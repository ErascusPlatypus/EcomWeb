<?php
header("Access-Control-Allow-Origin: *");

error_reporting(0);
 $sname = "localhost";
$uname = "Ecom_new";
$password = "Visanka";
$db_name = "Ecom_new";

$conn = mysqli_connect($sname, $uname, $password, $db_name);

if (!$conn) {
	echo "Connection failed!".$conn;
	echo  mysqli_connect_error();
	exit();
}



$currentUser = "SELECT * FROM buy_now_table ";

$resultOfQuery=mysqli_query($conn,$currentUser);

if(mysqli_num_rows($resultOfQuery)>0){
	$buyNowRecord[] = array();

	//to fatch all the data from buynowtabls
	$rowFound = mysqli_fetch_assoc($resultOfQuery);
		$buyNowRecord[] = $rowFound;

	echo json_encode(

		array(
			"success"=>true,
			"buyNowRecordData"=>$buyNowRecord,
		)
	);


	}
	else{
		echo json_encode(array("success"=>false));
	}



  ?>
