import StructuredQueries
import Tagged

// TODO: Add description for conquest_episode_warriors table
@Table("conquest_episode_warriors")
public struct PokeAPIConquestEpisodeWarrior: Decodable, Hashable, Sendable {

    // TODO: Add description for episode_id
    @Column("episode_id") public var episodeId: PokeAPIConquestEpisode.ID

    // TODO: Add description for warrior_id
    @Column("warrior_id") public var warriorId: PokeAPIConquestWarrior.ID

}