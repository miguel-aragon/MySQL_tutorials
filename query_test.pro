;
;
;
;
;
;


;window, xs=800,ys=800,retain=2
;device, decomposed=0
;loadct, 4
;my_ctable, white = 255


my_query = '"' + $
           'SELECT Halo_Prop.Id, Halo_Prop.x, Halo_Prop.y, Halo_Prop.z, ' + $
           'Halo_Prop.mass, Halo_Prop.radius, ' + $
           'Halo_Prop.Sx, Halo_Prop.Sy, Halo_Prop.Sz, ' + $
           'Halo_Prop.I1, Halo_Prop.I2, Halo_Prop.I3, ' + $
           'Halo_Prop.I1x, Halo_Prop.I1y, Halo_Prop.I1z, ' + $
           'Halo_Prop.radius_half, ' + $
           'Halo_Prop.Sx_half, Halo_Prop.Sy_half, Halo_Prop.Sz_half, ' + $
           'Halo_Prop.I1_half, Halo_Prop.I2_half, Halo_Prop.I3_half, ' + $
           'Halo_Prop.I1x_half, Halo_Prop.I1y_half, Halo_Prop.I1z_half, ' + $
           'Halo_Prop.Gau1, Halo_Prop.Gau3, Halo_Prop.Gau5 ' + $
           'FROM Halo_Prop WHERE Halo_Prop.z < 100000; ' + $
           '"'

my_query = '"' + $
           'SELECT Halo_Prop.x, Halo_Prop.y, Halo_Prop.z, ' + $
           'Halo_Prop.mass, Halo_Prop.radius ' + $
           'FROM Halo_Prop WHERE Halo_Prop.z AND WHERE halo_prop.morh EQ 2< 5000; ' + $
           '"'


h = query_mysql_python(my_query, '100Mpc_Halos')


print, 'Ready!'

;plot, h.x, h.y, psym=3





end

