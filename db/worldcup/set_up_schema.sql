DROP DATABASE IF EXISTS worldcup2014;

CREATE DATABASE worldcup2014;
USE worldcup2014;

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
    starting_group VARCHAR(1) NOT NULL,
    world_ranking INTEGER NOT NULL,
    pool INTEGER NOT NULL,

    PRIMARY KEY(name)
) ENGINE = INNODB;

CREATE TABLE users (
    name VARCHAR(32) NOT NULL,
    email VARCHAR(256) NOT NULL,
    password CHAR(64) NOT NULL,
    team VARCHAR(32),
    groups INTEGER,
    INDEX (team),

    PRIMARY KEY (email)
) ENGINE = INNODB;

CREATE TABLE countries_on_teams (
    team VARCHAR(32) NOT NULL,
    country VARCHAR(32) NOT NULL,

    FOREIGN KEY (team) REFERENCES users(team),
    FOREIGN KEY (country) REFERENCES countries(name)
) ENGINE = INNODB;

CREATE TABLE results (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    country VARCHAR(32) NOT NULL,
    goals_for INTEGER NOT NULL,
    goals_against INTEGER NOT NULL,
    points INTEGER NOT NULL,

    PRIMARY KEY(id),
    FOREIGN KEY (country) REFERENCES countries(name)
) ENGINE = INNODB;
-- Partly denormalised

CREATE TABLE country_standings (
    country VARCHAR(32) NOT NULL,
    played INTEGER NOT NULL,
    won INTEGER NOT NULL,
    drawn INTEGER NOT NULL,
    lost INTEGER NOT NULL,
    goals_for INTEGER NOT NULL,
    goals_against INTEGER NOT NULL,
    points INTEGER NOT NULL,

    PRIMARY KEY(country),
    FOREIGN KEY(country) REFERENCES countries(name)
) ENGINE = INNODB;

-- Partly denormalised

CREATE TABLE team_standings (
    team VARCHAR(32) NOT NULL,
    username VARCHAR(32) NOT NULL,
    played INTEGER NOT NULL,
    won INTEGER NOT NULL,
    drawn INTEGER NOT NULL,
    lost INTEGER NOT NULL,
    goals_for INTEGER NOT NULL,
    goals_against INTEGER NOT NULL,
    points INTEGER NOT NULL,

    PRIMARY KEY(team),
    FOREIGN KEY(team) REFERENCES users(team)
) ENGINE = INNODB;

DELIMITER //

-- TODO write calculate_country_standings, which was previously done in PHP at add-result-time

CREATE PROCEDURE calculate_team_standings()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE this_team VARCHAR(32);
    DECLARE this_username VARCHAR(32);
    DECLARE total_played INTEGER;
    DECLARE total_won INTEGER;
    DECLARE total_drawn INTEGER;
    DECLARE total_lost INTEGER;
    DECLARE total_goals_for INTEGER;
    DECLARE total_goals_against INTEGER;
    DECLARE total_points INTEGER;
    DECLARE team_cursor CURSOR FOR SELECT team, name FROM users WHERE team IS NOT NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    DELETE FROM team_standings;

    OPEN team_cursor;
    REPEAT
        FETCH team_cursor INTO this_team, this_username;

        IF NOT done THEN

            SELECT SUM(played), SUM(won), SUM(drawn), SUM(lost), SUM(goals_for), SUM(goals_against), SUM(points)
            INTO total_played, total_won, total_drawn, total_lost, total_goals_for, total_goals_against, total_points
            FROM country_standings
            WHERE country IN (
                SELECT country FROM countries_on_teams WHERE team = this_team);

            INSERT INTO team_standings (team, username, played, won, drawn, lost, goals_for, goals_against, points)
            VALUES (this_team, this_username, IFNULL(total_played, 0), IFNULL(total_won, 0), IFNULL(total_drawn, 0), IFNULL(total_lost, 0), IFNULL(total_goals_for, 0), IFNULL(total_goals_against, 0), IFNULL(total_points, 0));
        END IF;
    UNTIL done END REPEAT;

END //

DELIMITER ;
