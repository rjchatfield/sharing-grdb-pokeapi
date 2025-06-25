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
            // Get Pokemon that have moves in this version group
            let pokemonMoves: [PokeAPIPokemonMove] = try database.execute(
                PokeAPIPokemonMove.all.where { $0.versionGroupId == versionGroupId }
            )
            
            let pokemonIds = Set(pokemonMoves.map { $0.pokemonId })
            let limitedPokemonIds = Array(pokemonIds.sorted()).prefix(limit ?? 10_000)
            
            var results: [WithMoves] = []
            for pokemonId in limitedPokemonIds {
                // Get the Pokemon
                let pokemon: PokeAPIPokemon = try database.execute(
                    PokeAPIPokemon.all.where { $0.id == pokemonId }
                ).first!
                
                // Get its moves for this version group
                let moves = try fetchMovesForPokemon(database, pokemonId: pokemonId, versionGroupId: versionGroupId)
                results.append(WithMoves(pokemon: pokemon, moves: moves))
            }
            
            return results.sorted(by: { $0.pokemon.id < $1.pokemon.id })
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
            // Get the Pokemon
            let pokemonResults: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all.where { $0.id == pokemonId }
            )
            guard let pokemon = pokemonResults.first else {
                throw WithMovesError.pokemonNotFound(pokemonId)
            }
            
            // Get its moves for this version group
            let moves = try fetchMovesForPokemon(database, pokemonId: pokemonId, versionGroupId: versionGroupId)
            
            return WithMoves(pokemon: pokemon, moves: moves)
        }

        // MARK: - Private Helpers

        /// Fetches all move data for a specific Pokemon in a specific version group.
        private static func fetchMovesForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID,
            versionGroupId: PokeAPIVersionGroup.ID
        ) throws -> [MoveData] {
            // 1. Get Pokemon-move relationships for this Pokemon and version group
            let pokemonMoves: [PokeAPIPokemonMove] = try database.execute(
                PokeAPIPokemonMove.all.where { 
                    $0.pokemonId == pokemonId && $0.versionGroupId == versionGroupId 
                }
            )
            
            var moveDataArray: [MoveData] = []
            
            for pokemonMove in pokemonMoves {
                // 2. Get the actual move data
                let move: PokeAPIMove = try database.execute(
                    PokeAPIMove.all.where { $0.id == pokemonMove.moveId }
                ).first!
                
                // 3. Create the move data
                let moveData = MoveData(
                    move: move,
                    level: pokemonMove.level,
                    methodId: pokemonMove.pokemonMoveMethodId,
                    order: pokemonMove.order,
                    mastery: pokemonMove.mastery
                )
                
                moveDataArray.append(moveData)
            }
            
            // Sort moves by level, then order (if available), then move ID for consistent ordering
            return moveDataArray.sorted { lhs, rhs in
                if lhs.level != rhs.level {
                    return lhs.level < rhs.level
                }
                if let lhsOrder = lhs.order, let rhsOrder = rhs.order {
                    return lhsOrder < rhsOrder
                }
                return lhs.move.id < rhs.move.id
            }
        }

        // MARK: -

        private enum WithMovesError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}