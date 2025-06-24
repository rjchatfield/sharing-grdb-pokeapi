import Testing
import GRDB
import StructuredQueries
import StructuredQueriesSQLite
import StructuredQueriesTestSupport
import SnapshotTesting
import InlineSnapshotTesting
import PokeAPIDatabase
import SnapshotTestingCustomDump

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct AggregateRelationshipTests {

    // MARK: - PokeAPIPokemon.WithTypes

    @Test
    func testPokemonWithTypes_fetchAll() throws {
        let database = Helper.sqlDB()
        let allPokemonWithTypes = try PokeAPIPokemon.WithTypes.fetchAll(database, limit: 5)
        assertInlineSnapshot(of: allPokemonWithTypes, as: .customDump) {
            """
            [
              [0]: PokeAPIPokemon.WithTypes(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 1),
                  identifier: "bulbasaur",
                  speciesId: Tagged(rawValue: 1),
                  heightInDecimeters: 7,
                  weightInHectograms: 69,
                  baseExperience: 64,
                  order: 1,
                  isDefault: true
                ),
                types: [
                  [0]: PokeAPIType(
                    id: Tagged(rawValue: 12),
                    identifier: "grass",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 3)
                  ),
                  [1]: PokeAPIType(
                    id: Tagged(rawValue: 4),
                    identifier: "poison",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 2)
                  )
                ]
              ),
              [1]: PokeAPIPokemon.WithTypes(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 2),
                  identifier: "ivysaur",
                  speciesId: Tagged(rawValue: 2),
                  heightInDecimeters: 10,
                  weightInHectograms: 130,
                  baseExperience: 142,
                  order: 2,
                  isDefault: true
                ),
                types: [
                  [0]: PokeAPIType(
                    id: Tagged(rawValue: 12),
                    identifier: "grass",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 3)
                  ),
                  [1]: PokeAPIType(
                    id: Tagged(rawValue: 4),
                    identifier: "poison",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 2)
                  )
                ]
              ),
              [2]: PokeAPIPokemon.WithTypes(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 3),
                  identifier: "venusaur",
                  speciesId: Tagged(rawValue: 3),
                  heightInDecimeters: 20,
                  weightInHectograms: 1000,
                  baseExperience: 236,
                  order: 3,
                  isDefault: true
                ),
                types: [
                  [0]: PokeAPIType(
                    id: Tagged(rawValue: 12),
                    identifier: "grass",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 3)
                  )
                ]
              )
            ]
            """
        }
    }

    @Test
    func testPokemonWithTypes_fetch() throws {
        let database = Helper.sqlDB()
        let pokemonWithTypes = try PokeAPIPokemon.WithTypes.fetchOne(database, pokemonId: 1)
        assertInlineSnapshot(of: pokemonWithTypes, as: .customDump) {
            """
            PokeAPIPokemon.WithTypes(
              pokemon: PokeAPIPokemon(
                id: Tagged(rawValue: 1),
                identifier: "bulbasaur",
                speciesId: Tagged(rawValue: 1),
                heightInDecimeters: 7,
                weightInHectograms: 69,
                baseExperience: 64,
                order: 1,
                isDefault: true
              ),
              types: [
                [0]: PokeAPIType(
                  id: Tagged(rawValue: 12),
                  identifier: "grass",
                  generationId: Tagged(rawValue: 1),
                  damageClassId: Tagged(rawValue: 3)
                ),
                [1]: PokeAPIType(
                  id: Tagged(rawValue: 4),
                  identifier: "poison",
                  generationId: Tagged(rawValue: 1),
                  damageClassId: Tagged(rawValue: 2)
                )
              ]
            )
            """
        }
    }
}
