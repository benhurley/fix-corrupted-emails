#!/usr/bin/perl

# Benjamin Hurley
# Computer Networks Program 2

use warnings;
   
# (Function) calcSyndrome: Calculates the syndrome and finds a match in the
# parity matrix to determine which bit needs to be flipped
sub calcSyndrome {

   @codeword = @{$_[0]};

   # Local Variables:
   my $total = 0;
   my $math = 0;
   my @matrix = ([1, 1, 1, 0, 1, 0, 0], [0, 1, 1, 1, 0, 1, 0], [1, 1, 0, 1, 0, 0, 1]);
   my @syndrome = (0, 0, 0);

   #compute syndrome below:

   for (my $i = 0; $i < 3; $i++)
   {
	for (my $j = 0; $j < 7; $j++)
	{
 	   $math = $codeword[$j] & $matrix[$i][$j];

           if ($math == 1 && $total == 1) {
		$total = 0;
	   }
           else {
	        $total = $total | $math;
 	   }
	}

	$syndrome[$i] = $total;
	$total = 0;
   }

   # now check for match in parity check matrix

   for ($i = 0; $i < 7; $i++)
   {
      if ($syndrome[0] == $matrix[0][$i]) {
	 if ($syndrome[1] == $matrix[1][$i]) {
	    if ($syndrome[2] == $matrix[2][$i]) {
		if ($codeword[$i] == 0) {
		    # flip bit
		    $codeword[$i] = 1;
		}
		elsif ($codeword[$i] == 1) {
		    #flip bit
		    $codeword[$i] = 0;
		}

	  last;
    }}}}

   #grab first 4 bits of fixed codeword and return to main

   my @fourTuple = convert(\@codeword);

   return @fourTuple;
}

# (Function) covert: Converts a 7 bit codeword to the 4 bit piece needed
sub convert {

   @codeword = @{$_[0]};
   my @temp;

   for (my $i = 0; $i < 4; $i++) {
	$temp[$i] = $codeword[$i];
   }

   return @temp;
}

#-----------------------------------
# Main program

# global variables:

my @array;
my @codeword;
my @fixed;
my @build;
my @four;

my $spaces;
my $add = 0;
my $addOld = 0;

# save arguments, check if valid:
my ($filename) = @ARGV;

if(not defined $filename) {
    die "\nInvalid run. Need to pass in corrupted email as argument.\n\n";
}

# open corrupted email
open(my $fh, "<", $ARGV[0]) or die "\nAn error has occured opening the file.\n\n";

print"\n----------------------------------\n";
print "Request to fix: $filename\n";
print"----------------------------------\n";

# push corrupted email into array

while(<$fh>) { 
    chomp; 
    push @array, $_;
} 
close $fh;

# using regex, strip whitespace and pass codewords into 
# function to calculate the syndrome:

foreach $_ (@array) {
   $spaces = $_;
   $spaces =~ s/\s\s+//g;
   $spaces =~ s/^\s+//;

   # remove spaces
   @codeword = split('', $spaces, length($spaces));

   # store old codeword to print original message
   my @oldTuple = convert(\@codeword);
   push @old, @oldTuple;

   # this is where corrected bit-strings (length 4) return
   @four = calcSyndrome(\@codeword);
   push @build, @four;
}

# print original corrupted message:
print "\n----------------------------------------\n";
print "Previous corrupted version of the email:\n";
print "----------------------------------------\n\n";

for (my $i = 0; $i < scalar @old; $i = $i + 8)
{
   my $addOld = 128*$old[$i] + 64*$old[$i+1] + 32*$old[$i+2] + 16*$old[$i+3] + 8*$old[$i+4] + 4*$old[$i+5] + 2*$old[$i+6] + 1*$old[$i+7];

   my $letterOld = chr($addOld);
   print "$letterOld";
}

# convert into ASCII to print message:
print"\n\n-------------------------------------------\n";
print "Corrected Version using (7,4) Hamming Code:\n";
print"-------------------------------------------\n\n";

for (my $i = 0; $i < scalar @build; $i = $i + 8)
{
   $add = 128*$build[$i] + 64*$build[$i+1] + 32*$build[$i+2] + 16*$build[$i+3] + 8*$build[$i+4] + 4*$build[$i+5] + 2*$build[$i+6] + 1*$build[$i+7];

   my $letter = chr($add);
   print "$letter";
}
