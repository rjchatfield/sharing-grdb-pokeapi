import Testing
import StructuredQueries
import StructuredQueriesSQLite
import StructuredQueriesTestSupport
import SnapshotTesting
import InlineSnapshotTesting
import PokeAPIDatabase

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIPokemonSpeciesFlavorSummariesTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonSpeciesFlavorSummaries.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_species_flavor_summaries"
            """
        } results: {
            """
            ┌───┐
            │ 0 │
            └───┘
            """
        }
        // CSV was empty
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonSpeciesFlavorSummaries.limit(5)
        ) {
            """
            SELECT "pokemon_species_flavor_summaries"."pokemon_species_id", "pokemon_species_flavor_summaries"."local_language_id", "pokemon_species_flavor_summaries"."flavor_summary"
            FROM "pokemon_species_flavor_summaries"
            LIMIT 5
            """
        }
        // CSV was empty
    }
}
