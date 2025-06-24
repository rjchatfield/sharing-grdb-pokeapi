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
            let query = With {
                PokeAPIPokemon
                    .select(PokeAPIPokemon.TableSelection.Columns.init(pokemon:))
                    .limit(limit ?? 10_000)
            } query: {
                PokeAPIPokemon.TableSelection
                    .join(PokeAPIPokemonStat.all, on: joinOn(pokemon:junction:))
                    .join(PokeAPIStat.all, on: joinOn(pokemon:junction:stat:))
                    .select(makeColumns(pokemon:junction:stat:))
            }
            let fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIPokemonStat, PokeAPIStat)] = try database.execute(query)
            return process(fetchResults: fetchResults)
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
            let query = With {
                PokeAPIPokemon
                    .select(PokeAPIPokemon.TableSelection.Columns.init(pokemon:))
                    .where { $0.id == pokemonId }
            } query: {
                PokeAPIPokemon.TableSelection
                    .join(PokeAPIPokemonStat.all, on: joinOn(pokemon:junction:))
                    .join(PokeAPIStat.all, on: joinOn(pokemon:junction:stat:))
                    .select(makeColumns(pokemon:junction:stat:))
            }
            let fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIPokemonStat, PokeAPIStat)] = try database.execute(query)
            guard let result = process(fetchResults: fetchResults).first else {
                throw WithStatsError.pokemonNotFound(pokemonId)
            }
            return result
        }

        // MARK: -

        private static func process(
            fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIPokemonStat, PokeAPIStat)]
        ) -> [WithStats] {
            fetchResults
                .reduce(into: [PokeAPIPokemon.ID: WithStats]()) { acc, next in
                    let (pokemonLimited, junction, stat) = next
                    let pokemon = pokemonLimited.pokemon
                    let existing = acc[pokemon.id]?.stats ?? []
                    let statData = StatData(
                        stat: stat,
                        baseStat: junction.baseStat,
                        effort: junction.effort
                    )
                    let newStats = existing + [statData]
                    acc[pokemon.id] = WithStats(
                        pokemon: pokemon,
                        stats: newStats.sorted { lhs, rhs in
                            // Sort by stat ID (standard game order: HP, Atk, Def, SpA, SpD, Spe)
                            lhs.stat.id.rawValue < rhs.stat.id.rawValue
                        }
                    )
                }
                .sorted(by: { $0.key < $1.key })
                .map(\.value)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            junction: PokeAPIPokemonStat.TableColumns
        ) -> some QueryExpression<Bool> {
            return pokemon.id.eq(junction.pokemonId)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            junction: PokeAPIPokemonStat.TableColumns,
            stat: PokeAPIStat.TableColumns
        ) -> some QueryExpression<Bool> {
            return junction.statId.eq(stat.id)
        }

        private static func makeColumns(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            junction: PokeAPIPokemonStat.TableColumns,
            stat: PokeAPIStat.TableColumns
        ) -> (
            PokeAPIPokemon.TableSelection.TableColumns,
            PokeAPIPokemonStat.TableColumns,
            PokeAPIStat.TableColumns
        ) {
            return (
                pokemon,
                junction,
                stat
            )
        }

        // MARK: -

        private enum WithStatsError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}

