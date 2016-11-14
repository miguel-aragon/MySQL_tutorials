;
;
;
; mysql -u root -p
; USE dr7
;
;
;

;--- Choose between FoF or Subhaloes
Halo_type = 'FoF'

;--- Snapshot number
SnapNumInt = 100L
SnapNum    = format_number(SnapNumInt,3)

;--- Read all halo data
restore, 'Data/100Mpc_H_'+Halo_type+'_CAT_simple_'+SnapNum+'_COSMIC_WEB.IDL'


;--- Create Halo ID's OJO: possible error here if the ID changes...
ID = lindgen(n_elements(halo.x))


;--- Connect to database
GET_LUN, U
openmysql, U, '100Mpc_Halos'

;--- Compute the magnitude of the angular momentum. Divide by a large
;    number
;=== ALL
LMod = sqrt( double(halo.Lx)^2 + double(halo.Ly)^2 + double(halo.Lz)^2 )
halo.Lx = float( double(halo.Lx) / LMod )
halo.Ly = float( double(halo.Ly) / LMod )
halo.Lz = float( double(halo.Lz) / LMod )
;=== HALF MASS
Lmod_half = sqrt( double(halo_half.Lx)^2 + double(halo_half.Ly)^2 + double(halo_half.Lz)^2 )
halo_half.Lx = float( double(halo_half.Lx) / LMod_half )
halo_half.Ly = float( double(halo_half.Ly) / LMod_half )
halo_half.Lz = float( double(halo_half.Lz) / LMod_half )


;==================================
;--- Insert values into Halo_Prop
;==================================
FOR i=0L, N_ELEMENTS(halo.x)-1 DO BEGIN
   my_query = "INSERT INTO Halo_Prop (Id, x, y, z, vx,vy,vz, mass, radius, n_child, " + $
              "LMod,Lx,Ly,Lz, I1,I2,I3, I1x,I1y,I1z, I2x,I2y,I2z, I3x,I3y,I3z, " + $ 
              "radius_half, " + $
              "LMod_half, Lx_half,Ly_half,Lz_half, " + $
              "I1_half,I2_half,I3_half, I1x_half,I1y_half,I1z_half, I2x_half,I2y_half,I2z_half, I3x_half,I3y_half,I3z_half) " + $
              "VALUES(" + $
              "'" + string(long(      Id[i]), FORMAT='(I12)')           +"'," + $
              "'" + string(double(halo.x[i]), FORMAT='(D0)')            +"'," + $ ;--- Positions
              "'" + string(double(halo.y[i]), FORMAT='(D0)')            +"'," + $
              "'" + string(double(halo.z[i]), FORMAT='(D0)')            +"'," + $
              "'" + string(double(halo.vx[i]), FORMAT='(D0)')           +"'," + $ ;--- Velocities
              "'" + string(double(halo.vy[i]), FORMAT='(D0)')           +"'," + $
              "'" + string(double(halo.vz[i]), FORMAT='(D0)')           +"'," + $
              "'" + string(double(halo.mass[i]),   FORMAT='(D0)')       +"'," + $ ;--- Mass
              "'" + string(double(halo.radius[i]), FORMAT='(D0)')       +"'," + $ ;--- Maximum radius
              "'" + string(long(halo.multi[i]),     FORMAT='(I7)')      +"'," + $ ;--- Number of children subhaloes
              "'" + string(double(LMod[i]), FORMAT='(D0)')              +"'," + $ ;--- Angular momentum magnitude
              "'" + string(double(halo.Lx[i]), FORMAT='(D0)')           +"'," + $ ;--- Angular momentum components
              "'" + string(double(halo.Ly[i]), FORMAT='(D0)')           +"'," + $
              "'" + string(double(halo.Lz[i]), FORMAT='(D0)')           +"'," + $
              "'" + string(double(halo.I1[i]), FORMAT='(D0)')           +"'," + $ ;--- Inertia tensor
              "'" + string(double(halo.I2[i]), FORMAT='(D0)')           +"'," + $
              "'" + string(double(halo.I3[i]), FORMAT='(D0)')           +"'," + $
              "'" + string(double(halo.I1x[i]), FORMAT='(D0)')          +"'," + $ ;--- Inertia tensor components
              "'" + string(double(halo.I1y[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo.I1z[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo.I2x[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo.I2y[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo.I2z[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo.I3x[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo.I3y[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo.I3z[i]), FORMAT='(D0)')          +"'," + $
               "'" + string(double(halo_half.radius[i]), FORMAT='(D0)') +"'," + $ ;--- HALF MASS RADIUS
              "'" + string(double(LMod_half[i]), FORMAT='(D0)')         +"'," + $ ;--- Angular momentum magnitude
              "'" + string(double(halo_half.Lx[i]), FORMAT='(D0)')      +"'," + $ ;--- Angular momentum components
              "'" + string(double(halo_half.Ly[i]), FORMAT='(D0)')      +"'," + $
              "'" + string(double(halo_half.Lz[i]), FORMAT='(D0)')      +"'," + $
              "'" + string(double(halo_half.I1[i]), FORMAT='(D0)')      +"'," + $ ;--- Inertia tensor
              "'" + string(double(halo_half.I2[i]), FORMAT='(D0)')      +"'," + $
              "'" + string(double(halo_half.I3[i]), FORMAT='(D0)')      +"'," + $
              "'" + string(double(halo_half.I1x[i]), FORMAT='(D0)')     +"'," + $ ;--- Inertia tensor components
              "'" + string(double(halo_half.I1y[i]), FORMAT='(D0)')     +"'," + $
              "'" + string(double(halo_half.I1z[i]), FORMAT='(D0)')     +"'," + $
              "'" + string(double(halo_half.I2x[i]), FORMAT='(D0)')     +"'," + $
              "'" + string(double(halo_half.I2y[i]), FORMAT='(D0)')     +"'," + $
              "'" + string(double(halo_half.I2z[i]), FORMAT='(D0)')     +"'," + $
              "'" + string(double(halo_half.I3x[i]), FORMAT='(D0)')     +"'," + $
              "'" + string(double(halo_half.I3y[i]), FORMAT='(D0)')     +"'," + $
              "'" + string(double(halo_half.I3z[i]), FORMAT='(D0)')     +"'" + $
              ");"

   print_loop, i, 10000
   MYSQLCMD, U, my_query
ENDFOR

print, '>>> Ready inserting values into Halo_Prop'


close,  U
free_lun, U



end

