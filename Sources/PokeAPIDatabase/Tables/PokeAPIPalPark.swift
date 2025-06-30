import StructuredQueries
import Tagged

/// Defines which Pokemon species can be found in specific Pal Park areas.
/// Contains the encounter rate and scoring information for each species-area combination.
/// Used for transferring Pokemon from GBA games to Diamond/Pearl/Platinum.
@Table("pal_park")
public struct PokeAPIPalPark: Decodable, Hashable, Sendable {

    /// Reference to the Pokemon species that can be found in this area
    @Column("species_id") public var speciesId: PokeAPIPokemonSpecy.ID

    /// Reference to the Pal Park area where this species can be found
    @Column("area_id") public var areaId: PokeAPIPalParkArea.ID

    /// Base score awarded for catching this species in Pal Park
    /// Used in the Pal Park catching mini-game scoring system
    @Column("base_score") public var baseScore: Int

    /// Encounter rate for this species in this area
    /// Higher values indicate more common encounters
    @Column("rate") public var rate: Int

}