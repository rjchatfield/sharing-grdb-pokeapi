import StructuredQueries
import Tagged

/// Warriors involved in transformation relationships in Pokemon Conquest.
/// Links warrior transformations to the specific warriors that must be present
/// or involved for the transformation conditions to be met.
@Table("conquest_transformation_warriors")
public struct PokeAPIConquestTransformationWarrior: Decodable, Hashable, Sendable {

    /// References the transformation this warrior requirement applies to
    /// Links to a specific warrior transformation condition
    @Column("transformation_id") public var transformationId: Int

    /// The warrior that must be present for this transformation
    /// Some transformations require specific warriors to be in the army
    @Column("present_warrior_id") public var presentWarriorId: PokeAPIConquestWarrior.ID

}