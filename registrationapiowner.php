<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";
$email = $_POST['email'];
$password = $_POST['password'];
$lat = (double) $_POST['lat'];
$lng = (double) $_POST['lng'];
$address = $_POST['address'];
$phone = $_POST['phone'];
$shop_name = $_POST['shop_name'];
$gst = $_POST['gst'];
$is_third_party = $_POST['is_third_party'];
$service_type = $_POST['service_type'];
$service_locations = $_POST['service_locations'];

$zero = 0;

// Create connection
/*$conn = new mysqli("localhost:8000", "root", "", "ecom");
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} */
// Convert the service_locations array to a JSON string
$service_locations_json = json_encode($service_locations);



$findexist = "SELECT * from allsellers where email='$email'";
$resultsearch = mysqli_query($conn, $findexist);
if (mysqli_num_rows($resultsearch) > 0) {
    while ($row = mysqli_fetch_array($resultsearch)) {
        $result["success"] = "3";
        $result["message"] = "user Already exist";
        echo json_encode($result);
        mysqli_close($conn);
    }
} else {
    $sql = "INSERT INTO allsellers (shop_name, email, password, lat, lng, address, phone, gst, isRestrict, is_third_party, service_type, service_locations) VALUES ('$shop_name', '$email', '$password', '$lat', '$lng', '$address', '$phone', '$gst', '$zero','$is_third_party', '$service_type', $service_locations_json);";
    $query=mysqli_query($conn, $sql);

    if ($query) {
        $result["success"] = "1";
        $result["message"] = "Registration success";
        echo json_encode($result);
        mysqli_close($conn);
    } else {
        $result["success"] = "0";
        $result["message"] = "error in Registration".mysqli_error($conn);
        echo json_encode($result);
        mysqli_close($conn);
    }
}




?>
