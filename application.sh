#!/bin/bash

DBHOST=$1
ping -W 1 $DBHOST -c 1 1>/dev/null || exit 0


# OFFSET TIME
(( n = RANDOM % 30 ))
OFFSET=$(printf '%s.%s\n' $(( n / 10 )) $(( n % 10 )))
sleep $OFFSET


TMPFILE=/tmp/$(cat /proc/sys/kernel/random/uuid)
mkfifo $TMPFILE

sleep 999999999 > $TMPFILE &
PID=$!

mariadb -B -u app -p"ff02ow2023ff02" -h $DBHOST < $TMPFILE &

# all set up, now just push the SQL queries to the pipe, exemple:
# echo "select app_id, author_id, current_price, pay_author, app_name from dranapp.dd_apps where app_name='Housden Paradox';" > /tmp/sqlpipe
for i in {1..18}; do
    sleep 3
    SQLFILE=$(find /root/app/SQL/ -type f -name "*.sql" | shuf -n 1)
    cat $SQLFILE > $TMPFILE
    # echo "select now();" > $TMPFILE
    sleep 7
done
echo "exit" > $TMPFILE
# done! terminate pipe
kill -s SIGINT $PID
rm $TMPFILE
