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
struct PokeAPINatureBattleStylePreferenceTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPINatureBattleStylePreference.count()
        ) {
            """
            SELECT count(*)
            FROM "nature_battle_style_preferences"
            """
        } results: {
            """
            ┌────┐
            │ 75 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPINatureBattleStylePreference.limit(5)
        ) {
            """
            SELECT "nature_battle_style_preferences"."nature_id", "nature_battle_style_preferences"."move_battle_style_id", "nature_battle_style_preferences"."low_hp_preference", "nature_battle_style_preferences"."high_hp_preference"
            FROM "nature_battle_style_preferences"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPINatureBattleStylePreference(       │
            │   natureId: Tagged(rawValue: 1),          │
            │   moveBattleStyleId: Tagged(rawValue: 1), │
            │   lowHpPreference: 61,                    │
            │   highHpPreference: 61                    │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPINatureBattleStylePreference(       │
            │   natureId: Tagged(rawValue: 1),          │
            │   moveBattleStyleId: Tagged(rawValue: 2), │
            │   lowHpPreference: 7,                     │
            │   highHpPreference: 7                     │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPINatureBattleStylePreference(       │
            │   natureId: Tagged(rawValue: 1),          │
            │   moveBattleStyleId: Tagged(rawValue: 3), │
            │   lowHpPreference: 32,                    │
            │   highHpPreference: 32                    │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPINatureBattleStylePreference(       │
            │   natureId: Tagged(rawValue: 2),          │
            │   moveBattleStyleId: Tagged(rawValue: 1), │
            │   lowHpPreference: 32,                    │
            │   highHpPreference: 30                    │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPINatureBattleStylePreference(       │
            │   natureId: Tagged(rawValue: 2),          │
            │   moveBattleStyleId: Tagged(rawValue: 2), │
            │   lowHpPreference: 58,                    │
            │   highHpPreference: 20                    │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
}