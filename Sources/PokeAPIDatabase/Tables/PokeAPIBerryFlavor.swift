import StructuredQueries
import Tagged

/// Associates berries with their flavor profiles for different contest types.
/// Each berry has flavor values (spicy, dry, sweet, bitter, sour) that correspond
/// to contest categories and affect Pokemon preference and Poffin/Pokeblock creation.
@Table("berry_flavors")
public struct PokeAPIBerryFlavor: Decodable, Hashable, Sendable {

    /// References the berry that has this flavor profile
    @Column("berry_id") public var berryId: PokeAPIBerry.ID

    /// The contest type this flavor corresponds to (cool=spicy, beauty=dry, etc.)
    @Column("contest_type_id") public var contestTypeId: PokeAPIContestType.ID

    /// Intensity of this flavor in the berry (0-40+)
    /// Higher values provide more of this flavor for contest food preparation
    @Column("flavor") public var flavor: Int

}