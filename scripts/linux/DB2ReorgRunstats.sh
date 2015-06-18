#!/bin/sh
peinput=PE_LC

pefolder=/home/db2inst1/ProjExecScript/

db2folder=/opt/ibm/db2/V9.7/bin/

echo "Connecting to database $peinput"
"$db2folder"db2 connect to $peinput

echo ------------------------------------------------
echo Creating Reorg Tables script...
"$db2folder"db2 -x "select 'REORG TABLE ' ||rtrim (tabschema)||'.'|| rtrim (tabname) || ';' from syscat.tables where tabschema not like 'SYS%' and type='T' " > reorgtables.out

echo ------------------------------------------------
echo Creating Reorg Indexes script...
"$db2folder"db2 -x "select 'REORG INDEXES ALL FOR TABLE ' ||rtrim (tabschema)||'.'|| rtrim (tabname) || ';' from syscat.tables where tabschema not like 'SYS%' and type='T' " > reorgindexes.out

echo ------------------------------------------------
echo Creating RunStats script...
"$db2folder"db2 -x "select 'RUNSTATS ON TABLE ' ||rtrim (tabschema)||'.'|| rtrim (tabname) || ' WITH DISTRIBUTION AND DETAILED INDEXES ALL;' from syscat.tables where tabschema not like 'SYS%' and type='T' " > runstats.out

echo ------------------------------------------------
echo Running Tables Reorg...
"$db2folder"db2 -tvf reorgtables.out >"$pefolder"reorgtables.log

echo ------------------------------------------------
echo Running Indexes Reorg...
"$db2folder"db2 -tvf reorgindexes.out >"$pefolder"reorgindexes.log

echo ------------------------------------------------
echo Running RunStats...
"$db2folder"db2 -tvf runstats.out >"$pefolder"runstats.log

# END OF SCRIPT

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Script created by Rachid Zock - Trilog Group Inc. 2015 - (21-04-2015) 
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

