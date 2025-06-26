import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIPokemon {
    /// Represents a Pokemon species with all its available forms (base, Mega, Gigantamax, regional variants, etc.).
    /// 
    /// This is useful for team building where you want to see all possible forms of a Pokemon
    /// that might be available in a specific game version, including temporary transformations
    /// like Mega Evolution and Gigantamax that affect battle statistics.
    ///
    /// ```swift
    /// let charizardForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(database, speciesIdentifier: "charizard", versionId: 23)
    /// let megaForms = charizardForms.alternativeForms.filter { $0.isMegaForm }
    /// ```
    public struct WithAllForms {
        public let species: PokeAPIPokemonSpecies
        public let baseForms: [PokemonFormData]
        public let alternativeForms: [PokemonFormData]
        public let versionId: PokeAPIVersion.ID
        
        public init(
            species: PokeAPIPokemonSpecies,
            baseForms: [PokemonFormData],
            alternativeForms: [PokemonFormData],
            versionId: PokeAPIVersion.ID
        ) {
            self.species = species
            self.baseForms = baseForms
            self.alternativeForms = alternativeForms
            self.versionId = versionId
        }
        
        /// Contains a Pokemon form with all its relevant data
        public struct PokemonFormData {
            public let pokemon: PokeAPIPokemon
            public let stats: [StatData]
            public let encounters: [EncounterData]
            public let isDefault: Bool
            
            public init(
                pokemon: PokeAPIPokemon,
                stats: [StatData],
                encounters: [EncounterData],
                isDefault: Bool
            ) {
                self.pokemon = pokemon
                self.stats = stats
                self.encounters = encounters
                self.isDefault = isDefault
            }
            
            /// Total base stats for this Pokemon form
            public var totalStats: Int {
                return stats.reduce(0) { $0 + $1.baseStat }
            }
            
            /// Determines if this is a Mega Evolution form
            public var isMegaForm: Bool {
                return pokemon.identifier.contains("mega")
            }
            
            /// Determines if this is a Gigantamax form
            public var isGigantamaxForm: Bool {
                return pokemon.identifier.contains("gmax")
            }
            
            /// Determines if this is a regional variant (Alolan, Galarian, etc.)
            public var isRegionalVariant: Bool {
                return pokemon.identifier.contains("alola") || 
                       pokemon.identifier.contains("galar") ||
                       pokemon.identifier.contains("hisui") ||
                       pokemon.identifier.contains("paldea")
            }
            
            /// Determines if this is a costume or special event form
            public var isCostumeForm: Bool {
                return pokemon.identifier.contains("cap") ||
                       pokemon.identifier.contains("rock-star") ||
                       pokemon.identifier.contains("belle") ||
                       pokemon.identifier.contains("pop-star") ||
                       pokemon.identifier.contains("phd") ||
                       pokemon.identifier.contains("libre") ||
                       pokemon.identifier.contains("cosplay")
            }
            
            /// Determines if this is a battle mode form (Zen, Blade, Weather, etc.)
            public var isBattleModeForm: Bool {
                return pokemon.identifier.contains("zen") ||
                       pokemon.identifier.contains("blade") ||
                       pokemon.identifier.contains("sunny") ||
                       pokemon.identifier.contains("rainy") ||
                       pokemon.identifier.contains("snowy") ||
                       pokemon.identifier.contains("attack") ||
                       pokemon.identifier.contains("defense") ||
                       pokemon.identifier.contains("speed")
            }
            
            /// Determines if this is a legendary/mythical special form
            public var isLegendaryForm: Bool {
                return pokemon.identifier.contains("origin") ||
                       pokemon.identifier.contains("therian") ||
                       pokemon.identifier.contains("black") ||
                       pokemon.identifier.contains("white") ||
                       pokemon.identifier.contains("dusk") ||
                       pokemon.identifier.contains("dawn") ||
                       pokemon.identifier.contains("ice") ||
                       pokemon.identifier.contains("shadow") ||
                       pokemon.identifier.contains("complete")
            }
            
            /// Determines if this is a Totem form
            public var isTotemForm: Bool {
                return pokemon.identifier.contains("totem")
            }
            
            /// Returns the form category for this Pokemon
            public var formCategory: FormCategory {
                if isDefault { return .base }
                if isMegaForm { return .mega }
                if isGigantamaxForm { return .gigantamax }
                if isRegionalVariant { return .regional }
                if isTotemForm { return .totem }
                if isCostumeForm { return .costume }
                if isBattleModeForm { return .battleMode }
                if isLegendaryForm { return .legendary }
                return .other
            }
            
            /// Categories of Pokemon forms
            public enum FormCategory: String, CaseIterable {
                case base = "Base"
                case mega = "Mega Evolution"
                case gigantamax = "Gigantamax"
                case regional = "Regional Variant"
                case totem = "Totem"
                case costume = "Costume/Event"
                case battleMode = "Battle Mode"
                case legendary = "Legendary Form"
                case other = "Other"
            }
        }
        
        /// Contains stat data
        public struct StatData {
            public let stat: PokeAPIStat
            public let baseStat: Int
            public let effort: Int
            
            public init(stat: PokeAPIStat, baseStat: Int, effort: Int) {
                self.stat = stat
                self.baseStat = baseStat
                self.effort = effort
            }
        }
        
        /// Contains encounter data
        public struct EncounterData {
            public let encounter: PokeAPIEncounter
            public let locationArea: PokeAPILocationArea
            public let method: PokeAPIEncounterMethod
            public let slot: Int
            public let rarity: Int
            public let minLevel: Int
            public let maxLevel: Int
            
            public init(
                encounter: PokeAPIEncounter,
                locationArea: PokeAPILocationArea,
                method: PokeAPIEncounterMethod,
                slot: Int,
                rarity: Int,
                minLevel: Int,
                maxLevel: Int
            ) {
                self.encounter = encounter
                self.locationArea = locationArea
                self.method = method
                self.slot = slot
                self.rarity = rarity
                self.minLevel = minLevel
                self.maxLevel = maxLevel
            }
        }
        
        /// All forms (base + alternative) combined
        public var allForms: [PokemonFormData] {
            return baseForms + alternativeForms
        }
        
        /// The strongest form by total base stats
        public var strongestForm: PokemonFormData? {
            return allForms.max { $0.totalStats < $1.totalStats }
        }
        
        /// All Mega Evolution forms available
        public var megaForms: [PokemonFormData] {
            return alternativeForms.filter(\.isMegaForm)
        }
        
        /// All Gigantamax forms available
        public var gigantamaxForms: [PokemonFormData] {
            return alternativeForms.filter(\.isGigantamaxForm)
        }
        
        /// All regional variant forms available
        public var regionalVariants: [PokemonFormData] {
            return alternativeForms.filter(\.isRegionalVariant)
        }
        
        /// All Alolan forms available
        public var alolanForms: [PokemonFormData] {
            return alternativeForms.filter { $0.pokemon.identifier.contains("alola") }
        }
        
        /// All Galarian forms available
        public var galarianForms: [PokemonFormData] {
            return alternativeForms.filter { $0.pokemon.identifier.contains("galar") }
        }
        
        /// All Hisuian forms available
        public var hisuianForms: [PokemonFormData] {
            return alternativeForms.filter { $0.pokemon.identifier.contains("hisui") }
        }
        
        /// All Paldean forms available
        public var paldeanForms: [PokemonFormData] {
            return alternativeForms.filter { $0.pokemon.identifier.contains("paldea") }
        }
        
        /// All Totem forms available
        public var totemForms: [PokemonFormData] {
            return alternativeForms.filter { $0.pokemon.identifier.contains("totem") }
        }
        
        /// All costume/special event forms available
        public var costumeForms: [PokemonFormData] {
            return alternativeForms.filter(\.isCostumeForm)
        }
        
        /// All battle mode forms (Zen, Blade, Weather, etc.)
        public var battleModeForms: [PokemonFormData] {
            return alternativeForms.filter(\.isBattleModeForm)
        }
        
        /// All legendary/mythical special forms
        public var legendaryForms: [PokemonFormData] {
            return alternativeForms.filter(\.isLegendaryForm)
        }
        
        /// Get forms by specific category
        public func forms(ofCategory category: PokemonFormData.FormCategory) -> [PokemonFormData] {
            return allForms.filter { $0.formCategory == category }
        }
        
        /// Get all form categories present in this species
        public var availableCategories: [PokemonFormData.FormCategory] {
            return Array(Set(allForms.map(\.formCategory))).sorted { $0.rawValue < $1.rawValue }
        }
        
        // MARK: -
        
        /// Fetches all forms of a Pokemon species for a specific version.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - speciesIdentifier: The species identifier (e.g., "charizard", "pikachu")
        ///   - versionId: The game version to get encounters for
        /// - Returns: All forms of the species with their stats and encounters
        /// - Throws: `WithAllFormsError.speciesNotFound` if the species doesn't exist
        public static func fetchForSpecies(
            _ database: StructuredQueriesSQLite.Database,
            speciesIdentifier: String,
            versionId: PokeAPIVersion.ID
        ) throws -> PokeAPIPokemon.WithAllForms {
            // Get the species
            let speciesResults: [PokeAPIPokemonSpecies] = try database.execute(
                PokeAPIPokemonSpecies.all.where { $0.identifier == speciesIdentifier }
            )
            guard let species = speciesResults.first else {
                throw WithAllFormsError.speciesNotFound(speciesIdentifier)
            }
            
            return try fetchForSpecies(database, speciesId: species.id, versionId: versionId)
        }
        
        /// Fetches all forms of a Pokemon species for a specific version.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        ///   - speciesId: The species ID
        ///   - versionId: The game version to get encounters for
        /// - Returns: All forms of the species with their stats and encounters
        public static func fetchForSpecies(
            _ database: StructuredQueriesSQLite.Database,
            speciesId: PokeAPIPokemonSpecies.ID,
            versionId: PokeAPIVersion.ID
        ) throws -> PokeAPIPokemon.WithAllForms {
            // Get the species
            let speciesResults: [PokeAPIPokemonSpecies] = try database.execute(
                PokeAPIPokemonSpecies.all.where { $0.id == speciesId }
            )
            guard let species = speciesResults.first else {
                throw WithAllFormsError.speciesNotFound(speciesId.rawValue.description)
            }
            
            // Get all Pokemon forms for this species
            let allPokemonForms: [PokeAPIPokemon] = try database.execute(
                PokeAPIPokemon.all
                    .where { $0.speciesId == speciesId }
                    .order(by: \.id) // Order by ID for consistent ordering
            )
            
            // Filter forms based on availability in the target version
            let availableForms = try PokeAPIPokemonFormFiltering.filterFormsForVersion(
                database, 
                pokemon: allPokemonForms, 
                versionId: versionId
            )
            
            var baseForms: [PokemonFormData] = []
            var alternativeForms: [PokemonFormData] = []
            
            for pokemon in availableForms {
                // Get stats for this Pokemon form
                let stats = try fetchStatsForPokemon(database, pokemonId: pokemon.id)
                
                // Get encounters for this Pokemon form in the specified version
                let encounters = try fetchEncountersForPokemon(database, pokemonId: pokemon.id, versionId: versionId)
                
                let formData = PokemonFormData(
                    pokemon: pokemon,
                    stats: stats,
                    encounters: encounters,
                    isDefault: pokemon.isDefault
                )
                
                if pokemon.isDefault {
                    baseForms.append(formData)
                } else {
                    alternativeForms.append(formData)
                }
            }
            
            return WithAllForms(
                species: species,
                baseForms: baseForms,
                alternativeForms: alternativeForms,
                versionId: versionId
            )
        }
        
        // MARK: - Private Helpers
        
        /// Fetches all stat data for a specific Pokemon.
        private static func fetchStatsForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID
        ) throws -> [StatData] {
            let pokemonStats: [(PokeAPIPokemonStat, PokeAPIStat)] = try database.execute(
                PokeAPIPokemonStat.all
                    .where { $0.pokemonId == pokemonId }
                    .join(PokeAPIStat.all) { $0.statId == $1.id }
                    .order { $1.id }
            )
            return pokemonStats.map { (pokemonStat, stat) in
                StatData(
                    stat: stat,
                    baseStat: pokemonStat.baseStat,
                    effort: pokemonStat.effort
                )
            }
        }
        
        /// Fetches all encounter data for a specific Pokemon in a specific version.
        private static func fetchEncountersForPokemon(
            _ database: StructuredQueriesSQLite.Database,
            pokemonId: PokeAPIPokemon.ID,
            versionId: PokeAPIVersion.ID
        ) throws -> [EncounterData] {
            let encounters: [(PokeAPIEncounter, PokeAPILocationArea, PokeAPIEncounterSlot, PokeAPIEncounterMethod)] = try database.execute(
                PokeAPIEncounter.all
                    .where {
                        $0.pokemonId == pokemonId && $0.versionId == versionId
                    }
                    .join(PokeAPILocationArea.all, on: joinOn(encounter:location:))
                    .join(PokeAPIEncounterSlot.all, on: joinOn(encounter:location:encounterSlot:))
                    .join(PokeAPIEncounterMethod.all, on: joinOn(encounter:location:encounterSlot:encounterMethod:))
            )
            
            return encounters.map { (encounter, locationArea, encounterSlot, encounterMethod) in
                EncounterData(
                    encounter: encounter,
                    locationArea: locationArea,
                    method: encounterMethod,
                    slot: encounterSlot.slot ?? 1,
                    rarity: encounterSlot.rarity,
                    minLevel: encounter.minLevel,
                    maxLevel: encounter.maxLevel
                )
            }.sorted { lhs, rhs in
                if lhs.method.order != rhs.method.order {
                    return lhs.method.order < rhs.method.order
                }
                if lhs.rarity != rhs.rarity {
                    return lhs.rarity > rhs.rarity
                }
                return lhs.locationArea.id.rawValue < rhs.locationArea.id.rawValue
            }
        }
        
        private static func joinOn(
            encounter: PokeAPIEncounter.TableColumns,
            location: PokeAPILocationArea.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounter.locationAreaId.eq(location.id)
        }

        private static func joinOn(
            encounter: PokeAPIEncounter.TableColumns,
            location: PokeAPILocationArea.TableColumns,
            encounterSlot: PokeAPIEncounterSlot.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounter.encounterSlotId.eq(encounterSlot.id)
        }

        private static func joinOn(
            encounter: PokeAPIEncounter.TableColumns,
            location: PokeAPILocationArea.TableColumns,
            encounterSlot: PokeAPIEncounterSlot.TableColumns,
            encounterMethod: PokeAPIEncounterMethod.TableColumns
        ) -> some QueryExpression<Bool> {
            return encounterSlot.encounterMethodId.eq(encounterMethod.id)
        }
        
        
        // MARK: -
        
        private enum WithAllFormsError: Error {
            case speciesNotFound(String)
        }
    }
}