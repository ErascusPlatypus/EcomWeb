
<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Retrieve product details by name
if (isset($_GET['name'])) {
    $name = '%' . $_GET['name'] . '%'; // Add wildcards to search for names that contain the provided string

    // Prepare and execute SQL query with LIKE operator
    $sql = "SELECT * FROM products WHERE name LIKE ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $name);
    $stmt->execute();
    $result = $stmt->get_result();

    // Check if any rows were returned
    if ($result->num_rows > 0) {
        // Fetch and return product details as JSON response
        $products = $result->fetch_all(MYSQLI_ASSOC); // Fetch all matching products
        echo json_encode($products);
    } else {
        // No matching product found
        echo json_encode(array("message" => "Product not found"));
    }
} else {
    // No product name provided
    echo json_encode(array("message" => "Product name not specified"));
}

// Close connection
$stmt->close();

?>
