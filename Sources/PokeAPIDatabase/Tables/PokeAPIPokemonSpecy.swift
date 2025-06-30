import StructuredQueries
import Tagged

// TODO: Add description for pokemon_species table
@Table("pokemon_species")
public struct PokeAPIPokemonSpecy: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

    // TODO: Add description for generation_id
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    // TODO: Add description for evolves_from_species_id
    @Column("evolves_from_species_id") public var evolvesFromSpeciesId: PokeAPIPokemonSpecy.ID?

    // TODO: Add description for evolution_chain_id
    @Column("evolution_chain_id") public var evolutionChainId: PokeAPIEvolutionChain.ID

    // TODO: Add description for color_id
    @Column("color_id") public var colorId: PokeAPIPokemonColor.ID

    // TODO: Add description for shape_id
    @Column("shape_id") public var shapeId: PokeAPIPokemonShape.ID

    // TODO: Add description for habitat_id
    @Column("habitat_id") public var habitatId: PokeAPIPokemonHabitat.ID?

    // TODO: Add description for gender_rate
    @Column("gender_rate") public var genderRate: Int

    // TODO: Add description for capture_rate
    @Column("capture_rate") public var captureRate: Int

    // TODO: Add description for base_happiness
    @Column("base_happiness") public var baseHappiness: Int

    // TODO: Add description for is_baby
    @Column("is_baby") public var isBaby: Bool

    // TODO: Add description for hatch_counter
    @Column("hatch_counter") public var hatchCounter: Int

    // TODO: Add description for has_gender_differences
    @Column("has_gender_differences") public var hasGenderDifferences: Int

    // TODO: Add description for growth_rate_id
    @Column("growth_rate_id") public var growthRateId: PokeAPIGrowthRate.ID

    // TODO: Add description for forms_switchable
    @Column("forms_switchable") public var formsSwitchable: Int

    // TODO: Add description for is_legendary
    @Column("is_legendary") public var isLegendary: Bool

    // TODO: Add description for is_mythical
    @Column("is_mythical") public var isMythical: Bool

    // TODO: Add description for order
    @Column("order") public var order: Int

    // TODO: Add description for conquest_order
    @Column("conquest_order") public var conquestOrder: Int?

}
