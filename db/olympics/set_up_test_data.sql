-- Test data

USE olympics2016;

INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('France', 'img/France.png', TRUE, 9, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Mexico', 'img/Mexico.png', TRUE, 17, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('South Africa', 'img/South_Africa.png', TRUE, 83, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Uruguay', 'img/Uruguay.png', TRUE, 16, 2);

INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Argentina', 'img/Argentina.png', TRUE, 7, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Greece', 'img/Greece.png', TRUE, 13, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Nigeria', 'img/Nigeria.png', TRUE, 21, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('South Korea', 'img/South_Korea.png', TRUE, 47, 4);

INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Algeria', 'img/Algeria.png', TRUE, 30, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('England', 'img/England.png', TRUE, 8, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Slovenia', 'img/Slovenia.png', TRUE, 25, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('USA', 'img/USA.png', TRUE, 14, 2);

INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Australia', 'img/Australia.png', TRUE, 20, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Germany', 'img/Germany.png', TRUE, 6, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Ghana', 'img/Ghana.png', TRUE, 32, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Serbia', 'img/Serbia.png', TRUE, 15, 2);

INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Cameroon', 'img/Cameroon.png', TRUE, 19, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Denmark', 'img/Denmark.png', TRUE, 36, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Netherlands', 'img/Netherlands.png', TRUE, 4, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Japan', 'img/Japan.png', TRUE, 45, 4);

INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Italy', 'img/Italy.png', TRUE, 5, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('New Zealand', 'img/New_Zealand.png', TRUE, 78, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Paraguay', 'img/Paraguay.png', TRUE, 31, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Slovakia', 'img/Slovakia.png', TRUE, 38, 4);

INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Brazil', 'img/Brazil.png', TRUE, 1, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Ivory Coast', 'img/Ivory_Coast.png', TRUE, 27, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('North Korea', 'img/North_Korea.png', TRUE, 105, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Portugal', 'img/Portugal.png', TRUE, 3, 1);

INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Chile', 'img/Chile.png', TRUE, 18, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Honduras', 'img/Honduras.png', TRUE, 38, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Spain', 'img/Spain.png', TRUE, 2, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, pool) VALUES ('Switzerland', 'img/Switzerland.png', TRUE, 24, 3);

INSERT INTO users(name, how_known, team) VALUES ('Ali', 'self', 'e^(i*Pi)');
INSERT INTO users(name, how_known, team) VALUES ('ArstanWhitebeard', 'also self', 'Kingsguard');


INSERT INTO countries_on_teams(team, country) VALUES ('e^(i*Pi)', 'USA');
INSERT INTO countries_on_teams(team, country) VALUES ('e^(i*Pi)', 'Spain');
INSERT INTO countries_on_teams(team, country) VALUES ('e^(i*Pi)', 'Germany');

INSERT INTO countries_on_teams(team, country) VALUES ('Kingsguard', 'Spain');

INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('USA', 5, 4, 1);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Spain', 15, 14, 11);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Germany', 3, 1, 0);

CALL calculate_team_standings;
