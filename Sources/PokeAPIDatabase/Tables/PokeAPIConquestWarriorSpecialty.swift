import StructuredQueries
import Tagged

// TODO: Add description for conquest_warrior_specialties table
@Table("conquest_warrior_specialties")
public struct PokeAPIConquestWarriorSpecialty: Decodable, Hashable, Sendable {

    // TODO: Add description for warrior_id
    @Column("warrior_id") public var warriorId: PokeAPIConquestWarrior.ID

    // TODO: Add description for type_id
    @Column("type_id") public var typeId: PokeAPIType.ID

    // TODO: Add description for slot
    @Column("slot") public var slot: Int

}