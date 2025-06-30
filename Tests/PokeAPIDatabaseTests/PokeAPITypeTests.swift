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
struct PokeAPITypeTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIType.count()
        ) {
            """
            SELECT count(*)
            FROM "types"
            """
        } results: {
            """
            ┌────┐
            │ 21 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIType.limit(5)
        ) {
            """
            SELECT "types"."id", "types"."identifier", "types"."generation_id", "types"."damage_class_id"
            FROM "types"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 1),           │
            │   identifier: "normal",              │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 2),           │
            │   identifier: "fighting",            │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 3),           │
            │   identifier: "flying",              │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 4),           │
            │   identifier: "poison",              │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 5),           │
            │   identifier: "ground",              │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
}
