<?Php
/* PK - 16/06/2007 - Imprime las paginas de un tipo de categoria (C=Configuracion, M=Monitoreo, I=Informe */
function item($tipo) {
	$result=pg_query("select distinct p.idpagina, p.descripcion, p.url
	from usuarios U, UsuariosListasPermisos UP, ListasPermisos LP, PaginasListasPermisos PP, paginas P
	where P.idpagina = PP.idpagina
	and U.idusuario = UP.idusuario
	and LP.idlistapermiso = PP.idlistapermiso
	and LP.idlistapermiso = UP.idlistapermiso
	and U.idusuario = ".$_SESSION["idusuario"]."
	and P.tipo = '".$tipo."'
	order by p.descripcion");	
	
	while ($row = pg_fetch_row($result)){			
		echo '		<tr>
						<td bgcolor="#999999" height="1">
						</td>
					</tr>
					<tr> 
						<td bgcolor="#F4F4F4" align="right" onmouseover=\'this.style.background="#CCCCCC"\' onmouseout=\'this.style.background="#F4F4F4"\'>
							<table cellpadding="0" cellspacing="0" width="150" >
								<tr>
									<td align="left">
										<span class="style0">
											<a href="'.$row[2].'" class="sinLink">'.$row[1].'</a>
										</span>
									</td>
								</tr>
							</table>
						</td>									
					</tr>
			';
	}
}

/* PK - 16/06/2007 - Imprime el título de una categoría */
function categoria($titulo){
echo '			<tr>
					<td bgcolor="#999999" height="1">
					</td>
				</tr>
				<tr>					
					<td bgcolor="#DCDCDC">
						<span class="style1">'.$titulo.'</span>
					</td>
				</tr>';
}

/* PK - 16/06/2007 - Imprime el menu izquierdo */
function menu(){
require('/var/www/include/global.php');

$cn=pg_connect("host=localhost dbname=".$postgres_database." user=".$postgres_user." password=".$postgres_pass);

echo '      <br/>
			<!--PK - 02/06/2007 - Inicio Menu -->
			<table cellpadding="0" cellspacing="0" width="153" >	';	
categoria('Monitoreo');				
item('M');
categoria('Informes');	
item('I');
categoria('Configuración');
item('C');	
echo '	</table>
			<!--PK - 02/06/2007 - Fin Menu -->
 ';
pg_close($cn);
}
?>
