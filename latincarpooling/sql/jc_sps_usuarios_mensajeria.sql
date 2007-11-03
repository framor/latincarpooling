-- sps_usuarios_mensajeria
drop procedure dbo.sps_usuarios_mensajeria;

create procedure dbo.sps_usuarios_mensajeria
(
    id_usuario LIKE usuario.uio_id
) RETURNING CHAR(30), INTEGER, CHAR(25);

    DEFINE nombre_usuario LIKE dbo.usuariomensajeria.uma_nombreusuario;
    DEFINE id_programa LIKE dbo.programamensajeria.pma_id;
    DEFINE nombre_programa LIKE dbo.programamensajeria.pma_nombre;

    if not exists (select 1 from usuario where uio_id = id_usuario) then
       RAISE EXCEPTION -746, 0, 'No existe el id del usuario. [1]';
       return;
    end if;

    FOREACH
        SELECT uma_nombreusuario, pma_id, pma_nombre
        INTO nombre_usuario, id_programa, nombre_programa
        FROM usuariomensajeria, programamensajeria
        WHERE
            uma_uio_id = id_usuario AND uma_id = pma_id

        RETURN nombre_usuario, id_programa, nombre_programa WITH RESUME;
    END FOREACH;

end procedure
document
'Fecha de Creacion: 2007-11-02                                                          ',
'                                                                                       ',
'Autor:             JCapanegra                                                          ',
'                                                                                       ',
'Parametros:                                                                            ',
'                   id_ciudad_origen      Ciudad inicial del viaje.                     ',
'                   id_ciudad_destino     Ciudad final del viaje.                       ',
'                                                                                       ',
'Descripcion:       Realiza la búsqueda de los viajes de conductores que existen        ',
'                   registrados entre las ciudades especificadas.                       ',
'                                                                                       ',
'Resultados:        Id de los viajes que existen entre ambas ciudades.                  ',
'                   Si no hay ninguno, no devuelve ninguna fila.                        ',
'                                                                                       ',
'Errores Reportados:                                                                    ',
'                   - La ciudad origen no existe.                                       ',
'                   - La ciudad destino no existe.                                      ',
'                                                                                       '
with listing in 'informix_warn'
;
