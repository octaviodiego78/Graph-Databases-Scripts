// -1. Hola Mundo
// 0. Todas las personas que hicieron review a una película. Mostrar el grafo con las personas, relaciones y películas.
MATCH (p:Person)-[r:REVIEWED]->(m:Movie)
RETURN p,r,m

// 1. Dado Keanu Reeves, mostrar los actores que han compartido películas con él. Mostrar el grafo.
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(op:Person)
WHERE p.name = 'Keanu Reeves'
RETURN p,r,m,r2,op

// 2. Dado Keanu Reeves, mostrar los actores que han compartido películas con él. Mostrar como tabla los resultados
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(op:Person)
WHERE p.name = 'Keanu Reeves'
RETURN op.name

// 3. Grafo que muestre las personas que REVIEW or WROTE una película
MATCH (p:Person)-[r:REVIEWED|WROTE]->(m:Movie)
RETURN p,r,m

// 4. Grafo que muestre las personas que REVIEW or WROTE una película con released <2001
MATCH (p:Person)-[r:REVIEWED|WROTE]->(m:Movie)
WHERE m.released < 2001
RETURN p,r,m

// 5. Grafo que muestre las personas que REVIEW or WROTE una película con released <2001 y no sea Top Gun
MATCH (p:Person)-[r:REVIEWED|WROTE]->(m:Movie)
WHERE m.released < 2001
AND m.title <> 'Top Gun'
RETURN p,r,m


// 6. Grafo de los actores actuaron en la misma película que Keanu Reeves y su lista de películas ()
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(op:Person)
WHERE p.name = 'Keanu Reeves'
return op, m

// 7. Tabla de los actores actuaron en la misma película que Keanu Reeves y su lista de películas.
// Mostrar los nombres de las películas como colección
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(op:Person)
WHERE p.name = 'Keanu Reeves'
return op.name, collect(m.title)

// 8. Tabla de los actores actuaron en la misma película que Keanu Reeves y su lista de películas. 
// Contar las películas
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(op:Person)
WHERE p.name = 'Keanu Reeves'
return op.name, count(distinct m.title)


// 9. Todas las películas que contengan la palabra Matrix en el título
MATCH (m)
WHERE m.title CONTAINS "Matrix"
return collect(m.title)


// 10. Todas las películas que contengan la palabra All o all en el título
MATCH (m)
WHERE m.title CONTAINS "All"
OR  m.title CONTAINS "all"
return collect(m.title)

// 11. Nombre de las personas que nacieron en 1964, 1965 y 1967. Mostrar los años y los nombres de las personas como colección.

// 12. Muestra todas las personas, opcionalmente a las que hicieron un review. 
//Primero deben aparecer las que hicieron una review

// 13. Muestra las personas que hicieron una review, los rating que uso como colección, 
// el promedio de las calificaciones y el total de películas que calificó

// 14. Muestra las personas que hicieron una review, los rating que uso como colección, el promedio de las calificaciones
// y el total de películas que calificó

// Añadimos un CASE
// 15. un ejemplo con WITH. Solo quiero los buenos evaluadores

// 16. Número de personas y número de películas utilizando UNION ALL y UNION (quita duplicados)

// 17. Los tipos de relaciones que tiene el grafo

// 18. Cuantas relaciones de cada tipo hay
