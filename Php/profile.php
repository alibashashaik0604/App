<?php
// Include database configuration
require_once 'config.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);

    $userId = $data['userId'] ?? '';
    $name = $data['name'] ?? '';
    $dob = $data['dob'] ?? '';
    $gender = $data['gender'] ?? '';
    $contact = $data['contact'] ?? '';
    $address = $data['address'] ?? '';
    $nationality = $data['nationality'] ?? '';
    $schoolName = $data['schoolName'] ?? '';
    $schoolYearPassed = $data['schoolYearPassed'] ?? '';
    $schoolGrade = $data['schoolGrade'] ?? '';
    $schoolLocation = $data['schoolLocation'] ?? '';
    $collegeName = $data['collegeName'] ?? '';
    $collegeDepartment = $data['collegeDepartment'] ?? '';
    $collegeYearPassed = $data['collegeYearPassed'] ?? '';
    $collegeGrade = $data['collegeGrade'] ?? '';
    $collegeLocation = $data['collegeLocation'] ?? '';

    if (empty($userId)) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'User ID is required.']);
        exit;
    }

    try {
        // Check if the profile exists
        $stmt = $pdo->prepare("SELECT * FROM user_profiles WHERE user_id = :userId");
        $stmt->execute([':userId' => $userId]);
        $profile = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($profile) {
            // Update existing profile
            $stmt = $pdo->prepare("
                UPDATE user_profiles
                SET name = :name, dob = :dob, gender = :gender, contact = :contact, address = :address,
                    nationality = :nationality, school_name = :schoolName, school_year_passed = :schoolYearPassed,
                    school_grade = :schoolGrade, school_location = :schoolLocation,
                    college_name = :collegeName, college_department = :collegeDepartment,
                    college_year_passed = :collegeYearPassed, college_grade = :collegeGrade,
                    college_location = :collegeLocation
                WHERE user_id = :userId
            ");
        } else {
            // Create a new profile
            $stmt = $pdo->prepare("
                INSERT INTO user_profiles (
                    user_id, name, dob, gender, contact, address, nationality, school_name,
                    school_year_passed, school_grade, school_location, college_name,
                    college_department, college_year_passed, college_grade, college_location
                ) VALUES (
                    :userId, :name, :dob, :gender, :contact, :address, :nationality, :schoolName,
                    :schoolYearPassed, :schoolGrade, :schoolLocation, :collegeName,
                    :collegeDepartment, :collegeYearPassed, :collegeGrade, :collegeLocation
                )
            ");
        }

        // Bind parameters and execute
        $stmt->execute([
            ':userId' => $userId,
            ':name' => $name,
            ':dob' => $dob,
            ':gender' => $gender,
            ':contact' => $contact,
            ':address' => $address,
            ':nationality' => $nationality,
            ':schoolName' => $schoolName,
            ':schoolYearPassed' => $schoolYearPassed,
            ':schoolGrade' => $schoolGrade,
            ':schoolLocation' => $schoolLocation,
            ':collegeName' => $collegeName,
            ':collegeDepartment' => $collegeDepartment,
            ':collegeYearPassed' => $collegeYearPassed,
            ':collegeGrade' => $collegeGrade,
            ':collegeLocation' => $collegeLocation,
        ]);

        http_response_code(200);
        echo json_encode(['success' => true, 'message' => $profile ? 'Profile updated successfully.' : 'Profile created successfully.']);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Database error.', 'error' => $e->getMessage()]);
    }
} else {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed.']);
}
?>
