#!/usr/bin/perl -wt

use warnings;
use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use File::Basename;  
use File::stat;
use Image::Size; 

$ENV{PATH} = '/usr/bin/perl';
$CGI::POST_MAX = 1024 * 1024 * 4;			# 4096kb
#1024 * 100; # max 100K posts
my $cgi = new CGI;
my $upload_dir = "/MedicalVM/Fotos/MedicalVM";
my $image_param = "inputFile";
my $max_filesize = 8000000000;
my $res_big = '600';
my $res_medium = '300';
my $res_small = '150';

my $fsuf_big = 'big.jpg';
my $fsuf_medium = 'medium.jpg';
my $fsuf_small = 'small.jpg';

my $convert="/usr/local/bin/convert";
my $mogrify="/usr/local/bin/mogrify";
my $size = "800x800";
my $resize = "800x800";
my $backgroundcolor = "white";
my $gravity = "center";

my $r = "";

my @params = $cgi->param();

if ($cgi->param("FOTOS_DIR") and $cgi->param("FOTOS_DIR") ne "") {
	$upload_dir = $cgi->param("FOTOS_DIR");
}

if ($cgi->param("resolution_big") and $cgi->param("resolution_big") > 300 and $cgi->param("resolution_big") < 1200) {
	$res_big = $cgi->param("resolution_big");
}
if ($cgi->param("resolution_medium") and $cgi->param("resolution_medium") > 150 and $cgi->param("resolution_medium") < 500) {
	$res_medium = $cgi->param("resolution_medium");
}
if ($cgi->param("resolution_small") and $cgi->param("resolution_small") > 50 and $cgi->param("resolution_small") < 200) {
	$res_small = $cgi->param("resolution_small");
}

my @files = $cgi->param($image_param); 
my @fnames;
my @fpositions;

for (my $i = 0; $i < @files; $i++) {
	if (length $files[$i] > 1) {
		$fpositions[@fpositions] = $i;
	}
}


my @fhandles = $cgi->upload($image_param);
my @fmimes;
my @ftypes;
my @fsizes;
my @errors;
my @ancho;
my @largo;


if ($cgi->cgi_error()) {
    print $cgi->header({-type => 'text/html'});
	print $cgi->start_html({-title => 'CGI-Feedback'})."\n";
	print $cgi->start_p();
	print '{"imagenes": [{"big" : "", "small" : "", "mime" : "", "size" : "", "width" : "","error" : "Parece que un fichero es demasiado grande"}]}';
	print $cgi->end_p();
	print $cgi->end_html();
    exit 0;
}


for (my $i = 0; $fhandles[$i]; $i++) {

	$errors[$i] = "";
	$fnames[$i] = time.$$.$i.$fpositions[$i].'_';
	my $fpre = $upload_dir.'/'.$fnames[$i];
	my $fhandle = $fhandles[$i];
	
	$ftypes[$i] = $cgi->uploadInfo($fhandle)->{'Content-Type'};;
	$fmimes[$i] = $ftypes[$i];
	
	if ($fmimes[$i] =~ m/image/) {

		open ( UPLOADFILE, ">$fpre$fsuf_big" ) or die $errors[$i] .= $fpre.$fsuf_big;
			binmode UPLOADFILE;  
 
		while ( <$fhandle> ) {  
			print UPLOADFILE;  
		}  
 		
 		
		close UPLOADFILE;
		
	    ($ancho[$i], $largo[$i]) = imgsize($fpre.$fsuf_big); 
		$fsizes[$i] =  stat($fpre.$fsuf_big)->size;
		
		my @NoEFIX=("-strip",$fpre.$fsuf_big);
		system($mogrify,@NoEFIX) == 0 or die $errors[$i] .="mogrify @NoEFIX failed";
		
		
		
		if ($fsizes[$i] and $fsizes[$i] <= $max_filesize) {
			my @Thumbnail = ($fpre.$fsuf_big,"-define","jpeg:size=300x300","-thumbnail",$res_small.'x'.$res_small,"-gravity",$gravity,"-extent",$res_small.'x'.$res_small,$fpre.$fsuf_small);
			system($convert,@Thumbnail) == 0 or die $errors[$i] .="convert @Thumbnail failed";
			
		}
		else{
			$errors[$i] .= "Parece que un fichero es demasiado grande.";
		}	
		
	}
	else{
		$errors[$i] .= "Parece que un fichero no es un imagen.";
	}
	undef $fhandle;
}

my $flength = @fnames;
print $cgi->header({-type => 'text/html'});
print $cgi->start_html({-title => 'CGI-Feedback'})."\n";
print $cgi->start_p();
print '[';
for (my $i = 0; $fnames[$i]; $i++) {
	print '{"big" : "'.$fnames[$i].$fsuf_big.'", "small" : "'.$fnames[$i].$fsuf_small.'", "mime" : "'.$fmimes[$i].'", "size" : "'.$fsizes[$i].'", "width" : "'.$ancho[$i].'","error" : "'.$errors[$i].'"}';
	if ($i < $flength - 1) {
		print ', ';
	}
}
print ' ]';
print $cgi->end_p();
print $cgi->end_html();


undef @fnames;
undef @files;
undef @fpositions;
undef @fhandles;
undef @fmimes;
undef @ftypes;
undef @fsizes;
undef @errors;
undef $cgi;

