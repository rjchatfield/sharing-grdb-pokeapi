import StructuredQueries
import StructuredQueriesSQLite

extension PokeAPIGeneration {
    /// Represents a Generation with its associated version groups and individual versions.
    /// 
    /// This provides a hierarchical view of the Pokemon game releases:
    /// - Generation (e.g., "Generation I") with its main region
    /// - Version Groups (e.g., "Red/Blue", "Yellow") 
    /// - Individual Versions (e.g., "Red", "Blue", "Yellow")
    ///
    /// ```swift
    /// let allGames = try PokeAPIGeneration.WithVersionGroups.fetchAll(database)
    /// for generation in allGames {
    ///     print("\(generation.generation.localizedName) (\(generation.region.localizedName))")
    ///     for versionGroup in generation.versionGroups {
    ///         print("  \(versionGroup.versionGroup.formattedName)")
    ///         for version in versionGroup.versions {
    ///             print("    \(version.formattedName)")
    ///         }
    ///     }
    /// }
    /// ```
    public struct WithVersionGroups: Sendable, Equatable {
        public let generation: PokeAPIGeneration
        public let region: PokeAPIRegion
        public let versionGroups: [VersionGroupData]

        public struct VersionGroupData: Sendable, Equatable {
            public let versionGroup: PokeAPIVersionGroup
            public let versions: [PokeAPIVersion]

            public init(
                versionGroup: PokeAPIVersionGroup,
                versions: [PokeAPIVersion]
            ) {
                self.versionGroup = versionGroup
                self.versions = versions
            }
        }

        public init(
            generation: PokeAPIGeneration,
            region: PokeAPIRegion,
            versionGroups: [VersionGroupData]
        ) {
            self.generation = generation
            self.region = region
            self.versionGroups = versionGroups
        }

        // MARK: -

        /// Fetches all generations with their version groups and individual versions.
        /// 
        /// - Parameters:
        ///   - database: The database to query
        /// - Returns: Array of generations with their version groups and versions, ordered by generation ID
        public static func fetchAll(
            _ database: StructuredQueriesSQLite.Database
        ) throws -> [PokeAPIGeneration.WithVersionGroups] {
            let generations: [(PokeAPIGeneration, PokeAPIRegion)] = try database.execute(
                PokeAPIGeneration.all
                    .join(PokeAPIRegion.all) { $0.mainRegionId == $1.id }
                    .order(by: \.id)
            )
            return try generations
                .map { (generation, region) in
                    // Get version groups for this generation
                    let versionGroups: [PokeAPIVersionGroup] = try database.execute(
                        PokeAPIVersionGroup.all
                            .where { $0.generationId == generation.id }
                            .order(by: \.id)
                    )
                    // For each version group, get its individual versions
                    let versionGroupsData: [VersionGroupData] = try versionGroups
                        .map { versionGroup in
                            let versions: [PokeAPIVersion] = try database.execute(
                                PokeAPIVersion.all
                                    .where { $0.versionGroupId == versionGroup.id }
                                    .order(by: \.id)
                            )
                            return VersionGroupData(
                                versionGroup: versionGroup,
                                versions: versions
                            )
                        }
                    return WithVersionGroups(
                        generation: generation,
                        region: region,
                        versionGroups: versionGroupsData
                    )
                }
        }
    }
}
