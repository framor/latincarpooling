-- spu_informar_pasajeros
DROP PROCEDURE dbo.spu_informar_pasajeros;

CREATE PROCEDURE dbo.spu_informar_pasajeros
(
    id_viaje LIKE viaje.vje_id,
    lugares LIKE viajeconductor.vcr_cantlugares,
    lugares_libres LIKE viajeconductor.vcr_lugareslibres,
    importe LIKE viajeconductor.vcr_importe,
    importe_total LIKE viajeconductor.vcr_importeviaje
);

    DEFINE receptor LIKE usuario.uio_id;
    DEFINE id_conductor LIKE usuario.uio_id;
    DEFINE id_recorrido LIKE viaje.vje_rdo_id;
    DEFINE fecha_menor LIKE viaje.vje_fechamenor;
    DEFINE fecha_mayor LIKE viaje.vje_fechamayor;

    SELECT vcr_uio_id, vje_rdo_id, vje_fechamenor, vje_fechamayor
    INTO id_conductor, id_recorrido, fecha_menor, fecha_mayor
    FROM viaje, viajeconductor
    WHERE
        vje_id = vcr_vje_id;

    FOREACH
        SELECT vpp_uio_id INTO receptor
        FROM viaje, viajepasajero
        WHERE
            vje_id = vpp_vje_id AND vje_rdo_id = id_recorrido AND
            vje_fechamenor < fecha_mayor AND vje_fechamayor < fecha_menor AND
            lugares_libres > 0


        INSERT INTO mensaje
        (
            mje_fecha, mje_asunto, mje_texto, mje_fueleido,
            mje_uio_id_dest, mje_uio_id_rem
        )
        VALUES
        (
            TODAY, 'Viaje recibido', 'Se agrego un viaje solicitado', 0,
            receptor, id_conductor
        );

    END FOREACH;

end procedure
document
'Fecha de Creacion: 2007-10-15                                                          ',
'                                                                                       ',
'Autor:             JCapanegra                                                           ',
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