import StructuredQueries
import StructuredQueriesSQLite

/// Shared utilities for filtering Pokemon forms based on game version availability.
/// 
/// This ensures that Pokemon queries only return forms that were actually available 
/// in the target game version, preventing Pikachu in Pokemon Red from showing 
/// Gigantamax forms that weren't introduced until Generation 8.
public enum PokeAPIPokemonFormFiltering {
    
    /// Determines if a Pokemon form is available in a specific generation
    /// 
    /// - Parameters:
    ///   - identifier: The Pokemon identifier (e.g., "pikachu", "charizard-mega-x")
    ///   - generationId: The generation number (1-9)
    /// - Returns: True if the form is available in that generation
    public static func isFormAvailableInGeneration(
        _ identifier: PokeAPIPokemon.Identifier,
        generationId: PokeAPIGeneration.ID
    ) -> Bool {
        // Base forms are always available
        if !identifier.contains("-") {
            return true
        }
        
        // Mega Evolution forms available in Generation 6-7, removed in 8+
        // Use a more precise check to avoid false positives like "meganium"
        if identifier.contains("-mega") {
            return generationId >= 6 && generationId <= 7
        }
        
        // Gigantamax forms available only in Generation 8
        if identifier.contains("gmax") {
            return generationId == 8
        }
        
        // Alolan forms introduced in Generation 7 (Sun/Moon)
        if identifier.contains("alola") {
            return generationId >= 7
        }
        
        // Galarian forms introduced in Generation 8 (Sword/Shield)
        if identifier.contains("galar") {
            return generationId >= 8
        }
        
        // Hisuian forms introduced in Generation 8 (Legends Arceus)
        if identifier.contains("hisui") {
            return generationId >= 8
        }
        
        // Paldean forms introduced in Generation 9 (Scarlet/Violet)
        if identifier.contains("paldea") {
            return generationId >= 9
        }
        
        // Totem forms introduced in Generation 7 (Sun/Moon)
        if identifier.contains("totem") {
            return generationId >= 7
        }
        
        // Costume/Event forms - most were introduced in Generation 6+
        // These include Pikachu caps, contest costumes, etc.
        if identifier.contains("-cap") || 
           identifier.contains("-rock-star") || 
           identifier.contains("-belle") || 
           identifier.contains("-pop-star") || 
           identifier.contains("-phd") || 
           identifier.contains("-libre") || 
           identifier.contains("-cosplay") || 
           identifier.contains("-starter") || 
           identifier.contains("-world") {
            return generationId >= 6
        }
        
        // For other forms, assume they're available (could be refined further)
        return true
    }
    
    /// Filters Pokemon forms to only include those available in the target version
    /// 
    /// - Parameters:
    ///   - pokemon: Array of Pokemon to filter
    ///   - generationId: The generation number to filter for
    /// - Returns: Filtered array containing only available forms
    public static func filterFormsForGeneration(
        pokemon: some Collection<PokeAPIPokemon>,
        generationId: PokeAPIGeneration.ID
    ) -> [PokeAPIPokemon] {
        return pokemon.filter { pokemon in
            return isFormAvailableInGeneration(pokemon.identifier, generationId: generationId)
        }
    }
        
    /// Gets the generation number for a specific version ID
    /// 
    /// - Parameters:
    ///   - database: The database to query
    ///   - versionId: The version ID to look up
    /// - Returns: The generation number for that version
    /// - Throws: Database errors if the version is not found
    public static func getGenerationForVersion(
        _ database: StructuredQueriesSQLite.Database,
        versionId: PokeAPIVersion.ID
    ) throws -> PokeAPIGeneration.ID {
        let versionInfo: [PokeAPIVersionGroup] = try database.execute(
            PokeAPIVersion.all
                .where { $0.id == versionId }
                .join(PokeAPIVersionGroup.all) { $0.versionGroupId == $1.id }
                .select { $1 }
        )
        guard let versionGroup = versionInfo.first else {
            throw FormFilteringError.versionNotFound(versionId)
        }
        return versionGroup.generationId
    }
    
    /// Filters Pokemon to only return forms available in the specified version
    /// 
    /// - Parameters:
    ///   - database: The database to query for version information
    ///   - pokemon: Array of Pokemon to filter
    ///   - versionId: The target version ID
    /// - Returns: Filtered array containing only available forms
    /// - Throws: Database errors if the version is not found
    public static func filterFormsForVersion(
        _ database: StructuredQueriesSQLite.Database,
        pokemon: some Collection<PokeAPIPokemon>,
        versionId: PokeAPIVersion.ID
    ) throws -> [PokeAPIPokemon] {
        let targetGeneration = try getGenerationForVersion(database, versionId: versionId)
        return filterFormsForGeneration(pokemon: pokemon, generationId: targetGeneration)
    }

    // MARK: - Errors
    
    public enum FormFilteringError: Error {
        case versionNotFound(PokeAPIVersion.ID)
    }
}
