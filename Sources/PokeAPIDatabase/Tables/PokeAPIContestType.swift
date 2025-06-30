import StructuredQueries
import Tagged

/// Categories used in Pokemon Contests for move and Pokemon classification.
/// Each contest type represents a different aspect of Pokemon performance:
/// Cool, Beauty, Cute, Smart, and Tough categories from Gen 3+ contest systems.
@Table("contest_types")
public struct PokeAPIContestType: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this contest type
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable contest type name ("cool", "beauty", "cute", "smart", "tough")
    /// Used to categorize moves and Pokemon for contest performance
    @Column("identifier") public var identifier: Identifier

}