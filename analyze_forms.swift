#!/usr/bin/env swift

import Foundation
import GRDB

// Connect to the database
let dbPath = "/Users/rjchatfield/Developer/swift-pokeapi-database/Sources/PokeAPIDatabase/Resources/pokemon.db"

do {
    let dbQueue = try DatabaseQueue(path: dbPath)
    
    // Query for non-default forms
    let nonDefaultForms = try dbQueue.read { db in
        try Row.fetchAll(db, sql: """
            SELECT id, identifier, species_id, is_default
            FROM pokemon 
            WHERE is_default = 0 
            ORDER BY species_id, id
        """)
    }
    
    print("=== NON-DEFAULT POKEMON FORMS ANALYSIS ===")
    print("Total non-default forms: \(nonDefaultForms.count)")
    print("")
    
    // Analyze form patterns
    var formTypes: [String: Int] = [:]
    var examplesByType: [String: [(id: Int, identifier: String)]] = [:]
    
    for form in nonDefaultForms {
        let identifier = form["identifier"] as! String
        let id = form["id"] as! Int
        
        // Categorize form types based on identifier patterns
        var formType = "other"
        
        if identifier.contains("-mega") {
            formType = "mega"
        } else if identifier.contains("-gmax") {
            formType = "gmax"
        } else if identifier.contains("-alola") {
            formType = "alola"
        } else if identifier.contains("-galar") {
            formType = "galar"
        } else if identifier.contains("-hisui") {
            formType = "hisui"
        } else if identifier.contains("-paldea") {
            formType = "paldea"
        } else if identifier.contains("-primal") {
            formType = "primal"
        } else if identifier.contains("-totem") {
            formType = "totem"
        } else if identifier.contains("-cap") {
            formType = "cap"
        } else if identifier.contains("-cosplay") {
            formType = "cosplay"
        } else if identifier.contains("-origin") {
            formType = "origin"
        } else if identifier.contains("-sky") {
            formType = "sky"
        } else if identifier.contains("-zen") {
            formType = "zen"
        } else if identifier.contains("-therian") {
            formType = "therian"
        } else if identifier.contains("-incarnate") {
            formType = "incarnate"
        } else if identifier.contains("-resolute") {
            formType = "resolute"
        } else if identifier.contains("-pirouette") {
            formType = "pirouette"
        } else if identifier.contains("-blade") {
            formType = "blade"
        } else if identifier.contains("-shield") {
            formType = "shield"
        } else if identifier.contains("-unbound") {
            formType = "unbound"
        } else if identifier.contains("-complete") {
            formType = "complete"
        } else if identifier.contains("-10-percent") || identifier.contains("-50-percent") {
            formType = "zygarde"
        } else if identifier.contains("-ultra") {
            formType = "ultra"
        } else if identifier.contains("-dawn-wings") || identifier.contains("-dusk-mane") {
            formType = "necrozma"
        } else if identifier.contains("-low-key") || identifier.contains("-amped") {
            formType = "toxapex"
        } else if identifier.contains("-ice") || identifier.contains("-steam") {
            formType = "calyrex"
        } else if identifier.contains("-single-strike") || identifier.contains("-rapid-strike") {
            formType = "urshifu"
        } else if identifier.contains("-male") || identifier.contains("-female") {
            formType = "gender"
        } else if identifier.contains("-plant") || identifier.contains("-sandy") || identifier.contains("-trash") {
            formType = "wormadam"
        } else if identifier.contains("-heat") || identifier.contains("-wash") || identifier.contains("-frost") || identifier.contains("-fan") || identifier.contains("-mow") {
            formType = "rotom"
        } else if identifier.contains("-attack") || identifier.contains("-defense") || identifier.contains("-speed") {
            formType = "deoxys"
        }
        
        formTypes[formType, default: 0] += 1
        
        if examplesByType[formType] == nil {
            examplesByType[formType] = []
        }
        if examplesByType[formType]!.count < 5 {
            examplesByType[formType]!.append((id: id, identifier: identifier))
        }
    }
    
    // Display results
    print("=== FORM TYPE COUNTS ===")
    let sortedTypes = formTypes.sorted { $0.value > $1.value }
    for (type, count) in sortedTypes {
        print("\(type): \(count)")
    }
    
    print("\n=== EXAMPLES BY FORM TYPE ===")
    for (type, _) in sortedTypes {
        print("\n\(type.uppercased()) Forms:")
        for example in examplesByType[type] ?? [] {
            print("  ID \(example.id): \(example.identifier)")
        }
    }
    
    // Find Pokemon with most alternate forms
    print("\n=== POKEMON WITH MOST ALTERNATE FORMS ===")
    let speciesFormCounts = try dbQueue.read { db in
        try Row.fetchAll(db, sql: """
            SELECT species_id, COUNT(*) as form_count, 
                   GROUP_CONCAT(identifier, ', ') as forms
            FROM pokemon 
            WHERE is_default = 0 
            GROUP BY species_id 
            ORDER BY form_count DESC 
            LIMIT 10
        """)
    }
    
    for row in speciesFormCounts {
        let speciesId = row["species_id"] as! Int
        let formCount = row["form_count"] as! Int
        let forms = row["forms"] as! String
        
        // Get species name
        let speciesName = try dbQueue.read { db in
            try String.fetchOne(db, sql: "SELECT identifier FROM pokemon_species WHERE id = ?", arguments: [speciesId]) ?? "Unknown"
        }
        
        print("Species \(speciesId) (\(speciesName)): \(formCount) alternate forms")
        print("  Forms: \(forms)")
        print("")
    }
    
    // Additional interesting patterns
    print("=== INTERESTING PATTERNS ===")
    
    // Count total Pokemon entries
    let totalPokemon = try dbQueue.read { db in
        try Int.fetchOne(db, sql: "SELECT COUNT(*) FROM pokemon") ?? 0
    }
    
    let defaultPokemon = try dbQueue.read { db in
        try Int.fetchOne(db, sql: "SELECT COUNT(*) FROM pokemon WHERE is_default = 1") ?? 0
    }
    
    print("Total Pokemon entries: \(totalPokemon)")
    print("Default forms: \(defaultPokemon)")
    print("Non-default forms: \(nonDefaultForms.count)")
    print("Percentage of non-default forms: \(String(format: "%.1f", Double(nonDefaultForms.count) / Double(totalPokemon) * 100))%")
    
    // Look for unusual naming patterns
    print("\n=== UNUSUAL NAMING PATTERNS ===")
    let unusualPatterns = nonDefaultForms.filter { form in
        let identifier = form["identifier"] as! String
        return identifier.contains("-") && !identifier.contains("mega") && !identifier.contains("gmax") && 
               !identifier.contains("alola") && !identifier.contains("galar") && !identifier.contains("hisui") &&
               !identifier.contains("paldea") && !identifier.contains("primal") && !identifier.contains("totem") &&
               !identifier.contains("cap") && !identifier.contains("cosplay") && !identifier.contains("origin") &&
               !identifier.contains("sky") && !identifier.contains("zen") && !identifier.contains("therian") &&
               !identifier.contains("incarnate") && !identifier.contains("resolute") && !identifier.contains("pirouette") &&
               !identifier.contains("blade") && !identifier.contains("shield") && !identifier.contains("unbound") &&
               !identifier.contains("complete") && !identifier.contains("percent") && !identifier.contains("ultra") &&
               !identifier.contains("wings") && !identifier.contains("mane") && !identifier.contains("key") &&
               !identifier.contains("amped") && !identifier.contains("ice") && !identifier.contains("steam") &&
               !identifier.contains("strike") && !identifier.contains("male") && !identifier.contains("female") &&
               !identifier.contains("plant") && !identifier.contains("sandy") && !identifier.contains("trash") &&
               !identifier.contains("heat") && !identifier.contains("wash") && !identifier.contains("frost") &&
               !identifier.contains("fan") && !identifier.contains("mow") && !identifier.contains("attack") &&
               !identifier.contains("defense") && !identifier.contains("speed")
    }
    
    print("Found \(unusualPatterns.count) Pokemon with unusual patterns:")
    for form in unusualPatterns.prefix(10) {
        let id = form["id"] as! Int
        let identifier = form["identifier"] as! String
        print("  ID \(id): \(identifier)")
    }
    
} catch {
    print("Error: \(error)")
}