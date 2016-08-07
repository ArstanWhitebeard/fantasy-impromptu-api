USE olympics2016;

DROP PROCEDURE calculate_team_standings;

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

CALL calculate_team_standings();
