-- Live data
-- TODO: populate with 2016 values

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Brazil', 'img/Brazil.png', TRUE, 'A', 7, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Mexico', 'img/Mexico.png', TRUE, 'A', 19, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Croatia', 'img/Croatia.png', TRUE, 'A', 20, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Cameroon', 'img/Cameroon.png', TRUE, 'A', 50, 4);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Spain', 'img/Spain.png', TRUE, 'B', 1, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Netherlands', 'img/Netherlands.png', TRUE, 'B', 15, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Chile', 'img/Chile.png', TRUE, 'B', 14, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Australia', 'img/Australia.png', TRUE, 'B', 59, 4);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Colombia', 'img/Colombia.png', TRUE, 'C', 4, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Greece', 'img/Greece.png', TRUE, 'C', 10, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Ivory Coast', 'img/Ivory_Coast.png', TRUE, 'C', 21, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Japan', 'img/Japan.png', TRUE, 'C', 47, 4);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Uruguay', 'img/Uruguay.png', TRUE, 'D', 5, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Costa Rica', 'img/Costa_Rica.png', TRUE, 'D', 34, 4);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('England', 'img/England.png', TRUE, 'D', 11, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Italy', 'img/Italy.png', TRUE, 'D', 9, 2);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Switzerland', 'img/Switzerland.png', TRUE, 'E', 8, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Ecuador', 'img/Ecuador.png', TRUE, 'E', 28, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('France', 'img/France.png', TRUE, 'E', 16, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Honduras', 'img/Honduras.png', TRUE, 'E', 32, 3);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Argentina', 'img/Argentina.png', TRUE, 'F', 6, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Bosnia & Herzegovina', 'img/Bosnia.png', TRUE, 'F', 25, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Iran', 'img/Iran.png', TRUE, 'F', 37, 4);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Nigeria', 'img/Nigeria.png', TRUE, 'F', 45, 4);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Germany', 'img/Germany.png', TRUE, 'G', 2, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Portugal', 'img/Portugal.png', TRUE, 'G', 3, 1);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Ghana', 'img/Ghana.png', TRUE, 'G', 38, 4);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('USA', 'img/USA.png', TRUE, 'G', 13, 2);

INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Belgium', 'img/Belgium.png', TRUE, 'H', 12, 2);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Algeria', 'img/Algeria.png', TRUE, 'H', 25, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('Russia', 'img/Russia.png', TRUE, 'H', 18, 3);
INSERT INTO countries(name, flag_path, is_active, starting_group, world_ranking, pool) VALUES ('South Korea', 'img/South_Korea.png', TRUE, 'H', 56, 4);


INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Brazil', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Mexico', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Croatia', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Cameroon', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Spain', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Netherlands', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Chile', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Australia', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Colombia', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Greece', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Ivory Coast', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Japan', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Uruguay', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Costa Rica', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('England', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Italy', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Switzerland', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Ecuador', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('France', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Honduras', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Argentina', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Bosnia & Herzegovina', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Iran', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Nigeria', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Germany', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Portugal', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Ghana', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('USA', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Belgium', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Algeria', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('Russia', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO country_standings(country, played, won, drawn, lost, goals_for, goals_against, points) VALUES ('South Korea', 0, 0, 0, 0, 0, 0, 0);

INSERT INTO users(name, email, password) VALUES ('admin', 'admin@admin.invalid', PASSWORD('IloveAllan'));
