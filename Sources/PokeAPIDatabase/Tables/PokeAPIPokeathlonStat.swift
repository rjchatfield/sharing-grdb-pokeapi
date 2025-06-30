import StructuredQueries
import Tagged

/// Performance statistics used in the Pokeathlon mini-game from HeartGold/SoulSilver.
/// Defines the five athletic categories: Speed, Power, Technique, Stamina, and Jump
/// that determine Pokemon performance in various Pokeathlon events.
@Table("pokeathlon_stats")
public struct PokeAPIPokeathlonStat: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this Pokeathlon statistic
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable stat name ("speed", "power", "technique", "stamina", "jump")
    /// Used for Pokeathlon event performance calculations
    @Column("identifier") public var identifier: Identifier

}