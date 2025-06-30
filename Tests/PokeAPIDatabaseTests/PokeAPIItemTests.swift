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
struct PokeAPIItemTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIItem.count()
        ) {
            """
            SELECT count(*)
            FROM "items"
            """
        } results: {
            """
            ┌──────┐
            │ 2180 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIItem.limit(5)
        ) {
            """
            SELECT "items"."id", "items"."identifier", "items"."category_id", "items"."cost", "items"."fling_power", "items"."fling_effect_id"
            FROM "items"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────────────┐
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 1),          │
            │   identifier: "master-ball",        │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 0,                          │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 2),          │
            │   identifier: "ultra-ball",         │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 800,                        │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 3),          │
            │   identifier: "great-ball",         │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 600,                        │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 4),          │
            │   identifier: "poke-ball",          │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 200,                        │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 5),          │
            │   identifier: "safari-ball",        │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 0,                          │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            └─────────────────────────────────────┘
            """
        }
    }

    @Test
    func hasFlingPower() {
        Helper.assertQuery(
            PokeAPIItem
                .where { $0.flingPower != nil }
                .limit(1)
        ) {
            """
            SELECT "items"."id", "items"."identifier", "items"."category_id", "items"."cost", "items"."fling_power", "items"."fling_effect_id"
            FROM "items"
            WHERE ("items"."fling_power" IS NOT NULL)
            LIMIT 1
            """
        } results: {
            """
            ┌─────────────────────────────────────┐
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 17),         │
            │   identifier: "potion",             │
            │   categoryId: Tagged(rawValue: 27), │
            │   cost: 200,                        │
            │   flingPower: 30,                   │
            │   flingEffectId: nil                │
            │ )                                   │
            └─────────────────────────────────────┘
            """
        }
    }

    @Test
    func hasFlingEffect() {
        Helper.assertQuery(
            PokeAPIItem
                .where { $0.flingEffectId != nil }
                .limit(1)
        ) {
            """
            SELECT "items"."id", "items"."identifier", "items"."category_id", "items"."cost", "items"."fling_power", "items"."fling_effect_id"
            FROM "items"
            WHERE ("items"."fling_effect_id" IS NOT NULL)
            LIMIT 1
            """
        } results: {
            """
            ┌────────────────────────────────────┐
            │ PokeAPIItem(                       │
            │   id: Tagged(rawValue: 126),       │
            │   identifier: "cheri-berry",       │
            │   categoryId: Tagged(rawValue: 3), │
            │   cost: 80,                        │
            │   flingPower: 10,                  │
            │   flingEffectId: 3                 │
            │ )                                  │
            └────────────────────────────────────┘
            """
        }
    }
}
