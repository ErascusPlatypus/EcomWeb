<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";


$email = $_POST['email'];
// $email = "example@email.com";



$sql = "SELECT * FROM `allusers` WHERE email='$email'";
$resultsearch = mysqli_query($conn, $sql);



if ($resultsearch) {
    $row = mysqli_fetch_assoc($resultsearch);
    $x_64 = $row['cart_item'];
    $x = unserialize(base64_decode($x_64));
    $response = array();
    $cnt = count($x);

    $i = 0;
    for ($i = 0; $i < $cnt; $i++) {
        $y = $x[$i];
        $sql2 = "SELECT * FROM `products` WHERE pid='$y'";
        $result = mysqli_query($conn, $sql2);
        if ($result) {

            while ($row1 = $result->fetch_assoc()) {
                array_push($response, $row1);
            }


        }


    }




}

$conn->close();
echo json_encode($response);

?>
