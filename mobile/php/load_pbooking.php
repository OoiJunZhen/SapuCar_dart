<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$driver_id = $_POST['driver_id'];

$sqlloadpbooking = "SELECT table_booking.booking_id, table_passenger.passenger_id,
table_passenger.passenger_name, table_passenger.passenger_phoneNo, table_passenger.passenger_gender,
table_booking.booking_date, table_booking.booking_time, table_booking.booking_pickUp, 
table_booking.booking_dropOff, table_booking.booking_status FROM table_booking INNER JOIN table_passenger 
ON table_booking.passenger_email = table_passenger.passenger_email 
WHERE table_booking.driver_id = '$driver_id' 
ORDER BY booking_id DESC";

$result = $conn->query($sqlloadpbooking);
$number_of_result = $result->num_rows;
if ($result->num_rows > 0) {
    $bookings["bookings"] = array();
    while ($rows = $result->fetch_assoc()) {
        $bookinglist = array();
        $bookinglist['bookingID'] = $rows['booking_id'];
        $bookinglist['pID'] = $rows['passenger_id'];
        $bookinglist['passengerName'] = $rows['passenger_name'];
        $bookinglist['passengerPhone'] = $rows['passenger_phoneNo'];
        $bookinglist['passengerGender'] = $rows['passenger_gender'];
        $bookinglist['bookingDate'] = $rows['booking_date'];
        $bookinglist['bookingTime'] = $rows['booking_time'];
        $bookinglist['pickUp'] = $rows['booking_pickUp'];
        $bookinglist['dropOff'] = $rows['booking_dropOff'];
        $bookinglist['status'] = $rows['booking_status'];
        array_push($bookings["bookings"],$bookinglist);
    }
    $response = array('status' => 'success', 'data' => $bookings);
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