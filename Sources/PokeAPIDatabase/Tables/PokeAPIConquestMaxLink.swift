import StructuredQueries
import Tagged

/// Maximum bond levels that can be achieved between specific warrior ranks and Pokemon species.
/// The link system in Pokemon Conquest determines combat effectiveness and evolution possibilities.
/// Higher link levels unlock better stats, special abilities, and transformation opportunities.
@Table("conquest_max_links")
public struct PokeAPIConquestMaxLink: Decodable, Hashable, Sendable {

    /// The warrior rank for this maximum link relationship
    /// Different ranks of the same warrior may have different max links
    @Column("warrior_rank_id") public var warriorRankId: PokeAPIConquestWarriorRank.ID

    /// The Pokemon species this max link applies to
    /// Each species has different compatibility with each warrior
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

    /// The maximum link level achievable between this warrior rank and Pokemon species
    /// Higher values indicate better compatibility and stronger bonds
    @Column("max_link") public var maxLink: Int

}