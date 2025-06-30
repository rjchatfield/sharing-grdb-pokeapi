import StructuredQueries
import Tagged

/// Warriors that appear in specific episodes of Pokemon Conquest's story campaigns.
/// Each episode features different warriors as allies, enemies, or neutral characters.
/// This system controls narrative progression and character availability across different storylines.
@Table("conquest_episode_warriors")
public struct PokeAPIConquestEpisodeWarrior: Decodable, Hashable, Sendable {

    /// The story episode this warrior appears in
    /// Links to specific campaign or storyline segments
    @Column("episode_id") public var episodeId: PokeAPIConquestEpisode.ID

    /// The warrior that appears in this episode
    /// Determines which characters are available during this part of the story
    @Column("warrior_id") public var warriorId: PokeAPIConquestWarrior.ID

}