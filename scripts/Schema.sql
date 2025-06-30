CREATE TABLE IF NOT EXISTS "item_flavor_summaries" (
  "item_id" TEXT,
  "local_language_id" TEXT,
  "flavor_summary" TEXT,
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (local_language_id) REFERENCES languages(id)
);
CREATE TABLE IF NOT EXISTS "characteristics" (
  "id" INTEGER PRIMARY KEY,
  "stat_id" INTEGER,
  "gene_mod_5" INTEGER,
  FOREIGN KEY (stat_id) REFERENCES stats(id)
);
CREATE TABLE IF NOT EXISTS "type_efficacy" (
  "damage_type_id" INTEGER,
  "target_type_id" INTEGER,
  "damage_factor" INTEGER,
  FOREIGN KEY (damage_type_id) REFERENCES types(id),
  FOREIGN KEY (target_type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "berries" (
  "id" INTEGER PRIMARY KEY,
  "item_id" INTEGER,
  "firmness_id" INTEGER,
  "natural_gift_power" INTEGER,
  "natural_gift_type_id" INTEGER,
  "size" INTEGER,
  "max_harvest" INTEGER,
  "growth_time" INTEGER,
  "soil_dryness" INTEGER,
  "smoothness" INTEGER,
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (firmness_id) REFERENCES berry_firmness(id),
  FOREIGN KEY (natural_gift_type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_types_past" (
  "pokemon_id" INTEGER,
  "generation_id" INTEGER,
  "type_id" INTEGER,
  "slot" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "move_meta_stat_changes" (
  "move_id" INTEGER,
  "stat_id" INTEGER,
  "change" INTEGER,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (stat_id) REFERENCES stats(id)
);
CREATE TABLE IF NOT EXISTS "version_group_regions" (
  "version_group_id" INTEGER,
  "region_id" INTEGER,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (region_id) REFERENCES regions(id)
);
CREATE TABLE IF NOT EXISTS "generations" (
  "id" INTEGER PRIMARY KEY,
  "main_region_id" INTEGER,
  "identifier" TEXT,
  FOREIGN KEY (main_region_id) REFERENCES regions(id)
);
CREATE TABLE IF NOT EXISTS "pokedex_version_groups" (
  "pokedex_id" INTEGER,
  "version_group_id" INTEGER,
  FOREIGN KEY (pokedex_id) REFERENCES pokedexes(id),
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "item_fling_effects" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "nature_battle_style_preferences" (
  "nature_id" INTEGER,
  "move_battle_style_id" INTEGER,
  "low_hp_preference" INTEGER,
  "high_hp_preference" INTEGER,
  FOREIGN KEY (nature_id) REFERENCES natures(id),
  FOREIGN KEY (move_battle_style_id) REFERENCES move_battle_styles(id)
);
CREATE TABLE IF NOT EXISTS "move_meta" (
  "move_id" INTEGER,
  "meta_category_id" INTEGER,
  "meta_ailment_id" INTEGER,
  "min_hits" INTEGER,
  "max_hits" INTEGER,
  "min_turns" INTEGER,
  "max_turns" INTEGER,
  "drain" INTEGER,
  "healing" INTEGER,
  "crit_rate" INTEGER,
  "ailment_chance" INTEGER,
  "flinch_chance" INTEGER,
  "stat_chance" INTEGER,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (meta_category_id) REFERENCES move_meta_categories(id),
  FOREIGN KEY (meta_ailment_id) REFERENCES move_meta_ailments(id)
);
CREATE TABLE IF NOT EXISTS "regions" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "encounter_methods" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "order" INTEGER
);
CREATE TABLE IF NOT EXISTS "machines" (
  "machine_number" INTEGER,
  "version_group_id" INTEGER,
  "item_id" INTEGER,
  "move_id" INTEGER,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (move_id) REFERENCES moves(id)
);
CREATE TABLE IF NOT EXISTS "conquest_episodes" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "types" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "generation_id" INTEGER,
  "damage_class_id" INTEGER,
  FOREIGN KEY (generation_id) REFERENCES generations(id),
  FOREIGN KEY (damage_class_id) REFERENCES move_damage_classes(id)
);
CREATE TABLE IF NOT EXISTS "type_game_indices" (
  "type_id" INTEGER,
  "generation_id" INTEGER,
  "game_index" INTEGER,
  FOREIGN KEY (type_id) REFERENCES types(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_stats" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "conquest_max_links" (
  "warrior_rank_id" INTEGER,
  "pokemon_species_id" INTEGER,
  "max_link" INTEGER,
  FOREIGN KEY (warrior_rank_id) REFERENCES conquest_warrior_ranks(id),
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id)
);
CREATE TABLE IF NOT EXISTS "berry_flavors" (
  "berry_id" INTEGER,
  "contest_type_id" INTEGER,
  "flavor" INTEGER,
  FOREIGN KEY (berry_id) REFERENCES berries(id),
  FOREIGN KEY (contest_type_id) REFERENCES contest_types(id)
);
CREATE TABLE IF NOT EXISTS "item_game_indices" (
  "item_id" INTEGER,
  "generation_id" INTEGER,
  "game_index" INTEGER,
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "conquest_kingdoms" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "type_id" INTEGER,
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "conquest_pokemon_stats" (
  "pokemon_species_id" INTEGER,
  "conquest_stat_id" INTEGER,
  "base_stat" INTEGER,
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (conquest_stat_id) REFERENCES conquest_stats(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_colors" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "pokemon_shapes" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "item_pockets" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "pokemon_abilities_past" (
  "pokemon_id" INTEGER,
  "generation_id" INTEGER,
  "ability_id" INTEGER,
  "is_hidden" INTEGER,
  "slot" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id),
  FOREIGN KEY (ability_id) REFERENCES abilities(id)
);
CREATE TABLE IF NOT EXISTS "contest_effects" (
  "id" INTEGER PRIMARY KEY,
  "appeal" INTEGER,
  "jam" INTEGER
);
CREATE TABLE IF NOT EXISTS "location_game_indices" (
  "location_id" INTEGER,
  "generation_id" INTEGER,
  "game_index" INTEGER,
  FOREIGN KEY (location_id) REFERENCES locations(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_rank_stat_map" (
  "warrior_rank_id" INTEGER,
  "warrior_stat_id" INTEGER,
  "base_stat" INTEGER,
  FOREIGN KEY (warrior_rank_id) REFERENCES conquest_warrior_ranks(id),
  FOREIGN KEY (warrior_stat_id) REFERENCES conquest_warrior_stats(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_transformation" (
  "transformed_warrior_rank_id" INTEGER,
  "is_automatic" INTEGER,
  "required_link" INTEGER,
  "completed_episode_id" INTEGER,
  "current_episode_id" INTEGER,
  "distant_warrior_id" INTEGER,
  "female_warlord_count" INTEGER,
  "pokemon_count" INTEGER,
  "collection_type_id" INTEGER,
  "warrior_count" INTEGER,
  FOREIGN KEY (transformed_warrior_rank_id) REFERENCES conquest_warrior_ranks(id),
  FOREIGN KEY (completed_episode_id) REFERENCES conquest_episodes(id),
  FOREIGN KEY (current_episode_id) REFERENCES conquest_episodes(id),
  FOREIGN KEY (distant_warrior_id) REFERENCES conquest_warriors(id)
);
CREATE TABLE IF NOT EXISTS "move_flags" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "conquest_transformation_warriors" (
  "transformation_id" INTEGER,
  "present_warrior_id" INTEGER,
  FOREIGN KEY (transformation_id) REFERENCES conquest_warrior_transformation(transformed_warrior_rank_id),
  FOREIGN KEY (present_warrior_id) REFERENCES conquest_warriors(id)
);
CREATE TABLE IF NOT EXISTS "move_targets" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "move_flavor_summaries" (
  "move_id" TEXT,
  "local_language_id" TEXT,
  "flavor_summary" TEXT,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (local_language_id) REFERENCES languages(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_items" (
  "pokemon_id" INTEGER,
  "version_id" INTEGER,
  "item_id" INTEGER,
  "rarity" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (version_id) REFERENCES versions(id),
  FOREIGN KEY (item_id) REFERENCES items(id)
);
CREATE TABLE IF NOT EXISTS "stats" (
  "id" INTEGER PRIMARY KEY,
  "damage_class_id" INTEGER,
  "identifier" TEXT,
  "is_battle_only" INTEGER,
  "game_index" INTEGER,
  FOREIGN KEY (damage_class_id) REFERENCES move_damage_classes(id)
);
CREATE TABLE IF NOT EXISTS "encounter_condition_value_map" (
  "encounter_id" INTEGER,
  "encounter_condition_value_id" INTEGER,
  FOREIGN KEY (encounter_id) REFERENCES encounters(id),
  FOREIGN KEY (encounter_condition_value_id) REFERENCES encounter_condition_values(id)
);
CREATE TABLE IF NOT EXISTS "item_flag_map" (
  "item_id" INTEGER,
  "item_flag_id" INTEGER,
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (item_flag_id) REFERENCES item_flags(id)
);
CREATE TABLE IF NOT EXISTS "conquest_stats" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "is_base" INTEGER
);
CREATE TABLE IF NOT EXISTS "super_contest_combos" (
  "first_move_id" INTEGER,
  "second_move_id" INTEGER,
  FOREIGN KEY (first_move_id) REFERENCES moves(id),
  FOREIGN KEY (second_move_id) REFERENCES moves(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_species_flavor_summaries" (
  "pokemon_species_id" TEXT,
  "local_language_id" TEXT,
  "flavor_summary" TEXT,
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (local_language_id) REFERENCES languages(id)
);
CREATE TABLE IF NOT EXISTS "super_contest_effects" (
  "id" INTEGER PRIMARY KEY,
  "appeal" INTEGER
);
CREATE TABLE IF NOT EXISTS "location_area_encounter_rates" (
  "location_area_id" INTEGER,
  "encounter_method_id" INTEGER,
  "version_id" INTEGER,
  "rate" INTEGER,
  FOREIGN KEY (location_area_id) REFERENCES location_areas(id),
  FOREIGN KEY (encounter_method_id) REFERENCES encounter_methods(id),
  FOREIGN KEY (version_id) REFERENCES versions(id)
);
CREATE TABLE IF NOT EXISTS "move_meta_ailments" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "pokemon_move_methods" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "growth_rates" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "formula" TEXT
);
CREATE TABLE IF NOT EXISTS "item_categories" (
  "id" INTEGER PRIMARY KEY,
  "pocket_id" INTEGER,
  "identifier" TEXT,
  FOREIGN KEY (pocket_id) REFERENCES item_pockets(id)
);
CREATE TABLE IF NOT EXISTS "contest_combos" (
  "first_move_id" INTEGER,
  "second_move_id" INTEGER,
  FOREIGN KEY (first_move_id) REFERENCES moves(id),
  FOREIGN KEY (second_move_id) REFERENCES moves(id)
);
CREATE TABLE IF NOT EXISTS "encounter_slots" (
  "id" INTEGER PRIMARY KEY,
  "version_group_id" INTEGER,
  "encounter_method_id" INTEGER,
  "slot" INTEGER,
  "rarity" INTEGER,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (encounter_method_id) REFERENCES encounter_methods(id)
);
CREATE TABLE IF NOT EXISTS "ability_changelog" (
  "id" INTEGER PRIMARY KEY,
  "ability_id" INTEGER,
  "changed_in_version_group_id" INTEGER,
  FOREIGN KEY (ability_id) REFERENCES abilities(id),
  FOREIGN KEY (changed_in_version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_moves" (
  "pokemon_id" INTEGER,
  "version_group_id" INTEGER,
  "move_id" INTEGER,
  "pokemon_move_method_id" INTEGER,
  "level" INTEGER,
  "order" INTEGER,
  "mastery" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (pokemon_move_method_id) REFERENCES pokemon_move_methods(id)
);
CREATE TABLE IF NOT EXISTS "pal_park_areas" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "move_flag_map" (
  "move_id" INTEGER,
  "move_flag_id" INTEGER,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (move_flag_id) REFERENCES move_flags(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_egg_groups" (
  "species_id" INTEGER,
  "egg_group_id" INTEGER,
  FOREIGN KEY (species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (egg_group_id) REFERENCES egg_groups(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_ranks" (
  "id" INTEGER PRIMARY KEY,
  "warrior_id" INTEGER,
  "rank" INTEGER,
  "skill_id" INTEGER,
  FOREIGN KEY (warrior_id) REFERENCES conquest_warriors(id),
  FOREIGN KEY (skill_id) REFERENCES conquest_warrior_skills(id)
);
CREATE TABLE IF NOT EXISTS "move_battle_styles" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_specialties" (
  "warrior_id" INTEGER,
  "type_id" INTEGER,
  "slot" INTEGER,
  FOREIGN KEY (warrior_id) REFERENCES conquest_warriors(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_form_types" (
  "pokemon_form_id" INTEGER,
  "type_id" INTEGER,
  "slot" INTEGER,
  FOREIGN KEY (pokemon_form_id) REFERENCES pokemon_forms(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_types" (
  "pokemon_id" INTEGER,
  "type_id" INTEGER,
  "slot" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_skills" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "conquest_pokemon_moves" (
  "pokemon_species_id" INTEGER,
  "move_id" INTEGER,
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (move_id) REFERENCES moves(id)
);
CREATE TABLE IF NOT EXISTS "conquest_move_effects" (
  "id" INTEGER
);
CREATE TABLE IF NOT EXISTS "abilities" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "generation_id" INTEGER,
  "is_main_series" INTEGER,
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "encounter_condition_values" (
  "id" INTEGER PRIMARY KEY,
  "encounter_condition_id" INTEGER,
  "identifier" TEXT,
  "is_default" INTEGER,
  FOREIGN KEY (encounter_condition_id) REFERENCES encounter_conditions(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_form_pokeathlon_stats" (
  "pokemon_form_id" INTEGER,
  "pokeathlon_stat_id" INTEGER,
  "minimum_stat" INTEGER,
  "base_stat" INTEGER,
  "maximum_stat" INTEGER,
  FOREIGN KEY (pokemon_form_id) REFERENCES pokemon_forms(id),
  FOREIGN KEY (pokeathlon_stat_id) REFERENCES pokeathlon_stats(id)
);
CREATE TABLE IF NOT EXISTS "conquest_episode_warriors" (
  "episode_id" INTEGER,
  "warrior_id" INTEGER,
  FOREIGN KEY (episode_id) REFERENCES conquest_episodes(id),
  FOREIGN KEY (warrior_id) REFERENCES conquest_warriors(id)
);
CREATE TABLE IF NOT EXISTS "locations" (
  "id" INTEGER PRIMARY KEY,
  "region_id" INTEGER,
  "identifier" TEXT,
  FOREIGN KEY (region_id) REFERENCES regions(id)
);
CREATE TABLE IF NOT EXISTS "pokemon" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "species_id" INTEGER,
  "height" INTEGER,
  "weight" INTEGER,
  "base_experience" INTEGER,
  "order" INTEGER,
  "is_default" INTEGER,
  FOREIGN KEY (species_id) REFERENCES pokemon_species(id)
);
CREATE TABLE IF NOT EXISTS "encounters" (
  "id" INTEGER PRIMARY KEY,
  "version_id" INTEGER,
  "location_area_id" INTEGER,
  "encounter_slot_id" INTEGER,
  "pokemon_id" INTEGER,
  "min_level" INTEGER,
  "max_level" INTEGER,
  FOREIGN KEY (version_id) REFERENCES versions(id),
  FOREIGN KEY (location_area_id) REFERENCES location_areas(id),
  FOREIGN KEY (encounter_slot_id) REFERENCES encounter_slots(id),
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_dex_numbers" (
  "species_id" INTEGER,
  "pokedex_id" INTEGER,
  "pokedex_number" INTEGER,
  FOREIGN KEY (species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (pokedex_id) REFERENCES pokedexes(id)
);
CREATE TABLE IF NOT EXISTS "egg_groups" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "evolution_chains" (
  "id" INTEGER PRIMARY KEY,
  "baby_trigger_item_id" INTEGER,
  FOREIGN KEY (baby_trigger_item_id) REFERENCES items(id)
);
CREATE TABLE IF NOT EXISTS "conquest_pokemon_evolution" (
  "evolved_species_id" INTEGER,
  "required_stat_id" INTEGER,
  "minimum_stat" INTEGER,
  "minimum_link" INTEGER,
  "kingdom_id" INTEGER,
  "warrior_gender_id" INTEGER,
  "item_id" INTEGER,
  "recruiting_ko_required" INTEGER,
  FOREIGN KEY (evolved_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (required_stat_id) REFERENCES conquest_stats(id),
  FOREIGN KEY (kingdom_id) REFERENCES conquest_kingdoms(id),
  FOREIGN KEY (warrior_gender_id) REFERENCES genders(id),
  FOREIGN KEY (item_id) REFERENCES items(id)
);
CREATE TABLE IF NOT EXISTS "move_effects" (
  "id" INTEGER
);
CREATE TABLE IF NOT EXISTS "pokedexes" (
  "id" INTEGER PRIMARY KEY,
  "region_id" INTEGER,
  "identifier" TEXT,
  "is_main_series" INTEGER,
  FOREIGN KEY (region_id) REFERENCES regions(id)
);
CREATE TABLE IF NOT EXISTS "move_effect_changelog" (
  "id" INTEGER PRIMARY KEY,
  "effect_id" INTEGER,
  "changed_in_version_group_id" INTEGER,
  FOREIGN KEY (effect_id) REFERENCES move_effects(id),
  FOREIGN KEY (changed_in_version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "conquest_move_data" (
  "move_id" INTEGER,
  "power" INTEGER,
  "accuracy" INTEGER,
  "effect_chance" INTEGER,
  "effect_id" INTEGER,
  "range_id" INTEGER,
  "displacement_id" INTEGER,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (effect_id) REFERENCES conquest_move_effects(id),
  FOREIGN KEY (range_id) REFERENCES conquest_move_ranges(id),
  FOREIGN KEY (displacement_id) REFERENCES conquest_move_displacements(id)
);
CREATE TABLE IF NOT EXISTS "conquest_transformation_pokemon" (
  "transformation_id" INTEGER,
  "pokemon_species_id" INTEGER,
  FOREIGN KEY (transformation_id) REFERENCES conquest_warrior_transformation(transformed_warrior_rank_id),
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id)
);
CREATE TABLE IF NOT EXISTS "pal_park" (
  "species_id" INTEGER,
  "area_id" INTEGER,
  "base_score" INTEGER,
  "rate" INTEGER,
  FOREIGN KEY (species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (area_id) REFERENCES pal_park_areas(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_game_indices" (
  "pokemon_id" INTEGER,
  "version_id" INTEGER,
  "game_index" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (version_id) REFERENCES versions(id)
);
CREATE TABLE IF NOT EXISTS "evolution_triggers" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "encounter_conditions" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "pokemon_abilities" (
  "pokemon_id" INTEGER,
  "ability_id" INTEGER,
  "is_hidden" INTEGER,
  "slot" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (ability_id) REFERENCES abilities(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_forms" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "form_identifier" TEXT,
  "pokemon_id" INTEGER,
  "introduced_in_version_group_id" INTEGER,
  "is_default" INTEGER,
  "is_battle_only" INTEGER,
  "is_mega" INTEGER,
  "form_order" INTEGER,
  "order" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (introduced_in_version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "move_meta_categories" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "version_groups" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "generation_id" INTEGER,
  "order" INTEGER,
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warriors" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "gender_id" INTEGER,
  "archetype_id" INTEGER,
  FOREIGN KEY (gender_id) REFERENCES genders(id),
  FOREIGN KEY (archetype_id) REFERENCES conquest_warrior_archetypes(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_stats" (
  "pokemon_id" INTEGER,
  "stat_id" INTEGER,
  "base_stat" INTEGER,
  "effort" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (stat_id) REFERENCES stats(id)
);
CREATE TABLE IF NOT EXISTS "location_areas" (
  "id" INTEGER PRIMARY KEY,
  "location_id" INTEGER,
  "game_index" INTEGER,
  "identifier" TEXT,
  FOREIGN KEY (location_id) REFERENCES locations(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_species" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "generation_id" INTEGER,
  "evolves_from_species_id" INTEGER,
  "evolution_chain_id" INTEGER,
  "color_id" INTEGER,
  "shape_id" INTEGER,
  "habitat_id" INTEGER,
  "gender_rate" INTEGER,
  "capture_rate" INTEGER,
  "base_happiness" INTEGER,
  "is_baby" INTEGER,
  "hatch_counter" INTEGER,
  "has_gender_differences" INTEGER,
  "growth_rate_id" INTEGER,
  "forms_switchable" INTEGER,
  "is_legendary" INTEGER,
  "is_mythical" INTEGER,
  "order" INTEGER,
  "conquest_order" INTEGER,
  FOREIGN KEY (generation_id) REFERENCES generations(id),
  FOREIGN KEY (evolves_from_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (evolution_chain_id) REFERENCES evolution_chains(id),
  FOREIGN KEY (color_id) REFERENCES pokemon_colors(id),
  FOREIGN KEY (shape_id) REFERENCES pokemon_shapes(id),
  FOREIGN KEY (habitat_id) REFERENCES pokemon_habitats(id),
  FOREIGN KEY (growth_rate_id) REFERENCES growth_rates(id)
);
CREATE TABLE IF NOT EXISTS "items" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "category_id" INTEGER,
  "cost" INTEGER,
  "fling_power" INTEGER,
  "fling_effect_id" INTEGER,
  FOREIGN KEY (category_id) REFERENCES item_categories(id),
  FOREIGN KEY (fling_effect_id) REFERENCES item_fling_effects(id)
);
CREATE TABLE IF NOT EXISTS "version_group_pokemon_move_methods" (
  "version_group_id" INTEGER,
  "pokemon_move_method_id" INTEGER,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (pokemon_move_method_id) REFERENCES pokemon_move_methods(id)
);
CREATE TABLE IF NOT EXISTS "move_changelog" (
  "move_id" INTEGER,
  "changed_in_version_group_id" INTEGER,
  "type_id" INTEGER,
  "power" INTEGER,
  "pp" INTEGER,
  "accuracy" INTEGER,
  "priority" INTEGER,
  "target_id" INTEGER,
  "effect_id" INTEGER,
  "effect_chance" INTEGER,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (changed_in_version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (type_id) REFERENCES types(id),
  FOREIGN KEY (target_id) REFERENCES move_targets(id),
  FOREIGN KEY (effect_id) REFERENCES move_effects(id)
);
CREATE TABLE IF NOT EXISTS "move_damage_classes" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_archetypes" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "versions" (
  "id" INTEGER PRIMARY KEY,
  "version_group_id" INTEGER,
  "identifier" TEXT,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "nature_pokeathlon_stats" (
  "nature_id" INTEGER,
  "pokeathlon_stat_id" INTEGER,
  "max_change" INTEGER,
  FOREIGN KEY (nature_id) REFERENCES natures(id),
  FOREIGN KEY (pokeathlon_stat_id) REFERENCES pokeathlon_stats(id)
);
CREATE TABLE IF NOT EXISTS "conquest_pokemon_abilities" (
  "pokemon_species_id" INTEGER,
  "slot" INTEGER,
  "ability_id" INTEGER,
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (ability_id) REFERENCES abilities(id)
);
CREATE TABLE IF NOT EXISTS "berry_firmness" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "pokemon_form_generations" (
  "pokemon_form_id" INTEGER,
  "generation_id" INTEGER,
  "game_index" INTEGER,
  FOREIGN KEY (pokemon_form_id) REFERENCES pokemon_forms(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "languages" (
  "id" INTEGER PRIMARY KEY,
  "iso639" TEXT,
  "iso3166" TEXT,
  "identifier" TEXT,
  "official" INTEGER,
  "order" INTEGER
);
CREATE TABLE IF NOT EXISTS "type_efficacy_past" (
  "damage_type_id" INTEGER,
  "target_type_id" INTEGER,
  "damage_factor" INTEGER,
  "generation_id" INTEGER,
  FOREIGN KEY (damage_type_id) REFERENCES types(id),
  FOREIGN KEY (target_type_id) REFERENCES types(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_habitats" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "contest_types" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "moves" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "generation_id" INTEGER,
  "type_id" INTEGER,
  "power" INTEGER,
  "pp" INTEGER,
  "accuracy" INTEGER,
  "priority" INTEGER,
  "target_id" INTEGER,
  "damage_class_id" INTEGER,
  "effect_id" INTEGER,
  "effect_chance" INTEGER,
  "contest_type_id" INTEGER,
  "contest_effect_id" INTEGER,
  "super_contest_effect_id" INTEGER,
  FOREIGN KEY (generation_id) REFERENCES generations(id),
  FOREIGN KEY (type_id) REFERENCES types(id),
  FOREIGN KEY (target_id) REFERENCES move_targets(id),
  FOREIGN KEY (damage_class_id) REFERENCES move_damage_classes(id),
  FOREIGN KEY (effect_id) REFERENCES move_effects(id),
  FOREIGN KEY (contest_type_id) REFERENCES contest_types(id),
  FOREIGN KEY (contest_effect_id) REFERENCES contest_effects(id),
  FOREIGN KEY (super_contest_effect_id) REFERENCES super_contest_effects(id)
);
CREATE TABLE IF NOT EXISTS "natures" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "decreased_stat_id" INTEGER,
  "increased_stat_id" INTEGER,
  "hates_flavor_id" INTEGER,
  "likes_flavor_id" INTEGER,
  "game_index" INTEGER,
  FOREIGN KEY (decreased_stat_id) REFERENCES stats(id),
  FOREIGN KEY (increased_stat_id) REFERENCES stats(id),
  FOREIGN KEY (hates_flavor_id) REFERENCES contest_types(id),
  FOREIGN KEY (likes_flavor_id) REFERENCES contest_types(id)
);
CREATE TABLE IF NOT EXISTS "conquest_move_ranges" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "targets" INTEGER
);
CREATE TABLE IF NOT EXISTS "item_flags" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "pokemon_evolution" (
  "id" INTEGER PRIMARY KEY,
  "evolved_species_id" INTEGER,
  "evolution_trigger_id" INTEGER,
  "trigger_item_id" INTEGER,
  "minimum_level" INTEGER,
  "gender_id" INTEGER,
  "location_id" INTEGER,
  "held_item_id" INTEGER,
  "time_of_day" TEXT,
  "known_move_id" INTEGER,
  "known_move_type_id" INTEGER,
  "minimum_happiness" INTEGER,
  "minimum_beauty" INTEGER,
  "minimum_affection" INTEGER,
  "relative_physical_stats" INTEGER,
  "party_species_id" INTEGER,
  "party_type_id" INTEGER,
  "trade_species_id" INTEGER,
  "needs_overworld_rain" INTEGER,
  "turn_upside_down" INTEGER,
  FOREIGN KEY (evolved_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (evolution_trigger_id) REFERENCES evolution_triggers(id),
  FOREIGN KEY (trigger_item_id) REFERENCES items(id),
  FOREIGN KEY (gender_id) REFERENCES genders(id),
  FOREIGN KEY (location_id) REFERENCES locations(id),
  FOREIGN KEY (held_item_id) REFERENCES items(id),
  FOREIGN KEY (known_move_id) REFERENCES moves(id),
  FOREIGN KEY (known_move_type_id) REFERENCES types(id),
  FOREIGN KEY (party_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (party_type_id) REFERENCES types(id),
  FOREIGN KEY (trade_species_id) REFERENCES pokemon_species(id)
);
CREATE TABLE IF NOT EXISTS "pokeathlon_stats" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "conquest_move_displacements" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT,
  "affects_target" INTEGER
);
CREATE TABLE IF NOT EXISTS "genders" (
  "id" INTEGER PRIMARY KEY,
  "identifier" TEXT
);
CREATE TABLE IF NOT EXISTS "experience" (
  "growth_rate_id" INTEGER,
  "level" INTEGER,
  "experience" INTEGER,
  FOREIGN KEY (growth_rate_id) REFERENCES growth_rates(id)
);
