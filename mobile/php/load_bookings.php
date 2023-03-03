<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$results_per_page = 10;
$passenger_email = $_POST['passenger_email'];

// $page_first_result = ($pageno - 1) * $results_per_page;

$sqlloadbooking = "SELECT table_booking.booking_id, table_driver.driver_id, table_driver.driver_name, 
table_driver.driver_email, table_driver.driver_phoneNo, table_driver.driver_gender,
table_driver.driver_carModel, table_driver.driver_carPlateNo,
table_booking.booking_date, table_booking.booking_time, table_booking.booking_pickUp, 
table_booking.booking_dropOff, table_booking.booking_status FROM table_booking INNER JOIN table_driver 
ON table_booking.driver_id = table_driver.driver_id 
WHERE table_booking.passenger_email = '$passenger_email' 
ORDER BY booking_id DESC";

$result = $conn->query($sqlloadbooking);
$number_of_result = $result->num_rows;
// $number_of_page = ceil($number_of_result / $results_per_page);
// $sqlloadbooking = $sqlloadbooking . " LIMIT $page_first_result , $results_per_page";
// $result = $conn->query($sqlloadbooking);
if ($result->num_rows > 0) {
    $bookings["bookings"] = array();
    while ($rows = $result->fetch_assoc()) {
        $bookinglist = array();
        $bookinglist['bookingID'] = $rows['booking_id'];
        $bookinglist['driverID'] = $rows['driver_id'];
        $bookinglist['driverName'] = $rows['driver_name'];
        $bookinglist['driverEmail'] = $rows['driver_email'];
        $bookinglist['driverPhone'] = $rows['driver_phoneNo'];
        $bookinglist['gender'] = $rows['driver_gender'];
        $bookinglist['carModel'] = $rows['driver_carModel'];
        $bookinglist['carPlateNo'] = $rows['driver_carPlateNo'];
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