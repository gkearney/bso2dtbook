#!/usr/bin/perl

$in = $ARGV[0];


my $uid = time();
($sec,$min,$hour,$day,$month,$year) = localtime();

$year = $year+1900;
$month++;
if ($month < 10) {$month = "0$month";}
if ($day < 10) {$day = "0$day";}

my $stamp = "$year-$month-$day";



open(IN, $in)  || die "something's wrong";





while (<IN>)  {
	$myxml .=  $_;
}


 $myxml  =~ m/<title.*?>(.+)<\/title?>/gi;
 $title = $1;
 $myxml  =~ m/<author.+?>(.+)<\/author?>/gi;
 $author = $1;
 $myxml =~ m/(Bookshare-.+)\./gi;
 $_ = $1;
 if (m/bookshare/gi) {
 	$uid = $_;
 } else {
 	my $uid = time();}
 
 
 
 	$myxml =~ s/<dtbook3.*?>//gi;
 	$myxml =~ s/<book.+?>//gi;
    $myxml =~ s/<\/dtbook3>/<\/dtbook>/gi;
    $myxml =~ s/<span.+?>|<\/span>//gi;
    $myxml =~ s/<rearmatter.+?>//gi;
    $myxml =~ s/<docTitle.+?>/<doctitle>/gi;
    $myxml =~ s/<\/docTitle>/<\/doctitle>/gi;
    $myxml =~ s/<rearmatter.+\/>//gi;
    $myxml =~ s/\n/QQ/gi;
    $myxml =~ s/<head.+?>.+<\/head?>//gi;
    $myxml =~ s/<frontmatter.+?>.+<\/frontmatter?>//gi;
    $myxml =~ s/QQ/\n/gi;
    $myxml =~ s/<\?.+\??>//gi;
    #$myxml =~ s/<p\s+.+?>/<p>/gi;
    $myxml =~ s/<h(\d).+?>/<h$1>/gi;
    $myxml =~ s/<level(\d).+?>/<level$1>/gi;
    
    
my $dtbheader = <<EOT;
<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE dtbook
          PUBLIC "-//NISO//DTD dtbook 2005-3//EN" 
          "http://www.daisy.org/z3986/2005/dtbook-2005-3.dtd">

<dtbook xmlns="http://www.daisy.org/z3986/2005/dtbook/" version="2005-3" xml:lang="en-US">
   <head>
      <meta name="dc:Identifier" content="$uid"/>
      <meta name="dc:Title" content="$title"/>
      <meta name="dc:Creator" content="$author"/>
      <meta name="dc:Publisher" content="Bookshare.org"/>
      <meta name="dc:Date" content="$stamp"/>
      <meta name="dc:Type" content="Text"/>
      <meta name="dc:Format" content="ANSI/NISO Z39.86-2005"/>
      <meta name="dtb:uid" content="$uid"/>
      <meta name="dtb:revision" content="0"/>
      <meta name="dtb:revisionDate" content="$stamp"/>
      <meta name="Generator" content="bso2dtbook.pl"/>
   </head>
   
   <book>
   
   <frontmatter>
   	<doctitle>$title</doctitle>
   	<docauthor>$author</docauthor>
   </frontmatter>
   
EOT

$myxml = $dtbheader . $myxml;
print $myxml;

close (IN);
close (OUT);
