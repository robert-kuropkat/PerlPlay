#!C:\Strawberry\perl\bin\perl.exe -w

use strict;
use warnings;

use Prima qw(Application MsgBox);

message('Hello World!');

Prima::MainWindow->new( text => 'Hello World!');
run Prima;
