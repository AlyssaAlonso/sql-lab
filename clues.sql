-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
-- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
-- so find the least populated country in Southern Europe, and we'll start looking for her there.
 
-- Write SQL query here

-- SELECT * FROM country
-- WHERE region = 'Southern Europe'
-- ORDER BY population
-- LIMIT 1;

--  code |             name              | continent |     region      | surfacearea | indepyear | population | lifeexpectancy | gnp  | gnpold |            localname            |      governmentform      |     headofstate     | capital | code2 
-- ------+-------------------------------+-----------+-----------------+-------------+-----------+------------+----------------+------+--------+---------------------------------+--------------------------+---------------------+---------+-------
--  VAT  | Holy See (Vatican City State) | Europe    | Southern Europe |         0.4 |      1929 |       1000 |                | 9.00 |        | Santa Sede/Cittï¿½ del Vaticano | Independent Church State | Johannes Paavali II |    3538 | VA
-- (1 row)


-- ANSWER:
-- VAT - Vatican City

-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
-- this country's officially recognized language. Check our databases and find out what language is
-- spoken in this country, so we can call in a translator to work with you.

-- Write SQL query here

-- SELECT * FROM countrylanguage L
-- JOIN country C ON L.countrycode = C.code
-- WHERE C.code = 'VAT';

--  countrycode | language | isofficial | percentage | code |             name              | continent |     region      | surfacearea | indepyear | population | lifeexpectancy | gnp  | gnpold |            localname            |      governmentform      |     headofstate     | capital | code2 
-- -------------+----------+------------+------------+------+-------------------------------+-----------+-----------------+-------------+-----------+------------+----------------+------+--------+---------------------------------+--------------------------+---------------------+---------+-------
--  VAT         | Italian  | t          |          0 | VAT  | Holy See (Vatican City State) | Europe    | Southern Europe |         0.4 |      1929 |       1000 |                | 9.00 |        | Santa Sede/Cittï¿½ del Vaticano | Independent Church State | Johannes Paavali II |    3538 | VA
-- (1 row)

-- ANSWER:
-- Italian

-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
-- to a different country, a country where people speak only the language she was learning. Find out which
-- nearby country speaks nothing but that language.

-- Write SQL query here

-- SELECT * FROM country C
-- JOIN countrylanguage L
-- ON C.code = L.countrycode
-- WHERE C.region = 'Southern Europe' AND L.language = 'Italian';

--  code |             name              | continent |     region      | surfacearea | indepyear | population | lifeexpectancy |    gnp     |   gnpold   |            localname            |      governmentform      |     headofstate      | capital | code2 | countrycode | language | isofficial | percentage 
-- ------+-------------------------------+-----------+-----------------+-------------+-----------+------------+----------------+------------+------------+---------------------------------+--------------------------+----------------------+---------+-------+-------------+----------+------------+------------
--  ITA  | Italy                         | Europe    | Southern Europe |      301316 |      1861 |   57680000 |             79 | 1161755.00 | 1145372.00 | Italia                          | Republic                 | Carlo Azeglio Ciampi |    1464 | IT    | ITA         | Italian  | t          |       94.1
--  SMR  | San Marino                    | Europe    | Southern Europe |          61 |       885 |      27000 |           81.1 |     510.00 |            | San Marino                      | Republic                 |                      |    3171 | SM    | SMR         | Italian  | t          |        100
--  VAT  | Holy See (Vatican City State) | Europe    | Southern Europe |         0.4 |      1929 |       1000 |                |       9.00 |            | Santa Sede/Cittï¿½ del Vaticano | Independent Church State | Johannes Paavali II  |    3538 | VA    | VAT         | Italian  | t          |          0
-- (3 rows)

-- ANSWER:
-- SMR - San Marino

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time.
-- There are only two cities she could be flying to in the country. One is named the same as the country – that
-- would be too obvious. We're following our gut on this one; find out what other city in that country she might
-- be flying to.

-- Write SQL query here

-- SELECT * FROM city
-- WHERE countrycode = 'SMR' AND name <> 'San Marino';

--   id  |    name    | countrycode |     district      | population 
-- ------+------------+-------------+-------------------+------------
--  3170 | Serravalle | SMR         | Serravalle/Dogano |       4802
-- (1 row)

-- ANSWER:
-- Serravalle

-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
-- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
-- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

-- Write SQL query here

-- SELECT * FROM country CO
-- JOIN city CI ON CO.code = CI.countrycode
-- WHERE CO.continent = 'South America' AND CI.name LIKE 'Serra%';

--  code |  name  |   continent   |    region     | surfacearea  | indepyear | population | lifeexpectancy |    gnp    |  gnpold   | localname |  governmentform  |        headofstate        | capital | code2 | id  | name  | countrycode |     district     | population 
-- ------+--------+---------------+---------------+--------------+-----------+------------+----------------+-----------+-----------+-----------+------------------+---------------------------+---------+-------+-----+-------+-------------+------------------+------------
--  BRA  | Brazil | South America | South America | 8.547403e+06 |      1822 |  170115000 |           62.9 | 776739.00 | 804108.00 | Brasil    | Federal Republic | Fernando Henrique Cardoso |     211 | BR    | 265 | Serra | BRA         | Espï¿½rito Santo |     302666
-- (1 row)

-- ANSWER:
-- BRA - Brazil

-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
-- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
-- follow right behind you!

-- Write SQL query here

-- SELECT * FROM country CO
-- JOIN city CI ON CO.capital = CI.id
-- WHERE CO.code = 'BRA';

--  code |  name  |   continent   |    region     | surfacearea  | indepyear | population | lifeexpectancy |    gnp    |  gnpold   | localname |  governmentform  |        headofstate        | capital | code2 | id  |    name    | countrycode |     district     | population 
-- ------+--------+---------------+---------------+--------------+-----------+------------+----------------+-----------+-----------+-----------+------------------+---------------------------+---------+-------+-----+------------+-------------+------------------+------------
--  BRA  | Brazil | South America | South America | 8.547403e+06 |      1822 |  170115000 |           62.9 | 776739.00 | 804108.00 | Brasil    | Federal Republic | Fernando Henrique Cardoso |     211 | BR    | 211 | Brasï¿½lia | BRA         | Distrito Federal |    1969868
-- (1 row)

-- ANSWER
-- Brasï¿½lia

-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to
-- the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the
-- landing dock. Lucky for us, she's getting cocky. She left us a note (below), and I'm sure she thinks she's very clever, but
-- if we can crack it, we can finally put her where she belongs – behind bars.


--               Our playdate of late has been unusually fun –
--               As an agent, I'll say, you've been a joy to outrun.
--               And while the food here is great, and the people – so nice!
--               I need a little more sunshine with my slice of life.
--               So I'm off to add one to the population I find
--               In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.

-- Write SQL query here

-- SELECT * FROM city
-- WHERE population = 91084;

--   id  |     name     | countrycode |  district  | population 
-- ------+--------------+-------------+------------+------------
--  4060 | Santa Monica | USA         | California |      91084
-- (1 row)

-- ANSWER:
-- Santa Monica, CA