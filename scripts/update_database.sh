#!/bin/bash

# Script to update the PokeAPI database with latest CSV data
# This script backs up the existing database and creates a fresh one from CSV files

set -e  # Exit on any error

# Define paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DB_DIR="$PROJECT_ROOT/Sources/PokeAPIDatabase/Resources"
DB_FILE="$DB_DIR/pokeapi.db"
SCHEMA_FILE="$SCRIPT_DIR/Schema.sql"
CSV_DIR="$PROJECT_ROOT/submodules/pokeapi/data/v2/csv"

echo "🗃️  PokeAPI Database Update Script"
echo "================================="

# Check prerequisites
echo "📋 Checking prerequisites..."

if ! command -v sqlite3 &> /dev/null; then
    echo "❌ Error: sqlite3 is required but not installed"
    exit 1
fi

if ! command -v csvs-to-sqlite &> /dev/null; then
    echo "❌ Error: csvs-to-sqlite is required but not installed"
    echo "   Install with: pip install csvs-to-sqlite"
    exit 1
fi

if [ ! -f "$SCHEMA_FILE" ]; then
    echo "❌ Error: Schema file not found at $SCHEMA_FILE"
    exit 1
fi

if [ ! -d "$CSV_DIR" ]; then
    echo "❌ Error: CSV directory not found at $CSV_DIR"
    echo "   Make sure the submodule is properly initialized"
    exit 1
fi

echo "✅ All prerequisites satisfied"

# Backup existing database
if [ -f "$DB_FILE" ]; then
    echo "📦 Creating backup of existing database..."
    
    # Find next available backup number
    backup_num=1
    while [ -f "${DB_FILE%.db}_backup_${backup_num}.db" ]; do
        ((backup_num++))
    done
    
    backup_file="${DB_FILE%.db}_backup_${backup_num}.db"
    cp "$DB_FILE" "$backup_file"
    echo "✅ Backup created: $(basename "$backup_file")"
    
    # Remove original database
    rm "$DB_FILE"
else
    echo "ℹ️  No existing database found"
fi

# Create fresh database from schema
echo "🏗️  Creating fresh database from schema..."
if sqlite3 "$DB_FILE" < "$SCHEMA_FILE"; then
    echo "✅ Database schema created successfully"
else
    echo "❌ Error: Failed to create database schema"
    exit 1
fi

# Import CSV data
echo "📊 Importing CSV data..."
echo "   Finding CSV files (excluding translations, names, and prose files)..."

# Use find to get CSV files, excluding the ones we don't want
csv_files=$(find "$CSV_DIR" -name "*.csv" ! -path "*/translations/*" ! -name "*_names.csv" ! -name "*_prose.csv")

if [ -z "$csv_files" ]; then
    echo "❌ Error: No CSV files found to import"
    exit 1
fi

echo "   Found $(echo "$csv_files" | wc -l) CSV files to import"

# Import CSV files using csvs-to-sqlite
if csvs-to-sqlite $csv_files "$DB_FILE"; then
    echo "✅ CSV data imported successfully"
else
    echo "❌ Error: Failed to import CSV data"
    exit 1
fi

# Verify database
echo "🔍 Verifying database..."
table_count=$(sqlite3 "$DB_FILE" "SELECT COUNT(*) FROM sqlite_master WHERE type='table';")
echo "   Database contains $table_count tables"

if [ "$table_count" -gt 0 ]; then
    echo "✅ Database verification passed"
else
    echo "❌ Error: Database appears to be empty"
    exit 1
fi

# Compare with backup database if it exists
if [ -n "${backup_file:-}" ] && [ -f "$backup_file" ]; then
    echo ""
    echo "📊 Comparing with previous database..."
    
    # Compare table schemas
    echo "   Checking table schemas..."
    old_tables=$(sqlite3 "$backup_file" "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;" 2>/dev/null || echo "")
    new_tables=$(sqlite3 "$DB_FILE" "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;" 2>/dev/null || echo "")
    
    if [ "$old_tables" = "$new_tables" ]; then
        echo "✅ Table schemas match"
    else
        echo "⚠️  Table schema differences detected:"
        
        # Find added tables
        added_tables=$(comm -13 <(echo "$old_tables" | sort) <(echo "$new_tables" | sort) | grep -v '^$' || true)
        if [ -n "$added_tables" ]; then
            echo "   📈 Added tables: $(echo "$added_tables" | tr '\n' ' ')"
        fi
        
        # Find removed tables
        removed_tables=$(comm -23 <(echo "$old_tables" | sort) <(echo "$new_tables" | sort) | grep -v '^$' || true)
        if [ -n "$removed_tables" ]; then
            echo "   📉 Removed tables: $(echo "$removed_tables" | tr '\n' ' ')"
        fi
    fi
    
    # Compare row counts
    echo "   Checking row counts..."
    total_changes=0
    old_total_rows=0
    new_total_rows=0
    
    # Get all table names from new database
    all_tables=$(sqlite3 "$DB_FILE" "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;" 2>/dev/null)
    
    while IFS= read -r table; do
        if [ -n "$table" ]; then
            # Get row count from new database
            new_count=$(sqlite3 "$DB_FILE" "SELECT COUNT(*) FROM \"$table\";" 2>/dev/null || echo "0")
            new_total_rows=$((new_total_rows + new_count))
            
            # Get row count from old database (if table exists)
            old_count=$(sqlite3 "$backup_file" "SELECT COUNT(*) FROM \"$table\";" 2>/dev/null || echo "0")
            old_total_rows=$((old_total_rows + old_count))
            
            # Compare counts
            if [ "$old_count" -ne "$new_count" ]; then
                diff=$((new_count - old_count))
                if [ "$diff" -gt 0 ]; then
                    echo "   📈 $table: $old_count → $new_count (+$diff rows)"
                else
                    echo "   📉 $table: $old_count → $new_count ($diff rows)"
                fi
                total_changes=$((total_changes + 1))
            fi
        fi
    done <<< "$all_tables"
    
    # Summary
    echo ""
    if [ "$total_changes" -eq 0 ] && [ "$old_tables" = "$new_tables" ]; then
        echo "✅ No changes detected - databases are identical"
    else
        echo "📊 Database update summary:"
        echo "   Total tables with row changes: $total_changes"
        echo "   Previous total rows: $old_total_rows"
        echo "   New total rows: $new_total_rows"
        total_diff=$((new_total_rows - old_total_rows))
        if [ "$total_diff" -gt 0 ]; then
            echo "   Overall change: +$total_diff rows"
        elif [ "$total_diff" -lt 0 ]; then
            echo "   Overall change: $total_diff rows"
        else
            echo "   Overall change: No net change in row count"
        fi
    fi
else
    echo ""
    echo "ℹ️  No previous database found for comparison"
fi

echo ""
echo "🎉 Database update completed successfully!"
echo "   Database location: $DB_FILE"
if [ -n "${backup_file:-}" ]; then
    echo "   Backup location: $backup_file"
fi
echo ""

# Prompt to run tests
echo "🧪 To verify the tests still pass with the updated data, run:"
echo "   swift test"
echo ""
echo "💡 Note: If tests fail due to snapshot mismatches, use this command instead:"
echo "   xcodebuild test -scheme PokeAPIDatabase -destination \"platform=macOS,arch=arm64\""
echo ""