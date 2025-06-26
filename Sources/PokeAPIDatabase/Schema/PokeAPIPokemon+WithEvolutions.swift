import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIPokemon {
    /// Represents a Pokemon with its evolution information.
    /// 
    /// Shows the evolution conditions required for this Pokemon to evolve.
    /// Note: This shows evolutions FROM this Pokemon, not evolutions TO this Pokemon.
    ///
    /// ```swift
    /// let charmander = try PokeAPIPokemon.WithEvolutions.fetchOne(database, pokemonId: 4)
    /// let levelToEvolve = charmander.evolutions.first?.minimumLevel
    /// ```
    public struct WithEvolutions {
        public let pokemon: PokeAPIPokemon
        public let evolutions: [PokeAPIPokemonEvolution]

        public init(
            pokemon: PokeAPIPokemon,
            evolutions: [PokeAPIPokemonEvolution]
        ) {
            self.pokemon = pokemon
            self.evolutions = evolutions
        }

        // MARK: -

        /// Fetches multiple Pokemon with their evolution data.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - limit: Maximum number of Pokemon to fetch (default: 10, use nil for all)
        /// - Returns: Array of Pokemon with their evolutions, ordered by Pokemon ID
        public static func fetchAll(
            _ database: StructuredQueriesSQLite.Database,
            limit: Int? = 10
        ) throws -> [PokeAPIPokemon.WithEvolutions] {
            // Get all Pokemon
            let allPokemon: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all
                    .limit(limit ?? 10_000)
                    .order(by: \.id)
            )
            // Get its evolutions
            return try allPokemon
                .map { pokemon in
                    let evolutions = try fetchEvolutionsForPokemon(database, pokemon: pokemon)
                    return WithEvolutions(pokemon: pokemon, evolutions: evolutions)
                }
        }

        /// Fetches a single Pokemon with its evolution data.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - pokemonId: The ID of the Pokemon to fetch
        /// - Returns: The Pokemon with its evolutions (empty array if it doesn't evolve)
        public static func fetchOne(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID
        ) throws -> PokeAPIPokemon.WithEvolutions {
            // Get the Pokemon
            let pokemonResults: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all.where { $0.id == pokemonId }
            )
            guard let pokemon = pokemonResults.first else {
                throw WithEvolutionsError.pokemonNotFound(pokemonId)
            }
            
            // Get its evolutions
            let evolutions = try fetchEvolutionsForPokemon(database, pokemon: pokemon)
            
            return WithEvolutions(pokemon: pokemon, evolutions: evolutions)
        }

        // MARK: - Private Helpers

        /// Fetches all evolution data for a specific Pokemon.
        private static func fetchEvolutionsForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemon: PokeAPIPokemon
        ) throws -> [PokeAPIPokemonEvolution] {
            return try database.execute(
                PokeAPIPokemonSpecies.all
                    .where { $0.id == pokemon.speciesId }
                    .order(by: \.id)
                    .join(PokeAPIPokemonEvolution.all) { $0.id == $1.evolvedSpeciesId }
                    .select { $1 }
            )
        }

        // MARK: -

        private enum WithEvolutionsError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}
