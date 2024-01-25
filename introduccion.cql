// Clear screen 
:clear

//Nodes
()
:Producto
:producto
(:Producto)
(:Empleado)
(:Estudiante)

//Relationships
-- --> <--
-[:BUSCO]-> -[:COMPRA]-> -[:ESTUDIA]->

//Attributes
{nombre:"Juan"} 

(:Estudiante{nombre:"Luis"})-[:AMIGO]->(:Estudiante{nombre:"Lupe"})

///
SQL             
SELECT  RETURN  MATCH
FROM    MATCH   WHERE
WHERE   WHERE   RETURN

//Create nodes
CREATE (:Estudiante{nombre:"Luis"})-[:AMIGO]->(:Estudiante{nombre:"Lupe"})
CREATE (:ESTUDIANTE)
CREATE (:PROFESOR)

CREATE (p:PROFESOR) RETURN p

CREATE (e:Estudiante{nombre:"Rodo"})-[r:AMIGO]->(oe:Estudiante{nombre:"Lupe"}) RETURN e,r,oe

//All proffesor nodes
MATCH (p:PROFESOR) RETURN p

//All student names
MATCH (e:ESTUDIANTE) RETURN e.nombre
//Number
MATCH (e:Estudiante) RETURN COUNT(e) AS numEstudiante

//See schema
CALL db.schema.visualization

//Count Person Node
MATCH (p:Person)
RETURN COUNT(p)

//Count persons that have FOLLOW relationships
MATCH (p:Person)-[r:FOLLOWS]->()
RETURN COUNT(r)

//Count all FOLLOW relationships
MATCH ()-[r:FOLLOWS]->()
RETURN COUNT(r)

//Get labels
call db.labels

//Get relationships
call db.relationshipTypes

//Get attributes 
call db.propertyKeys


//Get attributes by node
call db.schema.nodeTypeProperties


//Get attributes by relationships
call db.schema.relTypeProperties

//Other tools
call dbms.info
call dbms.components //Get version
call dbms.showCurrentUser

//In which movies Tom Hanks has acted in 
MATCH (p:Person{name:'Tom Hanks'})-[r:ACTED_IN]->(m:Movie)
RETURN p,r,m

//Same but returning a table
MATCH (p:Person{name:'Tom Hanks'})-[r:ACTED_IN]->(m:Movie)
RETURN p.name,m.title

//Same but using where
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)
WHERE p.name = 'Tom Hanks'
RETURN p.name,m.title


//Get list of movies
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)
WHERE p.name = 'Tom Hanks'
RETURN p.name, COUNT(r),
COLLECT (m.title)


//All people that have made a review to a movie
//Return name and rating

MATCH (p:Person)-[r:REVIEWED]->(m:Movie)
RETURN p.name, COUNT(r) AS reviews_amount


//FRom Keanu Reeves show movies and actors which have movies in common
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(op:Person)
WHERE p.name = 'Keanu Reeves'
RETURN p.name,m.title,COLLECT(op.name)


//Graph that shows people who have wrote  or reviewed a movie
MATCH (p:Person)-[r:REVIEWED|WROTE]->(m:Movie)
RETURN p,r,m

//Return it in a list
MATCH (p:Person)-[r:REVIEWED|WROTE]->(m:Movie)
RETURN  COLLECT(p.name)


//Graphs of 1,2,3 jumps

//One jump 
MATCH (p:Person{name:'Keanu Reeves'})-[*1]-(m) RETURN p,m