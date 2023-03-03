<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$name = addslashes($_POST['Pname']);
$password = sha1($_POST['Ppassword']);
$email = $_POST['Pemail'];
$phoneNo = $_POST['PphoneNo'];
$matricStaffNo = $_POST['PmatricStaffNo'];
$gender = $_POST['Pgender'];
$base64image = $_POST['image'];
$sqlinsert = "INSERT INTO `table_passenger`(`passenger_name`, `passenger_email`, `passenger_password`, `passenger_phoneNo`, `passenger_matricStaffNo`, `passenger_gender`) VALUES ('$name','$email','$password','$phoneNo','$matricStaffNo','$gender')";
if ($conn->query($sqlinsert) == TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    $decoded_string = base64_decode($base64image);
    $path = '../assets/Pimages/' . $filename . '.jpg';
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