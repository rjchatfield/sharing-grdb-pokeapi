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
struct PokeAPIMoveFlavorSummariesTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveFlavorSummaries.count()
        ) {
            """
            SELECT count(*)
            FROM "move_flavor_summaries"
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
            PokeAPIMoveFlavorSummaries.limit(5)
        ) {
            """
            SELECT "move_flavor_summaries"."move_id", "move_flavor_summaries"."local_language_id", "move_flavor_summaries"."flavor_summary"
            FROM "move_flavor_summaries"
            LIMIT 5
            """
        }
        // CSV was empty
    }
}
