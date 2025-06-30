import StructuredQueries
import Tagged

// TODO: Add description for conquest_move_displacements table
@Table("conquest_move_displacements")
public struct PokeAPIConquestMoveDisplacement: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

    // TODO: Add description for affects_target
    @Column("affects_target") public var affectsTarget: Int

}