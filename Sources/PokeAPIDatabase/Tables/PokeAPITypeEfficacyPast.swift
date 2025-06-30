import StructuredQueries
import Tagged

// TODO: Add description for type_efficacy_past table
@Table("type_efficacy_past")
public struct PokeAPITypeEfficacyPast: Decodable, Hashable, Sendable {

    // TODO: Add description for damage_type_id
    @Column("damage_type_id") public var damageTypeId: PokeAPIType.ID

    // TODO: Add description for target_type_id
    @Column("target_type_id") public var targetTypeId: PokeAPIType.ID

    // TODO: Add description for damage_factor
    @Column("damage_factor") public var damageFactor: Int

    // TODO: Add description for generation_id
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

}