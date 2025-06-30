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
struct PokeAPIPokemonTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemon.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon"
            """
        } results: {
            """
            ┌──────┐
            │ 1302 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemon.limit(5)
        ) {
            """
            SELECT "pokemon"."id", "pokemon"."identifier", "pokemon"."species_id", "pokemon"."height", "pokemon"."weight", "pokemon"."base_experience", "pokemon"."order", "pokemon"."is_default"
            FROM "pokemon"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 1),        │
            │   identifier: "bulbasaur",        │
            │   speciesId: Tagged(rawValue: 1), │
            │   heightInDecimeters: 7,          │
            │   weightInHectograms: 69,         │
            │   baseExperience: 64,             │
            │   order: 1,                       │
            │   isDefault: true                 │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 2),        │
            │   identifier: "ivysaur",          │
            │   speciesId: Tagged(rawValue: 2), │
            │   heightInDecimeters: 10,         │
            │   weightInHectograms: 130,        │
            │   baseExperience: 142,            │
            │   order: 2,                       │
            │   isDefault: true                 │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 3),        │
            │   identifier: "venusaur",         │
            │   speciesId: Tagged(rawValue: 3), │
            │   heightInDecimeters: 20,         │
            │   weightInHectograms: 1000,       │
            │   baseExperience: 236,            │
            │   order: 3,                       │
            │   isDefault: true                 │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 4),        │
            │   identifier: "charmander",       │
            │   speciesId: Tagged(rawValue: 4), │
            │   heightInDecimeters: 6,          │
            │   weightInHectograms: 85,         │
            │   baseExperience: 62,             │
            │   order: 5,                       │
            │   isDefault: true                 │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 5),        │
            │   identifier: "charmeleon",       │
            │   speciesId: Tagged(rawValue: 5), │
            │   heightInDecimeters: 11,         │
            │   weightInHectograms: 190,        │
            │   baseExperience: 142,            │
            │   order: 6,                       │
            │   isDefault: true                 │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }

    @Test
    func notDefault() {
        Helper.assertQuery(
            PokeAPIPokemon
                .where { !$0.isDefault }
                .count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon"
            WHERE NOT ("pokemon"."is_default")
            """
        } results: {
            """
            ┌─────┐
            │ 276 │
            └─────┘
            """
        }
    }

    @Test
    func allIdentifiers() {
        Helper.assertQuery(
            PokeAPIPokemon
                .order(by: \.id)
                .select { ($0.id, $0.identifier) }
        ) {
            """
            SELECT "pokemon"."id", "pokemon"."identifier"
            FROM "pokemon"
            ORDER BY "pokemon"."id"
            """
        } results: {
            """
            ┌─────────────────────────┬───────────────────────────────┐
            │ Tagged(rawValue: 1)     │ "bulbasaur"                   │
            │ Tagged(rawValue: 2)     │ "ivysaur"                     │
            │ Tagged(rawValue: 3)     │ "venusaur"                    │
            │ Tagged(rawValue: 4)     │ "charmander"                  │
            │ Tagged(rawValue: 5)     │ "charmeleon"                  │
            │ Tagged(rawValue: 6)     │ "charizard"                   │
            │ Tagged(rawValue: 7)     │ "squirtle"                    │
            │ Tagged(rawValue: 8)     │ "wartortle"                   │
            │ Tagged(rawValue: 9)     │ "blastoise"                   │
            │ Tagged(rawValue: 10)    │ "caterpie"                    │
            │ Tagged(rawValue: 11)    │ "metapod"                     │
            │ Tagged(rawValue: 12)    │ "butterfree"                  │
            │ Tagged(rawValue: 13)    │ "weedle"                      │
            │ Tagged(rawValue: 14)    │ "kakuna"                      │
            │ Tagged(rawValue: 15)    │ "beedrill"                    │
            │ Tagged(rawValue: 16)    │ "pidgey"                      │
            │ Tagged(rawValue: 17)    │ "pidgeotto"                   │
            │ Tagged(rawValue: 18)    │ "pidgeot"                     │
            │ Tagged(rawValue: 19)    │ "rattata"                     │
            │ Tagged(rawValue: 20)    │ "raticate"                    │
            │ Tagged(rawValue: 21)    │ "spearow"                     │
            │ Tagged(rawValue: 22)    │ "fearow"                      │
            │ Tagged(rawValue: 23)    │ "ekans"                       │
            │ Tagged(rawValue: 24)    │ "arbok"                       │
            │ Tagged(rawValue: 25)    │ "pikachu"                     │
            │ Tagged(rawValue: 26)    │ "raichu"                      │
            │ Tagged(rawValue: 27)    │ "sandshrew"                   │
            │ Tagged(rawValue: 28)    │ "sandslash"                   │
            │ Tagged(rawValue: 29)    │ "nidoran-f"                   │
            │ Tagged(rawValue: 30)    │ "nidorina"                    │
            │ Tagged(rawValue: 31)    │ "nidoqueen"                   │
            │ Tagged(rawValue: 32)    │ "nidoran-m"                   │
            │ Tagged(rawValue: 33)    │ "nidorino"                    │
            │ Tagged(rawValue: 34)    │ "nidoking"                    │
            │ Tagged(rawValue: 35)    │ "clefairy"                    │
            │ Tagged(rawValue: 36)    │ "clefable"                    │
            │ Tagged(rawValue: 37)    │ "vulpix"                      │
            │ Tagged(rawValue: 38)    │ "ninetales"                   │
            │ Tagged(rawValue: 39)    │ "jigglypuff"                  │
            │ Tagged(rawValue: 40)    │ "wigglytuff"                  │
            │ Tagged(rawValue: 41)    │ "zubat"                       │
            │ Tagged(rawValue: 42)    │ "golbat"                      │
            │ Tagged(rawValue: 43)    │ "oddish"                      │
            │ Tagged(rawValue: 44)    │ "gloom"                       │
            │ Tagged(rawValue: 45)    │ "vileplume"                   │
            │ Tagged(rawValue: 46)    │ "paras"                       │
            │ Tagged(rawValue: 47)    │ "parasect"                    │
            │ Tagged(rawValue: 48)    │ "venonat"                     │
            │ Tagged(rawValue: 49)    │ "venomoth"                    │
            │ Tagged(rawValue: 50)    │ "diglett"                     │
            │ Tagged(rawValue: 51)    │ "dugtrio"                     │
            │ Tagged(rawValue: 52)    │ "meowth"                      │
            │ Tagged(rawValue: 53)    │ "persian"                     │
            │ Tagged(rawValue: 54)    │ "psyduck"                     │
            │ Tagged(rawValue: 55)    │ "golduck"                     │
            │ Tagged(rawValue: 56)    │ "mankey"                      │
            │ Tagged(rawValue: 57)    │ "primeape"                    │
            │ Tagged(rawValue: 58)    │ "growlithe"                   │
            │ Tagged(rawValue: 59)    │ "arcanine"                    │
            │ Tagged(rawValue: 60)    │ "poliwag"                     │
            │ Tagged(rawValue: 61)    │ "poliwhirl"                   │
            │ Tagged(rawValue: 62)    │ "poliwrath"                   │
            │ Tagged(rawValue: 63)    │ "abra"                        │
            │ Tagged(rawValue: 64)    │ "kadabra"                     │
            │ Tagged(rawValue: 65)    │ "alakazam"                    │
            │ Tagged(rawValue: 66)    │ "machop"                      │
            │ Tagged(rawValue: 67)    │ "machoke"                     │
            │ Tagged(rawValue: 68)    │ "machamp"                     │
            │ Tagged(rawValue: 69)    │ "bellsprout"                  │
            │ Tagged(rawValue: 70)    │ "weepinbell"                  │
            │ Tagged(rawValue: 71)    │ "victreebel"                  │
            │ Tagged(rawValue: 72)    │ "tentacool"                   │
            │ Tagged(rawValue: 73)    │ "tentacruel"                  │
            │ Tagged(rawValue: 74)    │ "geodude"                     │
            │ Tagged(rawValue: 75)    │ "graveler"                    │
            │ Tagged(rawValue: 76)    │ "golem"                       │
            │ Tagged(rawValue: 77)    │ "ponyta"                      │
            │ Tagged(rawValue: 78)    │ "rapidash"                    │
            │ Tagged(rawValue: 79)    │ "slowpoke"                    │
            │ Tagged(rawValue: 80)    │ "slowbro"                     │
            │ Tagged(rawValue: 81)    │ "magnemite"                   │
            │ Tagged(rawValue: 82)    │ "magneton"                    │
            │ Tagged(rawValue: 83)    │ "farfetchd"                   │
            │ Tagged(rawValue: 84)    │ "doduo"                       │
            │ Tagged(rawValue: 85)    │ "dodrio"                      │
            │ Tagged(rawValue: 86)    │ "seel"                        │
            │ Tagged(rawValue: 87)    │ "dewgong"                     │
            │ Tagged(rawValue: 88)    │ "grimer"                      │
            │ Tagged(rawValue: 89)    │ "muk"                         │
            │ Tagged(rawValue: 90)    │ "shellder"                    │
            │ Tagged(rawValue: 91)    │ "cloyster"                    │
            │ Tagged(rawValue: 92)    │ "gastly"                      │
            │ Tagged(rawValue: 93)    │ "haunter"                     │
            │ Tagged(rawValue: 94)    │ "gengar"                      │
            │ Tagged(rawValue: 95)    │ "onix"                        │
            │ Tagged(rawValue: 96)    │ "drowzee"                     │
            │ Tagged(rawValue: 97)    │ "hypno"                       │
            │ Tagged(rawValue: 98)    │ "krabby"                      │
            │ Tagged(rawValue: 99)    │ "kingler"                     │
            │ Tagged(rawValue: 100)   │ "voltorb"                     │
            │ Tagged(rawValue: 101)   │ "electrode"                   │
            │ Tagged(rawValue: 102)   │ "exeggcute"                   │
            │ Tagged(rawValue: 103)   │ "exeggutor"                   │
            │ Tagged(rawValue: 104)   │ "cubone"                      │
            │ Tagged(rawValue: 105)   │ "marowak"                     │
            │ Tagged(rawValue: 106)   │ "hitmonlee"                   │
            │ Tagged(rawValue: 107)   │ "hitmonchan"                  │
            │ Tagged(rawValue: 108)   │ "lickitung"                   │
            │ Tagged(rawValue: 109)   │ "koffing"                     │
            │ Tagged(rawValue: 110)   │ "weezing"                     │
            │ Tagged(rawValue: 111)   │ "rhyhorn"                     │
            │ Tagged(rawValue: 112)   │ "rhydon"                      │
            │ Tagged(rawValue: 113)   │ "chansey"                     │
            │ Tagged(rawValue: 114)   │ "tangela"                     │
            │ Tagged(rawValue: 115)   │ "kangaskhan"                  │
            │ Tagged(rawValue: 116)   │ "horsea"                      │
            │ Tagged(rawValue: 117)   │ "seadra"                      │
            │ Tagged(rawValue: 118)   │ "goldeen"                     │
            │ Tagged(rawValue: 119)   │ "seaking"                     │
            │ Tagged(rawValue: 120)   │ "staryu"                      │
            │ Tagged(rawValue: 121)   │ "starmie"                     │
            │ Tagged(rawValue: 122)   │ "mr-mime"                     │
            │ Tagged(rawValue: 123)   │ "scyther"                     │
            │ Tagged(rawValue: 124)   │ "jynx"                        │
            │ Tagged(rawValue: 125)   │ "electabuzz"                  │
            │ Tagged(rawValue: 126)   │ "magmar"                      │
            │ Tagged(rawValue: 127)   │ "pinsir"                      │
            │ Tagged(rawValue: 128)   │ "tauros"                      │
            │ Tagged(rawValue: 129)   │ "magikarp"                    │
            │ Tagged(rawValue: 130)   │ "gyarados"                    │
            │ Tagged(rawValue: 131)   │ "lapras"                      │
            │ Tagged(rawValue: 132)   │ "ditto"                       │
            │ Tagged(rawValue: 133)   │ "eevee"                       │
            │ Tagged(rawValue: 134)   │ "vaporeon"                    │
            │ Tagged(rawValue: 135)   │ "jolteon"                     │
            │ Tagged(rawValue: 136)   │ "flareon"                     │
            │ Tagged(rawValue: 137)   │ "porygon"                     │
            │ Tagged(rawValue: 138)   │ "omanyte"                     │
            │ Tagged(rawValue: 139)   │ "omastar"                     │
            │ Tagged(rawValue: 140)   │ "kabuto"                      │
            │ Tagged(rawValue: 141)   │ "kabutops"                    │
            │ Tagged(rawValue: 142)   │ "aerodactyl"                  │
            │ Tagged(rawValue: 143)   │ "snorlax"                     │
            │ Tagged(rawValue: 144)   │ "articuno"                    │
            │ Tagged(rawValue: 145)   │ "zapdos"                      │
            │ Tagged(rawValue: 146)   │ "moltres"                     │
            │ Tagged(rawValue: 147)   │ "dratini"                     │
            │ Tagged(rawValue: 148)   │ "dragonair"                   │
            │ Tagged(rawValue: 149)   │ "dragonite"                   │
            │ Tagged(rawValue: 150)   │ "mewtwo"                      │
            │ Tagged(rawValue: 151)   │ "mew"                         │
            │ Tagged(rawValue: 152)   │ "chikorita"                   │
            │ Tagged(rawValue: 153)   │ "bayleef"                     │
            │ Tagged(rawValue: 154)   │ "meganium"                    │
            │ Tagged(rawValue: 155)   │ "cyndaquil"                   │
            │ Tagged(rawValue: 156)   │ "quilava"                     │
            │ Tagged(rawValue: 157)   │ "typhlosion"                  │
            │ Tagged(rawValue: 158)   │ "totodile"                    │
            │ Tagged(rawValue: 159)   │ "croconaw"                    │
            │ Tagged(rawValue: 160)   │ "feraligatr"                  │
            │ Tagged(rawValue: 161)   │ "sentret"                     │
            │ Tagged(rawValue: 162)   │ "furret"                      │
            │ Tagged(rawValue: 163)   │ "hoothoot"                    │
            │ Tagged(rawValue: 164)   │ "noctowl"                     │
            │ Tagged(rawValue: 165)   │ "ledyba"                      │
            │ Tagged(rawValue: 166)   │ "ledian"                      │
            │ Tagged(rawValue: 167)   │ "spinarak"                    │
            │ Tagged(rawValue: 168)   │ "ariados"                     │
            │ Tagged(rawValue: 169)   │ "crobat"                      │
            │ Tagged(rawValue: 170)   │ "chinchou"                    │
            │ Tagged(rawValue: 171)   │ "lanturn"                     │
            │ Tagged(rawValue: 172)   │ "pichu"                       │
            │ Tagged(rawValue: 173)   │ "cleffa"                      │
            │ Tagged(rawValue: 174)   │ "igglybuff"                   │
            │ Tagged(rawValue: 175)   │ "togepi"                      │
            │ Tagged(rawValue: 176)   │ "togetic"                     │
            │ Tagged(rawValue: 177)   │ "natu"                        │
            │ Tagged(rawValue: 178)   │ "xatu"                        │
            │ Tagged(rawValue: 179)   │ "mareep"                      │
            │ Tagged(rawValue: 180)   │ "flaaffy"                     │
            │ Tagged(rawValue: 181)   │ "ampharos"                    │
            │ Tagged(rawValue: 182)   │ "bellossom"                   │
            │ Tagged(rawValue: 183)   │ "marill"                      │
            │ Tagged(rawValue: 184)   │ "azumarill"                   │
            │ Tagged(rawValue: 185)   │ "sudowoodo"                   │
            │ Tagged(rawValue: 186)   │ "politoed"                    │
            │ Tagged(rawValue: 187)   │ "hoppip"                      │
            │ Tagged(rawValue: 188)   │ "skiploom"                    │
            │ Tagged(rawValue: 189)   │ "jumpluff"                    │
            │ Tagged(rawValue: 190)   │ "aipom"                       │
            │ Tagged(rawValue: 191)   │ "sunkern"                     │
            │ Tagged(rawValue: 192)   │ "sunflora"                    │
            │ Tagged(rawValue: 193)   │ "yanma"                       │
            │ Tagged(rawValue: 194)   │ "wooper"                      │
            │ Tagged(rawValue: 195)   │ "quagsire"                    │
            │ Tagged(rawValue: 196)   │ "espeon"                      │
            │ Tagged(rawValue: 197)   │ "umbreon"                     │
            │ Tagged(rawValue: 198)   │ "murkrow"                     │
            │ Tagged(rawValue: 199)   │ "slowking"                    │
            │ Tagged(rawValue: 200)   │ "misdreavus"                  │
            │ Tagged(rawValue: 201)   │ "unown"                       │
            │ Tagged(rawValue: 202)   │ "wobbuffet"                   │
            │ Tagged(rawValue: 203)   │ "girafarig"                   │
            │ Tagged(rawValue: 204)   │ "pineco"                      │
            │ Tagged(rawValue: 205)   │ "forretress"                  │
            │ Tagged(rawValue: 206)   │ "dunsparce"                   │
            │ Tagged(rawValue: 207)   │ "gligar"                      │
            │ Tagged(rawValue: 208)   │ "steelix"                     │
            │ Tagged(rawValue: 209)   │ "snubbull"                    │
            │ Tagged(rawValue: 210)   │ "granbull"                    │
            │ Tagged(rawValue: 211)   │ "qwilfish"                    │
            │ Tagged(rawValue: 212)   │ "scizor"                      │
            │ Tagged(rawValue: 213)   │ "shuckle"                     │
            │ Tagged(rawValue: 214)   │ "heracross"                   │
            │ Tagged(rawValue: 215)   │ "sneasel"                     │
            │ Tagged(rawValue: 216)   │ "teddiursa"                   │
            │ Tagged(rawValue: 217)   │ "ursaring"                    │
            │ Tagged(rawValue: 218)   │ "slugma"                      │
            │ Tagged(rawValue: 219)   │ "magcargo"                    │
            │ Tagged(rawValue: 220)   │ "swinub"                      │
            │ Tagged(rawValue: 221)   │ "piloswine"                   │
            │ Tagged(rawValue: 222)   │ "corsola"                     │
            │ Tagged(rawValue: 223)   │ "remoraid"                    │
            │ Tagged(rawValue: 224)   │ "octillery"                   │
            │ Tagged(rawValue: 225)   │ "delibird"                    │
            │ Tagged(rawValue: 226)   │ "mantine"                     │
            │ Tagged(rawValue: 227)   │ "skarmory"                    │
            │ Tagged(rawValue: 228)   │ "houndour"                    │
            │ Tagged(rawValue: 229)   │ "houndoom"                    │
            │ Tagged(rawValue: 230)   │ "kingdra"                     │
            │ Tagged(rawValue: 231)   │ "phanpy"                      │
            │ Tagged(rawValue: 232)   │ "donphan"                     │
            │ Tagged(rawValue: 233)   │ "porygon2"                    │
            │ Tagged(rawValue: 234)   │ "stantler"                    │
            │ Tagged(rawValue: 235)   │ "smeargle"                    │
            │ Tagged(rawValue: 236)   │ "tyrogue"                     │
            │ Tagged(rawValue: 237)   │ "hitmontop"                   │
            │ Tagged(rawValue: 238)   │ "smoochum"                    │
            │ Tagged(rawValue: 239)   │ "elekid"                      │
            │ Tagged(rawValue: 240)   │ "magby"                       │
            │ Tagged(rawValue: 241)   │ "miltank"                     │
            │ Tagged(rawValue: 242)   │ "blissey"                     │
            │ Tagged(rawValue: 243)   │ "raikou"                      │
            │ Tagged(rawValue: 244)   │ "entei"                       │
            │ Tagged(rawValue: 245)   │ "suicune"                     │
            │ Tagged(rawValue: 246)   │ "larvitar"                    │
            │ Tagged(rawValue: 247)   │ "pupitar"                     │
            │ Tagged(rawValue: 248)   │ "tyranitar"                   │
            │ Tagged(rawValue: 249)   │ "lugia"                       │
            │ Tagged(rawValue: 250)   │ "ho-oh"                       │
            │ Tagged(rawValue: 251)   │ "celebi"                      │
            │ Tagged(rawValue: 252)   │ "treecko"                     │
            │ Tagged(rawValue: 253)   │ "grovyle"                     │
            │ Tagged(rawValue: 254)   │ "sceptile"                    │
            │ Tagged(rawValue: 255)   │ "torchic"                     │
            │ Tagged(rawValue: 256)   │ "combusken"                   │
            │ Tagged(rawValue: 257)   │ "blaziken"                    │
            │ Tagged(rawValue: 258)   │ "mudkip"                      │
            │ Tagged(rawValue: 259)   │ "marshtomp"                   │
            │ Tagged(rawValue: 260)   │ "swampert"                    │
            │ Tagged(rawValue: 261)   │ "poochyena"                   │
            │ Tagged(rawValue: 262)   │ "mightyena"                   │
            │ Tagged(rawValue: 263)   │ "zigzagoon"                   │
            │ Tagged(rawValue: 264)   │ "linoone"                     │
            │ Tagged(rawValue: 265)   │ "wurmple"                     │
            │ Tagged(rawValue: 266)   │ "silcoon"                     │
            │ Tagged(rawValue: 267)   │ "beautifly"                   │
            │ Tagged(rawValue: 268)   │ "cascoon"                     │
            │ Tagged(rawValue: 269)   │ "dustox"                      │
            │ Tagged(rawValue: 270)   │ "lotad"                       │
            │ Tagged(rawValue: 271)   │ "lombre"                      │
            │ Tagged(rawValue: 272)   │ "ludicolo"                    │
            │ Tagged(rawValue: 273)   │ "seedot"                      │
            │ Tagged(rawValue: 274)   │ "nuzleaf"                     │
            │ Tagged(rawValue: 275)   │ "shiftry"                     │
            │ Tagged(rawValue: 276)   │ "taillow"                     │
            │ Tagged(rawValue: 277)   │ "swellow"                     │
            │ Tagged(rawValue: 278)   │ "wingull"                     │
            │ Tagged(rawValue: 279)   │ "pelipper"                    │
            │ Tagged(rawValue: 280)   │ "ralts"                       │
            │ Tagged(rawValue: 281)   │ "kirlia"                      │
            │ Tagged(rawValue: 282)   │ "gardevoir"                   │
            │ Tagged(rawValue: 283)   │ "surskit"                     │
            │ Tagged(rawValue: 284)   │ "masquerain"                  │
            │ Tagged(rawValue: 285)   │ "shroomish"                   │
            │ Tagged(rawValue: 286)   │ "breloom"                     │
            │ Tagged(rawValue: 287)   │ "slakoth"                     │
            │ Tagged(rawValue: 288)   │ "vigoroth"                    │
            │ Tagged(rawValue: 289)   │ "slaking"                     │
            │ Tagged(rawValue: 290)   │ "nincada"                     │
            │ Tagged(rawValue: 291)   │ "ninjask"                     │
            │ Tagged(rawValue: 292)   │ "shedinja"                    │
            │ Tagged(rawValue: 293)   │ "whismur"                     │
            │ Tagged(rawValue: 294)   │ "loudred"                     │
            │ Tagged(rawValue: 295)   │ "exploud"                     │
            │ Tagged(rawValue: 296)   │ "makuhita"                    │
            │ Tagged(rawValue: 297)   │ "hariyama"                    │
            │ Tagged(rawValue: 298)   │ "azurill"                     │
            │ Tagged(rawValue: 299)   │ "nosepass"                    │
            │ Tagged(rawValue: 300)   │ "skitty"                      │
            │ Tagged(rawValue: 301)   │ "delcatty"                    │
            │ Tagged(rawValue: 302)   │ "sableye"                     │
            │ Tagged(rawValue: 303)   │ "mawile"                      │
            │ Tagged(rawValue: 304)   │ "aron"                        │
            │ Tagged(rawValue: 305)   │ "lairon"                      │
            │ Tagged(rawValue: 306)   │ "aggron"                      │
            │ Tagged(rawValue: 307)   │ "meditite"                    │
            │ Tagged(rawValue: 308)   │ "medicham"                    │
            │ Tagged(rawValue: 309)   │ "electrike"                   │
            │ Tagged(rawValue: 310)   │ "manectric"                   │
            │ Tagged(rawValue: 311)   │ "plusle"                      │
            │ Tagged(rawValue: 312)   │ "minun"                       │
            │ Tagged(rawValue: 313)   │ "volbeat"                     │
            │ Tagged(rawValue: 314)   │ "illumise"                    │
            │ Tagged(rawValue: 315)   │ "roselia"                     │
            │ Tagged(rawValue: 316)   │ "gulpin"                      │
            │ Tagged(rawValue: 317)   │ "swalot"                      │
            │ Tagged(rawValue: 318)   │ "carvanha"                    │
            │ Tagged(rawValue: 319)   │ "sharpedo"                    │
            │ Tagged(rawValue: 320)   │ "wailmer"                     │
            │ Tagged(rawValue: 321)   │ "wailord"                     │
            │ Tagged(rawValue: 322)   │ "numel"                       │
            │ Tagged(rawValue: 323)   │ "camerupt"                    │
            │ Tagged(rawValue: 324)   │ "torkoal"                     │
            │ Tagged(rawValue: 325)   │ "spoink"                      │
            │ Tagged(rawValue: 326)   │ "grumpig"                     │
            │ Tagged(rawValue: 327)   │ "spinda"                      │
            │ Tagged(rawValue: 328)   │ "trapinch"                    │
            │ Tagged(rawValue: 329)   │ "vibrava"                     │
            │ Tagged(rawValue: 330)   │ "flygon"                      │
            │ Tagged(rawValue: 331)   │ "cacnea"                      │
            │ Tagged(rawValue: 332)   │ "cacturne"                    │
            │ Tagged(rawValue: 333)   │ "swablu"                      │
            │ Tagged(rawValue: 334)   │ "altaria"                     │
            │ Tagged(rawValue: 335)   │ "zangoose"                    │
            │ Tagged(rawValue: 336)   │ "seviper"                     │
            │ Tagged(rawValue: 337)   │ "lunatone"                    │
            │ Tagged(rawValue: 338)   │ "solrock"                     │
            │ Tagged(rawValue: 339)   │ "barboach"                    │
            │ Tagged(rawValue: 340)   │ "whiscash"                    │
            │ Tagged(rawValue: 341)   │ "corphish"                    │
            │ Tagged(rawValue: 342)   │ "crawdaunt"                   │
            │ Tagged(rawValue: 343)   │ "baltoy"                      │
            │ Tagged(rawValue: 344)   │ "claydol"                     │
            │ Tagged(rawValue: 345)   │ "lileep"                      │
            │ Tagged(rawValue: 346)   │ "cradily"                     │
            │ Tagged(rawValue: 347)   │ "anorith"                     │
            │ Tagged(rawValue: 348)   │ "armaldo"                     │
            │ Tagged(rawValue: 349)   │ "feebas"                      │
            │ Tagged(rawValue: 350)   │ "milotic"                     │
            │ Tagged(rawValue: 351)   │ "castform"                    │
            │ Tagged(rawValue: 352)   │ "kecleon"                     │
            │ Tagged(rawValue: 353)   │ "shuppet"                     │
            │ Tagged(rawValue: 354)   │ "banette"                     │
            │ Tagged(rawValue: 355)   │ "duskull"                     │
            │ Tagged(rawValue: 356)   │ "dusclops"                    │
            │ Tagged(rawValue: 357)   │ "tropius"                     │
            │ Tagged(rawValue: 358)   │ "chimecho"                    │
            │ Tagged(rawValue: 359)   │ "absol"                       │
            │ Tagged(rawValue: 360)   │ "wynaut"                      │
            │ Tagged(rawValue: 361)   │ "snorunt"                     │
            │ Tagged(rawValue: 362)   │ "glalie"                      │
            │ Tagged(rawValue: 363)   │ "spheal"                      │
            │ Tagged(rawValue: 364)   │ "sealeo"                      │
            │ Tagged(rawValue: 365)   │ "walrein"                     │
            │ Tagged(rawValue: 366)   │ "clamperl"                    │
            │ Tagged(rawValue: 367)   │ "huntail"                     │
            │ Tagged(rawValue: 368)   │ "gorebyss"                    │
            │ Tagged(rawValue: 369)   │ "relicanth"                   │
            │ Tagged(rawValue: 370)   │ "luvdisc"                     │
            │ Tagged(rawValue: 371)   │ "bagon"                       │
            │ Tagged(rawValue: 372)   │ "shelgon"                     │
            │ Tagged(rawValue: 373)   │ "salamence"                   │
            │ Tagged(rawValue: 374)   │ "beldum"                      │
            │ Tagged(rawValue: 375)   │ "metang"                      │
            │ Tagged(rawValue: 376)   │ "metagross"                   │
            │ Tagged(rawValue: 377)   │ "regirock"                    │
            │ Tagged(rawValue: 378)   │ "regice"                      │
            │ Tagged(rawValue: 379)   │ "registeel"                   │
            │ Tagged(rawValue: 380)   │ "latias"                      │
            │ Tagged(rawValue: 381)   │ "latios"                      │
            │ Tagged(rawValue: 382)   │ "kyogre"                      │
            │ Tagged(rawValue: 383)   │ "groudon"                     │
            │ Tagged(rawValue: 384)   │ "rayquaza"                    │
            │ Tagged(rawValue: 385)   │ "jirachi"                     │
            │ Tagged(rawValue: 386)   │ "deoxys-normal"               │
            │ Tagged(rawValue: 387)   │ "turtwig"                     │
            │ Tagged(rawValue: 388)   │ "grotle"                      │
            │ Tagged(rawValue: 389)   │ "torterra"                    │
            │ Tagged(rawValue: 390)   │ "chimchar"                    │
            │ Tagged(rawValue: 391)   │ "monferno"                    │
            │ Tagged(rawValue: 392)   │ "infernape"                   │
            │ Tagged(rawValue: 393)   │ "piplup"                      │
            │ Tagged(rawValue: 394)   │ "prinplup"                    │
            │ Tagged(rawValue: 395)   │ "empoleon"                    │
            │ Tagged(rawValue: 396)   │ "starly"                      │
            │ Tagged(rawValue: 397)   │ "staravia"                    │
            │ Tagged(rawValue: 398)   │ "staraptor"                   │
            │ Tagged(rawValue: 399)   │ "bidoof"                      │
            │ Tagged(rawValue: 400)   │ "bibarel"                     │
            │ Tagged(rawValue: 401)   │ "kricketot"                   │
            │ Tagged(rawValue: 402)   │ "kricketune"                  │
            │ Tagged(rawValue: 403)   │ "shinx"                       │
            │ Tagged(rawValue: 404)   │ "luxio"                       │
            │ Tagged(rawValue: 405)   │ "luxray"                      │
            │ Tagged(rawValue: 406)   │ "budew"                       │
            │ Tagged(rawValue: 407)   │ "roserade"                    │
            │ Tagged(rawValue: 408)   │ "cranidos"                    │
            │ Tagged(rawValue: 409)   │ "rampardos"                   │
            │ Tagged(rawValue: 410)   │ "shieldon"                    │
            │ Tagged(rawValue: 411)   │ "bastiodon"                   │
            │ Tagged(rawValue: 412)   │ "burmy"                       │
            │ Tagged(rawValue: 413)   │ "wormadam-plant"              │
            │ Tagged(rawValue: 414)   │ "mothim"                      │
            │ Tagged(rawValue: 415)   │ "combee"                      │
            │ Tagged(rawValue: 416)   │ "vespiquen"                   │
            │ Tagged(rawValue: 417)   │ "pachirisu"                   │
            │ Tagged(rawValue: 418)   │ "buizel"                      │
            │ Tagged(rawValue: 419)   │ "floatzel"                    │
            │ Tagged(rawValue: 420)   │ "cherubi"                     │
            │ Tagged(rawValue: 421)   │ "cherrim"                     │
            │ Tagged(rawValue: 422)   │ "shellos"                     │
            │ Tagged(rawValue: 423)   │ "gastrodon"                   │
            │ Tagged(rawValue: 424)   │ "ambipom"                     │
            │ Tagged(rawValue: 425)   │ "drifloon"                    │
            │ Tagged(rawValue: 426)   │ "drifblim"                    │
            │ Tagged(rawValue: 427)   │ "buneary"                     │
            │ Tagged(rawValue: 428)   │ "lopunny"                     │
            │ Tagged(rawValue: 429)   │ "mismagius"                   │
            │ Tagged(rawValue: 430)   │ "honchkrow"                   │
            │ Tagged(rawValue: 431)   │ "glameow"                     │
            │ Tagged(rawValue: 432)   │ "purugly"                     │
            │ Tagged(rawValue: 433)   │ "chingling"                   │
            │ Tagged(rawValue: 434)   │ "stunky"                      │
            │ Tagged(rawValue: 435)   │ "skuntank"                    │
            │ Tagged(rawValue: 436)   │ "bronzor"                     │
            │ Tagged(rawValue: 437)   │ "bronzong"                    │
            │ Tagged(rawValue: 438)   │ "bonsly"                      │
            │ Tagged(rawValue: 439)   │ "mime-jr"                     │
            │ Tagged(rawValue: 440)   │ "happiny"                     │
            │ Tagged(rawValue: 441)   │ "chatot"                      │
            │ Tagged(rawValue: 442)   │ "spiritomb"                   │
            │ Tagged(rawValue: 443)   │ "gible"                       │
            │ Tagged(rawValue: 444)   │ "gabite"                      │
            │ Tagged(rawValue: 445)   │ "garchomp"                    │
            │ Tagged(rawValue: 446)   │ "munchlax"                    │
            │ Tagged(rawValue: 447)   │ "riolu"                       │
            │ Tagged(rawValue: 448)   │ "lucario"                     │
            │ Tagged(rawValue: 449)   │ "hippopotas"                  │
            │ Tagged(rawValue: 450)   │ "hippowdon"                   │
            │ Tagged(rawValue: 451)   │ "skorupi"                     │
            │ Tagged(rawValue: 452)   │ "drapion"                     │
            │ Tagged(rawValue: 453)   │ "croagunk"                    │
            │ Tagged(rawValue: 454)   │ "toxicroak"                   │
            │ Tagged(rawValue: 455)   │ "carnivine"                   │
            │ Tagged(rawValue: 456)   │ "finneon"                     │
            │ Tagged(rawValue: 457)   │ "lumineon"                    │
            │ Tagged(rawValue: 458)   │ "mantyke"                     │
            │ Tagged(rawValue: 459)   │ "snover"                      │
            │ Tagged(rawValue: 460)   │ "abomasnow"                   │
            │ Tagged(rawValue: 461)   │ "weavile"                     │
            │ Tagged(rawValue: 462)   │ "magnezone"                   │
            │ Tagged(rawValue: 463)   │ "lickilicky"                  │
            │ Tagged(rawValue: 464)   │ "rhyperior"                   │
            │ Tagged(rawValue: 465)   │ "tangrowth"                   │
            │ Tagged(rawValue: 466)   │ "electivire"                  │
            │ Tagged(rawValue: 467)   │ "magmortar"                   │
            │ Tagged(rawValue: 468)   │ "togekiss"                    │
            │ Tagged(rawValue: 469)   │ "yanmega"                     │
            │ Tagged(rawValue: 470)   │ "leafeon"                     │
            │ Tagged(rawValue: 471)   │ "glaceon"                     │
            │ Tagged(rawValue: 472)   │ "gliscor"                     │
            │ Tagged(rawValue: 473)   │ "mamoswine"                   │
            │ Tagged(rawValue: 474)   │ "porygon-z"                   │
            │ Tagged(rawValue: 475)   │ "gallade"                     │
            │ Tagged(rawValue: 476)   │ "probopass"                   │
            │ Tagged(rawValue: 477)   │ "dusknoir"                    │
            │ Tagged(rawValue: 478)   │ "froslass"                    │
            │ Tagged(rawValue: 479)   │ "rotom"                       │
            │ Tagged(rawValue: 480)   │ "uxie"                        │
            │ Tagged(rawValue: 481)   │ "mesprit"                     │
            │ Tagged(rawValue: 482)   │ "azelf"                       │
            │ Tagged(rawValue: 483)   │ "dialga"                      │
            │ Tagged(rawValue: 484)   │ "palkia"                      │
            │ Tagged(rawValue: 485)   │ "heatran"                     │
            │ Tagged(rawValue: 486)   │ "regigigas"                   │
            │ Tagged(rawValue: 487)   │ "giratina-altered"            │
            │ Tagged(rawValue: 488)   │ "cresselia"                   │
            │ Tagged(rawValue: 489)   │ "phione"                      │
            │ Tagged(rawValue: 490)   │ "manaphy"                     │
            │ Tagged(rawValue: 491)   │ "darkrai"                     │
            │ Tagged(rawValue: 492)   │ "shaymin-land"                │
            │ Tagged(rawValue: 493)   │ "arceus"                      │
            │ Tagged(rawValue: 494)   │ "victini"                     │
            │ Tagged(rawValue: 495)   │ "snivy"                       │
            │ Tagged(rawValue: 496)   │ "servine"                     │
            │ Tagged(rawValue: 497)   │ "serperior"                   │
            │ Tagged(rawValue: 498)   │ "tepig"                       │
            │ Tagged(rawValue: 499)   │ "pignite"                     │
            │ Tagged(rawValue: 500)   │ "emboar"                      │
            │ Tagged(rawValue: 501)   │ "oshawott"                    │
            │ Tagged(rawValue: 502)   │ "dewott"                      │
            │ Tagged(rawValue: 503)   │ "samurott"                    │
            │ Tagged(rawValue: 504)   │ "patrat"                      │
            │ Tagged(rawValue: 505)   │ "watchog"                     │
            │ Tagged(rawValue: 506)   │ "lillipup"                    │
            │ Tagged(rawValue: 507)   │ "herdier"                     │
            │ Tagged(rawValue: 508)   │ "stoutland"                   │
            │ Tagged(rawValue: 509)   │ "purrloin"                    │
            │ Tagged(rawValue: 510)   │ "liepard"                     │
            │ Tagged(rawValue: 511)   │ "pansage"                     │
            │ Tagged(rawValue: 512)   │ "simisage"                    │
            │ Tagged(rawValue: 513)   │ "pansear"                     │
            │ Tagged(rawValue: 514)   │ "simisear"                    │
            │ Tagged(rawValue: 515)   │ "panpour"                     │
            │ Tagged(rawValue: 516)   │ "simipour"                    │
            │ Tagged(rawValue: 517)   │ "munna"                       │
            │ Tagged(rawValue: 518)   │ "musharna"                    │
            │ Tagged(rawValue: 519)   │ "pidove"                      │
            │ Tagged(rawValue: 520)   │ "tranquill"                   │
            │ Tagged(rawValue: 521)   │ "unfezant"                    │
            │ Tagged(rawValue: 522)   │ "blitzle"                     │
            │ Tagged(rawValue: 523)   │ "zebstrika"                   │
            │ Tagged(rawValue: 524)   │ "roggenrola"                  │
            │ Tagged(rawValue: 525)   │ "boldore"                     │
            │ Tagged(rawValue: 526)   │ "gigalith"                    │
            │ Tagged(rawValue: 527)   │ "woobat"                      │
            │ Tagged(rawValue: 528)   │ "swoobat"                     │
            │ Tagged(rawValue: 529)   │ "drilbur"                     │
            │ Tagged(rawValue: 530)   │ "excadrill"                   │
            │ Tagged(rawValue: 531)   │ "audino"                      │
            │ Tagged(rawValue: 532)   │ "timburr"                     │
            │ Tagged(rawValue: 533)   │ "gurdurr"                     │
            │ Tagged(rawValue: 534)   │ "conkeldurr"                  │
            │ Tagged(rawValue: 535)   │ "tympole"                     │
            │ Tagged(rawValue: 536)   │ "palpitoad"                   │
            │ Tagged(rawValue: 537)   │ "seismitoad"                  │
            │ Tagged(rawValue: 538)   │ "throh"                       │
            │ Tagged(rawValue: 539)   │ "sawk"                        │
            │ Tagged(rawValue: 540)   │ "sewaddle"                    │
            │ Tagged(rawValue: 541)   │ "swadloon"                    │
            │ Tagged(rawValue: 542)   │ "leavanny"                    │
            │ Tagged(rawValue: 543)   │ "venipede"                    │
            │ Tagged(rawValue: 544)   │ "whirlipede"                  │
            │ Tagged(rawValue: 545)   │ "scolipede"                   │
            │ Tagged(rawValue: 546)   │ "cottonee"                    │
            │ Tagged(rawValue: 547)   │ "whimsicott"                  │
            │ Tagged(rawValue: 548)   │ "petilil"                     │
            │ Tagged(rawValue: 549)   │ "lilligant"                   │
            │ Tagged(rawValue: 550)   │ "basculin-red-striped"        │
            │ Tagged(rawValue: 551)   │ "sandile"                     │
            │ Tagged(rawValue: 552)   │ "krokorok"                    │
            │ Tagged(rawValue: 553)   │ "krookodile"                  │
            │ Tagged(rawValue: 554)   │ "darumaka"                    │
            │ Tagged(rawValue: 555)   │ "darmanitan-standard"         │
            │ Tagged(rawValue: 556)   │ "maractus"                    │
            │ Tagged(rawValue: 557)   │ "dwebble"                     │
            │ Tagged(rawValue: 558)   │ "crustle"                     │
            │ Tagged(rawValue: 559)   │ "scraggy"                     │
            │ Tagged(rawValue: 560)   │ "scrafty"                     │
            │ Tagged(rawValue: 561)   │ "sigilyph"                    │
            │ Tagged(rawValue: 562)   │ "yamask"                      │
            │ Tagged(rawValue: 563)   │ "cofagrigus"                  │
            │ Tagged(rawValue: 564)   │ "tirtouga"                    │
            │ Tagged(rawValue: 565)   │ "carracosta"                  │
            │ Tagged(rawValue: 566)   │ "archen"                      │
            │ Tagged(rawValue: 567)   │ "archeops"                    │
            │ Tagged(rawValue: 568)   │ "trubbish"                    │
            │ Tagged(rawValue: 569)   │ "garbodor"                    │
            │ Tagged(rawValue: 570)   │ "zorua"                       │
            │ Tagged(rawValue: 571)   │ "zoroark"                     │
            │ Tagged(rawValue: 572)   │ "minccino"                    │
            │ Tagged(rawValue: 573)   │ "cinccino"                    │
            │ Tagged(rawValue: 574)   │ "gothita"                     │
            │ Tagged(rawValue: 575)   │ "gothorita"                   │
            │ Tagged(rawValue: 576)   │ "gothitelle"                  │
            │ Tagged(rawValue: 577)   │ "solosis"                     │
            │ Tagged(rawValue: 578)   │ "duosion"                     │
            │ Tagged(rawValue: 579)   │ "reuniclus"                   │
            │ Tagged(rawValue: 580)   │ "ducklett"                    │
            │ Tagged(rawValue: 581)   │ "swanna"                      │
            │ Tagged(rawValue: 582)   │ "vanillite"                   │
            │ Tagged(rawValue: 583)   │ "vanillish"                   │
            │ Tagged(rawValue: 584)   │ "vanilluxe"                   │
            │ Tagged(rawValue: 585)   │ "deerling"                    │
            │ Tagged(rawValue: 586)   │ "sawsbuck"                    │
            │ Tagged(rawValue: 587)   │ "emolga"                      │
            │ Tagged(rawValue: 588)   │ "karrablast"                  │
            │ Tagged(rawValue: 589)   │ "escavalier"                  │
            │ Tagged(rawValue: 590)   │ "foongus"                     │
            │ Tagged(rawValue: 591)   │ "amoonguss"                   │
            │ Tagged(rawValue: 592)   │ "frillish"                    │
            │ Tagged(rawValue: 593)   │ "jellicent"                   │
            │ Tagged(rawValue: 594)   │ "alomomola"                   │
            │ Tagged(rawValue: 595)   │ "joltik"                      │
            │ Tagged(rawValue: 596)   │ "galvantula"                  │
            │ Tagged(rawValue: 597)   │ "ferroseed"                   │
            │ Tagged(rawValue: 598)   │ "ferrothorn"                  │
            │ Tagged(rawValue: 599)   │ "klink"                       │
            │ Tagged(rawValue: 600)   │ "klang"                       │
            │ Tagged(rawValue: 601)   │ "klinklang"                   │
            │ Tagged(rawValue: 602)   │ "tynamo"                      │
            │ Tagged(rawValue: 603)   │ "eelektrik"                   │
            │ Tagged(rawValue: 604)   │ "eelektross"                  │
            │ Tagged(rawValue: 605)   │ "elgyem"                      │
            │ Tagged(rawValue: 606)   │ "beheeyem"                    │
            │ Tagged(rawValue: 607)   │ "litwick"                     │
            │ Tagged(rawValue: 608)   │ "lampent"                     │
            │ Tagged(rawValue: 609)   │ "chandelure"                  │
            │ Tagged(rawValue: 610)   │ "axew"                        │
            │ Tagged(rawValue: 611)   │ "fraxure"                     │
            │ Tagged(rawValue: 612)   │ "haxorus"                     │
            │ Tagged(rawValue: 613)   │ "cubchoo"                     │
            │ Tagged(rawValue: 614)   │ "beartic"                     │
            │ Tagged(rawValue: 615)   │ "cryogonal"                   │
            │ Tagged(rawValue: 616)   │ "shelmet"                     │
            │ Tagged(rawValue: 617)   │ "accelgor"                    │
            │ Tagged(rawValue: 618)   │ "stunfisk"                    │
            │ Tagged(rawValue: 619)   │ "mienfoo"                     │
            │ Tagged(rawValue: 620)   │ "mienshao"                    │
            │ Tagged(rawValue: 621)   │ "druddigon"                   │
            │ Tagged(rawValue: 622)   │ "golett"                      │
            │ Tagged(rawValue: 623)   │ "golurk"                      │
            │ Tagged(rawValue: 624)   │ "pawniard"                    │
            │ Tagged(rawValue: 625)   │ "bisharp"                     │
            │ Tagged(rawValue: 626)   │ "bouffalant"                  │
            │ Tagged(rawValue: 627)   │ "rufflet"                     │
            │ Tagged(rawValue: 628)   │ "braviary"                    │
            │ Tagged(rawValue: 629)   │ "vullaby"                     │
            │ Tagged(rawValue: 630)   │ "mandibuzz"                   │
            │ Tagged(rawValue: 631)   │ "heatmor"                     │
            │ Tagged(rawValue: 632)   │ "durant"                      │
            │ Tagged(rawValue: 633)   │ "deino"                       │
            │ Tagged(rawValue: 634)   │ "zweilous"                    │
            │ Tagged(rawValue: 635)   │ "hydreigon"                   │
            │ Tagged(rawValue: 636)   │ "larvesta"                    │
            │ Tagged(rawValue: 637)   │ "volcarona"                   │
            │ Tagged(rawValue: 638)   │ "cobalion"                    │
            │ Tagged(rawValue: 639)   │ "terrakion"                   │
            │ Tagged(rawValue: 640)   │ "virizion"                    │
            │ Tagged(rawValue: 641)   │ "tornadus-incarnate"          │
            │ Tagged(rawValue: 642)   │ "thundurus-incarnate"         │
            │ Tagged(rawValue: 643)   │ "reshiram"                    │
            │ Tagged(rawValue: 644)   │ "zekrom"                      │
            │ Tagged(rawValue: 645)   │ "landorus-incarnate"          │
            │ Tagged(rawValue: 646)   │ "kyurem"                      │
            │ Tagged(rawValue: 647)   │ "keldeo-ordinary"             │
            │ Tagged(rawValue: 648)   │ "meloetta-aria"               │
            │ Tagged(rawValue: 649)   │ "genesect"                    │
            │ Tagged(rawValue: 650)   │ "chespin"                     │
            │ Tagged(rawValue: 651)   │ "quilladin"                   │
            │ Tagged(rawValue: 652)   │ "chesnaught"                  │
            │ Tagged(rawValue: 653)   │ "fennekin"                    │
            │ Tagged(rawValue: 654)   │ "braixen"                     │
            │ Tagged(rawValue: 655)   │ "delphox"                     │
            │ Tagged(rawValue: 656)   │ "froakie"                     │
            │ Tagged(rawValue: 657)   │ "frogadier"                   │
            │ Tagged(rawValue: 658)   │ "greninja"                    │
            │ Tagged(rawValue: 659)   │ "bunnelby"                    │
            │ Tagged(rawValue: 660)   │ "diggersby"                   │
            │ Tagged(rawValue: 661)   │ "fletchling"                  │
            │ Tagged(rawValue: 662)   │ "fletchinder"                 │
            │ Tagged(rawValue: 663)   │ "talonflame"                  │
            │ Tagged(rawValue: 664)   │ "scatterbug"                  │
            │ Tagged(rawValue: 665)   │ "spewpa"                      │
            │ Tagged(rawValue: 666)   │ "vivillon"                    │
            │ Tagged(rawValue: 667)   │ "litleo"                      │
            │ Tagged(rawValue: 668)   │ "pyroar"                      │
            │ Tagged(rawValue: 669)   │ "flabebe"                     │
            │ Tagged(rawValue: 670)   │ "floette"                     │
            │ Tagged(rawValue: 671)   │ "florges"                     │
            │ Tagged(rawValue: 672)   │ "skiddo"                      │
            │ Tagged(rawValue: 673)   │ "gogoat"                      │
            │ Tagged(rawValue: 674)   │ "pancham"                     │
            │ Tagged(rawValue: 675)   │ "pangoro"                     │
            │ Tagged(rawValue: 676)   │ "furfrou"                     │
            │ Tagged(rawValue: 677)   │ "espurr"                      │
            │ Tagged(rawValue: 678)   │ "meowstic-male"               │
            │ Tagged(rawValue: 679)   │ "honedge"                     │
            │ Tagged(rawValue: 680)   │ "doublade"                    │
            │ Tagged(rawValue: 681)   │ "aegislash-shield"            │
            │ Tagged(rawValue: 682)   │ "spritzee"                    │
            │ Tagged(rawValue: 683)   │ "aromatisse"                  │
            │ Tagged(rawValue: 684)   │ "swirlix"                     │
            │ Tagged(rawValue: 685)   │ "slurpuff"                    │
            │ Tagged(rawValue: 686)   │ "inkay"                       │
            │ Tagged(rawValue: 687)   │ "malamar"                     │
            │ Tagged(rawValue: 688)   │ "binacle"                     │
            │ Tagged(rawValue: 689)   │ "barbaracle"                  │
            │ Tagged(rawValue: 690)   │ "skrelp"                      │
            │ Tagged(rawValue: 691)   │ "dragalge"                    │
            │ Tagged(rawValue: 692)   │ "clauncher"                   │
            │ Tagged(rawValue: 693)   │ "clawitzer"                   │
            │ Tagged(rawValue: 694)   │ "helioptile"                  │
            │ Tagged(rawValue: 695)   │ "heliolisk"                   │
            │ Tagged(rawValue: 696)   │ "tyrunt"                      │
            │ Tagged(rawValue: 697)   │ "tyrantrum"                   │
            │ Tagged(rawValue: 698)   │ "amaura"                      │
            │ Tagged(rawValue: 699)   │ "aurorus"                     │
            │ Tagged(rawValue: 700)   │ "sylveon"                     │
            │ Tagged(rawValue: 701)   │ "hawlucha"                    │
            │ Tagged(rawValue: 702)   │ "dedenne"                     │
            │ Tagged(rawValue: 703)   │ "carbink"                     │
            │ Tagged(rawValue: 704)   │ "goomy"                       │
            │ Tagged(rawValue: 705)   │ "sliggoo"                     │
            │ Tagged(rawValue: 706)   │ "goodra"                      │
            │ Tagged(rawValue: 707)   │ "klefki"                      │
            │ Tagged(rawValue: 708)   │ "phantump"                    │
            │ Tagged(rawValue: 709)   │ "trevenant"                   │
            │ Tagged(rawValue: 710)   │ "pumpkaboo-average"           │
            │ Tagged(rawValue: 711)   │ "gourgeist-average"           │
            │ Tagged(rawValue: 712)   │ "bergmite"                    │
            │ Tagged(rawValue: 713)   │ "avalugg"                     │
            │ Tagged(rawValue: 714)   │ "noibat"                      │
            │ Tagged(rawValue: 715)   │ "noivern"                     │
            │ Tagged(rawValue: 716)   │ "xerneas"                     │
            │ Tagged(rawValue: 717)   │ "yveltal"                     │
            │ Tagged(rawValue: 718)   │ "zygarde-50"                  │
            │ Tagged(rawValue: 719)   │ "diancie"                     │
            │ Tagged(rawValue: 720)   │ "hoopa"                       │
            │ Tagged(rawValue: 721)   │ "volcanion"                   │
            │ Tagged(rawValue: 722)   │ "rowlet"                      │
            │ Tagged(rawValue: 723)   │ "dartrix"                     │
            │ Tagged(rawValue: 724)   │ "decidueye"                   │
            │ Tagged(rawValue: 725)   │ "litten"                      │
            │ Tagged(rawValue: 726)   │ "torracat"                    │
            │ Tagged(rawValue: 727)   │ "incineroar"                  │
            │ Tagged(rawValue: 728)   │ "popplio"                     │
            │ Tagged(rawValue: 729)   │ "brionne"                     │
            │ Tagged(rawValue: 730)   │ "primarina"                   │
            │ Tagged(rawValue: 731)   │ "pikipek"                     │
            │ Tagged(rawValue: 732)   │ "trumbeak"                    │
            │ Tagged(rawValue: 733)   │ "toucannon"                   │
            │ Tagged(rawValue: 734)   │ "yungoos"                     │
            │ Tagged(rawValue: 735)   │ "gumshoos"                    │
            │ Tagged(rawValue: 736)   │ "grubbin"                     │
            │ Tagged(rawValue: 737)   │ "charjabug"                   │
            │ Tagged(rawValue: 738)   │ "vikavolt"                    │
            │ Tagged(rawValue: 739)   │ "crabrawler"                  │
            │ Tagged(rawValue: 740)   │ "crabominable"                │
            │ Tagged(rawValue: 741)   │ "oricorio-baile"              │
            │ Tagged(rawValue: 742)   │ "cutiefly"                    │
            │ Tagged(rawValue: 743)   │ "ribombee"                    │
            │ Tagged(rawValue: 744)   │ "rockruff"                    │
            │ Tagged(rawValue: 745)   │ "lycanroc-midday"             │
            │ Tagged(rawValue: 746)   │ "wishiwashi-solo"             │
            │ Tagged(rawValue: 747)   │ "mareanie"                    │
            │ Tagged(rawValue: 748)   │ "toxapex"                     │
            │ Tagged(rawValue: 749)   │ "mudbray"                     │
            │ Tagged(rawValue: 750)   │ "mudsdale"                    │
            │ Tagged(rawValue: 751)   │ "dewpider"                    │
            │ Tagged(rawValue: 752)   │ "araquanid"                   │
            │ Tagged(rawValue: 753)   │ "fomantis"                    │
            │ Tagged(rawValue: 754)   │ "lurantis"                    │
            │ Tagged(rawValue: 755)   │ "morelull"                    │
            │ Tagged(rawValue: 756)   │ "shiinotic"                   │
            │ Tagged(rawValue: 757)   │ "salandit"                    │
            │ Tagged(rawValue: 758)   │ "salazzle"                    │
            │ Tagged(rawValue: 759)   │ "stufful"                     │
            │ Tagged(rawValue: 760)   │ "bewear"                      │
            │ Tagged(rawValue: 761)   │ "bounsweet"                   │
            │ Tagged(rawValue: 762)   │ "steenee"                     │
            │ Tagged(rawValue: 763)   │ "tsareena"                    │
            │ Tagged(rawValue: 764)   │ "comfey"                      │
            │ Tagged(rawValue: 765)   │ "oranguru"                    │
            │ Tagged(rawValue: 766)   │ "passimian"                   │
            │ Tagged(rawValue: 767)   │ "wimpod"                      │
            │ Tagged(rawValue: 768)   │ "golisopod"                   │
            │ Tagged(rawValue: 769)   │ "sandygast"                   │
            │ Tagged(rawValue: 770)   │ "palossand"                   │
            │ Tagged(rawValue: 771)   │ "pyukumuku"                   │
            │ Tagged(rawValue: 772)   │ "type-null"                   │
            │ Tagged(rawValue: 773)   │ "silvally"                    │
            │ Tagged(rawValue: 774)   │ "minior-red-meteor"           │
            │ Tagged(rawValue: 775)   │ "komala"                      │
            │ Tagged(rawValue: 776)   │ "turtonator"                  │
            │ Tagged(rawValue: 777)   │ "togedemaru"                  │
            │ Tagged(rawValue: 778)   │ "mimikyu-disguised"           │
            │ Tagged(rawValue: 779)   │ "bruxish"                     │
            │ Tagged(rawValue: 780)   │ "drampa"                      │
            │ Tagged(rawValue: 781)   │ "dhelmise"                    │
            │ Tagged(rawValue: 782)   │ "jangmo-o"                    │
            │ Tagged(rawValue: 783)   │ "hakamo-o"                    │
            │ Tagged(rawValue: 784)   │ "kommo-o"                     │
            │ Tagged(rawValue: 785)   │ "tapu-koko"                   │
            │ Tagged(rawValue: 786)   │ "tapu-lele"                   │
            │ Tagged(rawValue: 787)   │ "tapu-bulu"                   │
            │ Tagged(rawValue: 788)   │ "tapu-fini"                   │
            │ Tagged(rawValue: 789)   │ "cosmog"                      │
            │ Tagged(rawValue: 790)   │ "cosmoem"                     │
            │ Tagged(rawValue: 791)   │ "solgaleo"                    │
            │ Tagged(rawValue: 792)   │ "lunala"                      │
            │ Tagged(rawValue: 793)   │ "nihilego"                    │
            │ Tagged(rawValue: 794)   │ "buzzwole"                    │
            │ Tagged(rawValue: 795)   │ "pheromosa"                   │
            │ Tagged(rawValue: 796)   │ "xurkitree"                   │
            │ Tagged(rawValue: 797)   │ "celesteela"                  │
            │ Tagged(rawValue: 798)   │ "kartana"                     │
            │ Tagged(rawValue: 799)   │ "guzzlord"                    │
            │ Tagged(rawValue: 800)   │ "necrozma"                    │
            │ Tagged(rawValue: 801)   │ "magearna"                    │
            │ Tagged(rawValue: 802)   │ "marshadow"                   │
            │ Tagged(rawValue: 803)   │ "poipole"                     │
            │ Tagged(rawValue: 804)   │ "naganadel"                   │
            │ Tagged(rawValue: 805)   │ "stakataka"                   │
            │ Tagged(rawValue: 806)   │ "blacephalon"                 │
            │ Tagged(rawValue: 807)   │ "zeraora"                     │
            │ Tagged(rawValue: 808)   │ "meltan"                      │
            │ Tagged(rawValue: 809)   │ "melmetal"                    │
            │ Tagged(rawValue: 810)   │ "grookey"                     │
            │ Tagged(rawValue: 811)   │ "thwackey"                    │
            │ Tagged(rawValue: 812)   │ "rillaboom"                   │
            │ Tagged(rawValue: 813)   │ "scorbunny"                   │
            │ Tagged(rawValue: 814)   │ "raboot"                      │
            │ Tagged(rawValue: 815)   │ "cinderace"                   │
            │ Tagged(rawValue: 816)   │ "sobble"                      │
            │ Tagged(rawValue: 817)   │ "drizzile"                    │
            │ Tagged(rawValue: 818)   │ "inteleon"                    │
            │ Tagged(rawValue: 819)   │ "skwovet"                     │
            │ Tagged(rawValue: 820)   │ "greedent"                    │
            │ Tagged(rawValue: 821)   │ "rookidee"                    │
            │ Tagged(rawValue: 822)   │ "corvisquire"                 │
            │ Tagged(rawValue: 823)   │ "corviknight"                 │
            │ Tagged(rawValue: 824)   │ "blipbug"                     │
            │ Tagged(rawValue: 825)   │ "dottler"                     │
            │ Tagged(rawValue: 826)   │ "orbeetle"                    │
            │ Tagged(rawValue: 827)   │ "nickit"                      │
            │ Tagged(rawValue: 828)   │ "thievul"                     │
            │ Tagged(rawValue: 829)   │ "gossifleur"                  │
            │ Tagged(rawValue: 830)   │ "eldegoss"                    │
            │ Tagged(rawValue: 831)   │ "wooloo"                      │
            │ Tagged(rawValue: 832)   │ "dubwool"                     │
            │ Tagged(rawValue: 833)   │ "chewtle"                     │
            │ Tagged(rawValue: 834)   │ "drednaw"                     │
            │ Tagged(rawValue: 835)   │ "yamper"                      │
            │ Tagged(rawValue: 836)   │ "boltund"                     │
            │ Tagged(rawValue: 837)   │ "rolycoly"                    │
            │ Tagged(rawValue: 838)   │ "carkol"                      │
            │ Tagged(rawValue: 839)   │ "coalossal"                   │
            │ Tagged(rawValue: 840)   │ "applin"                      │
            │ Tagged(rawValue: 841)   │ "flapple"                     │
            │ Tagged(rawValue: 842)   │ "appletun"                    │
            │ Tagged(rawValue: 843)   │ "silicobra"                   │
            │ Tagged(rawValue: 844)   │ "sandaconda"                  │
            │ Tagged(rawValue: 845)   │ "cramorant"                   │
            │ Tagged(rawValue: 846)   │ "arrokuda"                    │
            │ Tagged(rawValue: 847)   │ "barraskewda"                 │
            │ Tagged(rawValue: 848)   │ "toxel"                       │
            │ Tagged(rawValue: 849)   │ "toxtricity-amped"            │
            │ Tagged(rawValue: 850)   │ "sizzlipede"                  │
            │ Tagged(rawValue: 851)   │ "centiskorch"                 │
            │ Tagged(rawValue: 852)   │ "clobbopus"                   │
            │ Tagged(rawValue: 853)   │ "grapploct"                   │
            │ Tagged(rawValue: 854)   │ "sinistea"                    │
            │ Tagged(rawValue: 855)   │ "polteageist"                 │
            │ Tagged(rawValue: 856)   │ "hatenna"                     │
            │ Tagged(rawValue: 857)   │ "hattrem"                     │
            │ Tagged(rawValue: 858)   │ "hatterene"                   │
            │ Tagged(rawValue: 859)   │ "impidimp"                    │
            │ Tagged(rawValue: 860)   │ "morgrem"                     │
            │ Tagged(rawValue: 861)   │ "grimmsnarl"                  │
            │ Tagged(rawValue: 862)   │ "obstagoon"                   │
            │ Tagged(rawValue: 863)   │ "perrserker"                  │
            │ Tagged(rawValue: 864)   │ "cursola"                     │
            │ Tagged(rawValue: 865)   │ "sirfetchd"                   │
            │ Tagged(rawValue: 866)   │ "mr-rime"                     │
            │ Tagged(rawValue: 867)   │ "runerigus"                   │
            │ Tagged(rawValue: 868)   │ "milcery"                     │
            │ Tagged(rawValue: 869)   │ "alcremie"                    │
            │ Tagged(rawValue: 870)   │ "falinks"                     │
            │ Tagged(rawValue: 871)   │ "pincurchin"                  │
            │ Tagged(rawValue: 872)   │ "snom"                        │
            │ Tagged(rawValue: 873)   │ "frosmoth"                    │
            │ Tagged(rawValue: 874)   │ "stonjourner"                 │
            │ Tagged(rawValue: 875)   │ "eiscue-ice"                  │
            │ Tagged(rawValue: 876)   │ "indeedee-male"               │
            │ Tagged(rawValue: 877)   │ "morpeko-full-belly"          │
            │ Tagged(rawValue: 878)   │ "cufant"                      │
            │ Tagged(rawValue: 879)   │ "copperajah"                  │
            │ Tagged(rawValue: 880)   │ "dracozolt"                   │
            │ Tagged(rawValue: 881)   │ "arctozolt"                   │
            │ Tagged(rawValue: 882)   │ "dracovish"                   │
            │ Tagged(rawValue: 883)   │ "arctovish"                   │
            │ Tagged(rawValue: 884)   │ "duraludon"                   │
            │ Tagged(rawValue: 885)   │ "dreepy"                      │
            │ Tagged(rawValue: 886)   │ "drakloak"                    │
            │ Tagged(rawValue: 887)   │ "dragapult"                   │
            │ Tagged(rawValue: 888)   │ "zacian"                      │
            │ Tagged(rawValue: 889)   │ "zamazenta"                   │
            │ Tagged(rawValue: 890)   │ "eternatus"                   │
            │ Tagged(rawValue: 891)   │ "kubfu"                       │
            │ Tagged(rawValue: 892)   │ "urshifu-single-strike"       │
            │ Tagged(rawValue: 893)   │ "zarude"                      │
            │ Tagged(rawValue: 894)   │ "regieleki"                   │
            │ Tagged(rawValue: 895)   │ "regidrago"                   │
            │ Tagged(rawValue: 896)   │ "glastrier"                   │
            │ Tagged(rawValue: 897)   │ "spectrier"                   │
            │ Tagged(rawValue: 898)   │ "calyrex"                     │
            │ Tagged(rawValue: 899)   │ "wyrdeer"                     │
            │ Tagged(rawValue: 900)   │ "kleavor"                     │
            │ Tagged(rawValue: 901)   │ "ursaluna"                    │
            │ Tagged(rawValue: 902)   │ "basculegion-male"            │
            │ Tagged(rawValue: 903)   │ "sneasler"                    │
            │ Tagged(rawValue: 904)   │ "overqwil"                    │
            │ Tagged(rawValue: 905)   │ "enamorus-incarnate"          │
            │ Tagged(rawValue: 906)   │ "sprigatito"                  │
            │ Tagged(rawValue: 907)   │ "floragato"                   │
            │ Tagged(rawValue: 908)   │ "meowscarada"                 │
            │ Tagged(rawValue: 909)   │ "fuecoco"                     │
            │ Tagged(rawValue: 910)   │ "crocalor"                    │
            │ Tagged(rawValue: 911)   │ "skeledirge"                  │
            │ Tagged(rawValue: 912)   │ "quaxly"                      │
            │ Tagged(rawValue: 913)   │ "quaxwell"                    │
            │ Tagged(rawValue: 914)   │ "quaquaval"                   │
            │ Tagged(rawValue: 915)   │ "lechonk"                     │
            │ Tagged(rawValue: 916)   │ "oinkologne-male"             │
            │ Tagged(rawValue: 917)   │ "tarountula"                  │
            │ Tagged(rawValue: 918)   │ "spidops"                     │
            │ Tagged(rawValue: 919)   │ "nymble"                      │
            │ Tagged(rawValue: 920)   │ "lokix"                       │
            │ Tagged(rawValue: 921)   │ "pawmi"                       │
            │ Tagged(rawValue: 922)   │ "pawmo"                       │
            │ Tagged(rawValue: 923)   │ "pawmot"                      │
            │ Tagged(rawValue: 924)   │ "tandemaus"                   │
            │ Tagged(rawValue: 925)   │ "maushold-family-of-four"     │
            │ Tagged(rawValue: 926)   │ "fidough"                     │
            │ Tagged(rawValue: 927)   │ "dachsbun"                    │
            │ Tagged(rawValue: 928)   │ "smoliv"                      │
            │ Tagged(rawValue: 929)   │ "dolliv"                      │
            │ Tagged(rawValue: 930)   │ "arboliva"                    │
            │ Tagged(rawValue: 931)   │ "squawkabilly-green-plumage"  │
            │ Tagged(rawValue: 932)   │ "nacli"                       │
            │ Tagged(rawValue: 933)   │ "naclstack"                   │
            │ Tagged(rawValue: 934)   │ "garganacl"                   │
            │ Tagged(rawValue: 935)   │ "charcadet"                   │
            │ Tagged(rawValue: 936)   │ "armarouge"                   │
            │ Tagged(rawValue: 937)   │ "ceruledge"                   │
            │ Tagged(rawValue: 938)   │ "tadbulb"                     │
            │ Tagged(rawValue: 939)   │ "bellibolt"                   │
            │ Tagged(rawValue: 940)   │ "wattrel"                     │
            │ Tagged(rawValue: 941)   │ "kilowattrel"                 │
            │ Tagged(rawValue: 942)   │ "maschiff"                    │
            │ Tagged(rawValue: 943)   │ "mabosstiff"                  │
            │ Tagged(rawValue: 944)   │ "shroodle"                    │
            │ Tagged(rawValue: 945)   │ "grafaiai"                    │
            │ Tagged(rawValue: 946)   │ "bramblin"                    │
            │ Tagged(rawValue: 947)   │ "brambleghast"                │
            │ Tagged(rawValue: 948)   │ "toedscool"                   │
            │ Tagged(rawValue: 949)   │ "toedscruel"                  │
            │ Tagged(rawValue: 950)   │ "klawf"                       │
            │ Tagged(rawValue: 951)   │ "capsakid"                    │
            │ Tagged(rawValue: 952)   │ "scovillain"                  │
            │ Tagged(rawValue: 953)   │ "rellor"                      │
            │ Tagged(rawValue: 954)   │ "rabsca"                      │
            │ Tagged(rawValue: 955)   │ "flittle"                     │
            │ Tagged(rawValue: 956)   │ "espathra"                    │
            │ Tagged(rawValue: 957)   │ "tinkatink"                   │
            │ Tagged(rawValue: 958)   │ "tinkatuff"                   │
            │ Tagged(rawValue: 959)   │ "tinkaton"                    │
            │ Tagged(rawValue: 960)   │ "wiglett"                     │
            │ Tagged(rawValue: 961)   │ "wugtrio"                     │
            │ Tagged(rawValue: 962)   │ "bombirdier"                  │
            │ Tagged(rawValue: 963)   │ "finizen"                     │
            │ Tagged(rawValue: 964)   │ "palafin-zero"                │
            │ Tagged(rawValue: 965)   │ "varoom"                      │
            │ Tagged(rawValue: 966)   │ "revavroom"                   │
            │ Tagged(rawValue: 967)   │ "cyclizar"                    │
            │ Tagged(rawValue: 968)   │ "orthworm"                    │
            │ Tagged(rawValue: 969)   │ "glimmet"                     │
            │ Tagged(rawValue: 970)   │ "glimmora"                    │
            │ Tagged(rawValue: 971)   │ "greavard"                    │
            │ Tagged(rawValue: 972)   │ "houndstone"                  │
            │ Tagged(rawValue: 973)   │ "flamigo"                     │
            │ Tagged(rawValue: 974)   │ "cetoddle"                    │
            │ Tagged(rawValue: 975)   │ "cetitan"                     │
            │ Tagged(rawValue: 976)   │ "veluza"                      │
            │ Tagged(rawValue: 977)   │ "dondozo"                     │
            │ Tagged(rawValue: 978)   │ "tatsugiri-curly"             │
            │ Tagged(rawValue: 979)   │ "annihilape"                  │
            │ Tagged(rawValue: 980)   │ "clodsire"                    │
            │ Tagged(rawValue: 981)   │ "farigiraf"                   │
            │ Tagged(rawValue: 982)   │ "dudunsparce-two-segment"     │
            │ Tagged(rawValue: 983)   │ "kingambit"                   │
            │ Tagged(rawValue: 984)   │ "great-tusk"                  │
            │ Tagged(rawValue: 985)   │ "scream-tail"                 │
            │ Tagged(rawValue: 986)   │ "brute-bonnet"                │
            │ Tagged(rawValue: 987)   │ "flutter-mane"                │
            │ Tagged(rawValue: 988)   │ "slither-wing"                │
            │ Tagged(rawValue: 989)   │ "sandy-shocks"                │
            │ Tagged(rawValue: 990)   │ "iron-treads"                 │
            │ Tagged(rawValue: 991)   │ "iron-bundle"                 │
            │ Tagged(rawValue: 992)   │ "iron-hands"                  │
            │ Tagged(rawValue: 993)   │ "iron-jugulis"                │
            │ Tagged(rawValue: 994)   │ "iron-moth"                   │
            │ Tagged(rawValue: 995)   │ "iron-thorns"                 │
            │ Tagged(rawValue: 996)   │ "frigibax"                    │
            │ Tagged(rawValue: 997)   │ "arctibax"                    │
            │ Tagged(rawValue: 998)   │ "baxcalibur"                  │
            │ Tagged(rawValue: 999)   │ "gimmighoul"                  │
            │ Tagged(rawValue: 1000)  │ "gholdengo"                   │
            │ Tagged(rawValue: 1001)  │ "wo-chien"                    │
            │ Tagged(rawValue: 1002)  │ "chien-pao"                   │
            │ Tagged(rawValue: 1003)  │ "ting-lu"                     │
            │ Tagged(rawValue: 1004)  │ "chi-yu"                      │
            │ Tagged(rawValue: 1005)  │ "roaring-moon"                │
            │ Tagged(rawValue: 1006)  │ "iron-valiant"                │
            │ Tagged(rawValue: 1007)  │ "koraidon"                    │
            │ Tagged(rawValue: 1008)  │ "miraidon"                    │
            │ Tagged(rawValue: 1009)  │ "walking-wake"                │
            │ Tagged(rawValue: 1010)  │ "iron-leaves"                 │
            │ Tagged(rawValue: 1011)  │ "dipplin"                     │
            │ Tagged(rawValue: 1012)  │ "poltchageist"                │
            │ Tagged(rawValue: 1013)  │ "sinistcha"                   │
            │ Tagged(rawValue: 1014)  │ "okidogi"                     │
            │ Tagged(rawValue: 1015)  │ "munkidori"                   │
            │ Tagged(rawValue: 1016)  │ "fezandipiti"                 │
            │ Tagged(rawValue: 1017)  │ "ogerpon"                     │
            │ Tagged(rawValue: 1018)  │ "archaludon"                  │
            │ Tagged(rawValue: 1019)  │ "hydrapple"                   │
            │ Tagged(rawValue: 1020)  │ "gouging-fire"                │
            │ Tagged(rawValue: 1021)  │ "raging-bolt"                 │
            │ Tagged(rawValue: 1022)  │ "iron-boulder"                │
            │ Tagged(rawValue: 1023)  │ "iron-crown"                  │
            │ Tagged(rawValue: 1024)  │ "terapagos"                   │
            │ Tagged(rawValue: 1025)  │ "pecharunt"                   │
            │ Tagged(rawValue: 10001) │ "deoxys-attack"               │
            │ Tagged(rawValue: 10002) │ "deoxys-defense"              │
            │ Tagged(rawValue: 10003) │ "deoxys-speed"                │
            │ Tagged(rawValue: 10004) │ "wormadam-sandy"              │
            │ Tagged(rawValue: 10005) │ "wormadam-trash"              │
            │ Tagged(rawValue: 10006) │ "shaymin-sky"                 │
            │ Tagged(rawValue: 10007) │ "giratina-origin"             │
            │ Tagged(rawValue: 10008) │ "rotom-heat"                  │
            │ Tagged(rawValue: 10009) │ "rotom-wash"                  │
            │ Tagged(rawValue: 10010) │ "rotom-frost"                 │
            │ Tagged(rawValue: 10011) │ "rotom-fan"                   │
            │ Tagged(rawValue: 10012) │ "rotom-mow"                   │
            │ Tagged(rawValue: 10013) │ "castform-sunny"              │
            │ Tagged(rawValue: 10014) │ "castform-rainy"              │
            │ Tagged(rawValue: 10015) │ "castform-snowy"              │
            │ Tagged(rawValue: 10016) │ "basculin-blue-striped"       │
            │ Tagged(rawValue: 10017) │ "darmanitan-zen"              │
            │ Tagged(rawValue: 10018) │ "meloetta-pirouette"          │
            │ Tagged(rawValue: 10019) │ "tornadus-therian"            │
            │ Tagged(rawValue: 10020) │ "thundurus-therian"           │
            │ Tagged(rawValue: 10021) │ "landorus-therian"            │
            │ Tagged(rawValue: 10022) │ "kyurem-black"                │
            │ Tagged(rawValue: 10023) │ "kyurem-white"                │
            │ Tagged(rawValue: 10024) │ "keldeo-resolute"             │
            │ Tagged(rawValue: 10025) │ "meowstic-female"             │
            │ Tagged(rawValue: 10026) │ "aegislash-blade"             │
            │ Tagged(rawValue: 10027) │ "pumpkaboo-small"             │
            │ Tagged(rawValue: 10028) │ "pumpkaboo-large"             │
            │ Tagged(rawValue: 10029) │ "pumpkaboo-super"             │
            │ Tagged(rawValue: 10030) │ "gourgeist-small"             │
            │ Tagged(rawValue: 10031) │ "gourgeist-large"             │
            │ Tagged(rawValue: 10032) │ "gourgeist-super"             │
            │ Tagged(rawValue: 10033) │ "venusaur-mega"               │
            │ Tagged(rawValue: 10034) │ "charizard-mega-x"            │
            │ Tagged(rawValue: 10035) │ "charizard-mega-y"            │
            │ Tagged(rawValue: 10036) │ "blastoise-mega"              │
            │ Tagged(rawValue: 10037) │ "alakazam-mega"               │
            │ Tagged(rawValue: 10038) │ "gengar-mega"                 │
            │ Tagged(rawValue: 10039) │ "kangaskhan-mega"             │
            │ Tagged(rawValue: 10040) │ "pinsir-mega"                 │
            │ Tagged(rawValue: 10041) │ "gyarados-mega"               │
            │ Tagged(rawValue: 10042) │ "aerodactyl-mega"             │
            │ Tagged(rawValue: 10043) │ "mewtwo-mega-x"               │
            │ Tagged(rawValue: 10044) │ "mewtwo-mega-y"               │
            │ Tagged(rawValue: 10045) │ "ampharos-mega"               │
            │ Tagged(rawValue: 10046) │ "scizor-mega"                 │
            │ Tagged(rawValue: 10047) │ "heracross-mega"              │
            │ Tagged(rawValue: 10048) │ "houndoom-mega"               │
            │ Tagged(rawValue: 10049) │ "tyranitar-mega"              │
            │ Tagged(rawValue: 10050) │ "blaziken-mega"               │
            │ Tagged(rawValue: 10051) │ "gardevoir-mega"              │
            │ Tagged(rawValue: 10052) │ "mawile-mega"                 │
            │ Tagged(rawValue: 10053) │ "aggron-mega"                 │
            │ Tagged(rawValue: 10054) │ "medicham-mega"               │
            │ Tagged(rawValue: 10055) │ "manectric-mega"              │
            │ Tagged(rawValue: 10056) │ "banette-mega"                │
            │ Tagged(rawValue: 10057) │ "absol-mega"                  │
            │ Tagged(rawValue: 10058) │ "garchomp-mega"               │
            │ Tagged(rawValue: 10059) │ "lucario-mega"                │
            │ Tagged(rawValue: 10060) │ "abomasnow-mega"              │
            │ Tagged(rawValue: 10061) │ "floette-eternal"             │
            │ Tagged(rawValue: 10062) │ "latias-mega"                 │
            │ Tagged(rawValue: 10063) │ "latios-mega"                 │
            │ Tagged(rawValue: 10064) │ "swampert-mega"               │
            │ Tagged(rawValue: 10065) │ "sceptile-mega"               │
            │ Tagged(rawValue: 10066) │ "sableye-mega"                │
            │ Tagged(rawValue: 10067) │ "altaria-mega"                │
            │ Tagged(rawValue: 10068) │ "gallade-mega"                │
            │ Tagged(rawValue: 10069) │ "audino-mega"                 │
            │ Tagged(rawValue: 10070) │ "sharpedo-mega"               │
            │ Tagged(rawValue: 10071) │ "slowbro-mega"                │
            │ Tagged(rawValue: 10072) │ "steelix-mega"                │
            │ Tagged(rawValue: 10073) │ "pidgeot-mega"                │
            │ Tagged(rawValue: 10074) │ "glalie-mega"                 │
            │ Tagged(rawValue: 10075) │ "diancie-mega"                │
            │ Tagged(rawValue: 10076) │ "metagross-mega"              │
            │ Tagged(rawValue: 10077) │ "kyogre-primal"               │
            │ Tagged(rawValue: 10078) │ "groudon-primal"              │
            │ Tagged(rawValue: 10079) │ "rayquaza-mega"               │
            │ Tagged(rawValue: 10080) │ "pikachu-rock-star"           │
            │ Tagged(rawValue: 10081) │ "pikachu-belle"               │
            │ Tagged(rawValue: 10082) │ "pikachu-pop-star"            │
            │ Tagged(rawValue: 10083) │ "pikachu-phd"                 │
            │ Tagged(rawValue: 10084) │ "pikachu-libre"               │
            │ Tagged(rawValue: 10085) │ "pikachu-cosplay"             │
            │ Tagged(rawValue: 10086) │ "hoopa-unbound"               │
            │ Tagged(rawValue: 10087) │ "camerupt-mega"               │
            │ Tagged(rawValue: 10088) │ "lopunny-mega"                │
            │ Tagged(rawValue: 10089) │ "salamence-mega"              │
            │ Tagged(rawValue: 10090) │ "beedrill-mega"               │
            │ Tagged(rawValue: 10091) │ "rattata-alola"               │
            │ Tagged(rawValue: 10092) │ "raticate-alola"              │
            │ Tagged(rawValue: 10093) │ "raticate-totem-alola"        │
            │ Tagged(rawValue: 10094) │ "pikachu-original-cap"        │
            │ Tagged(rawValue: 10095) │ "pikachu-hoenn-cap"           │
            │ Tagged(rawValue: 10096) │ "pikachu-sinnoh-cap"          │
            │ Tagged(rawValue: 10097) │ "pikachu-unova-cap"           │
            │ Tagged(rawValue: 10098) │ "pikachu-kalos-cap"           │
            │ Tagged(rawValue: 10099) │ "pikachu-alola-cap"           │
            │ Tagged(rawValue: 10100) │ "raichu-alola"                │
            │ Tagged(rawValue: 10101) │ "sandshrew-alola"             │
            │ Tagged(rawValue: 10102) │ "sandslash-alola"             │
            │ Tagged(rawValue: 10103) │ "vulpix-alola"                │
            │ Tagged(rawValue: 10104) │ "ninetales-alola"             │
            │ Tagged(rawValue: 10105) │ "diglett-alola"               │
            │ Tagged(rawValue: 10106) │ "dugtrio-alola"               │
            │ Tagged(rawValue: 10107) │ "meowth-alola"                │
            │ Tagged(rawValue: 10108) │ "persian-alola"               │
            │ Tagged(rawValue: 10109) │ "geodude-alola"               │
            │ Tagged(rawValue: 10110) │ "graveler-alola"              │
            │ Tagged(rawValue: 10111) │ "golem-alola"                 │
            │ Tagged(rawValue: 10112) │ "grimer-alola"                │
            │ Tagged(rawValue: 10113) │ "muk-alola"                   │
            │ Tagged(rawValue: 10114) │ "exeggutor-alola"             │
            │ Tagged(rawValue: 10115) │ "marowak-alola"               │
            │ Tagged(rawValue: 10116) │ "greninja-battle-bond"        │
            │ Tagged(rawValue: 10117) │ "greninja-ash"                │
            │ Tagged(rawValue: 10118) │ "zygarde-10-power-construct"  │
            │ Tagged(rawValue: 10119) │ "zygarde-50-power-construct"  │
            │ Tagged(rawValue: 10120) │ "zygarde-complete"            │
            │ Tagged(rawValue: 10121) │ "gumshoos-totem"              │
            │ Tagged(rawValue: 10122) │ "vikavolt-totem"              │
            │ Tagged(rawValue: 10123) │ "oricorio-pom-pom"            │
            │ Tagged(rawValue: 10124) │ "oricorio-pau"                │
            │ Tagged(rawValue: 10125) │ "oricorio-sensu"              │
            │ Tagged(rawValue: 10126) │ "lycanroc-midnight"           │
            │ Tagged(rawValue: 10127) │ "wishiwashi-school"           │
            │ Tagged(rawValue: 10128) │ "lurantis-totem"              │
            │ Tagged(rawValue: 10129) │ "salazzle-totem"              │
            │ Tagged(rawValue: 10130) │ "minior-orange-meteor"        │
            │ Tagged(rawValue: 10131) │ "minior-yellow-meteor"        │
            │ Tagged(rawValue: 10132) │ "minior-green-meteor"         │
            │ Tagged(rawValue: 10133) │ "minior-blue-meteor"          │
            │ Tagged(rawValue: 10134) │ "minior-indigo-meteor"        │
            │ Tagged(rawValue: 10135) │ "minior-violet-meteor"        │
            │ Tagged(rawValue: 10136) │ "minior-red"                  │
            │ Tagged(rawValue: 10137) │ "minior-orange"               │
            │ Tagged(rawValue: 10138) │ "minior-yellow"               │
            │ Tagged(rawValue: 10139) │ "minior-green"                │
            │ Tagged(rawValue: 10140) │ "minior-blue"                 │
            │ Tagged(rawValue: 10141) │ "minior-indigo"               │
            │ Tagged(rawValue: 10142) │ "minior-violet"               │
            │ Tagged(rawValue: 10143) │ "mimikyu-busted"              │
            │ Tagged(rawValue: 10144) │ "mimikyu-totem-disguised"     │
            │ Tagged(rawValue: 10145) │ "mimikyu-totem-busted"        │
            │ Tagged(rawValue: 10146) │ "kommo-o-totem"               │
            │ Tagged(rawValue: 10147) │ "magearna-original"           │
            │ Tagged(rawValue: 10148) │ "pikachu-partner-cap"         │
            │ Tagged(rawValue: 10149) │ "marowak-totem"               │
            │ Tagged(rawValue: 10150) │ "ribombee-totem"              │
            │ Tagged(rawValue: 10151) │ "rockruff-own-tempo"          │
            │ Tagged(rawValue: 10152) │ "lycanroc-dusk"               │
            │ Tagged(rawValue: 10153) │ "araquanid-totem"             │
            │ Tagged(rawValue: 10154) │ "togedemaru-totem"            │
            │ Tagged(rawValue: 10155) │ "necrozma-dusk"               │
            │ Tagged(rawValue: 10156) │ "necrozma-dawn"               │
            │ Tagged(rawValue: 10157) │ "necrozma-ultra"              │
            │ Tagged(rawValue: 10158) │ "pikachu-starter"             │
            │ Tagged(rawValue: 10159) │ "eevee-starter"               │
            │ Tagged(rawValue: 10160) │ "pikachu-world-cap"           │
            │ Tagged(rawValue: 10161) │ "meowth-galar"                │
            │ Tagged(rawValue: 10162) │ "ponyta-galar"                │
            │ Tagged(rawValue: 10163) │ "rapidash-galar"              │
            │ Tagged(rawValue: 10164) │ "slowpoke-galar"              │
            │ Tagged(rawValue: 10165) │ "slowbro-galar"               │
            │ Tagged(rawValue: 10166) │ "farfetchd-galar"             │
            │ Tagged(rawValue: 10167) │ "weezing-galar"               │
            │ Tagged(rawValue: 10168) │ "mr-mime-galar"               │
            │ Tagged(rawValue: 10169) │ "articuno-galar"              │
            │ Tagged(rawValue: 10170) │ "zapdos-galar"                │
            │ Tagged(rawValue: 10171) │ "moltres-galar"               │
            │ Tagged(rawValue: 10172) │ "slowking-galar"              │
            │ Tagged(rawValue: 10173) │ "corsola-galar"               │
            │ Tagged(rawValue: 10174) │ "zigzagoon-galar"             │
            │ Tagged(rawValue: 10175) │ "linoone-galar"               │
            │ Tagged(rawValue: 10176) │ "darumaka-galar"              │
            │ Tagged(rawValue: 10177) │ "darmanitan-galar-standard"   │
            │ Tagged(rawValue: 10178) │ "darmanitan-galar-zen"        │
            │ Tagged(rawValue: 10179) │ "yamask-galar"                │
            │ Tagged(rawValue: 10180) │ "stunfisk-galar"              │
            │ Tagged(rawValue: 10181) │ "zygarde-10"                  │
            │ Tagged(rawValue: 10182) │ "cramorant-gulping"           │
            │ Tagged(rawValue: 10183) │ "cramorant-gorging"           │
            │ Tagged(rawValue: 10184) │ "toxtricity-low-key"          │
            │ Tagged(rawValue: 10185) │ "eiscue-noice"                │
            │ Tagged(rawValue: 10186) │ "indeedee-female"             │
            │ Tagged(rawValue: 10187) │ "morpeko-hangry"              │
            │ Tagged(rawValue: 10188) │ "zacian-crowned"              │
            │ Tagged(rawValue: 10189) │ "zamazenta-crowned"           │
            │ Tagged(rawValue: 10190) │ "eternatus-eternamax"         │
            │ Tagged(rawValue: 10191) │ "urshifu-rapid-strike"        │
            │ Tagged(rawValue: 10192) │ "zarude-dada"                 │
            │ Tagged(rawValue: 10193) │ "calyrex-ice"                 │
            │ Tagged(rawValue: 10194) │ "calyrex-shadow"              │
            │ Tagged(rawValue: 10195) │ "venusaur-gmax"               │
            │ Tagged(rawValue: 10196) │ "charizard-gmax"              │
            │ Tagged(rawValue: 10197) │ "blastoise-gmax"              │
            │ Tagged(rawValue: 10198) │ "butterfree-gmax"             │
            │ Tagged(rawValue: 10199) │ "pikachu-gmax"                │
            │ Tagged(rawValue: 10200) │ "meowth-gmax"                 │
            │ Tagged(rawValue: 10201) │ "machamp-gmax"                │
            │ Tagged(rawValue: 10202) │ "gengar-gmax"                 │
            │ Tagged(rawValue: 10203) │ "kingler-gmax"                │
            │ Tagged(rawValue: 10204) │ "lapras-gmax"                 │
            │ Tagged(rawValue: 10205) │ "eevee-gmax"                  │
            │ Tagged(rawValue: 10206) │ "snorlax-gmax"                │
            │ Tagged(rawValue: 10207) │ "garbodor-gmax"               │
            │ Tagged(rawValue: 10208) │ "melmetal-gmax"               │
            │ Tagged(rawValue: 10209) │ "rillaboom-gmax"              │
            │ Tagged(rawValue: 10210) │ "cinderace-gmax"              │
            │ Tagged(rawValue: 10211) │ "inteleon-gmax"               │
            │ Tagged(rawValue: 10212) │ "corviknight-gmax"            │
            │ Tagged(rawValue: 10213) │ "orbeetle-gmax"               │
            │ Tagged(rawValue: 10214) │ "drednaw-gmax"                │
            │ Tagged(rawValue: 10215) │ "coalossal-gmax"              │
            │ Tagged(rawValue: 10216) │ "flapple-gmax"                │
            │ Tagged(rawValue: 10217) │ "appletun-gmax"               │
            │ Tagged(rawValue: 10218) │ "sandaconda-gmax"             │
            │ Tagged(rawValue: 10219) │ "toxtricity-amped-gmax"       │
            │ Tagged(rawValue: 10220) │ "centiskorch-gmax"            │
            │ Tagged(rawValue: 10221) │ "hatterene-gmax"              │
            │ Tagged(rawValue: 10222) │ "grimmsnarl-gmax"             │
            │ Tagged(rawValue: 10223) │ "alcremie-gmax"               │
            │ Tagged(rawValue: 10224) │ "copperajah-gmax"             │
            │ Tagged(rawValue: 10225) │ "duraludon-gmax"              │
            │ Tagged(rawValue: 10226) │ "urshifu-single-strike-gmax"  │
            │ Tagged(rawValue: 10227) │ "urshifu-rapid-strike-gmax"   │
            │ Tagged(rawValue: 10228) │ "toxtricity-low-key-gmax"     │
            │ Tagged(rawValue: 10229) │ "growlithe-hisui"             │
            │ Tagged(rawValue: 10230) │ "arcanine-hisui"              │
            │ Tagged(rawValue: 10231) │ "voltorb-hisui"               │
            │ Tagged(rawValue: 10232) │ "electrode-hisui"             │
            │ Tagged(rawValue: 10233) │ "typhlosion-hisui"            │
            │ Tagged(rawValue: 10234) │ "qwilfish-hisui"              │
            │ Tagged(rawValue: 10235) │ "sneasel-hisui"               │
            │ Tagged(rawValue: 10236) │ "samurott-hisui"              │
            │ Tagged(rawValue: 10237) │ "lilligant-hisui"             │
            │ Tagged(rawValue: 10238) │ "zorua-hisui"                 │
            │ Tagged(rawValue: 10239) │ "zoroark-hisui"               │
            │ Tagged(rawValue: 10240) │ "braviary-hisui"              │
            │ Tagged(rawValue: 10241) │ "sliggoo-hisui"               │
            │ Tagged(rawValue: 10242) │ "goodra-hisui"                │
            │ Tagged(rawValue: 10243) │ "avalugg-hisui"               │
            │ Tagged(rawValue: 10244) │ "decidueye-hisui"             │
            │ Tagged(rawValue: 10245) │ "dialga-origin"               │
            │ Tagged(rawValue: 10246) │ "palkia-origin"               │
            │ Tagged(rawValue: 10247) │ "basculin-white-striped"      │
            │ Tagged(rawValue: 10248) │ "basculegion-female"          │
            │ Tagged(rawValue: 10249) │ "enamorus-therian"            │
            │ Tagged(rawValue: 10250) │ "tauros-paldea-combat-breed"  │
            │ Tagged(rawValue: 10251) │ "tauros-paldea-blaze-breed"   │
            │ Tagged(rawValue: 10252) │ "tauros-paldea-aqua-breed"    │
            │ Tagged(rawValue: 10253) │ "wooper-paldea"               │
            │ Tagged(rawValue: 10254) │ "oinkologne-female"           │
            │ Tagged(rawValue: 10255) │ "dudunsparce-three-segment"   │
            │ Tagged(rawValue: 10256) │ "palafin-hero"                │
            │ Tagged(rawValue: 10257) │ "maushold-family-of-three"    │
            │ Tagged(rawValue: 10258) │ "tatsugiri-droopy"            │
            │ Tagged(rawValue: 10259) │ "tatsugiri-stretchy"          │
            │ Tagged(rawValue: 10260) │ "squawkabilly-blue-plumage"   │
            │ Tagged(rawValue: 10261) │ "squawkabilly-yellow-plumage" │
            │ Tagged(rawValue: 10262) │ "squawkabilly-white-plumage"  │
            │ Tagged(rawValue: 10263) │ "gimmighoul-roaming"          │
            │ Tagged(rawValue: 10264) │ "koraidon-limited-build"      │
            │ Tagged(rawValue: 10265) │ "koraidon-sprinting-build"    │
            │ Tagged(rawValue: 10266) │ "koraidon-swimming-build"     │
            │ Tagged(rawValue: 10267) │ "koraidon-gliding-build"      │
            │ Tagged(rawValue: 10268) │ "miraidon-low-power-mode"     │
            │ Tagged(rawValue: 10269) │ "miraidon-drive-mode"         │
            │ Tagged(rawValue: 10270) │ "miraidon-aquatic-mode"       │
            │ Tagged(rawValue: 10271) │ "miraidon-glide-mode"         │
            │ Tagged(rawValue: 10272) │ "ursaluna-bloodmoon"          │
            │ Tagged(rawValue: 10273) │ "ogerpon-wellspring-mask"     │
            │ Tagged(rawValue: 10274) │ "ogerpon-hearthflame-mask"    │
            │ Tagged(rawValue: 10275) │ "ogerpon-cornerstone-mask"    │
            │ Tagged(rawValue: 10276) │ "terapagos-terastal"          │
            │ Tagged(rawValue: 10277) │ "terapagos-stellar"           │
            └─────────────────────────┴───────────────────────────────┘
            """
        }
    }
}
