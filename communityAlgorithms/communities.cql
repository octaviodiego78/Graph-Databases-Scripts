
//Villian subgraph creation
CALL gds.graph.project(
    'myUndirectedGraph'
    , 'Villian',
     {COMPANION: {orientation: 'UNDIRECTED', properties: 'Weight'}})

//Louvin
CALL gds.louvain.write('myUndirectedGraph', {writeProperty: 'communitylouvain'})
YIELD communityCount, modularity, modularities

//Label Propagation
CALL gds.labelPropagation.write('myUndirectedGraph', {writeProperty: 'communitylabelpropagation'})
YIELD communityCount, ranIterations, didConverge


//Superheroes subgraph creation
CALL gds.graph.project(
    'mySupUndirectedGraph'
    , 'SuperHero',
     {FRIEND_OF: {orientation: 'UNDIRECTED', properties: 'Weight'}})

//Louvin
CALL gds.louvain.write('mySupUndirectedGraph', {writeProperty: 'communitylouvain'})
YIELD communityCount, modularity, modularities

//Label Propagation
CALL gds.labelPropagation.write('mySupUndirectedGraph', {writeProperty: 'communitylabelpropagation'})
YIELD communityCount, ranIterations, didConverge

//Weakest link
CALL gds.wcc.write('myUndirectedGraph', {writeProperty: 'community_wcc'})
YIELD componentCount, componentDistribution


CALL gds.wcc.write('mySupUndirectedGraph', {writeProperty: 'community2_wcc'})
YIELD componentCount, componentDistribution


//Write a property with kmeans
CALL gds.kmeans.write('myUndirectedGraph', {
    nodeProperty: 'Weight',
    writeProperty: 'communitykmeans',
    maxIterations: 10,
    tolerance: 0.0001,
    seedProperty: 'Weight',
    k: 2
})



