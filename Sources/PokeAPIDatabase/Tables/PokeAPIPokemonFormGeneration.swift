import StructuredQueries
import Tagged

/// Links Pokemon forms to the generations in which they appear.
/// Tracks which forms are available in each generation and their game-specific index numbers.
/// Essential for determining form availability across different Pokemon games.
@Table("pokemon_form_generations")
public struct PokeAPIPokemonFormGeneration: Decodable, Hashable, Sendable {

    /// Foreign key to the Pokemon form that appears in this generation
    @Column("pokemon_form_id") public var pokemonFormId: PokeAPIPokemonForm.ID

    /// Foreign key to the generation in which this form is available
    /// Determines game compatibility and form accessibility
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    /// Internal game index number for this form within the generation
    /// Used by game engines to reference and load specific Pokemon forms
    @Column("game_index") public var gameIndex: Int

}