<?php
header("Access-Control-Allow-Origin: *");

require_once "dbUpload.php";


if (isset($_POST['user_email']) && isset($_POST['name']) && isset($_POST['price']) && isset($_POST['seller_id'])) {
    $seller_id = $_POST['seller_id'];
    $query_seller = "SELECT * FROM allsellers WHERE id = '$seller_id'";
    $exe_seller = mysqli_query($conn, $query_seller);
    if ($exe_seller) {
        $result_seller = mysqli_fetch_assoc($exe_seller);
        // echo json_encode($result_seller);
        // echo json_encode($result_seller['email']);
        $seller = $result_seller['email'];
        $shop_name = $result_seller['shop_name'];
        $seller_phone = $result_seller['phone'];
        $shop_lat = $result_seller['lat'];
        $shop_lng = $result_seller['lng'];
        $shop_address = $result_seller['address'];



        $product_name = $_POST['name'];
        $user = $_POST['user_email'];






        $user_lat = "25.7447";
        $user_lng = "85.0138";
        $user_address = $_POST["user address"];
        $total_amount = $_POST['price'];
        $product_image = $_POST['product_image'];
        $driver_id = "1";
        $order_date = date("Y-m-d");
        $cash_on_delivery = $_POST['cash_on_delivery'];
        $query = "INSERT INTO `orders`( `product_name`, `user`, `seller`, `shop_name`, `seller_phone`, `shop_lat`, `shop_lng`, `shop_address`, `user_lat`, `user_lng`, `user_address`, `total_amount`, `driver_id`, `order_date`, `product_image`, `cash_on_delivery`,`seller_id`) VALUES ('$product_name','$user','$seller','$shop_name','$seller_phone','$shop_lat','$shop_lng','$shop_address','$user_lat','$user_lng','$user_address','$total_amount','$driver_id','$order_date','$product_image','$cash_on_delivery','$seller_id')";


        //  $query = "INSERT INTO `orders`(`product_name`, `user`, `seller`, `shop_name`, `user_phone`, `seller_phone`, `shop_lat`, `shop_lng`, `shop_address`, `user_lat`, `user_lng`, `user_address`, `total_amount`, `driver_id`,)
        //                        VALUES ('$product_name','$user','$seller','$shop_name','$user_phone','$seller_phone','$shop_lat','$shop_lng','$shop_address','$user_lat','$user_lng','$user_address','$total_amount','$driver_id')";

        $exe = mysqli_query($conn, $query);

        if ($exe) {
            $result["success"] = "1";
            $result["message"] = "Order placed successfully";
            echo json_encode($result);
        } else {
            echo json_encode("failed to place order") . mysqli_error($conn);
        }
    }
} else {

    echo json_encode("Parameters not found") . isset($_POST['user_email']) . isset($_POST['name']) . isset($_POST['price']) . isset($_POST['seller_id']);
    return;
}



mysqli_close($conn);

?>
