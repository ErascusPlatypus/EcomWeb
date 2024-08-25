<?php
header("Access-Control-Allow-Origin: *");

error_reporting(0);
$hostName = "localhost";
$userName= "Ecom_new";
$password = "Visanka";
$dbName = "Ecom_new";


$conn=mysqli_connect($hostName,$userName,$password,$dbName);

if(!$conn){
echo "Something Get Wrong";
}


$driverId = $_GET['driverId'];

$fetchOrderDataForSeller = "SELECT * FROM orders WHERE DriverId = '$driverId' ";

$resultOfFetchOrderDataForSeller = mysqli_query($conn,$fetchOrderDataForSeller);

if(!$resultOfFetchOrderDataForSeller){
	echo "Something got Wrong In mysqli_query";
}
else{

	if($row=mysqli_num_rows($resultOfFetchOrderDataForSeller)>0){
	$data=array();

	while ($row = mysqli_fetch_assoc($resultOfFetchOrderDataForSeller)) {

		$data[] = $row;
	}
	echo json_encode($data);
	}
}

 ?>
