import StructuredQueries
import Tagged

// TODO: Add description for item_game_indices table
@Table("item_game_indices")
public struct PokeAPIItemGameIndices: Decodable, Hashable, Sendable {

    // TODO: Add description for item_id
    @Column("item_id") public var itemId: PokeAPIItem.ID

    // TODO: Add description for generation_id
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    // TODO: Add description for game_index
    @Column("game_index") public var gameIndex: Int

}