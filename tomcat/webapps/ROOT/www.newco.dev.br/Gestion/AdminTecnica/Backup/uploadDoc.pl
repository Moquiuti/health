#!/usr/bin/perl -wt

use warnings;
use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use File::Basename;  
use File::stat;
use Image::Size; 

$ENV{PATH} = '/usr/bin/perl';
$CGI::POST_MAX = 1024 * 1024 * 4; # 4096kb

my $cgi = new CGI;

my $upload_dir = "/MedicalVM/Fotos/Hospitecnia";
my $upload_docs_dir = "/MedicalVM/Documentos/Hospitecnia";

my $image_param = "inputFile";
##
my $image_planos = "inputFile_2";
#
my $docs_param = "inputFileDoc";
my $productos_param = "inputFileProducts";

my $max_filesize = 8000000000;

my $res_big = '600';
my $res_medium = '300';
my $res_small = '150';
my $res_thumbnail = '75';

my $fsuf_orig = 'orig.jpg';
my $fsuf_big = 'big.jpg';
my $fsuf_medium = 'medium.jpg';
my $fsuf_small = 'small.jpg';
my $fsuf_thumbnail = 'thumbnail.jpg';

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
##
my @files_planos = $cgi->param($image_planos);
my @fnames_planos;
my @fpositions_planos;

for (my $i = 0; $i < @files_planos; $i++) {
        if (length $files_planos[$i] > 1) {
                $fpositions_planos[@fpositions_planos] = $i;
        }
}
#

my @files_docs = $cgi->param($docs_param); 
my @fnames_docs;
my @fpositions_docs;

for (my $i = 0; $i < @files_docs; $i++) {
	if (length $files_docs[$i] > 1) {
		$fpositions_docs[@fpositions_docs] = $i;
	}
}

my @files_productos = $cgi->param($productos_param); 
my @fnames_productos;
my @fpositions_productos;

for (my $i = 0; $i < @files_productos; $i++) {
	if (length $files_productos[$i] > 1) {
		$fpositions_productos[@fpositions_productos] = $i;
	}
}

my @fhandles = $cgi->upload($image_param);
my @fmimes;
my @ftypes;
my @fsizes;
my @errors;
my @ancho;
my @largo;

##
my @fhandles_planos = $cgi->upload($image_planos);
my @fmimes_planos;
my @ftypes_planos;
my @fsizes_planos;
my @errors_planos;
my @ancho_planos;
my @largo_planos;
#

