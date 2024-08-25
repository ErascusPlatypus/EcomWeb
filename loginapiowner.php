<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

$email = $_POST['email'];
$password = $_POST['password'];
// $email = "sarxc1@k.com";
// $password = "12345678";

    $findexist = "SELECT id, shop_name, email, address, phone FROM allsellers WHERE email = '$email' AND password = '$password'";
    $resultsearch = mysqli_query($conn, $findexist);
    $data = mysqli_fetch_array($resultsearch);
    $conn->close();
    if($data != null && count($data) > 0) {
        echo json_encode(array("msg" => "Login Successfully", "auth" => true, "data" => $data));
    } else {
        echo json_encode(array("msg" => "Invalid User Name Or Password", "data" => [], "auth" => false));
    }
?>
