import StructuredQueries
import Tagged

/// Maps locations to their internal game indices in different generations.
/// Each game generation assigns numeric identifiers to locations for internal reference,
/// and these indices may vary between generations for the same location.
@Table("location_game_indices")
public struct PokeAPILocationGameIndices: Decodable, Hashable, Sendable {

    /// References the location this game index applies to
    /// Links to the location record with name and regional information
    @Column("location_id") public var locationId: PokeAPILocation.ID

    /// References the generation where this game index is used
    /// Different generations may assign different indices to the same location
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    /// The numeric identifier used internally by the games for this location
    /// Used for save data, map transitions, and other internal game mechanics
    @Column("game_index") public var gameIndex: Int

}