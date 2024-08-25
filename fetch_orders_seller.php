<?php
header("Access-Control-Allow-Origin: *");
require_once "dbUpload.php";

if(isset($_GET['email'])){
    $email = $_GET['email'];
}else{
   echo json_encode("Email not found");
   mysqli_close($conn);
   return ;
}

$fetch_query = "SELECT * FROM orders WHERE seller = '$email'";

$exe = mysqli_query($conn , $fetch_query);

if($exe){
    $orders = array();

    while($result = mysqli_fetch_assoc($exe)){
        $orders[] = $result;
    }
    echo json_encode(
        array(
            "success"=>true,
            "orderItemsRecords"=>$orders
        )
    );
}else{
    json_encode("Failed to execute");
}


mysqli_close($conn);
?>