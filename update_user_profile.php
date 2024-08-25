<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";


    $sql="UPDATE `allusers` SET `image_url`='{$_POST['url']}' WHERE id = {$_POST['userId']}";
    $resultsearch=mysqli_query($conn,$sql);
    if($resultsearch) {
            echo json_encode("done");
        }
     else {
        echo json_encode("notdone");
    }


    $conn->close();
