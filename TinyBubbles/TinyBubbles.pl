#!C:\Strawberry\perl\bin\perl.exe -w

use strict;
use warnings;
use diagnostics;
$| = 1;

use Benchmark; 

my $file;
open $file, '<', 'C:\Dev\HelloPerl\ShuffledWordList.txt';
chomp(my @unsorted = <$file>);
close $file;

print "\n\nStarting...\n\n";

print "\nBubbleSort Me...\n";
# my @sortMe = ("wilma", "fred", "barney", "bam-bam", "pebbles", "dino");
my @sortMe = @unsorted;
timethis ( 1000, bubblesort_me(\@sortMe));
# print join("\n", @sortMe),"\n";

print "\nBubbleSort Jon...\n";
# @sortMe = ("wilma", "fred", "barney", "bam-bam", "pebbles", "dino");
@sortMe = @unsorted;
timethis ( 1000, bubblesort_jon(\@sortMe));
# print join("\n", @sortMe),"\n";

print "\nBubbleSort Don...\n";
# @sortMe = ("wilma", "fred", "barney", "bam-bam", "pebbles", "dino");
@sortMe = @unsorted;
timethis ( 1000, bubblesort_don(\@sortMe));
# print join("\n", @sortMe),"\n";

print "\n\nDone...\n\n";

sub bubblesort_me{
    my $r = shift;
    my $BOUND;
    my $j;
    my $wordCount = $#$r;

    print "Pass ";
    for ($BOUND = $#$r; $BOUND; $BOUND--) {
        printf( "%02.4f%%", ($BOUND/$wordCount)*100 );
        for ($j=1; $j<=$BOUND; $j++){
            if ($r->[$j-1] gt $r->[$j]) {
                @$r[$j, $j-1] = @$r[$j-1, $j];
            }
        }
        print "\b\b\b\b\b\b\b\b";
    }
}

sub bubblesort_jon{
    my $array = shift;
    my $i;
    my $j;
    my $ncomp = 0;
    my $nswap = 0;

    print "Pass #";
    for ($i = $#$array; $i; $i--) {
        printf( "%06d", $i);
        for ($j=1; $j<=$i; $j++){
            $ncomp++;
            if ($array->[$j-1] gt $array->[$j]) {
                @$array[$j, $j-1] = @$array[$j-1, $j];
                $nswap++;
            }
        }
        print "\b\b\b\b\b\b";
    }
}

sub bubblesort_don{
    my $R = shift;
    my $BOUND;
    my $j;
    my $t= 0;
    my $N = $#$R;

    print "Pass #";
    for ($BOUND = $N; $BOUND; $BOUND--) {
        printf( "%06d", $BOUND);
        for ($j=1; $j<=$BOUND; $j++){
            if ($R->[$j-1] gt $R->[$j]) {
                @$R[$j, $j-1] = @$R[$j-1, $j];
                $t++;
            }
        }
        print "\b\b\b\b\b\b";
    }
}