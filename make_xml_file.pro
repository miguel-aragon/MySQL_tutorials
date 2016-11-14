;
;
;
;
;
;
;
;
;



x = h.x
y = h.y
z = h.z
m = h.mass
r = h.radius

filename = 'test.xml'

GET_LUN, unit
OPENW, unit, filename

;--- Header
PRINTF, unit, '<?xml version="1.0"?>'

PRINTF, unit, '<Grupos>'
FOR i=0L, N_ELEMENTS(x)-1 DO BEGIN
   PRINTF, unit, '   <group id='+strcompress(string(i),/remove_all)+'>'
    PRINTF, unit, '     <x>' + strcompress(x[i],/remove_all)+'</x>'
    PRINTF, unit, '     <y>' + strcompress(y[i],/remove_all)+'</y>'
    PRINTF, unit, '     <z>' + strcompress(z[i],/remove_all)+'</z>'
    PRINTF, unit, '     <m>' + strcompress(m[i],/remove_all)+'</m>'
    PRINTF, unit, '     <r>' + strcompress(r[i],/remove_all)+'</r>'
   PRINTF, unit, '   </group>'
ENDFOR
PRINTF, unit, '</Grupos>'

FREE_LUN, unit











end

