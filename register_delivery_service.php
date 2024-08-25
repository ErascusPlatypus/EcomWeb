<?php
header("Access-Control-Allow-Origin: *");

$service_name = $_POST['service_name'];
$email = $_POST['email'];
$user_password = $_POST['password'];
$area = $_POST['area'];
$transport = $_POST['transport'];

require_once "dbUpload.php";

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$findexist = "SELECT * from delivery_services where email='$email'";
$resultsearch = mysqli_query($conn, $findexist);
if (mysqli_num_rows($resultsearch) > 0) {
    while ($row = mysqli_fetch_array($resultsearch)) {
        $result["success"] = "3";
        $result["message"] = "user Already exist";
        echo json_encode($result);
        mysqli_close($conn);
    }
} else {
    $sql = "INSERT INTO `delivery_services`(`service_name`, `email`, `password`, `area`, `transport`)
                                    VALUES ('$service_name','$email','$user_password','$area','$transport')";
    if (mysqli_query($conn, $sql)) {
        $result["success"] = "1";
        $result["message"] = "Registration success";
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
