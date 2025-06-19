import SharingGRDB

/// Item category groupings.
@Table("item_categories")
public struct PokeAPIItemCategory: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("pocket_id") public var pocketId: Int
    @Column("identifier") public var identifier: String
}