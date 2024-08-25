<?php
header("Access-Control-Allow-Origin: *");

require_once "dbUpload.php";

if(isset($_POST['id'])){
    $id = $_POST['id'];
}else{
    echo json_encode("Id not received");
    mysqli_close($conn);
    return ;
}

$fetch_query = "SELECT * FROM orders WHERE id = '$id'";

$exe = mysqli_query($conn , $fetch_query);

if($exe){
    $result = mysqli_fetch_assoc($exe);
    echo json_encode($result);
}

?>
