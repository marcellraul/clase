<?php
include "db/parametros.php";

function permisos() {  
  if (isset($_SERVER['HTTP_ORIGIN'])){
    header('Access-Control-Allow-Origin:*'); 
    header("Access-Control-Allow-Credentials: true");
    header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS');
    header('Access-Control-Max-Age: 1000');
    header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token , Authorization');

  }  
  if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS'){
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))          
        header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS');
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token , Authorization');
    exit(0);
  }
}

permisos();
$conexion =  Conectar($db);
if ($_SERVER['REQUEST_METHOD'] == 'GET'){
    if (isset($_GET['id'])) {      
      $sql = $conexion->prepare("SELECT * FROM clase where id=:id");
      $sql->bindValue(':id', $_GET['id']);
      $sql->execute();
      header("HTTP/1.1 200 OK");
      echo json_encode($sql->fetch(PDO::FETCH_ASSOC));
      exit();
    }
    else{      
      $sql = $conexion->prepare("SELECT * FROM clase");
      $sql->execute();
      $sql->setFetchMode(PDO::FETCH_ASSOC);
      header("HTTP/1.1 200 OK");
      echo json_encode( $sql->fetchAll());
      exit();
    }
}
if ($_SERVER['REQUEST_METHOD'] == 'POST'){
    $input = $_POST;		
    $sql = "INSERT INTO clase (clase) VALUES (:clase)";		  
    $resultado = $conexion->prepare($sql);
    bindAllValues($resultado, $input);
    $resultado->execute();
    $id = $conexion->lastInsertId();
    if($id){
      $input['id'] = $id;
      header("HTTP/1.1 200 OK");
      echo json_encode($input);
      exit();
    }
}
if ($_SERVER['REQUEST_METHOD'] == 'PUT'){
    $input = $_GET;	
    $id = $input['id'];
    $campos = getParams($input);
    $sql = "UPDATE clase SET $campos WHERE id='$id'";
    $resultado = $conexion->prepare($sql);
    bindAllValues($resultado, $input);
    $resultado->execute();
    header("HTTP/1.1 200 OK");
    exit();
}
if ($_SERVER['REQUEST_METHOD'] == 'DELETE'){
  $id = $_GET['id'];
  $resultado = $conexion->prepare("DELETE FROM clase where id=:id");
  $resultado->bindValue(':id', $id);
  $resultado->execute();
  header("HTTP/1.1 200 OK");
  exit();
}
header("HTTP/1.1 400 Peticion HTTP inexistente");
?>