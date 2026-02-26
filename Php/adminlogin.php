<?php
header("Content-Type: application/json");

// Include the database configuration file
include('config.php');

// Get the raw POST data
$data = json_decode(file_get_contents("php://input"), true);

// Check if email and password are provided
if (isset($data['email']) && isset($data['password'])) {
    $email = trim($data['email']);
    $password = trim($data['password']);

    // Validate email format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo json_encode(['message' => 'Invalid email format.']);
        exit;
    }

    // Prepare SQL query to check in admin table only
    $query = "SELECT * FROM admin WHERE email = ?";
    $stmt = $conn->prepare($query);

    if (!$stmt) {
        echo json_encode(['message' => 'Database error: Unable to prepare statement.']);
        exit;
    }

    $stmt->bind_param('s', $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $admin = $result->fetch_assoc();

    if ($admin) {
        // Compare password (plain text, not recommended for production)
        if ($password === $admin['password']) {
            echo json_encode([
                'message' => 'Login successful.',
                'isNewUser' => $admin['is_new_user'] == 1
            ]);
        } else {
            echo json_encode(['message' => 'Invalid password.']);
        }
    } else {
        echo json_encode(['message' => 'Admin not found.']);
    }

    $stmt->close();
} else {
    echo json_encode(['message' => 'Email and password are required.']);
}

$conn->close();
?>
