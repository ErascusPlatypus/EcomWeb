<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";


$email = $_POST['email'];
$pid = (int) $_POST['pid'];
// $email = "example@email.com";

$sql = "SELECT * FROM `allusers` WHERE email='$email'";
$resultsearch = mysqli_query($conn, $sql);



if ($resultsearch) {
    $row = mysqli_fetch_assoc($resultsearch);
    $x = $row['cart_item'];
    $array = unserialize(base64_decode($x));
    if (($key = array_search($pid, $array)) !== false) {
        array_splice($array, $key, 1);
    }
    $x_64 = base64_encode(serialize($array));


    $sql1 = "UPDATE `allusers` SET `cart_item`='$x_64' WHERE email='$email'";
    $resultsearch1 = mysqli_query($conn, $sql1);

    if ($resultsearch1) {

        echo json_encode("done");
    } else {
        echo json_encode("notdone");
    }
}

$conn->close();



?>
