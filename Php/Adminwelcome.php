<?php
header("Content-Type: application/json");
$host = "localhost";
$username = "root";
$password = "";
$dbname = "collegehunt";

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

$data = json_decode(file_get_contents("php://input"), true);
$type = $conn->real_escape_string($data['type'] ?? '');
$action = $conn->real_escape_string($data['action'] ?? '');
$name = $conn->real_escape_string($data['name'] ?? '');

$table = ($type === "course") ? "Courses" : (($type === "location") ? "Locations" : "");

if ($table && !empty($action) && !empty($name)) {
    if ($action === "add") {
        $sql = "INSERT INTO $table (". ($type === "course" ? "course_name" : "location_name") .") VALUES ('$name')";
    } elseif ($action === "remove") {
        $sql = "DELETE FROM $table WHERE ". ($type === "course" ? "course_name" : "location_name") ."='$name'";
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid action"]);
        exit;
    }

    if ($conn->query($sql)) {
        echo json_encode(["status" => "success", "message" => ucfirst($type) . " " . $action . "ed successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Error: " . $conn->error]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request"]);
}

$conn->close();
?>
