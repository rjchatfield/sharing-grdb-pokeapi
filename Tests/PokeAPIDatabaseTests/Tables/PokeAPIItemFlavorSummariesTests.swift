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
struct PokeAPIItemFlavorSummariesTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIItemFlavorSummaries.count()
        ) {
            """
            SELECT count(*)
            FROM "item_flavor_summaries"
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
            PokeAPIItemFlavorSummaries.limit(5)
        ) {
            """
            SELECT "item_flavor_summaries"."item_id", "item_flavor_summaries"."local_language_id", "item_flavor_summaries"."flavor_summary"
            FROM "item_flavor_summaries"
            LIMIT 5
            """
        }
        // CSV was empty
    }
}
