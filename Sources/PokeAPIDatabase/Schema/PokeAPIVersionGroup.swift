import StructuredQueries
import Tagged

/// Groups related Pokemon game versions that share core mechanics and data.
/// Version groups typically include paired versions (Red/Blue) or sets of games
/// released together with similar features but different exclusive content.
@Table("version_groups")
public struct PokeAPIVersionGroup: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique version group identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable version group name (e.g., "red-blue", "gold-silver", "diamond-pearl")
    /// Represents collections of related game versions
    @Column("identifier") public var identifier: Identifier
    
    /// Generation this version group belongs to
    /// Links the games to their respective generation's Pokemon and mechanics
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID
    
    /// Release order within the generation
    /// Used for chronological sorting of version groups
    /// Range: 1-29
    @Column("order") public var order: Int

    // MARK: - Helpers

    public var formattedName: String {
        return identifier.capitalized.replacingOccurrences(of: "-", with: "/")
    }
}

extension PokeAPIVersionGroup.ID {
    // Generation I
    public static let redBlue = PokeAPIVersionGroup.ID(1)
    public static let yellow = PokeAPIVersionGroup.ID(2)
    public static let redGreenJapan = PokeAPIVersionGroup.ID(28)
    public static let blueJapan = PokeAPIVersionGroup.ID(29)
    // Generation II
    public static let goldSilver = PokeAPIVersionGroup.ID(3)
    public static let crystal = PokeAPIVersionGroup.ID(4)
    // Generation III
    public static let rubySapphire = PokeAPIVersionGroup.ID(5)
    public static let emerald = PokeAPIVersionGroup.ID(6)
    public static let fireRedLeafGreen = PokeAPIVersionGroup.ID(7)
    public static let colosseum = PokeAPIVersionGroup.ID(12)
    public static let xd = PokeAPIVersionGroup.ID(13)
    // Generation IV
    public static let diamondPearl = PokeAPIVersionGroup.ID(8)
    public static let platinum = PokeAPIVersionGroup.ID(9)
    public static let heartGoldSoulSilver = PokeAPIVersionGroup.ID(10)
    // Generation V
    public static let blackWhite = PokeAPIVersionGroup.ID(11)
    public static let black2white2 = PokeAPIVersionGroup.ID(14)
    // Generation VI
    public static let xY = PokeAPIVersionGroup.ID(15)
    public static let omegaRubyAlphaSapphire = PokeAPIVersionGroup.ID(16)
    // Generation VII
    public static let sunMoon = PokeAPIVersionGroup.ID(17)
    public static let ultraSunUltraMoon = PokeAPIVersionGroup.ID(18)
    public static let letsGoPikachuLetsGoEevee = PokeAPIVersionGroup.ID(19)
    // Generation VIII
    public static let swordShield = PokeAPIVersionGroup.ID(20)
    public static let theIsleOfArmor = PokeAPIVersionGroup.ID(21)
    public static let theCrownTundra = PokeAPIVersionGroup.ID(22)
    public static let brilliantDiamondShiningPearl = PokeAPIVersionGroup.ID(23)
    public static let legendsArceus = PokeAPIVersionGroup.ID(24)
    // Generation IX
    public static let scarletViolet = PokeAPIVersionGroup.ID(25)
}
