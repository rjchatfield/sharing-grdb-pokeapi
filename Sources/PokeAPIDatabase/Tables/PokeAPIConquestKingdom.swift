import StructuredQueries
import Tagged

// TODO: Add description for conquest_kingdoms table
@Table("conquest_kingdoms")
public struct PokeAPIConquestKingdom: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

    // TODO: Add description for type_id
    @Column("type_id") public var typeId: PokeAPIType.ID

}