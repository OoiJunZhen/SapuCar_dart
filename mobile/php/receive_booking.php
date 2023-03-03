<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$bookingID = $_POST['bookingID'];
$statusBooking = $_POST['statusBooking'];
$sqlupdateBooking = "UPDATE `table_booking` SET `booking_status` = '$statusBooking' WHERE `booking_id` = '$bookingID'";
if ($conn->query($sqlupdateBooking) == TRUE) {
    $response = array('status' => 'success', 'data' => 'received');
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