import StructuredQueries
import Tagged

// TODO: Add description for conquest_move_effects table
@Table("conquest_move_effects")
public struct PokeAPIConquestMoveEffect: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

}