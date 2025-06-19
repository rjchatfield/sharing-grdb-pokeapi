import SharingGRDB

/// Represents specific Pokemon forms (e.g., regular Pikachu vs. different regional forms).
/// Each entry corresponds to a unique Pokemon form that can appear in battle,
/// with its own stats, appearance, and battle characteristics.
@Table("pokemon")
public struct PokeAPIPokemon: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int
    
    /// Unique identifier for this Pokemon form
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable name (e.g., "pikachu", "pikachu-cosplay")
    @Column("identifier") public var identifier: String
    
    /// Foreign key to the pokemon_species table - links to the base species information
    @Column("species_id") public var speciesId: PokeAPIPokemonSpecies.ID
    
    /// Pokemon's height in decimeters (1 decimeter = 10 cm)
    /// Example: Pikachu's height of 4 means 40 cm tall
    @Column("height") public var height: Int
    
    /// Pokemon's weight in hectograms (1 hectogram = 100 grams)
    /// Example: Pikachu's weight of 60 means 6.0 kg
    @Column("weight") public var weight: Int
    
    /// Base experience points yielded when this Pokemon is defeated in battle
    /// Used for calculating EXP gain. Nil for Pokemon that don't give EXP (like some forms)
    @Column("base_experience") public var baseExperience: Int?
    
    /// Sorting order for this Pokemon within its species
    /// Used to determine display order when multiple forms exist
    @Column("order") public var order: Int?
    
    /// Whether this is the default/primary form of the species
    /// True for the main form (e.g., regular Pikachu), false for alternate forms
    @Column("is_default") public var isDefault: Bool
}
