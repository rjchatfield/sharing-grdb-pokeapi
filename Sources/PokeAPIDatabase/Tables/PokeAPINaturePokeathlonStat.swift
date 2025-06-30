import StructuredQueries
import Tagged

// TODO: Add description for nature_pokeathlon_stats table
@Table("nature_pokeathlon_stats")
public struct PokeAPINaturePokeathlonStat: Decodable, Hashable, Sendable {

    // TODO: Add description for nature_id
    @Column("nature_id") public var natureId: PokeAPINature.ID

    // TODO: Add description for pokeathlon_stat_id
    @Column("pokeathlon_stat_id") public var pokeathlonStatId: PokeAPIPokeathlonStat.ID

    // TODO: Add description for max_change
    @Column("max_change") public var maxChange: Int

}