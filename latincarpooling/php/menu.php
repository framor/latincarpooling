<?Php

function menu(){
echo '<div id="mainmenu">
</div>
<br><br><br><br>
Hola '; 
echo $_SESSION["nombreusuario"];
echo '
<div id="wrap">

<div id="leftside">
<a class="nav" href="buscarviaje.php">Viajes</a><span class="hide"> | </span>
<a class="nav sub" href="buscarviaje.php">Buscar</a><span class="hide"> | </span>
<a class="nav sub" href="ingresarviaje.php">Nuevo</a><span class="hide"> | </span>
<a class="nav sub" href="listarviajeconductor.php">Mis Viajes</a><span class="hide"> | </span>
<a class="nav" href="#">Pedidos</a><span class="hide"> | </span>
<a class="nav sub" href="ingresarPedido.php">Nuevo</a><span class="hide"> | </span>
<a class="nav sub" href="listarviajepasajero.php">Mis Pedidos</a><span class="hide"> | </span>
<a class="nav" href="#">Mis Mensajes</a><span class="hide"> | </span>
<a class="nav sub" href="listarmensajes.php?tipo=recibidos">Recibidos</a><span class="hide"> | </span>
<a class="nav sub" href="listarmensajes.php?tipo=enviados">Enviados</a><span class="hide"> | </span>
<a class="nav" href="login.php?accion=salir">Salir</a><span class="hide"> | </span>


</div>

<div id="rightside">
<h1> <u>Carpooling</u>
</h1>
<p> <strong>�Qu� es �Carpooling� o viajar en grupo?</strong><br><br>
La definici�n b�sica es cuando dos o m�s personas viajan juntas en el mismo veh�culo. �Qu� puede significar para usted? �Menos gastos!

<br><br><strong>�C�mo es que se ahorra?</strong><br><br>
Unase a por lo menos otra persona para ir al trabajo y reduzca sus gastos de viaje. Mientras m�s personas tenga en su �carpool�, m�s bajos ser�n sus gastos. Ahorre dinero al dividir los costos entre las personas que viajan juntas o rotando las responsabilidades cada semana o dos. Recuerde: Usted puede comenzar tratando este sistema s�lo unos d�as a la semana.

<br><br><strong>Piense en los beneficios:</strong><br><br>
� Menos gastos de viaje (para calcular cuanto se gasta viajando al trabajo en estos momentos, utilice la calculadora)<br>
� Inscripci�n GRATIS en el Programa de Emergencia para Ir a Casa.<br>
� Viajar en grupo le permite usar la l�nea HOV, lo cual reduce el tiempo que usted emplea viajando al trabajo.<br>
� Menos autos en la carretera reduce la contaminacion y la congesti�n.<br>

<br><br><strong>�Comience hoy!</strong><br><br>
  

</div>
';
};

?>
