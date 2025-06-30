import StructuredQueries
import Tagged

// TODO: Add description for move_meta table
@Table("move_meta")
public struct PokeAPIMoveMeta: Decodable, Hashable, Sendable {

    // TODO: Add description for move_id
    @Column("move_id") public var moveId: PokeAPIMove.ID

    // TODO: Add description for meta_category_id
    @Column("meta_category_id") public var metaCategoryId: PokeAPIMoveMetaCategory.ID

    // TODO: Add description for meta_ailment_id
    @Column("meta_ailment_id") public var metaAilmentId: PokeAPIMoveMetaAilment.ID

    // TODO: Add description for min_hits
    @Column("min_hits") public var minHits: Int?

    // TODO: Add description for max_hits
    @Column("max_hits") public var maxHits: Int?

    // TODO: Add description for min_turns
    @Column("min_turns") public var minTurns: Int?

    // TODO: Add description for max_turns
    @Column("max_turns") public var maxTurns: Int?

    // TODO: Add description for drain
    @Column("drain") public var drain: Int

    // TODO: Add description for healing
    @Column("healing") public var healing: Int

    // TODO: Add description for crit_rate
    @Column("crit_rate") public var critRate: Int

    // TODO: Add description for ailment_chance
    @Column("ailment_chance") public var ailmentChance: Int

    // TODO: Add description for flinch_chance
    @Column("flinch_chance") public var flinchChance: Int

    // TODO: Add description for stat_chance
    @Column("stat_chance") public var statChance: Int

}
