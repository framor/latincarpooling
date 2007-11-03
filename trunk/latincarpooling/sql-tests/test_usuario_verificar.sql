/* Realiza el testeo de los siguientes procedimientos:
        sps_verificar_usuario

*/

-- Reporta que no se ingreso el usuario.
execute procedure dbo.sps_verificar_usuario (null, 'nadiees')
;

--Reporta que no se ingreso la contraseña.
execute procedure dbo.sps_verificar_usuario ('test',null)
;

--Mostramos los datos del usuario.
select uio_id, uio_nombre, uio_apellido, uio_nombreusuario, uio_contrasena
from usuario
where uio_id = 666
;

--Devuelve cero porque la contraseña o el usuario son incorrectos.
execute procedure dbo.sps_verificar_usuario ('tester','nadiees')
;
execute procedure dbo.sps_verificar_usuario ('test2','guionbajo')
;

--Devuelve el ID del usuario porque los parametros son correctos.
execute procedure dbo.sps_verificar_usuario ('tester','guionbajo')
;

