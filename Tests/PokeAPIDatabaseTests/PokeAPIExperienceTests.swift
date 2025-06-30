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
struct PokeAPIExperienceTests {
    @Test
        func testExperienceBasicQuery() {
            Helper.assertQuery(
                PokeAPIExperience.count()
            ) {
                """
                SELECT count(*)
                FROM "experience"
                """
            } results: {
                """
                ┌─────┐
                │ 600 │
                └─────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIExperience.limit(5)
            ) {
                """
                SELECT "experience"."growth_rate_id", "experience"."level", "experience"."experience"
                FROM "experience"
                LIMIT 5
                """
            } results: {
                """
                ┌──────────────────────────────────────┐
                │ PokeAPIExperience(                   │
                │   growthRateId: Tagged(rawValue: 1), │
                │   level: 1,                          │
                │   experience: 0                      │
                │ )                                    │
                ├──────────────────────────────────────┤
                │ PokeAPIExperience(                   │
                │   growthRateId: Tagged(rawValue: 1), │
                │   level: 2,                          │
                │   experience: 10                     │
                │ )                                    │
                ├──────────────────────────────────────┤
                │ PokeAPIExperience(                   │
                │   growthRateId: Tagged(rawValue: 1), │
                │   level: 3,                          │
                │   experience: 33                     │
                │ )                                    │
                ├──────────────────────────────────────┤
                │ PokeAPIExperience(                   │
                │   growthRateId: Tagged(rawValue: 1), │
                │   level: 4,                          │
                │   experience: 80                     │
                │ )                                    │
                ├──────────────────────────────────────┤
                │ PokeAPIExperience(                   │
                │   growthRateId: Tagged(rawValue: 1), │
                │   level: 5,                          │
                │   experience: 156                    │
                │ )                                    │
                └──────────────────────────────────────┘
                """
            }
        }
}
