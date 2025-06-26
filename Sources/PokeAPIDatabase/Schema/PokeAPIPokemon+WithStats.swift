import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIPokemon {
    /// Represents a Pokemon with its base stats (HP, Attack, Defense, etc.).
    /// 
    /// Each Pokemon has exactly 6 core stats, providing essential battle data.
    /// Stats are ordered by their standard game order (HP, Attack, Defense, Sp.Attack, Sp.Defense, Speed).
    ///
    /// ```swift
    /// let pikachu = try PokeAPIPokemon.WithStats.fetchOne(database, pokemonId: 25)
    /// let hp = pikachu.stats.first(where: { $0.stat.identifier == "hp" })?.baseStat
    /// ```
    public struct WithStats {
        public let pokemon: PokeAPIPokemon
        public let stats: [StatData]

        public init(
            pokemon: PokeAPIPokemon,
            stats: [StatData]
        ) {
            self.pokemon = pokemon
            self.stats = stats
        }

        /// Contains a stat value and effort yield for a specific Pokemon.
        public struct StatData {
            public let stat: PokeAPIStat
            public let baseStat: Int
            public let effort: Int

            public init(
                stat: PokeAPIStat,
                baseStat: Int,
                effort: Int
            ) {
                self.stat = stat
                self.baseStat = baseStat
                self.effort = effort
            }
        }

        // MARK: -

        /// Fetches multiple Pokemon with their base stats.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - limit: Maximum number of Pokemon to fetch (default: 10, use nil for all)
        /// - Returns: Array of Pokemon with their stats, ordered by Pokemon ID
        public static func fetchAll(
            _ database: StructuredQueriesSQLite.Database,
            limit: Int? = 10
        ) throws -> [PokeAPIPokemon.WithStats] {
            // Get all Pokemon
            let allPokemon: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all
                    .limit(limit ?? 10_000)
                    .order(by: \.id)
            )
            // Get its stats
            return try allPokemon
                .map { pokemon in
                    let stats = try fetchStatsForPokemon(database, pokemonId: pokemon.id)
                    return WithStats(pokemon: pokemon, stats: stats)
                }
        }

        /// Fetches multiple Pokemon with their base stats, filtered by version availability.
        /// 
        /// This ensures that Pokemon like Pikachu in Pokemon Red won't return forms
        /// that weren't available in that generation (e.g., Gigantamax forms).
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - versionId: The game version to filter forms for
        ///   - limit: Maximum number of Pokemon to fetch (default: 10, use nil for all)
        /// - Returns: Array of Pokemon with their stats, filtered for version compatibility
        public static func fetchAllForVersion(
            _ database: StructuredQueriesSQLite.Database,
            versionId: PokeAPIVersion.ID,
            limit: Int? = 10
        ) throws -> [PokeAPIPokemon.WithStats] {
            // Get all Pokemon
            let allPokemon: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all
                    .limit(limit ?? 10_000)
                    .order(by: \.id)
            )
            
            // Filter forms based on availability in the target version
            let availableForms = try PokeAPIPokemonFormFiltering.filterFormsForVersion(
                database, 
                pokemon: allPokemon, 
                versionId: versionId
            )
            
            // Get stats for available forms
            return try availableForms
                .map { pokemon in
                    let stats = try fetchStatsForPokemon(database, pokemonId: pokemon.id)
                    return WithStats(pokemon: pokemon, stats: stats)
                }
        }

        /// Fetches a single Pokemon with its base stats.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - pokemonId: The ID of the Pokemon to fetch
        /// - Returns: The Pokemon with its stats
        /// - Throws: `WithStatsError.pokemonNotFound` if no Pokemon exists with the given ID
        public static func fetchOne(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID
        ) throws -> PokeAPIPokemon.WithStats {
            // Get the Pokemon
            let pokemonResults: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all.where { $0.id == pokemonId }
            )
            guard let pokemon = pokemonResults.first else {
                throw WithStatsError.pokemonNotFound(pokemonId)
            }
            
            // Get its stats
            let stats = try fetchStatsForPokemon(database, pokemonId: pokemonId)
            
            return WithStats(pokemon: pokemon, stats: stats)
        }

        // MARK: - Private Helpers

        /// Fetches all stat data for a specific Pokemon.
        private static func fetchStatsForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID
        ) throws -> [StatData] {
            let pokemonStats: [(PokeAPIPokemonStat, PokeAPIStat)] = try database.execute(
                PokeAPIPokemonStat.all
                    .where { $0.pokemonId == pokemonId }
                    .join(PokeAPIStat.all) { $0.statId == $1.id }
                    // Sort stats by stat ID (HP, Attack, Defense, Sp.Attack, Sp.Defense, Speed)
                    .order { $1.id }
            )
            return pokemonStats
                .map { (pokemonStat, stat) in
                    StatData(
                        stat: stat,
                        baseStat: pokemonStat.baseStat,
                        effort: pokemonStat.effort
                    )
                }
        }

        // MARK: -

        private enum WithStatsError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}
