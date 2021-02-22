CREATE DEFINER=`root`@`localhost` FUNCTION `batchVerify`(batch_id smallint) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
declare current_batch smallint;
declare batch_year tinyint;
set current_batch = (select batchId from batch where isCurrent = 1);
set batch_year = current_batch - batch_id + 1;
	if batch_year = 1 || batch_year = 0 then
		RETURN 1;
	else
		RETURN 0;
	end if;
END