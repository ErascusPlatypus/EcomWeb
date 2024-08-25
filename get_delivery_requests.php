<?php
header("Access-Control-Allow-Origin: *");
require_once "dbUpload.php";

if(isset($_POST['email'])){
    $email = $_POST['email'];
    $get_id = "SELECT id FROM delivery_services WHERE email = '$email'";
    $exe_get_id = mysqli_query($conn , $get_id);
    if($exe_get_id){
        $id_data = mysqli_fetch_assoc($exe_get_id);
        $id = $id_data['id'];
    }
}else{
    echo json_encode("Invalid request");
    mysqli_close($conn);
    return ;
}

$query = "SELECT * FROM alldeliveries WHERE delivery_service_id = '$id' ";

$exe = mysqli_query($conn , $query);

if($exe){
    $deliveries = array();

    while($result = mysqli_fetch_assoc($exe)){
        $deliveries[] = $result;
    }
    echo json_encode($deliveries);
}else{
    json_encode("Failed to execute");
}


mysqli_close($conn);

?>
