	<?php
header("Access-Control-Allow-Origin: *");

/*error_reporting(0);
$serverHost = "localhost";   //"http://192.168.32.165/";

//$user = "root";
//$password = "";
//$database = "ecom";

// $serverHost = "localhost";

//$sname = "http://192.168.32.165";
$user = "Ecom_new";
$password = "Visanka";
$database = "Ecom_new";

//$conn = mysqli_connect("localhost", "Ecom_new", "Visanka", "Ecom_new");
$connectNow = new mysqli($serverHost, $user, $password, $database);



//POST = send/save data to mysql db
//GET = retrieve/read data from mysql db

$userEmail = $_POST['email'];
$userPassword = $_POST['password'];

$sqlQuery = "SELECT * FROM alldrivers WHERE email = '$userEmail' AND password = '$userPassword'";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery->num_rows > 0) //allow user to login
{
    $userRecord = array();
    while($rowFound = $resultOfQuery->fetch_assoc())
    {
        $userRecord[] = $rowFound;
    }

    echo json_encode(
        array(
            "success"=>true,
            "userData"=>$userRecord[0],
        )
    );
}
else //Do NOT allow user to login
{
    echo json_encode(array("success"=>false));
}

?> */


include "dbUpload.php";

$email = $_POST['email'];
$password = $_POST['password'];


    $findexist="SELECT * from all_service_users where email='$email' AND password = '$password'";
    $resultsearch=mysqli_query($conn,$findexist);
    $data = mysqli_fetch_array($resultsearch);

    if($data != null && count($data) > 0) {
        echo json_encode(array("msg" => "Login Successfully", "auth" => true, "data" => $data));
    } else {
        echo json_encode(array("msg" => "Invalid User Name Or Password", "data" => [], "auth" => false));
    }


    $conn->close();
?>
