<?php

require('/var/www/include/carpooling_db.php');

include 'header.php';
include 'func_lib.php';
carpooling_header("Consulta de Tramos");

?>

          <form name="formBuscarTramo" method="post" action="consulta.php">
                    <div align="center">
      
<table cellpadding="0" cellspacing="0" width="780">
		<?php
			$conexion=database_connect();
			
			echo '<tr> <td>';
			$resultadoCantidad = database_query("select count(*) from tramo");
			$filaCantidad = database_fetch_row($resultadoCantidad);
			$cantidadTramos = $filaCantidad[0];
			echo 'Vamos Equipo!! Ya van '.$cantidadTramos.' tramos.';			
			echo '</td> </tr>';
			
			/* Provincia Origen */
			echo '<tr> <td>';
			echo '<input type="hidden" id="provinciaOrigenAnterior" name="provinciaOrigenAnterior" value="'.$_REQUEST['provinciaOrigenActual'].'" />';
			if ($_REQUEST['provinciaOrigenActual'] != $_REQUEST['provinciaOrigenAnterior']) 
				$_REQUEST['ciudadOrigenActual'] = 0;
			echo 'Provincia Origen: <select name="provinciaOrigenActual" class="style2" id="provinciaOrigenActual">';
			$listaProvinciasO = database_query("select ron_id, ron_nombre from region where ron_pis_id = 1 order by ron_nombre");
									
			while (	$filaProvinciaO = database_fetch_row($listaProvinciasO)) {
				$idProvinciaO = $filaProvinciaO[0];
				$nombreProvinciaO = $filaProvinciaO[1];				
	
				
				echo '<option value="'.$idProvinciaO.'" ';
				if ($idProvinciaO == $_REQUEST['provinciaOrigenActual']) echo 'selected="selected" ';
				echo '>'.$nombreProvinciaO.'</option>';
			};
					
			echo '</td> </tr>';
			
			
			/* Ciudad Origen */
			
			if (isset($_REQUEST['provinciaOrigenActual'])) {			
				echo '<tr> <td>';
				echo 'Ciudad Origen: <select name="ciudadOrigenActual" class="style2" id="ciudadOrigenActual">';
							
				$listaCiudadesO = database_query("select cad_id, cad_nombre from ciudad where cad_ron_id = ".$_REQUEST['provinciaOrigenActual']." order by cad_nombre");
			
				echo '<option value="0">(seleccione una ciudad)</option>';
			
				while (	$filaCiudadO = database_fetch_row($listaCiudadesO)) {
					$idCiudadO = $filaCiudadO[0];
					$nombreCiudadO = $filaCiudadO[1];
				
					echo '<option value="'.$idCiudadO.'" ';
					if ($idCiudadO == $_REQUEST['ciudadOrigenActual']) echo 'selected="selected" ';
					echo '>'.$nombreCiudadO.'</option>';
				};
					
				echo '</td> </tr>';
			};
			
			
			/* Provincia Destino*/
			echo '<tr> <td>';
			echo '<input type="hidden" id="provinciaDestinoAnterior" name="provinciaDestinoAnterior" value="'.$_REQUEST['provinciaDestinoActual'].'" />';
			if ($_REQUEST['provinciaDestinoActual'] != $_REQUEST['provinciaDestinoAnterior']) 
				$_REQUEST['ciudadDestinoActual'] = 0;
			echo 'Provincia Destino: <select name="provinciaDestinoActual" class="style2" id="provinciaDestinoActual">';
			$listaProvinciasD = database_query("select ron_id, ron_nombre from region where ron_pis_id = 1 order by ron_nombre");
									
			while (	$filaProvinciaD = database_fetch_row($listaProvinciasD)) {
				$idProvinciaD = $filaProvinciaD[0];
				$nombreProvinciaD = $filaProvinciaD[1];
				
				echo '<option value="'.$idProvinciaD.'" ';
				if ($idProvinciaD == $_REQUEST['provinciaDestinoActual']) echo 'selected="selected" ';
				echo '>'.$nombreProvinciaD.'</option>';
			};
					
			echo '</td> </tr>';
			
			/* Ciudad Destino */
			
			if (isset($_REQUEST['provinciaDestinoActual'])) {			
				echo '<tr> <td>';
				echo 'Ciudad Destino: <select name="ciudadDestinoActual" class="style2" id="ciudadDestinoActual">';
							
				$listaCiudadesD = database_query("select cad_id, cad_nombre from ciudad where cad_ron_id = ".$_REQUEST['provinciaDestinoActual']." order by cad_nombre");
			
				echo '<option value="0">(seleccione una ciudad)</option>';
				
				while (	$filaCiudadD = database_fetch_row($listaCiudadesD)) {
					$idCiudadD = $filaCiudadD[0];
					$nombreCiudadD = $filaCiudadD[1];
				
					echo '<option value="'.$idCiudadD.'" ';
					if ($idCiudadD == $_REQUEST['ciudadDestinoActual']) echo 'selected="selected" ';
					echo '>'.$nombreCiudadD.'</option>';
				};
					
				echo '</td> </tr>';
			};
				
			
						
			database_close($conexion);			
		?>			
                    </tr>
                  </table>                                      
                  
                  <input type="submit" name="Submit" value="Buscar">
                </div>					
             </form>

<table cellpadding="0" cellspacing="0" width="780">
		<?php
          
          	    $conexion=database_connect();          
                    /* Tramos para las ciudades */
                    
                    
		if (isset($_REQUEST['ciudadOrigenActual']) && isset($_REQUEST['ciudadDestinoActual'])) {			
				echo '<tr> <td>';
				echo 'Tramos Encontrados';
				echo '</td> </tr>';
							
				$listaTramos = database_query("select tra_id, tra_valorpeaje, tra_distancia
							from tramo
						  where tra_cad_id1 = ".$_REQUEST['ciudadOrigenActual']
						."and tra_cad_id2 = ".$_REQUEST['ciudadDestinoActual']
						."union
						  select tra_id, tra_valorpeaje, tra_distancia
						  from tramo
						  where tra_cad_id1 = ".$_REQUEST['ciudadDestinoActual']
						."and tra_cad_id2 = ".$_REQUEST['ciudadOrigenActual']);
			
				while (	$filaTramo = database_fetch_row($listaTramos)) {
					$idTramo = $filaTramo[0];
					$costoTramo = $filaTramo[1];
					$distanciaTramo = $filaTramo[2];
					echo '<tr> <td>';
																
					echo '<A href="agregartramo.php?idTramo='.$idTramo.'">Tramo #'.$idTramo.' - $ '.$costoTramo.' - '.$distanciaTramo.' Kms.</A>';
					echo '</td> </tr>';	
				};
					
				echo '</td> </tr>';
				echo '<tr> <td>';
				echo '<A href="agregartramo.php?idCiudad1='
					.$_REQUEST['ciudadOrigenActual']
					.'&idCiudad2='
					.$_REQUEST['ciudadDestinoActual']
					.'">Nuevo Tramo</A>';
				echo '</td> </tr>';
		} else echo 'Seleccione dos ciudades.';
		
                    ?>
                                      
                    </table>                                      
                    
            <p align="center">&nbsp; 
<?php 
include 'footer.php';
footer();
?>
          