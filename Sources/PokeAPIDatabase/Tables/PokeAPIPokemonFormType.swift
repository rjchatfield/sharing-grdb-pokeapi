import StructuredQueries
import Tagged

/// Associates Pokemon forms with their elemental types.
/// Each form can have 1-2 types (primary and optional secondary type).
/// Form-specific type changes are tracked here (e.g., Rotom forms, regional variants).
@Table("pokemon_form_types")
public struct PokeAPIPokemonFormType: Decodable, Hashable, Sendable {

    /// References the specific Pokemon form that has this type
    @Column("pokemon_form_id") public var pokemonFormId: PokeAPIPokemonForm.ID

    /// The elemental type assigned to this form (Fire, Water, Grass, etc.)
    @Column("type_id") public var typeId: PokeAPIType.ID

    /// Type slot number: 1 for primary type, 2 for secondary type
    /// Single-type Pokemon only have slot 1
    @Column("slot") public var slot: Int

}