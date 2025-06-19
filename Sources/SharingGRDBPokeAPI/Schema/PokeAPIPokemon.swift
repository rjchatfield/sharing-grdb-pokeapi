import SharingGRDB

/// Individual Pokemon forms and variants.
@Table("pokemon")
public struct PokeAPIPokemon: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
    @Column("species_id") public var speciesId: Int
    @Column("height") public var height: Int
    @Column("weight") public var weight: Int
    @Column("base_experience") public var baseExperience: Int?
    @Column("order") public var order: Int?
    @Column("is_default") public var isDefault: Bool
}
