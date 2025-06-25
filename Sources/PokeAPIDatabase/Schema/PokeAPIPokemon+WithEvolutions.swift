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
            // Get Pokemon that have evolution data
            let pokemonWithEvolutions: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all.limit(limit ?? 10_000)
            )
            
            var results: [WithEvolutions] = []
            for pokemon in pokemonWithEvolutions {
                let evolutions = try fetchEvolutionsForPokemon(database, pokemonId: pokemon.id)
                results.append(WithEvolutions(pokemon: pokemon, evolutions: evolutions))
            }
            
            return results.sorted(by: { $0.pokemon.id < $1.pokemon.id })
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
            let evolutions = try fetchEvolutionsForPokemon(database, pokemonId: pokemonId)
            
            return WithEvolutions(pokemon: pokemon, evolutions: evolutions)
        }

        // MARK: - Private Helpers

        /// Fetches all evolution data for a specific Pokemon.
        private static func fetchEvolutionsForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID
        ) throws -> [PokeAPIPokemonEvolution] {
            // 1. Get the Pokemon to find its species ID
            let pokemon: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all.where { $0.id == pokemonId }
            )
            guard let pokemonResult = pokemon.first else {
                return []
            }
            
            // 2. Get the Pokemon's species to find its evolution chain
            let pokemonSpecies: [PokeAPIPokemonSpecies] = try database.execute(
                PokeAPIPokemonSpecies.all.where { $0.id == pokemonResult.speciesId }
            )
            guard let species = pokemonSpecies.first else {
                // No species found, return empty evolutions
                return []
            }
            
            // 3. Get all evolutions that evolve FROM this species
            let evolutions: [PokeAPIPokemonEvolution] = try database.execute(
                PokeAPIPokemonEvolution.all.where { evolution in
                    evolution.evolvedSpeciesId == species.id
                }
            )
            
            return evolutions.sorted(by: { $0.id < $1.id })
        }

        // MARK: -

        private enum WithEvolutionsError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}