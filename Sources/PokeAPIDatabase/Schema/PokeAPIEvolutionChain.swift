import StructuredQueries

/// Represents an evolution chain linking Pokemon species through evolutionary relationships.
/// Each chain represents a complete evolutionary line (e.g., Bulbasaur -> Ivysaur -> Venusaur).
/// Baby Pokemon may require special items to produce, which are tracked here.
@Table("evolution_chains")
public struct PokeAPIEvolutionChain: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int
    
    /// Unique evolution chain identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Item required to breed and produce the baby Pokemon in this chain
    /// Nil if no special breeding item is required
    @Column("baby_trigger_item_id") public var babyTriggerItemId: PokeAPIItem.ID?
}