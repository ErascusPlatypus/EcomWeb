<?php
header("Access-Control-Allow-Origin: *");

    include "dbUpload.php";

    $image = (String)$_POST['imageurl'];
    $pid = $_POST['pid'];
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $category = $_POST['category'];
    $price1 = (float)$price;
    $sql = "SELECT * FROM category WHERE category='".$category."'";
    $result = mysqli_query($conn, $sql);
    $response = mysqli_fetch_assoc($result);
    $category_id = (int)$response['cid'];

    $sql1="UPDATE `products` SET `name`='$name' WHERE pid = '$pid'";
    $sql2="UPDATE `products` SET `description`='$description' WHERE pid = '$pid'";
    $sql3="UPDATE `products` SET `price`='$price' WHERE pid = '$pid'";
    $sql4="UPDATE `products` SET `category_id`='$category_id' WHERE pid = '$pid'";
    $sql5="UPDATE `products` SET `imgurl`='$image' WHERE pid = '$pid'";
    $result1=mysqli_query($conn, $sql1);
    $result2=mysqli_query($conn, $sql2);
    $result3=mysqli_query($conn, $sql3);
    $result4=mysqli_query($conn, $sql4);
    $result5=mysqli_query($conn, $sql5);
    if($result1 && $result2 && $result3 && $result4 && $result5) {
        echo json_encode("success");
        }
     else {
        echo json_encode("nosuccess");
    }


    $conn->close();
