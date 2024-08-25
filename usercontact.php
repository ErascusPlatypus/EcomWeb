<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";
$email = $_POST['email'];
$name = $_POST['name'];
$phone = strtoupper($_POST['phone']);


    $findexist="SELECT * FROM `user_contacts` where email='$email'";
        $resultsearch=mysqli_query($conn,$findexist);
    if(mysqli_num_rows($resultsearch)>0)
    {
           while($row=mysqli_fetch_array($resultsearch))
          {
              $result["success"] = "3";
              $result["message"] = "user Already exist";
              echo json_encode($result);
              mysqli_close($conn);
          }
  }

else{
    $arr = array();
    $arr1 = base64_encode(serialize($arr));
    $sql = "INSERT INTO `user_contacts` (email, name, phone) VALUES ('$email', '$name', '$phone');";

    $add = 50;

    if ( mysqli_query($conn, $sql) ) {
        $result["success"] = "1";
        $result["message"] = "Registration success";
        echo json_encode($result);
        mysqli_close($conn);
    } else {
        $result["success"] = "0";
        $result["message"] = "error in Registration";
        echo json_encode($result);
        mysqli_close($conn);
    }
}

?>
