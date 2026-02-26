<?php
header('Content-Type: application/json');
require 'config.php'; // Make sure this contains $conn for DB connection

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['error' => 'Invalid request method. Use POST.']);
    exit;
}

// Check if fields exist
if (
    !isset($_POST['name']) || empty($_POST['name']) ||
    !isset($_POST['address']) || empty($_POST['address']) ||
    !isset($_POST['state']) || empty($_POST['state']) ||
    !isset($_FILES['image'])
) {
    echo json_encode(['error' => 'Missing name, address, state, or image']);
    exit;
}

// Upload image
$uploadDir = 'uploads/';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

$image = $_FILES['image'];
if ($image['error'] !== 0) {
    echo json_encode(['error' => 'Image upload error: ' . $image['error']]);
    exit;
}

$filename = uniqid() . '_' . basename($image['name']);
$targetPath = $uploadDir . $filename;

if (!move_uploaded_file($image['tmp_name'], $targetPath)) {
    echo json_encode(['error' => 'Failed to move uploaded file']);
    exit;
}

// Construct full URL for image
$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? "https" : "http";
$imageURL = $protocol . '://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['PHP_SELF']) . '/' . $targetPath;

// Sanitize inputs
$name = mysqli_real_escape_string($conn, $_POST['name']);
$address = mysqli_real_escape_string($conn, $_POST['address']);
$state = mysqli_real_escape_string($conn, $_POST['state']);

// Insert into `ts` table (Telangana)
$sql = "INSERT INTO ma (name, address, state, image_url) VALUES ('$name', '$address', '$state', '$imageURL')";
if (mysqli_query($conn, $sql)) {
    echo json_encode([
        'success' => true,
        'name' => $name,
        'address' => $address,
        'state' => $state,
        'image_url' => $imageURL
    ]);
} else {
    echo json_encode(['error' => 'Database error: ' . mysqli_error($conn)]);
}
?>
