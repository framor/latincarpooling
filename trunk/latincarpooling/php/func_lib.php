<?Php
Function database_connect(){
	require('/var/www/include/carpooling_db.php');
	return  $cn=pg_connect("host=".$db_host." dbname=".$db_database." user=".$db_user." password=".$db_pass);
}

Function database_query( $consulta){
	return 	pg_query( $consulta);
}

Function database_fetch_row( $resultado){
	return pg_fetch_row($resultado);
}

Function database_close( $conexion){
	return pg_close($conexion);
}

function buscar_campo($campo, $tabla, $campoclave, $clave){	
	$cn=database_connect();
	$result=pg_query("Select ".$campo."
					  From ".$tabla."
					  where ".$campoclave." = '".$clave."'");
	$row = pg_fetch_row($result);	
	pg_close($cn);
	return trim($row[0]);
}

function buscar_campo_nopost($campo, $tabla, $campoclave, $clave){
	if(count($_POST) == 0){		
		$cn=database_connect();
		$result=pg_query("Select ".$campo."
					  	From ".$tabla."
					  	where ".$campoclave." = '".$clave."'");
		$row = pg_fetch_row($result);	
		pg_close($cn);
		return trim($row[0]);
	}else{
		return $_POST[$campo];
	}
}

function verificar_post($campo){
	if (isset($_POST[$campo])){
		if (strlen(trim($_POST[$campo])) > 0){
			return 1;
		}
	}
	return 0;
}

function asignar_style($campo){
	if (count($_POST) > 0){
		if (strlen(trim($_POST[$campo])) > 0){
				return 'style2';
		}else{
			return 'style3';
		}
	}else{
		return 'style2';
	}
}


function error($msg){
	echo '
		<tr>
			<td><div align="right">			
				<img src="/imagenes/Warning.png" width="50" height="50" border="0">
			</div></td>
			<td>			
				<span class="style5">ERROR: '.$msg.' <br></span>
			</td>
		</tr>
	';
}

function no_error($msg){
	echo '
		<tr>
			<td><div align="right">			
				<img src="/imagenes/Good.png" width="50" height="50" border="0">
			</div></td>
			<td>			
				<span class="style1">'.$msg.' <br></span>
			</td>
		</tr>
	';
}



?>
