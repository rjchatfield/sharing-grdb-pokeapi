import StructuredQueries
import Tagged

// TODO: Add description for move_meta_categories table
@Table("move_meta_categories")
public struct PokeAPIMoveMetaCategory: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

}