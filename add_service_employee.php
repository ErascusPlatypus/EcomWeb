<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = $_POST['password'];
$sellerId = $_POST['seller_id'];
$serviceId = $_POST['service_id'];

$isExist = "SELECT * from all_service_users where email='$email'";
$resultSearch = mysqli_query($conn, $isExist);
if (mysqli_num_rows($resultSearch) > 0) {
    $result["success"] = "3";
    $result["message"] = "user Already exist";
    echo (json_encode($result));
    mysqli_close($conn);
    // echo (json_encode($result));

} else {
    $sql = "INSERT INTO `all_service_users`( `seller_id`, `service_id`, `name`, `phone`, `email`, `password`) VALUES ('$sellerId','$serviceId','$name','$phone','$email', '$password')";
    $resultSearch1 = mysqli_query($conn, $sql);
    if ($resultSearch1) {
        $result["success"] = "1";
        $result["message"] = "Serviceman registration is successful";
        echo json_encode($result);
        mysqli_close($conn);
    } else {
        $result["success"] = "0";
        $result["message"] = "error in Registration";
        echo json_encode($result);
        mysqli_close($conn);
    }
}
?>