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
struct PokeAPIItemFlingEffectTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIItemFlingEffect.count()
        ) {
            """
            SELECT count(*)
            FROM "item_fling_effects"
            """
        } results: {
            """
            ┌───┐
            │ 7 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIItemFlingEffect.limit(5)
        ) {
            """
            SELECT "item_fling_effects"."id", "item_fling_effects"."identifier"
            FROM "item_fling_effects"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────┐
            │ PokeAPIItemFlingEffect(      │
            │   id: Tagged(rawValue: 1),   │
            │   identifier: "badly-poison" │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemFlingEffect(      │
            │   id: Tagged(rawValue: 2),   │
            │   identifier: "burn"         │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemFlingEffect(      │
            │   id: Tagged(rawValue: 3),   │
            │   identifier: "berry-effect" │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemFlingEffect(      │
            │   id: Tagged(rawValue: 4),   │
            │   identifier: "herb-effect"  │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemFlingEffect(      │
            │   id: Tagged(rawValue: 5),   │
            │   identifier: "paralyze"     │
            │ )                            │
            └──────────────────────────────┘
            """
        }
    }
}