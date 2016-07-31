USE olympics2016;

-- datafix to correct Russian handicap
UPDATE countries SET handicap = 0 WHERE name = 'Russia';
UPDATE countries SET handicap = 15 WHERE name = 'Great Britain';
UPDATE countries SET handicap = 52 WHERE name = 'Germany';
UPDATE countries SET handicap = 59 WHERE name = 'Australia';
UPDATE countries SET handicap = 72 WHERE name = 'France';
UPDATE countries SET handicap = 74 WHERE name = 'South Korea';
UPDATE countries SET handicap = 78 WHERE name = 'Japan';
UPDATE countries SET handicap = 87 WHERE name = 'Italy';

CALL calculate_team_standings;
