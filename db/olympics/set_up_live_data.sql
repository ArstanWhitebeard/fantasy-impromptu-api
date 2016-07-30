-- Live data
USE olympics2016;

INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Russia', 'img/Russia.png', TRUE, 0, 170, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Great Britain', 'img/Great_Britain.png', TRUE, 0, 169, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Germany', 'img/Germany.png', TRUE, 37, 96, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Australia', 'img/Australia.png', TRUE, 44, 74, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('France', 'img/France.png', TRUE, 57, 78, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('South Korea', 'img/South_Korea.png', TRUE, 59, 75, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Japan', 'img/Japan.png', TRUE, 63, 73, 1);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Italy', 'img/Italy.png', TRUE, 72, 61, 1);

INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Canada', 'img/Canada.png', TRUE, 0, 26, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Brazil', 'img/Brazil.png', TRUE, 1, 31, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Kazakhstan', 'img/Kazakhstan.png', TRUE, 3, 35, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Jamaica', 'img/Jamaica.png', TRUE, 4, 28, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Kenya', 'img/Kenya.png', TRUE, 5, 21, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Poland', 'img/Poland.png', TRUE, 9, 18, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Iran', 'img/Iran.png', TRUE, 12, 29, 2);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Norway', 'img/Norway.png', TRUE, 14, 11, 2);

INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('North Korea', 'img/North_Korea.png', TRUE, 0, 18, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Sweden', 'img/Sweden.png', TRUE, 1, 15, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Georgia', 'img/Georgia.png', TRUE, 2, 13, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Croatia', 'img/Croatia.png', TRUE, 3, 16, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('South Africa', 'img/South_Africa.png', TRUE, 4, 17, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Argentina', 'img/Argentina.png', TRUE, 5, 8, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Thailand', 'img/Thailand.png', TRUE, 6, 5, 3);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Mongolia', 'img/Mongolia.png', TRUE, 7, 7, 3);

INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Ireland', 'img/Ireland.png', TRUE, 0, 10, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('India', 'img/India.png', TRUE, 1, 8, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Indonesia', 'img/Indonesia.png', TRUE, 1, 3, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Belgium', 'img/Belgium.png', TRUE, 2, 4, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Tunisia', 'img/Tunisia.png', TRUE, 2, 7, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Egypt', 'img/Egypt.png', TRUE, 3, 4, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Bahamas', 'img/Bahamas.png', TRUE, 3, 4, 4);
INSERT INTO countries(name, flag_path, is_active, handicap, previous, pool) VALUES ('Zimbabwe', 'img/Zimbabwe.png', TRUE, 3, 0, 4);

INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Great Britain', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Germany', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Australia', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('France', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Japan', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Italy', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Cuba', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Hungary', 0, 0, 0);

INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Canada', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Brazil', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Kazakhstan', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Jamaica', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Kenya', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Poland', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Iran', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Norway', 0, 0, 0);

INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('North Korea', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Sweden', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Georgia', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Croatia', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('South Africa', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Argentina', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Thailand', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Mongolia', 0, 0, 0);

INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Ireland', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('India', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Indonesia', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Belgium', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Tunisia', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Egypt', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Bahamas', 0, 0, 0);
INSERT INTO country_standings(country, golds, silvers, bronzes) VALUES ('Zimbabwe', 0, 0, 0);
