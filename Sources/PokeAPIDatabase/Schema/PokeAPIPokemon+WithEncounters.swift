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
            let query = With {
                PokeAPIPokemon
                    .select(PokeAPIPokemon.TableSelection.Columns.init(pokemon:))
                    .limit(limit ?? 10_000) // higher than total number of pokemon
            } query: {
                PokeAPIPokemon.TableSelection
                    .join(PokeAPIEncounter.all.where { $0.versionId == versionId }, on: joinOn(pokemon:encounter:))
                    .join(PokeAPILocationArea.all, on: joinOn(pokemon:encounter:locationArea:))
            }
            let fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIEncounter, PokeAPILocationArea)] = try database.execute(query)
            return try process(fetchResults: fetchResults, database: database)
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
            let query = With {
                PokeAPIPokemon
                    .select(PokeAPIPokemon.TableSelection.Columns.init(pokemon:))
                    .where { $0.id == pokemonId }
            } query: {
                PokeAPIPokemon.TableSelection
                    .join(PokeAPIEncounter.all.where { $0.versionId == versionId }, on: joinOn(pokemon:encounter:))
                    .join(PokeAPILocationArea.all, on: joinOn(pokemon:encounter:locationArea:))
            }
            let fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIEncounter, PokeAPILocationArea)] = try database.execute(query)

            // If no encounter data found, try to get just the Pokemon
            if fetchResults.isEmpty {
                let pokemonQuery = PokeAPIPokemon.where { $0.id == pokemonId }
                let pokemonResults: [PokeAPIPokemon] = try database.execute(pokemonQuery)
                guard let pokemon = pokemonResults.first else {
                    throw WithEncountersError.pokemonNotFound(pokemonId)
                }
                return WithEncounters(pokemon: pokemon, encounters: [])
            }
            
            return try process(fetchResults: fetchResults, database: database).first!
        }

        // MARK: -

        private static func process(
            fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIEncounter, PokeAPILocationArea)],
            database: StructuredQueriesSQLite.Database
        ) throws -> [WithEncounters] {
            // Get all unique encounter slot IDs from the results
            let encounterSlotIds = Set(fetchResults.map { $0.1.encounterSlotId })
            
            // For now, use placeholder values to test the structure
            // TODO: Implement proper lookup of encounter slots and methods
            let encounterSlotMap: [PokeAPIEncounterSlot.ID: PokeAPIEncounterSlot] = [:]
            let encounterMethodMap: [PokeAPIEncounterMethod.ID: PokeAPIEncounterMethod] = [:]
            
            return fetchResults
                .reduce(into: [PokeAPIPokemon.ID: WithEncounters]()) { acc, next in
                    let (tableSelection, encounter, locationArea) = next
                    let pokemon = tableSelection.pokemon
                    let existing = acc[pokemon.id]?.encounters ?? []
                    
                    // Use placeholder values for now
                    let encounterSlot = PokeAPIEncounterSlot(
                        id: encounter.encounterSlotId,
                        versionGroupId: .init(rawValue: 1),
                        encounterMethodId: .init(rawValue: 1),
                        slot: 1,
                        rarity: 20
                    )
                    let encounterMethod = PokeAPIEncounterMethod(
                        id: .init(rawValue: 1),
                        identifier: "walk",
                        order: 1
                    )
                    
                    let encounterData = EncounterData(
                        encounter: encounter,
                        locationArea: locationArea,
                        method: encounterMethod,
                        slot: encounterSlot.slot,
                        rarity: encounterSlot.rarity,
                        minLevel: encounter.minLevel,
                        maxLevel: encounter.maxLevel
                    )
                    let newEncounters = existing + [encounterData]
                    acc[pokemon.id] = WithEncounters(
                        pokemon: pokemon,
                        encounters: newEncounters.sorted { lhs, rhs in
                            // Sort by encounter method order, then rarity (high to low), then location area ID for consistent ordering
                            if lhs.method.order != rhs.method.order {
                                return lhs.method.order < rhs.method.order
                            }
                            if lhs.rarity != rhs.rarity {
                                return lhs.rarity > rhs.rarity // Higher rarity (more common) first
                            }
                            return lhs.locationArea.id.rawValue < rhs.locationArea.id.rawValue
                        }
                    )
                }
                .sorted(by: { $0.key < $1.key })
                .map(\.value)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            encounter: PokeAPIEncounter.TableColumns
        ) -> some QueryExpression<Bool> {
            return pokemon.id.eq(encounter.pokemonId)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            encounter: PokeAPIEncounter.TableColumns,
            locationArea: PokeAPILocationArea.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounter.locationAreaId.eq(locationArea.id)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            encounter: PokeAPIEncounter.TableColumns,
            locationArea: PokeAPILocationArea.TableColumns,
            encounterSlot: PokeAPIEncounterSlot.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounter.encounterSlotId.eq(encounterSlot.id)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            encounter: PokeAPIEncounter.TableColumns,
            locationArea: PokeAPILocationArea.TableColumns,
            encounterSlot: PokeAPIEncounterSlot.TableColumns,
            encounterMethod: PokeAPIEncounterMethod.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounterSlot.encounterMethodId.eq(encounterMethod.id)
        }

        // MARK: -

        private enum WithEncountersError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}
