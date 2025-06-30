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
            // Get all Pokemon
            let allPokemon: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all
                    .limit(limit ?? 10_000)
                    .order(by: \.id)
            )
            // Get its abilities
            return try allPokemon
                .map { pokemon in
                    let abilities = try fetchAbilitiesForPokemon(database, pokemonId: pokemon.id)
                    return WithAbilities(pokemon: pokemon, abilities: abilities)
                }
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
            // Get the Pokemon
            let pokemonResults: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all.where { $0.id == pokemonId }
            )
            guard let pokemon = pokemonResults.first else {
                throw WithAbilitiesError.pokemonNotFound(pokemonId)
            }
            
            // Get its abilities
            let abilities = try fetchAbilitiesForPokemon(database, pokemonId: pokemonId)
            
            return WithAbilities(pokemon: pokemon, abilities: abilities)
        }

        // MARK: - Private Helpers

        /// Fetches all ability data for a specific Pokemon.
        private static func fetchAbilitiesForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID
        ) throws -> [AbilityData] {
            let pokemonAbilities: [(PokeAPIPokemonAbility, PokeAPIAbility)] = try database.execute(
                PokeAPIPokemonAbility.all
                    .where { $0.pokemonId == pokemonId }
                    // Sort abilities by slot (regular abilities first, then hidden)
                    .order(by: \.slot)
                    .join(PokeAPIAbility.all) { $0.abilityId == $1.id }
            )
            return pokemonAbilities
                .map { (pokemonAbility, ability) in
                    AbilityData(
                        ability: ability,
                        isHidden: pokemonAbility.isHidden,
                        slot: pokemonAbility.slot
                    )
                }
        }

        // MARK: -

        private enum WithAbilitiesError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}
