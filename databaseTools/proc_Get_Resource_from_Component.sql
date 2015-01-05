DELIMITER $$
DROP FUNCTION IF EXISTS `yale_dev`.`getResourceFromComponent` $$
CREATE FUNCTION `yale_dev`.`getResourceFromComponent` (GivenID INT) RETURNS VARCHAR(1024)
DETERMINISTIC
BEGIN
	DECLARE rv INT;
    DECLARE tp INT;
    DECLARE ch INT;
SET tp = GivenID; /*There is no component 0 so this will be returned if first hit is top level*/
    SET ch = GivenID;
    WHILE ch > 0 DO
        SELECT IFNULL(parentResourceComponentId,-1) INTO ch FROM
        (SELECT parentResourceComponentId FROM ResourcesComponents WHERE resourceComponentId = ch) A;
        IF ch > 0 THEN
            SET tp = ch; /*Keep replacing with the next value up the tree until you hit -1 which means the parent was null*/
        END IF;
    END WHILE;
select resourceId into rv from ResourcesComponents where resourceComponentId = tp;
    RETURN rv;
END $$
DELIMITER ;