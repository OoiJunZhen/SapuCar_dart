<?php
// if (!isset($_POST)) {
//     $response = array('status' => 'failed', 'data' => null);
//     sendJsonResponse($response);
//     die();
// }
// include_once("dbconnect.php");
// $results_per_page = 10;
// $pageno = (int)$_POST['pageno'];
// $search = $_POST['search'];

// $page_first_result = ($pageno - 1) * $results_per_page;

// $sqlloaddriver = "SELECT * FROM table_driver";
// $result = $conn->query($sqlloaddriver);
// $number_of_result = $result->num_rows;
// $number_of_page = ceil($number_of_result / $results_per_page);
// $sqlloaddriver = $sqlloaddriver . " LIMIT $page_first_result , $results_per_page";
// $result = $conn->query($sqlloaddriver);
// if ($result->num_rows > 0) {
//     $driver["driver"] = array();
//     while ($row = $result->fetch_assoc()) {
//         $driverlist = array();
//         $driverlist['id'] = $row['driver_id'];
//         $driverlist['name'] = $row['driver_name'];
//         $driverlist['ICno'] = $row['driver_ICno'];
//         $driverlist['email'] = $row['driver_email'];
//         $driverlist['phone'] = $row['driver_phoneNo'];
//         $driverlist['matricStaffNo'] = $row['driver_matricStaffNo'];
//         $driverlist['carModel'] = $row['driver_carModel'];
//         $driverlist['carPlateNo'] = $row['driver_carPlateNo'];
//         $driverlist['licenseNo'] = $row['driver_LicenseNo'];
//         $driverlist['stickerNo'] = $row['driver_stickerNo'];
//         $driverlist['gender'] = $row['driver_gender'];
//         array_push($driver["driver"],$driverlist);
//     }
//     $response = array('status' => 'success', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page", 'data' => $driver);
//     sendJsonResponse($response);
// } else {
//     $response = array('status' => 'failed', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page",'data' => null);
//     sendJsonResponse($response);
// }

// function sendJsonResponse($sentArray)
// {
//     header('Content-Type: application/json');
//     echo json_encode($sentArray);
// }

if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$results_per_page = 10;
$pageno = (int)$_POST['pageno'];
$search = $_POST['search'];

$page_first_result = ($pageno - 1) * $results_per_page;

$sqlloaddriverapp = "SELECT * FROM table_driver WHERE driver_status = 'approved' AND driver_name LIKE '%$search%'";
// "SELECT tbl_tutors.tutor_id, tbl_tutors.tutor_email, tbl_tutors.tutor_phone, tbl_tutors.tutor_name, tbl_tutors.tutor_description, tbl_tutors.tutor_datereg, 
// GROUP_CONCAT(tbl_subjects.subject_name ORDER BY tbl_subjects.subject_id ASC) FROM tbl_tutors
// INNER JOIN tbl_subjects ON tbl_tutors.tutor_id = tbl_subjects.tutor_id WHERE tbl_tutors.tutor_name LIKE '%$search%' GROUP BY tbl_tutors.tutor_id ASC";
$result = $conn->query($sqlloaddriverapp);
$number_of_result = $result->num_rows;
$number_of_page = ceil($number_of_result / $results_per_page);
$sqlloaddriverapp = $sqlloaddriverapp . " LIMIT $page_first_result , $results_per_page";
$result = $conn->query($sqlloaddriverapp);
if ($result->num_rows > 0) {
    $driverApp["driverApp"] = array();
    while ($row = $result->fetch_assoc()) {
        $driverApplist = array();
        $driverApplist['id'] = $row['driver_id'];
        $driverApplist['name'] = $row['driver_name'];
        $driverApplist['ICno'] = $row['driver_ICno'];
        $driverApplist['email'] = $row['driver_email'];
        $driverApplist['phone'] = $row['driver_phoneNo'];
        $driverApplist['matricStaffNo'] = $row['driver_matricStaffNo'];
        $driverApplist['carModel'] = $row['driver_carModel'];
        $driverApplist['carPlateNo'] = $row['driver_carPlateNo'];
        $driverApplist['licenseNo'] = $row['driver_LicenseNo'];
        $driverApplist['stickerNo'] = $row['driver_stickerNo'];
        $driverApplist['gender'] = $row['driver_gender'];
        array_push($driverApp["driverApp"],$driverApplist);
    }
    $response = array('status' => 'success', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page", 'data' => $driverApp);
    sendJsonResponse($response);
} else { 
    $response = array('status' => 'failed', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page",'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>