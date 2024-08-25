<?php

$email = $_POST['email'];
$user_password = $_POST['password'];


 $conn =  mysqli_connect("localhost", "Ecom_new1", "Visanka", "Ecom_new1");
//require_once 'dbUpload.php';


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


    $findexist = "SELECT * FROM delivery_services WHERE email = '$email' ";
    $resultsearch = mysqli_query($conn, $findexist);
    $data = mysqli_fetch_array($resultsearch);

    if($data[0] >= 1) {
        if($data[3] == $user_password) {
            echo json_encode("true");
        } else {
            echo json_encode("wrongPassword");
        }
    } else {
        echo json_encode($data);
        echo json_encode("noUser");
    }


    $conn->close();
?>
