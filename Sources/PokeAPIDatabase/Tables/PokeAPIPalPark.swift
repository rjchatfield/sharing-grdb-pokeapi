import StructuredQueries
import Tagged

// TODO: Add description for pal_park table
@Table("pal_park")
public struct PokeAPIPalPark: Decodable, Hashable, Sendable {

    // TODO: Add description for species_id
    @Column("species_id") public var speciesId: PokeAPIPokemonSpecy.ID

    // TODO: Add description for area_id
    @Column("area_id") public var areaId: PokeAPIPalParkArea.ID

    // TODO: Add description for base_score
    @Column("base_score") public var baseScore: Int

    // TODO: Add description for rate
    @Column("rate") public var rate: Int

}