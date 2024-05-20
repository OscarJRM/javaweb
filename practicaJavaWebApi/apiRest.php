<?php
header('Content-Type: application/json');
include ('consulta.php');

$opc=$_SERVER['REQUEST_METHOD'];
switch($opc){
    case 'GET';
    $NOM_REP = $_GET['NOM_REP'];
    $PAIS = $_GET['PAIS'];
    CRUDC::consultaRepuesto($NOM_REP, $PAIS);
    
}
?>