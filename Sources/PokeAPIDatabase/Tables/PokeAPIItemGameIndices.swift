import StructuredQueries
import Tagged

/// Game-specific indices for items across different generations.
/// Each item may have different internal ID numbers in different game generations,
/// this table maps the universal item ID to generation-specific indices.
@Table("item_game_indices")
public struct PokeAPIItemGameIndices: Decodable, Hashable, Sendable {

    /// Reference to the universal item
    /// Links to the items table
    @Column("item_id") public var itemId: PokeAPIItem.ID

    /// The generation this game index applies to
    /// References the generations table
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    /// The internal item ID used within this specific generation's games
    /// Different generations may use different numbering schemes
    /// Range: varies by generation
    @Column("game_index") public var gameIndex: Int

}