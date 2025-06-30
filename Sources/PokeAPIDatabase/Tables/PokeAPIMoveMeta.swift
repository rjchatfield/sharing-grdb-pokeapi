import StructuredQueries
import Tagged

/// Contains detailed battle mechanics and effect metadata for moves.
/// This includes information about multi-hit moves, status effects, healing,
/// critical hit rates, and various battle-specific parameters.
@Table("move_meta")
public struct PokeAPIMoveMeta: Decodable, Hashable, Sendable {

    /// References the move that this metadata applies to
    @Column("move_id") public var moveId: PokeAPIMove.ID

    /// The move's meta category (damage, ailment, net-good-stats, etc.)
    /// Categorizes the move's primary battle effect
    @Column("meta_category_id") public var metaCategoryId: PokeAPIMoveMetaCategory.ID

    /// The status ailment this move can inflict (paralysis, burn, poison, etc.)
    /// References the specific ailment type
    @Column("meta_ailment_id") public var metaAilmentId: PokeAPIMoveMetaAilment.ID

    /// Minimum number of hits for multi-hit moves
    /// Nil for single-hit moves (e.g., Double Slap: 2, Fury Attack: 2)
    @Column("min_hits") public var minHits: Int?

    /// Maximum number of hits for multi-hit moves
    /// Nil for single-hit moves (e.g., Double Slap: 5, Fury Attack: 5)
    @Column("max_hits") public var maxHits: Int?

    /// Minimum duration in turns for moves with variable duration
    /// Used for moves like Thrash, Outrage, Sleep Talk
    @Column("min_turns") public var minTurns: Int?

    /// Maximum duration in turns for moves with variable duration
    /// Used for moves like Thrash, Outrage, Sleep Talk
    @Column("max_turns") public var maxTurns: Int?

    /// Percentage of damage dealt that is recovered as HP (negative values)
    /// Used for draining moves like Absorb, Giga Drain (typically -50 to -75)
    @Column("drain") public var drain: Int

    /// Percentage of user's max HP restored by healing moves
    /// Used for moves like Recover (50), Rest (100), Roost (50)
    @Column("healing") public var healing: Int

    /// Critical hit rate modifier (0 = normal, 1 = high crit ratio)
    /// Moves like Slash, Razor Leaf have crit_rate = 1
    @Column("crit_rate") public var critRate: Int

    /// Percentage chance of inflicting the associated ailment (0-100)
    /// Used for moves with status effect chances (e.g., Thunder has 10% paralysis)
    @Column("ailment_chance") public var ailmentChance: Int

    /// Percentage chance of causing the target to flinch (0-100)
    /// Flinching prevents the target from acting this turn
    @Column("flinch_chance") public var flinchChance: Int

    /// Percentage chance of the move's stat changes occurring (0-100)
    /// For moves that may or may not apply stat modifications
    @Column("stat_chance") public var statChance: Int

}
