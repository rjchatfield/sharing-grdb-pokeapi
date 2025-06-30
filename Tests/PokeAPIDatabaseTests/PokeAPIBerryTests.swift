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
struct PokeAPIBerryTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIBerry.count()
        ) {
            """
            SELECT count(*)
            FROM "berries"
            """
        } results: {
            """
            ┌────┐
            │ 64 │
            └────┘
            """
        }
    }
    
    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIBerry.limit(5)
        ) {
            """
            SELECT "berries"."id", "berries"."item_id", "berries"."firmness_id", "berries"."natural_gift_power", "berries"."natural_gift_type_id", "berries"."size", "berries"."max_harvest", "berries"."growth_time", "berries"."soil_dryness", "berries"."smoothness"
            FROM "berries"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────┐
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 1),       │
            │   itemId: Tagged(rawValue: 126), │
            │   firmnessId: 2,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 10,         │
            │   size: 20,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 2),       │
            │   itemId: Tagged(rawValue: 127), │
            │   firmnessId: 5,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 11,         │
            │   size: 80,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 3),       │
            │   itemId: Tagged(rawValue: 128), │
            │   firmnessId: 1,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 13,         │
            │   size: 40,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 4),       │
            │   itemId: Tagged(rawValue: 129), │
            │   firmnessId: 3,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 12,         │
            │   size: 32,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 5),       │
            │   itemId: Tagged(rawValue: 130), │
            │   firmnessId: 5,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 15,         │
            │   size: 50,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            └──────────────────────────────────┘
            """
        }
    }
}
