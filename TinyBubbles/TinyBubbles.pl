#!C:\Strawberry\perl\bin\perl.exe -w

use strict;
use warnings;
use diagnostics;
use English;

local $OUTPUT_AUTOFLUSH = 1;

my $DEBUG = 1;

bubblesort_don(["wilma", "fred", "barney", "bam-bam", "pebbles", "dino"]);
bubblesort_me(["wilma", "fred", "barney", "bam-bam", "pebbles", "dino"]);
bubblesort_jon(["wilma", "fred", "barney", "bam-bam", "pebbles", "dino"]);

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
    use Array::Base +1;
    my $R = shift;      # reference to records array
    my $K = $R;         # secondary reference to records array
    my $BOUND;          # highest index for which the record is not known to be in its final position
    my $j;              # lopp index
    my $t;              # last swapped value array index
    my $N = @$R;        # highest array index
#    local $[ = 1;       # reset starting index to follow algoritm as stated.

    DeBug($R, "presort", "bubblesort_don") if $DEBUG;
    B1:
        $BOUND = $N;
    B2:
        $t = 0;
        for ($j=1; $j<=$BOUND-1; $j++){
            B3:
            if ($K->[$j] gt $K->[$j+1]) {
                @$R[$j, $j+1] = @$R[$j+1, $j];
                $t = $j;
            }
        }
    B4:
    if ($t) {
        $BOUND = $t;
        goto B2;
    }

    DeBug($R, "postsort", "bubblesort_don") if $DEBUG;

    no Array::Base;
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
