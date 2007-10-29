/* Realiza el testeo de los siguientes procedimientos:
        spu_usuario_mensajeria
        spd_usuario_mensajeria
*/

-- Reporta que el usuario no existe.
execute procedure spu_usuario_mensajeria (1299, 1, 'usuarioYahoo')
;
--Reporta que el programa de mensajeria no existe.
execute procedure spu_usuario_mensajeria (666, 99, 'usuarioYahoo')
;
--Reporta que no se indico el nombre de usuario.
execute procedure spu_usuario_mensajeria (666, 1, null)
;

--Mostramos que el usuario 666 no tiene usuarios de mensajeria.
select *
from usuariomensajeria
where uma_uio_id = 666
;

--Insertamos dos usuarios de mensajeria.
execute procedure spu_usuario_mensajeria (666, 1, 'utiliceYahoo')
;
execute procedure spu_usuario_mensajeria (666, 2, 'abajoMicrosoft')
;

--Mostramos como quedaron las tablas.
select *
from usuariomensajeria
where uma_uio_id = 666
;

--Actualizamos uno de los nombres de usuarios.
execute procedure spu_usuario_mensajeria (666, 2, 'santoMicrosoft')
;

--Mostramos como quedaron las tablas.
select *
from usuariomensajeria
where uma_uio_id = 666
;

-- Reporta que el usuario no existe.
execute procedure spd_usuario_mensajeria (1299, 1)
;

--Reporta que el programa de mensajeria no existe.
execute procedure spd_usuario_mensajeria (666, 99)
;

-- Borramos el usuario de mensajeria de Yahoo.
execute procedure spd_usuario_mensajeria (666, 1)
;

--Mostramos como quedaron las tablas: Solo MSN.
select *
from usuariomensajeria
where uma_uio_id = 666
;
