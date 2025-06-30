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
struct PokeAPIConquestTransformationWarriorTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestTransformationWarrior.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_transformation_warriors"
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
            PokeAPIConquestTransformationWarrior.limit(5)
        ) {
            """
            SELECT "conquest_transformation_warriors"."transformation_id", "conquest_transformation_warriors"."present_warrior_id"
            FROM "conquest_transformation_warriors"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────┐
            │ PokeAPIConquestTransformationWarrior(    │
            │   transformationId: 43,                  │
            │   presentWarriorId: Tagged(rawValue: 21) │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestTransformationWarrior(    │
            │   transformationId: 45,                  │
            │   presentWarriorId: Tagged(rawValue: 20) │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestTransformationWarrior(    │
            │   transformationId: 55,                  │
            │   presentWarriorId: Tagged(rawValue: 12) │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestTransformationWarrior(    │
            │   transformationId: 59,                  │
            │   presentWarriorId: Tagged(rawValue: 14) │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestTransformationWarrior(    │
            │   transformationId: 67,                  │
            │   presentWarriorId: Tagged(rawValue: 3)  │
            │ )                                        │
            └──────────────────────────────────────────┘
            """
        }
    }
}