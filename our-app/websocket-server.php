<?php

error_reporting(E_ALL);
set_time_limit(0);
ob_implicit_flush();

$address = '0.0.0.0';
$port = 8080;

// Create TCP/IP stream socket
$sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
if ($sock === false) {
    echo "socket_create() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
}

echo "WebSocket server started\n";

socket_set_option($sock, SOL_SOCKET, SO_REUSEADDR, 1);

if (socket_bind($sock, $address, $port) === false) {
    echo "socket_bind() failed: reason: " . socket_strerror(socket_last_error($sock)) . "\n";
}

if (socket_listen($sock, 5) === false) {
    echo "socket_listen() failed: reason: " . socket_strerror(socket_last_error($sock)) . "\n";
}

$clients = array($sock);

while (true) {
    $read = $clients;
    if (socket_select($read, $write, $except, null) === false) {
        echo "socket_select() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
        break;
    }

    foreach ($read as $read_sock) {
        if ($read_sock === $sock) {
            // Accept a new client connection
            $new_sock = socket_accept($sock);
            if ($new_sock === false) {
                echo "socket_accept() failed: reason: " . socket_strerror(socket_last_error($sock)) . "\n";
            } else {
                $clients[] = $new_sock;
                $header = socket_read($new_sock, 1024);
                perform_handshaking($header, $new_sock, $address, $port);
            }
        } else {
            // Handle data from an existing client
            $data = socket_read($read_sock, 1024);
            if ($data === false) {
                $key = array_search($read_sock, $clients);
                unset($clients[$key]);
                socket_close($read_sock);
            } else {
                $message = unmask($data);
                echo "Received message: $message\n";
            }
        }
    }
}

socket_close($sock);

function perform_handshaking($receved_header, $client_conn, $host, $port) {
    $headers = array();
    $lines = preg_split("/\r\n/", $receved_header);
    foreach ($lines as $line) {
        $line = chop($line);
        if (preg_match('/\A(\S+): (.*)\z/', $line, $matches)) {
            $headers[$matches[1]] = $matches[2];
        }
    }

    // $secKey = $headers['Sec-WebSocket-Key'];
    // $secAccept = base64_encode(pack('H*', sha1($secKey . '258EAFA5-E914-47DA-95CA-C5AB0DC85B11')));
    $upgrade = "HTTP/1.1 101 Web Socket Protocol Handshake\r\n" .
               "Upgrade: websocket\r\n" .
               "Connection: Upgrade\r\n" ;
               //"Sec-WebSocket-Accept: $secAccept\r\n\r\n";
    socket_write($client_conn, $upgrade, strlen($upgrade));
}

function unmask($text) {
    $length = ord($text[1]) & 127;
    if ($length == 126) {
        $masks = substr($text, 4, 4);
        $data = substr($text, 8);
    } elseif ($length == 127) {
        $masks = substr($text, 10, 4);
        $data = substr($text, 14);
    } else {
        $masks = substr($text, 2, 4);
        $data = substr($text, 6);
    }
    $text = '';
    for ($i = 0; $i < strlen($data); ++$i) {
        $text .= $data[$i] ^ $masks[$i % 4];
    }
    return $text;
}
