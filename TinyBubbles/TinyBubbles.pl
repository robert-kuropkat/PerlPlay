#!C:\Strawberry\perl\bin\perl.exe -w

use strict;
use warnings;
use diagnostics;
use English;

local $OUTPUT_AUTOFLUSH = 1;

my $DEBUG = 1;

bubblesort_me(["wilma", "pebbles", "fred", "dino", "barney", "bam-bam"]);
bubblesort_jon(["wilma", "pebbles", "fred", "dino", "barney", "bam-bam"]);
bubblesort_don(["wilma", "pebbles", "fred", "dino", "barney", "bam-bam"]);

sub bubblesort_me{
    my $words = shift;
    my $wordCount = @$words;
    my $lastIndex = $#$words;

    DeBug($words, "presort", "bubblesort_me") if $DEBUG;
    for (my $i = 1; $i <= $wordCount -1; $i++) {
        for (my $j=0; $j <= $lastIndex - 1; $j++){
            if ($words->[$j] gt $words->[$j+1]) {
                @$words[$j, $j+1] = @$words[$j+1, $j];
            }
        }
    }
    DeBug($words, "postsort", "bubblesort_me") if $DEBUG;
}

sub bubblesort_jon{
    my $array = shift;
    my $i;
    my $j;

    DeBug($array, "presort", "bubblesort_jon") if $DEBUG;
    for ($i = $#$array; $i; $i--) {
        for ($j=1; $j<=$i; $j++){
            if ($array->[$j-1] gt $array->[$j]) {
                @$array[$j, $j-1] = @$array[$j-1, $j];
            }
        }
    }
    DeBug($array, "postsort", "bubblesort_jon") if $DEBUG;

}

sub bubblesort_don{
    use Array::Base +1; # Start array index at 1 to match Algorithm description
    my $R = shift;      # reference to records array
    my $K = $R;         # secondary reference to records array
    my $BOUND;          # highest index for which the record is not known to be in its final position
    my $j;              # lopp index
    my $t;              # last swapped value array index
    my $N = $#$R;       # highest array index (aka, number of array elements)

    DeBug($R, "presort", "bubblesort_don") if $DEBUG;
    B1: # [Initialize BOUND.]
        $BOUND = $N;
    B2: # [Loop on j.]
        $t = 0;
        for ($j=1; $j<=$BOUND-1; $j++){
    B3: # [Compare/exchange Rj:Rj+1.]
            if ($K->[$j] gt $K->[$j+1]) {
                @$R[$j, $j+1] = @$R[$j+1, $j];
                $t = $j;
            }
        }
    B4: # [Any exchanges?]
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
