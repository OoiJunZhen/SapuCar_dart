<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);
$sqllogin = "SELECT * FROM table_passenger WHERE passenger_email = '$email' AND passenger_password = '$password'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows;

if ($numrow > 0) {
    while ($row = $result->fetch_assoc()) {
        $passenger['id'] = $row['passenger_id'];
        $passenger['name'] = $row['passenger_name'];
        $passenger['email'] = $row['passenger_email'];
        $passenger['phoneNo'] = $row['passenger_phoneNo'];
        $passenger['matricStaffNo'] = $row['passenger_matricStaffNo'];
        $passenger['gender'] = $row['passenger_gender'];
    }

    $response = array('status' => 'success', 'data' => $passenger);
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