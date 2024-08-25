<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";

$email = $_POST['email'];
$password = $_POST['password'];


    $findexist="SELECT * from allusers where email='$email' AND password = '$password'";
    $resultsearch=mysqli_query($conn,$findexist);
    $data = mysqli_fetch_array($resultsearch);

    if($data != null && count($data) > 0) {
        echo json_encode(array("msg" => "Login Successfully", "auth" => true, "data" => $data));
    } else {
        echo json_encode(array("msg" => "Invalid User Name Or Password", "data" => [], "auth" => false));
    }


    $conn->close();
?>
