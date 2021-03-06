     -----------------------------------------------------------------
     Welcome to Togai InfraLogic's Fuzzy Mail Server and Mailing List!
     -----------------------------------------------------------------

TIL maintains this facility as a public service to users and potential users
of fuzzy logic and fuzzy expert systems.  Please address comments, suggestions,
bug reports, and files you would like to be added to the mail server to
info@til.com.

You make a request to the fuzzy server by sending an email message to
fuzzy-server@til.com.  Each line of your request message represents one
command to the fuzzy server.  If you like, you can put a command in the
Subject: header of your request - the Subject: header is considered to be
part of the message body.  Please don't put the same command in both the
Subject and the message body.  *Both* copies of the command will be executed,
doubling our transmission costs (and yours).

The following commands are currently implemented:

btoa				All files sent as a result of this request will
				be btoa'd.  This is an alternative to uuencode.
				See the note at the end of this file about
                                encoded files.  Btoa increases the size of the
                                file by about 25%.

compress			All files sent as a result of this request will
				be compressed and uuencoded (or btoa'd).  This
				option is automatically set when the file to be
				sent is binary.  See the notes at the end of
                                this file about encoded and compressed files.

end				Causes any lines in your request following the
				end command to be ignored.  This command is
				mainly useful if your .sig *doesn't* start with
				a "--" in column one, and contains things that
				look like mail server commands.

help				Sends this text.  It is identical to the
				command "send help".

limit <bytes>			Causes the server to split replies to your
				requests up into multiple email messages, if
				necessary, so that no message sent to you is
				larger than <bytes> bytes in size.  The default
				limit is 60000.  This limit does not include
				the email headers, so if your system allows
				messages no larger than 100,000 bytes, we
				suggest that you use LIMIT 98000 to allow for
				mail headers.  To turn off splitting, just
				specify a very larger number for the limit.

list				Sends a list of the available files.  It is
				identical to the command "send index".

path <mailing address>		Causes the reply to your request to be sent to
				the specified mailing address, instead of the
				one extracted from the "From:" header in your
				request.  You only need to use this command if
				you send requests to fuzzy-server@til.com and
				get no response, even after a couple of days.
                                Note: due to difficulty of telling a real
                                request from a mail bounce, the fuzzy mail-
                                server cannot accept requests from users named
                                Mailer-Daemon or Postmaster (upper or lower
                                case).

quit				Causes any lines in your request following the
				quit command to be ignored.  This is a synonym
				for the end command.

send <filename>			Sends you the specified file by return email.
				If the file is binary or too large, it will be
				compressed and uuencoded (or btoa'd) before
				being mailed to you.  You can also manually
				request compression with the compress command,
				and either uuencode or btoa encoding by the
				uuencode and btoa commands, respectively.  See
                                the notes at the end of this file about encoded
                                and compressed files.

split <bytes>			Has exactly the same effect as the limit
				command.

subscribe			Subscribe to TIL's fuzzy logic mailing list.
				This mailing list provides you with press
				releases and preliminary product information.

unsubscribe			Unsubscribe from the fuzzy logic mailing list.
				Note: If you subscribe and unsubscribe in the
				same day, in either order, the unsubscribe will
				take precedence.

uuencode			All files sent as a result of this request will
				be uuencoded.  This option is automatically set
				when the file to be sent is binary, or when
				the file is compressed.  See the note at the
                                end of this file about encoded files.  Uuencode
                                increases the size of the file by about 33%.

--------------------------
A note about encoded files
--------------------------

When you receive a file that has been uuencoded or btoa'd, you need to remove
the mail header lines from the file before you use uudecode or atob to decode
it.  If you see an error message like "Short File" from uudecode, you've
probably just forgotten to do this.  Just use a text editor to delete all lines
at the start of the file up to and including the line that says "cut here".
Warning: DO NOT SAVE THE MAIL MESSAGE TO A FILE WITH THE SAME NAME AS THE
OUTPUT FILE!  In other words, if you receive primer.ps.Z in the mail, save it
as something *other than* primer.ps.Z.  If you save it to primer.ps.Z,
uudecode will *create* primer.ps.Z, thus truncating and destroying the mail
message before it is done being decoded.  This is another way to cause a
"Short File" error message from uudecode.

-----------------------------
A note about compressed files
-----------------------------

When you receive a file that has a ".Z" at the end of its name, that file has
been compressed to save space and transmission time and costs.  To make the
file useful, you need to uncompress it.  To uncompress a file named x.Z, just
enter the command "uncompress x".  Note that you do not have to specify the
".Z" part of the filename.  The compressed version of the file will be replaced
by an uncompressed version.
