import SharingGRDB

/// Move definitions.
@Table("moves")
public struct PokeAPIMove: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
    @Column("generation_id") public var generationId: Int
    @Column("type_id") public var typeId: Int
    @Column("power") public var power: Int?
    @Column("pp") public var pp: Int?
    @Column("accuracy") public var accuracy: Int?
    @Column("priority") public var priority: Int
    @Column("target_id") public var targetId: Int
    @Column("damage_class_id") public var damageClassId: Int
    @Column("effect_id") public var effectId: Int
    @Column("effect_chance") public var effectChance: Int?
    @Column("contest_type_id") public var contestTypeId: Int?
    @Column("contest_effect_id") public var contestEffectId: Int?
    @Column("super_contest_effect_id") public var superContestEffectId: Int?
}