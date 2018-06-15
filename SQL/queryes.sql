#���-5 ����� �� ���������� ��������� � �������
SELECT name FROM country ORDER BY population DESC LIMIT 5

#��������� ���-�� �����, ��������� �� ���������� ����� � ������
SELECT SUM(population/100*countrylanguage.percentage) AS population FROM country INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = 'English' AND country.Continent = 'Europe'

/*������ ����� � ����� � ����� ������������ �������, � ������� ����������
������������� ������ ��� ������� ����� ������, ��� �����������*/
SELECT name, SUM(countrylanguage.IsOfficial = 'T') AS official, SUM(countrylanguage.IsOfficial = 'F') AS nonofficial
FROM country INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
GROUP BY name HAVING SUM(countrylanguage.IsOfficial='T') >= 2 AND SUM(countrylanguage.IsOfficial='F') > SUM(countrylanguage.IsOfficial='T')*2