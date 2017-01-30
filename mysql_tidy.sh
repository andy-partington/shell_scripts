#!/bin/bash
# 
# A little shell script to tidy up mysql backups
#

LOGFILE=/some/log/mysql-db-tidy.out

echo "Starting MySQL Backups tidy up `date`" > $LOGFILE
echo >> $LOGFILE
echo "Total Files : " >> $LOGFILE
find /path/to/mysql/files -type f | wc -l >> $LOGFILE
echo >> $LOGFILE
echo "Files to delete : " >> $LOGFILE
find /path/to/mysql/files -mtime +14 -type f | wc -l >> $LOGFILE
echo >> $LOGFILE
echo "Deleting files older than 14 days...." >> $LOGFILE
find /path/to/mysql/files -mtime +14 -type f -print -delete >> $LOGFILE
echo "Total Files after tidy `date` : " >> $LOGFILE
find /path/to/mysql/files -type f | wc -l >> $LOGFILE
echo "Completed MySQL Backups tidy up `date`" >> $LOGFILE 