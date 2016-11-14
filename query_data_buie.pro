;
;
;
; mysql -u root -p
; USE dr7
;
;
;


;--- Read halos from file
halo = mrdfits('Data/100Mpc_H_FoF_CAT_simple_100.fit',1)

;--- Create Halo ID's OJO: possible error here if the ID changes...
ID = lindgen(n_elements(halo.x))



;--- Connect to database
GET_LUN, U
openmysql, U, '100Mpc_Halos'

;--- Get columns from table
;my_query = 'SELECT x,y,z,mass FROM Halo_Prop_Bas WHERE x < 10000 AND y < 10000;'
;mysqlquery, U, my_query, x,y,z,mass, format='(f,f,f,f)'

;my_query = 'SELECT Sx,Sy,Sz,I1,I2,I3 FROM Halo_Prop_Ext LIMIT 100;'
;mysqlquery, U, my_query, Sx,Sy,Sz,I1,I2,I3, format='(f,f,f,f,f,f)'

;my_query = 'SELECT Halo_Prop_Bas.x, Halo_Prop_Ext.Sy FROM Halo_Prop_Bas, Halo_Prop_Ext WHERE Halo_Prop_Bas.x < 100 LIMIT 100;'
;mysqlquery, U, my_query, Sx,Sy,Sz,I1,I2,I3, format='(f,f,f,f,f,f)'


my_query = 'SELECT Halo_Prop.Id, Halo_Prop.x, Halo_Prop.y, Halo_Prop.z, Halo_Prop.mass, Halo_Prop.radius, Halo_Prop.Gau3 ' + $
           'FROM  Halo_Prop,Halo_SpineWeb ' + $
           'WHERE Halo_SpineWeb.Morph_dim_L012 = 1 ' + $
           'AND   Halo_Prop.Id = Halo_SpineWeb.Id;'

mysqlquery, U, my_query, x,y,z, mass, radius, den3, format='(f,f,f,f,f,f)'

;mysqlcmd, U,my_query,result,nlines,/DEBUG


;--- Close database
close,  U
free_lun, U


end

