DROP DATABASE IF EXISTS olympics2016;

CREATE DATABASE olympics2016;
USE olympics2016;

DROP PROCEDURE IF EXISTS calculate_team_standings;
DROP TABLE IF EXISTS team_standings;
DROP TABLE IF EXISTS country_standings;
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS countries_on_teams;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS countries;

-- schema setup

CREATE TABLE countries (
    name VARCHAR(32) NOT NULL,
    flag_path VARCHAR(256) NOT NULL,
    is_active BOOLEAN NOT NULL,
    handicap INTEGER NOT NULL,
    previous INTEGER NOT NULL,
    pool INTEGER NOT NULL,

    PRIMARY KEY(name)
) ENGINE = INNODB;

CREATE TABLE users (
    name VARCHAR(32) NOT NULL,
    how_known VARCHAR(256),
    team VARCHAR(32) NOT NULL,

    PRIMARY KEY (team)
) ENGINE = INNODB;

CREATE TABLE countries_on_teams (
    team VARCHAR(32) NOT NULL,
    country VARCHAR(32) NOT NULL,

    FOREIGN KEY (team) REFERENCES users(team),
    FOREIGN KEY (country) REFERENCES countries(name)
) ENGINE = INNODB;

-- Partly denormalised

CREATE TABLE country_standings (
    country VARCHAR(32) NOT NULL,
    golds INTEGER NOT NULL,
    silvers INTEGER NOT NULL,
    bronzes INTEGER NOT NULL,

    PRIMARY KEY(country)
) ENGINE = INNODB;

-- Partly denormalised

CREATE TABLE team_standings (
    team VARCHAR(32) NOT NULL,
    username VARCHAR(32) NOT NULL,
    golds INTEGER NOT NULL,
    silvers INTEGER NOT NULL,
    bronzes INTEGER NOT NULL,
    handicaps INTEGER NOT NULL,
    points INTEGER NOT NULL,

    PRIMARY KEY(team),
    FOREIGN KEY(team) REFERENCES users(team)
) ENGINE = INNODB;

DELIMITER //

CREATE PROCEDURE calculate_team_standings()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE this_team VARCHAR(32);
    DECLARE this_username VARCHAR(32);
    DECLARE total_golds INTEGER;
    DECLARE total_silvers INTEGER;
    DECLARE total_bronzes INTEGER;
    DECLARE total_points INTEGER;
    DECLARE total_handicaps INTEGER;
    DECLARE team_cursor CURSOR FOR SELECT team, name FROM users WHERE team IS NOT NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    DELETE FROM team_standings;

    OPEN team_cursor;
    REPEAT
        FETCH team_cursor INTO this_team, this_username;

        IF NOT done THEN

            SELECT SUM(cs.golds), SUM(cs.silvers), SUM(cs.bronzes), SUM(c.handicap)
            INTO total_golds, total_silvers, total_bronzes, total_handicaps
            FROM country_standings cs RIGHT OUTER JOIN countries c ON cs.country = c.name
            WHERE c.name IN (
                SELECT country FROM countries_on_teams WHERE team = this_team
            );

            SET total_points = 4*IFNULL(total_golds, 0) + 2*IFNULL(total_silvers, 0) + IFNULL(total_bronzes, 0) + IFNULL(total_handicaps, 0);

            INSERT INTO team_standings (team, username, golds, silvers, bronzes, handicaps, points)
            VALUES (this_team, this_username, IFNULL(total_golds, 0), IFNULL(total_silvers, 0), IFNULL(total_bronzes, 0), IFNULL(total_handicaps, 0), IFNULL(total_points, 0));
        END IF;
    UNTIL done END REPEAT;

END //

DELIMITER ;

-- API user
CREATE USER IF NOT EXISTS 'api'@'localhost' IDENTIFIED BY 'r4ms4ysD0gs';
GRANT SELECT ON olympics2016.* TO 'api'@'localhost';
GRANT INSERT ON olympics2016.users TO 'api'@'localhost';
GRANT INSERT ON olympics2016.countries_on_teams TO 'api'@'localhost';
GRANT EXECUTE ON PROCEDURE olympics2016.calculate_team_standings TO 'api'@'localhost';

CREATE USER IF NOT EXISTS 'scraper'@'localhost' IDENTIFIED BY 'r4ms4ysD0gs';
GRANT DELETE ON olympics2016.country_standings TO 'scraper'@'localhost';
GRANT INSERT ON olympics2016.country_standings TO 'scraper'@'localhost';
GRANT EXECUTE ON PROCEDURE olympics2016.calculate_team_standings TO 'scraper'@'localhost';
