<?php
 header("Access-Control-Allow-Origin: *");
// error_reporting(0);
//  $sname = "localhost";

// //$sname = "http://192.168.32.165";
// $uname = "Ecom_new";
// $password = "Visanka";
// $db_name = "Ecom_new";

// $connectNow = mysqli_connect($sname, $uname, $password, $db_name);

// if (!$connectNow) {
// 	echo "Connection failed!".$connectNow;
// 	echo  mysqli_connect_error();

// }
// include "dbUpload.php";

//     $sql="UPDATE orders SET driver_status='{$_GET['driverStatus']}' WHERE id = {$_GET['orderId']}";
//     $resultsearch=mysqli_query($connectNow,$sql);

//     if($resultsearch) {
//             echo json_encode(array(
//             	"success"=>true,

//             ));
//         }
//      else {
//         echo json_encode("notdone");
//     }


//     $conn->close();



// Include database connection file
include "dbUpload.php";

// Check if the request method is POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get orderId and driverStatus from POST data
    $orderId = $_POST['orderId'];
    $driverStatus = $_POST['driverStatus'];

    // Prepare and bind statement
    $stmt = $conn->prepare("UPDATE orders SET driver_status = ? WHERE id = ?");
    $stmt->bind_param("si", $driverStatus, $orderId);

    // Execute the statement
    if ($stmt->execute()) {
        // Update successful
        echo json_encode(array("success" => true, "message" => "Order status updated successfully."));
    } else {
        // Update failed
        echo json_encode(array("success" => false, "message" => "Failed to update order status."));
    }

    // Close statement
    $stmt->close();
} else {
    // Request method is not POST
    echo json_encode(array("success" => false, "message" => "Invalid request method."));
}



 ?>