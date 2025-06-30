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
struct PokeAPIGrowthRateTests {
    @Test
        func testGrowthRateBasicQuery() {
            Helper.assertQuery(
                PokeAPIGrowthRate.count()
            ) {
                """
                SELECT count(*)
                FROM "growth_rates"
                """
            } results: {
                """
                ┌───┐
                │ 6 │
                └───┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIGrowthRate.limit(5)
            ) {
                """
                SELECT "growth_rates"."id", "growth_rates"."identifier", "growth_rates"."formula"
                FROM "growth_rates"
                LIMIT 5
                """
            } results: {
                #"""
                ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
                │ PokeAPIGrowthRate(                                                                                                                                      │
                │   id: Tagged(rawValue: 1),                                                                                                                              │
                │   identifier: "slow",                                                                                                                                   │
                │   formula: #"\frac{5x^3}{4}"#                                                                                                                           │
                │ )                                                                                                                                                       │
                ├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
                │ PokeAPIGrowthRate(                                                                                                                                      │
                │   id: Tagged(rawValue: 2),                                                                                                                              │
                │   identifier: "medium",                                                                                                                                 │
                │   formula: "x^3"                                                                                                                                        │
                │ )                                                                                                                                                       │
                ├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
                │ PokeAPIGrowthRate(                                                                                                                                      │
                │   id: Tagged(rawValue: 3),                                                                                                                              │
                │   identifier: "fast",                                                                                                                                   │
                │   formula: #"\frac{4x^3}{5}"#                                                                                                                           │
                │ )                                                                                                                                                       │
                ├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
                │ PokeAPIGrowthRate(                                                                                                                                      │
                │   id: Tagged(rawValue: 4),                                                                                                                              │
                │   identifier: "medium-slow",                                                                                                                            │
                │   formula: #"\frac{6x^3}{5} - 15x^2 + 100x - 140"#                                                                                                      │
                │ )                                                                                                                                                       │
                ├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
                │ PokeAPIGrowthRate(                                                                                                                                      │
                │   id: Tagged(rawValue: 5),                                                                                                                              │
                │   identifier: "slow-then-very-fast",                                                                                                                    │
                │   formula: """                                                                                                                                          │
                │     \begin{cases}                                                                                                                                       │
                │     \frac{ x^3 \left( 100 - x \right) }{50},    & \text{if } x \leq 50  \\                                                                              │
                │     \frac{ x^3 \left( 150 - x \right) }{100},   & \text{if } 50 < x \leq 68  \\                                                                         │
                │     \frac{ x^3 \left( 1274 + (x \bmod 3)^2 - 9 (x \bmod 3) - 20 \left\lfloor \frac{x}{3} \right\rfloor \right) }{1000}, & \text{if } 68 < x \leq 98  \\ │
                │     \frac{ x^3 \left( 160 - x \right) }{100},   & \text{if } x > 98  \\                                                                                 │
                │     \end{cases}                                                                                                                                         │
                │     """                                                                                                                                                 │
                │ )                                                                                                                                                       │
                └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
                """#
            }
        }
}
