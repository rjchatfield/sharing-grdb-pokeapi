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
struct PokeAPIMoveDamageClassTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveDamageClass.count()
        ) {
            """
            SELECT count(*)
            FROM "move_damage_classes"
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
            PokeAPIMoveDamageClass.limit(5)
        ) {
            """
            SELECT "move_damage_classes"."id", "move_damage_classes"."identifier"
            FROM "move_damage_classes"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIMoveDamageClass(    │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "status"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIMoveDamageClass(    │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "physical"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIMoveDamageClass(    │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "special"    │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}
