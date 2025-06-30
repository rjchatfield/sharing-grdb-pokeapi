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
struct PokeAPIEvolutionChainTests {
    @Test
        func testEvolutionChainBasicQuery() {
            Helper.assertQuery(
                PokeAPIEvolutionChain.count()
            ) {
                """
                SELECT count(*)
                FROM "evolution_chains"
                """
            } results: {
                """
                ┌─────┐
                │ 541 │
                └─────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIEvolutionChain.limit(5)
            ) {
                """
                SELECT "evolution_chains"."id", "evolution_chains"."baby_trigger_item_id"
                FROM "evolution_chains"
                LIMIT 5
                """
            } results: {
                """
                ┌────────────────────────────┐
                │ PokeAPIEvolutionChain(     │
                │   id: Tagged(rawValue: 1), │
                │   babyTriggerItemId: nil   │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIEvolutionChain(     │
                │   id: Tagged(rawValue: 2), │
                │   babyTriggerItemId: nil   │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIEvolutionChain(     │
                │   id: Tagged(rawValue: 3), │
                │   babyTriggerItemId: nil   │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIEvolutionChain(     │
                │   id: Tagged(rawValue: 4), │
                │   babyTriggerItemId: nil   │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIEvolutionChain(     │
                │   id: Tagged(rawValue: 5), │
                │   babyTriggerItemId: nil   │
                │ )                          │
                └────────────────────────────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIEvolutionChain
                    .where { $0.babyTriggerItemId != nil }
                    .count()
            ) {
                """
                SELECT count(*)
                FROM "evolution_chains"
                WHERE ("evolution_chains"."baby_trigger_item_id" IS NOT NULL)
                """
            } results: {
                """
                ┌───┐
                │ 9 │
                └───┘
                """
            }
        }
}
