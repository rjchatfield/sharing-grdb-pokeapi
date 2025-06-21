import Foundation

/// Public helper functions for accessing localized strings from the PokeAPI database.
/// Provides convenient access to localized names for Pokemon, abilities, moves, and other entities
/// using their database IDs.
public enum PokeAPIStrings {
    /// Returns the localized name for a Pokemon by its ID.
    /// - Parameter id: The Pokemon ID (1-1010+)
    /// - Parameter identifier: The Pokemon Identfier
    /// - Returns: Localized Pokemon name, or the identifier as fallback
    public static func pokemon(id: PokeAPIPokemon.ID, identifier: PokeAPIPokemon.Identifier) -> String {
        return localizedString(key: "pokemon.\(id).name", table: "Pokemon")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for an ability by its ID.
    /// - Parameter id: The ability ID (1-300+)
    /// - Parameter identifier: The ability identifier
    /// - Returns: Localized ability name, or the identifier as fallback
    public static func ability(id: PokeAPIAbility.ID, identifier: PokeAPIAbility.Identifier) -> String {
        return localizedString(key: "ability.\(id).name", table: "Abilities")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for a move by its ID.
    /// - Parameter id: The move ID (1-900+)
    /// - Parameter identifier: The move identifier
    /// - Returns: Localized move name, or the identifier as fallback
    public static func move(id: PokeAPIMove.ID, identifier: PokeAPIMove.Identifier) -> String {
        return localizedString(key: "move.\(id).name", table: "Moves")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for a type by its ID.
    /// - Parameter id: The type ID (1-19)
    /// - Parameter identifier: The type identifier
    /// - Returns: Localized type name, or the identifier as fallback
    public static func type(id: PokeAPIType.ID, identifier: PokeAPIType.Identifier) -> String {
        return localizedString(key: "type.\(id).name", table: "Types")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for an item by its ID.
    /// - Parameter id: The item ID (1-2000+)
    /// - Parameter identifier: The item identifier
    /// - Returns: Localized item name, or the identifier as fallback
    public static func item(id: PokeAPIItem.ID, identifier: PokeAPIItem.Identifier) -> String {
        return localizedString(key: "item.\(id).name", table: "Items")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for a location by its ID.
    /// - Parameter id: The location ID
    /// - Parameter identifier: The location identifier
    /// - Returns: Localized location name, or the identifier as fallback
    public static func location(id: PokeAPILocation.ID, identifier: PokeAPILocation.Identifier) -> String {
        return localizedString(key: "location.\(id).name", table: "Locations")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for a region by its ID.
    /// - Parameter id: The region ID (1-9)
    /// - Parameter identifier: The region identifier
    /// - Returns: Localized region name, or the identifier as fallback
    public static func region(id: PokeAPIRegion.ID, identifier: PokeAPIRegion.Identifier) -> String {
        return localizedString(key: "region.\(id).name", table: "Regions")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for a stat by its ID.
    /// - Parameter id: The stat ID (1-8)
    /// - Parameter identifier: The stat identifier
    /// - Returns: Localized stat name, or the identifier as fallback
    public static func stat(id: PokeAPIStat.ID, identifier: PokeAPIStat.Identifier) -> String {
        return localizedString(key: "stat.\(id).name", table: "Stats")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for a nature by its ID.
    /// - Parameter id: The nature ID (1-25)
    /// - Parameter identifier: The nature identifier
    /// - Returns: Localized nature name, or the identifier as fallback
    public static func nature(id: PokeAPINature.ID, identifier: PokeAPINature.Identifier) -> String {
        return localizedString(key: "nature.\(id).name", table: "Natures")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for a generation by its ID.
    /// - Parameter id: The generation ID (1-9)
    /// - Parameter identifier: The generation identifier
    /// - Returns: Localized generation name, or the identifier as fallback
    public static func generation(id: PokeAPIGeneration.ID, identifier: PokeAPIGeneration.Identifier) -> String {
        return localizedString(key: "generation.\(id).name", table: "Generations")
            ?? formatted(identifier: identifier)
    }
    
    /// Returns the localized name for a Pokemon color by its ID.
    /// - Parameter id: The color ID (1-10)
    /// - Returns: Localized color name, or the identifier as fallback
    public static func color(id: PokeAPIPokemonSpecies.ColorID) -> String? {
        return localizedString(key: "color.\(id).name", table: "Colors")
    }
    
    /// Returns the localized name for a Pokemon habitat by its ID.
    /// - Parameter id: The habitat ID (1-9)
    /// - Returns: Localized habitat name, or the identifier as fallback
    public static func habitat(id: PokeAPIPokemonSpecies.HabitatID) -> String? {
        return localizedString(key: "habitat.\(id).name", table: "Habitats")
    }

    // MARK: - Helpers

    /// Internal helper to load localized strings from the module bundle.
    /// - Parameters:
    ///   - key: The localization key (e.g., "pokemon.1.name")
    ///   - table: The strings table name (e.g., "Pokemon")
    /// - Returns: The localized string
    private static func localizedString(key: String, table: String) -> String? {
        let string = Bundle.module.localizedString(forKey: key, value: key, table: table)
        return string == key ? nil : string
    }

    static func formatted(identifier: String) -> String {
        return identifier.capitalized.replacingOccurrences(of: "-", with: " ")
    }
}
