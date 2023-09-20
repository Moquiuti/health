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

my $upload_docs_dir = "/MedicalVM/Documentos/Canguroencasa";

my $docs_param = "inputFileDoc";

my $max_filesize = 8000000000;

my $safe_filename_characters = "a-zA-Z0-9_.-";  

my $r = "";

my @params = $cgi->param();

my @files_docs = $cgi->param($docs_param); 
my @fnames_docs;
my @fpositions_docs;

for (my $i = 0; $i < @files_docs; $i++) {
	if (length $files_docs[$i] > 1) {
		$fpositions_docs[@fpositions_docs] = $i;
	}
}

my @fhandles_docs = $cgi->upload($docs_param);
my @fmimes_docs;
my @ftypes_docs;
my @fsizes_docs;
my @errors_docs;
my @extensions;

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
		$errors_docs[$i] = "Se ha producido un error.";
	}
	
}



my $flength_docs = @fnames_docs;


print $cgi->header({-type => 'text/html'});
print $cgi->start_html({-title => 'CGI-Feedback'})."\n";
print $cgi->start_p();

print '[{"documentos": [';
for (my $i = 0; $fnames_docs[$i]; $i++) {
	print '{"num" : "'.$i.'","nombre" : "'.$fnames_docs[$i].'","size" : "'.$fsizes_docs[$i].'","mime" : "'.$fmimes_docs[$i].'","error" : "'.$errors_docs[$i].'"}';
	if ($i < $flength_docs - 1) {
		print ',';
	}
}
print ' ]';
print ' }]';
print $cgi->end_p();
print $cgi->end_html();


