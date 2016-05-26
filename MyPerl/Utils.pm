package MyPerl::Utils;
use strict;
use warnings;
     
use Exporter qw(import);
     
our @EXPORT_OK = qw(trim ltrim rtrim readFile createBakFiles printlist msg);

use File::Copy;

#--------------------------------------------------
# trim($string)
# Trims leading and trailing whitespace from a string.
#--------------------------------------------------
sub trim
{
my $string = shift;
   $string =~ s/^\s+//;
   $string =~ s/\s+$//;
   return $string;
}

#--------------------------------------------------
# ltrim($string)
# Removes leading whitespace from a string.
#--------------------------------------------------
sub ltrim
{
   my $string = shift;
   $string =~ s/^\s+//;
   return $string;
}

#--------------------------------------------------
# rtrim($string)
# Removes trailing whitespace from a string.
#--------------------------------------------------
sub rtrim
{
   my $string = shift;
   $string =~ s/\s+$//;
   return $string;
}

#-------------------------
# createBakFiles(@files)
# For each file in an array, creates a duplicate file
# with appended extension ".bak".
#-------------------------
sub createBakFiles
{
   my (@files) = @_;

   for my $t (@files){
      my $tbak = "$t" . ".bak";
      msg("moving $t to " . $tbak . "\n");
      copy($t,$tbak);
      #move($t,$tbak);
   }
}

#-------------------------
# readFile($filename) - returns array of lines
# Note: Does chomp then trim on all lines.
#-------------------------
sub readFile
{
   my ($fname) = @_;
   my @lines;

   open(my $fh, "<", $fname)
      or die "Failed to open file: $fname\n";
   while(<$fh>) {
      chomp;
      trim($_);
      push(@lines,$_);
   }
   close($fh);
   @lines;
}

#-------------------------
# printlist($header,@list)
# Prints a list to the terminal.
# Header is printed on the first line of output.
# Each list item is printed on subsequent lines.
#-------------------------
sub printlist {
   my ($caption,@list) = @_;

   print $caption . "\n";
   foreach my $item (@list){
      print $item . "\n";
   }
}

#-------------------------
# msg($txt)
# Prints a message to the terminal.
# Does not append a "\n".
#-------------------------
sub msg {
   my ($txt) = @_;

   #if( $talking == 1 ){
      print $txt;
   #}
}
     
1;
