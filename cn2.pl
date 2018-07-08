#!/usr/bin/perl

# Benjamin Hurley
# Computer Networks Program 2

use warnings;

sub calcSyndrome {

   # Calculates the syndrome and finds a match in the
   # parity matrix to determine which bit needs to 
   # be flipped

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

sub convert {

   # Converts a 7 bit codeword to the 4 bit piece needed

   @codeword = @{$_[0]};
   my @temp;

   for (my $i = 0; $i < 4; $i++) {
	$temp[$i] = $codeword[$i];
   }

   return @temp;
}

# Main Variables:
my @array;
my @codeword;
my $spaces;
my @fixed;
my @build;
my $add = 0;
my @four;

# open file and read in contents:

open(my $fh, "<", "corrupted_email_2") or die "Test data file not found in directory\n";

while(<$fh>) { 
    chomp; 
    push @array, $_;
} 
close $fh;

# testdata is saved

# using regex, strip whitespace and pass codewords into 
# function to calculate the syndrome:

foreach $_ (@array) {
   $spaces = $_;
   $spaces =~ s/\s\s+//g;
   $spaces =~ s/^\s+//;

   @codeword = split('', $spaces, length($spaces));
   @four = calcSyndrome(\@codeword);

   # this is where corrected bits-trings (length 4) return
   push @build, @four;
}

# convert into ASCII to print message:

for (my $i = 0; $i < scalar @build; $i = $i + 8)
{
   $add = 128*$build[$i] + 64*$build[$i+1] + 32*$build[$i+2] + 16*$build[$i+3] + 8*$build[$i+4] + 4*$build[$i+5] + 2*$build[$i+6] + 1*$build[$i+7];

   my $letter = chr($add);
   print "$letter";
}
