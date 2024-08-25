<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";

$email = $_POST['email'];
$restrict = (int)$_POST['restrict'];
// $email = "example@email.com";
// $password = "12345678";


// echo json_encode($email);
// echo json_encode($password);
    $sql="UPDATE allsellers SET isRestrict=$restrict where email='".$email."'";
        $resultsearch=mysqli_query($conn,$sql);


    // echo json_encode($data[0]);
    // echo json_encode($data[1]);

    if($resultsearch) {

            echo json_encode("done");
        }
     else {
        echo json_encode("notdone");
    }

    $conn->close();

?>
