import SharingGRDB

/// Main species information for Pokemon.
@Table("pokemon_species")
public struct PokeAPIPokemonSpecies: Codable, Equatable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
    @Column("generation_id") public var generationId: Int
    @Column("evolves_from_species_id") public var evolvesFromSpeciesId: Int?
    @Column("evolution_chain_id") public var evolutionChainId: Int
    @Column("color_id") public var colorId: Int
    @Column("shape_id") public var shapeId: Int
    @Column("habitat_id") public var habitatId: Int?
    @Column("gender_rate") public var genderRate: Int
    @Column("capture_rate") public var captureRate: Int
    @Column("base_happiness") public var baseHappiness: Int
    @Column("is_baby") public var isBaby: Bool
    @Column("hatch_counter") public var hatchCounter: Int
    @Column("has_gender_differences") public var hasGenderDifferences: Bool
    @Column("growth_rate_id") public var growthRateId: Int
    @Column("forms_switchable") public var formsSwitchable: Bool
    @Column("is_legendary") public var isLegendary: Bool
    @Column("is_mythical") public var isMythical: Bool
    @Column("order") public var order: Int
    @Column("conquest_order") public var conquestOrder: Int?

    public var formattedName: String {
        identifier.capitalized.replacingOccurrences(of: "-", with: " ")
    }
    
    public var nationalDexNumber: Int {
        id
    }
}
