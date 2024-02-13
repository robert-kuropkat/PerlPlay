#!C:\Strawberry\perl\bin\perl.exe -w

use strict;
use warnings;
use diagnostics;
use Benchmark; 
use English;

local $OUTPUT_AUTOFLUSH = 1;

my $DEBUG = 1;
my $sortCylces = 2;

my $file;
open $file, '<', 'D:\Dev\PerlPlay\TinyBubbles\ShuffledWordList.txt';
chomp(my @unsorted = <$file>);
my $u = \@unsorted;
close $file;

my $results = timethese ( $sortCylces
          , { '1_bubbleMe'   => sub { bubblesort_me($u) }
#            , '2_bubbleJon'  => sub { bubblesort_jon($u) }
#            , '3_bubbleDon'  => sub { bubblesort_don($u) }
            }
          );
Benchmark::cmpthese($results);

sub bubblesort_me{
    my $words = shift;
#    my $unsortedWords = shift;
#    my @words = @$unsortedWords;

#    my $words = \@words;
    my $wordCount = @$words;
    my $lastIndex = $#$words;

    DeBug($words, "presort", "bubblesort_me") if $DEBUG;
    for (my $i = 1; $i <= $wordCount - 1; $i++) {
        printf( "%08.4f%%", ($i/$wordCount)*100 ) if $DEBUG;
        for (my $j=0; $j <= $lastIndex - 1; $j++){
            if ($words->[$j] gt $words->[$j+1]) {
                @$words[$j, $j+1] = @$words[$j+1, $j];
            }
        }
        printf ("\b\b\b\b\b\b\b\b\b") if $DEBUG;
    }
    DeBug($words, "postsort", "bubblesort_me") if $DEBUG;
}

sub bubblesort_jon{
    my $u = shift;

    my @array = @$u;
    my $array = \@array;

    my $i;
    my $j;

    DeBug($array, "presort", "bubblesort_jon") if $DEBUG;
    for ($i = $#$array; $i; $i--) {
        printf( "%08.4f%%", ($i/$#$array)*100 ) if $DEBUG;
        for ($j=1; $j<=$i; $j++){
            if ($array->[$j-1] gt $array->[$j]) {
                @$array[$j, $j-1] = @$array[$j-1, $j];
            }
        }
        printf ("\b\b\b\b\b\b\b\b\b") if $DEBUG;
    }
    DeBug($array, "postsort", "bubblesort_jon") if $DEBUG;

}

sub bubblesort_don{
    use Array::Base +1; # Start array index at 1 to match Algorithm description
    my $u = shift;

    my @R = @$u;
    my $R = \@R;

    my $K = $R;         # secondary reference to records array
    my $BOUND;          # highest index for which the record is not known to be in its final position
    my $j;              # lopp index
    my $t;              # last swapped value array index
    my $N = @$R;        # highest array index (aka, number of array elements)

    DeBug($R, "presort", "bubblesort_don") if $DEBUG;
    B1: # [Initialize BOUND.]
        $BOUND = $N;
    B2: # [Loop on j.]
        $t = 0;
        printf( "%08.4f%%", ($BOUND/$N)*100 ) if $DEBUG;
        for ($j=1; $j<=$BOUND-1; $j++){
    B3: # [Compare/exchange Rj:Rj+1.]
            if ($K->[$j] gt $K->[$j+1]) {
                @$R[$j, $j+1] = @$R[$j+1, $j];
                $t = $j;
            }
        }
        printf ("\b\b\b\b\b\b\b\b\b") if $DEBUG;
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
    print $tab . "First word: " . $array->[0] . "\n";
    print $tab . " Last word: " . $array->[-1] . "\n";
    print "\n";
}
