CREATE TABLE IF NOT EXISTS "item_flavor_summaries" (
  "item_id" TEXT NOT NULL,
  "local_language_id" TEXT NOT NULL,
  "flavor_summary" TEXT NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (local_language_id) REFERENCES languages(id)
);
CREATE TABLE IF NOT EXISTS "characteristics" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "stat_id" INTEGER NOT NULL,
  "gene_mod_5" INTEGER NOT NULL,
  FOREIGN KEY (stat_id) REFERENCES stats(id)
);
CREATE TABLE IF NOT EXISTS "type_efficacy" (
  "damage_type_id" INTEGER NOT NULL,
  "target_type_id" INTEGER NOT NULL,
  "damage_factor" INTEGER NOT NULL,
  FOREIGN KEY (damage_type_id) REFERENCES types(id),
  FOREIGN KEY (target_type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "berries" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "item_id" INTEGER NOT NULL,
  "firmness_id" INTEGER NOT NULL,
  "natural_gift_power" INTEGER NOT NULL,
  "natural_gift_type_id" INTEGER NOT NULL,
  "size" INTEGER NOT NULL,
  "max_harvest" INTEGER NOT NULL,
  "growth_time" INTEGER NOT NULL,
  "soil_dryness" INTEGER NOT NULL,
  "smoothness" INTEGER NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (firmness_id) REFERENCES berry_firmness(id),
  FOREIGN KEY (natural_gift_type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_types_past" (
  "pokemon_id" INTEGER NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "type_id" INTEGER NOT NULL,
  "slot" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "move_meta_stat_changes" (
  "move_id" INTEGER NOT NULL,
  "stat_id" INTEGER NOT NULL,
  "change" INTEGER NOT NULL,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (stat_id) REFERENCES stats(id)
);
CREATE TABLE IF NOT EXISTS "version_group_regions" (
  "version_group_id" INTEGER NOT NULL,
  "region_id" INTEGER NOT NULL,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (region_id) REFERENCES regions(id)
);
CREATE TABLE IF NOT EXISTS "generations" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "main_region_id" INTEGER NOT NULL,
  "identifier" TEXT NOT NULL,
  FOREIGN KEY (main_region_id) REFERENCES regions(id)
);
CREATE TABLE IF NOT EXISTS "pokedex_version_groups" (
  "pokedex_id" INTEGER NOT NULL,
  "version_group_id" INTEGER NOT NULL,
  FOREIGN KEY (pokedex_id) REFERENCES pokedexes(id),
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "item_fling_effects" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "nature_battle_style_preferences" (
  "nature_id" INTEGER NOT NULL,
  "move_battle_style_id" INTEGER NOT NULL,
  "low_hp_preference" INTEGER NOT NULL,
  "high_hp_preference" INTEGER NOT NULL,
  FOREIGN KEY (nature_id) REFERENCES natures(id),
  FOREIGN KEY (move_battle_style_id) REFERENCES move_battle_styles(id)
);
CREATE TABLE IF NOT EXISTS "move_meta" (
  "move_id" INTEGER NOT NULL,
  "meta_category_id" INTEGER NOT NULL,
  "meta_ailment_id" INTEGER NOT NULL,
  "min_hits" INTEGER,
  "max_hits" INTEGER,
  "min_turns" INTEGER,
  "max_turns" INTEGER,
  "drain" INTEGER NOT NULL,
  "healing" INTEGER NOT NULL,
  "crit_rate" INTEGER NOT NULL,
  "ailment_chance" INTEGER NOT NULL,
  "flinch_chance" INTEGER NOT NULL,
  "stat_chance" INTEGER NOT NULL,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (meta_category_id) REFERENCES move_meta_categories(id),
  FOREIGN KEY (meta_ailment_id) REFERENCES move_meta_ailments(id)
);
CREATE TABLE IF NOT EXISTS "regions" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "encounter_methods" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "order" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "machines" (
  "machine_number" INTEGER NOT NULL,
  "version_group_id" INTEGER NOT NULL,
  "item_id" INTEGER NOT NULL,
  "move_id" INTEGER NOT NULL,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (move_id) REFERENCES moves(id)
);
CREATE TABLE IF NOT EXISTS "conquest_episodes" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "types" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "damage_class_id" INTEGER,
  FOREIGN KEY (generation_id) REFERENCES generations(id),
  FOREIGN KEY (damage_class_id) REFERENCES move_damage_classes(id)
);
CREATE TABLE IF NOT EXISTS "type_game_indices" (
  "type_id" INTEGER NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "game_index" INTEGER NOT NULL,
  FOREIGN KEY (type_id) REFERENCES types(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_stats" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "conquest_max_links" (
  "warrior_rank_id" INTEGER NOT NULL,
  "pokemon_species_id" INTEGER NOT NULL,
  "max_link" INTEGER NOT NULL,
  FOREIGN KEY (warrior_rank_id) REFERENCES conquest_warrior_ranks(id),
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id)
);
CREATE TABLE IF NOT EXISTS "berry_flavors" (
  "berry_id" INTEGER NOT NULL,
  "contest_type_id" INTEGER NOT NULL,
  "flavor" INTEGER NOT NULL,
  FOREIGN KEY (berry_id) REFERENCES berries(id),
  FOREIGN KEY (contest_type_id) REFERENCES contest_types(id)
);
CREATE TABLE IF NOT EXISTS "item_game_indices" (
  "item_id" INTEGER NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "game_index" INTEGER NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "conquest_kingdoms" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "type_id" INTEGER NOT NULL,
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "conquest_pokemon_stats" (
  "pokemon_species_id" INTEGER NOT NULL,
  "conquest_stat_id" INTEGER NOT NULL,
  "base_stat" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (conquest_stat_id) REFERENCES conquest_stats(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_colors" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "pokemon_shapes" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "item_pockets" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "pokemon_abilities_past" (
  "pokemon_id" INTEGER NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "ability_id" INTEGER,
  "is_hidden" INTEGER NOT NULL,
  "slot" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id),
  FOREIGN KEY (ability_id) REFERENCES abilities(id)
);
CREATE TABLE IF NOT EXISTS "contest_effects" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "appeal" INTEGER NOT NULL,
  "jam" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "location_game_indices" (
  "location_id" INTEGER NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "game_index" INTEGER NOT NULL,
  FOREIGN KEY (location_id) REFERENCES locations(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_rank_stat_map" (
  "warrior_rank_id" INTEGER NOT NULL,
  "warrior_stat_id" INTEGER NOT NULL,
  "base_stat" INTEGER NOT NULL,
  FOREIGN KEY (warrior_rank_id) REFERENCES conquest_warrior_ranks(id),
  FOREIGN KEY (warrior_stat_id) REFERENCES conquest_warrior_stats(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_transformation" (
  "transformed_warrior_rank_id" INTEGER NOT NULL,
  "is_automatic" INTEGER NOT NULL,
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
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "conquest_transformation_warriors" (
  "transformation_id" INTEGER NOT NULL,
  "present_warrior_id" INTEGER NOT NULL,
  FOREIGN KEY (transformation_id) REFERENCES conquest_warrior_transformation(transformed_warrior_rank_id),
  FOREIGN KEY (present_warrior_id) REFERENCES conquest_warriors(id)
);
CREATE TABLE IF NOT EXISTS "move_targets" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "move_flavor_summaries" (
  "move_id" TEXT NOT NULL,
  "local_language_id" TEXT NOT NULL,
  "flavor_summary" TEXT NOT NULL,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (local_language_id) REFERENCES languages(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_items" (
  "pokemon_id" INTEGER NOT NULL,
  "version_id" INTEGER NOT NULL,
  "item_id" INTEGER NOT NULL,
  "rarity" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (version_id) REFERENCES versions(id),
  FOREIGN KEY (item_id) REFERENCES items(id)
);
CREATE TABLE IF NOT EXISTS "stats" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "damage_class_id" INTEGER,
  "identifier" TEXT NOT NULL,
  "is_battle_only" INTEGER NOT NULL,
  "game_index" INTEGER,
  FOREIGN KEY (damage_class_id) REFERENCES move_damage_classes(id)
);
CREATE TABLE IF NOT EXISTS "encounter_condition_value_map" (
  "encounter_id" INTEGER NOT NULL,
  "encounter_condition_value_id" INTEGER NOT NULL,
  FOREIGN KEY (encounter_id) REFERENCES encounters(id),
  FOREIGN KEY (encounter_condition_value_id) REFERENCES encounter_condition_values(id)
);
CREATE TABLE IF NOT EXISTS "item_flag_map" (
  "item_id" INTEGER NOT NULL,
  "item_flag_id" INTEGER NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (item_flag_id) REFERENCES item_flags(id)
);
CREATE TABLE IF NOT EXISTS "conquest_stats" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "is_base" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "super_contest_combos" (
  "first_move_id" INTEGER NOT NULL,
  "second_move_id" INTEGER NOT NULL,
  FOREIGN KEY (first_move_id) REFERENCES moves(id),
  FOREIGN KEY (second_move_id) REFERENCES moves(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_species_flavor_summaries" (
  "pokemon_species_id" TEXT NOT NULL,
  "local_language_id" TEXT NOT NULL,
  "flavor_summary" TEXT NOT NULL,
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (local_language_id) REFERENCES languages(id)
);
CREATE TABLE IF NOT EXISTS "super_contest_effects" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "appeal" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "location_area_encounter_rates" (
  "location_area_id" INTEGER NOT NULL,
  "encounter_method_id" INTEGER NOT NULL,
  "version_id" INTEGER NOT NULL,
  "rate" INTEGER NOT NULL,
  FOREIGN KEY (location_area_id) REFERENCES location_areas(id),
  FOREIGN KEY (encounter_method_id) REFERENCES encounter_methods(id),
  FOREIGN KEY (version_id) REFERENCES versions(id)
);
CREATE TABLE IF NOT EXISTS "move_meta_ailments" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "pokemon_move_methods" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "growth_rates" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "formula" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "item_categories" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "pocket_id" INTEGER NOT NULL,
  "identifier" TEXT NOT NULL,
  FOREIGN KEY (pocket_id) REFERENCES item_pockets(id)
);
CREATE TABLE IF NOT EXISTS "contest_combos" (
  "first_move_id" INTEGER NOT NULL,
  "second_move_id" INTEGER NOT NULL,
  FOREIGN KEY (first_move_id) REFERENCES moves(id),
  FOREIGN KEY (second_move_id) REFERENCES moves(id)
);
CREATE TABLE IF NOT EXISTS "encounter_slots" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "version_group_id" INTEGER NOT NULL,
  "encounter_method_id" INTEGER NOT NULL,
  "slot" INTEGER,
  "rarity" INTEGER NOT NULL,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (encounter_method_id) REFERENCES encounter_methods(id)
);
CREATE TABLE IF NOT EXISTS "ability_changelog" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "ability_id" INTEGER NOT NULL,
  "changed_in_version_group_id" INTEGER NOT NULL,
  FOREIGN KEY (ability_id) REFERENCES abilities(id),
  FOREIGN KEY (changed_in_version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_moves" (
  "pokemon_id" INTEGER NOT NULL,
  "version_group_id" INTEGER NOT NULL,
  "move_id" INTEGER NOT NULL,
  "pokemon_move_method_id" INTEGER NOT NULL,
  "level" INTEGER NOT NULL,
  "order" INTEGER,
  "mastery" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (pokemon_move_method_id) REFERENCES pokemon_move_methods(id)
);
CREATE TABLE IF NOT EXISTS "pal_park_areas" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "move_flag_map" (
  "move_id" INTEGER NOT NULL,
  "move_flag_id" INTEGER NOT NULL,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (move_flag_id) REFERENCES move_flags(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_egg_groups" (
  "species_id" INTEGER NOT NULL,
  "egg_group_id" INTEGER NOT NULL,
  FOREIGN KEY (species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (egg_group_id) REFERENCES egg_groups(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_ranks" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "warrior_id" INTEGER NOT NULL,
  "rank" INTEGER NOT NULL,
  "skill_id" INTEGER NOT NULL,
  FOREIGN KEY (warrior_id) REFERENCES conquest_warriors(id),
  FOREIGN KEY (skill_id) REFERENCES conquest_warrior_skills(id)
);
CREATE TABLE IF NOT EXISTS "move_battle_styles" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_specialties" (
  "warrior_id" INTEGER NOT NULL,
  "type_id" INTEGER NOT NULL,
  "slot" INTEGER NOT NULL,
  FOREIGN KEY (warrior_id) REFERENCES conquest_warriors(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_form_types" (
  "pokemon_form_id" INTEGER NOT NULL,
  "type_id" INTEGER NOT NULL,
  "slot" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_form_id) REFERENCES pokemon_forms(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_types" (
  "pokemon_id" INTEGER NOT NULL,
  "type_id" INTEGER NOT NULL,
  "slot" INTEGER,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_skills" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "conquest_pokemon_moves" (
  "pokemon_species_id" INTEGER NOT NULL,
  "move_id" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (move_id) REFERENCES moves(id)
);
CREATE TABLE IF NOT EXISTS "conquest_move_effects" (
  "id" INTEGER PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "abilities" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "is_main_series" INTEGER NOT NULL,
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "encounter_condition_values" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "encounter_condition_id" INTEGER NOT NULL,
  "identifier" TEXT NOT NULL,
  "is_default" INTEGER NOT NULL,
  FOREIGN KEY (encounter_condition_id) REFERENCES encounter_conditions(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_form_pokeathlon_stats" (
  "pokemon_form_id" INTEGER NOT NULL,
  "pokeathlon_stat_id" INTEGER NOT NULL,
  "minimum_stat" INTEGER NOT NULL,
  "base_stat" INTEGER NOT NULL,
  "maximum_stat" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_form_id) REFERENCES pokemon_forms(id),
  FOREIGN KEY (pokeathlon_stat_id) REFERENCES pokeathlon_stats(id)
);
CREATE TABLE IF NOT EXISTS "conquest_episode_warriors" (
  "episode_id" INTEGER NOT NULL,
  "warrior_id" INTEGER NOT NULL,
  FOREIGN KEY (episode_id) REFERENCES conquest_episodes(id),
  FOREIGN KEY (warrior_id) REFERENCES conquest_warriors(id)
);
CREATE TABLE IF NOT EXISTS "locations" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "region_id" INTEGER,
  "identifier" TEXT NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(id)
);
CREATE TABLE IF NOT EXISTS "pokemon" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "species_id" INTEGER NOT NULL,
  "height" INTEGER NOT NULL,
  "weight" INTEGER NOT NULL,
  "base_experience" INTEGER,
  "order" INTEGER,
  "is_default" INTEGER NOT NULL,
  FOREIGN KEY (species_id) REFERENCES pokemon_species(id)
);
CREATE TABLE IF NOT EXISTS "encounters" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "version_id" INTEGER NOT NULL,
  "location_area_id" INTEGER NOT NULL,
  "encounter_slot_id" INTEGER NOT NULL,
  "pokemon_id" INTEGER NOT NULL,
  "min_level" INTEGER NOT NULL,
  "max_level" INTEGER NOT NULL,
  FOREIGN KEY (version_id) REFERENCES versions(id),
  FOREIGN KEY (location_area_id) REFERENCES location_areas(id),
  FOREIGN KEY (encounter_slot_id) REFERENCES encounter_slots(id),
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_dex_numbers" (
  "species_id" INTEGER NOT NULL,
  "pokedex_id" INTEGER NOT NULL,
  "pokedex_number" INTEGER NOT NULL,
  FOREIGN KEY (species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (pokedex_id) REFERENCES pokedexes(id)
);
CREATE TABLE IF NOT EXISTS "egg_groups" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "evolution_chains" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "baby_trigger_item_id" INTEGER,
  FOREIGN KEY (baby_trigger_item_id) REFERENCES items(id)
);
CREATE TABLE IF NOT EXISTS "conquest_pokemon_evolution" (
  "evolved_species_id" INTEGER NOT NULL,
  "required_stat_id" INTEGER,
  "minimum_stat" INTEGER,
  "minimum_link" INTEGER,
  "kingdom_id" INTEGER,
  "warrior_gender_id" INTEGER,
  "item_id" INTEGER,
  "recruiting_ko_required" INTEGER NOT NULL,
  FOREIGN KEY (evolved_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (required_stat_id) REFERENCES conquest_stats(id),
  FOREIGN KEY (kingdom_id) REFERENCES conquest_kingdoms(id),
  FOREIGN KEY (warrior_gender_id) REFERENCES genders(id),
  FOREIGN KEY (item_id) REFERENCES items(id)
);
CREATE TABLE IF NOT EXISTS "move_effects" (
  "id" INTEGER PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "pokedexes" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "region_id" INTEGER,
  "identifier" TEXT NOT NULL,
  "is_main_series" INTEGER NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(id)
);
CREATE TABLE IF NOT EXISTS "move_effect_changelog" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "effect_id" INTEGER NOT NULL,
  "changed_in_version_group_id" INTEGER NOT NULL,
  FOREIGN KEY (effect_id) REFERENCES move_effects(id),
  FOREIGN KEY (changed_in_version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "conquest_move_data" (
  "move_id" INTEGER NOT NULL,
  "power" INTEGER,
  "accuracy" INTEGER,
  "effect_chance" INTEGER,
  "effect_id" INTEGER,
  "range_id" INTEGER NOT NULL,
  "displacement_id" INTEGER,
  FOREIGN KEY (move_id) REFERENCES moves(id),
  FOREIGN KEY (effect_id) REFERENCES conquest_move_effects(id),
  FOREIGN KEY (range_id) REFERENCES conquest_move_ranges(id),
  FOREIGN KEY (displacement_id) REFERENCES conquest_move_displacements(id)
);
CREATE TABLE IF NOT EXISTS "conquest_transformation_pokemon" (
  "transformation_id" INTEGER NOT NULL,
  "pokemon_species_id" INTEGER NOT NULL,
  FOREIGN KEY (transformation_id) REFERENCES conquest_warrior_transformation(transformed_warrior_rank_id),
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id)
);
CREATE TABLE IF NOT EXISTS "pal_park" (
  "species_id" INTEGER NOT NULL,
  "area_id" INTEGER NOT NULL,
  "base_score" INTEGER NOT NULL,
  "rate" INTEGER NOT NULL,
  FOREIGN KEY (species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (area_id) REFERENCES pal_park_areas(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_game_indices" (
  "pokemon_id" INTEGER NOT NULL,
  "version_id" INTEGER NOT NULL,
  "game_index" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (version_id) REFERENCES versions(id)
);
CREATE TABLE IF NOT EXISTS "evolution_triggers" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "encounter_conditions" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "pokemon_abilities" (
  "pokemon_id" INTEGER NOT NULL,
  "ability_id" INTEGER NOT NULL,
  "is_hidden" INTEGER NOT NULL,
  "slot" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (ability_id) REFERENCES abilities(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_forms" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "form_identifier" TEXT,
  "pokemon_id" INTEGER NOT NULL,
  "introduced_in_version_group_id" INTEGER NOT NULL,
  "is_default" INTEGER NOT NULL,
  "is_battle_only" INTEGER NOT NULL,
  "is_mega" INTEGER NOT NULL,
  "form_order" INTEGER NOT NULL,
  "order" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (introduced_in_version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "move_meta_categories" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "version_groups" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "order" INTEGER NOT NULL,
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "conquest_warriors" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "gender_id" INTEGER NOT NULL,
  "archetype_id" INTEGER,
  FOREIGN KEY (gender_id) REFERENCES genders(id),
  FOREIGN KEY (archetype_id) REFERENCES conquest_warrior_archetypes(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_stats" (
  "pokemon_id" INTEGER NOT NULL,
  "stat_id" INTEGER NOT NULL,
  "base_stat" INTEGER NOT NULL,
  "effort" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id),
  FOREIGN KEY (stat_id) REFERENCES stats(id)
);
CREATE TABLE IF NOT EXISTS "location_areas" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "location_id" INTEGER NOT NULL,
  "game_index" INTEGER NOT NULL,
  "identifier" TEXT,
  FOREIGN KEY (location_id) REFERENCES locations(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_species" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "evolves_from_species_id" INTEGER,
  "evolution_chain_id" INTEGER NOT NULL,
  "color_id" INTEGER NOT NULL,
  "shape_id" INTEGER NOT NULL,
  "habitat_id" INTEGER,
  "gender_rate" INTEGER NOT NULL,
  "capture_rate" INTEGER NOT NULL,
  "base_happiness" INTEGER NOT NULL,
  "is_baby" INTEGER NOT NULL,
  "hatch_counter" INTEGER NOT NULL,
  "has_gender_differences" INTEGER NOT NULL,
  "growth_rate_id" INTEGER NOT NULL,
  "forms_switchable" INTEGER NOT NULL,
  "is_legendary" INTEGER NOT NULL,
  "is_mythical" INTEGER NOT NULL,
  "order" INTEGER NOT NULL,
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
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "category_id" INTEGER NOT NULL,
  "cost" INTEGER NOT NULL,
  "fling_power" INTEGER,
  "fling_effect_id" INTEGER,
  FOREIGN KEY (category_id) REFERENCES item_categories(id),
  FOREIGN KEY (fling_effect_id) REFERENCES item_fling_effects(id)
);
CREATE TABLE IF NOT EXISTS "version_group_pokemon_move_methods" (
  "version_group_id" INTEGER NOT NULL,
  "pokemon_move_method_id" INTEGER NOT NULL,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id),
  FOREIGN KEY (pokemon_move_method_id) REFERENCES pokemon_move_methods(id)
);
CREATE TABLE IF NOT EXISTS "move_changelog" (
  "move_id" INTEGER NOT NULL,
  "changed_in_version_group_id" INTEGER NOT NULL,
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
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "conquest_warrior_archetypes" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "versions" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "version_group_id" INTEGER NOT NULL,
  "identifier" TEXT NOT NULL,
  FOREIGN KEY (version_group_id) REFERENCES version_groups(id)
);
CREATE TABLE IF NOT EXISTS "nature_pokeathlon_stats" (
  "nature_id" INTEGER NOT NULL,
  "pokeathlon_stat_id" INTEGER NOT NULL,
  "max_change" INTEGER NOT NULL,
  FOREIGN KEY (nature_id) REFERENCES natures(id),
  FOREIGN KEY (pokeathlon_stat_id) REFERENCES pokeathlon_stats(id)
);
CREATE TABLE IF NOT EXISTS "conquest_pokemon_abilities" (
  "pokemon_species_id" INTEGER NOT NULL,
  "slot" INTEGER NOT NULL,
  "ability_id" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_species_id) REFERENCES pokemon_species(id),
  FOREIGN KEY (ability_id) REFERENCES abilities(id)
);
CREATE TABLE IF NOT EXISTS "berry_firmness" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "pokemon_form_generations" (
  "pokemon_form_id" INTEGER NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "game_index" INTEGER NOT NULL,
  FOREIGN KEY (pokemon_form_id) REFERENCES pokemon_forms(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "languages" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "iso639" TEXT NOT NULL,
  "iso3166" TEXT NOT NULL,
  "identifier" TEXT NOT NULL,
  "official" INTEGER NOT NULL,
  "order" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "type_efficacy_past" (
  "damage_type_id" INTEGER NOT NULL,
  "target_type_id" INTEGER NOT NULL,
  "damage_factor" INTEGER NOT NULL,
  "generation_id" INTEGER NOT NULL,
  FOREIGN KEY (damage_type_id) REFERENCES types(id),
  FOREIGN KEY (target_type_id) REFERENCES types(id),
  FOREIGN KEY (generation_id) REFERENCES generations(id)
);
CREATE TABLE IF NOT EXISTS "pokemon_habitats" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "contest_types" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "moves" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "generation_id" INTEGER NOT NULL,
  "type_id" INTEGER NOT NULL,
  "power" INTEGER,
  "pp" INTEGER,
  "accuracy" INTEGER,
  "priority" INTEGER NOT NULL,
  "target_id" INTEGER NOT NULL,
  "damage_class_id" INTEGER NOT NULL,
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
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "decreased_stat_id" INTEGER NOT NULL,
  "increased_stat_id" INTEGER NOT NULL,
  "hates_flavor_id" INTEGER NOT NULL,
  "likes_flavor_id" INTEGER NOT NULL,
  "game_index" INTEGER NOT NULL,
  FOREIGN KEY (decreased_stat_id) REFERENCES stats(id),
  FOREIGN KEY (increased_stat_id) REFERENCES stats(id),
  FOREIGN KEY (hates_flavor_id) REFERENCES contest_types(id),
  FOREIGN KEY (likes_flavor_id) REFERENCES contest_types(id)
);
CREATE TABLE IF NOT EXISTS "conquest_move_ranges" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "targets" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "item_flags" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "pokemon_evolution" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "evolved_species_id" INTEGER NOT NULL,
  "evolution_trigger_id" INTEGER NOT NULL,
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
  "needs_overworld_rain" INTEGER NOT NULL,
  "turn_upside_down" INTEGER NOT NULL,
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
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "conquest_move_displacements" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL,
  "affects_target" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "genders" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "identifier" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "experience" (
  "growth_rate_id" INTEGER NOT NULL,
  "level" INTEGER NOT NULL,
  "experience" INTEGER NOT NULL,
  FOREIGN KEY (growth_rate_id) REFERENCES growth_rates(id)
);
