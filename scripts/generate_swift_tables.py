#!/usr/bin/env python3

import sqlite3
import os
import sys
import re
from pathlib import Path

def snake_to_camel_case(snake_str):
    """Convert snake_case to camelCase"""
    components = snake_str.split('_')
    return components[0] + ''.join(word.capitalize() for word in components[1:])

def snake_to_pascal_case(snake_str):
    """Convert snake_case to PascalCase with PokeAPI prefix"""
    # Handle special cases first
    special_cases = {
        'pokedexes': 'PokeAPIPokedex',
        'languages': 'PokeAPILanguage', 
        'genders': 'PokeAPIGender',
        'versions': 'PokeAPIVersion',
        'regions': 'PokeAPIRegion',
        'types': 'PokeAPIType',
        'stats': 'PokeAPIStat',
        'moves': 'PokeAPIMove',
        'natures': 'PokeAPINature',
        'items': 'PokeAPIItem',
        'abilities': 'PokeAPIAbility',
        'berries': 'PokeAPIBerry',
        'locations': 'PokeAPILocation',
        'machines': 'PokeAPIMachine',
        'encounters': 'PokeAPIEncounter',
        'generations': 'PokeAPIGeneration',
        'characteristics': 'PokeAPICharacteristic',
        'experience': 'PokeAPIExperience',
        'pokemon': 'PokeAPIPokemon'
    }
    
    if snake_str in special_cases:
        return special_cases[snake_str]
    
    # Split by underscores
    parts = snake_str.split('_')
    result_parts = []
    
    for i, part in enumerate(parts):
        if not part:
            continue
            
        # Capitalize first letter
        capitalized = part.capitalize()
        
        # Apply singularization to the last part (unless it's a junction table pattern)
        if i == len(parts) - 1:
            # Don't singularize certain patterns
            if not any(snake_str.endswith(suffix) for suffix in ['_map', '_past', '_indices', '_text', '_summaries', '_changelog']):
                # Apply singularization rules
                if capitalized.endswith('ies'):
                    capitalized = capitalized[:-3] + 'y'
                elif capitalized.endswith(('ches', 'shes', 'xes', 'zes')):
                    capitalized = capitalized[:-2]
                elif capitalized.endswith('sses'):
                    capitalized = capitalized[:-2]
                elif capitalized.endswith('species'):
                    pass  # "species" is both singular and plural
                elif not capitalized.endswith(('ness', 'ss')) and capitalized.endswith('s'):
                    capitalized = capitalized[:-1]
        
        result_parts.append(capitalized)
    
    return 'PokeAPI' + ''.join(result_parts)

def get_table_schema(db_path, table_name):
    """Get table schema from SQLite database"""
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Get table info
    cursor.execute(f"PRAGMA table_info({table_name})")
    columns = cursor.fetchall()
    
    # Get foreign key info
    cursor.execute(f"PRAGMA foreign_key_list({table_name})")
    foreign_keys = cursor.fetchall()
    
    conn.close()
    
    return columns, foreign_keys

def sql_to_swift_type(sql_type, column_name, is_primary_key, foreign_keys):
    """Map SQL types to Swift types"""
    # Check if this is a foreign key
    for fk in foreign_keys:
        if fk[3] == column_name:  # fk[3] is the 'from' column
            referenced_table = fk[2]  # fk[2] is the referenced table
            referenced_column = fk[4]  # fk[4] is the referenced column
            
            if referenced_column == 'id':
                swift_type = snake_to_pascal_case(referenced_table)
                return f"{swift_type}.ID"
            else:
                return "Int"
    
    # Handle regular types
    if sql_type == 'INTEGER':
        if column_name == 'id' and is_primary_key:
            return "ID"
        elif column_name.startswith('is_'):
            return "Bool"
        else:
            return "Int"
    elif sql_type == 'TEXT':
        if column_name == 'identifier':
            return "Identifier"
        else:
            return "String"
    elif sql_type == 'REAL':
        return "Double"
    elif sql_type == 'BLOB':
        return "Data"
    else:
        return "String"  # Default fallback

