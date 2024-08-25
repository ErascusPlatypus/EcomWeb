<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";

$userId = $_POST['userId'];
$productId = $_POST['productId'];
$productName = $_POST['productName'];
$productDescription = $_POST['productDescription'];
$productPrice = $_POST['productPrice'];
$pdImageUrl = $_POST['pdImageUrl'];
$sellerId = $_POST['sellerId'];
$userEmail = $_POST['userEmail'];


$sqlQuery = "INSERT INTO buy_now_table SET user_id = '$userId', product_id = '$productId', product_name = '$productName',product_description = '$productDescription', product_price = '$productPrice', pd_image_url = '$pdImageUrl',seller_id='$sellerId',user_email = '$userEmail'";




$resultOfQuery = mysqli_query($conn,$sqlQuery);



if($resultOfQuery)
{
    echo json_encode(array("success"=>true));
}
else
{
    echo json_encode(array("success"=>false));
}

 ?>
