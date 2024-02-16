// Villains and degree
MATCH (v:Villain)
RETURN v.Degree as Degree,
         COUNT(DISTINCT v) how_many
ORDER BY Degree DESC


MATCH (v:Villain)
WHERE v.Name = "Lobo"
RETURN v.Name, v.Degree as Degree,v.PageRank as PageRank, v.Betweenness as Betweenness