<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$driverAppID = $_POST['driverAppID'];
$statusApproved = $_POST['statusApproved'];
$sqlinsert = "UPDATE `table_driver` SET `driver_status` = '$statusApproved' WHERE `driver_id` = '$driverAppID'";
if ($conn->query($sqlinsert) == TRUE) {
    $response = array('status' => 'success', 'data' => 'approved');
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