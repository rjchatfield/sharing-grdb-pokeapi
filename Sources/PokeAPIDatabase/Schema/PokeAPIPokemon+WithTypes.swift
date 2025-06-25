import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIPokemon {
    /// Represents a Pokemon with its associated types, avoiding manual junction table handling.
    /// 
    /// Types are automatically ordered with primary type first (slot 1), secondary type second (slot 2).
    /// This provides a more convenient API than manually joining through `PokeAPIPokemonType`.
    ///
    /// ```swift
    /// let pikachu = try PokeAPIPokemon.WithTypes.fetchOne(database, pokemonId: 25)
    /// print(pikachu.types.first?.identifier) // "electric"
    /// ```
    public struct WithTypes {
        public let pokemon: PokeAPIPokemon
        public let types: [PokeAPIType]

        public init(
            pokemon: PokeAPIPokemon,
            types: [PokeAPIType],
        ) {
            self.pokemon = pokemon
            self.types = types
        }

        // MARK: -

        /// Fetches multiple Pokemon with their types in a single query.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - limit: Maximum number of Pokemon to fetch (default: 10, use nil for all)
        /// - Returns: Array of Pokemon with their types, ordered by Pokemon ID
        public static func fetchAll(
            _ database: StructuredQueriesSQLite.Database,
            limit: Int? = 10,
        ) throws -> [PokeAPIPokemon.WithTypes] {
            let query = With {
                PokeAPIPokemon
                    .select(PokeAPIPokemon.TableSelection.Columns.init(pokemon:))
                    .limit(limit ?? 10_000) // higher than total number of pokemon
            } query: {
                PokeAPIPokemon.TableSelection
                    .join(PokeAPIPokemonType.all, on: joinOn(pokemon:junction:))
                    .join(PokeAPIType.all, on: joinOn(pokemon:junction:type:))
            }
            let fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIPokemonType, PokeAPIType)] = try database.execute(query)
            return process(fetchResults: fetchResults)
        }

        /// Fetches a single Pokemon with its types.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - pokemonId: The ID of the Pokemon to fetch
        /// - Returns: The Pokemon with its types
        /// - Throws: `WithTypesError.pokemonNotFound` if no Pokemon exists with the given ID
        public static func fetchOne(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID,
        ) throws -> PokeAPIPokemon.WithTypes {
            let query = With {
                PokeAPIPokemon
                    .select(PokeAPIPokemon.TableSelection.Columns.init(pokemon:))
                    .where { $0.id == pokemonId }
            } query: {
                PokeAPIPokemon.TableSelection
                    .join(PokeAPIPokemonType.all, on: joinOn(pokemon:junction:))
                    .join(PokeAPIType.all, on: joinOn(pokemon:junction:type:))
            }
            let fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIPokemonType, PokeAPIType)] = try database.execute(query)
            guard let result = process(fetchResults: fetchResults).first else {
                throw WithTypesError.pokemonNotFound(pokemonId)
            }
            return result
        }

        // MARK: -

        private static func process(
            fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIPokemonType, PokeAPIType)],
        ) -> [WithTypes] {
            fetchResults
                .reduce(into: [PokeAPIPokemon.ID: WithTypes]()) { acc, next in
                    let (tableSelection, junction, type) = next
                    let pokemon = tableSelection.pokemon
                    let existing = acc[pokemon.id]?.types ?? []
                    let newTypes = switch junction.slot {
                    case 1: // first slow
                        [type] + existing
                    default: // nil assumes existing is empty, 2 means it is the second
                        existing + [type]
                    }
                    acc[pokemon.id] = WithTypes(
                        pokemon: pokemon,
                        types: newTypes
                    )
                }
                .sorted(by: { $0.key < $1.key })
                .map(\.value)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            junction: PokeAPIPokemonType.TableColumns,
        ) -> some QueryExpression<Bool> {
            return pokemon.id.eq(junction.pokemonId)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            junction: PokeAPIPokemonType.TableColumns,
            type: PokeAPIType.TableColumns
        ) -> some QueryExpression<Bool> {
            return junction.typeId.eq(type.id)
        }

        // MARK: -

        private enum WithTypesError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}
