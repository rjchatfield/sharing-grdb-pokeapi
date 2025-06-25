import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIPokemon {
    /// Represents a Pokemon with its encounter locations and conditions.
    /// 
    /// Shows where this Pokemon can be found in the wild, including level ranges
    /// and encounter rates. Data is version-specific since encounter tables vary between games.
    ///
    /// ```swift
    /// let pikachu = try PokeAPIPokemon.WithEncounters.fetchOne(database, pokemonId: 25, versionId: 1)
    /// let viridianForest = pikachu.encounters.first(where: { $0.locationArea.identifier.contains("forest") })
    /// ```
    public struct WithEncounters {
        public let pokemon: PokeAPIPokemon
        public let encounters: [EncounterData]

        public init(
            pokemon: PokeAPIPokemon,
            encounters: [EncounterData]
        ) {
            self.pokemon = pokemon
            self.encounters = encounters
        }

        /// Contains encounter information for a specific location.
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

        // MARK: -

        /// Fetches multiple Pokemon with their encounter data for a specific version.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - versionId: The game version to get encounters for
        ///   - limit: Maximum number of Pokemon to fetch (default: 10, use nil for all)
        /// - Returns: Array of Pokemon with their encounters, ordered by Pokemon ID
        public static func fetchAll(
            _ database: StructuredQueriesSQLite.Database,
            versionId: PokeAPIVersion.ID,
            limit: Int? = 10
        ) throws -> [PokeAPIPokemon.WithEncounters] {
            // Get distinct Pokemon IDs that have encounters in this version
            let encountersInVersion: [PokeAPIEncounter] = try database.execute(
                PokeAPIEncounter.all.where { $0.versionId == versionId }
            )
            
            let pokemonIds = Set(encountersInVersion.map { $0.pokemonId })
            let limitedPokemonIds = Array(pokemonIds.sorted()).prefix(limit ?? 10_000)
            
            var results: [WithEncounters] = []
            for pokemonId in limitedPokemonIds {
                // Get the Pokemon
                let pokemon: PokeAPIPokemon = try database.execute(
                    PokeAPIPokemon.all.where { $0.id == pokemonId }
                ).first!
                
                // Get its encounters
                let encounters = try fetchEncountersForPokemon(database, pokemonId: pokemonId, versionId: versionId)
                results.append(WithEncounters(pokemon: pokemon, encounters: encounters))
            }
            
            return results.sorted(by: { $0.pokemon.id < $1.pokemon.id })
        }

        /// Fetches a single Pokemon with its encounter data for a specific version.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - pokemonId: The ID of the Pokemon to fetch
        ///   - versionId: The game version to get encounters for
        /// - Returns: The Pokemon with its encounters (empty array if not found in wild)
        public static func fetchOne(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID,
            versionId: PokeAPIVersion.ID
        ) throws -> PokeAPIPokemon.WithEncounters {
            // Get the Pokemon
            let pokemonResults: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all.where { $0.id == pokemonId }
            )
            guard let pokemon = pokemonResults.first else {
                throw WithEncountersError.pokemonNotFound(pokemonId)
            }
            
            // Get its encounters
            let encounters = try fetchEncountersForPokemon(database, pokemonId: pokemonId, versionId: versionId)
            
            return WithEncounters(pokemon: pokemon, encounters: encounters)
        }

        // MARK: - Private Helpers

        /// Fetches all encounter data for a specific Pokemon in a specific version.
        private static func fetchEncountersForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID,
            versionId: PokeAPIVersion.ID
        ) throws -> [EncounterData] {
            // 1. Get base encounters for this Pokemon in this version
            let encounters: [PokeAPIEncounter] = try database.execute(
                PokeAPIEncounter.all.where { 
                    $0.pokemonId == pokemonId && $0.versionId == versionId 
                }
            )
            
            var encounterDataArray: [EncounterData] = []
            
            for encounter in encounters {
                // 2. Get the location area for this encounter
                let locationArea: PokeAPILocationArea = try database.execute(
                    PokeAPILocationArea.all.where { $0.id == encounter.locationAreaId }
                ).first!
                
                // 3. Get the encounter slot details
                let encounterSlot: PokeAPIEncounterSlot = try database.execute(
                    PokeAPIEncounterSlot.all.where { $0.id == encounter.encounterSlotId }
                ).first!
                
                // 4. Get the encounter method
                let encounterMethod: PokeAPIEncounterMethod = try database.execute(
                    PokeAPIEncounterMethod.all.where { $0.id == encounterSlot.encounterMethodId }
                ).first!
                
                // 5. Create the encounter data
                let encounterData = EncounterData(
                    encounter: encounter,
                    locationArea: locationArea,
                    method: encounterMethod,
                    slot: encounterSlot.slot ?? 1, // Default to slot 1 if null
                    rarity: encounterSlot.rarity,
                    minLevel: encounter.minLevel,
                    maxLevel: encounter.maxLevel
                )
                
                encounterDataArray.append(encounterData)
            }
            
            // Sort encounters by method order, then rarity (high to low), then location area ID
            return encounterDataArray.sorted { lhs, rhs in
                if lhs.method.order != rhs.method.order {
                    return lhs.method.order < rhs.method.order
                }
                if lhs.rarity != rhs.rarity {
                    return lhs.rarity > rhs.rarity // Higher rarity (more common) first
                }
                return lhs.locationArea.id.rawValue < rhs.locationArea.id.rawValue
            }
        }

        // MARK: -

        private enum WithEncountersError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}