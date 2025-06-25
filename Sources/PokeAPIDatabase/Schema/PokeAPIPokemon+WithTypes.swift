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
            types: [PokeAPIType]
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
            limit: Int? = 10
        ) throws -> [PokeAPIPokemon.WithTypes] {
            // Get all Pokemon
            let allPokemon: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all.limit(limit ?? 10_000)
            )
            
            var results: [WithTypes] = []
            for pokemon in allPokemon {
                let types = try fetchTypesForPokemon(database, pokemonId: pokemon.id)
                results.append(WithTypes(pokemon: pokemon, types: types))
            }
            
            return results.sorted(by: { $0.pokemon.id < $1.pokemon.id })
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
            pokemonId: PokeAPIPokemon.ID
        ) throws -> PokeAPIPokemon.WithTypes {
            // Get the Pokemon
            let pokemonResults: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all.where { $0.id == pokemonId }
            )
            guard let pokemon = pokemonResults.first else {
                throw WithTypesError.pokemonNotFound(pokemonId)
            }
            
            // Get its types
            let types = try fetchTypesForPokemon(database, pokemonId: pokemonId)
            
            return WithTypes(pokemon: pokemon, types: types)
        }

        // MARK: - Private Helpers

        /// Fetches all type data for a specific Pokemon.
        private static func fetchTypesForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID
        ) throws -> [PokeAPIType] {
            // 1. Get Pokemon-type relationships for this Pokemon
            let pokemonTypes: [PokeAPIPokemonType] = try database.execute(
                PokeAPIPokemonType.all.where { $0.pokemonId == pokemonId }
            )
            
            var typeArray: [PokeAPIType] = []
            
            for pokemonType in pokemonTypes {
                // 2. Get the actual type data
                let type: PokeAPIType = try database.execute(
                    PokeAPIType.all.where { $0.id == pokemonType.typeId }
                ).first!
                
                typeArray.append(type)
            }
            
            // Sort types by slot (primary type first, secondary type second)
            return typeArray.sorted { lhs, rhs in
                // Find the slots for these types
                let lhsSlot = pokemonTypes.first { $0.typeId == lhs.id }?.slot ?? 1
                let rhsSlot = pokemonTypes.first { $0.typeId == rhs.id }?.slot ?? 1
                return lhsSlot < rhsSlot
            }
        }

        // MARK: -

        private enum WithTypesError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}