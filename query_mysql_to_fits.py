#! /usr/bin/env python
#
#  PROGRAM query_mysql_to_fits
#
#    Submit a query to a MySQL database and return a fits file
#
#  EXAMPLE:
#    python query_mysql_to_fits.py "SELECT Halo_Prop.Id, Halo_Prop.x FROM Halo_Prop WHERE Halo_Prop.z < 5000;" "out.fits"
#
#  COMMENTS:
#
#
#  CREATED BY:
#    Miguel Aragon-Calvo, JHU. Dec/2009
#    Thanks to Tamas Budavary for tip with zip() function.
#
#


import MySQLdb
import pyfits
import os
import sys

#--------------------------------
#--- Get command line arguments
#--------------------------------
my_query = sys.argv[1]
my_db    = sys.argv[2]
file_out = sys.argv[3]

#--- Connect to database and get cursor
conn   = MySQLdb.connect (host = "localhost",user = "idl",passwd = "idl_pass",db = my_db)
cursor = conn.cursor ()


#--- Execute MySQL query
cursor.execute(my_query) 

#--- Get header and rows of data
header = cursor.description
row    = cursor.fetchall ()

#--- Close connection to MySQL database
cursor.close ()
conn.close ()


#--------------------------------
#--- Create lists of colum names
#--------------------------------
head_list = []
for i, head_i in enumerate(header):
    head_list.append(head_i[0])

#--------------------------------
#--- Fill list of lists from columns in tuple
#--------------------------------
ccc = list()
for i, column_i in enumerate(zip(*row)): 
    
    #--- Get the datatype. Not all types are  right!!!
    if type(column_i[0]).__name__=='int':    #--- 16 bit integer
        type_col = 'I'
    if type(column_i[0]).__name__=='long':   #--- 32 bit integer
        type_col = 'J'
    if type(column_i[0]).__name__=='long64': #--- 64 bit integer
        type_col = 'K'
    if type(column_i[0]).__name__=='float':  #--- Single precision float
        type_col = 'E'
    if type(column_i[0]).__name__=='double': #--- Double precision float
        type_col = 'D'
    if type(column_i[0]).__name__=='byte':   #--- Unsigned byte
        type_col = 'B'
    if type(column_i[0]).__name__=='char':   #--- Character (also include number)
        type_col = 'A'

    ccc.append(pyfits.Column(name=head_list[i],format=type_col, array=list(column_i)))


#--- Create a column-definitions object for all columns in a table
column_definition = pyfits.ColDefs(ccc)

#--- Create a table HDU object
tbhdu=pyfits.new_table(column_definition)

#--- Write the table HDU to a FITS file
fout = pyfits.HDUList(pyfits.PrimaryHDU())
fout.append(tbhdu)
fout.writeto(file_out)


