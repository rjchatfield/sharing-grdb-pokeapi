import StructuredQueries
import Tagged

// TODO: Add description for item_flavor_summaries table
@Table("item_flavor_summaries")
public struct PokeAPIItemFlavorSummaries: Decodable, Hashable, Sendable {

    // TODO: Add description for item_id
    @Column("item_id") public var itemId: PokeAPIItem.ID

    // TODO: Add description for local_language_id
    @Column("local_language_id") public var localLanguageId: PokeAPILanguage.ID

    // TODO: Add description for flavor_summary
    @Column("flavor_summary") public var flavorSummary: String

}