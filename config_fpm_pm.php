<?php
$confPath = "/etc/php/7.4/fpm/pool.d/www.conf";
var_dump($_ENV);
var_dump(getenv());
$lines = explode("\n", file_get_contents($confPath));
$newLines = "";
foreach($lines as $line) {
   if (substr($line, 0, 2) == "pm") {
	$components = explode("=", $line);
	$id = str_replace(" ", "", $components[0]);
	$id = str_replace("pm.", "pm_", $components[0]);
	$id = strtoupper($id);
	$id = str_replace(' ', '', $id);
	$line = $components[0] . " = " . getenv()['FPM_' . $id];
	echo "Edited: " . $id . " with value " . getenv()['FPM_' . $id] . " \n";
  }
  $newLines .= $line . "\n";
}
$newLines .= "clear_env=no\n";
file_put_contents($confPath, $newLines);
