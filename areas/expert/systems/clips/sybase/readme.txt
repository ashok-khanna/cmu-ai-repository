We have developed some DB-Library functions which provide a Sybase
interface for CLIPS, and are making it available for general distribution.

Our CLIPS programs need to do the following:

        o Open/close a connection to a SQL server
        o Execute commands/queries on the SQL server
        o Assert data returned from the server into CLIPS
        o Trap server errors and display messages to the user

Our strategy was to keep the interface design as simple as possible.  While
it provides a great deal of flexibility, it does leave the responsibility
of constructing the SQL code entirely up to the calling (CLIPS) program.
Also, it is limited to one open SQL server connection at a time.  However,
it provides full insert/delete/update access to the Sybase database and
allows the results of SQL queries to be asserted into the CLIPS fact-base.

The interface consists of a small number of application-independent "C"
functions, which are built as extensions to CLIPS.  When they encounter an
error, error and message handler functions for the DB-Library routines
display helpful messages describing why the error occurred.  The function
value returned to the caller allows the CLIPS application program to test
for (and handle) the errors.

We have also implemented a utility which creates deftemplate declarations
from information stored in the Sybase system tables.

VERSION INFORMATION:
    CLIPS V6.01
    Sybase SQL Server 4.9.1
    DB-Library 4.6
    SunOS Release 4.1.3

The source code and documentation are available via anonymous ftp on
wuarchive.wustl.edu.  The file names are README and clips2sybase.tar.uu,
and can be found in the /packages/clips2sybase/v6.01 directory.

There is also a version that is compatible with CLIPS V5.1, and it can be
found in the /packages/clips2sybase/v5.1 directory.

Sherry Steib
sherry@informatics.wustl.edu
Washington University School of Medicine
Division of Medical Informatics
St. Louis, MO