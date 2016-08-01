USE olympics2016;

INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Russia', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('South Korea', 0, 0, 0);

DELETE FROM country_standings where country='Cuba';
DELETE FROM country_standings where country='Hungary';

CALL calculate_team_standings;
