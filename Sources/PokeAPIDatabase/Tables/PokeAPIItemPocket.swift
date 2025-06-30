import StructuredQueries
import Tagged

// TODO: Add description for item_pockets table
@Table("item_pockets")
public struct PokeAPIItemPocket: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

}