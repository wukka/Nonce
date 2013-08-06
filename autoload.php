<?php
@include __DIR__ . '/vendor/autoload.php';

spl_autoload_register(function( $class ){
  $namespace = 'Wukka\Nonce';
  if( $class == $namespace ){
     require __DIR__ . '/lib/' . str_replace('\\', '/', $class) . '.php';
  }
});