def generate_swift_file(db_path, table_name, swift_type_name):
    """Generate Swift file content for a table"""
    columns, foreign_keys = get_table_schema(db_path, table_name)
    
    # Check if table has id column
    has_id_column = any(col[1] == 'id' and col[5] for col in columns)  # col[5] is pk flag
    
    # Check if table has identifier column
    has_identifier_column = any(col[1] == 'identifier' for col in columns)
    
    # Generate file header
    content = []
    content.append("import StructuredQueries")
    content.append("import Tagged")
    content.append("")
    content.append(f"// TODO: Add description for {table_name} table")
    content.append(f'@Table("{table_name}")')
    
    if has_id_column:
        content.append(f"public struct {swift_type_name}: Decodable, Hashable, Identifiable, Sendable {{")
        content.append("    public typealias ID = Tagged<Self, Int>")
        if has_identifier_column:
            content.append("    public typealias Identifier = String")
    else:
        content.append(f"public struct {swift_type_name}: Decodable, Hashable, Sendable {{")
        if has_identifier_column:
            content.append("    public typealias Identifier = String")
    
    content.append("")
    
    # Generate properties
    for col in columns:
        column_name = col[1]
        sql_type = col[2]
        is_primary_key = col[5]
        
        # Generate property name (snake_case to camelCase)
        property_name = snake_to_camel_case(column_name)
        
        # Determine Swift type
        swift_type = sql_to_swift_type(sql_type, column_name, is_primary_key, foreign_keys)
        
        # Generate column annotation
        primary_key_annotation = ", primaryKey: true" if is_primary_key else ""
        
        content.append(f"    // TODO: Add description for {column_name}")
        content.append(f'    @Column("{column_name}"{primary_key_annotation}) public var {property_name}: {swift_type}')
        content.append("")
    
    content.append("}")
    
    return "\n".join(content)

def categorize_table(table_name):
    """Categorize table based on naming patterns"""
    if table_name.startswith('conquest_'):
        return 'conquest'
    elif any(table_name.endswith(suffix) for suffix in ['_flavor_text', '_flavor_summaries', '_changelog', '_text']):
        return 'flavor'
    elif table_name.startswith('contest_') or table_name.startswith('super_contest_'):
        return 'contest'
    elif any(table_name.endswith(suffix) for suffix in ['_game_indices', '_past', '_map']):
        return 'metadata'
    elif table_name in ['abilities', 'berries', 'characteristics', 'egg_groups', 'encounters', 
                       'encounter_methods', 'encounter_slots', 'evolution_chains', 'evolution_triggers',
                       'experience', 'generations', 'growth_rates', 'items', 'item_categories',
                       'languages', 'locations', 'location_areas', 'machines', 'moves',
                       'move_damage_classes', 'move_effects', 'move_targets', 'natures',
                       'pokedexes', 'pokemon', 'pokemon_colors', 'pokemon_forms', 'pokemon_habitats',
                       'pokemon_shapes', 'pokemon_species', 'regions', 'stats', 'types',
                       'versions', 'version_groups']:
        return 'core'
    else:
        return 'other'

def generate_test_file(swift_type_name):
    """Generate test file content for a table"""
    content = [
        "import Testing",
        "import StructuredQueries",
        "import StructuredQueriesSQLite", 
        "import StructuredQueriesTestSupport",
        "import SnapshotTesting",
        "import InlineSnapshotTesting",
        "import PokeAPIDatabase",
        "",
        "@Suite(",
        "    .serialized,",
        "    .snapshots(record: .failed)",
        ")",
        f"struct {swift_type_name}Tests {{",
        "    @Test",
        "    func count() {",
        "        Helper.assertQuery(",
        f"            {swift_type_name}.count()",
        "        )",
        "    }",
        "",
        "    @Test",
        "    func first5() {",
        "        Helper.assertQuery(",
        f"            {swift_type_name}.limit(5)",
        "        )",
        "    }",
        "}"
    ]
    
    return "\n".join(content)

