import StructuredQueries
import Tagged

// TODO: Add description for languages table
@Table("languages")
public struct PokeAPILanguage: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for iso639
    @Column("iso639") public var iso639: String

    // TODO: Add description for iso3166
    @Column("iso3166") public var iso3166: String

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

    // TODO: Add description for official
    @Column("official") public var official: Int

    // TODO: Add description for order
    @Column("order") public var order: Int

}