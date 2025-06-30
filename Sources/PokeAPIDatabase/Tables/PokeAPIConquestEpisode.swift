import StructuredQueries
import Tagged

/// Story episodes and campaigns in Pokemon Conquest's narrative structure.
/// Each episode represents a different storyline or campaign with unique objectives,
/// available warriors, and progression requirements for the tactical RPG experience.
@Table("conquest_episodes")
public struct PokeAPIConquestEpisode: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this story episode
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable episode name (e.g., "the-legend-of-ransei", "the-tale-of-warriors")
    /// Identifies the specific campaign or storyline
    @Column("identifier") public var identifier: Identifier

}