DELIMITER $$
DROP FUNCTION IF EXISTS `yale_dev`.`getComponentAncestry` $$
CREATE FUNCTION `yale_dev`.`getComponentAncestry` (GivenID INT) RETURNS VARCHAR(1024)
DETERMINISTIC
BEGIN
    DECLARE rv VARCHAR(1024);
    DECLARE cm CHAR(1);
    DECLARE ch INT;
SET rv = '';
    SET cm = '';
    SET ch = GivenID;
    WHILE ch > 0 DO
        SELECT IFNULL(parentResourceComponentId,-1) INTO ch FROM
        (SELECT parentResourceComponentId FROM ResourcesComponents WHERE resourceComponentId = ch) A;
        IF ch > 0 THEN
            SET rv = CONCAT(rv,cm,ch);
            SET cm = ',';
        END IF;
    END WHILE;
    RETURN rv;
END $$
DELIMITER ;