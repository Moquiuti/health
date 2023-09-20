/*
	Utilidades de uso mas frecuentes, copiadas desde general.js para no tener que cargar
	ese fichero, excesivamente grande
	
	(c) ET 18oct04 Medical Virtual Market SL
*/


    // convert all characters to lowercase to simplify testing 
    //alert(navigator.userAgent.toLowerCase());
    var agt=navigator.userAgent.toLowerCase(); 

    // *** BROWSER VERSION *** 
    // Note: On IE5, these return 4, so use is_ie5up to detect IE5. 
    var is_major = parseInt(navigator.appVersion); 
    var is_minor = parseFloat(navigator.appVersion); 
    // Note: Opera and WebTV spoof Navigator.  We do strict client detection. 
    // If you want to allow spoofing, take out the tests for opera and webtv. 

    var is_nav  = ((agt.indexOf('mozilla')!=-1) && (agt.indexOf('spoofer')==-1) 
                && (agt.indexOf('compatible') == -1) && (agt.indexOf('opera')==-1) 
                && (agt.indexOf('webtv')==-1)); 
    var is_nav5 = (is_nav && (is_major == 5)); 
    var is_nav5up = (is_nav && (is_major >= 5));
    var is_nav47down = (is_nav && (is_minor < 4.7));    
     

    var is_ie   = (agt.indexOf("msie") != -1);
    var is_ie3  = (is_ie && (is_major < 4)); 
    var is_ie4  = (is_ie && (is_major == 4) && (agt.indexOf("msie 5.")==-1) );    
    var is_ie5  = (is_ie && (is_major == 4) && (agt.indexOf("msie 5.")!=-1) ); 
    var is_ie5up  = (is_ie  && !is_ie3 && !is_ie4); 
