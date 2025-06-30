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
struct PokeAPINatureTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPINature.count()
        ) {
            """
            SELECT count(*)
            FROM "natures"
            """
        } results: {
            """
            ┌────┐
            │ 25 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPINature.limit(5)
        ) {
            """
            SELECT "natures"."id", "natures"."identifier", "natures"."decreased_stat_id", "natures"."increased_stat_id", "natures"."hates_flavor_id", "natures"."likes_flavor_id", "natures"."game_index"
            FROM "natures"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────────────┐
            │ PokeAPINature(                      │
            │   id: Tagged(rawValue: 1),          │
            │   identifier: "hardy",              │
            │   decreasedStatId: .attack,         │
            │   increasedStatId: .attack,         │
            │   hatesFlavorId: 1,                 │
            │   likesFlavorId: 1,                 │
            │   gameIndex: 0                      │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPINature(                      │
            │   id: Tagged(rawValue: 2),          │
            │   identifier: "bold",               │
            │   decreasedStatId: .attack,         │
            │   increasedStatId: .defense,        │
            │   hatesFlavorId: 1,                 │
            │   likesFlavorId: 5,                 │
            │   gameIndex: 5                      │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPINature(                      │
            │   id: Tagged(rawValue: 3),          │
            │   identifier: "modest",             │
            │   decreasedStatId: .attack,         │
            │   increasedStatId: .specialAttack,  │
            │   hatesFlavorId: 1,                 │
            │   likesFlavorId: 2,                 │
            │   gameIndex: 15                     │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPINature(                      │
            │   id: Tagged(rawValue: 4),          │
            │   identifier: "calm",               │
            │   decreasedStatId: .attack,         │
            │   increasedStatId: .specialDefense, │
            │   hatesFlavorId: 1,                 │
            │   likesFlavorId: 4,                 │
            │   gameIndex: 20                     │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPINature(                      │
            │   id: Tagged(rawValue: 5),          │
            │   identifier: "timid",              │
            │   decreasedStatId: .attack,         │
            │   increasedStatId: .speed,          │
            │   hatesFlavorId: 1,                 │
            │   likesFlavorId: 3,                 │
            │   gameIndex: 10                     │
            │ )                                   │
            └─────────────────────────────────────┘
            """
        }
    }
}
