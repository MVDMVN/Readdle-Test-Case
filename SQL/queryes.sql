#Топ-5 стран по количеству населения в столице
SELECT name FROM country ORDER BY population DESC LIMIT 5

#Суммарное кол-во людей, говорящих на английском языке в Европе
SELECT SUM(population/100*countrylanguage.percentage) AS population FROM country INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = 'English' AND country.Continent = 'Europe'

/*Список стран с двумя и более официальными языками, в которых количество
неофициальных языков как минимум вдвое больше, чем официальных*/
SELECT name, SUM(countrylanguage.IsOfficial = 'T') AS official, SUM(countrylanguage.IsOfficial = 'F') AS nonofficial
FROM country INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
GROUP BY name HAVING SUM(countrylanguage.IsOfficial='T') >= 2 AND SUM(countrylanguage.IsOfficial='F') > SUM(countrylanguage.IsOfficial='T')*2