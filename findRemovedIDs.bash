#!/bin/bash
DBUSER=""
DBPASS=""
DBNAME=""
DBHOST=""
TABLENAME=""
lastID=`mysql -u"$DBUSER" -p"$DBPASS" $DBNAME -h$DBHOST -e "SELECT MAX(id) FROM $TABLENAME"`
columnId=1
while [[ $columnId -le $lastID ]]
do
dbID=`mysql -u"$DBUSER" -p"$DBPASS" $DBNAME -h$DBHOST -e "SELECT id FROM $TABLENAME WHERE id=$columnId"`
if [[ "$dbID" == "$columnId" ]]; then
continue
else
echo -e "$columnId not found\n"
echo -e "$columnId\n" >> notFoundIds.list
fi
((columnId = columnId+1))
done
