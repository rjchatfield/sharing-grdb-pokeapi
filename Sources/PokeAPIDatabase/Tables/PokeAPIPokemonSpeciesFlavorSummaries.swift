import StructuredQueries
import Tagged

// TODO: Add description for pokemon_species_flavor_summaries table
@Table("pokemon_species_flavor_summaries")
public struct PokeAPIPokemonSpeciesFlavorSummaries: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_species_id
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

    // TODO: Add description for local_language_id
    @Column("local_language_id") public var localLanguageId: PokeAPILanguage.ID

    // TODO: Add description for flavor_summary
    @Column("flavor_summary") public var flavorSummary: String

}