import StructuredQueries
import Tagged

/// Kingdoms in the Ransei region from Pokemon Conquest.
/// Each kingdom has a specific Pokemon type specialty and serves as a territorial unit in the game.
/// Kingdoms are conquered through battles and serve as strategic strongholds for army expansion.
@Table("conquest_kingdoms")
public struct PokeAPIConquestKingdom: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this kingdom
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable kingdom name (e.g., "aurora", "chrysalia", "fontaine")
    /// Based on the kingdom's characteristics and specialization
    @Column("identifier") public var identifier: Identifier

    /// The Pokemon type this kingdom specializes in
    /// Determines the kingdom's theme, resident Pokemon, and strategic bonuses
    @Column("type_id") public var typeId: PokeAPIType.ID

}