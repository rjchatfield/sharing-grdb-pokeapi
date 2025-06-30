import StructuredQueries
import Tagged

// TODO: Add description for pokeathlon_stats table
@Table("pokeathlon_stats")
public struct PokeAPIPokeathlonStat: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

}