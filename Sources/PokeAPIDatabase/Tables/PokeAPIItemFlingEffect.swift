import StructuredQueries
import Tagged

// TODO: Add description for item_fling_effects table
@Table("item_fling_effects")
public struct PokeAPIItemFlingEffect: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

}