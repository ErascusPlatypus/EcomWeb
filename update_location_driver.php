<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";

$lat = (double)$_POST['lat'];
$lng = (double)$_POST['lng'];
$email = $_POST['email'];


    $sql="UPDATE `alldrivers` SET `lat`='$lat',`lng`='$lng' WHERE email='$email'";
        $resultsearch=mysqli_query($conn,$sql);

    if($resultsearch) {

            echo json_encode("done");
        }
     else {
        echo json_encode("notdone");
    }


    $conn->close();
?>
