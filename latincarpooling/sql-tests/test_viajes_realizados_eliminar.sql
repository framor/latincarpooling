/* Realiza el testeo de los siguientes procedimientos:
        spd_viajes_realizados

   Nota: Verificar la configuracion de las fechas.
*/

--Muestra los viajes.
select *
from viaje
order by vje_fechamenor
;

-- Muestra los viajes realizados al dia de hoy.
select *
from viaje
where vje_fechamayor < today
order by vje_fechamenor
;


--Reporta que la fecha es mayor a la de hoy.
execute procedure dbo.spd_viajes_realizados ('01-01-2008')
;

--Borra los viajes realizados.
execute procedure dbo.spd_viajes_realizados (today)
;

--Muestra los viajes.
select *
from viaje
order by vje_fechamenor
;

-- Muestra los viajes realizados al dia de hoy.
select *
from viaje
where vje_fechamayor < today
order by vje_fechamenor
;

