
REM Variables of the form [CAPITALLETTERS] are template variables which will be replaced by the GUI
REM when generating the scripts.

REM -- All this shit is necessary to get a consistent, working datestamp on Windows regardless of locale. --
REM Credit to Eric Ouellet from https://serverfault.com/questions/16706/current-date-in-the-file-name
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
REM -- End datestamp fuckery. What a crock of shit -- 

title CYS Backup In Progress [BACKUPTITLE] -- %fullstamp%

set logfile=[LOGFILE]
if [%logfile%] == [] (
	if not exist "%USERPROFILE%\Documents\CYS3" mkdir "%USERPROFILE%\Documents\CYS3"
	set logfile=%USERPROFILE%\Documents\CYS3\logs\cys3-sync-%datestamp%.log
)
set s3cmd=[S3CMD]
if [%s3cmd%] == [] (
	set s3cmd=s3cmd-freeze\dist\s3cmd.exe
)

for %%x in ( [SOURCEDIRS] ) do (
             time /T >> %logfile% 2>&1
             %s3cmd% -v sync %%x s3://[TARGETBUCKET] >> %logfile% 2>&1
             echo Folder %%x Complete >> %logfile% 2>&1
           )
echo Backup Complete >> %logfile% 2>&1
time /T >> %logfile% 2>&1
