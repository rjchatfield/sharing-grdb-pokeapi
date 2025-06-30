import StructuredQueries
import Tagged

/// Maps Pokemon types to their game-specific index numbers across generations.
/// Types may have different internal indices in different generations
/// due to type system changes and additions over time.
@Table("type_game_indices")
public struct PokeAPITypeGameIndices: Decodable, Hashable, Sendable {

    /// References the type that has this generation-specific index
    @Column("type_id") public var typeId: PokeAPIType.ID

    /// The generation in which this type index applies
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    /// The type's internal index number in this generation
    /// Used for game mechanics and type effectiveness calculations
    @Column("game_index") public var gameIndex: Int

}