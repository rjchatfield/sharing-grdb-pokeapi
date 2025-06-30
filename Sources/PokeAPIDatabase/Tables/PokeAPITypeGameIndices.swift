import StructuredQueries
import Tagged

// TODO: Add description for type_game_indices table
@Table("type_game_indices")
public struct PokeAPITypeGameIndices: Decodable, Hashable, Sendable {

    // TODO: Add description for type_id
    @Column("type_id") public var typeId: PokeAPIType.ID

    // TODO: Add description for generation_id
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    // TODO: Add description for game_index
    @Column("game_index") public var gameIndex: Int

}