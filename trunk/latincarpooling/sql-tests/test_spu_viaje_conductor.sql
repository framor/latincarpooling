-- Scripts TEST
-- EXECUTE PROCEDURE spu_viaje_conductor (
--     id_viaje, id_conductor, id_recorrido, fecha_menor, fecha_mayor, lugares,
--     lugares_libres, importe, importe_total);

-- No existe el id del usuario conductor. [1]
EXECUTE PROCEDURE spu_viaje_conductor (
     1000, 128379, 1, '10-02-2007', '10-05-2007', 10,
     10, 20, 200)
;

-- El importe es menor a cero. [22]
EXECUTE PROCEDURE spu_viaje_conductor (
     1000, 666, 1, '10-02-2007', '10-05-2007', 10,
     10, -20, -200)
;

-- La cantidad de lugares totales es menor que los lugares libres. [23]
EXECUTE PROCEDURE spu_viaje_conductor (
     1000, 666, 1, '10-02-2007', '10-05-2007', 5,
     10, 20, 200)
;

-- La cantidad de lugares libres es menor a cero. [24]
EXECUTE PROCEDURE spu_viaje_conductor (
     1000, 666, 1, '10-02-2007', '10-05-2007', 10,
     -10, 20, 200)
;

-- La fecha menor debería ser mas chica que la fecha mayor. [25]
EXECUTE PROCEDURE spu_viaje_conductor (
     1000, 666, 1, '10-05-2007', '10-02-2007', 10,
     -10, 20, 200)
;

-- No existe el id del recorrido indicado. [26]
EXECUTE PROCEDURE spu_viaje_conductor (
     1000, 666, 1000, '10-02-2007', '10-05-2007', 10,
     10, 20, 200)
;

-- Borrar todo
DELETE viajeconductor WHERE vcr_vje_id = 1000;
DELETE viaje WHERE vje_id = 1000;

-- Ver si existe un viaje con ese id
SELECT * FROM viajeconductor WHERE vcr_vje_id = 1000
;
SELECT * FROM viaje WHERE vje_id = 1000
;
SELECT * FROM viajeconductor;

-- Insertar el viaje con unos valores
EXECUTE PROCEDURE spu_viaje_conductor (
     1000, 666, 1, '10-02-2007', '10-05-2007', 10,
     10, 20, 200)
;

-- Actualizar los datos del viaje
EXECUTE PROCEDURE spu_viaje_conductor (
     1000, 666, 2, '10-05-2007', '10-07-2007', 10,
     5, 21, 300)
;


