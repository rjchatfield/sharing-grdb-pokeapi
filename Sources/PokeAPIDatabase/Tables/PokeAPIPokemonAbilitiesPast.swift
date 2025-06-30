import StructuredQueries
import Tagged

// TODO: Add description for pokemon_abilities_past table
@Table("pokemon_abilities_past")
public struct PokeAPIPokemonAbilitiesPast: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_id
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    // TODO: Add description for generation_id
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    // TODO: Add description for ability_id
    @Column("ability_id") public var abilityId: PokeAPIAbility.ID?

    // TODO: Add description for is_hidden
    @Column("is_hidden") public var isHidden: Bool

    // TODO: Add description for slot
    @Column("slot") public var slot: Int

}
