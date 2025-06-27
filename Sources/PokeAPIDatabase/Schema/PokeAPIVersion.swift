import StructuredQueries
import Tagged

/// Represents specific Pokemon game cartridges/titles within version groups.
/// Each version may have exclusive Pokemon, different encounter rates, or unique features
/// while sharing core mechanics with other versions in the same group.
@Table("versions")
public struct PokeAPIVersion: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique version identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable version name (e.g., "red", "blue", "gold", "silver", "diamond")
    /// Individual game cartridge or digital release identifier
    @Column("identifier") public var identifier: Identifier
    
    /// Version group this individual game belongs to
    /// Links related versions like Red/Blue or Diamond/Pearl together
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}

extension PokeAPIVersion.ID {
    // Generation I
    public static let red = PokeAPIVersion.ID(1)
    public static let blue = PokeAPIVersion.ID(2)
    public static let yellow = PokeAPIVersion.ID(3)
    // Generation II
    public static let gold = PokeAPIVersion.ID(4)
    public static let silver = PokeAPIVersion.ID(5)
    public static let crystal = PokeAPIVersion.ID(6)
    // Generation IIII
    public static let ruby = PokeAPIVersion.ID(7)
    public static let sapphire = PokeAPIVersion.ID(8)
    public static let emerald = PokeAPIVersion.ID(9)
    public static let fireRed = PokeAPIVersion.ID(10)
    public static let leafGreen = PokeAPIVersion.ID(11)
    // Generation IV
    public static let diamond = PokeAPIVersion.ID(12)
    public static let pearl = PokeAPIVersion.ID(13)
    public static let platinum = PokeAPIVersion.ID(14)
    public static let heartGold = PokeAPIVersion.ID(15)
    public static let soulSilver = PokeAPIVersion.ID(16)
    // Generation V
    public static let black = PokeAPIVersion.ID(17)
    public static let white = PokeAPIVersion.ID(18)
    public static let black2 = PokeAPIVersion.ID(21)
    public static let white2 = PokeAPIVersion.ID(22)
    // Generation VI
    public static let x = PokeAPIVersion.ID(23)
    public static let y = PokeAPIVersion.ID(24)
    public static let omegaRuby = PokeAPIVersion.ID(25)
    public static let alphaSapphire = PokeAPIVersion.ID(26)
    // Generation VII
    public static let sun = PokeAPIVersion.ID(27)
    public static let moon = PokeAPIVersion.ID(28)
    public static let ultraSun = PokeAPIVersion.ID(29)
    public static let ultraMoon = PokeAPIVersion.ID(30)
    public static let letsGoPikachu = PokeAPIVersion.ID(31)
    public static let letsGoEevee = PokeAPIVersion.ID(32)
    // Generation VIII
    public static let sword = PokeAPIVersion.ID(33)
    public static let shield = PokeAPIVersion.ID(34)
    public static let brilliantDiamond = PokeAPIVersion.ID(37)
    public static let shiningPearl = PokeAPIVersion.ID(38)
    public static let legendsArceus = PokeAPIVersion.ID(39)
    // Generation IX
    public static let scarlet = PokeAPIVersion.ID(40)
    public static let violet = PokeAPIVersion.ID(41)
}
