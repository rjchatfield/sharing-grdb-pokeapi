import StructuredQueries
import Tagged

/// Historical record of Pokemon type changes across different generations.
/// Tracks when Pokemon had different types in past generations before type retcons,
/// such as Magnemite/Magneton being pure Electric before Steel type was introduced.
@Table("pokemon_types_past")
public struct PokeAPIPokemonTypesPast: Decodable, Hashable, Sendable {

    /// Foreign key to the Pokemon that had a different type in the past
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    /// The generation in which this Pokemon had this historical type
    /// References the generation before type changes were made
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    /// The type this Pokemon had in the specified generation
    /// May differ from the Pokemon's current type due to retcons or additions
    @Column("type_id") public var typeId: PokeAPIType.ID

    /// The type slot position (1 for primary type, 2 for secondary type)
    /// Determines type ordering for dual-type Pokemon
    @Column("slot") public var slot: Int

}