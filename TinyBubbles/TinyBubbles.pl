#!C:\Strawberry\perl\bin\perl.exe -w

use strict;
use warnings;
use diagnostics;
use English;

local $OUTPUT_AUTOFLUSH = 1;

my $DEBUG = 1;

bubblesort_me(["wilma", "fred", "barney", "bam-bam", "pebbles", "dino"]);
bubblesort_jon(["wilma", "fred", "barney", "bam-bam", "pebbles", "dino"]);
bubblesort_don(["wilma", "fred", "barney", "bam-bam", "pebbles", "dino"]);

sub bubblesort_me{
    my $r = shift;
    my $BOUND;
    my $j;
    my $wordCount = $#$r;

    DeBug($r, "presort", "bubblesort_me") if $DEBUG;
    for ($BOUND = $wordCount; $BOUND; $BOUND--) {
        for ($j=1; $j<=$BOUND; $j++){
            if ($r->[$j-1] gt $r->[$j]) {
                @$r[$j, $j-1] = @$r[$j-1, $j];
            }
        }
    }
    DeBug($r, "postsort", "bubblesort_me") if $DEBUG;
}

sub bubblesort_jon{
    my $array = shift;
    my $i;
    my $j;
    my $ncomp = 0;
    my $nswap = 0;

    DeBug($array, "presort", "bubblesort_jon") if $DEBUG;
    for ($i = $#$array; $i; $i--) {
        for ($j=1; $j<=$i; $j++){
            $ncomp++;
            if ($array->[$j-1] gt $array->[$j]) {
                @$array[$j, $j-1] = @$array[$j-1, $j];
                $nswap++;
            }
        }
    }
    DeBug($array, "postsort", "bubblesort_jon") if $DEBUG;

}

#
# Not finished.  This was a copy of mine and never
# done correctly.  See Algorithm in book
#
# Looks like it is just one loop and a goto

sub bubblesort_don{
    my $R = shift;
    my $BOUND;
    my $j;
    my $t= 0;
    my $N = $#$R;

    DeBug($R, "presort", "bubblesort_don") if $DEBUG;
    for ($BOUND = $N; $BOUND; $BOUND--) {
        for ($j=1; $j<=$BOUND; $j++){
            if ($R->[$j-1] gt $R->[$j]) {
                @$R[$j, $j-1] = @$R[$j-1, $j];
                $t++;
            }
        }
    }
    DeBug($R, "postsort", "bubblesort_don") if $DEBUG;

}

sub DeBug {
    my $array = shift;
    my $sorting = shift;
    my $calling_subroutine = shift;
    my $tab = "";
    $tab = "     " if ($sorting eq "postsort");
    print $tab . " Called by: " . $calling_subroutine . "\n";
    print $tab . "Word count: " . @$array . "\n";
    print $tab . "Sort State: " . $sorting . "\n";
    print $tab;
    print join("\n$tab", @$array),"\n";
    print "\n";
}
