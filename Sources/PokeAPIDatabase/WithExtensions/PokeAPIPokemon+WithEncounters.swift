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
            // TODO: Missing encounter_condition.csv

            public init(
                encounter: PokeAPIEncounter,
                locationArea: PokeAPILocationArea,
                method: PokeAPIEncounterMethod,
                slot: Int,
                rarity: Int,
            ) {
                self.encounter = encounter
                self.locationArea = locationArea
                self.method = method
                self.slot = slot
                self.rarity = rarity
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
            let pokemonIds: [PokeAPIPokemon.ID] = try database.execute(
                PokeAPIEncounter.all
                    .where { $0.versionId == versionId }
                    .select(\.pokemonId)
                    .distinct()
                    .limit(limit ?? 10_000)
                    .order(by: \.pokemonId)
            )
            // Get its encounters
            return try pokemonIds
                .map { try fetchOne(database, pokemonId: $0, versionId: versionId) }
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
            let encounters: [(PokeAPIEncounter, PokeAPILocationArea, PokeAPIEncounterSlot, PokeAPIEncounterMethod)] = try database.execute(
                PokeAPIEncounter.all
                    .where {
                        return $0.pokemonId == pokemonId
                            && $0.versionId == versionId
                    }
                    .join(PokeAPILocationArea.all, on: joinOn(encounter:location:))
                    .join(PokeAPIEncounterSlot.all, on: joinOn(encounter:location:encounterSlot:))
                    .join(PokeAPIEncounterMethod.all, on: joinOn(encounter:location:encounterSlot:encounterMethod:))
            )
            
            return encounters
                .map { (encounter, locationArea, encounterSlot, encounterMethod) in
                    EncounterData(
                        encounter: encounter,
                        locationArea: locationArea,
                        method: encounterMethod,
                        slot: encounterSlot.slot ?? 1, // Default to slot 1 if null
                        rarity: encounterSlot.rarity,
                    )
                }
                // Sort encounters by method order, then rarity (high to low), then location area ID
                .sorted { lhs, rhs in
                    if lhs.method.order != rhs.method.order {
                        return lhs.method.order < rhs.method.order
                    }
                    if lhs.rarity != rhs.rarity {
                        return lhs.rarity > rhs.rarity // Higher value (more common) first
                    }
                    return lhs.locationArea.id.rawValue < rhs.locationArea.id.rawValue
                }
        }

        private static func joinOn(
            encounter: PokeAPIEncounter.TableColumns,
            location: PokeAPILocationArea.TableColumns,
        ) -> some QueryExpression<Bool> {
            return encounter.locationAreaId.eq(location.id)
        }

        private static func joinOn(
            encounter: PokeAPIEncounter.TableColumns,
            location: PokeAPILocationArea.TableColumns,
            encounterSlot: PokeAPIEncounterSlot.TableColumns,
        ) -> some QueryExpression<Bool> {
            return encounter.encounterSlotId.eq(encounterSlot.id)
        }

        private static func joinOn(
            encounter: PokeAPIEncounter.TableColumns,
            location: PokeAPILocationArea.TableColumns,
            encounterSlot: PokeAPIEncounterSlot.TableColumns,
            encounterMethod: PokeAPIEncounterMethod.TableColumns,
        ) -> some QueryExpression<Bool> {
            return encounterSlot.encounterMethodId.eq(encounterMethod.id)
        }

        // MARK: -

        private enum WithEncountersError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}
