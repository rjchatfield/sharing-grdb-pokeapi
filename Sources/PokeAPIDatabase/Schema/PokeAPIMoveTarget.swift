import StructuredQueries

/// Defines what a move can target in battle scenarios.
/// Determines whether moves affect single Pokemon, multiple Pokemon,
/// the user itself, or have other special targeting behaviors.
@Table("move_targets")
public struct PokeAPIMoveTarget: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int
    public typealias Identifier = String

    /// Unique move target identifier
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable target type (e.g., "selected-pokemon", "all-opponents", "user")
    /// Examples: single enemy, all enemies, all allies, self, random enemy, entire field
    @Column("identifier") public var identifier: Identifier

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
