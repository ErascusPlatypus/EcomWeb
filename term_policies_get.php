
<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Fetch existing terms from the database
$sql = "SELECT * FROM terms_policies";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // Terms found, fetch and return them as JSON
  $row = $result->fetch_assoc();
  echo json_encode($row);
} else {
  // No terms found, return an empty JSON object
  echo "{}";
}


?>
