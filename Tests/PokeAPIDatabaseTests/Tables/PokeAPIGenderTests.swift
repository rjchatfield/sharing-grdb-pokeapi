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
struct PokeAPIGenderTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIGender.count()
        ) {
            """
            SELECT count(*)
            FROM "genders"
            """
        } results: {
            """
            ┌───┐
            │ 3 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIGender.limit(5)
        ) {
            """
            SELECT "genders"."id", "genders"."identifier"
            FROM "genders"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIGender(             │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "female"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIGender(             │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "male"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIGender(             │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "genderless" │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}