import StructuredQueries
import Tagged

// TODO: Add description for conquest_transformation_warriors table
@Table("conquest_transformation_warriors")
public struct PokeAPIConquestTransformationWarrior: Decodable, Hashable, Sendable {

    // TODO: Add description for transformation_id
    @Column("transformation_id") public var transformationId: Int

    // TODO: Add description for present_warrior_id
    @Column("present_warrior_id") public var presentWarriorId: PokeAPIConquestWarrior.ID

}