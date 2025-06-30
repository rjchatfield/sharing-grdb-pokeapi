import StructuredQueries
import Tagged

/// Represents different battle styles or categories that moves can be classified into.
/// Battle styles categorize moves based on their tactical use in battle,
/// such as attack, defense, or support roles.
@Table("move_battle_styles")
public struct PokeAPIMoveBattleStyle: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for the battle style
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable identifier for the battle style (e.g., "attack", "defense", "support")
    @Column("identifier") public var identifier: Identifier

}