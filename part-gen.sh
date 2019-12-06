#!/bin/bash
mysql=`/usr/bin/which mysql`
cat=`/usr/bin/which cat`




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
