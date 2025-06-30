import StructuredQueries
import Tagged

// TODO: Add description for location_game_indices table
@Table("location_game_indices")
public struct PokeAPILocationGameIndices: Decodable, Hashable, Sendable {

    // TODO: Add description for location_id
    @Column("location_id") public var locationId: PokeAPILocation.ID

    // TODO: Add description for generation_id
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    // TODO: Add description for game_index
    @Column("game_index") public var gameIndex: Int

}