-- spu_viaje_conductor
drop procedure dbo.spu_viaje_conductor;

create procedure dbo.spu_viaje_conductor
(
    id_viaje LIKE viaje.vje_id,
    id_conductor LIKE usuario.uio_id,
    id_recorrido LIKE viaje.rdo_id,
    fecha_menor LIKE viaje.vje_fechamenor,
    fecha_mayor LIKE viaje.vje_fechamayor,
    lugares LIKE viajeconductor.vcr_cantlugares,
    lugares_libres LIKE viajeconductor.vcr_lugareslibres,
    importe LIKE viajeconductor.vcr_importe,
    importe_total LIKE viajeconductor.vcr_importeviaje
);

    if not exists (select 1 from usuario where uio_id = id_conductor) then
       RAISE EXCEPTION -746, 0, 'No existe el id del usuario conductor. [1]';
       return;
    end if;

    if importe < 0 AND importe_total < 0 then
       RAISE EXCEPTION -746, 0, 'El importe es menor a cero. [2]';
       return;
    end if;

    if lugares < lugares_libres then
       RAISE EXCEPTION -746, 0, 'La cantidad de lugares totales es menor que los lugares libres. [3]';
       return;
    end if;

    if lugares_libres < 0 then
       RAISE EXCEPTION -746, 0, 'La cantidad de lugares libres es menor a cero. [4]';
       return;
    end if;

    if fecha_menor > fecha_mayor then
       RAISE EXCEPTION -746, 0, 'La fecha menor debería ser mas chica que la fecha mayor. [5]';
       return;
    end if;

    if not exists (select 1 from recorrido where rdo_id = id_recorrido) then
       RAISE EXCEPTION -746, 0, 'No existe el id del recorrido indicado. [6]';
       return;
    end if;

    if exists (select 1 from viaje where vje_id = id_viaje) then
      begin
          update viaje
          set
              vje_fechamenor = fecha_menor,
              vje_fechamayor = fecha_mayor,
              vje_rdo_id = id_recorrido
          where vje_id = id_viaje;

          update viajeconductor
          set
              vcr_uio_id = id_conductor,
              vcr_importe = importe,
              vcr_importeviaje = importe_total,
              vcr_cantlugares = lugares,
              vcr_lugareslibres = lugares_libres
          where vcr_vje_id = id_viaje;
      end;
    else
      begin
          insert into viaje
          (
              vje_id, vje_fechamenor, vje_fechamayor, vje_tipoviaje, vje_rdo_id
          )
          values
          (
              id_viaje, fecha_menor, fecha_mayor, 'C', id_recorrido
          );

          insert into viajeconductor
          (
              vcr_vje_id, vcr_uio_id, vcr_importe, vcr_importeviaje,
              vcr_cantlugares, vcr_lugareslibres
          )
          values
          (
              id_viaje, id_conductor, importe, importe_total,
              lugares, lugares_libres
          );
      end;
    end if;

end procedure
document
'Fecha de Creacion: 2007-10-15                                                          ',
'                                                                                       ',
'Autor:             JCapanegra                                                           ',
'                                                                                       ',
'Parametros:                                                                            ',
'                   nombre_usuario      Nombre del usuario.                             ',
'                   contrasena_hash     Hash MD5 de la contraseña                       ',
'                                                                                       ',
'Descripcion:       Verifica que el nombre de usuario y la contraseña indicada sean las ',
'                   correctas con respecto a la información almacenada.                 ',
'                                                                                       ',
'Resultados:        ID del usuario si la informacion es correcta.                       ',
'                   Cero en otro caso.                                                  ',
'                                                                                       ',
'Errores Reportados:                                                                    ',
'                   - No se ingresó un usuario.                                         ',
'                   - No se ingresó la contraseña.                                      ',
'                                                                                       '
with listing in 'informix_warn'
;