my @fhandles_productos = $cgi->upload($productos_param);
my @fmimes_productos;
my @ftypes_productos;
my @fsizes_productos;
my @errors_productos;
my @ancho_productos;
my @largo_productos;

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
	print '{"imagenes": [{"num" : "","nombre" : "","big" : "", "small" : "", "mime" : "", "size" : "", "width" : "","error" : "La imagen es demasiado grande"}],"documentos":[{"num" : "","nombre" : "","big" : "", "small" : "", "mime" : "", "size" : "", "width" : "","error" : "El fichero es demasiado grande"}],"productos": [{"num" : "","nombre" : "","big" : "", "small" : "", "mime" : "", "size" : "", "width" : "","error" : "La imagen es demasiado grande"}]}';
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
		$errors_docs[$i] = "Se ha producido un error.";
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

		open ( UPLOADFILE, ">$fpre$fsuf_orig" ) or die $errors[$i] .= $fpre.$fsuf_orig;
			binmode UPLOADFILE;  
 
		while ( <$fhandle> ) {  
			print UPLOADFILE;  
		}  
 		
 		
		close UPLOADFILE;

		# calculo ancho, largo y tamanyo de la imagen original
		($ancho[$i], $largo[$i]) = imgsize($fpre.$fsuf_orig);
		$fsizes[$i] =  stat($fpre.$fsuf_orig)->size;

		my @NoEFIX=("-strip",$fpre.$fsuf_orig);
		system($mogrify,@NoEFIX) == 0 or die $errors[$i] .="mogrify @NoEFIX failed";

		if ($fsizes[$i] and $fsizes[$i] <= $max_filesize) {

			my @Thumbnail = ($fpre.$fsuf_orig,"-define","jpeg:size=150x150","-thumbnail",$res_small.'x'.$res_small,"-gravity",$gravity,"-extent",$res_small.'x'.$res_small,$fpre.$fsuf_small);
			system($convert,@Thumbnail) == 0 or die $errors[$i] .="convert @Thumbnail failed";

			# Condicion para redimensionar imagen grande segun dimensiones de imagen original
			if ($ancho[$i] >= $res_big or $largo[$i] >= $res_big) {
	                        my @Thumbnail = ($fpre.$fsuf_orig,"-thumbnail",$res_big.'x'.$res_big,"-gravity",$gravity,"-extent",$res_big.'x'.$res_big,$fpre.$fsuf_big);
				system($convert,@Thumbnail) == 0 or die $errors[$i] .="convert @Thumbnail failed";
			}else{
				if($ancho[$i] >= $largo[$i]) {
					my @Thumbnail = ($fpre.$fsuf_orig,"-thumbnail",$ancho[$i].'x'.$ancho[$i],"-gravity",$gravity,"-extent",$ancho[$i].'x'.$ancho[$i],$fpre.$fsuf_big);
					system($convert,@Thumbnail) == 0 or die $errors[$i] .="convert @Thumbnail failed";
				} else {
					my @Thumbnail = ($fpre.$fsuf_orig,"-thumbnail",$largo[$i].'x'.$largo[$i],"-gravity",$gravity,"-extent",$largo[$i].'x'.$largo[$i],$fpre.$fsuf_big);
					system($convert,@Thumbnail) == 0 or die $errors[$i] .="convert @Thumbnail failed";
				}
			}

			my @Thumbnail = ($fpre.$fsuf_orig,"-thumbnail",$res_thumbnail.'x'.$res_thumbnail,"-gravity",$gravity,"-extent",$res_thumbnail.'x'.$res_thumbnail,$fpre.$fsuf_thumbnail);
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

for (my $i = 0; $fhandles_planos[$i]; $i++) {

        $errors_planos[$i] = "";
        $fnames_planos[$i] = time.$$.$i.$fpositions_planos[$i].'_';
        my $fpre_planos = $upload_dir.'/'.$fnames_planos[$i];
        my $fhandle_planos = $fhandles_planos[$i];

        $ftypes_planos[$i] = $cgi->uploadInfo($fhandle_planos)->{'Content-Type'};;
        $fmimes_planos[$i] = $ftypes_planos[$i];

        if ($fmimes_planos[$i] =~ m/image/) {

                open ( UPLOADFILE, ">$fpre_planos$fsuf_orig" ) or die $errors_planos[$i] .= $fpre_planos.$fsuf_orig;
                        binmode UPLOADFILE;

                while ( <$fhandle_planos> ) {
                        print UPLOADFILE;
                }


                close UPLOADFILE;

		# calculo ancho, largo y tamanyo de la imagen original
		($ancho[$i], $largo[$i]) = imgsize($fpre_planos.$fsuf_orig);
                $fsizes_planos[$i] =  stat($fpre_planos.$fsuf_orig)->size;

                my @NoEFIX=("-strip",$fpre_planos.$fsuf_orig);
                system($mogrify,@NoEFIX) == 0 or die $errors_planos[$i] .="mogrify @NoEFIX failed";



                if ($fsizes_planos[$i] and $fsizes_planos[$i] <= $max_filesize) {

                        my @Thumbnail = ($fpre_planos.$fsuf_orig,"-define","jpeg:size=150x150","-thumbnail",$res_small.'x'.$res_small,"-gravity",$gravity,"-extent",$res_small.'x'.$res_small,$fpre_planos.$fsuf_small);
                        system($convert,@Thumbnail) == 0 or die $errors_planos[$i] .="convert @Thumbnail failed";

                        # Condicion para redimensionar imagen grande segun dimensiones de imagen original
			if ($ancho[$i] >= $res_big or $largo[$i] >= $res_big) {
				my @Thumbnail = ($fpre_planos.$fsuf_orig,"-thumbnail",$res_big.'x'.$res_big,"-gravity",$gravity,"-extent",$res_big.'x'.$res_big,$fpre_planos.$fsuf_big);
				system($convert,@Thumbnail) == 0 or die $errors[$i] .="convert @Thumbnail failed";
			}else{
				if($ancho[$i] >= $largo[$i]) {
					my @Thumbnail = ($fpre_planos.$fsuf_orig,"-thumbnail",$ancho[$i].'x'.$ancho[$i],"-gravity",$gravity,"-extent",$ancho[$i].'x'.$ancho[$i],$fpre_planos.$fsuf_big);
					system($convert,@Thumbnail) == 0 or die $errors[$i] .="convert @Thumbnail failed";
				} else {
					my @Thumbnail = ($fpre_planos.$fsuf_orig,"-thumbnail",$largo[$i].'x'.$largo[$i],"-gravity",$gravity,"-extent",$largo[$i].'x'.$largo[$i],$fpre_planos.$fsuf_big);
					system($convert,@Thumbnail) == 0 or die $errors[$i] .="convert @Thumbnail failed";
				}
			}

#			my @Thumbnail = ($fpre_planos.$fsuf_orig,"-thumbnail",$res_big.'x'.$res_big,"-gravity",$gravity,"-extent",$res_big.'x'.$res_big,$fpre_planos.$fsuf_big);
#                        system($convert,@Thumbnail) == 0 or die $errors_planos[$i] .="convert @Thumbnail failed";

                        my @Thumbnail = ($fpre_planos.$fsuf_orig,"-thumbnail",$res_thumbnail.'x'.$res_thumbnail,"-gravity",$gravity,"-extent",$res_thumbnail.'x'.$res_thumbnail,$fpre_planos.$fsuf_thumbnail);
                        system($convert,@Thumbnail) == 0 or die $errors_planos[$i] .="convert @Thumbnail failed";
                }
                else{
                        $errors_planos[$i] .= "Parece que un fichero es demasiado grande.";
                }
        }
        else{
                $errors_planos[$i] .= "Parece que un fichero no es un imagen.";
        }
        undef $fhandle_planos;
}




#
# Ya no se suben productos!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
#for (my $i = 0; $fhandles_productos[$i]; $i++) {
#
#	$errors_productos[$i] = "";
#	$fnames_productos[$i] = time.$$.$i.$fpositions_productos[$i].'_';
#	
#	my $fpre_productos = $upload_dir.'/'.$fnames_productos[$i];
#	my $fhandle_producto = $fhandles_productos[$i];
#	
#	$ftypes_productos[$i] = $cgi->uploadInfo($fhandle_producto)->{'Content-Type'};;
#	$fmimes_productos[$i] = $ftypes_productos[$i];
#	
#	if ($fmimes_productos[$i] =~ m/image/) {
#		open ( UPLOADFILE_PRODUCTOS, ">$fpre_productos$fsuf_big" ) or die $errors_productos[$i] .= $fpre_productos.$fsuf_big;
#			binmode UPLOADFILE_PRODUCTOS;  
#		while ( <$fhandle_producto> ) {  
#			print UPLOADFILE_PRODUCTOS;  
#		}  
# 		
#		close UPLOADFILE_PRODUCTOS;
#		
#	    ($ancho_productos[$i], $largo_productos[$i]) = imgsize($fpre_productos.$fsuf_big); 
#		$fsizes_productos[$i] =  stat($fpre_productos.$fsuf_big)->size;
#		
#		my @NoEFIX=("-strip",$fpre_productos.$fsuf_big);
#		system($mogrify,@NoEFIX) == 0 or die $errors_productos[$i] .="mogrify @NoEFIX failed";
#	
#		if ($fsizes_productos[$i] and $fsizes_productos[$i] <= $max_filesize) {
#
#			my @Thumbnail = ($fpre_productos.$fsuf_big,"-define","jpeg:size=300x300","-thumbnail",$res_small.'x'.$res_small,"-gravity",$gravity,"-extent",$res_small.'x'.$res_small,$fpre_productos.$fsuf_small);
#			system($convert,@Thumbnail) == 0 or die $errors_productos[$i] .="convert @Thumbnail failed";
#			
#			my @Thumbnail = ($fpre_productos.$fsuf_big,"-thumbnail",$res_thumbnail.'x'.$res_thumbnail,"-gravity",$gravity,"-extent",$res_thumbnail.'x'.$res_thumbnail,$fpre_productos.$fsuf_thumbnail);
#			system($convert,@Thumbnail) == 0 or die $errors[$i] .="convert @Thumbnail failed";
#			
#			
#		}
#		else{
#			$errors_productos[$i] .= "Parece que un fichero es demasiado grande.";
#		}	
#		
#	}
#	else{
#		$errors_productos[$i] .= "Parece que un fichero no es un imagen.";
#	}
#	undef $fhandle_producto;
#}
#
#

my $flength = @fnames;
my $flength_planos = @fnames_planos;
my $flength_docs = @fnames_docs;
#my $flength_productos = @fnames_productos;

print $cgi->header({-type => 'text/html'});
print $cgi->start_html({-title => 'CGI-Feedback'})."\n";
print $cgi->start_p();
print '{"imagenes": [';

for (my $i = 0; $fnames[$i]; $i++) {
	print '{"file":"'.$fhandles[$i].'","num" : "'.$i.'","nombre" : "'.$fnames[$i].$fsuf_orig.'","orig" : "'.$fnames[$i].$fsuf_orig.'","big" : "'.$fnames[$i].$fsuf_big.'", "small" : "'.$fnames[$i].$fsuf_small.'", "mime" : "'.$fmimes[$i].'", "size" : "'.$fsizes[$i].'", "width" : "'.$ancho[$i].'", "height" : "'.$largo[$i].'", "error" : "'.$errors[$i].'"}';
	if ($i < $flength - 1) {
		print ', ';
	}
}

for (my $i = 0; $fnames_planos[$i]; $i++) {
        print '{"file":"'.$fhandles_planos[$i].'","num" : "'.$i.'","nombre" : "'.$fnames_planos[$i].$fsuf_orig.'","orig" : "'.$fnames_planos[$i].$fsuf_orig.'","big" : "'.$fnames_planos[$i].$fsuf_big.'", "small" : "'.$fnames_planos[$i].$fsuf_small.'", "mime" : "'.$fmimes_planos[$i].'", "size" : "'.$fsizes_planos[$i].'", "width" : "'.$ancho[$i].'", "height" : "'.$largo[$i].'","error" : "'.$errors_planos[$i].'"}';
        if ($i < $flength_planos - 1) {
                print ', ';
        }
}

print ' ]';
print ', ';
print '"documentos": [';
for (my $i = 0; $fnames_docs[$i]; $i++) {
	print '{"file" : "'.$fhandles_docs[$i].'","num" : "'.$i.'","nombre" : "'.$fnames_docs[$i].'","size" : "'.$fsizes_docs[$i].'","mime" : "'.$fmimes_docs[$i].'","error" : "'.$errors_docs[$i].'"}';
	if ($i < $flength_docs - 1) {
		print ',';
	}
}
print ' ]';
#
# Ya no se suben productos!!!!!!!!!!!!!!!!!!!!!
#
#print ', ';
#print '"productos": [';
#for (my $i = 0; $fnames_productos[$i]; $i++) {
#	print '{"num" : "'.$i.'","nombre" : "'.$fnames_productos[$i].$fsuf_big.'","big" : "'.$fnames_productos[$i].$fsuf_big.'", "small" : "'.$fnames_productos[$i].$fsuf_small.'", "mime" : "'.$fmimes_productos[$i].'", "size" : "'.$fsizes_productos[$i].'", "width" : "'.$ancho_productos[$i].'","error" : "'.$errors_productos[$i].'"}';
#	if ($i < $flength_productos - 1) {
#		print ',';
#	}
#}
#print ' ]';
#
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

