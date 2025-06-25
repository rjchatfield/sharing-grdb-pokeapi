import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIPokemon {
    /// Represents a Pokemon with its possible abilities.
    /// 
    /// Each Pokemon can have 1-3 abilities: up to 2 regular abilities and optionally 1 hidden ability.
    /// Abilities are ordered by slot (1-2 for regular, 3 for hidden).
    ///
    /// ```swift
    /// let pikachu = try PokeAPIPokemon.WithAbilities.fetchOne(database, pokemonId: 25)
    /// let hiddenAbility = pikachu.abilities.first(where: { $0.isHidden })
    /// ```
    public struct WithAbilities {
        public let pokemon: PokeAPIPokemon
        public let abilities: [AbilityData]

        public init(
            pokemon: PokeAPIPokemon,
            abilities: [AbilityData]
        ) {
            self.pokemon = pokemon
            self.abilities = abilities
        }

        /// Contains an ability and its slot information for a specific Pokemon.
        public struct AbilityData {
            public let ability: PokeAPIAbility
            public let isHidden: Bool
            public let slot: Int

            public init(
                ability: PokeAPIAbility,
                isHidden: Bool,
                slot: Int
            ) {
                self.ability = ability
                self.isHidden = isHidden
                self.slot = slot
            }
        }

        // MARK: -

        /// Fetches multiple Pokemon with their abilities.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - limit: Maximum number of Pokemon to fetch (default: 10, use nil for all)
        /// - Returns: Array of Pokemon with their abilities, ordered by Pokemon ID
        public static func fetchAll(
            _ database: StructuredQueriesSQLite.Database,
            limit: Int? = 10
        ) throws -> [PokeAPIPokemon.WithAbilities] {
            let query = With {
                PokeAPIPokemon
                    .select(PokeAPIPokemon.TableSelection.Columns.init(pokemon:))
                    .limit(limit ?? 10_000) // higher than total number of pokemon
            } query: {
                PokeAPIPokemon.TableSelection
                    .join(PokeAPIPokemonAbility.all, on: joinOn(pokemon:junction:))
                    .join(PokeAPIAbility.all, on: joinOn(pokemon:junction:ability:))
            }
            let fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIPokemonAbility, PokeAPIAbility)] = try database.execute(query)
            return process(fetchResults: fetchResults)
        }

        /// Fetches a single Pokemon with its abilities.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - pokemonId: The ID of the Pokemon to fetch
        /// - Returns: The Pokemon with its abilities
        /// - Throws: `WithAbilitiesError.pokemonNotFound` if no Pokemon exists with the given ID
        public static func fetchOne(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID
        ) throws -> PokeAPIPokemon.WithAbilities {
            let query = With {
                PokeAPIPokemon
                    .select(PokeAPIPokemon.TableSelection.Columns.init(pokemon:))
                    .where { $0.id == pokemonId }
            } query: {
                PokeAPIPokemon.TableSelection
                    .join(PokeAPIPokemonAbility.all, on: joinOn(pokemon:junction:))
                    .join(PokeAPIAbility.all, on: joinOn(pokemon:junction:ability:))
            }
            let fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIPokemonAbility, PokeAPIAbility)] = try database.execute(query)
            guard let result = process(fetchResults: fetchResults).first else {
                throw WithAbilitiesError.pokemonNotFound(pokemonId)
            }
            return result
        }

        // MARK: -

        private static func process(
            fetchResults: [(PokeAPIPokemon.TableSelection, PokeAPIPokemonAbility, PokeAPIAbility)]
        ) -> [WithAbilities] {
            fetchResults
                .reduce(into: [PokeAPIPokemon.ID: WithAbilities]()) { acc, next in
                    let (tableSelection, junction, ability) = next
                    let pokemon = tableSelection.pokemon
                    let existing = acc[pokemon.id]?.abilities ?? []
                    let abilityData = AbilityData(
                        ability: ability,
                        isHidden: junction.isHidden,
                        slot: junction.slot
                    )
                    let newAbilities = existing + [abilityData]
                    acc[pokemon.id] = WithAbilities(
                        pokemon: pokemon,
                        abilities: newAbilities.sorted { lhs, rhs in
                            // Sort by slot (regular abilities first, then hidden)
                            lhs.slot < rhs.slot
                        }
                    )
                }
                .sorted(by: { $0.key < $1.key })
                .map(\.value)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            junction: PokeAPIPokemonAbility.TableColumns
        ) -> some QueryExpression<Bool> {
            return pokemon.id.eq(junction.pokemonId)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableSelection.TableColumns,
            junction: PokeAPIPokemonAbility.TableColumns,
            ability: PokeAPIAbility.TableColumns
        ) -> some QueryExpression<Bool> {
            return junction.abilityId.eq(ability.id)
        }

        // MARK: -

        private enum WithAbilitiesError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}
