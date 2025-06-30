import StructuredQueries
import Tagged

/// Represents different visual forms and variants of Pokemon.
/// This includes alternate forms, regional variants, mega evolutions, and cosmetic differences.
/// Each Pokemon has at least one default form, with additional forms for variants.
@Table("pokemon_forms")
public struct PokeAPIPokemonForm: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this Pokemon form
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable form name (e.g., "pikachu", "charizard-mega-x")
    @Column("identifier") public var identifier: Identifier

    /// Specific form variant name (e.g., "mega-x", "alola", "gmax")
    /// Nil for default forms
    @Column("form_identifier") public var formIdentifier: String?

    /// References the base Pokemon that this form belongs to
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    /// Version group in which this form was first introduced
    @Column("introduced_in_version_group_id") public var introducedInVersionGroupId: PokeAPIVersionGroup.ID

    /// Whether this is the default/standard form for the Pokemon
    /// Every Pokemon has exactly one default form
    @Column("is_default") public var isDefault: Bool

    /// Whether this form only appears during battle
    /// True for forms like Mega Evolutions, Primal Reversions
    @Column("is_battle_only") public var isBattleOnly: Bool

    /// Whether this form is a Mega Evolution
    /// Mega Evolutions are temporary transformations during battle
    @Column("is_mega") public var isMega: Bool

    /// Sort order within this Pokemon's forms (1-based)
    /// Used to determine display order of multiple forms
    @Column("form_order") public var formOrder: Int

    /// Global sort order across all Pokemon forms
    /// Used for consistent ordering in the complete form list
    @Column("order") public var order: Int

}
