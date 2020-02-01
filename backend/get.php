<?php

include "creds.php";

//open connection to mysql db
$connection = mysqli_connect($servername,$username,$password,"HDB") or die("Error " . mysqli_error($connection));

//fetch table rows from mysql db
$sql = "select * from HDB";
$result = mysqli_query($connection, $sql) or die("Error in Selecting " . mysqli_error($connection));

// Create new array so we can return the JSON 
$emparray = array();
while($row =mysqli_fetch_assoc($result))
{
$emparray[] = $row;
}
// echo out the content to the user
echo json_encode($emparray);

//close the db connection and free up process
mysqli_close($connection);
?>