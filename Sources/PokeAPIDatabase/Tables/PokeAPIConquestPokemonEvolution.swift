import StructuredQueries
import Tagged

/// Pokemon evolution requirements specific to Pokemon Conquest's unique evolution system.
/// Unlike main series games, Conquest evolution depends on warrior bonds, stats, and kingdom locations.
/// Each Pokemon species may have different evolution conditions in the tactical RPG setting.
@Table("conquest_pokemon_evolution")
public struct PokeAPIConquestPokemonEvolution: Decodable, Hashable, Sendable {

    /// The Pokemon species that results from this evolution
    /// Points to the evolved form of the Pokemon
    @Column("evolved_species_id") public var evolvedSpeciesId: PokeAPIPokemonSpecy.ID

    /// The specific stat that must meet minimum requirements
    /// Different evolutions may require different stats to be high enough
    @Column("required_stat_id") public var requiredStatId: PokeAPIConquestStat.ID?

    /// Minimum value required for the specified stat
    /// The Pokemon must reach this stat threshold to evolve
    @Column("minimum_stat") public var minimumStat: Int?

    /// Minimum link level required between Pokemon and warrior
    /// Strong bonds are often necessary for evolution
    @Column("minimum_link") public var minimumLink: Int?

    /// Specific kingdom where this evolution can occur
    /// Some evolutions are location-dependent
    @Column("kingdom_id") public var kingdomId: PokeAPIConquestKingdom.ID?

    /// Required gender of the warrior partnered with this Pokemon
    /// Some evolutions depend on the warrior's gender
    @Column("warrior_gender_id") public var warriorGenderId: PokeAPIGender.ID?

    /// Item required for this evolution to occur
    /// Some evolutions need specific items like evolution stones
    @Column("item_id") public var itemId: PokeAPIItem.ID?

    /// Number of enemy Pokemon that must be defeated by recruiting
    /// Combat-based evolution requirement
    @Column("recruiting_ko_required") public var recruitingKoRequired: Int

}
