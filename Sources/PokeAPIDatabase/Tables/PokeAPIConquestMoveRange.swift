import StructuredQueries
import Tagged

// TODO: Add description for conquest_move_ranges table
@Table("conquest_move_ranges")
public struct PokeAPIConquestMoveRange: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

    // TODO: Add description for targets
    @Column("targets") public var targets: Int

}