#!/bin/bash
DBUSER=""      # Database User Name
DBPASS=""      # Database Password
DBNAME=""      # Database Name
DBHOST=""      # Database Server IP
TABLENAME=""      # Table Name
FieldName=""      # Auto increased field name
ReportFile=""

>$ReportFile  #Clear old Report
### get maximum number from database
lastID=`mysql -u"$DBUSER" -p"$DBPASS" $DBNAME -h$DBHOST -N -e "SELECT MAX($FieldName) FROM $TABLENAME"`
### set columnId 0, this variable is use for loop
columnId=0

### Loop in 0 to maximum id from database
while [[ $columnId -le $lastID ]]
do
### Increasing columnId, because id in mysql start from 1, and this variable used for loop condition
((columnId = columnId+1))
### get field id from database where this id is equal to loop number
dbID=`mysql -u"$DBUSER" -p"$DBPASS" $DBNAME -h$DBHOST -N -e "SELECT $FieldName FROM $TABLENAME WHERE $FieldName=$columnId"`
### check if loop number is equal to database id, that is exists; then continue to loop
if [[ "$dbID" == "$columnId" ]]; then
continue
### else this loop id is not exists in database so show this id and store it in report file
else
echo -e "$columnId not found\n"
### Append id to report File
echo -e "$columnId" >> $ReportFile
fi
done
