import StructuredQueries
import Tagged

// TODO: Add description for move_flavor_summaries table
@Table("move_flavor_summaries")
public struct PokeAPIMoveFlavorSummaries: Decodable, Hashable, Sendable {

    // TODO: Add description for move_id
    @Column("move_id") public var moveId: PokeAPIMove.ID

    // TODO: Add description for local_language_id
    @Column("local_language_id") public var localLanguageId: PokeAPILanguage.ID

    // TODO: Add description for flavor_summary
    @Column("flavor_summary") public var flavorSummary: String

}