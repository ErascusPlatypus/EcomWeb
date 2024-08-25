<?php
header("Access-Control-Allow-Origin: *");
    include "dbUpload.php";

    $image = (String)$_POST['imageurl'];
    //$Iname = $_POST['Iname'];
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $category = $_POST['category'];
    $email = $_POST['email'];
    $price1 = (float)$price;

    $sql2 = "SELECT * FROM allsellers WHERE id='{$_POST['sellerId']}'";
        $result2 = $conn->query($sql2);
        $response2 = array();
        if($result2->num_rows >0) {
        while($row2 = $result2->fetch_assoc()) {
                array_push($response2, $row2);
        }


        }

     if($response2[0]['isRestrict'] == 0) {
        $sql1 = "SELECT * FROM category WHERE category='".$category."'";
        $result = $conn->query($sql1);
        $response = array();
        if($result->num_rows >0) {
        while($row = $result->fetch_assoc()) {
                array_push($response, $row);
        }



        }
        $category_id = (int)$response[0]['cid'];
        $seller_id = (int)$response2[0]['id'];

        //$sql = "INSERT INTO 'products' ('imgurl', 'name', 'description', 'price', 'category_id', 'seller_id') VALUES ($image, $name, $description, '$price1', '$category_id', '$seller_id');";
        $sql4 = "INSERT INTO products (imgurl, name, description, price, category_id, seller_id) VALUES ('$image', '$name', '$description', '$price1', '$category_id', '$seller_id')";
        $result3 = $conn->query($sql4);
        if($result3) {
                echo json_encode("success");

        } else {
                echo json_encode("nosuccess");

        }
     } else {
        echo json_encode("restricted");
     }
        $conn->close();


?>
