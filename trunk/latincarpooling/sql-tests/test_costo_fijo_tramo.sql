/* Realiza el testeo de los siguientes procedimientos:
        spu_costo_fijo_tramo

   Nota: Verificar la configuracion de las fechas.
*/

--Muestra los distintos costos fijos del tramo 1.
select *
from costofijotramo
where cft_tra_id = 1
order by cft_vigentedesde
;

-- Reporta que no existe la moneda.
execute procedure dbo.spu_costo_fijo_tramo (9999, null, 4.00)
;

--Reporta que no se indico la fecha de inicio de la vigencia.
execute procedure dbo.spu_costo_fijo_tramo (1, null, 3.10)
;

--Reporta que no se indico el costo fijo.
execute procedure dbo.spu_costo_fijo_tramo (1, '10-28-2007', null)
;

--Reporta que el costo fijo debe ser mayor a cero.
execute procedure dbo.spu_costo_fijo_tramo (1, '10-28-2007', -3.14)
;

--Inserta el costo fijo al 28/10/2007.
execute procedure dbo.spu_costo_fijo_tramo (1, '10-28-2007', 2.20)
;

--Inserta el costo fijo al 01/01/2001
execute procedure dbo.spu_costo_fijo_tramo (1, '01-01-2001', 1)
;

--Inserta el costo fijo al 01/01/2008
execute procedure dbo.spu_costo_fijo_tramo (1, '01-01-2008', 3.5)
;

--Inserta el costo fijo al 01/03/2002
execute procedure dbo.spu_costo_fijo_tramo (1, '01-03-2002', 1.5)
;

--Muestra los distintos costos fijos del tramo 1.
select *
from costofijotramo
where cft_tra_id = 1
order by cft_vigentedesde
;

--Actualiza el costo fijo al 28/10/2007.
execute procedure dbo.spu_costo_fijo_tramo (1, '10-28-2007', 2.25)
;

--Muestra los distintos costos fijos del tramo 1.
select *
from costofijotramo
where cft_tra_id = 1
order by cft_vigentedesde
;
