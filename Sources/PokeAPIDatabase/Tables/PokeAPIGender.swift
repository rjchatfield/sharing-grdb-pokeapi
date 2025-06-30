import StructuredQueries
import Tagged

/// Represents the gender classification for Pokémon species.
/// Includes female, male, and genderless categories used throughout the Pokémon database.
@Table("genders")
public struct PokeAPIGender: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this gender.
    @Column("id", primaryKey: true) public var id: ID

    /// A unique string identifier for this gender (e.g., "female", "male", "genderless").
    @Column("identifier") public var identifier: Identifier

}