<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$driverID = $_POST['driverID'];
$passengerEmail = $_POST['passengerEmail'];
$date = $_POST['date'];
$time = $_POST['time'];
$pickUp = $_POST['pickUp'];
$dropOff = $_POST['dropOff'];
$bookingStatus = $_POST['bookingStatus'];

$sqlcreateBooking = "INSERT INTO `table_booking`(`driver_id`, `passenger_email`, `booking_date`, `booking_time`, `booking_pickUp`, `booking_dropOff`, `booking_status`) VALUES ('$driverID','$passengerEmail','$date','$time','$pickUp','$dropOff','$bookingStatus')";
if ($conn->query($sqlcreateBooking) == TRUE) {
    $response = array('status' => 'success', 'data' => null);
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