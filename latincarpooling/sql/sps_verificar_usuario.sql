drop procedure sps_verificar_usuario
;
create procedure sps_verificar_usuario
(
    nombre_usuario char(20),
    contrasena_hash char(255)

) returning integer;

    define id_usuario integer;

    if nombre_usuario is null or nombre_usuario = '' then
       RAISE EXCEPTION -746, 0, 'No se ingreso un usuario. [6]';
       return 0;
    end if;

    if contrasena_hash is null or contrasena_hash = '' then
       RAISE EXCEPTION -746, 0, 'No se ingreso la contrase�a. [7]';
       return 0;
    end if;

    let id_usuario = (select u.uio_id
        from usuario u
        where u.uio_nombreusuario = nombre_usuario
        and u.uio_contrasena = contrasena_hash);

    if id_usuario is null then
        let id_usuario = 0;
    end if;

    return id_usuario;

end procedure
document
'Fecha de Creacion: 2007-10-15                                                          ',
'                                                                                       ',
'Autor:             ARobirosa                                                           ',
'                                                                                       ',
'Parametros:                                                                            ',
'                   nombre_usuario      Nombre del usuario.                             ',
'                   contrasena_hash     Hash MD5 de la contrase�a                       ',
'                                                                                       ',
'Descripcion:       Verifica que el nombre de usuario y la contrase�a indicada sean las ',
'                   correctas con respecto a la informaci�n almacenada.                 ',
'                                                                                       ',
'Resultados:        ID del usuario si la informacion es correcta.                       ',
'                   Cero en otro caso.                                                  ',
'                                                                                       ',
'Errores Reportados:                                                                    ',
'                   - No se ingres� un usuario.                                         ',
'                   - No se ingres� la contrase�a.                                      ',
'                                                                                       '
with listing in 'informix_warn'
;

-- INFORMIX --
--DROP FUNCTION DBO.VERIFICAR_USUARIO
CREATE FUNCTION DBO.VERIFICAR_USUARIO ( u char(20), p char(200))
RETURNING integer;
RETURN SPS_VERIFICAR_USUARIO(u, p);
END FUNCTION;
-- DB2 --
--drop FUNCTION VERIFICAR_UIO
create FUNCTION DB2ADMIN.VERIFICAR_UIO2 (varchar(20), varchar(200))
RETURNS integer
AS TEMPLATE
DETERMINISTIC
NO EXTERNAL ACTION

CREATE FUNCTION MAPPING VERIFICAR_UIO_2 FOR VERIFICAR_UIO2
SERVER TYPE INFORMIX OPTIONS (REMOTE_NAME 'VERIFICAR_USUARIO')
-- VALIDACION
SELECT  VERIFICAR_UIO2('tester', 'guionbajo'), count(*)  FROM USUARIO


