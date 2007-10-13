<?php

require('/var/www/include/carpooling_db.php');

include 'func_lib.php';

/* AR 2007-09-16 Si tenemos todos los datos, agregamos los datos a la BD. */
		
if ( verificar_post('idTramo') && verificar_post('idCiudad1') && verificar_post('valorPeaje') && verificar_post('distancia') ){
	$conexion=database_connect();
	$idTramo = $_REQUEST['idTramo'];
	$idCiudad1 = $_REQUEST['idCiudad1'];
	$idCiudad2 = $_REQUEST['idCiudad2'];
	$valorPeaje = $_REQUEST['valorPeaje'];
	$valorPeaje = str_replace (  ',', '.', $valorPeaje); /* Para que no falle el update.*/
	$distancia = $_REQUEST['distancia'];
	
	if ($_REQUEST['idTramo'] <= 0 ) {
		$resultado=database_query('			
			INSERT INTO tramo(
            		tra_id, tra_cad_id1, tra_cad_id2, tra_valorpeaje, tra_distancia)
    			select COALESCE(max(tra_id),0) + 1, '.$idCiudad1.', '.$idCiudad2.', '.$valorPeaje.', '.$distancia.' 
    			from tramo');
    	} else {
    		$resultado=database_query('			
			update tramo
			set 	tra_valorpeaje = '.$valorPeaje.',
				tra_distancia = '.$distancia.'
			where tra_id = '.$idTramo);		
	};
	database_close($conexion);			
	header("Location: consulta.php");
	exit();
};

include 'header.php';
carpooling_header("Agregar/Editar Tramo");
?>

          <form name="formEditarTramo" method="post" action="agregartramo.php">
                    <div align="center">
      
<table cellpadding="0" cellspacing="0" width="780">
		<?php
			$conexion=database_connect();
			$idTramo = $_REQUEST['idTramo'];
			$idCiudad1 = $_REQUEST['idCiudad1'];
			$idCiudad2 = $_REQUEST['idCiudad2'];
			$nombreCiudad1 = '';
			$nombreCiudad2 = '';
			$distancia = 0;
			$valorPeaje = 0;
	
			if ($idTramo > 0) {
				$listaTramos = database_query("
					select t.tra_id,
						t.tra_cad_id1,
						c1.cad_nombre as cad_nombre1,
						t.tra_cad_id2,
						c2.cad_nombre as cad_nombre2,
						t.tra_valorpeaje,
						t.tra_distancia
					from tramo t
					inner join ciudad c1
					on c1.cad_id = t.tra_cad_id1
					inner join ciudad c2
					on c2.cad_id = t.tra_cad_id2
					where t.tra_id = ".$idTramo);
				
				$filaTramo = database_fetch_row($listaTramos);
				$idCiudad1 = $filaTramo[1];				
				$nombreCiudad1 = $filaTramo[2];
				$idCiudad2 = $filaTramo[3];
				$nombreCiudad2 = $filaTramo[4];
				$valorPeaje = $filaTramo[5];
				$distancia = $filaTramo[6];												
			} else {
				/*No valido que idCiudad1 y idCiudad2 sean validos.*/
				$listaCiudad1 = database_query("
					select c.cad_nombre						
					from ciudad c					
					where c.cad_id = ".$idCiudad1);
					
				$filaCiudad1 = database_fetch_row($listaCiudad1);
				$nombreCiudad1 = $filaCiudad1[0];
				
				$listaCiudad2 = database_query("
					select c.cad_nombre						
					from ciudad c					
					where c.cad_id = ".$idCiudad2);
					
				$filaCiudad2 = database_fetch_row($listaCiudad2);
				$nombreCiudad2 = $filaCiudad2[0];
				$idTramo = 0;
			};
	
			database_close($conexion);								
			
			echo '<input type="hidden" id="idTramo" name="idTramo" value="'.$idTramo.'" />';
			echo '<input type="hidden" id="idCiudad1" name="idCiudad1" value="'.$idCiudad1.'" />';
			echo '<input type="hidden" id="idCiudad2" name="idCiudad2" value="'.$idCiudad2.'" />';
			
			echo '<tr> <td>';
			echo 'Ciudad Origen: '.$nombreCiudad1;
			echo '</td> </tr>';
			
			echo '<tr> <td>';
			echo 'Ciudad Destino: '.$nombreCiudad2;
			echo '</td> </tr>';
						
			echo '<tr> <td>';
			echo 'Valor Peaje <input name="valorPeaje" type="text" id="valorPeaje" value="'.$valorPeaje.'" tabindex="1" maxlength="10" />';
			echo '</td> </tr>';
			
			echo '<tr> <td>';
			echo 'Distancia <input name="distancia" type="text" id="distancia" value="'.$distancia.'" tabindex="1" maxlength="10" />';
			echo '</td> </tr>';					
		?>			                    
                  
                  <tr> <td>

<input type="submit" name="Submit" value="Grabar">                  
                  
                  
</td> </tr>

</table>                                      
                </div>					
             </form>                    
            <p align="center">&nbsp; 
<?php 
include 'footer.php';
footer();
?>
          