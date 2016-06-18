-- Test data
USE worldcup2014;

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('France', 'img/France.png', TRUE, 'A', 9, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Mexico', 'img/Mexico.png', TRUE, 'A', 17, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('South Africa', 'img/South_Africa.png', TRUE, 'A', 83, 4);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Uruguay', 'img/Uruguay.png', TRUE, 'A', 16, 2);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Argentina', 'img/Argentina.png', TRUE, 'B', 7, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Greece', 'img/Greece.png', TRUE, 'B', 13, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Nigeria', 'img/Nigeria.png', TRUE, 'B', 21, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('South Korea', 'img/South_Korea.png', TRUE, 'B', 47, 4);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Algeria', 'img/Algeria.png', TRUE, 'C', 30, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('England', 'img/England.png', TRUE, 'C', 8, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Slovenia', 'img/Slovenia.png', TRUE, 'C', 25, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('USA', 'img/USA.png', TRUE, 'C', 14, 2);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Australia', 'img/Australia.png', TRUE, 'D', 20, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Germany', 'img/Germany.png', TRUE, 'D', 6, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Ghana', 'img/Ghana.png', TRUE, 'D', 32, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Serbia', 'img/Serbia.png', TRUE, 'D', 15, 2);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Cameroon', 'img/Cameroon.png', TRUE, 'E', 19, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Denmark', 'img/Denmark.png', TRUE, 'E', 36, 4);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Netherlands', 'img/Netherlands.png', TRUE, 'E', 4, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Japan', 'img/Japan.png', TRUE, 'E', 45, 4);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Italy', 'img/Italy.png', TRUE, 'F', 5, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('New Zealand', 'img/New_Zealand.png', TRUE, 'F', 78, 4);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Paraguay', 'img/Paraguay.png', TRUE, 'F', 31, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Slovakia', 'img/Slovakia.png', TRUE, 'F', 38, 4);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Brazil', 'img/Brazil.png', TRUE, 'G', 1, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Ivory Coast', 'img/Ivory_Coast.png', TRUE, 'G', 27, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('North Korea', 'img/North_Korea.png', TRUE, 'G', 105, 4);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Portugal', 'img/Portugal.png', TRUE, 'G', 3, 1);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Chile', 'img/Chile.png', TRUE, 'H', 18, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Honduras', 'img/Honduras.png', TRUE, 'H', 38, 4);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Spain', 'img/Spain.png', TRUE, 'H', 2, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Switzerland', 'img/Switzerland.png', TRUE, 'H', 24, 3);

INSERT INTO users(name, email, password, team) VALUES ('Ali', 'ali@admin.invalid', PASSWORD('password'), 'e^(i*Pi)');
INSERT INTO users(name, email, password, team) VALUES ('David', 'david@admin.invalid', PASSWORD('password'), 'Bob!');

INSERT INTO users(name, email, password) VALUES ('admin', 'admin@admin.invalid', PASSWORD('password'));

INSERT INTO countries_on_teams(team, country) VALUES ('e^(i*Pi)', 'USA');
INSERT INTO countries_on_teams(team, country) VALUES ('e^(i*Pi)', 'Spain');
INSERT INTO countries_on_teams(team, country) VALUES ('e^(i*Pi)', 'Germany');

INSERT INTO results(id, country, goals_for, goals_against, points) VALUES (NULL, 'England', 7, 0, 4);
INSERT INTO results(id, country, goals_for, goals_against, points) VALUES (NULL, 'USA', 0, 7, 1);

INSERT INTO results(id, country, goals_for, goals_against, points) VALUES (NULL, 'England', 4, 1, 4);
INSERT INTO results(id, country, goals_for, goals_against, points) VALUES (NULL, 'Slovenia', 1, 4, 1);

INSERT INTO results(id, country, goals_for, goals_against, points) VALUES (NULL, 'USA', 1, 1, 2);
INSERT INTO results(id, country, goals_for, goals_against, points) VALUES (NULL, 'Algeria', 1, 1, 2);

CALL calculate_team_standings;
