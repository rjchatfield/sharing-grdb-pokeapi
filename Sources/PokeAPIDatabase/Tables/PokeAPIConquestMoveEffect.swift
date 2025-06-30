import StructuredQueries
import Tagged

/// Special effects that moves can have in Pokemon Conquest battles.
/// These effects are adapted for the tactical combat system and may include
/// stat changes, status conditions, or battlefield manipulation effects.
@Table("conquest_move_effects")
public struct PokeAPIConquestMoveEffect: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    /// The primary key identifier for this Conquest move effect
    @Column("id", primaryKey: true) public var id: ID

}