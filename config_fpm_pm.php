<?php
$confPath = "/etc/php/7.3/fpm/pool.d/www.conf";
$lines = explode("\n", file_get_contents($confPath));
$newLines = "";
foreach($lines as $line) {
   if (substr($line, 0, 2) == "pm") {
	$components = explode("=", $line);
	$id = str_replace(" ", "", $components[0]);
	$id = str_replace("pm.", "pm_", $components[0]);
	$id = strtoupper($id);
	$line = $components[0] . " = " . getenv('FPM_' . $id);
	echo "Edited: " . $id . " \n";
  }
  $newLines .= $line . "\n";
}

file_put_contents($confPath, $newLines);