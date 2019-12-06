#!/bin/bash
mysql=`/usr/bin/which mysql`
cat=`/usr/bin/which cat`

###########################################
# Partition create



### history ###
echo "Get last date of data in the history table..."
start_date=`$mysql -sN -e "SELECT FROM_UNIXTIME(MIN(clock)) FROM zabbix.history;" | awk '{print $1}'`
end_date=`date +%F`

if [[ $start_date -eq NULL ]] ; then
  start_date=`echo $end_date`
fi

echo "Last data date: $start_date"
echo "Current date: $end_date"

part0="ALTER TABLE history PARTITION BY RANGE (clock)
("
echo "$part0" > /tmp/history.sql
echo "Generate history.sql..."
while ! [[ $start_date > $end_date ]]; do
  part1="PARTITION p$(date -d "$start_date" +%Y_%m_%d)"
  start_date=$(date -d "$start_date + 1 day" +%F)
  part2="VALUES LESS THAN (UNIX_TIMESTAMP(\"$start_date 00:00:00\")) ENGINE = InnoDB,"
  echo $part1 $part2 >> /tmp/history.sql || echo "Error with write file"
done && echo "Generate successfull" || echo "Generate error"
count=`cat /tmp/history.sql | wc -l`

sed -i "$count s/InnoDB,/InnoDB);/" /tmp/history.sql

echo "Cat /tmp/history.sql to mysql..."
$cat /tmp/history.sql  | $mysql zabbix && echo "Cat file to mysql successfull" || "Cat file to mysql error"
##############################################




### history_uint ###
echo "Get last date of data in the history_uint table..."
start_date=`$mysql -sN -e "SELECT FROM_UNIXTIME(MIN(clock)) FROM zabbix.history_uint;" | awk '{print $1}'`
end_date=`date +%F`

if [[ $start_date -eq NULL ]] ; then
  start_date=`echo $end_date`
fi

echo "Last data date: $start_date"
echo "Current date: $end_date"

part0="ALTER TABLE history_uint PARTITION BY RANGE (clock)
("
echo "$part0" > /tmp/history_uint.sql
echo "Generate history_uint.sql..."
while ! [[ $start_date > $end_date ]]; do
  part1="PARTITION p$(date -d "$start_date" +%Y_%m_%d)"
  start_date=$(date -d "$start_date + 1 day" +%F)
  part2="VALUES LESS THAN (UNIX_TIMESTAMP(\"$start_date 00:00:00\")) ENGINE = InnoDB,"
  echo $part1 $part2 >> /tmp/history_uint.sql
done && echo "Generate successfull" || echo "Generate error"

count=`cat /tmp/history_uint.sql | wc -l`
sed -i "$count s/InnoDB,/InnoDB);/" /tmp/history_uint.sql

echo "Cat  /tmp/history_uint.sql to mysql..."
$cat /tmp/history_uint.sql  | $mysql zabbix && echo "Cat file to mysql successfull" || "Cat file to mysql error"
##############################################




### history_str ###
echo "Get last date of data in the history_str table..."
start_date=`$mysql -sN -e "SELECT FROM_UNIXTIME(MIN(clock)) FROM zabbix.history_str;" | awk '{print $1}'`
end_date=`date +%F`

if [[ $start_date -eq NULL ]] ; then
  start_date=`echo $end_date`
fi

echo "Last data date: $start_date"
echo "Current date: $end_date"

part0="ALTER TABLE history_str PARTITION BY RANGE (clock)
("
echo "$part0" > /tmp/history_str.sql
echo "Generate history_str.sql..."
while ! [[ $start_date > $end_date ]]; do
  part1="PARTITION p$(date -d "$start_date" +%Y_%m_%d)"
  start_date=$(date -d "$start_date + 1 day" +%F)
  part2="VALUES LESS THAN (UNIX_TIMESTAMP(\"$start_date 00:00:00\")) ENGINE = InnoDB,"
  echo $part1 $part2 >> /tmp/history_str.sql
done && echo "Generate successfull" || echo "Generate error"

count=`cat /tmp/history_str.sql | wc -l`
sed -i "$count s/InnoDB,/InnoDB);/" /tmp/history_str.sql

echo "Cat /tmp/history_str.sql to mysql..."
$cat /tmp/history_str.sql  | $mysql zabbix && echo "Cat file to mysql successfull" || "Cat file to mysql error"
##############################################




### history_log ###
echo "Get last date of data in the history_log table..."
start_date=`$mysql -sN -e "SELECT FROM_UNIXTIME(MIN(clock)) FROM zabbix.history_log;" | awk '{print $1}'`
end_date=`date +%F`

if [[ $start_date -eq NULL ]] ; then
  start_date=`echo $end_date`
fi

echo "Last data date: $start_date"
echo "Current date: $end_date"

part0="ALTER TABLE history_log PARTITION BY RANGE (clock)
("
echo "$part0" > /tmp/history_log.sql
echo "Generate history_log.sql..."
while ! [[ $start_date > $end_date ]]; do
  part1="PARTITION p$(date -d "$start_date" +%Y_%m_%d)"
  start_date=$(date -d "$start_date + 1 day" +%F)
  part2="VALUES LESS THAN (UNIX_TIMESTAMP(\"$start_date 00:00:00\")) ENGINE = InnoDB,"
  echo $part1 $part2 >> /tmp/history_log.sql
done && echo "Generate successfull" || echo "Generate error"

count=`cat /tmp/history_log.sql | wc -l`
sed -i "$count s/InnoDB,/InnoDB);/" /tmp/history_log.sql

echo "Cat /tmp/history_log.sql to mysql..."
$cat /tmp/history_log.sql  | $mysql zabbix && echo "Cat file to mysql successfull" || "Cat file to mysql error"
##############################################




### history_text ###
echo "Get last date of data in the history_text table..."
start_date=`$mysql -sN -e "SELECT FROM_UNIXTIME(MIN(clock)) FROM zabbix.history_text;" | awk '{print $1}'`
end_date=`date +%F`

if [[ $start_date -eq NULL ]] ; then
  start_date=`echo $end_date`
fi

echo "Last data date: $start_date"
echo "Current date: $end_date"

part0="ALTER TABLE history_text PARTITION BY RANGE (clock)
("
echo "$part0" > /tmp/history_text.sql
echo "Generate history_text.sql..."
while ! [[ $start_date > $end_date ]]; do
  part1="PARTITION p$(date -d "$start_date" +%Y_%m_%d)"
  start_date=$(date -d "$start_date + 1 day" +%F)
  part2="VALUES LESS THAN (UNIX_TIMESTAMP(\"$start_date 00:00:00\")) ENGINE = InnoDB,"
  echo $part1 $part2 >> /tmp/history_text.sql
done && echo "Generate successfull" || echo "Generate error"

count=`cat /tmp/history_text.sql | wc -l`
sed -i "$count s/InnoDB,/InnoDB);/" /tmp/history_text.sql

echo "Cat /tmp/history_text.sql  to mysql..."
$cat /tmp/history_text.sql  | $mysql zabbix && echo "Cat file to mysql successfull" || "Cat file to mysql error"
##############################################




### trends ###
echo "Get last date of data in the trends table..."
start_date=`$mysql -sN -e "SELECT FROM_UNIXTIME(MIN(clock)) FROM zabbix.trends;" | awk '{print $1}'`
end_date=`date +%F`

if [[ $start_date -eq NULL ]] ; then
  start_date=`echo $end_date`
fi

echo "Last data date: $start_date"
echo "Current date: $end_date"

part0="ALTER TABLE trends PARTITION BY RANGE (clock)
("
echo "$part0" > /tmp/trends.sql
echo "Generate trends.sql..."
while ! [[ $start_date > $end_date ]]; do
  part1="PARTITION p$(date -d "$start_date" +%Y_%m_%d)"
  start_date=$(date -d "$start_date + 1 day" +%F)
  part2="VALUES LESS THAN (UNIX_TIMESTAMP(\"$start_date 00:00:00\")) ENGINE = InnoDB,"
  echo $part1 $part2 >> /tmp/trends.sql
done && echo "Generate successfull" || echo "Generate error"

count=`cat /tmp/trends.sql | wc -l`
sed -i "$count s/InnoDB,/InnoDB);/" /tmp/trends.sql

echo "Cat /tmp/trends.sql trends.sql to mysql..."
$cat /tmp/trends.sql  | $mysql zabbix && echo "Cat file to mysql successfull" || "Cat file to mysql error"
##############################################




### trends_uint ###
echo "Get last date of data in the trends_uint table..."
start_date=`$mysql -sN -e "SELECT FROM_UNIXTIME(MIN(clock)) FROM zabbix.trends_uint;" | awk '{print $1}'`
end_date=`date +%F`

if [[ $start_date -eq NULL ]] ; then
  start_date=`echo $end_date`
fi

echo "Last data date: $start_date"
echo "Current date: $end_date"

part0="ALTER TABLE trends_uint PARTITION BY RANGE (clock)
("
echo "$part0" > /tmp/trends_uint.sql
echo "Generate trends_uint.sql..."
while ! [[ $start_date > $end_date ]]; do
  part1="PARTITION p$(date -d "$start_date" +%Y_%m_%d)"
  start_date=$(date -d "$start_date + 1 day" +%F)
  part2="VALUES LESS THAN (UNIX_TIMESTAMP(\"$start_date 00:00:00\")) ENGINE = InnoDB,"
  echo $part1 $part2 >> /tmp/trends_uint.sql
done && echo "Generate successfull" || echo "Generate error"

count=`cat /tmp/trends_uint.sql | wc -l`
sed -i "$count s/InnoDB,/InnoDB);/" /tmp/trends_uint.sql

echo "Cat /tmp/trends_uint.sql to mysql..."
$cat /tmp/trends_uint.sql  | $mysql zabbix && echo "Cat file to mysql successfull" || "Cat file to mysql error"
##############################################

# MySQL tables & proc create
###############################################
# Keep history in days
history_cnt=30
history_uint_cnt=30
history_str_cnt=120
history_text_cnt=120
history_log_cnt=120
trends_cnt=180
trends_uint_cnt=180
# Scheduler start datetime
evnt_start="2019-12-08 04:00:00"


echo "Generate tables for manage & keep partitions..."

manage_part="CREATE TABLE IF NOT EXISTS \`zabbix\`.\`manage_partitions\` (
  \`tablename\` VARCHAR(64) NOT NULL COMMENT 'Table name',
  \`period\` VARCHAR(64) NOT NULL COMMENT 'Period - daily or monthly',
  \`keep_history\` INT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'For how many days or months to keep the partitions',
  \`last_updated\` DATETIME DEFAULT NULL COMMENT 'When a partition was added last time',
  \`comments\` VARCHAR(128) DEFAULT '1' COMMENT 'Comments',
  PRIMARY KEY (\`tablename\`)
) ENGINE=INNODB;"

echo "$manage_part" | $mysql zabbix && echo "create table manage_partitions OK"

part_hist="CREATE TABLE IF NOT EXISTS \`zabbix\`.\`manage_partitions_history\` (
  \`schema_name\` varchar(64) NOT NULL COMMENT 'Zabbix schema name',
  \`table_name\` varchar(64) NOT NULL COMMENT 'Zabbix table name',
  \`table_partition_name\` varchar(64) NOT NULL COMMENT 'Zabbix table partition name',
  \`partition_action\` varchar(64) NOT NULL COMMENT 'Zabbix table partition action',
  \`partition_action_date\` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When a partition was added or dropped'
) ENGINE=InnoDB;"

echo "$part_hist" | $mysql zabbix && echo "create table manage_partitions_history OK"

keep_count_part="INSERT INTO zabbix.manage_partitions (tablename, period, keep_history, last_updated, comments) VALUES ('history', 'day', $history_cnt, now(), '');
INSERT INTO zabbix.manage_partitions (tablename, period, keep_history, last_updated, comments) VALUES ('history_uint', 'day', $history_uint_cnt, now(), '');
INSERT INTO zabbix.manage_partitions (tablename, period, keep_history, last_updated, comments) VALUES ('history_str', 'day', $history_str_cnt, now(), '');
INSERT INTO zabbix.manage_partitions (tablename, period, keep_history, last_updated, comments) VALUES ('history_text', 'day', $history_text_cnt, now(), '');
INSERT INTO zabbix.manage_partitions (tablename, period, keep_history, last_updated, comments) VALUES ('history_log', 'day', $history_log_cnt, now(), '');
INSERT INTO zabbix.manage_partitions (tablename, period, keep_history, last_updated, comments) VALUES ('trends', 'day', $trends_cnt, now(), '');
INSERT INTO zabbix.manage_partitions (tablename, period, keep_history, last_updated, comments) VALUES ('trends_uint', 'day', $trends_uint_cnt, now(), '');"

echo "$keep_count_part" | $mysql zabbix && echo "insert into manage_partitions OK"

# Create procedure
echo "Create procedure..."

proc_create="DROP PROCEDURE IF EXISTS \`create_next_partitions\`;
DROP PROCEDURE IF EXISTS \`create_partition_by_day\`;
DROP PROCEDURE IF EXISTS \`create_partition_by_month\`;
DROP PROCEDURE IF EXISTS \`drop_partitions\`;
DROP PROCEDURE IF EXISTS \`drop_old_partition\`;
DROP EVENT IF EXISTS \`e_zbx_part_mgmt\`;"

echo "$proc_create" | $mysql zabbix && echo "drop procedure OK"

proc="DELIMITER \$$
CREATE PROCEDURE \`create_next_partitions\`(IN_SCHEMANAME VARCHAR(64))
BEGIN
    DECLARE TABLENAME_TMP VARCHAR(64);
    DECLARE PERIOD_TMP VARCHAR(12);
    DECLARE DONE INT DEFAULT 0;
    DECLARE get_prt_tables CURSOR FOR
        SELECT \`tablename\`, \`period\`
        FROM manage_partitions;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN get_prt_tables;
        loop_create_part: LOOP
            IF DONE THEN
                LEAVE loop_create_part;
            END IF;
            FETCH get_prt_tables INTO TABLENAME_TMP, PERIOD_TMP;
            CASE
                WHEN PERIOD_TMP = 'day' THEN
                    CALL \`create_partition_by_day\`(IN_SCHEMANAME, TABLENAME_TMP);
                WHEN PERIOD_TMP = 'month' THEN
                    CALL \`create_partition_by_month\`(IN_SCHEMANAME, TABLENAME_TMP);
                ELSE
                BEGIN
                    ITERATE loop_create_part;
                END;
            END CASE;
                UPDATE manage_partitions set last_updated = NOW() WHERE tablename = TABLENAME_TMP;
        END LOOP loop_create_part;
    CLOSE get_prt_tables;
END\$$
DELIMITER ;

DELIMITER \$$
CREATE PROCEDURE \`create_partition_by_day\`(IN_SCHEMANAME VARCHAR(64), IN_TABLENAME VARCHAR(64))
BEGIN
    DECLARE BEGINTIME TIMESTAMP;
    DECLARE ENDTIME INT UNSIGNED;
    DECLARE PART_ACTION VARCHAR(12);
    DECLARE PARTITIONNAME VARCHAR(16);
    DECLARE ROWS_CNT INT UNSIGNED;
    SET BEGINTIME = DATE(NOW()) + INTERVAL 1 DAY;
    SET ENDTIME = UNIX_TIMESTAMP(BEGINTIME + INTERVAL 1 DAY);
    SET PART_ACTION = 'ADD';
    SET PARTITIONNAME = DATE_FORMAT( BEGINTIME, 'p%Y_%m_%d' );
    SELECT COUNT(*) INTO ROWS_CNT
    FROM information_schema.partitions
    WHERE table_schema = IN_SCHEMANAME
        AND table_name = IN_TABLENAME
        AND partition_name = PARTITIONNAME;
    IF ROWS_CNT = 0 THEN
        SET @SQL = CONCAT('INSERT INTO \`manage_partitions_history\`(\`schema_name\`,\`table_name\`,\`table_partition_name\`,\`partition_action\`) VALUES (\"', IN_SCHEMANAME,'\",\"', IN_TABLENAME,'\",\"', PARTITIONNAME,'\",\"', PART_ACTION,'\");');
        PREPARE STMT FROM @SQL;
        EXECUTE STMT;
        DEALLOCATE PREPARE STMT;
        SET @SQL = CONCAT( 'ALTER TABLE \`', IN_SCHEMANAME, '\`.\`', IN_TABLENAME, '\`',' ADD PARTITION (PARTITION ', PARTITIONNAME, ' VALUES LESS THAN (', ENDTIME, '));' );
        PREPARE STMT FROM @SQL;
        EXECUTE STMT;
        DEALLOCATE PREPARE STMT;
        ELSE
            SELECT CONCAT(\"partition \`\", PARTITIONNAME, \"\` for table \`\",IN_SCHEMANAME, \".\", IN_TABLENAME, \"\` already exists\") AS result;
    END IF;
END\$$
DELIMITER ;

DELIMITER \$$
CREATE PROCEDURE \`create_partition_by_month\`(IN_SCHEMANAME VARCHAR(64), IN_TABLENAME VARCHAR(64))
BEGIN
    DECLARE BEGINTIME TIMESTAMP;
    DECLARE ENDTIME INT UNSIGNED;
    DECLARE PART_ACTION VARCHAR(12);
    DECLARE PARTITIONNAME VARCHAR(16);
    DECLARE ROWS_CNT INT UNSIGNED;
    SET BEGINTIME = DATE(NOW() - INTERVAL DAY(NOW()) DAY + INTERVAL 1 DAY + INTERVAL 1 MONTH);
    SET ENDTIME = UNIX_TIMESTAMP(BEGINTIME + INTERVAL 1 MONTH);
    SET PART_ACTION = 'ADD';
    SET PARTITIONNAME = DATE_FORMAT( BEGINTIME, 'p%Y_%m' );
    SELECT COUNT(*) INTO ROWS_CNT
    FROM information_schema.partitions
    WHERE table_schema = IN_SCHEMANAME
        AND table_name = IN_TABLENAME
        AND partition_name = PARTITIONNAME;
    IF ROWS_CNT = 0 THEN
        SET @SQL = CONCAT('INSERT INTO \`manage_partitions_history\`(\`schema_name\`,\`table_name\`,\`table_partition_name\`,\`partition_action\`) VALUES (\"', IN_SCHEMANAME,'\",\"', IN_TABLENAME,'\",\"', PARTITIONNAME,'\",\"', PART_ACTION,'\");');
        PREPARE STMT FROM @SQL;
        EXECUTE STMT;
        DEALLOCATE PREPARE STMT;
        SET @SQL = CONCAT( 'ALTER TABLE \`', IN_SCHEMANAME, '\`.\`', IN_TABLENAME, '\`',' ADD PARTITION (PARTITION ', PARTITIONNAME, ' VALUES LESS THAN (', ENDTIME, '));' );
        PREPARE STMT FROM @SQL;
        EXECUTE STMT;
        DEALLOCATE PREPARE STMT;
        ELSE
            SELECT CONCAT(\"partition \`\", PARTITIONNAME, \"\` for table \`\",IN_SCHEMANAME, \".\", IN_TABLENAME, \"\` already exists\") AS result;
    END IF;
END\$$
DELIMITER ;

DELIMITER \$$
CREATE PROCEDURE \`drop_partitions\`(IN_SCHEMANAME VARCHAR(64))
BEGIN
    DECLARE TABLENAME_TMP VARCHAR(64);
    DECLARE PARTITIONNAME_TMP VARCHAR(64);
    DECLARE VALUES_LESS_TMP INT;
    DECLARE PERIOD_TMP VARCHAR(12);
    DECLARE KEEP_HISTORY_TMP INT;
    DECLARE KEEP_HISTORY_BEFORE INT;
    DECLARE DONE INT DEFAULT 0;
    DECLARE get_partitions CURSOR FOR
        SELECT p.\`table_name\`, p.\`partition_name\`, LTRIM(RTRIM(p.\`partition_description\`)), mp.\`period\`, mp.\`keep_history\`
        FROM information_schema.partitions p
        JOIN manage_partitions mp ON mp.tablename = p.table_name
        WHERE p.table_schema = IN_SCHEMANAME
        ORDER BY p.table_name, p.subpartition_ordinal_position;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN get_partitions;
        loop_check_prt: LOOP
            IF DONE THEN
                LEAVE loop_check_prt;
            END IF;
            FETCH get_partitions INTO TABLENAME_TMP, PARTITIONNAME_TMP, VALUES_LESS_TMP, PERIOD_TMP, KEEP_HISTORY_TMP;
            CASE
                WHEN PERIOD_TMP = 'day' THEN
                    SET KEEP_HISTORY_BEFORE = UNIX_TIMESTAMP(DATE(NOW() - INTERVAL KEEP_HISTORY_TMP DAY));
                WHEN PERIOD_TMP = 'month' THEN
                    SET KEEP_HISTORY_BEFORE = UNIX_TIMESTAMP(DATE(NOW() - INTERVAL KEEP_HISTORY_TMP MONTH - INTERVAL DAY(NOW())-1 DAY));
                ELSE
                    BEGIN
                        ITERATE loop_check_prt;
                    END;
            END CASE;
            IF KEEP_HISTORY_BEFORE >= VALUES_LESS_TMP THEN
                CALL drop_old_partition(IN_SCHEMANAME, TABLENAME_TMP, PARTITIONNAME_TMP);
            END IF;
        END LOOP loop_check_prt;
    CLOSE get_partitions;
END\$$
DELIMITER ;

DELIMITER \$$
CREATE PROCEDURE \`drop_old_partition\`(IN_SCHEMANAME VARCHAR(64), IN_TABLENAME VARCHAR(64), IN_PARTITIONNAME VARCHAR(64))
BEGIN
    DECLARE PART_ACTION VARCHAR(12);
    DECLARE PART_ACTION_DATE INT;
    DECLARE ROWS_CNT INT UNSIGNED;
        SELECT COUNT(*) INTO ROWS_CNT
        FROM information_schema.partitions
        WHERE table_schema = IN_SCHEMANAME
            AND table_name = IN_TABLENAME
            AND partition_name = IN_PARTITIONNAME;
    SET PART_ACTION = 'DROP';
    IF ROWS_CNT = 1 THEN
        SET @SQL = CONCAT('INSERT INTO \`manage_partitions_history\`(\`schema_name\`,\`table_name\`,\`table_partition_name\`,\`partition_action\`) VALUES (\"', IN_SCHEMANAME,'\",\"', IN_TABLENAME,'\",\"', IN_PARTITIONNAME,'\",\"', PART_ACTION,'\");');
        PREPARE STMT FROM @SQL;
        EXECUTE STMT;
        DEALLOCATE PREPARE STMT;
        SET @SQL = CONCAT( 'ALTER TABLE \`', IN_SCHEMANAME, '\`.\`', IN_TABLENAME, '\`',' DROP PARTITION ', IN_PARTITIONNAME, ';' );
        PREPARE STMT FROM @SQL;
        EXECUTE STMT;
        DEALLOCATE PREPARE STMT;
        ELSE
            SELECT CONCAT(\"partition \`\", IN_PARTITIONNAME, \"\` for table \`\", IN_SCHEMANAME, \".\", IN_TABLENAME, \"\` does not exist\") AS result;
    END IF;
END\$$
DELIMITER ;

DELIMITER \$$
CREATE EVENT \`e_zbx_part_mgmt\`
	ON SCHEDULE EVERY 1 DAY STARTS '"$evnt_start"'
	ON COMPLETION PRESERVE
	ENABLE
	COMMENT 'Creating and dropping partitions'
	DO BEGIN
	CALL zabbix.drop_partitions('zabbix');
	CALL zabbix.create_next_partitions('zabbix');
	END\$$
DELIMITER ;"

echo "$proc" | $mysql zabbix && echo "successfull, partitioning the end" || echo "Error"
