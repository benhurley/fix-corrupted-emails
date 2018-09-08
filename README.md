# Fix Corrupted Emails
This program uses (7,4) Hamming Code to recover data that has been corrupted. In this particular case, corrupted emails are passed in and corrected to show their original messages.

Each codeword in the test files have exactly 1 error. This program determines where that error occured and corrects it.

## Getting Started

To get started, grab the https link above and clone this repo to your local machine
```
git clone https://github.com/thebenhurley/fix-corrupted-emails.git
```

Then run the Perl executable and pass in one of the test emails
```
Perl cn2.pl corrupted_email_1
```

## Prerequisites

In order to clone and run this project, you will need the following:
1. Perl

## How it works

### cn2.pl
This Perl script loads in the corrupted emails, finds the inavlid bit in each codeword, fixes it, and then prints the original version and the correct version to the console. 

### corrupt_email_1 and corrupt_email_2
These are corrupted text files containing several hundred 7-bit codewords. Each codeword has exactly one error. When fixed by the above Perl script, they will print as legible email message.

## Acknowledgments
FSU Department of CS for providing test files

