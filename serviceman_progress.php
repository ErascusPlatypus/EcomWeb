
<?php
header("Access-Control-Allow-Origin: *");
// Include database connection
include "dbUpload.php";

// Assuming seller_email is provided via POST method
$seller_email = $_POST['seller_email'];

// Prepare SQL query to fetch data

$sql = "SELECT * FROM `repair_booking` WHERE `seller` = '$seller_email'";
// $sql = "SELECT `user`, `seller`, `address`, `issue`, `date`, `time`, `mechanic_phone`, `serviceman_email`, `repair_time`, `serviceman_status`, `feedback` FROM `repair_booking` WHERE `seller` = '$seller_email'";

// Perform the query
$result = $conn->query($sql);

// Check if there are rows returned
if ($result->num_rows > 0) {
    // Initialize an empty array to store the results
    $data = array();

    // Fetch each row from the result set
    while ($row = $result->fetch_assoc()) {
        // Append the row to the data array
        $data[] = $row;
    }

    // Convert the data array to JSON format
    $json_data = json_encode($data);

    // Output the JSON data
    echo $json_data;
} else {
    // No rows found, output a message indicating no data
    echo json_encode(array('message' => 'No data found for the provided seller email.'));
}

// Close database connection
$conn->close();

?>
