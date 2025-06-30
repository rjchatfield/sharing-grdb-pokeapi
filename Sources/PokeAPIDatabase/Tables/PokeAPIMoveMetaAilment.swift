import StructuredQueries
import Tagged

// TODO: Add description for move_meta_ailments table
@Table("move_meta_ailments")
public struct PokeAPIMoveMetaAilment: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

}