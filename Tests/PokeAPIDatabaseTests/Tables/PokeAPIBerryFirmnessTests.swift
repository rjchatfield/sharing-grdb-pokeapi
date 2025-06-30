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
struct PokeAPIBerryFirmnessTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIBerryFirmness.count()
        ) {
            """
            SELECT count(*)
            FROM "berry_firmness"
            """
        } results: {
            """
            ┌───┐
            │ 5 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIBerryFirmness.limit(5)
        ) {
            """
            SELECT "berry_firmness"."id", "berry_firmness"."identifier"
            FROM "berry_firmness"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIBerryFirmness(      │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "very-soft"  │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIBerryFirmness(      │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "soft"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIBerryFirmness(      │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "hard"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIBerryFirmness(      │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "very-hard"  │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIBerryFirmness(      │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "super-hard" │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}