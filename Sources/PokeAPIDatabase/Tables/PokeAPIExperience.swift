import StructuredQueries
import Tagged

/// Experience points required for each level for different growth rates
@Table("experience")
public struct PokeAPIExperience: Decodable, Hashable, Sendable {
    /// Foreign key to growth rate
    @Column("growth_rate_id") public var growthRateId: PokeAPIGrowthRate.ID

    /// Level
    @Column("level") public var level: Int

    /// Experience
    @Column("experience") public var experience: Int
}
