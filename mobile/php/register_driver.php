<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$name = addslashes($_POST['name']);
$password = sha1($_POST['password']);
$email = $_POST['email'];
$phoneNo = $_POST['phoneNo'];
$matricStaffNo = $_POST['matricStaffNo'];
$ICno = $_POST['ICno'];
$carModel = $_POST['carModel'];
$carPlateNo = $_POST['carPlateNo'];
$licenseNo = $_POST['licenseNo'];
$stickerNo = $_POST['stickerNo'];
$gender = $_POST['gender'];
$base64image = $_POST['image'];
$sqlinsert = "INSERT INTO `table_driver`(`driver_email`, `driver_password`, `driver_name`, `driver_ICno`, `driver_matricStaffNo`, `driver_phoneNo`, `driver_carModel`, `driver_carPlateNo`, `driver_LicenseNo`, `driver_stickerNo`, `driver_gender`) VALUES ('$email','$password','$name','$ICno','$matricStaffNo','$phoneNo','$carModel','$carPlateNo','$licenseNo','$stickerNo','$gender')";
if ($conn->query($sqlinsert) == TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    $decoded_string = base64_decode($base64image);
    $path = '../assets/Dimages/' . $filename . '.jpg';
    $is_written = file_put_contents($path, $decoded_string);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>