DELIMITER $$
DROP FUNCTION IF EXISTS `yale_dev`.`getTopComponent` $$
CREATE FUNCTION `yale_dev`.`getTopComponent` (GivenID INT) RETURNS VARCHAR(1024)
DETERMINISTIC
BEGIN
    DECLARE rv INT;
    DECLARE ch INT;
SET rv = 0; /*There is no component 0 so this will be returned if first hit is top level*/
    SET ch = GivenID;
    WHILE ch > 0 DO
        SELECT IFNULL(parentResourceComponentId,-1) INTO ch FROM
        (SELECT parentResourceComponentId FROM ResourcesComponents WHERE resourceComponentId = ch) A;
        IF ch > 0 THEN
            SET rv = ch; /*Keep replacing with the next value up the tree until you hit -1 which means the parent was null*/
        END IF;
    END WHILE;
    RETURN rv;
END $$
DELIMITER ;