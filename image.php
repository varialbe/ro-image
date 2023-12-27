<?php
// Place this into the wanted server directory.
if(isset($_GET['url'])) {
    $url = $_GET['url'];
  
    if(filter_var($url, FILTER_VALIDATE_URL) === FALSE) {
        die('Not a valid URL');
    }

    $imageContent = file_get_contents($url);
  
    $image = imagecreatefromstring($imageContent);
    if (!$image) {
        die('Unable to create image from URL');
    }

    $width = imagesx($image);
    $height = imagesy($image);

    $format = pathinfo($url, PATHINFO_EXTENSION);

    $result = [[$format, $width, $height]];
  
    for($y = 0; $y < $height; $y++) {
        for($x = 0; $x < $width; $x++) {
            $rgb = imagecolorat($image, $x, $y);
            $colors = imagecolorsforindex($image, $rgb);
            $result[] = [$colors["red"], $colors["green"], $colors["blue"]];
        }
    }

    imagedestroy($image);

    echo json_encode($result);
} else {
    echo "No URL provided";
}
?>
