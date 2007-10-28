-- Este procedimento debe correrse por unica vez y realiza la carga de los
-- datos iniciales.

create procedure dbo.spi_datos_iniciales ();
    --Agregamos las monedas
    if not exists (select 1
                from moneda
                where mda_id = 1) then
       INSERT INTO moneda(
            mda_id, mda_nombre)
        VALUES (1, 'Peso Argentino');
    end if;

    if not exists (select 1
                from moneda
                where mda_id = 2) then
       INSERT INTO moneda(
            mda_id, mda_nombre)
        VALUES (2, 'Dolar Americano');
    end if;

    --Agregamos los paises.
    if not exists (select 1
                from pais
                where pis_id = 1) then
        insert into pais (
                pis_id, pis_nombre, pis_mda_id)
        values (1, 'Argentina', 1);
    end if;

    --Agregamos las regiones
    if not exists (select 1
                from region
                where ron_pis_id = 1) then
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (2, 'Catamarca', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (17, 'Salta', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (7, 'Distrito Federal', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (19, 'San Luis', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (8, 'Entre Rios', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (12, 'La Rioja', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (22, 'Santiago del Estero', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (3, 'Chaco', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (18, 'San Juan', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (11, 'La Pampa', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (13, 'Mendoza', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (14, 'Misiones', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (9, 'Formosa', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (15, 'Neuquen', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (16, 'Rio Negro', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (21, 'Santa Fe', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (24, 'Tucuman', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (4, 'Chubut', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (23, 'Tierra del Fuego', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (6, 'Corrientes', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (5, 'Cordoba', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (10, 'Jujuy', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (20, 'Santa Cruz', 1);
            INSERT INTO region (ron_id, ron_nombre, ron_pis_id) VALUES (1, 'Buenos Aires, Prov.', 1);
    end if;

    -- Agregamos los programas de mensajeria.
    if not exists (select 1
                from programamensajeria p
                where p.pma_id = 1) then
        insert into programamensajeria (pma_id, pma_nombre)
        values (1, 'Yahoo');
    end if;

    if not exists (select 1
                from programamensajeria p
                where p.pma_id = 2) then
        insert into programamensajeria (pma_id, pma_nombre)
        values (2, 'MSN');
    end if;

    if not exists (select 1
                from programamensajeria p
                where p.pma_id = 3) then
        insert into programamensajeria (pma_id, pma_nombre)
        values (3, 'ICQ');
    end if;

    if not exists (select 1
                from programamensajeria p
                where p.pma_id = 4) then
        insert into programamensajeria (pma_id, pma_nombre)
        values (4, 'Jabber');
    end if;

    -- Cargamos los tipos de documentos.
    if not exists (select 1
                from tipodocumento t
                where t.tdo_id = 1) then
        insert into tipodocumento (tdo_id, tdo_descripcion)
        values (1, 'DNI');
    end if;

    if not exists (select 1
                from tipodocumento t
                where t.tdo_id = 2) then
        insert into tipodocumento (tdo_id, tdo_descripcion)
        values (2, 'LC');
    end if;

    if not exists (select 1
                from tipodocumento t
                where t.tdo_id = 3) then
        insert into tipodocumento (tdo_id, tdo_descripcion)
        values (3, 'LE');
    end if;

    if not exists (select 1
                from tipodocumento t
                where t.tdo_id = 4) then
        insert into tipodocumento (tdo_id, tdo_descripcion)
        values (4, 'Pasaporte');
    end if;

    if not exists (select 1
                from tipodocumento t
                where t.tdo_id = 5) then
        insert into tipodocumento (tdo_id, tdo_descripcion)
        values (5, 'Cedula de Identidad');
    end if;

    --Agregamos los combustibles.
    if not exists (select 1
                from combustible c
                where c.cle_id = 1) then
        insert into combustible (cle_id, cle_nombre)
        values (1, 'Nafta Super');
    end if;

    if not exists (select 1
                from combustible c
                where c.cle_id = 2) then
        insert into combustible (cle_id, cle_nombre)
        values (2, 'Nafta Comun');
    end if;

    if not exists (select 1
                from combustible c
                where c.cle_id = 3) then
        insert into combustible (cle_id, cle_nombre)
        values (3, 'Gasoil');
    end if;

    if not exists (select 1
                from combustible c
                where c.cle_id = 4) then
        insert into combustible (cle_id, cle_nombre)
        values (4, 'GNC');
    end if;

    -- Agregamos los idiomas.
    if not exists (select 1
                from idioma i
                where i.ima_id = 1) then
        insert into idioma (ima_id, ima_descripcion)
        values (1, 'Español');
    end if;

    if not exists (select 1
                from idioma i
                where i.ima_id = 2) then
        insert into idioma (ima_id, ima_descripcion)
        values (2, 'Ingles');
    end if;

    if not exists (select 1
                from idioma i
                where i.ima_id = 3) then
        insert into idioma (ima_id, ima_descripcion)
        values (3, 'Aleman');
    end if;

    if not exists (select 1
                from idioma i
                where i.ima_id = 4) then
        insert into idioma (ima_id, ima_descripcion)
        values (4, 'Frances');
    end if;

    if not exists (select 1
                from idioma i
                where i.ima_id = 5) then
        insert into idioma (ima_id, ima_descripcion)
        values (5, 'Portugues');
    end if;
    
    

end procedure
document
'Fecha de Creacion: 2007-10-28                                                          ',
'                                                                                       ',
'Autor:             ARobirosa                                                           ',
'                                                                                       ',
'Parametros:                                                                            ',
'                                                                                       ',
'Descripcion:       Carga los datos iniciales del sistema.                              ',
'                                                                                       ',
'Resultados:        Ninguno.                                                            ',
'                                                                                       ',
'Errores Reportados:                                                                    ',
'                                                                                       '
with listing in 'informix_warn'
;
execute procedure dbo.spi_datos_iniciales()
;
drop procedure dbo.spi_datos_iniciales
;

