import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIPokemon {
    /// Represents a Pokemon with its associated moves for a specific version group.
    /// 
    /// Moves are version-specific, so a version group ID must be provided to fetch
    /// the correct moveset. Moves are ordered by learning progression (level, then order).
    ///
    /// ```swift
    /// let pikachu = try PokeAPIPokemon.WithMoves.fetchOne(
    ///     database, 
    ///     pokemonId: 25, 
    ///     versionGroupId: 1
    /// )
    /// print(pikachu.moves.first?.move.identifier) // First learnable move
    /// ```
    public struct WithMoves {
        public let pokemon: PokeAPIPokemon
        public let moves: [MoveData]

        public init(
            pokemon: PokeAPIPokemon,
            moves: [MoveData]
        ) {
            self.pokemon = pokemon
            self.moves = moves
        }

        /// Contains a move and its learning information for a specific Pokemon.
        public struct MoveData {
            public let move: PokeAPIMove
            public let level: Int
            public let methodId: Int
            public let order: Int?
            public let mastery: String?

            public init(
                move: PokeAPIMove,
                level: Int,
                methodId: Int,
                order: Int? = nil,
                mastery: String? = nil
            ) {
                self.move = move
                self.level = level
                self.methodId = methodId
                self.order = order
                self.mastery = mastery
            }
        }

        // MARK: -

        /// Fetches multiple Pokemon with their moves for a specific version group.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - versionGroupId: The version group to get moves for
        ///   - limit: Maximum number of Pokemon to fetch (default: 10, use nil for all)
        /// - Returns: Array of Pokemon with their moves, ordered by Pokemon ID
        public static func fetchAll(
            _ database: StructuredQueriesSQLite.Database,
            versionGroupId: PokeAPIVersionGroup.ID,
            limit: Int? = 10
        ) throws -> [PokeAPIPokemon.WithMoves] {
            let query = PokeAPIPokemon
                .limit(limit ?? 10_000)
                .join(PokeAPIPokemonMove.all.where { $0.versionGroupId == versionGroupId }, on: joinOn(pokemon:junction:))
                .join(PokeAPIMove.all, on: joinOn(pokemon:junction:move:))
                .select(makeColumns(pokemon:junction:move:))
            let fetchResults: [(PokeAPIPokemon, PokeAPIPokemonMove, PokeAPIMove)] = try database.execute(query)
            return process(fetchResults: fetchResults)
        }

        /// Fetches a single Pokemon with its moves for a specific version group.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - pokemonId: The ID of the Pokemon to fetch
        ///   - versionGroupId: The version group to get moves for
        /// - Returns: The Pokemon with its moves
        /// - Throws: `WithMovesError.pokemonNotFound` if no Pokemon exists with the given ID
        public static func fetchOne(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID,
            versionGroupId: PokeAPIVersionGroup.ID
        ) throws -> PokeAPIPokemon.WithMoves {
            let query = PokeAPIPokemon
                .where { $0.id == pokemonId }
                .join(PokeAPIPokemonMove.all.where { $0.versionGroupId == versionGroupId }, on: joinOn(pokemon:junction:))
                .join(PokeAPIMove.all, on: joinOn(pokemon:junction:move:))
                .select(makeColumns(pokemon:junction:move:))
            let fetchResults: [(PokeAPIPokemon, PokeAPIPokemonMove, PokeAPIMove)] = try database.execute(query)
            guard let result = process(fetchResults: fetchResults).first else {
                throw WithMovesError.pokemonNotFound(pokemonId)
            }
            return result
        }

        // MARK: -

        private static func process(
            fetchResults: [(PokeAPIPokemon, PokeAPIPokemonMove, PokeAPIMove)]
        ) -> [WithMoves] {
            fetchResults
                .reduce(into: [PokeAPIPokemon.ID: WithMoves]()) { acc, next in
                    let (pokemon, junction, move) = next
                    let existing = acc[pokemon.id]?.moves ?? []
                    let moveData = MoveData(
                        move: move,
                        level: junction.level,
                        methodId: junction.pokemonMoveMethodId,
                        order: junction.order,
                        mastery: junction.mastery
                    )
                    let newMoves = existing + [moveData]
                    acc[pokemon.id] = WithMoves(
                        pokemon: pokemon,
                        moves: newMoves.sorted { lhs, rhs in
                            // Sort by level first, then by order
                            if lhs.level != rhs.level {
                                return lhs.level < rhs.level
                            }
                            return (lhs.order ?? 0) < (rhs.order ?? 0)
                        }
                    )
                }
                .sorted(by: { $0.key < $1.key })
                .map(\.value)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableColumns,
            junction: PokeAPIPokemonMove.TableColumns
        ) -> some QueryExpression<Bool> {
            return pokemon.id.eq(junction.pokemonId)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableColumns,
            junction: PokeAPIPokemonMove.TableColumns,
            move: PokeAPIMove.TableColumns
        ) -> some QueryExpression<Bool> {
            return junction.moveId.eq(move.id)
        }

        private static func makeColumns(
            pokemon: PokeAPIPokemon.TableColumns,
            junction: PokeAPIPokemonMove.TableColumns,
            move: PokeAPIMove.TableColumns
        ) -> (
            PokeAPIPokemon.TableColumns,
            PokeAPIPokemonMove.TableColumns,
            PokeAPIMove.TableColumns
        ) {
            return (
                pokemon,
                junction,
                move
            )
        }

        // MARK: -

        private enum WithMovesError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}