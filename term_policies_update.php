
<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Receive data sent from Flutter app
$data = json_decode(file_get_contents("php://input"), true);

// Check if the data is not empty
if (!empty($data)) {
    // Check if there is an existing row in the table
    $sqlCheck = "SELECT COUNT(*) as count FROM terms_policies";
    $resultCheck = $conn->query($sqlCheck);

    if ($resultCheck && $resultCheck->fetch_assoc()['count'] > 0) {
        // Update existing row
        $sql = "UPDATE terms_policies SET
                    terms_of_use = ?,
                    privacy_policy = ?,
                    license = ?,
                    seller_policy = ?,
                    return_policy = ?
                WHERE id = 1";

        $stmt = $conn->prepare($sql);

        if (!$stmt) {
            die("Error: " . $conn->error);
        }

        // Bind parameters and execute the statement
        $stmt->bind_param("sssss", $data['terms_of_use'], $data['privacy_policy'], $data['license'], $data['seller_policy'], $data['return_policy']);
        $stmt->execute();
        $stmt->close();
    } else {
        // Insert new row
        $sql = "INSERT INTO terms_policies (terms_of_use, privacy_policy, license, seller_policy, return_policy)
                VALUES (?, ?, ?, ?, ?)";

        $stmt = $conn->prepare($sql);

        if (!$stmt) {
            die("Error: " . $conn->error);
        }

        // Bind parameters and execute the statement
        $stmt->bind_param("sssss", $data['terms_of_use'], $data['privacy_policy'], $data['license'], $data['seller_policy'], $data['return_policy']);
        $stmt->execute();
        $stmt->close();
    }
}

// Close the database connection
$conn->close();

?>
