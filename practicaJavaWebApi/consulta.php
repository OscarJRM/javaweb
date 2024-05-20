<?php

include ("conexion.php");
class CRUDC {
    public static function consultaRepuesto($repuesto,$pais){
        $conexion = new Conexion();
        $con = $conexion->conectar();
        header('Content-Type: application/json');

        $sql= "SELECT R.NOM_REP, R.CAN_REP, R.PRE_REP, B.PAIS
        FROM repuesto AS R
        JOIN 
        bodega AS B ON R.ID_BOD = B.ID_BOD
        WHERE
        R.NOM_REP LIKE '%$repuesto%' AND B.PAIS = '$pais';";

        $stm = $con->prepare($sql);
        $stm->execute();
        $repuestos =$stm->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode($repuestos);
    }


}


?>