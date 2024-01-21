#!C:\Strawberry\perl\bin\perl.exe -w

use strict;
use warnings;

use Tk;

my $mw = MainWindow->new;
$mw->title("Hello World");
$mw->Button( -text => "Hello World!"
           , -command => sub{exit;})->pack;
MainLoop;
