import StructuredQueries
import Tagged

// TODO: Add description for conquest_stats table
@Table("conquest_stats")
public struct PokeAPIConquestStat: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

    // TODO: Add description for is_base
    @Column("is_base") public var isBase: Int

}