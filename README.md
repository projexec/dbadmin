# ProjExec DB AdminTools
This project hosts a set of database administration tools for ProjExec.

## DB2
Contains DB2 related script for reorganizing the tables, indexes and running statistics. The script is available in two versions: Windows and Linux and for each a corresponding folder and script file.
The Reorg/Runstats script needs to be launched after large number of data changes such as Big Project imports or ProjExec upgrades.

**Instructions**

This script generates Reog Tables / Reorg Indexes / RunStats SQL Commands for ProjExec Tables/Indexes and executes the generated script files.

**for DB2 on Windows**

The ProjExec Database name should be replaced in the script file on the line (`set peinput="PROJEXEC"`) for example if your ProjExec Database name is PEDB, the line should be set to (`set peinput="PEDB"`). Please note that it is best to schedule the script to run on a weekly basis from the OS using your preferred scheduling software. 


To schedule it, the db2 Administration command window should be called with the batch file location
example: (`db2cwadmin E:\ProjExecScript\ReorgRunstats.bat`). It is mandatory to use the db2cwadmin command or run the batch from the DB2 Command Window Administrator. The folder where the scripts are placed need to be also set in the script file in order for the logs to be saved in the same folder to set the script folder change the line (`set pefolder="E:\ProjExecScript\"`) 

**for DB2 on Linux** 

The ProjExec Database name should be replaced in the script file on the line (`peinput=PROJEXEC`) for example if your ProjExec Database name is PEDB, the line should be set to (`peinput=PEDB`). The path to the DB2 installation should also be specified by changing the line ('db2folder=/opt/ibm/db2/V9.7/bin/') to reflect the correct path to your DB2 installation binary files. Please note that it is best to schedule the script to run on a weekly basis from the OS using your preferred scheduling software. 

To schedule it, call the DB2ReorgRunstats.sh script file from the folder where you placed it example: (`/home/db2inst1/ProjExecScript/DB2ReorgRunstats.sh`). 

The folder where the scripts are placed also need to be set in the script file in order for the logs to be saved in the same folder. to set the script folder change the line (`pefolder=/home/db2inst1/ProjExecScript/`) 


