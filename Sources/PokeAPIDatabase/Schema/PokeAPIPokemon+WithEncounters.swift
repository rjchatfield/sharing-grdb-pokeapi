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
            public let minLevel: Int
            public let maxLevel: Int

            public init(
                encounter: PokeAPIEncounter,
                locationArea: PokeAPILocationArea,
                minLevel: Int,
                maxLevel: Int
            ) {
                self.encounter = encounter
                self.locationArea = locationArea
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
            let query = PokeAPIPokemon
                .limit(limit ?? 10_000)
                .join(PokeAPIEncounter.all.where { $0.versionId == versionId }, on: joinOn(pokemon:encounter:))
                .join(PokeAPILocationArea.all, on: joinOn(pokemon:encounter:locationArea:))
                .select(makeColumns(pokemon:encounter:locationArea:))
            let fetchResults: [(PokeAPIPokemon, PokeAPIEncounter, PokeAPILocationArea)] = try database.execute(query)
            return process(fetchResults: fetchResults)
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
            let query = PokeAPIPokemon
                .where { $0.id == pokemonId }
                .join(PokeAPIEncounter.all.where { $0.versionId == versionId }, on: joinOn(pokemon:encounter:))
                .join(PokeAPILocationArea.all, on: joinOn(pokemon:encounter:locationArea:))
                .select(makeColumns(pokemon:encounter:locationArea:))
            let fetchResults: [(PokeAPIPokemon, PokeAPIEncounter, PokeAPILocationArea)] = try database.execute(query)
            
            // If no encounter data found, try to get just the Pokemon
            if fetchResults.isEmpty {
                let pokemonQuery = PokeAPIPokemon.where { $0.id == pokemonId }
                let pokemonResults: [PokeAPIPokemon] = try database.execute(pokemonQuery)
                guard let pokemon = pokemonResults.first else {
                    throw WithEncountersError.pokemonNotFound(pokemonId)
                }
                return WithEncounters(pokemon: pokemon, encounters: [])
            }
            
            return process(fetchResults: fetchResults).first!
        }

        // MARK: -

        private static func process(
            fetchResults: [(PokeAPIPokemon, PokeAPIEncounter, PokeAPILocationArea)]
        ) -> [WithEncounters] {
            fetchResults
                .reduce(into: [PokeAPIPokemon.ID: WithEncounters]()) { acc, next in
                    let (pokemon, encounter, locationArea) = next
                    let existing = acc[pokemon.id]?.encounters ?? []
                    let encounterData = EncounterData(
                        encounter: encounter,
                        locationArea: locationArea,
                        minLevel: encounter.minLevel,
                        maxLevel: encounter.maxLevel
                    )
                    let newEncounters = existing + [encounterData]
                    acc[pokemon.id] = WithEncounters(
                        pokemon: pokemon,
                        encounters: newEncounters.sorted { lhs, rhs in
                            // Sort by location area ID for consistent ordering
                            lhs.locationArea.id.rawValue < rhs.locationArea.id.rawValue
                        }
                    )
                }
                .sorted(by: { $0.key < $1.key })
                .map(\.value)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableColumns,
            encounter: PokeAPIEncounter.TableColumns
        ) -> some QueryExpression<Bool> {
            return pokemon.id.eq(encounter.pokemonId)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableColumns,
            encounter: PokeAPIEncounter.TableColumns,
            locationArea: PokeAPILocationArea.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounter.locationAreaId.eq(locationArea.id)
        }

        private static func makeColumns(
            pokemon: PokeAPIPokemon.TableColumns,
            encounter: PokeAPIEncounter.TableColumns,
            locationArea: PokeAPILocationArea.TableColumns
        ) -> (
            PokeAPIPokemon.TableColumns,
            PokeAPIEncounter.TableColumns,
            PokeAPILocationArea.TableColumns
        ) {
            return (
                pokemon,
                encounter,
                locationArea
            )
        }

        // MARK: -

        private enum WithEncountersError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}