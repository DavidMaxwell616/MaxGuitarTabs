#!/usr/bin/perl

$hsfile = "invadersscores.txt";
# CHMOD this to 666 and this perl script to 755

print "Cache-Control: max-age=0, must-revalidate\n";
print "Expires: Sun, 31 Oct 2001 12:00:00 GMT\n";
print "Content-Type: text/plain\n\n";

# Read input from POST http header into buffer
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
$len = length($buffer);

if ($len > 12) {
	@pairs = split(/&/, $buffer);
	foreach $pair (@pairs) {
	        ($nm, $val) = split(/=/, $pair);
	        $NEWDATA{$nm} = $val;
	}

	open (FILE,"<$hsfile");
	flock (FILE,2);
	$line = <FILE>;

	$count = 0;
	$newline = "";
	$ranked = 0;
	@pairs = split(/&/, $line);
	foreach $pair (@pairs) {
		if ($count < 101) {
			($nm, $val) = split(/=/, $pair);
			if (substr($nm,0,4) eq "name") {
				$newline .= "name$count=$val&";
			}
			else {
				if ($ranked == 0 && $NEWDATA{'score'} > $val && $NEWDATA{'name'} ne "") {
					$count++;
					$newline .= "score$count=$NEWDATA{'score'}&name$count=$NEWDATA{'name'}&";
						$ranked = 1;
				}
	
				$count++;
				$newline .= "score$count=$val&";
			}
		}
	}
	print $newline;
	close (FILE);

	$lennew = length($newline);
	if ($lennew > 12) {
		open (FILE,">$hsfile");
		flock (FILE,2);
		print FILE "$newline";
		close (FILE);
	}
}
else {
	open (FILE,"<$hsfile");
	flock (FILE,2);
	$line = <FILE>;
	print "$line";
	close (FILE);
}