def update_runtime_check_schemas(project_root, new_swift_types):
    """Update RuntimeCheckSchemas.swift with new table types and sort all execute lines"""
    test_file_path = project_root / "Tests/PokeAPIDatabaseTests/RuntimeCheckSchemas.swift"
    
    if not test_file_path.exists():
        print(f"\\033[0;33mWarning: RuntimeCheckSchemas.swift not found at {test_file_path}\\033[0m")
        return
    
    # Read the current file
    with open(test_file_path, 'r') as f:
        content = f.read()
    
    lines = content.split('\n')
    
    # Find the function boundaries
    function_start = -1
    function_end = -1
    for i, line in enumerate(lines):
        if 'func testRuntimeCheckSchemas()' in line:
            function_start = i
        elif function_start != -1 and line.strip() == '}':
            function_end = i
            break
    
    if function_start == -1 or function_end == -1:
        print("\\033[0;33mWarning: Could not find function boundaries in RuntimeCheckSchemas.swift\\033[0m")
        return
    
    # Extract existing execute lines and other lines
    execute_lines = []
    other_lines = []
    
    for i in range(function_start + 1, function_end):
        line = lines[i]
        if 'let _ = try database.execute(' in line:
            # Extract the type name for sorting
            type_match = re.search(r'database\.execute\((\w+)\.all\)', line)
            if type_match:
                type_name = type_match.group(1)
                execute_lines.append((type_name, line))
        else:
            other_lines.append((i, line))
    
    # Add new types to the execute lines
    for swift_type in new_swift_types:
        execute_lines.append((swift_type, f"    let _ = try database.execute({swift_type}.all)"))
    
    # Sort execute lines alphabetically by type name
    execute_lines.sort(key=lambda x: x[0])
    
    # Rebuild the function content
    new_function_lines = []
    
    # Add lines before execute statements (typically just the database declaration)
    for i, line in other_lines:
        if i < function_start + 3:  # Assume first few lines are setup
            new_function_lines.append(line)
    
    # Add all execute lines in sorted order
    for _, line in execute_lines:
        new_function_lines.append(line)
    
    # Rebuild the entire file
    new_lines = (
        lines[:function_start + 1] +  # Everything before function body
        new_function_lines +           # Sorted function body
        lines[function_end:]           # Closing brace and everything after
    )
    
    # Write back to file
    updated_content = '\n'.join(new_lines)
    with open(test_file_path, 'w') as f:
        f.write(updated_content)
    
    total_types = len(execute_lines)
    new_count = len(new_swift_types)
    print(f"\\033[0;32mUpdated RuntimeCheckSchemas.swift with {new_count} new types, sorted {total_types} total types\\033[0m")

