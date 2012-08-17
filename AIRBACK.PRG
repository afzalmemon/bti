PARAMETERS backupfile

SET TALK OFF
SET SAFETY OFF

IF !DIRECTORY("c:\backups")
   MD c:\backups
ENDIF

backupfile = 'c:\backups\' + ALLTRIM(backupfile) + '.sql'
backuproot = 'c:\backups\' + 'backroot' + '.sql'

IF FILE('&backupfile')
   DELETE FILE &backupfile
ENDIF

yeardbf = 'bti_1_1112' 
back = " mysqldump -uroot -praj " + yeardbf + " > " + backupfile  && Export
RUN mysqldump -uroot -praj &yeardbf > &backupfile

rootdbf = '&zrootdbf'
back2   = " mysqldump -uroot -praj " + rootdbf + " > " +  backuproot  && Export
RUN &back2 

mfname = "bti1011"
mroot  = 'bti_root'

RUN pkzip &mfname &backupfile
RUN pkzip &mroot &backuproot

******************************************************
*             For Import                             *
******************************************************
*mysql -u username -ppassword database_name < dump.sql
******************************************************

=errmess('Backup Successfully')
QUIT

