@Echo off
ECHO -----------------------------------------------------------------------------------------------
ECHO This script generates Reog Tables / Reorg Indexes / RunStats SQL Commands
ECHO for ProjExec Tables/Indexes and executes the generated script files.
ECHO The ProjExec Database name should be replaced in this file on the line (set peinput="PROJEXEC")
ECHO for example if your ProjExec Database name is PEDB, the line should 
ECHO be set to (set peinput="PEDB"). The script can be scheduled to run weekly from the OS.
ECHO To schedule it, the db2 Administration command window should be called with the batch file location
ECHO example: (db2cwadmin E:\ProjExecScript\ReorgRunstats.bat)
ECHO It is mandatory to use the db2cwadmin command or run the batch
ECHO from the DB2 Command Window Administrator.
ECHO The folder where the scripts are placed need to be also set 
ECHO in this file in order for the logs to be saved in the same folder
ECHO to set the script folder change the line (set pefolder="E:\ProjExecScript\") 
ECHO -------------------------------------------------------------------------------------------------	

set peinput="PROJEXEC"
set pefolder="E:\ProjExecScript\"

echo Connecting to database %peinput% ...
db2 connect to %peinput%

echo ------------------------------------------ 
echo Creating Reorg Tables Script...
db2 -x "select 'REORG TABLE ' ||rtrim (tabschema)|| '.' || rtrim (tabname) || ';' from syscat.tables  where tabschema not like 'SYS%' and type = 'T'" > reorgtables.out

echo ------------------------------------------ 
echo Creating Reorg Indexes Script...
db2 -x "select 'REORG INDEXES ALL FOR TABLE ' ||rtrim (tabschema)|| '.' || rtrim (tabname) || ';' from  syscat.tables where tabschema not like 'SYS%' and type='T' " > reorgindexes.out

echo ------------------------------------------ 
echo Creating RunStats Script...
db2 -x "select 'RUNSTATS ON TABLE ' ||rtrim (tabschema)|| '.' || rtrim (tabname) || ' WITH DISTRIBUTION  AND DETAILED INDEXES ALL;' from syscat.tables where tabschema not like 'SYS%' and type = 'T'" >  runstats.out


echo ------------------------------------------ 
echo Running Tables Reorg...
db2 -tvf reorgtables.out >%pefolder%Reorgtables.log


echo ------------------------------------------ 
echo Running Indexes Reorg...
db2 -tvf reorgindexes.out>%pefolder%Reorgindexes.log

echo ------------------------------------------ 
echo Running Stats...
db2 -tvf runstats.out >%pefolder%Runstats.log

:: @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
:: Script created by Rachid Zock - Trilog Group Inc. 2015 - (13-Mar-2015) 
:: @@@@@@@@@@@@@@@@@@@@@@@@@ END OF SCRIPT @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@