def main():
    # Configuration
    project_root = Path(__file__).parent.parent
    db_path = project_root / "Sources/PokeAPIDatabase/Resources/pokeapi.db"
    tables_dir = project_root / "Sources/PokeAPIDatabase/Tables"
    
    # Pretty header
    print("\033[0;34mDatabase Table Verification and Swift File Generation\033[0m")
    print("======================================================")
    print()
    
    # Check if database exists
    if not db_path.exists():
        print(f"\033[0;31mError: Database not found at {db_path}\033[0m")
        sys.exit(1)
    
    # Check if tables directory exists
    if not tables_dir.exists():
        print(f"\033[0;31mError: Tables directory not found at {tables_dir}\033[0m")
        sys.exit(1)
    
    print("\033[0;34mGetting list of database tables...\033[0m")
    
    # Get all tables from database
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
    all_tables = sorted([row[0] for row in cursor.fetchall()])
    conn.close()
    
    print(f"\033[0;34mFound {len(all_tables)} tables in database\033[0m")
    print()
    
    # Get existing Swift files
    existing_files = []
    for file_path in tables_dir.glob("*.swift"):
        if "+" not in file_path.name:  # Skip extension files
            existing_files.append(file_path.stem)
    
    print(f"\033[0;34mFound {len(existing_files)} existing Swift table files\033[0m")
    print()
    
    # Categorize missing tables
    missing_by_category = {
        'core': [],
        'conquest': [],
        'flavor': [],
        'contest': [],
        'metadata': [],
        'other': []
    }
    
    for table in all_tables:
        expected_swift_type = snake_to_pascal_case(table)
        if expected_swift_type not in existing_files:
            category = categorize_table(table)
            missing_by_category[category].append(table)
    
    # Calculate totals
    total_missing = sum(len(tables) for tables in missing_by_category.values())
    total_existing = len(existing_files)
    total_tables = len(all_tables)
    coverage = (total_existing * 100 // total_tables) if total_tables > 0 else 0
    
    # Display summary
    print("\033[1;33mSummary:\033[0m")
    print(f"Total tables: {total_tables}")
    print(f"Existing Swift files: {total_existing}")
    print(f"Missing Swift files: {total_missing}")
    print(f"Coverage: {coverage}%")
    print()
    
    if total_missing == 0:
        print("\033[0;32mAll tables have corresponding Swift files!\033[0m")
        return
    
    # Display missing tables by category
    print("\033[1;33mMissing Swift files by category:\033[0m")
    print()
    
    category_names = {
        'core': 'Core Entity Tables',
        'conquest': 'Conquest Game Tables', 
        'flavor': 'Flavor Text/Metadata Tables',
        'contest': 'Contest System Tables',
        'metadata': 'Metadata/Junction Tables',
        'other': 'Other Tables'
    }
    
    for category, tables in missing_by_category.items():
        if tables:
            print(f"\033[0;31m{category_names[category]} ({len(tables)}):\033[0m")
            for table in tables:
                swift_type = snake_to_pascal_case(table)
                print(f"  - {table} → {swift_type}.swift")
            print()
    
    # Ask for confirmation
    print("\033[1;33mDo you want to generate the missing Swift files? (y/N):\033[0m")
    response = input()
    
    if response.lower() == 'y':
        print()
        print("\033[0;34mGenerating missing Swift files...\033[0m")
        print()
        
        # Combine all missing tables
        all_missing = []
        for tables in missing_by_category.values():
            all_missing.extend(tables)
        
        generated_count = 0
        generated_swift_types = []
        tests_dir = project_root / "Tests/PokeAPIDatabaseTests/Tables"
        
        # Ensure tests directory exists
        tests_dir.mkdir(parents=True, exist_ok=True)
        
        for table in all_missing:
            swift_type = snake_to_pascal_case(table)
            output_file = tables_dir / f"{swift_type}.swift"
            test_file = tests_dir / f"{swift_type}Tests.swift"
            
            print(f"\033[0;34mGenerating {swift_type}.swift...\\033[0m")
            
            # Generate Swift file content
            content = generate_swift_file(db_path, table, swift_type)
            
            # Write to file
            with open(output_file, 'w') as f:
                f.write(content)
            
            # Generate test file content
            test_content = generate_test_file(swift_type)
            
            # Write test file
            with open(test_file, 'w') as f:
                f.write(test_content)
            
            generated_count += 1
            generated_swift_types.append(swift_type)
        
        print()
        print(f"\033[0;32mSuccessfully generated {generated_count} Swift files and {generated_count} test files!\033[0m")
        
        # Update RuntimeCheckSchemas.swift with new types
        if generated_swift_types:
            print("\033[0;34mUpdating RuntimeCheckSchemas.swift...\033[0m")
            update_runtime_check_schemas(project_root, generated_swift_types)
        print()
        print("\033[1;33mNext steps:\033[0m")
        print("1. Review the generated files and add proper documentation")
        print("2. Run 'swift build' to check for compilation errors")
        print("3. Run 'swift test' to ensure tests still pass")
        print("4. Consider adding tests for the new schema files")
    else:
        print("\033[1;33mSkipping file generation.\033[0m")

if __name__ == "__main__":
    main()