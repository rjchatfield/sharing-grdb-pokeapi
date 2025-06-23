import Foundation
import StructuredQueries
import Tagged

/// Represents specific Pokemon forms (e.g., regular Pikachu vs. different regional forms).
/// Each entry corresponds to a unique Pokemon form that can appear in battle,
/// with its own stats, appearance, and battle characteristics.
@Table("pokemon")
public struct PokeAPIPokemon: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this Pokemon form
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable name (e.g., "pikachu", "pikachu-cosplay")
    @Column("identifier") public var identifier: Identifier
    
    /// Foreign key to the pokemon_species table - links to the base species information
    @Column("species_id") public var speciesId: PokeAPIPokemonSpecies.ID
    
    /// Pokemon's height in decimeters (1 decimeter = 10 cm)
    /// Example: Pikachu's height of 4 means 40 cm tall
    /// Range: 1-1000
    @Column("height") public var heightInDecimeters: Int
    
    /// Pokemon's weight in hectograms (1 hectogram = 100 grams)
    /// Example: Pikachu's weight of 60 means 6.0 kg
    /// Range: 0-10000
    @Column("weight") public var weightInHectograms: Int
    
    /// Base experience points yielded when this Pokemon is defeated in battle
    /// Used for calculating EXP gain. Nil for Pokemon that don't give EXP (like some forms)
    /// Range: 36-608
    @Column("base_experience") public var baseExperience: Int?
    
    /// Sorting order for this Pokemon within its species
    /// Used to determine display order when multiple forms exist
    /// Range: 1-1109
    @Column("order") public var order: Int?
    
    /// Whether this is the default/primary form of the species
    /// True for the main form (e.g., regular Pikachu), false for alternate forms
    @Column("is_default") public var isDefault: Bool

    // MARK: - Helpers

    public var nationalDexNumber: Int {
        return id.rawValue
    }

    public var localizedName: String {
        return PokeAPIStrings.pokemon(id: id, identifier: identifier)
    }

    public var height: Measurement<UnitLength> {
        return Measurement(value: Double(heightInDecimeters), unit: UnitLength.decimeters)
    }

    public var weight: Measurement<UnitMass> {
        return Measurement(value: Double(weightInHectograms) / 10.0, unit: UnitMass.kilograms)
    }
}
