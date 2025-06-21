import StructuredQueries

/// Contains core species data shared across all forms of a Pokemon.
/// This includes breeding information, capture mechanics, evolution data,
/// and classification details that remain consistent regardless of form.
@Table("pokemon_species")
public struct PokeAPIPokemonSpecies: Codable, Equatable, Identifiable, Sendable {
    public typealias ID = Int

    /// National Pokedex number and unique species identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable species name (e.g., "pikachu", "charizard")
    @Column("identifier") public var identifier: String
    
    /// Generation in which this species was first introduced (1-9+)
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    /// Species this Pokemon evolves from, if any
    /// Nil for base evolution forms (e.g., Bulbasaur, Charmander)
    @Column("evolves_from_species_id") public var evolvesFromSpeciesId: PokeAPIPokemonSpecies.ID?

    /// Evolution chain this species belongs to
    /// Links related evolutionary forms together
    @Column("evolution_chain_id") public var evolutionChainId: PokeAPIEvolutionChain.ID

    /// Primary color classification for this Pokemon
    /// Used for Pokedex filtering and organization
    @Column("color_id") public var colorId: Int
    
    /// Body shape category (humanoid, quadruped, serpentine, etc.)
    @Column("shape_id") public var shapeId: Int
    
    /// Natural habitat where this Pokemon can typically be found
    /// Nil for Pokemon without a specific natural habitat
    @Column("habitat_id") public var habitatId: Int?
    
    /// Gender distribution ratio: -1 = genderless, 0 = always male, 8 = always female
    /// Values 1-7 represent increasing likelihood of being female (1/8 to 7/8)
    @Column("gender_rate") public var genderRate: Int
    
    /// Base capture rate (0-255, higher = easier to catch)
    /// Example: Caterpie = 255 (very easy), Mewtwo = 3 (very hard)
    /// Range: 3-255
    @Column("capture_rate") public var captureRate: Int
    
    /// Base friendship/happiness value when caught (0-255)
    /// Affects happiness evolution and certain move effectiveness
    /// Range: 0-140
    @Column("base_happiness") public var baseHappiness: Int
    
    /// Whether this is considered a "baby" Pokemon
    /// Baby Pokemon cannot breed and often evolve via friendship
    @Column("is_baby") public var isBaby: Bool
    
    /// Base number of egg cycles required to hatch (steps = cycles × 256)
    /// Used for breeding mechanics
    /// Range: 5-120
    @Column("hatch_counter") public var hatchCounter: Int
    
    /// Whether male and female versions have visual differences
    /// True for species like Nidoran, Pyroar, etc.
    @Column("has_gender_differences") public var hasGenderDifferences: Bool
    
    /// Experience growth rate category (slow, medium, fast, etc.)
    /// Determines how much EXP is needed to reach each level
    @Column("growth_rate_id") public var growthRateId: Int
    
    /// Whether this Pokemon can switch between different forms
    /// True for Pokemon like Rotom, Deoxys, Shaymin, etc.
    @Column("forms_switchable") public var formsSwitchable: Bool
    
    /// Whether this Pokemon is classified as Legendary
    /// Legendary Pokemon are rare, powerful, and often unique
    @Column("is_legendary") public var isLegendary: Bool
    
    /// Whether this Pokemon is classified as Mythical  
    /// Mythical Pokemon are typically event-exclusive
    @Column("is_mythical") public var isMythical: Bool
    
    /// National Pokedex sort order
    /// Range: 1-1027
    @Column("order") public var order: Int
    
    /// Sort order for Pokemon Conquest game (if applicable)
    /// Range: 1-200
    @Column("conquest_order") public var conquestOrder: Int?

    public var formattedName: String {
        identifier.capitalized.replacingOccurrences(of: "-", with: " ")
    }
    
    public var nationalDexNumber: Int {
        id
    }
}
