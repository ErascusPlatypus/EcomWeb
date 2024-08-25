<?php
header("Access-Control-Allow-Origin: *");

$email = $_POST['email'];

// Create connection
$conn = mysqli_connect("localhost", "Ecom_new", "Visanka", "Ecom_new");

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$findexist = "SELECT * FROM allsellers WHERE email = '$email' ";
$resultsearch = mysqli_query($conn, $findexist);
$data = mysqli_fetch_array($resultsearch);

if ($data) {
    $response = array(
        "success" => true,
        "message" => "User found",
        "data" => ["email" => $data[2], "shop_name" => $data[1], "phone" => $data[7], "address" => $data[6], "gst" => $data[9], "is_third_party" => $data[11], "service_type" => $data[12], "service_locations" => $data[13]]
    );
    echo json_encode($response);
} else {
    $response = array(
        "success" => false,
        "message" => "No user found"
    );
    echo json_encode($response);
}


$conn->close();
?>
