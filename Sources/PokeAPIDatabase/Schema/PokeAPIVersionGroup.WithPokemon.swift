import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIVersionGroup {
    /// Provides functionality for fetching Pokemon data related to specific version groups.
    /// 
    /// This struct contains methods for retrieving Pokemon species that are associated with
    /// particular version groups, such as starter Pokemon available in those games.
    ///
    /// ## Usage
    /// ```swift
    /// let database = try Database(path: "pokemon.db")
    /// let starters = try PokeAPIVersionGroup.WithPokemon.fetchStarters(database, versionGroupId: PokeAPIVersionGroup.ID(1))
    /// print("Red/Blue starters: \(starters.map(\.formattedName))")
    /// // Output: Red/Blue starters: ["Bulbasaur", "Charmander", "Squirtle"]
    /// ```
    public struct WithPokemon {
        
        /// Fetches the starter Pokemon species for the given version group.
        /// 
        /// Returns the three starter Pokemon species (Grass, Fire, Water types) that are available
        /// as starter choices in the specified version group. The Pokemon are returned in National
        /// Pokedex order (ascending by ID).
        /// 
        /// ## Examples
        /// ```swift
        /// // Get Gen 1 starters (Red/Blue)
        /// let gen1Starters = try PokeAPIVersionGroup.WithPokemon.fetchStarters(database, versionGroupId: PokeAPIVersionGroup.ID(1))
        /// // Returns: [Bulbasaur, Charmander, Squirtle]
        /// 
        /// // Get Gen 6 starters (X/Y)
        /// let gen6Starters = try PokeAPIVersionGroup.WithPokemon.fetchStarters(database, versionGroupId: PokeAPIVersionGroup.ID(15))
        /// // Returns: [Chespin, Fennekin, Froakie]
        /// ```
        /// 
        /// - Parameter database: The database connection to query from
        /// - Parameter versionGroupId: The ID of the version group to get starters for
        /// - Returns: Array of PokeAPIPokemonSpecies representing the starter Pokemon, ordered by National Pokedex number
        /// - Throws: `StarterError.versionGroupNotFound` if the version group doesn't exist, or database errors
        public static func fetchStarters(
            _ database: StructuredQueriesSQLite.Database,
            versionGroupId: PokeAPIVersionGroup.ID
        ) throws -> [PokeAPIPokemonSpecies] {
            // Get the generation for this version group
            let versionGroupResults: [PokeAPIVersionGroup] = try database.execute(
                PokeAPIVersionGroup.all.where { $0.id == versionGroupId }
            )
            guard let versionGroup = versionGroupResults.first else {
                throw StarterError.versionGroupNotFound(versionGroupId)
            }
            
            // Get starter Pokemon species for this generation
            let starterIds = starterSpeciesIds(for: versionGroup.generationId)
            
            let starters: [PokeAPIPokemonSpecies] = try database.execute(
                PokeAPIPokemonSpecies.all
                    .where { pokemonSpecies in
                        starterIds.contains(pokemonSpecies.id)
                    }
                    .order(by: \.id)
            )
            
            return starters
        }
        
        /// Returns the starter Pokemon species IDs for a given generation
        private static func starterSpeciesIds(for generationId: PokeAPIGeneration.ID) -> [PokeAPIPokemonSpecies.ID] {
            switch generationId.rawValue {
            case 1: // Gen 1 (Red/Blue/Green/Yellow)
                return [PokeAPIPokemonSpecies.ID(1), PokeAPIPokemonSpecies.ID(4), PokeAPIPokemonSpecies.ID(7)] // Bulbasaur, Charmander, Squirtle
            case 2: // Gen 2 (Gold/Silver/Crystal)
                return [PokeAPIPokemonSpecies.ID(152), PokeAPIPokemonSpecies.ID(155), PokeAPIPokemonSpecies.ID(158)] // Chikorita, Cyndaquil, Totodile
            case 3: // Gen 3 (Ruby/Sapphire/Emerald/FireRed/LeafGreen)
                return [PokeAPIPokemonSpecies.ID(252), PokeAPIPokemonSpecies.ID(255), PokeAPIPokemonSpecies.ID(258)] // Treecko, Torchic, Mudkip
            case 4: // Gen 4 (Diamond/Pearl/Platinum/HeartGold/SoulSilver)
                return [PokeAPIPokemonSpecies.ID(387), PokeAPIPokemonSpecies.ID(390), PokeAPIPokemonSpecies.ID(393)] // Turtwig, Chimchar, Piplup
            case 5: // Gen 5 (Black/White/Black2/White2)
                return [PokeAPIPokemonSpecies.ID(495), PokeAPIPokemonSpecies.ID(498), PokeAPIPokemonSpecies.ID(501)] // Snivy, Tepig, Oshawott
            case 6: // Gen 6 (X/Y/Omega Ruby/Alpha Sapphire)
                return [PokeAPIPokemonSpecies.ID(650), PokeAPIPokemonSpecies.ID(653), PokeAPIPokemonSpecies.ID(656)] // Chespin, Fennekin, Froakie
            case 7: // Gen 7 (Sun/Moon/Ultra Sun/Ultra Moon)
                return [PokeAPIPokemonSpecies.ID(722), PokeAPIPokemonSpecies.ID(725), PokeAPIPokemonSpecies.ID(728)] // Rowlet, Litten, Popplio
            case 8: // Gen 8 (Sword/Shield/Let's Go/Brilliant Diamond/Shining Pearl/Legends Arceus)
                return [PokeAPIPokemonSpecies.ID(810), PokeAPIPokemonSpecies.ID(813), PokeAPIPokemonSpecies.ID(816)] // Grookey, Scorbunny, Sobble
            case 9: // Gen 9 (Scarlet/Violet)
                return [PokeAPIPokemonSpecies.ID(906), PokeAPIPokemonSpecies.ID(909), PokeAPIPokemonSpecies.ID(912)] // Sprigatito, Fuecoco, Quaxly
            default:
                return []
            }
        }
        
        /// Errors that can occur when fetching starter Pokemon
        private enum StarterError: Error {
            case versionGroupNotFound(PokeAPIVersionGroup.ID)
        }
    }
}
