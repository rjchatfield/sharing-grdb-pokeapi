import StructuredQueries
import Tagged

// TODO: Add description for conquest_pokemon_evolution table
@Table("conquest_pokemon_evolution")
public struct PokeAPIConquestPokemonEvolution: Decodable, Hashable, Sendable {

    // TODO: Add description for evolved_species_id
    @Column("evolved_species_id") public var evolvedSpeciesId: PokeAPIPokemonSpecy.ID

    // TODO: Add description for required_stat_id
    @Column("required_stat_id") public var requiredStatId: PokeAPIConquestStat.ID?

    // TODO: Add description for minimum_stat
    @Column("minimum_stat") public var minimumStat: Int?

    // TODO: Add description for minimum_link
    @Column("minimum_link") public var minimumLink: Int?

    // TODO: Add description for kingdom_id
    @Column("kingdom_id") public var kingdomId: PokeAPIConquestKingdom.ID?

    // TODO: Add description for warrior_gender_id
    @Column("warrior_gender_id") public var warriorGenderId: PokeAPIGender.ID?

    // TODO: Add description for item_id
    @Column("item_id") public var itemId: PokeAPIItem.ID?

    // TODO: Add description for recruiting_ko_required
    @Column("recruiting_ko_required") public var recruitingKoRequired: Int

}
