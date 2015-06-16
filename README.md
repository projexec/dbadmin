# ProjExec DB AdminTools
This project hosts a set of database administration tools for ProjExec.

## DB2
Contains some DB2 related scripts for reorganizing the tables, indexes and run stats

**Instructions**

This script generates Reog Tables / Reorg Indexes / RunStats SQL Commands for ProjExec Tables/Indexes and executes the generated script files.

The ProjExec Database name should be replaced in this file on the line (`set peinput="PROJEXEC"`) for example if your ProjExec Database name is PEDB, the line should be set to (`set peinput="PEDB"`). The 
script can be scheduled to run weekly from the OS. 

To schedule it, the db2 Administration command window should be called with the batch file location
example: (`db2cwadmin E:\ProjExecScript\ReorgRunstats.bat`). It is mandatory to use the db2cwadmin command or run the batch from the DB2 Command Window Administrator. The folder where the scripts are placed need to be also set in this file in order for the logs to be saved in the same folder to set the script folder change the line (`set pefolder="E:\ProjExecScript\"`) 


