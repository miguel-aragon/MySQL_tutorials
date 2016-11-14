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

;--- Read structures from file
restore, 'Data/100Mpc_H_'+Halo_type+'_CAT_simple_100_COSMIC_WEB.IDL'

;--- Create indexes by hand OJO: dangerous!!!
Id = lindgen(N_ELEMENTS(halo_tid.TIDAL_1))

more, Id

;--- Connect to database
GET_LUN, U
openmysql, U, '100Mpc_Halos'


;--- Format spine values from adjacent void count to number of
;    dimensions
;--- Level 0
Spine_Lev123 = bytarr(N_ELEMENTS(halo_spi.Spine_Lev123)) + 3 ;--- All voids
Spine_Lev123[where(halo_spi.Spine_Lev123 EQ 2)] = 2 ;--- Walls
Spine_Lev123[where(halo_spi.Spine_Lev123 GE 3)] = 1 ;--- Filaments

;==================================
;--- Hierarchical Spine
;==================================
FOR i=0L, N_ELEMENTS(halo_spi.Spine_Lev123)-1 DO BEGIN
   my_query = "INSERT INTO Halo_SpineWeb (Id, Morph_dim_L012 ) VALUES(" + $
              "'" + string(long(    Id[i]), FORMAT='(I12)')          +"'," + $
              "'" + string(Spine_Lev123[i], FORMAT='(I6)')          +"'" + $ ;--- Tidal field
               ");"

   print_loop, i, 10000
   MYSQLCMD, U, my_query
ENDFOR

print, '>>> Ready inserting SpineWeb classification'

close,  U
free_lun, U



end

