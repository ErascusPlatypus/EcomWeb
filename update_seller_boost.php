<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $pid = $_POST['pid'];
    $sellerBoost = $_POST['sellerBoost'];

    $sql = "UPDATE boosted_products SET boost = '$sellerBoost' WHERE pid = '$pid'";

    $resultOfQuery = mysqli_query($conn,$sqlQuery);

    if ($resultOfQuery) {
        echo "success";
    } else {
        echo "error";
    }

    $conn->close();
}
?>
