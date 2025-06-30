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
struct PokeAPIPokemonFormTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonForm.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_forms"
            """
        } results: {
            """
            ┌──────┐
            │ 1527 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonForm.limit(5)
        ) {
            """
            SELECT "pokemon_forms"."id", "pokemon_forms"."identifier", "pokemon_forms"."form_identifier", "pokemon_forms"."pokemon_id", "pokemon_forms"."introduced_in_version_group_id", "pokemon_forms"."is_default", "pokemon_forms"."is_battle_only", "pokemon_forms"."is_mega", "pokemon_forms"."form_order", "pokemon_forms"."order"
            FROM "pokemon_forms"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────────────────────┐
            │ PokeAPIPokemonForm(                                │
            │   id: Tagged(rawValue: 1),                         │
            │   identifier: "bulbasaur",                         │
            │   formIdentifier: nil,                             │
            │   pokemonId: Tagged(rawValue: 1),                  │
            │   introducedInVersionGroupId: Tagged(rawValue: 1), │
            │   isDefault: true,                                 │
            │   isBattleOnly: false,                             │
            │   isMega: false,                                   │
            │   formOrder: 1,                                    │
            │   order: 1                                         │
            │ )                                                  │
            ├────────────────────────────────────────────────────┤
            │ PokeAPIPokemonForm(                                │
            │   id: Tagged(rawValue: 2),                         │
            │   identifier: "ivysaur",                           │
            │   formIdentifier: nil,                             │
            │   pokemonId: Tagged(rawValue: 2),                  │
            │   introducedInVersionGroupId: Tagged(rawValue: 1), │
            │   isDefault: true,                                 │
            │   isBattleOnly: false,                             │
            │   isMega: false,                                   │
            │   formOrder: 1,                                    │
            │   order: 2                                         │
            │ )                                                  │
            ├────────────────────────────────────────────────────┤
            │ PokeAPIPokemonForm(                                │
            │   id: Tagged(rawValue: 3),                         │
            │   identifier: "venusaur",                          │
            │   formIdentifier: nil,                             │
            │   pokemonId: Tagged(rawValue: 3),                  │
            │   introducedInVersionGroupId: Tagged(rawValue: 1), │
            │   isDefault: true,                                 │
            │   isBattleOnly: false,                             │
            │   isMega: false,                                   │
            │   formOrder: 1,                                    │
            │   order: 3                                         │
            │ )                                                  │
            ├────────────────────────────────────────────────────┤
            │ PokeAPIPokemonForm(                                │
            │   id: Tagged(rawValue: 4),                         │
            │   identifier: "charmander",                        │
            │   formIdentifier: nil,                             │
            │   pokemonId: Tagged(rawValue: 4),                  │
            │   introducedInVersionGroupId: Tagged(rawValue: 1), │
            │   isDefault: true,                                 │
            │   isBattleOnly: false,                             │
            │   isMega: false,                                   │
            │   formOrder: 1,                                    │
            │   order: 5                                         │
            │ )                                                  │
            ├────────────────────────────────────────────────────┤
            │ PokeAPIPokemonForm(                                │
            │   id: Tagged(rawValue: 5),                         │
            │   identifier: "charmeleon",                        │
            │   formIdentifier: nil,                             │
            │   pokemonId: Tagged(rawValue: 5),                  │
            │   introducedInVersionGroupId: Tagged(rawValue: 1), │
            │   isDefault: true,                                 │
            │   isBattleOnly: false,                             │
            │   isMega: false,                                   │
            │   formOrder: 1,                                    │
            │   order: 6                                         │
            │ )                                                  │
            └────────────────────────────────────────────────────┘
            """
        }
    }

    @Test
    func first5FormIdentifiers() {
        Helper.assertQuery(
            PokeAPIPokemonForm
                .where { $0.formIdentifier != nil }
                .limit(20)
                .select { ($0.identifier, $0.formIdentifier) }
        ) {
            """
            SELECT "pokemon_forms"."identifier", "pokemon_forms"."form_identifier"
            FROM "pokemon_forms"
            WHERE ("pokemon_forms"."form_identifier" IS NOT NULL)
            LIMIT 20
            """
        } results: {
            """
            ┌────────────────────────┬───────────────┐
            │ "unown-a"              │ "a"           │
            │ "deoxys-normal"        │ "normal"      │
            │ "burmy-plant"          │ "plant"       │
            │ "wormadam-plant"       │ "plant"       │
            │ "mothim-plant"         │ "plant"       │
            │ "cherrim-overcast"     │ "overcast"    │
            │ "shellos-west"         │ "west"        │
            │ "gastrodon-west"       │ "west"        │
            │ "giratina-altered"     │ "altered"     │
            │ "shaymin-land"         │ "land"        │
            │ "arceus-normal"        │ "normal"      │
            │ "basculin-red-striped" │ "red-striped" │
            │ "darmanitan-standard"  │ "standard"    │
            │ "deerling-spring"      │ "spring"      │
            │ "sawsbuck-spring"      │ "spring"      │
            │ "tornadus-incarnate"   │ "incarnate"   │
            │ "thundurus-incarnate"  │ "incarnate"   │
            │ "landorus-incarnate"   │ "incarnate"   │
            │ "keldeo-ordinary"      │ "ordinary"    │
            │ "meloetta-aria"        │ "aria"        │
            └────────────────────────┴───────────────┘
            """
        }
    }
}
