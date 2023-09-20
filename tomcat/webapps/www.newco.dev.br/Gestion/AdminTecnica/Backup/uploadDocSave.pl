#!/usr/bin/perl -wT  
 
use strict;  
use CGI;  
use CGI::Carp qw ( fatalsToBrowser );  
use File::Basename;  
use File::stat;

$CGI::POST_MAX = 1024 * 5000;  
my $safe_filename_characters = "a-zA-Z0-9_.-";  
my $upload_dir = "/MedicalVM/Documentos/Hospitecnia"; 
my $upload_dir_img = "/MedicalVM/Fotos/Hospitecnia";

my $file_param = "inputFileDoc"; 
my $file_param_img = "inputFile"; 

my $query = new CGI;  
my @errors_img;
my @errors;
my @ftypes;
my @ftypes_img;
my @fsizes;
my @fsizes_img;
my @files;
my @files_img;
my @extensions;
my @extensions_img;

# PARSEO TODOS LOS INPUTFILE
my @filename = $query->param($file_param);
my @filename_img = $query->param($file_param_img);
@files=@filename;
@files_img=@filename_img;

for (my $i = 0; $filename[$i]; $i++) {
	
	
	# SI no existe el fichero
	if ( !$filename[$i]) {  
 		print $query->header();  
 		$errors[$i] .= "Parece que hay un problema al subir el fichero.<br />"; 
	}  
	else{
 		# FORMATEO EL NOMBRE DEL FICHERO
		my ($name, $path,$extension ) = fileparse( $filename[$i], '\..*' );  
		$extensions[$i]=$extension;
		$filename[$i] = $name . $extension;  
		$filename[$i] =~ tr/ /_/;  
		$filename[$i] =~ s/[^$safe_filename_characters]//g;  
 
		if ( $filename[$i] =~ /^([$safe_filename_characters]+)$/ ) {  
 			$filename[$i] = $1;  
		}  
		else{  
 			$errors[$i] .= "El fichero contiene caracteres invalidos.<br />"; 
		}  
	
		my $upload_filehandle = $query->upload($file_param);	
		$ftypes[$i] = $query->uploadInfo($upload_filehandle)->{'Content-Type'};

		open ( UPLOADFILE, ">$upload_dir/$filename[$i]" ) or die "$!";  
		binmode UPLOADFILE;  
 
		while ( <$upload_filehandle> ) {  
			print UPLOADFILE;  
			$fsizes[$i] =  stat($upload_dir.'/'.$filename[$i])->size;
		}  
 		
		close UPLOADFILE;	
	}

}

for (my $i = 0; $filename_img[$i]; $i++) {
	
	
	# SI no existe el fichero
	if ( !$filename_img[$i]) {  
 		print $query->header();  
 		$errors_img[$i] .= "Parece que hay un problema al subir la imagen.<br />"; 
	}  
	else{
 		# FORMATEO EL NOMBRE DEL FICHERO
		my ($name_img, $path_img,$extension_img ) = fileparse( $filename_img[$i], '\..*' );  
		$extensions_img[$i]=$extension_img;
		$filename_img[$i] = $name_img . $extension_img;  
		$filename_img[$i] =~ tr/ /_/;  
		$filename_img[$i] =~ s/[^$safe_filename_characters]//g;  
 
		if ( $filename_img[$i] =~ /^([$safe_filename_characters]+)$/ ) {  
 			$filename_img[$i] = $1;  
		}  
		else{  
 			$errors_img[$i] .= "El fichero contiene caracteres invalidos.<br />"; 
		}  
	
		my $upload_filehandle_img = $query->upload($file_param_img);	
		$ftypes_img[$i] = $query->uploadInfo($upload_filehandle_img)->{'Content-Type'};

		open ( UPLOADFILE, ">$upload_dir_img/$filename_img[$i]" ) or die "$!";  
		binmode UPLOADFILE;  
 
		while ( <$upload_filehandle_img> ) {  
			print UPLOADFILE;  
			$fsizes_img[$i] =  stat($upload_dir_img.'/'.$filename_img[$i])->size;
		}  
 		
		close UPLOADFILE;						
		
	}

}

my $flength = @files;
my $flength_img = @files_img;

print $query->header({-type => 'text/html'});
print $query->start_html({-title => 'CGI-Feedback'})."\n";
print $query->start_p();
print '{"imagenes": [';
for (my $i = 0; $files_img[$i]; $i++) {
	print '{"num" : "'.$i.'","nombre" : "'.$filename_img[$i].'","size" : "'.$fsizes_img[$i].'","mime" : "'.$extensions_img[$i].'","error" : "'.$errors_img[$i].'"}';

	#print '{"num" : "0","nombre" : "blaval.gif","error" : ""}';

	if ($i < $flength_img - 1) {
		print ',';
	}
	
}
print ' ]';
print ', ';
print '"documentos": [';
for (my $i = 0; $files[$i]; $i++) {
	print '{"num" : "'.$i.'","nombre" : "'.$filename[$i].'","size" : "'.$fsizes[$i].'","mime" : "'.$extensions[$i].'","error" : "'.$errors[$i].'"}';
	if ($i < $flength - 1) {
		print ',';
	}
}
print ' ]';
print ' }';

print $query->end_p();
print $query->end_html();


  
