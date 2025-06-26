import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIPokemon {
    /// Represents a complete evolution chain with all Pokemon forms, their stats, and encounters for a specific game.
    /// 
    /// This is designed for displaying Pokemon lists where you want to show evolution families
    /// sorted by the most powerful Pokemon in each chain for a specific game/version.
    ///
    /// ```swift
    /// let chains = try PokeAPIPokemon.WithEvolutionChain.fetchAllForVersion(database, versionId: 1)
    /// let sortedByPower = chains.sorted { $0.maxTotalStats > $1.maxTotalStats }
    /// ```
    public struct WithEvolutionChain {
        public let chainId: PokeAPIEvolutionChain.ID
        public let pokemonInChain: [PokemonWithData]
        
        public init(
            chainId: PokeAPIEvolutionChain.ID,
            pokemonInChain: [PokemonWithData]
        ) {
            self.chainId = chainId
            self.pokemonInChain = pokemonInChain
        }
        
        /// Contains a Pokemon with all its relevant data for the evolution chain display
        public struct PokemonWithData {
            public let pokemon: PokeAPIPokemon
            public let species: PokeAPIPokemonSpecies
            public let stats: [StatData]
            public let encounters: [EncounterData]
            
            public init(
                pokemon: PokeAPIPokemon,
                species: PokeAPIPokemonSpecies,
                stats: [StatData],
                encounters: [EncounterData]
            ) {
                self.pokemon = pokemon
                self.species = species
                self.stats = stats
                self.encounters = encounters
            }
            
            /// Total base stats for this Pokemon
            public var totalStats: Int {
                return stats.reduce(0) { $0 + $1.baseStat }
            }
        }
        
        /// Contains stat data similar to WithStats.StatData
        public struct StatData {
            public let stat: PokeAPIStat
            public let baseStat: Int
            public let effort: Int
            
            public init(stat: PokeAPIStat, baseStat: Int, effort: Int) {
                self.stat = stat
                self.baseStat = baseStat
                self.effort = effort
            }
        }
        
        /// Contains encounter data similar to WithEncounters.EncounterData
        public struct EncounterData {
            public let encounter: PokeAPIEncounter
            public let locationArea: PokeAPILocationArea
            public let method: PokeAPIEncounterMethod
            public let slot: Int
            public let rarity: Int
            public let minLevel: Int
            public let maxLevel: Int
            
            public init(
                encounter: PokeAPIEncounter,
                locationArea: PokeAPILocationArea,
                method: PokeAPIEncounterMethod,
                slot: Int,
                rarity: Int,
                minLevel: Int,
                maxLevel: Int
            ) {
                self.encounter = encounter
                self.locationArea = locationArea
                self.method = method
                self.slot = slot
                self.rarity = rarity
                self.minLevel = minLevel
                self.maxLevel = maxLevel
            }
        }
        
        /// Maximum total stats across all Pokemon in this evolution chain
        public var maxTotalStats: Int {
            return pokemonInChain.map(\.totalStats).max() ?? 0
        }
        
        /// The Pokemon with the highest total stats in this chain
        public var strongestPokemon: PokemonWithData? {
            return pokemonInChain.max { $0.totalStats < $1.totalStats }
        }
        
        /// All Pokemon in this chain that can be encountered in the wild for the queried version
        public var catchablePokemon: [PokemonWithData] {
            return pokemonInChain.filter { !$0.encounters.isEmpty }
        }
        
        // MARK: -
        
        /// Fetches all evolution chains with Pokemon data for a specific version/game.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - versionId: The game version to get encounters for
        ///   - limit: Maximum number of chains to fetch (default: nil for all)
        /// - Returns: Array of evolution chains sorted by max total stats (strongest first)
        public static func fetchAllForVersion(
            _ database: StructuredQueriesSQLite.Database,
            versionId: PokeAPIVersion.ID,
            limit: Int? = nil
        ) throws -> [PokeAPIPokemon.WithEvolutionChain] {
            // Get all evolution chain IDs
            let chainIds: [PokeAPIEvolutionChain.ID] = try database.execute(
                PokeAPIEvolutionChain.all
                    .select(\.id)
                    .order(by: \.id)
            )
            
            let limitedChainIds = limit.map { Array(chainIds.prefix($0)) } ?? chainIds
            
            // Build chains for each evolution chain ID
            let chains = try limitedChainIds.compactMap { chainId in
                try fetchChainForVersion(database, chainId: chainId, versionId: versionId)
            }
            
            // Sort by strongest Pokemon in each chain
            return chains.sorted { $0.maxTotalStats > $1.maxTotalStats }
        }
        
        /// Fetches the complete evolution chain for any Pokemon in a specific version.
        /// 
        /// Given any Pokemon ID, this finds its evolution chain and returns all
        /// Pokemon in that chain with their stats and encounters for the specified version.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - pokemonId: Any Pokemon ID in the chain you want to fetch
        ///   - versionId: The game version to get encounters for
        /// - Returns: The complete evolution chain containing the specified Pokemon
        /// - Throws: `WithEvolutionChainError.pokemonNotFound` if the Pokemon doesn't exist
        public static func fetchChainForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID,
            versionId: PokeAPIVersion.ID
        ) throws -> PokeAPIPokemon.WithEvolutionChain {
            // Get the Pokemon and its species to find the evolution chain
            let evolutionChainIds: [PokeAPIEvolutionChain.ID] = try database.execute(
                PokeAPIPokemon.all
                    .where { $0.id == pokemonId }
                    .join(PokeAPIPokemonSpecies.all) { $0.speciesId == $1.id }
                    .select { $1.evolutionChainId }
            )

            guard let evolutionChainId = evolutionChainIds.first else {
                throw WithEvolutionChainError.pokemonNotFound(pokemonId)
            }
            
            // Now get the full evolution chain
            guard let chain = try fetchChainForVersion(database, chainId: evolutionChainId, versionId: versionId) else {
                throw WithEvolutionChainError.pokemonNotFound(pokemonId)
            }
            
            return chain
        }
        
        // MARK: - Private Helpers

        /// Fetches a specific evolution chain with Pokemon data for a specific version.
        ///
        /// - Parameters:
        ///   - database: The database to query
        ///   - chainId: The evolution chain ID to fetch
        ///   - versionId: The game version to get encounters for
        /// - Returns: The evolution chain, or nil if no Pokemon exist in the specified version
        private static func fetchChainForVersion(
            _ database: StructuredQueriesSQLite.Database,
            chainId: PokeAPIEvolutionChain.ID,
            versionId: PokeAPIVersion.ID
        ) throws -> PokeAPIPokemon.WithEvolutionChain? {
            // Get all species in this evolution chain
            let speciesInChain: [PokeAPIPokemonSpecies] = try database.execute(
                PokeAPIPokemonSpecies.all
                    .where { $0.evolutionChainId == chainId }
                    .order(by: \.id)
            )
            
            guard !speciesInChain.isEmpty else { return nil }
            
            // Get all Pokemon forms for these species (we want the base form, typically the first one)
            var pokemonWithData: [PokemonWithData] = []
            
            for species in speciesInChain {
                // Get all Pokemon forms for this species
                let allPokemonForms: [PokeAPIPokemon] = try database.execute(
                    PokeAPIPokemon.all
                        .where { $0.speciesId == species.id }
                        .order(by: \.id)
                )
                
                // Filter forms based on availability in the target version
                let availableForms = try PokeAPIPokemonFormFiltering.filterFormsForVersion(
                    database, 
                    pokemon: allPokemonForms, 
                    versionId: versionId
                )
                
                // Prefer the default form, but fall back to the first available form
                let pokemon = availableForms.first(where: \.isDefault) ?? availableForms.first
                
                guard let pokemon = pokemon else {
                    continue
                }

                // Get stats for this Pokemon
                let stats = try fetchStatsForPokemon(database, pokemonId: pokemon.id)
                
                // Get encounters for this Pokemon in the specified version
                let encounters = try fetchEncountersForPokemon(database, pokemonId: pokemon.id, versionId: versionId)
                
                let pokemonData = PokemonWithData(
                    pokemon: pokemon,
                    species: species,
                    stats: stats,
                    encounters: encounters
                )
                
                pokemonWithData.append(pokemonData)
            }
            
            guard !pokemonWithData.isEmpty else { return nil }
            
            return WithEvolutionChain(
                chainId: chainId,
                pokemonInChain: pokemonWithData
            )
        }

        /// Fetches all stat data for a specific Pokemon.
        private static func fetchStatsForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID
        ) throws -> [StatData] {
            let pokemonStats: [(PokeAPIPokemonStat, PokeAPIStat)] = try database.execute(
                PokeAPIPokemonStat.all
                    .where { $0.pokemonId == pokemonId }
                    .join(PokeAPIStat.all) { $0.statId == $1.id }
                    .order { $1.id }
            )
            return pokemonStats.map { (pokemonStat, stat) in
                StatData(
                    stat: stat,
                    baseStat: pokemonStat.baseStat,
                    effort: pokemonStat.effort
                )
            }
        }
        
        /// Fetches all encounter data for a specific Pokemon in a specific version.
        private static func fetchEncountersForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID,
            versionId: PokeAPIVersion.ID
        ) throws -> [EncounterData] {
            let encounters: [(PokeAPIEncounter, PokeAPILocationArea, PokeAPIEncounterSlot, PokeAPIEncounterMethod)] = try database.execute(
                PokeAPIEncounter.all
                    .where {
                        $0.pokemonId == pokemonId && $0.versionId == versionId
                    }
                    .join(PokeAPILocationArea.all, on: joinOn(encounter:location:))
                    .join(PokeAPIEncounterSlot.all, on: joinOn(encounter:location:encounterSlot:))
                    .join(PokeAPIEncounterMethod.all, on: joinOn(encounter:location:encounterSlot:encounterMethod:))
            )
            
            return encounters.map { (encounter, locationArea, encounterSlot, encounterMethod) in
                EncounterData(
                    encounter: encounter,
                    locationArea: locationArea,
                    method: encounterMethod,
                    slot: encounterSlot.slot ?? 1,
                    rarity: encounterSlot.rarity,
                    minLevel: encounter.minLevel,
                    maxLevel: encounter.maxLevel
                )
            }.sorted { lhs, rhs in
                if lhs.method.order != rhs.method.order {
                    return lhs.method.order < rhs.method.order
                }
                if lhs.rarity != rhs.rarity {
                    return lhs.rarity > rhs.rarity
                }
                return lhs.locationArea.id.rawValue < rhs.locationArea.id.rawValue
            }
        }
        
        private static func joinOn(
            encounter: PokeAPIEncounter.TableColumns,
            location: PokeAPILocationArea.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounter.locationAreaId.eq(location.id)
        }

        private static func joinOn(
            encounter: PokeAPIEncounter.TableColumns,
            location: PokeAPILocationArea.TableColumns,
            encounterSlot: PokeAPIEncounterSlot.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounter.encounterSlotId.eq(encounterSlot.id)
        }

        private static func joinOn(
            encounter: PokeAPIEncounter.TableColumns,
            location: PokeAPILocationArea.TableColumns,
            encounterSlot: PokeAPIEncounterSlot.TableColumns,
            encounterMethod: PokeAPIEncounterMethod.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounterSlot.encounterMethodId.eq(encounterMethod.id)
        }
        
        // MARK: -
        
        private enum WithEvolutionChainError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}
