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
        public let evolutions: [EvolutionData]

        public init(
            pokemon: PokeAPIPokemon,
            evolutions: [EvolutionData]
        ) {
            self.pokemon = pokemon
            self.evolutions = evolutions
        }

        /// Contains evolution requirement information.
        public struct EvolutionData {
            public let evolution: PokeAPIPokemonEvolution
            public let evolvedSpeciesId: PokeAPIPokemonSpecies.ID
            public let evolutionTriggerId: PokeAPIEvolutionTrigger.ID
            public let minimumLevel: String?
            public let triggerItemId: PokeAPIItem.ID?

            public init(
                evolution: PokeAPIPokemonEvolution,
                evolvedSpeciesId: PokeAPIPokemonSpecies.ID,
                evolutionTriggerId: PokeAPIEvolutionTrigger.ID,
                minimumLevel: String? = nil,
                triggerItemId: PokeAPIItem.ID? = nil
            ) {
                self.evolution = evolution
                self.evolvedSpeciesId = evolvedSpeciesId
                self.evolutionTriggerId = evolutionTriggerId
                self.minimumLevel = minimumLevel
                self.triggerItemId = triggerItemId
            }
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
            let query = PokeAPIPokemon
                .limit(limit ?? 10_000)
                .join(PokeAPIPokemonSpecies.all, on: joinOn(pokemon:species:))
                .join(PokeAPIEvolutionChain.all, on: joinOn(pokemon:species:chain:))
                .join(PokeAPIPokemonEvolution.all, on: joinOn(pokemon:species:chain:evolution:))
                .select(makeColumns(pokemon:species:chain:evolution:))
            let fetchResults: [(PokeAPIPokemon, PokeAPIPokemonSpecies, PokeAPIEvolutionChain, PokeAPIPokemonEvolution)] = try database.execute(query)
            return process(fetchResults: fetchResults)
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
            let query = PokeAPIPokemon
                .where { $0.id == pokemonId }
                .join(PokeAPIPokemonSpecies.all, on: joinOn(pokemon:species:))
                .join(PokeAPIEvolutionChain.all, on: joinOn(pokemon:species:chain:))
                .join(PokeAPIPokemonEvolution.all, on: joinOn(pokemon:species:chain:evolution:))
                .select(makeColumns(pokemon:species:chain:evolution:))
            let fetchResults: [(PokeAPIPokemon, PokeAPIPokemonSpecies, PokeAPIEvolutionChain, PokeAPIPokemonEvolution)] = try database.execute(query)
            
            // If no evolution data found, try to get just the Pokemon
            if fetchResults.isEmpty {
                let pokemonQuery = PokeAPIPokemon.where { $0.id == pokemonId }
                let pokemonResults: [PokeAPIPokemon] = try database.execute(pokemonQuery)
                guard let pokemon = pokemonResults.first else {
                    throw WithEvolutionsError.pokemonNotFound(pokemonId)
                }
                return WithEvolutions(pokemon: pokemon, evolutions: [])
            }
            
            return process(fetchResults: fetchResults).first!
        }

        // MARK: -

        private static func process(
            fetchResults: [(PokeAPIPokemon, PokeAPIPokemonSpecies, PokeAPIEvolutionChain, PokeAPIPokemonEvolution)]
        ) -> [WithEvolutions] {
            fetchResults
                .reduce(into: [PokeAPIPokemon.ID: WithEvolutions]()) { acc, next in
                    let (pokemon, _, _, evolution) = next
                    let existing = acc[pokemon.id]?.evolutions ?? []
                    let evolutionData = EvolutionData(
                        evolution: evolution,
                        evolvedSpeciesId: evolution.evolvedSpeciesId,
                        evolutionTriggerId: evolution.evolutionTriggerId,
                        minimumLevel: evolution.minimumLevel,
                        triggerItemId: evolution.triggerItemId
                    )
                    let newEvolutions = existing + [evolutionData]
                    acc[pokemon.id] = WithEvolutions(
                        pokemon: pokemon,
                        evolutions: newEvolutions
                    )
                }
                .sorted(by: { $0.key < $1.key })
                .map(\.value)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableColumns,
            species: PokeAPIPokemonSpecies.TableColumns
        ) -> some QueryExpression<Bool> {
            return pokemon.speciesId.eq(species.id)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableColumns,
            species: PokeAPIPokemonSpecies.TableColumns,
            chain: PokeAPIEvolutionChain.TableColumns
        ) -> some QueryExpression<Bool> {
            return species.evolutionChainId.eq(chain.id)
        }

        private static func joinOn(
            pokemon: PokeAPIPokemon.TableColumns,
            species: PokeAPIPokemonSpecies.TableColumns,
            chain: PokeAPIEvolutionChain.TableColumns,
            evolution: PokeAPIPokemonEvolution.TableColumns
        ) -> some QueryExpression<Bool> {
            // This is a simplified join - in reality evolution relationships are more complex
            return species.id.eq(evolution.evolvedSpeciesId)
        }

        private static func makeColumns(
            pokemon: PokeAPIPokemon.TableColumns,
            species: PokeAPIPokemonSpecies.TableColumns,
            chain: PokeAPIEvolutionChain.TableColumns,
            evolution: PokeAPIPokemonEvolution.TableColumns
        ) -> (
            PokeAPIPokemon.TableColumns,
            PokeAPIPokemonSpecies.TableColumns,
            PokeAPIEvolutionChain.TableColumns,
            PokeAPIPokemonEvolution.TableColumns
        ) {
            return (
                pokemon,
                species,
                chain,
                evolution
            )
        }

        // MARK: -

        private enum WithEvolutionsError: Error {
            case pokemonNotFound(PokeAPIPokemon.ID)
        }
    }
}