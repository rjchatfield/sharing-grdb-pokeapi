import StructuredQueries
import Tagged

/// Stat types used in Pokemon Conquest's tactical battle system.
/// These stats determine warrior and Pokemon combat effectiveness.
/// Unlike main series games, Conquest uses a simplified stat system focused on tactical combat.
@Table("conquest_warrior_stats")
public struct PokeAPIConquestWarriorStat: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this Conquest warrior stat type
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable stat name (e.g., "attack", "defense", "speed", "range")
    /// Conquest uses simplified stats compared to main series: Attack, Defense, Speed, Range, and Health
    @Column("identifier") public var identifier: Identifier

}