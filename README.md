# Fix Corrupted Emails
This program uses (7,4) Hamming Code to recover data that has been corrupted. In this particular case, corrupted emails are passed in and corrected to show their original messages.
Each codeword has exactly 1 error. This program determines where that error occured.

### cn2.pl
This Perl file loads in the corrupted emails, finds the inavlid bit in each codeword, fixes it, and then prints the correct version to the console. 

### corrupt_email_1 and corrupt_email_2
The input file is a text file containing several hundred 7-bit codewords. Each codeword has exactly one error.

