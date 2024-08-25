<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";

$image = (string)$_POST['imageurl'];
//$Iname = $_POST['Iname'];
$name = $_POST['name'];
$description = $_POST['description'];
$price = (float)$_POST['price'];
$category = $_POST['category'];
$email = $_POST['email'];
$deliver = $_POST['deliver'];




$sql1 = "SELECT * FROM category WHERE category='" . $category . "'";
$result = $conn->query($sql1);
$response = array();
if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
                array_push($response, $row);
        }
}
$category_id = (int)$response[0]['cid'];



$sql4 = "INSERT INTO `marketplace_products`(`image_url`, `name`, `description`, `price`, `category_id`, `user_email`, `deliver`) VALUES ('$image', '$name', '$description', '$price' , '$category_id', '$email', '$deliver')";
$result3 = $conn->query($sql4);
if ($result3) {
        echo json_encode("success");
} else {
        echo json_encode("nosuccess");
}

$conn->close();
