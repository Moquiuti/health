//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //
 //	FUNCIONES DE COOKIES
 //
 //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
	// Creacion de una cookie con nombre sName y valor sValue
	function SetCookie(sName, sValue)
	{ 
	  document.cookie = sName + "=" + escape(sValue) + ";host=www.mvmnucleo.com;path=/";	
	}

	//Retorna el valor de la cookie
	function GetCookie(sName){ 
          if (document.cookie.length > 0) {   
	    // cookies are separated by semicolons
	    var aCookie = document.cookie.split("; ");
	    for (var i=0; i < aCookie.length; i++)
	    {
	      // a name/value pair (a crumb) is separated by an equal sign
	      var aCrumb = aCookie[i].split("=");
	      //alert('Cookie:Name='+aCrumb[0]+'. Value='+aCrumb[1]+'.');
	      if (sName == aCrumb[0]) 
	        return unescape(aCrumb[1]);
	    }
	    // a cookie with the requested name does not exist*/
	    return null;
	  }
	  return null;
	}

	// Mira si existe la cookie.
	// Si no existe la crea.
	// Si existe y su valor es 'E' recargamos.
	//
	// Estados de la cookie:
	// Iniciar
	//   E - End.    Ya se ha recargado.
	//   R - Reload. Se esta recargando. No volver a recargar.
	//
	// Terminar
	//
	function Actualitza_Cookie (nombre_cookie,estado){
		
        if (estado == 'Iniciar') {
	  // Si no existe cookie la creamos con valor 'E' 
	  if (GetCookie(nombre_cookie)==null) {
	    SetCookie(nombre_cookie,'E');
	    //document.location.href=document.location.href;
	  } else {	    
	    if (GetCookie(nombre_cookie)=='R') { //Si existe con valor 'R' la actualizamos y recargamos pagina.
	      SetCookie(nombre_cookie,'E');
	      document.location.href=document.location.href; // La ultima instruccion que se ejecuta
	    }
	  }
	} else {
		if (estado == 'Terminar') {
			SetCookie(nombre_cookie,'R');	
		}
	  }
	//alert('sortim de la funcio nombre= '+nombre_cookie+' estado= '+estado+' valor= '+GetCookie(nombre_cookie));
	}