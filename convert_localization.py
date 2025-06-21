#!/usr/bin/env python3
"""
Convert PokeAPI CSV localization data to iOS .strings files

This script processes CSV files from the PokeAPI database and converts them
into iOS .strings files organized by language and category.
"""

import csv
import os
import re
from pathlib import Path
from typing import Dict, List, Tuple

# Language ID to iOS locale mapping based on languages.csv
LANGUAGE_MAPPING = {
    1: "ja",        # Japanese (Hiragana/Katakana)
    2: "ja",        # Japanese (Romaji) - use same locale as Japanese
    3: "ko",        # Korean
    4: "zh-Hant",   # Chinese Traditional
    5: "fr",        # French
    6: "de",        # German
    7: "es",        # Spanish
    8: "it",        # Italian
    9: "en",        # English
    11: "ja",       # Japanese - use same as ID 1
    12: "zh-Hans",  # Chinese Simplified
    13: "pt-BR"     # Portuguese Brazil
}

# CSV files to process with their categories and key prefixes
CSV_FILES = [
    ("pokemon_species_names.csv", "Pokemon", "pokemon"),
    ("move_names.csv", "Moves", "move"),
    ("ability_names.csv", "Abilities", "ability"),
    ("type_names.csv", "Types", "type"),
    ("item_names.csv", "Items", "item"),
    ("location_names.csv", "Locations", "location"),
    ("stat_names.csv", "Stats", "stat"),
    ("nature_names.csv", "Natures", "nature"),
    ("pokemon_habitat_names.csv", "Habitats", "habitat"),
    ("pokemon_color_names.csv", "Colors", "color"),
    ("region_names.csv", "Regions", "region"),
    ("generation_names.csv", "Generations", "generation"),
]

def escape_string_value(value: str) -> str:
    """Escape special characters for .strings format"""
    return (value
            .replace("\\", "\\\\")
            .replace('"', '\\"')
            .replace("\n", "\\n")
            .replace("\r", "\\r")
            .replace("\t", "\\t"))

def process_csv_file(csv_path: Path, category: str, key_prefix: str) -> Dict[str, Dict[str, str]]:
    """
    Process a CSV file and return localized content grouped by locale
    
    Returns:
        Dict[locale, Dict[key, value]]
    """
    localized_content = {}
    
    if not csv_path.exists():
        print(f"Warning: {csv_path} not found, skipping...")
        return localized_content
    
    with open(csv_path, 'r', encoding='utf-8') as file:
        reader = csv.reader(file)
        next(reader)  # Skip header
        
        for row in reader:
            if len(row) < 3:
                continue
                
            entity_id = row[0]
            try:
                language_id = int(row[1])
            except ValueError:
                continue
                
            name = row[2].strip()
            if not name:
                continue
                
            locale = LANGUAGE_MAPPING.get(language_id)
            if not locale:
                continue
                
            key = f"{key_prefix}.{entity_id}.name"
            escaped_value = escape_string_value(name)
            
            if locale not in localized_content:
                localized_content[locale] = {}
            
            localized_content[locale][key] = escaped_value
    
    return localized_content

def create_strings_files(all_content: Dict[str, Dict[str, Dict[str, str]]], output_dir: Path):
    """
    Create .strings files organized by locale and category
    
    Args:
        all_content: Dict[category, Dict[locale, Dict[key, value]]]
        output_dir: Output directory path
    """
    # Group by locale first
    by_locale = {}
    
    for category, locale_content in all_content.items():
        for locale, key_values in locale_content.items():
            if locale not in by_locale:
                by_locale[locale] = {}
            if category not in by_locale[locale]:
                by_locale[locale][category] = {}
            by_locale[locale][category].update(key_values)
    
    # Create .strings files
    for locale, categories in by_locale.items():
        locale_dir = output_dir / f"{locale}.lproj"
        locale_dir.mkdir(parents=True, exist_ok=True)
        
        for category, key_values in categories.items():
            strings_file = locale_dir / f"{category}.strings"
            
            # Sort keys for consistent output
            sorted_items = sorted(key_values.items())
            
            with open(strings_file, 'w', encoding='utf-8') as f:
                f.write(f"/* {category} - {locale} */\n\n")
                for key, value in sorted_items:
                    f.write(f'"{key}" = "{value}";\n')
                f.write("\n")
            
            print(f"Created {strings_file} with {len(key_values)} entries")

def main():
    # Paths
    script_dir = Path(__file__).parent
    csv_dir = script_dir / "submodules" / "pokeapi" / "data" / "v2" / "csv"
    output_dir = script_dir / "Resources"
    
    print(f"CSV directory: {csv_dir}")
    print(f"Output directory: {output_dir}")
    
    if not csv_dir.exists():
        print(f"Error: CSV directory not found at {csv_dir}")
        return
    
    # Process all CSV files
    all_content = {}
    
    for csv_file, category, key_prefix in CSV_FILES:
        csv_path = csv_dir / csv_file
        print(f"Processing {csv_file}...")
        
        localized_content = process_csv_file(csv_path, category, key_prefix)
        if localized_content:
            all_content[category] = localized_content
    
    # Create .strings files
    if all_content:
        print("\nCreating .strings files...")
        create_strings_files(all_content, output_dir)
        print(f"\nLocalization files created in {output_dir}")
        
        # Print summary
        print("\nSummary:")
        for category, locale_content in all_content.items():
            for locale, key_values in locale_content.items():
                print(f"  {category} ({locale}): {len(key_values)} entries")
    else:
        print("No content to process!")

if __name__ == "__main__":
    main()