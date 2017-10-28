#!/bin/bash

DBUSER=""      # Database User Name
DBPASS=""      # Database Password
DBNAME=""      # Database Name
DBHOST=""      # Database Server IP
TABLENAME=""      # Table Name
FieldName=""      # Auto increased field name
lastID=`mysql -u"$DBUSER" -p"$DBPASS" $DBNAME -h$DBHOST -N -e "SELECT MAX($FieldName) FROM $TABLENAME"`
columnId=1
while [[ $columnId -le $lastID ]]
do
dbID=`mysql -u"$DBUSER" -p"$DBPASS" $DBNAME -h$DBHOST -N -e "SELECT $FieldName FROM $TABLENAME WHERE $FieldName=$columnId"`
if [[ "$dbID" == "$columnId" ]]; then
continue
else
echo -e "$columnId not found\n"
echo -e "$columnId\n" >> notFoundIds.list
fi
((columnId = columnId+1))
done
