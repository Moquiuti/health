#!/usr/bin/perl -wt

use warnings;
use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use File::Basename;  
use File::stat;
#use Image::Size; 

$ENV{PATH} = '/usr/bin/perl';
$CGI::POST_MAX = 1024 * 1024 * 12;			# 4096kb
my $cgi = new CGI;

my $upload_docs_dir = "/MedicalVM/Documentos/IntegracionMVM";

my $safe_filename_characters = "a-zA-Z0-9_.-";  

#my $r = "";


my $doc_param = "inputFileDoc";
my @params = $cgi->param();

my $file_doc = $cgi->param($doc_param); 
my $fname_doc;


#my $fhandle_doc = $cgi->upload($doc_param);
my $fmime_doc;
my $ftype_doc;
my $fsize_doc;
my $error_doc;
my $extension;
my $fhandle_doc = $cgi->upload($file_doc);

if ($cgi->cgi_error()) {
    print $cgi->header({-type => 'text/html'});
	print $cgi->start_html({-title => 'CGI-Feedback'})."\n";
	print $cgi->start_p();
	print '{"documentos":[{"num" : "","nombre" : "","big" : "", "small" : "", "mime" : "", "size" : "", "width" : "","error" : "El fichero es demasiado grande"}]}';
	print $cgi->end_p();
	print $cgi->end_html();
    exit 0;
}


my $debug;
$debug= 'inicio'.$file_doc;

#Tratamiento del nombre del fichero	
my ($name, $path, $extension) = fileparse( $file_doc, '\..*' );  

$fname_doc = $name.'_'.time.$$.$extension;
$fname_doc =~ tr/ /_/;  
$fname_doc =~ s/[^$safe_filename_characters]//g;  
		
my $fpre_doc = $upload_docs_dir.'/'.$fname_doc;
	
#$ftype_doc = $cgi->uploadInfo($fhandle_doc)->{'Content-Type'};;
$fmime_doc = $ftype_doc;	

#Enviando el fichero	
#open ( UPLOADFILE_DOC, ">$fpre_doc" ) or die $error_doc .= $fpre_doc;
open ( UPLOADFILE_DOC, ">$fpre_doc" ) or die "$!";
	binmode UPLOADFILE_DOC;  

$debug=$debug.'Abierto.';

while ( <$fhandle_doc> ) {  
	$debug=$debug.'Escribiendo.';
	print UPLOADFILE_DOC;  
}  

print UPLOADFILE_DOC 'Esto es una prueba';  
 		
$debug=$debug.'Cerrando.';
close UPLOADFILE;


if ( -s $fpre_doc){
	$fsize_doc =  stat($fpre_doc)->size;
	
	$debug=$debug.'enviado';
}
else{
	$fsize_doc = 0;
    #$error_doc = $ftype_doc." Se ha producido un error. El fichero no existe o contiene errores: fpre:".$fpre_doc.', fname:'.$fname_doc;
    $error_doc = 'Se ha producido un error. El fichero no existe o contiene errores: '.$file_doc.', fpre:'.$fpre_doc.', fname:'.$fname_doc;
			
	$debug=$debug.'error envio';
}
		
undef $fhandle_doc;


#my $flength_doc = $fname_doc;

print $cgi->header({-type => 'text/html'});
print $cgi->start_html({-title => 'CGI-Feedback'})."\n";
print $cgi->start_p();
print '{"documentos": [';
print '{"num" : 0,"nombre" : "'.$fname_doc.'","size" : "'.$fsize_doc.'","mime" : "'.$fmime_doc.'","error" : "'.$debug.'::'.$error_doc.'"}';
print $debug;	

print ' ]';
print ' }';
print $cgi->end_p();
print $cgi->end_html();


#undef @fname_docs;
#undef @files_docs;
#undef @fpositions_docs;
#undef @fhandles_docs;
#undef @fmimes_docs;
#undef @ftypes_docs;
#undef @fsizes_docs;
#undef @errors_docs;
undef $cgi;

