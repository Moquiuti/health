//
	//  Construimos el string de cantidades/precios de las lineas de multioferta.
	//  (LMO_ID|CANTIDAD)(100|300.4)
	//
	function ConstruirString(formu,aBuscar) {
	     var cadena="";
	     var cant;
	     var lg = aBuscar.length;
	     for (i=0;i<formu.length;i++)
	        {
	        if (formu.elements[i].name.substring(0,lg)==aBuscar)
	            {
	            
	            // #sustituye#
	            cant=Antiformatea(formu.elements[i].value);
	            cant=formu.elements[i].value;
	            cadena+="(" + formu.elements[i].name.substring(lg,formu.elements[i].name.length) + "|" + cant + ")";	            
	            }
	        }
	        return cadena;
	}