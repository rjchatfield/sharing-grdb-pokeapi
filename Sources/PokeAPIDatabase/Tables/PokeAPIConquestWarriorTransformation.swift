import StructuredQueries
import Tagged

/// Warrior transformation requirements and conditions in Pokemon Conquest.
/// Warriors can evolve/transform into higher ranks under specific conditions.
/// These transformations unlock new abilities, stats, and sometimes change appearance.
@Table("conquest_warrior_transformation")
public struct PokeAPIConquestWarriorTransformation: Decodable, Hashable, Sendable {

    /// The warrior rank that results from this transformation
    /// Points to the evolved/transformed form of the warrior
    @Column("transformed_warrior_rank_id") public var transformedWarriorRankId: PokeAPIConquestWarriorRank.ID

    /// Whether this transformation happens automatically when conditions are met
    /// If false, transformation requires manual triggering
    @Column("is_automatic") public var isAutomatic: Bool

    /// Minimum link level required with a Pokemon to unlock this transformation
    /// Higher transformations often require strong bonds with Pokemon
    @Column("required_link") public var requiredLink: Int?

    /// Episode that must be completed before this transformation is available
    /// Story progression requirement for transformation
    @Column("completed_episode_id") public var completedEpisodeId: PokeAPIConquestEpisode.ID?

    /// Episode that must be currently active for this transformation
    /// Some transformations are episode-specific
    @Column("current_episode_id") public var currentEpisodeId: PokeAPIConquestEpisode.ID?

    /// Specific distant warrior that must be encountered or defeated
    /// Some transformations require interaction with particular warriors
    @Column("distant_warrior_id") public var distantWarriorId: PokeAPIConquestWarrior.ID?

    /// Required number of female warlords in the player's army
    /// Gender-based transformation requirement
    @Column("female_warlord_count") public var femaleWarlordCount: Int?

    /// Required number of Pokemon in the player's collection
    /// Collection-based transformation requirement
    @Column("pokemon_count") public var pokemonCount: Int?

    /// Specific type of Pokemon collection required
    /// May require collecting certain types or rarities of Pokemon
    @Column("collection_type_id") public var collectionTypeId: Int?

    /// Required number of warriors in the player's army
    /// Army size requirement for transformation
    @Column("warrior_count") public var warriorCount: Int?

}
