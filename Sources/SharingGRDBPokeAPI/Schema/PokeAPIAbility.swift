import SharingGRDB

/// Ability definitions.
@Table("abilities")
public struct PokeAPIAbility: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
    @Column("generation_id") public var generationId: Int
    @Column("is_main_series") public var isMainSeries: Bool
}