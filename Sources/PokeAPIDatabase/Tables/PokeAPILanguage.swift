import StructuredQueries
import Tagged

/// Represents a language used for localized text in the Pokémon database.
/// Contains ISO language codes and regional information for proper internationalization.
@Table("languages")
public struct PokeAPILanguage: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this language.
    @Column("id", primaryKey: true) public var id: ID

    /// The ISO 639-1 language code (e.g., "en" for English, "ja" for Japanese).
    @Column("iso639") public var iso639: String

    /// The ISO 3166-1 country code (e.g., "us" for United States, "jp" for Japan).
    @Column("iso3166") public var iso3166: String

    /// A unique string identifier for this language, often combining language and script information.
    @Column("identifier") public var identifier: Identifier

    /// Indicates whether this is an official language for the Pokémon franchise (1 for official, 0 for unofficial).
    @Column("official") public var official: Int

    /// The display order for this language when listed in user interfaces.
    @Column("order") public var order: Int

}