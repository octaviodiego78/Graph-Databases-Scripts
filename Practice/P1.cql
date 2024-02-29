LOAD CSV WITH HEADERS FROM "file:///nodos.csv" AS row
CREATE (n:Airports)
SET n = row


CREATE INDEX index_Airports FOR (n:Airports) ON (n.Id);

CREATE INDEX index_Label FOR (n:Airports) ON (n.Label);

LOAD CSV FROM "file:///enlaces.csv" AS row
MATCH (n:Airports), (m:Airports)
WHERE n.Id=row[0] and m.Id=row[1]
MERGE (n)-[:GOES_TO]->(m)


// 2.1. Una imagen del esquema general del grafo
CALL db.schema.visualization


// 2.2. Una imagen del grafo completo
MATCH (n:Airports)-[r:GOES_TO]->(m:Airports)
RETURN n,r,m

// 2.3. Número de nodos y atributos
MATCH(n)
RETURN count(n) as airports


//2.3.2 Attributes
CALL db.propertyKeys

MATCH(n)
return M LIMIT 100


// 2.4. Número de relaciones y atributos
MATCH(n:Airports)-[r:GOES_TO]->(m:Airports)
RETURN count(r) as trips


//2.7. Una consulta con cypher que muestre el número aeropuertos por cada país y una la lista de ellos 
MATCH (a:Airports)-[:GOES_TO]->(a2:Airports)
RETURN a.country, count(a) as airports, collect( distinct a.Label) as airportsList
ORDER BY airports DESC

//2.8. Una consulta con cypher que muestre el número de conexiones que cada país tiene con otros países
MATCH (a:Airports)-[:GOES_TO]->(a2:Airports)
RETURN a.country, count(DISTINCT a2.country) as connections


//2.9.	Una frase de búsqueda en Bloom que reciba el nombre del aeropuerto como parámetro y te regrese su grafo a un salto. Prueba con un aeropuerto de tu elección de Europa
MATCH (a:Airports)-[r:GOES_TO]->(a2:Airports)
WHERE a.Label = "Berlin"
RETURN DISTINCT a, a2



//2.10.	Una frase de búsqueda en Bloom que reciba el nombre del país como parámetro y te regrese su grafo a dos saltos. Prueba con México.
MATCH z = (a:Airports)-[*2]->(a2:Airports)
WHERE a.Label = "Berlin"
RETURN DISTINCT z



//1.1.	Añade un atributo Degree con su valor correspondiente a cada nodo Airport
CALL gds.graph.project(
    'degreeGraph',
    'Airports',
    {GOES_TO:
        {
            Orientation:'UNDIRECTED'
        }
    }
)


CALL gds.degree.write('degreeGraph',
    {writeProperty:'Degree'}
)
YIELD centralityDistribution, nodePropertiesWritten

RETURN centralityDistribution.min, 
       centralityDistribution.max,
       centralityDistribution.mean,
nodePropertiesWritten 

//1.2.	Añade un atributo In_Degree con su valor correspondiente a cada nodo Airport
CALL gds.graph.project(
    'INDegreeGraph',
    'Airports',
    {GOES_TO:
        {
            Orientation:'REVERSE'
        }
    }
)

CALL gds.degree.write('INDegreeGraph',
    {writeProperty:'InDegree'}
)
YIELD centralityDistribution, nodePropertiesWritten

RETURN centralityDistribution.min, 
       centralityDistribution.max,
       centralityDistribution.mean,
nodePropertiesWritten

//1.3.	Añade un atributo Out_Degree con su valor correspondiente a cada nodo Airport

CALL gds.graph.project(
    'OUTDegreeGraph',
    'Airports',
    {GOES_TO:
        {
            Orientation:'NATURAL'
        }
    }
)

CALL gds.degree.write('OUTDegreeGraph',
    {writeProperty:'OutDegree'}
)
YIELD centralityDistribution, nodePropertiesWritten

RETURN centralityDistribution.min, 
       centralityDistribution.max,
       centralityDistribution.mean,
nodePropertiesWritten 



//Page Rank , betweenness, closeness

CALL gds.graph.project(
    "subGraph",
    "Airports",
    "GOES_TO"
    )

//1.4.	Añade un atributo PageRank con su valor correspondiente a cada nodo Airport
CALL gds.pageRank.write(
    'subGraph',
    {
        maxIterations: 20,
        dampingFactor: 0.85,
        writeProperty: 'pageRank'
    }
)
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore, centralityDistribution.mean AS meanScore, nodePropertiesWritten

//1.5.	Añade un atributo Betweenness Centrality con su valor correspondiente a cada nodo Airport
CALL gds.betweenness.write('subGraph',{writeProperty: 'betweenness'})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min as minimunScore, centralityDistribution, nodePropertiesWritten


//1.6.	Añade un atributo Closeness Centrality con su valor correspondiente a cada nodo Airport
CALL gds.closeness.write('subGraph',{writeProperty: 'closeness'})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min as minimunScore,
 centralityDistribution.max as maximunScore,
  centralityDistribution.mean as meanScore, nodePropertiesWritten


//Give me a query that outputs a table with all airports and all centrality metrics previusly calculated
MATCH (a:Airports)
RETURN a.Label AS Airport, a.Degree AS Degree, a.InDegree AS InDegree, a.OutDegree AS OutDegree, a.pageRank AS PageRank, a.betweenness AS Betweenness, a.closeness AS Closeness





