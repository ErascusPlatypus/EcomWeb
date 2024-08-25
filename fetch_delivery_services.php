<?php
header("Access-Control-Allow-Origin: *");
require_once "dbUpload.php";

$query = "SELECT * FROM `delivery_services` WHERE `id` > 0";



$exe = mysqli_query($conn , $query);

if($exe){
    $services = array();

    while($result = mysqli_fetch_assoc($exe)){
        $services[] = $result;
    }
    echo json_encode($services);
}else{
    echo json_encode("Failed to fetch data");
}

mysqli_close($conn);

?>
