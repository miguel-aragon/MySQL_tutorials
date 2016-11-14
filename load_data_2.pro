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

;--- Connect to database
GET_LUN, U
openmysql, U, '100Mpc_Halos'

;==================================
;--- Local density
;==================================
FOR i=0L, N_ELEMENTS(halo_lss.gau1)-1 DO BEGIN
   my_query = "INSERT INTO Halo_Den (Id, Top1,Top3,Top5,Top8, Gau1,Gau3,Gau5,Gau8) VALUES(" + $
              "'" + string(long(      Id[i]), FORMAT='(I12)')          +"'," + $
              "'" + string(double(halo_lss.Top1[i]), FORMAT='(D0)')          +"'," + $ ;--- Top-hat window
              "'" + string(double(halo_lss.Top2[i]), FORMAT='(D0)')          +"'," + $ ;---
              "'" + string(double(halo_lss.Top3[i]), FORMAT='(D0)')          +"'," + $ ;---
              "'" + string(double(halo_lss.Top4[i]), FORMAT='(D0)')          +"'," + $ ;---
              "'" + string(double(halo_lss.Gau1[i]), FORMAT='(D0)')          +"'," + $ ;--- Gaussian window
              "'" + string(double(halo_lss.Gau2[i]), FORMAT='(D0)')          +"'," + $ ;---
              "'" + string(double(halo_lss.Gau3[i]), FORMAT='(D0)')          +"'," + $ ;---
              "'" + string(double(halo_lss.Gau4[i]), FORMAT='(D0)')          +"'" + $  ;---
              ");"

   print_loop, i, 10000
   MYSQLCMD, U, my_query
ENDFOR

print, '>>> Ready inserting local density values'



;==================================
;--- MMF Hessian
;==================================
FOR i=0L, N_ELEMENTS(halo_tid.tidal_1)-1 DO BEGIN
   my_query = "INSERT INTO Halo_Hess  (Id, E1_S0,E2_S0,E3_S0, E1x_S0,E1y_S0,E1z_S0, E2x_S0,E2y_S0,E2z_S0, E3x_S0,E3y_S0,E3z_S0," + $
                                          "E1_S1,E2_S1,E3_S1, E1x_S1,E1y_S1,E1z_S1, E2x_S1,E2y_S1,E2z_S1, E3x_S1,E3y_S1,E3z_S1," + $
                                          "E1_S2,E2_S2,E3_S2, E1x_S2,E1y_S2,E1z_S2, E2x_S2,E2y_S2,E2z_S2, E3x_S2,E3y_S2,E3z_S2 ) VALUES(" + $
              "'" + string(long(      Id[i]), FORMAT='(I12)')          +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_1[i]), FORMAT='(D0)')          +"'," + $ ;--- Hessian eigenvalues
              "'" + string(double(halo_LSS.HESS_SCL1_2[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_3[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_1_i[i]), FORMAT='(D0)')         +"'," + $ ;--- Hessian eigenvectors
              "'" + string(double(halo_LSS.HESS_SCL1_1_j[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_1_k[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_2_i[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_2_j[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_2_k[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_3_i[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_3_j[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL1_3_k[i]), FORMAT='(D0)')         +"'," + $ 
              "'" + string(double(halo_LSS.HESS_SCL2_1[i]), FORMAT='(D0)')          +"'," + $ ;--- Hessian eigenvalues
              "'" + string(double(halo_LSS.HESS_SCL2_2[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL2_3[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL2_1_i[i]), FORMAT='(D0)')         +"'," + $ ;--- Hessian eigenvectors
              "'" + string(double(halo_LSS.HESS_SCL2_1_j[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL2_1_k[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL2_2_i[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL2_2_j[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL2_2_k[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL2_3_i[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL2_3_j[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL2_3_k[i]), FORMAT='(D0)')         +"'," + $ 
              "'" + string(double(halo_LSS.HESS_SCL3_1[i]), FORMAT='(D0)')          +"'," + $ ;--- Hessian eigenvalues
              "'" + string(double(halo_LSS.HESS_SCL3_2[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL3_3[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL3_1_i[i]), FORMAT='(D0)')         +"'," + $ ;--- Hessian eigenvectors
              "'" + string(double(halo_LSS.HESS_SCL3_1_j[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL3_1_k[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL3_2_i[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL3_2_j[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL3_2_k[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL3_3_i[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL3_3_j[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_LSS.HESS_SCL3_3_k[i]), FORMAT='(D0)')         +"'" + $ 
              ");"

   print_loop, i, 10000
   MYSQLCMD, U, my_query
ENDFOR

print, '>>> Ready inserting MMF Hessian values'


;==================================
;--- Tidal field
;==================================
FOR i=0L, N_ELEMENTS(halo_tid.tidal_1)-1 DO BEGIN
   my_query = "INSERT INTO Halo_Tidal (Id, T1,T2,T3, T1x,T1y,T1z, T2x,T2y,T2z, T3x,T3y,T3z ) VALUES(" + $
              "'" + string(long(      Id[i]), FORMAT='(I12)')          +"'," + $
              "'" + string(double(halo_tid.tidal_1[i]), FORMAT='(D0)')          +"'," + $ ;--- Tidal field
              "'" + string(double(halo_tid.tidal_2[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo_tid.tidal_3[i]), FORMAT='(D0)')          +"'," + $
              "'" + string(double(halo_tid.tidal_1x[i]), FORMAT='(D0)')         +"'," + $ ;--- Tidal field components
              "'" + string(double(halo_tid.tidal_1y[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_tid.tidal_1z[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_tid.tidal_2x[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_tid.tidal_2y[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_tid.tidal_2z[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_tid.tidal_3x[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_tid.tidal_3y[i]), FORMAT='(D0)')         +"'," + $
              "'" + string(double(halo_tid.tidal_3z[i]), FORMAT='(D0)')         +"'" + $
              ");"

   print_loop, i, 10000
   MYSQLCMD, U, my_query
ENDFOR

print, '>>> Ready inserting Tidal field values'


close,  U
free_lun, U



end

