import StructuredQueries
import Tagged

// TODO: Add description for conquest_warrior_transformation table
@Table("conquest_warrior_transformation")
public struct PokeAPIConquestWarriorTransformation: Decodable, Hashable, Sendable {

    // TODO: Add description for transformed_warrior_rank_id
    @Column("transformed_warrior_rank_id") public var transformedWarriorRankId: PokeAPIConquestWarriorRank.ID

    // TODO: Add description for is_automatic
    @Column("is_automatic") public var isAutomatic: Int

    // TODO: Add description for required_link
    @Column("required_link") public var requiredLink: Int?

    // TODO: Add description for completed_episode_id
    @Column("completed_episode_id") public var completedEpisodeId: PokeAPIConquestEpisode.ID?

    // TODO: Add description for current_episode_id
    @Column("current_episode_id") public var currentEpisodeId: PokeAPIConquestEpisode.ID?

    // TODO: Add description for distant_warrior_id
    @Column("distant_warrior_id") public var distantWarriorId: PokeAPIConquestWarrior.ID?

    // TODO: Add description for female_warlord_count
    @Column("female_warlord_count") public var femaleWarlordCount: Int?

    // TODO: Add description for pokemon_count
    @Column("pokemon_count") public var pokemonCount: Int?

    // TODO: Add description for collection_type_id
    @Column("collection_type_id") public var collectionTypeId: Int?

    // TODO: Add description for warrior_count
    @Column("warrior_count") public var warriorCount: Int?

}
