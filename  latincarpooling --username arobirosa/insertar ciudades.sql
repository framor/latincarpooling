insert into ciudad
(cad_id, cad_nombre, cad_ron_id)
select g.geonameid, substr(g.asciiname,1,30), int4(g.admin1)
from geoname g
where g.fclass = 'P'
and g.admin1 is not null

DROP INDEX cad_si_nombre;

CREATE  INDEX cad_si_nombre
  ON ciudad
  USING btree
  (cad_ron_id, cad_nombre);

select *
from region

select *
from ciudad
where cad_ron_id = 1


select cad_nombre, cad_ron_id, count(*)
from ciudad
group by cad_nombre, cad_ron_id
having count(*) > 1