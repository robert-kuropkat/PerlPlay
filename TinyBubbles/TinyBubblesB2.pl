#!C:\Strawberry\perl\bin\perl.exe -w

use strict;
use warnings;
use diagnostics;
use Benchmark; 
use English;

local $OUTPUT_AUTOFLUSH = 1;

my $DEBUG = 0;
my $sortCylces = 10;

my $file;
open $file, '<', 'D:\Dev\PerlPlay\TinyBubbles\ShuffledWordList.txt';
chomp(my @unsorted = <$file>);
my $u = \@unsorted;
close $file;

my $bubbleMe = sub {
    my $u = shift;
    my @r = @$u;

    my $r = \@r;
    my $BOUND;
    my $j;
    my $wordCount = $#$r;

    DeBug($r, "presort") if $DEBUG;
    for ($BOUND = $wordCount; $BOUND; $BOUND--) {
        printf( "%08.4f%%", ($BOUND/$wordCount)*100 ) if $DEBUG;
        for ($j=1; $j<=$BOUND; $j++){
            if ($r->[$j-1] gt $r->[$j]) {
                @$r[$j, $j-1] = @$r[$j-1, $j];
            }
        }
        printf ("\b\b\b\b\b\b\b\b\b") if $DEBUG;
    }
    DeBug($r, "postsort") if $DEBUG;

   };

my  $bubbleJon = sub {
    my $u = shift;
    my @array = @$u;

    my $array = \@array;
    my $i;
    my $j;
    my $ncomp = 0;
    my $nswap = 0;

    DeBug($array, "presort") if $DEBUG;
    for ($i = $#$array; $i; $i--) {
        printf( "%08.4f%%", ($i/$#$array)*100 ) if $DEBUG;
        for ($j=1; $j<=$i; $j++){
            $ncomp++;
            if ($array->[$j-1] gt $array->[$j]) {
                @$array[$j, $j-1] = @$array[$j-1, $j];
                $nswap++;
            }
        }
        printf ("\b\b\b\b\b\b\b\b\b") if $DEBUG;
    }
    DeBug($array, "postsort") if $DEBUG;

   };

my $bubbleDon = sub {
    my $u = shift;
    my @R = @$u;

    my $R = \@R;
    my $BOUND;
    my $j;
    my $t= 0;
    my $N = $#$R;

    DeBug($R, "presort") if $DEBUG;
    for ($BOUND = $N; $BOUND; $BOUND--) {
        printf( "%08.4f%%", ($BOUND/$N)*100 ) if $DEBUG;
        for ($j=1; $j<=$BOUND; $j++){
            if ($R->[$j-1] gt $R->[$j]) {
                @$R[$j, $j-1] = @$R[$j-1, $j];
                $t++;
            }
        }
        printf ("\b\b\b\b\b\b\b\b\b") if $DEBUG;
    }
    DeBug($R, "postsort") if $DEBUG;

   };

sub DeBug {
    my $array = shift;
    my $sorting = shift;
    my $tab = "";
    $tab = "     " if ($sorting eq "postsort");
    print $tab . "Word count: " . @$array . "\n";
    print $tab . "Sort State: " . $sorting . "\n";
    print $tab . "First word: " . $array->[0] . "\n";
    print $tab . " Last word: " . $array->[-1] . "\n";
    print "\n";
}

timethese ( $sortCylces
          , { bubbleMe   => sub { $bubbleMe->($u) }
            , bubbleJon  => sub { $bubbleJon->($u) }
            , bubbleDon  => sub { $bubbleDon->($u) }
            }
          );
