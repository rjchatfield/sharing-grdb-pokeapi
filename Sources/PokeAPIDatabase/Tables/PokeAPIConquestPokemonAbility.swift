import StructuredQueries
import Tagged

// TODO: Add description for conquest_pokemon_abilities table
@Table("conquest_pokemon_abilities")
public struct PokeAPIConquestPokemonAbility: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_species_id
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

    // TODO: Add description for slot
    @Column("slot") public var slot: Int

    // TODO: Add description for ability_id
    @Column("ability_id") public var abilityId: PokeAPIAbility.ID

}