<?php

class Conexion{

    public function conectar(){
        define('server','localhost');
        define('db','repuesto');
        define('user','root');
        define('psw','');

        $opc = array(PDO::MYSQL_ATTR_INIT_COMMAND> 'SET NAMES utf8');
        try {
            $con=new PDO("mysql:host=".server.";dbname=".db,user,psw,$opc);
            return $con;
        } catch (Exception $e) {
            die("Error en la conexion: ".$e->getMessage());
        }
        
        
    }

}


?>