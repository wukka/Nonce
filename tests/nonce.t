#!/usr/bin/env php
<?php
include_once __DIR__ . '/../autoload.php';
use Wukka\Test as T;
use Wukka\Nonce;
T::plan(8);
$token = 'demo' . time();
$secret = 'abc123demo' . microtime(TRUE);
$n = new Nonce($secret);
T::ok( $n->check( $nonce = $n->create( $token, $expires = time() + 1 ), $token ), 'nonce created with 1 left checks out');
T::debug($nonce);
T::ok( ! $n->check( $nonce = $n->create($token, time() - 1), $token), 'old nonce is expired');
T::debug( $nonce );
$n = new Nonce($secret, 39 );
$expires = time() + 10;
$nonce = $n->create( $token, $expires );
T::is( strlen( $nonce), 39, 'nonce chunk length overriden to create a shorter nonce (less secure)');
T::debug( $nonce );

$n = new Nonce($secret, 15 );
$expires = time() + 10;
$nonce = $n->create( $token, $expires );
T::is( strlen( $nonce), 15, 'nonce chunk length overriden to create shortest nonce');
T::debug( $nonce );

$n = new Nonce($secret, 14 );
$nonce = $n->create( $token, $expires = time() + 10 );
T::is( strlen( $nonce), 15, 'cant create a nonce shorter than 15');
T::debug( $nonce );

$n = new Nonce($secret, 1000 );
$expires = time() + 10;
$nonce = $n->create( $token, $expires );
T::is( strlen( $nonce), 1000, 'created a huge nonce');
T::ok( $n->check( $nonce, $token ), 'huge nonce checks out');
T::debug( $nonce );

$err = '';

try {
    $nonce = new Nonce(NULL);
} catch( Exception $e ){
    $err = $e->getMessage();
}

T::like($err, '#secret#', 'exception thrown on no secret found');
