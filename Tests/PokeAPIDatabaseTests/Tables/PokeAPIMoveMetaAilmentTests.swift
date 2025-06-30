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
struct PokeAPIMoveMetaAilmentTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveMetaAilment.count()
        ) {
            """
            SELECT count(*)
            FROM "move_meta_ailments"
            """
        } results: {
            """
            ┌────┐
            │ 22 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIMoveMetaAilment.limit(5)
        ) {
            """
            SELECT "move_meta_ailments"."id", "move_meta_ailments"."identifier"
            FROM "move_meta_ailments"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────┐
            │ PokeAPIMoveMetaAilment(     │
            │   id: Tagged(rawValue: -1), │
            │   identifier: "unknown"     │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIMoveMetaAilment(     │
            │   id: Tagged(rawValue: 0),  │
            │   identifier: "none"        │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIMoveMetaAilment(     │
            │   id: Tagged(rawValue: 1),  │
            │   identifier: "paralysis"   │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIMoveMetaAilment(     │
            │   id: Tagged(rawValue: 2),  │
            │   identifier: "sleep"       │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIMoveMetaAilment(     │
            │   id: Tagged(rawValue: 3),  │
            │   identifier: "freeze"      │
            │ )                           │
            └─────────────────────────────┘
            """
        }
    }
}