<?php

include "creds.php";

$unique_id = $_POST["uniqueid"];
$pain_rating = $_POST["painrating"];
$current_time = $_POST["currenttime"];
$_medications = $_POST["medications"];
$_symptoms = $_POST["symptoms"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO HDB (uniqID, symptoms, medications, painscale, user_date)
VALUES ($unique_id, _symptoms, _medications, $pain_rating, $current_time)";

if ($conn->query($sql) === TRUE) {
    echo "Success";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();


?>