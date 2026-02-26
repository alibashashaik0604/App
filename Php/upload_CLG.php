<?php
include 'config.php';
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method. Only POST allowed.']);
    exit;
}

$requiredFields = ['name', 'description1', 'description2', 'description3'];
$requiredFiles = ['image_logo', 'image1', 'image2', 'image3'];

foreach ($requiredFields as $field) {
    if (empty($_POST[$field])) {
        echo json_encode(['status' => 'error', 'message' => "Missing or empty field: $field"]);
        exit;
    }
}

foreach ($requiredFiles as $file) {
    if (!isset($_FILES[$file]) || $_FILES[$file]['error'] !== UPLOAD_ERR_OK) {
        echo json_encode(['status' => 'error', 'message' => "Missing or error in file: $file"]);
        exit;
    }
}

$uploadDir = 'uploads/';
if (!is_dir($uploadDir) && !mkdir($uploadDir, 0777, true)) {
    echo json_encode(['status' => 'error', 'message' => 'Failed to create upload directory.']);
    exit;
}

$base_url = "http://172.23.52.145/collegehunt/";

function saveImage($file, $uploadDir) {
    $cleanName = preg_replace("/[^A-Za-z0-9\.\-_]/", "", basename($file['name']));
    $filename = uniqid('img_', true) . '_' . $cleanName;
    $targetPath = $uploadDir . $filename;
    if (move_uploaded_file($file['tmp_name'], $targetPath)) {
        return $filename;
    }
    return null;
}

$image_logo = saveImage($_FILES['image_logo'], $uploadDir);
$image1 = saveImage($_FILES['image1'], $uploadDir);
$image2 = saveImage($_FILES['image2'], $uploadDir);
$image3 = saveImage($_FILES['image3'], $uploadDir);

if (!$image_logo || !$image1 || !$image2 || !$image3) {
    echo json_encode(['status' => 'error', 'message' => 'Failed to upload one or more images.']);
    exit;
}

$image_logo_url = $base_url . $uploadDir . $image_logo;
$image1_url = $base_url . $uploadDir . $image1;
$image2_url = $base_url . $uploadDir . $image2;
$image3_url = $base_url . $uploadDir . $image3;

$name = htmlspecialchars(trim($_POST['name']));
$description1 = htmlspecialchars(trim($_POST['description1']));
$description2 = htmlspecialchars(trim($_POST['description2']));
$description3 = htmlspecialchars(trim($_POST['description3']));

$stmt = $conn->prepare("INSERT INTO HyderabadIIIT (name, image_logo, image1, image2, image3, description1, description2, description3) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

if (!$stmt) {
    echo json_encode(['status' => 'error', 'message' => 'Prepare failed: ' . $conn->error]);
    exit;
}

$stmt->bind_param("ssssssss", $name, $image_logo_url, $image1_url, $image2_url, $image3_url, $description1, $description2, $description3);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Data and images uploaded successfully.']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Database error: ' . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
