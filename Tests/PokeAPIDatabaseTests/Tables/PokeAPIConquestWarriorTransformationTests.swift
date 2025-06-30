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
struct PokeAPIConquestWarriorTransformationTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestWarriorTransformation.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_warrior_transformation"
            """
        } results: {
            """
            ┌────┐
            │ 41 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestWarriorTransformation.limit(5)
        ) {
            """
            SELECT "conquest_warrior_transformation"."transformed_warrior_rank_id", "conquest_warrior_transformation"."is_automatic", "conquest_warrior_transformation"."required_link", "conquest_warrior_transformation"."completed_episode_id", "conquest_warrior_transformation"."current_episode_id", "conquest_warrior_transformation"."distant_warrior_id", "conquest_warrior_transformation"."female_warlord_count", "conquest_warrior_transformation"."pokemon_count", "conquest_warrior_transformation"."collection_type_id", "conquest_warrior_transformation"."warrior_count"
            FROM "conquest_warrior_transformation"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────────────┐
            │ PokeAPIConquestWarriorTransformation(            │
            │   transformedWarriorRankId: Tagged(rawValue: 2), │
            │   isAutomatic: true,                             │
            │   requiredLink: nil,                             │
            │   completedEpisodeId: nil,                       │
            │   currentEpisodeId: nil,                         │
            │   distantWarriorId: nil,                         │
            │   femaleWarlordCount: nil,                       │
            │   pokemonCount: nil,                             │
            │   collectionTypeId: nil,                         │
            │   warriorCount: nil                              │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIConquestWarriorTransformation(            │
            │   transformedWarriorRankId: Tagged(rawValue: 3), │
            │   isAutomatic: false,                            │
            │   requiredLink: 80,                              │
            │   completedEpisodeId: nil,                       │
            │   currentEpisodeId: Tagged(rawValue: 38),        │
            │   distantWarriorId: nil,                         │
            │   femaleWarlordCount: nil,                       │
            │   pokemonCount: nil,                             │
            │   collectionTypeId: nil,                         │
            │   warriorCount: nil                              │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIConquestWarriorTransformation(            │
            │   transformedWarriorRankId: Tagged(rawValue: 5), │
            │   isAutomatic: true,                             │
            │   requiredLink: nil,                             │
            │   completedEpisodeId: nil,                       │
            │   currentEpisodeId: nil,                         │
            │   distantWarriorId: nil,                         │
            │   femaleWarlordCount: nil,                       │
            │   pokemonCount: nil,                             │
            │   collectionTypeId: nil,                         │
            │   warriorCount: nil                              │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIConquestWarriorTransformation(            │
            │   transformedWarriorRankId: Tagged(rawValue: 6), │
            │   isAutomatic: false,                            │
            │   requiredLink: 80,                              │
            │   completedEpisodeId: nil,                       │
            │   currentEpisodeId: Tagged(rawValue: 38),        │
            │   distantWarriorId: nil,                         │
            │   femaleWarlordCount: nil,                       │
            │   pokemonCount: nil,                             │
            │   collectionTypeId: nil,                         │
            │   warriorCount: nil                              │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIConquestWarriorTransformation(            │
            │   transformedWarriorRankId: Tagged(rawValue: 8), │
            │   isAutomatic: false,                            │
            │   requiredLink: 80,                              │
            │   completedEpisodeId: nil,                       │
            │   currentEpisodeId: Tagged(rawValue: 2),         │
            │   distantWarriorId: nil,                         │
            │   femaleWarlordCount: nil,                       │
            │   pokemonCount: nil,                             │
            │   collectionTypeId: nil,                         │
            │   warriorCount: nil                              │
            │ )                                                │
            └──────────────────────────────────────────────────┘
            """
        }
    }
}
