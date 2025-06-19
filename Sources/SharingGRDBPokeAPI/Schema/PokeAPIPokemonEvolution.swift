import SharingGRDB

/// Defines the specific conditions required for Pokemon to evolve.
/// Pokemon can evolve through various methods: leveling up, using items,
/// trading, friendship, location, time of day, and many other complex conditions.
@Table("pokemon_evolution")
public struct PokeAPIPokemonEvolution: Decodable, Hashable, Identifiable, Sendable {
    /// Unique evolution record identifier
    @Column("id", primaryKey: true) public var id: Int
    
    /// Species that results from this evolution
    @Column("evolved_species_id") public var evolvedSpeciesId: Int
    
    /// Primary evolution method (level-up, use-item, trade, etc.)
    @Column("evolution_trigger_id") public var evolutionTriggerId: Int
    
    /// Item required to trigger evolution (evolution stones, etc.)
    /// Nil if no item is required
    @Column("trigger_item_id") public var triggerItemId: Int?
    
    /// Minimum level required for evolution
    /// Nil if level is not a requirement
    @Column("minimum_level") public var minimumLevel: String?
    
    /// Required gender for evolution (male/female specific evolutions)
    /// Nil if gender doesn't matter
    @Column("gender_id") public var genderId: Int?
    
    /// Specific location where evolution must occur
    /// Nil if location doesn't matter
    @Column("location_id") public var locationId: Int?
    
    /// Item the Pokemon must be holding during evolution
    /// Nil if no held item is required
    @Column("held_item_id") public var heldItemId: Int?
    
    /// Time of day required for evolution ("day", "night")
    /// Nil if time doesn't matter
    @Column("time_of_day") public var timeOfDay: String?
    
    /// Specific move the Pokemon must know to evolve
    /// Nil if no specific move is required
    @Column("known_move_id") public var knownMoveId: Int?
    
    /// Type of move the Pokemon must know to evolve
    /// Nil if no specific move type is required
    @Column("known_move_type_id") public var knownMoveTypeId: Int?
    
    /// Minimum friendship/happiness level required
    /// Nil if happiness is not a factor
    @Column("minimum_happiness") public var minimumHappiness: String?
    
    /// Minimum beauty condition level required (Gen III contests)
    /// Nil if beauty is not a factor
    @Column("minimum_beauty") public var minimumBeauty: String?
    
    /// Minimum affection level required (Pokemon-Amie/Refresh)
    /// Nil if affection is not a factor
    @Column("minimum_affection") public var minimumAffection: String?
    
    /// Attack vs Defense stat comparison requirement
    /// Nil if stat comparison is not needed
    @Column("relative_physical_stats") public var relativePhysicalStats: String?
    
    /// Specific Pokemon species required in party for evolution
    /// Nil if no party member is required
    @Column("party_species_id") public var partySpeciesId: Int?
    
    /// Specific Pokemon type required in party for evolution
    /// Nil if no party type is required
    @Column("party_type_id") public var partyTypeId: Int?
    
    /// Specific species required as trade partner
    /// Nil for non-trade-specific evolutions
    @Column("trade_species_id") public var tradeSpeciesId: Int?
    
    /// Whether it must be raining in the overworld
    @Column("needs_overworld_rain") public var needsOverworldRain: Bool
    
    /// Whether game system must be turned upside down (Inkay -> Malamar)
    /// Nil if orientation doesn't matter
    @Column("turn_upside_down") public var turnUpsideDown: String?
}
