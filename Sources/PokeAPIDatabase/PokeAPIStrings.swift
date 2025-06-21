import Foundation

/// Public helper functions for accessing localized strings from the PokeAPI database.
/// Provides convenient access to localized names for Pokemon, abilities, moves, and other entities
/// using their database IDs.
public enum PokeAPIStrings {
    
    /// Returns the localized name for a Pokemon by its ID.
    /// - Parameter id: The Pokemon ID (1-1010+)
    /// - Returns: Localized Pokemon name, or the identifier as fallback
    public static func pokemon(id: PokeAPIPokemon.ID) -> String {
        return localizedString(key: "pokemon.\(id).name", table: "Pokemon")
    }
    
    /// Returns the localized name for an ability by its ID.
    /// - Parameter id: The ability ID (1-300+)
    /// - Returns: Localized ability name, or the identifier as fallback
    public static func ability(id: PokeAPIAbility.ID) -> String {
        return localizedString(key: "ability.\(id).name", table: "Abilities")
    }
    
    /// Returns the localized name for a move by its ID.
    /// - Parameter id: The move ID (1-900+)
    /// - Returns: Localized move name, or the identifier as fallback
    public static func move(id: PokeAPIMove.ID) -> String {
        return localizedString(key: "move.\(id).name", table: "Moves")
    }
    
    /// Returns the localized name for a type by its ID.
    /// - Parameter id: The type ID (1-19)
    /// - Returns: Localized type name, or the identifier as fallback
    public static func type(id: PokeAPIType.ID) -> String {
        return localizedString(key: "type.\(id).name", table: "Types")
    }
    
    /// Returns the localized name for an item by its ID.
    /// - Parameter id: The item ID (1-2000+)
    /// - Returns: Localized item name, or the identifier as fallback
    public static func item(id: PokeAPIItem.ID) -> String {
        return localizedString(key: "item.\(id).name", table: "Items")
    }
    
    /// Returns the localized name for a location by its ID.
    /// - Parameter id: The location ID
    /// - Returns: Localized location name, or the identifier as fallback
    public static func location(id: PokeAPILocation.ID) -> String {
        return localizedString(key: "location.\(id).name", table: "Locations")
    }
    
    /// Returns the localized name for a region by its ID.
    /// - Parameter id: The region ID (1-9)
    /// - Returns: Localized region name, or the identifier as fallback
    public static func region(id: PokeAPIRegion.ID) -> String {
        return localizedString(key: "region.\(id).name", table: "Regions")
    }
    
    /// Returns the localized name for a stat by its ID.
    /// - Parameter id: The stat ID (1-8)
    /// - Returns: Localized stat name, or the identifier as fallback
    public static func stat(id: PokeAPIStat.ID) -> String {
        return localizedString(key: "stat.\(id).name", table: "Stats")
    }
    
    /// Returns the localized name for a nature by its ID.
    /// - Parameter id: The nature ID (1-25)
    /// - Returns: Localized nature name, or the identifier as fallback
    public static func nature(id: PokeAPINature.ID) -> String {
        return localizedString(key: "nature.\(id).name", table: "Natures")
    }
    
    /// Returns the localized name for a generation by its ID.
    /// - Parameter id: The generation ID (1-9)
    /// - Returns: Localized generation name, or the identifier as fallback
    public static func generation(id: PokeAPIGeneration.ID) -> String {
        return localizedString(key: "generation.\(id).name", table: "Generations")
    }
    
    /// Returns the localized name for a Pokemon color by its ID.
    /// - Parameter id: The color ID (1-10)
    /// - Returns: Localized color name, or the identifier as fallback
    public static func color(id: PokeAPIPokemonSpecies.ID) -> String {
        return localizedString(key: "color.\(id).name", table: "Colors")
    }
    
    /// Returns the localized name for a Pokemon habitat by its ID.
    /// - Parameter id: The habitat ID (1-9)
    /// - Returns: Localized habitat name, or the identifier as fallback
    public static func habitat(id: PokeAPIPokemonSpecies.ID) -> String {
        return localizedString(key: "habitat.\(id).name", table: "Habitats")
    }

    // MARK: - Private Implementation
    
    /// Internal helper to load localized strings from the module bundle.
    /// - Parameters:
    ///   - key: The localization key (e.g., "pokemon.1.name")
    ///   - table: The strings table name (e.g., "Pokemon")
    /// - Returns: The localized string
    private static func localizedString(key: String, table: String) -> String {
        return Bundle.module.localizedString(forKey: key, value: key, table: table)
    }
}
