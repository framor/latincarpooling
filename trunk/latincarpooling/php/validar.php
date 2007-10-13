<?Php
Function validar_sesion(){
        session_start();
	if ($_SESSION["autentificado"] != "SI") {
	    header("Location: login.php");
	    exit();
	} 
}

?>
