import SharingGRDB

/// Evolution requirements and triggers.
@Table("pokemon_evolution")
public struct PokeAPIPokemonEvolution: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("evolved_species_id") public var evolvedSpeciesId: Int
    @Column("evolution_trigger_id") public var evolutionTriggerId: Int
    @Column("trigger_item_id") public var triggerItemId: Int?
    @Column("minimum_level") public var minimumLevel: String?
    @Column("gender_id") public var genderId: Int?
    @Column("location_id") public var locationId: Int?
    @Column("held_item_id") public var heldItemId: Int?
    @Column("time_of_day") public var timeOfDay: String?
    @Column("known_move_id") public var knownMoveId: Int?
    @Column("known_move_type_id") public var knownMoveTypeId: Int?
    @Column("minimum_happiness") public var minimumHappiness: String?
    @Column("minimum_beauty") public var minimumBeauty: String?
    @Column("minimum_affection") public var minimumAffection: String?
    @Column("relative_physical_stats") public var relativePhysicalStats: String?
    @Column("party_species_id") public var partySpeciesId: Int?
    @Column("party_type_id") public var partyTypeId: Int?
    @Column("trade_species_id") public var tradeSpeciesId: Int?
    @Column("needs_overworld_rain") public var needsOverworldRain: Bool
    @Column("turn_upside_down") public var turnUpsideDown: String?
}