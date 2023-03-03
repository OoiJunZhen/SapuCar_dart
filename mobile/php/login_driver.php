<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);
$sqllogin = "SELECT * FROM table_driver WHERE driver_email = '$email' AND driver_password = '$password' AND driver_status = 'approved'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows;

if ($numrow > 0) {
    while ($row = $result->fetch_assoc()) {
        $driver['id'] = $row['driver_id'];
        $driver['email'] = $row['driver_email'];
        $driver['name'] = $row['driver_name'];
        $driver['ICno'] = $row['driver_ICno'];
        $driver['matricStaffNo'] = $row['driver_matricStaffNo'];
        $driver['phoneNo'] = $row['driver_phoneNo'];
        $driver['carModel'] = $row['driver_carModel'];
        $driver['carPlateNo'] = $row['driver_carPlateNo'];
        $driver['licenseNo'] = $row['driver_LicenseNo'];
        $driver['stickerNo'] = $row['driver_stickerNo'];
        $driver['gender'] = $row['driver_gender'];
    }

    $response = array('status' => 'success', 'data' => $driver);
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