#!/usr/bin/perl -wt

use warnings;
use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use File::Basename;  
use File::stat;
use Image::Size; 

$ENV{PATH} = '/usr/bin/perl';
$CGI::POST_MAX = 1024 * 1024 * 12;			# 4096kb
my $cgi = new CGI;

my $upload_dir = "/MedicalVM/Fotos/MedicalVM";
my $upload_docs_dir = "/MedicalVM/Documentos/MedicalVM";

my $image_param = "inputFile";
my $docs_param = "inputFileDoc";

my $max_filesize = 8000000000;

my $res_big = '600';
my $res_medium = '300';
my $res_small = '150';

my $fsuf_big = 'big.jpg';
my $fsuf_medium = 'medium.jpg';
my $fsuf_small = 'small.jpg';

my $convert="/usr/local/bin/convert";
my $mogrify="/usr/local/bin/mogrify";

my $backgroundcolor = "white";
my $gravity = "center";

my $safe_filename_characters = "a-zA-Z0-9_.-";  

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

my @files_docs = $cgi->param($docs_param); 
my @fnames_docs;
my @fpositions_docs;

for (my $i = 0; $i < @files_docs; $i++) {
	if (length $files_docs[$i] > 1) {
		$fpositions_docs[@fpositions_docs] = $i;
	}
}

my @fhandles = $cgi->upload($image_param);
my @fmimes;
my @ftypes;
my @fsizes;
my @errors;
my @ancho;
my @largo;

my @fhandles_docs = $cgi->upload($docs_param);
my @fmimes_docs;
my @ftypes_docs;
my @fsizes_docs;
my @errors_docs;
my @extensions;

if ($cgi->cgi_error()) {
    print $cgi->header({-type => 'text/html'});
	print $cgi->start_html({-title => 'CGI-Feedback'})."\n";
	print $cgi->start_p();
	print '{"imagenes": [{"num" : "","nombre" : "","big" : "", "small" : "", "mime" : "", "size" : "", "width" : "","error" : "La imagen es demasiado grande"}],"documentos":[{"num" : "","nombre" : "","big" : "", "small" : "", "mime" : "", "size" : "", "width" : "","error" : "El fichero es demasiado grande"}]}';
	print $cgi->end_p();
	print $cgi->end_html();
    exit 0;
}



for (my $i = 0; $fhandles_docs[$i]; $i++) {
	
	my ($name, $path,$extension ) = fileparse( $fhandles_docs[$i], '\..*' );  
	
	$extensions[$i]=$extension;
	
	$fnames_docs[$i] = $name.'_'.time.$$.$i.$extension;
	$fnames_docs[$i] =~ tr/ /_/;  
	$fnames_docs[$i] =~ s/[^$safe_filename_characters]//g;  
		
	my $fpre_docs = $upload_docs_dir.'/'.$fnames_docs[$i];
	my $fhandle_doc = $fhandles_docs[$i];
	
	$ftypes_docs[$i] = $cgi->uploadInfo($fhandle_doc)->{'Content-Type'};;
	$fmimes_docs[$i] = $ftypes_docs[$i];	
	
	if ($fmimes_docs[$i]) {

		open ( UPLOADFILE_DOC, ">$fpre_docs" ) or die $errors_docs[$i] .= $fpre_docs;
			binmode UPLOADFILE_DOC;  
 
		while ( <$fhandle_doc> ) {  
			print UPLOADFILE_DOC;  
		}  
 		
 		
		close UPLOADFILE;
	 	
		 if ($fmimes_docs[$i] eq 'text/plain'){


                        if ( grep -f, glob $fpre_docs) {
                                $fsizes_docs[$i] =  stat($fpre_docs)->size;
                        }else{
                                $fsizes_docs[$i] = 0;
                                $errors_docs[$i] = "Se ha producido un error. El fichero no existe o contiene errores.";
                        }
                }
                else{

                        if ( -s $fpre_docs){
                                $fsizes_docs[$i] =  stat($fpre_docs)->size;
                        }

                        else{
                                $fsizes_docs[$i] = 0;
                                $errors_docs[$i] = "Se ha producido un error. El fichero no existe o contiene errores.";
                        }
                }
 
		
	    	undef $fhandle_doc;
	 }
	else{
		$errors[$i] .= "Se ha producido un error.";
	}
	
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
my $flength_docs = @fnames_docs;

print $cgi->header({-type => 'text/html'});
print $cgi->start_html({-title => 'CGI-Feedback'})."\n";
print $cgi->start_p();
print '{"imagenes": [';
for (my $i = 0; $fnames[$i]; $i++) {
	print '{"num" : "'.$i.'","nombre" : "'.$fnames[$i].$fsuf_big.'","big" : "'.$fnames[$i].$fsuf_big.'", "small" : "'.$fnames[$i].$fsuf_small.'", "mime" : "'.$fmimes[$i].'", "size" : "'.$fsizes[$i].'", "width" : "'.$ancho[$i].'","error" : "'.$errors[$i].'"}';
	if ($i < $flength - 1) {
		print ', ';
	}
}
print ' ]';
print ', ';
print '"documentos": [';
for (my $i = 0; $fnames_docs[$i]; $i++) {
	print '{"num" : "'.$i.'","nombre" : "'.$fnames_docs[$i].'","size" : "'.$fsizes_docs[$i].'","mime" : "'.$fmimes_docs[$i].'","error" : "'.$errors_docs[$i].'"}';
	if ($i < $flength_docs - 1) {
		print ',';
	}
}
print ' ]';
print ' }';
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

