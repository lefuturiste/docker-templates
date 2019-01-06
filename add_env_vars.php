<?php

$originFile = '/app/.env.example';
$destinationWriteFile = '/etc/php/7.2/fpm/pool.d/www.conf';

if (file_exists($originFile)){

    $dotEnvDefinitionRow = file_get_contents($originFile);

    $dotEnvDefinitionLines = explode("\n", $dotEnvDefinitionRow);

    $lines = '';

    $envVariables = getenv();

    foreach ($dotEnvDefinitionLines as $line) {
        if (
            substr(str_replace(' ', '', $line), 0, 1) !== '#' &&
            $line !== ''
        ) {
            $key = explode('=', $line)[0];
            if (isset($envVariables[$key])) {
                $lines =  $lines . "\nenv[$key] = " . $envVariables[$key];
            }
        }
    }

    $lines = $lines . "\n";

    file_put_contents($destinationWriteFile, $lines, FILE_APPEND);
}
