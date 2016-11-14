FUNCTION query_mysql_python, query, database, VERBOSE=verbose, SAVE=save
;
; FUNCTION: QUERY_MYSQL_PYTHON
;
; PURPOSE:
;   Query data from a MuSQL database using python and fits file as bridge
;   Not elegant but effective if you don't query too often.
;   This approach is faster than Mark Buie's method for large
;   arrays. It also has the advantage of returning the correct data
;   type.
;
; DESCRIPTION:
;   Simple wrapper. Call Python and then remove temporary file. IDL
;   calls a python program and gives it a SQL string to process. The
;   result is parsed and stored as a temporary FITS file by python.
;   IDL then reads the temporary file and removes the file afterwards.
;
; INPUT:
;   my_query  -> String containing the MySQL query
;   database  -> String with the database name
;   user      -> User name (NOT IMPLEMENTED)
;   pass      -> Password  (NOT IMPLEMENTED)
;
; OPTIONAL PARAMETERS:
;   VERBOSE   -> Print some info
;   SAVE      -> String with the name of the .fits file containing the
;                result of the query
;
; USAGE:
;   arr = query_mysql_python('"SELECT Halo_Prop.Id, Halo_Prop.x, $
;   Halo_Prop.y FROM Halo_Prop WHERE Halo_Prop.z < 5000;"', '100Mpc_Halos')
;
;
; CREATED:
;   Miguel A. Aragon-Calvo 
;   Dec/2009
;
;


;--- Output fits file
IF N_ELEMENTS(save) EQ 0 THEN BEGIN
   file_out = 'temp.fits'
ENDIF ELSE BEGIN
   file_out = save
ENDELSE

;--- This is the command to send to shell
comando = 'python query_mysql_to_fits.py '+ query + ' ' + database + ' ' + file_out

;--- Print info
IF KEYWORD_SET(verbose) THEN BEGIN
   print, comando
ENDIF

;--- Do MySQL query via Python
SPAWN, comando

;--- Read fits temporary file
arr = mrdfits(file_out, 1)

;--- Clean up (remove temporary file)
IF N_ELEMENTS(save) EQ 0 THEN BEGIN
   SPAWN, 'rm -rf temp.fits'
ENDIF

return, arr

end


