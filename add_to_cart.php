<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";


$email = $_POST['email'];
$product_id = (int)$_POST['product_id'];


    $sql1="SELECT * FROM `allusers` WHERE email='$email'";
    $resultsearch1=mysqli_query($conn,$sql1);



    if($resultsearch1) {
    $row = mysqli_fetch_assoc($resultsearch1);
    $x_64 = $row['cart_item'];
    if($x_64 == null || $x_64 == "") {
        $arr = array();
        array_push($arr, $product_id);
        $array_up = base64_encode(serialize($arr));

        $sql="UPDATE `allusers` SET `cart_item`='$array_up' WHERE email='$email'";
            $resultsearch=mysqli_query($conn,$sql);

        if($resultsearch) {

                echo json_encode("done");
            }
        else {
            echo json_encode("notdone");
        }
    } else {
        $x = unserialize(base64_decode($x_64));
        array_push($x, $product_id);
        $array_up = base64_encode(serialize($x));

        $sql="UPDATE `allusers` SET `cart_item`='$array_up' WHERE email='$email'";
            $resultsearch=mysqli_query($conn,$sql);

        if($resultsearch) {

                echo json_encode("done");
            }
        else {
            echo json_encode("notdone");
        }

    }

    }


    $conn->close();


?>
