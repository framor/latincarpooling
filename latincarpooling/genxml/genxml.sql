-- (c) Copyright IBM Corp. 2003  All rights reserved.                 */
--                                                                    */
-- This sample program is owned by International Business Machines    */
-- Corporation or one of its subsidiaries ("IBM") and is copyrighted  */
-- and licensed, not sold.                                            */
--                                                                    */
-- You may copy, modify, and distribute this sample program in any    */
-- form without payment to IBM,  for any purpose including developing,*/
-- using, marketing or distributing programs that include or are      */
-- derivative works of the sample program.                            */
--                                                                    */
-- The sample program is provided to you on an "AS IS" basis, without */
-- warranty of any kind.  IBM HEREBY  EXPRESSLY DISCLAIMS ALL         */
-- WARRANTIES EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO*/
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTIC-*/
-- ULAR PURPOSE. Some jurisdictions do not allow for the exclusion or */
-- limitation of implied warranties, so the above limitations or      */
-- exclusions may not apply to you.  IBM shall not be liable for any  */
-- damages you suffer as a result of using, modifying or distributing */
-- the sample program or its derivatives.                             */
--                                                                    */
-- Each copy of any portion of this sample program or any derivative  */
-- work,  must include a the above copyright notice and disclaimer of */
-- warranty.                                                          */
--                                                                    */
-- ********************************************************************/
CREATE FUNCTION genxmlversion()
RETURNING lvarchar
WITH(NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(genxmlversion)"
LANGUAGE C;

{ Devuelve un tag XML con el nombre dado para cada una de las filas
  enviada como parametro.
  Argumentos:
  - Nombre de cada tag XML.
  - Row o lista de columnas.

  Ejemplo:
  select genxml('unCombustible', row(cle_id, cle_nombre))
  from combustible;
}
CREATE FUNCTION genxml(LVARCHAR, ROW)
RETURNING lvarchar
WITH(NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(genxml)"
LANGUAGE C;

{ Devuelve un tag XML con el nombre "Row" para cada una de las filas
  enviada como parametro.
  Argumentos
  - Row o lista de columnas.

  Ejemplo:
  select genxml(row(cle_id, cle_nombre))
  from combustible;
}
CREATE FUNCTION genxml(ROW)
RETURNING lvarchar
WITH(NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(genxmlnamedrow)"
LANGUAGE C;

{ Devuelve un tag XML con el nombre indicado para cada una de las filas
  enviada como parametro.
  Argumentos
  - nombre del tag XML.
  - Row o lista de columnas.

  Ejemplo:
  select genxml('combustible','select * from combustible')
  from systables
  where tabid = 1;
}
CREATE FUNCTION genxml(LVARCHAR, LVARCHAR)
RETURNING lvarchar
WITH(NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(genxmlnhdr)"
LANGUAGE C;

{ Devuelve un documento XML con una seccion principal con el nombre recibido
  a partir de una sentencia SQL.

  Argumentos:
  - nombre del tag XML principal.
  - Sentencia SQL cuyo resultado se convertira a XML.

  Ejemplo:
        select genxmlhdr('combustible','select * from combustible')
        from systables
        where tabid = 1;
}
CREATE FUNCTION genxmlhdr(LVARCHAR, LVARCHAR)
RETURNING lvarchar
WITH(NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(genxmlhdr)"
LANGUAGE C;

{ Devuelve un documento XML con una seccion principal con el nombre recibido
  a partir de una sentencia SQL.

  Argumentos:
  - ID en la tabla de DTDs y XSLs.
  - Sentencia SQL cuyo resultado se convertira a XML. Solo convierte la
  - primera columna.

  Ejemplo:
        select addxmlhdr('customer_set','select cle_id from combustible')
        from systables
        where tabid = 1;
}

CREATE FUNCTION addxmlhdr(LVARCHAR, LVARCHAR)
RETURNING lvarchar
WITH(NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(addxmlhdr)"
LANGUAGE C;

CREATE DISTINCT TYPE aggrxml_t AS POINTER;
CREATE OPAQUE TYPE genxml_t (INTERNALLENGTH=VARIABLE, MAXLEN=32730);

CREATE FUNCTION castgenxml_t(genxml_t)
RETURNING lvarchar
WITH (HANDLESNULLS, NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(castgenxml_t_lvar)"
LANGUAGE C;

CREATE IMPLICIT CAST (genxml_t AS lvarchar WITH castgenxml_t);

CREATE FUNCTION init_aggrxml(ROW, LVARCHAR default "Document")
RETURNING aggrxml_t
WITH (HANDLESNULLS, NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(init_aggrxml)"
LANGUAGE C;

CREATE FUNCTION iter_aggrxml(aggrxml_t, ROW)
RETURNING aggrxml_t
WITH (NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(iter_aggrxml)"
LANGUAGE C;

CREATE FUNCTION comb_aggrxml(aggrxml_t, aggrxml_t)
RETURNING aggrxml_t
WITH (NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(init_aggrxml)"
LANGUAGE C;

{ Funcion agregada qeu genera un documento XML.
  Parametros:
  - Lista de columnas (row)
  - ID en la tabla de DTDs y XSLs

  Ejemplo:
	SELECT aggrxml(recorrido, "customer_set")
	FROM recorrido
	WHERE rdo_id = 1;
}
CREATE FUNCTION final_aggrxml(aggrxml_t)
RETURNING genxml_t
WITH (NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(final_aggrxml)"
LANGUAGE C;

CREATE AGGREGATE aggrxml WITH (
  INIT = init_aggrxml,
  ITER = iter_aggrxml,
  COMBINE = comb_aggrxml,
  FINAL = final_aggrxml
);

{ Tabla que guarda los Paths de los dtd y xsl.}
CREATE TABLE genxmlinfo (
  name       varchar(30) PRIMARY KEY,
  dtypepath  lvarchar,
  xslpath    lvarchar
);
INSERT INTO genxmlinfo
VALUES ("customer_set",
        "/usr/dtd/customer_set.dtd",
        "/usr/xls/customer_set.xls"
);
INSERT INTO genxmlinfo
VALUES ("manufact_set", "../manufact_set", "../manufact_set");


CREATE FUNCTION genxsl(LVARCHAR, LVARCHAR, ROW)
RETURNING lvarchar(32000)
WITH(NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(genxsl)"
LANGUAGE C;


CREATE FUNCTION gendtd(LVARCHAR, LVARCHAR, ROW)
RETURNING lvarchar(32000)
WITH(NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(gendtd)"
LANGUAGE C;

{ Devuelve un documento XML.
        Argumentos
  - Nombre de la seccion principal.
  - Sentencia SQL cuyo resultado se convertira a XML.
  - Path completo del archivo con la DTD.
  - Path completo del archivo con la XSL.

  Ejemplo:
  EXECUTE FUNCTION
  genxmlhdr2("valoresdolares",
        "SELECT * FROM valorcambio where vco_mda_id = 1",
        "E:\usr\undtd.dtd",
        "D:\usr\otroxsl.xsl");
}
CREATE FUNCTION genxmlhdr2(LVARCHAR, LVARCHAR, LVARCHAR, LVARCHAR)
RETURNING lvarchar
WITH(NOT VARIANT)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(genxmlhdr2)"
LANGUAGE C;


{
CREATE FUNCTION set_tracing(lvarchar, int, lvarchar)
RETURNING int
WITH (not variant, handlesnulls)
EXTERNAL NAME "$INFORMIXDIR/extend/genxml/bin/genxml.bld(set_tracing)"
LANGUAGE C;

INSERT INTO systraceclasses(name)
       VALUES("myclass");
}
