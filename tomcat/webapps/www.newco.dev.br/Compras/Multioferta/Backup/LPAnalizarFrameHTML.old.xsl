<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:variable name="accion"><xsl:value-of select="Analizar/ANALISIS/ACCION"/></xsl:variable>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
 <xsl:choose>
  <xsl:when test="//xsql-error">
    <xsl:apply-templates select="//xsql-error"/>
  </xsl:when>
  <xsl:otherwise>  
  
    <html>
      <head> 
       <!--idioma 5-4-15 mc-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
        <!--idioma fin-->
        
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
	<link rel="stylesheet" href="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.css" type="text/css"/>

      <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	  <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
      <script type="text/javascript" src="http://www.newco.dev.br/General/divisas.js"></script>
      <script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>
      
    <xsl:text disable-output-escaping="yes"><![CDATA[  	
     
	<script type="text/javascript">
	  <!--    
       var msgCantidadNegativa='';
       var msgTodasCantidadesMismoSigno='';
       var fechaEntregaMinima;
       
       //var msgFechaMinimaIncorrecta='La fecha de entrega introducida no es valida.\nLa fecha de entrega no puede ser anterior a: ';
       //var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de continuar.';
       
	   
	   function obtenerIdDivisa(form,nombre){
	     if(form.elements[nombre].type=='select-one'){
	       return obtenerIdDesplegable(form, nombre);
             }        
	     else{
	       return form.elements[nombre].value;
	     }
	   }
	   
	   function actualizaHiddenDivisa(hiddenDivisa,valorDivisaMaestra){
	     hiddenDivisa.value=valorDivisaMaestra;
	   }
       
       
       var arrayProductosProveedoresLineas=new Array();
       var arrayProveedores=new Array();
       var arrayProveedoresConDiferenteSigno=new Array();	
       var arrayCentros=new Array();
       var arrayLugaresEntrega=new Array();
       var arrayCentrosConsumo=new Array();
       //var arrayAlmacenesInternos=new Array();
		
		]]></xsl:text>
		 <xsl:for-each select="Analizar/ANALISIS/CABECERA/TODOSLUGARESENTREGA/CENTRO">
				arrayCentros[arrayCentros.length]=new Array(<xsl:value-of select="@ID"/>,
															'<xsl:value-of select="@nombre"/>',
															'<xsl:value-of select="PEDIDO_MINIMO/IMPORTE"/>',
                                                            '<xsl:value-of select="COSTE_TRANSPORTE/IMPORTE"/>');
															
		    	<xsl:for-each select="LUGARESENTREGA/LUGARENTREGA">
		 		arrayLugaresEntrega[arrayLugaresEntrega.length]=new Array(<xsl:value-of select="ID"/>,
		                                                                <xsl:value-of select="IDCENTRO"/>,
		                                                                '<xsl:value-of select="REFERENCIA"/>',
		                                                                '<xsl:value-of select="NOMBRE"/>',
		                                                                '<xsl:value-of select="DIRECCION"/>',
		                                                                '<xsl:value-of select="CPOSTAL"/>',
		                                                                '<xsl:value-of select="POBLACION"/>',
		                                                                '<xsl:value-of select="PROVINCIA"/>',
		                                                                '<xsl:value-of select="PORDEFECTO"/>',
																		'<xsl:value-of select="../../PEDIDO_MINIMO/IMPORTE"/>',
		                                                                '<xsl:value-of select="PORDEFECTO_FARMACIA"/>'
																		);
		 		</xsl:for-each>
		  </xsl:for-each>
		
		
		  <xsl:for-each select="Analizar/ANALISIS/CABECERA/TODOSCENTROSCONSUMO/CENTRO">
		  		<xsl:for-each select="CENTROSCONSUMO/CENTROCONSUMO">
		      	arrayCentrosConsumo[arrayCentrosConsumo.length]=new Array(<xsl:value-of select="ID"/>,
		                                                                <xsl:value-of select="IDCENTRO"/>,
		                                                                '<xsl:value-of select="REFERENCIA"/>',
		                                                                '<xsl:value-of select="NOMBRE_CORTO"/>',
		                                                                '<xsl:value-of select="PORDEFECTO"/>');
		  		</xsl:for-each>
		  </xsl:for-each>
		  <!--
		  <xsl:for-each select="Analizar/ANALISIS/CABECERA/TODOSALMACENESINTERNOS/CENTRO">
		    <xsl:for-each select="ALMACENESINTERNOS/ALMACENINTERNO">
		      arrayAlmacenesInternos[arrayAlmacenesInternos.length]=new Array(<xsl:value-of select="ID"/>,
		                                                                <xsl:value-of select="IDCENTRO"/>,
		                                                                '<xsl:value-of select="REFERENCIA"/>',
		                                                                '<xsl:value-of select="NOMBRE"/>',
		                                                                '<xsl:value-of select="PORDEFECTO"/>');
		    </xsl:for-each>
		  </xsl:for-each>
		-->
		<xsl:text disable-output-escaping="yes"><![CDATA[

function inicializarDesplegableCentrosConsumo(centroSeleccionado)
{

   //alert('cen sel despl centro '+centroSeleccionado);

  document.forms['formBot'].elements['IDCENTROCONSUMO'].length=0;

  for(var n=0;n<arrayCentrosConsumo.length;n++){
    if(arrayCentrosConsumo[n][1]==centroSeleccionado){
      if(arrayCentrosConsumo[n][4]=='S'){
        document.forms['formBot'].elements['IDCENTROCONSUMO'].options[document.forms['formBot'].elements['IDCENTROCONSUMO'].length]=new Option('['+arrayCentrosConsumo[n][3]+']',arrayCentrosConsumo[n][0]);	//	7mar08	ET	+' ('+arrayCentrosConsumo[n][2]
        document.forms['formBot'].elements['IDCENTROCONSUMO'].options[document.forms['formBot'].elements['IDCENTROCONSUMO'].length-1].selected=true;
      }
      else{
        document.forms['formBot'].elements['IDCENTROCONSUMO'].options[document.forms['formBot'].elements['IDCENTROCONSUMO'].length]=new Option(arrayCentrosConsumo[n][3],arrayCentrosConsumo[n][0]);	//	7mar08	ET	+' ('+arrayCentrosConsumo[n][2]+')'
      }
    }
  } 
}	
        
        
function ActualizarTextoLugarEntrega(idlugarEntrega)
{

	var form=document.forms['formBot'];
	for(var n=0;n<arrayLugaresEntrega.length;n++)
	{
		if(arrayLugaresEntrega[n][0]==idlugarEntrega)
		{
			form.elements['CEN_DIRECCION'].value=arrayLugaresEntrega[n][4];
			form.elements['CEN_CPOSTAL'].value=arrayLugaresEntrega[n][5];
			form.elements['CEN_POBLACION'].value=arrayLugaresEntrega[n][6];
			form.elements['CEN_PROVINCIA'].value=arrayLugaresEntrega[n][7];	
			form.elements['CEN_PEDIDOMINIMO'].value=arrayLugaresEntrega[n][9];	
		}
	}
}// fin ActualizarTextoLugarEntrega

    
//	Oculta los desplegables de lugares de entrega, deja solo el del centro seleccionado	
function mostrarDesplegableLugarDeEntrega(centroSeleccionado)
{
	//no visualizo ninguno de los lugares entrega
	var formu = document.forms['formBot'];
	for (var i=0;(i<formu.length);i++)
	{
    	var k=formu.elements[i].name;
    	if (k.substr(0,15)=='IDLUGARENTREGA_')
    	{
        	formu.elements[i].style.display = 'none';
    	}
	}		
	//enseño solo lugar entrega seleccionado
	document.forms['formBot'].elements['IDLUGARENTREGA_'+centroSeleccionado].style.display = 'block';

	//selecciono lugar entrega por defecto
	var Categoria=document.forms['form_iddivisa'].elements['CATEGORIA'].value;
	var lugarSelect='';

    for(var n=0;n<arrayLugaresEntrega.length;n++)
	{
		//	Inicializamos lugarSelect con un valor cualquiera de la lista
		if ((arrayLugaresEntrega[n][1]==centroSeleccionado)&&(lugarSelect==''))
		{
			lugarSelect = arrayLugaresEntrega[n][0];
		}
	
		//si es farmacia miro decimo campo array indica "por defecto"
		if (((arrayLugaresEntrega[n][1]==centroSeleccionado)&&(arrayLugaresEntrega[n][10]=='S')&&(Categoria=='F'))
				|| ((arrayLugaresEntrega[n][1]==centroSeleccionado)&&(arrayLugaresEntrega[n][8]=='S')&&(Categoria=='N')))
		{
			document.forms['formBot'].elements['IDLUGARENTREGA_'+centroSeleccionado].value=arrayLugaresEntrega[n][0];
			lugarSelect = arrayLugaresEntrega[n][0];
		}
	}//fin for

	//doy a IDLUGARENTREGA el valor seleccionado
	document.forms['formBot'].elements['IDLUGARENTREGA'].value = document.forms['formBot'].elements['IDLUGARENTREGA_'+centroSeleccionado].value;

	ActualizarTextoLugarEntrega(lugarSelect);

}


//	Inicializa el desplegable del centro 
function inicializarDesplegableCentros(centroSeleccionado)
{
	
	document.forms['formBot'].elements['IDCENTRO'].length=0;
        

	for(var n=0;n<arrayCentros.length;n++)
	{
        if(arrayCentros[n][0]==centroSeleccionado)
		{
			document.forms['formBot'].elements['IDCENTRO'].options[document.forms['formBot'].elements['IDCENTRO'].length]=new Option('['+arrayCentros[n][1]+']',arrayCentros[n][0]);
			document.forms['formBot'].elements['IDCENTRO'].options[document.forms['formBot'].elements['IDCENTRO'].length-1].selected=true;
                            
                        //coste de transporte
                        document.forms['sumaTotal'].elements['COSTE_LOGISTICA'].value =anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(arrayCentros[n][3]),2)),2);
                    
			inicializarDesplegableCentrosConsumo(centroSeleccionado);
            
        }
        else
		{
        	document.forms['formBot'].elements['IDCENTRO'].options[document.forms['formBot'].elements['IDCENTRO'].length]=new Option(arrayCentros[n][1],arrayCentros[n][0]);
        }
	} 
    
    //cambio total brasil si cambia coste de transporte
    
    var coste = parseFloat(desformateaDivisa(document.forms['sumaTotal'].elements['COSTE_LOGISTICA'].value));
    var total = parseFloat(desformateaDivisa(document.forms['sumaTotal'].elements['sumaTotal'].value));
                                    
    sumaBrasil = total + coste;
    //si total ya diferente de 0 escribo, si no no
    if (total != '0'){
    	document.forms['sumaTotal'].elements['sumaTotalBrasil'].value = anyadirCerosDecimales(reemplazaPuntoPorComa(sumaBrasil),2);
        }
    //fin de total brasil


	mostrarDesplegableLugarDeEntrega(centroSeleccionado);
}


       
       
		]]></xsl:text>
		  <xsl:for-each select="//Analizar/ANALISIS/LINEAS/LINEA_ROW">
		    arrayProductosProveedoresLineas[arrayProductosProveedoresLineas.length]='<xsl:value-of select="PRODUCTOS/PRODUCTOS_ROW/PROVEEDOR" disable-output-escaping="yes"/>';
		  </xsl:for-each>
		<xsl:text disable-output-escaping="yes"><![CDATA[

		for(var n=0;n<arrayProductosProveedoresLineas.length;n++){
		  var proveedor=arrayProductosProveedoresLineas[n];

		  var existe=0;
		  for(var i=0;i<arrayProveedores.length && existe==0;i++){
		    if(arrayProveedores[i][0]==proveedor){
		      existe=1;
		    }
		  }
		  if(existe==0)
		    arrayProveedores[arrayProveedores.length]=new Array(proveedor,'');
		}
		
		
		
       
       
       
       //inicializamos las divisas a 0 (Euro)
       
       function inicializarDivisas(){
         for(var i=0;i<document.forms.length;i++){
           var elForm=document.forms[i];
           if((elForm.name!='sumaTotal')&&(elForm.name!='form_catpriv')){
           	actualizaHiddenDivisa(elForm.elements['IDDIVISA'],obtenerIdDivisa(document.forms['form_iddivisa'],'IDDIVISA'));
           }
         }
       }
       
     
        var suma=0;
        var vector;
        var const_decimales = 0;
             
        
        // tipo=1 para multioferta. tipo=0 para pedido directo.
        
        function inicializarPedidoMinimo(doc){
          arrayProductosNoValidos=new Array();
          arrayProveedoresNoValidos=new Array();
        ]]></xsl:text>
                 <xsl:for-each select="//PRODUCTOS_ROW">
                   <xsl:if test="PEDIDO_MINIMO[.='I']">
                     arrayProductosNoValidos[arrayProductosNoValidos.length]='<xsl:value-of select="PLL_ID"/>';
                   </xsl:if>
                 </xsl:for-each>
       <xsl:text disable-output-escaping="yes"><![CDATA[  
          
          //recorro todos los forms, excepto el ultimo que es formBot
          for(var n=0;n<document.forms.length-1;n++){
            for(var k=0;k<doc.forms[n].length;k++){    
              if(doc.forms[n].elements[k].type=="checkbox"){ 
                for(var i=0;i<arrayProductosNoValidos.length;i++)
                  if(doc.forms[n].elements[k].value==arrayProductosNoValidos[i])
                    doc.forms[n].elements[k].disabled=true; 
              }
            }
          }
        }
        
        function heAcabado(tipo){
          if (tipo==1){
            sumar_Multioferta();            
          }
          else {
            sumar_pedidoDirecto();
          }          
        }
        
        
        
          

        // Creamos un array de num_cols posiciones
	function crearArray(num_cols){ 
	    max_cols=parseInt(num_cols);
	    count=0;
	    suma=0;
	    vector = new Array(max_cols);          
        } 
        // Rellenamos el array con el identificador y el precio      
	function anadirArray(identificador,precio){		  
          vector[count]= new Array(2);
          vector[count][0]=identificador;
          vector[count][1]=precio;
	  count++;
        }              
        
        //Para la incializacion
        //Recorremos todos los checkbox activando la funcion suma para cada uno.
        
        function sumar_Multioferta(){

          document.forms['formBot'].elements['sum'].value='0';
          document.forms['sumaTotal'].elements['sumaTotal'].value=document.forms['formBot'].elements['sum'].value;
	  //Barrido de todos los formularios
	  for (i=0;i<document.forms.length;i++){
            formu=document.forms[i];
            // Barrido de todos los elementos del formulario.
            if(formu.name!='formBot' && formu.name!='form_iddivisa' && formu.name!='form_catpriv'){       
              for(var k=0; k<formu.elements.length; k++){              
                elemento=formu.elements[k];
                var idLinea;
                if(elemento.name.match('PRECIOUNITARIO_'))
                  idLinea=obtenerId(elemento.name);
                if(elemento.name=='SELECCION' && formu.elements[k].checked){                         
                  if ( formu.elements[k].checked && !formu.elements['NuevoImporte_'+idLinea]){
                    document.forms['formBot'].elements['sum'].value="Solicitud de muestra"; 
                    document.forms['sumaTotal'].elements['sumaTotal'].value=document.forms['formBot'].elements['sum'].value;
                    return true;
                  }
                  precio_seleccionado=parseFloat(desformateaDivisa(formu.elements['NuevoImporte_'+idLinea].value));
                  suma=parseFloat(desformateaDivisa(document.forms['formBot'].elements['sum'].value));
                  suma=suma+precio_seleccionado;

                  document.forms['formBot'].elements['sum'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(suma),2)),2);
                  document.forms['sumaTotal'].elements['sumaTotal'].value=document.forms['formBot'].elements['sum'].value;
                  //alert('mi '+document.forms['sumaTotal'].elements['sumaTotal'].value);
                }
              }
            }
          }
          //alineaCelda();
        }
 
	//Para la inicializacion
	//Suma el importe de todas las líneas.
	function sumar_pedidoDirecto()
	{
		var porDefinir=0;
    	var suma=0;
        var sumaBrasil = 0;

		for (i=0;i<document.forms.length;i++)
		{
        	formu=document.forms[i];
        	if(formu.name!='form_iddivisa' && formu.name!='formBot')
			{
            	for(k=0; k<formu.elements.length; k++)
				{
               		elemento=formu.elements[k]; 
                	var idLinea;
                	if(elemento.name.match('NuevaCantidad_'))
                  		idLinea=obtenerId(elemento.name);        
                	if(elemento.name=='SELECCION')
					{
                  		if(!formu.elements['NuevoImporte_'+idLinea])
						{
                    		if(elemento.checked)
                     			elemento.checked=false;
                  		}
                  		else
						{
                      		if(formu.elements['NuevoImporte_'+idLinea].value=='Sol.Muestra')
							{ 
                       			if(!porDefinir)
                         		porDefinir=1;
                      		}
                      		else
							{
                   				if(elemento.checked)
								{
                       				//22feb11	para mayor precision, calculamos a partir de la cantida y precio unitario (4 decimales) en lugar de total linea (2 decimales)
									//precio_seleccionado=parseFloat(desformateaDivisa(formu.elements['NuevoImporte_'+idLinea].value));

									var cant = desformateaDivisa(formu.elements['NuevaCantidad_'+idLinea].value);//22feb11	
									var precio = desformateaDivisa(formu.elements['PRECIOUNITARIO_'+idLinea].value);  //22feb11	  
									var precio_seleccionado = parseFloat(cant)*parseFloat(precio);//22feb11	
                                    
                                    var coste = parseFloat(desformateaDivisa(document.forms['sumaTotal'].elements['COSTE_LOGISTICA'].value));
                                   	suma=suma+precio_seleccionado;

                                    sumaBrasil = suma + coste;
                                     
								}
							}
                 		}              
                	}
				}
			}
		}
		if (!porDefinir)
		{ 
			document.forms['formBot'].elements['sumanumerica'].value=suma;		//	24mar10	ET	Guardamos el numero en el formato numerico original
			document.forms['formBot'].elements['sum'].value=anyadirCerosDecimales(formateaDivisa(Round(suma,2)),2);
			document.forms['sumaTotal'].elements['sumaTotal'].value=anyadirCerosDecimales(document.forms['formBot'].elements['sum'].value,2);
            //suma brasil
            document.forms['formBot'].elements['sumBrasil'].value=anyadirCerosDecimales(formateaDivisa(Round(sumaBrasil,2)),2);
			document.forms['sumaTotal'].elements['sumaTotalBrasil'].value=anyadirCerosDecimales(document.forms['formBot'].elements['sumBrasil'].value,2);
            
            
            
		}
		else
		{
			document.forms['sumaTotal'].elements['sumaTotal'].value= document.forms['sumaTotal'].elements['sumaTotal'].value=document.forms['form_iddivisa'].elements['SOL_MUESTRAS'].value;
		}
	}       
        
        
function validarFechaMinima(obj,fechaMinima)
{
             
	var fechaTmpFormatoIngles=obtenerSubCadena(obj.value,2)+'/'+obtenerSubCadena(obj.value,1)+'/'+obtenerSubCadena(obj.value,3);
	var fechaMinimaTmpFormatoIngles=(fechaMinima.getMonth()+1)+'/'+fechaMinima.getDate()+'/'+fechaMinima.getFullYear();
	var fechaMinimaTmpFormatoEspanyol=fechaMinima.getDate()+'/'+(fechaMinima.getMonth()+1)+'/'+fechaMinima.getFullYear();

	var fechaTmp=new Date(fechaTmpFormatoIngles);
	var fechaMinimaTmp=new Date(fechaMinimaTmpFormatoIngles);
	  
	  
	  if(parseInt(fechaTmp.getTime())<parseInt(fechaMinimaTmp.getTime())){
	    alert( document.forms['form_iddivisa'].elements['FECHA_MINIMA'].value + fechaMinimaTmpFormatoEspanyol);
	    obj.focus();
	    return false;
	  }
	  return true;
        }
        
        function FormateaNumero(Numero){
	    Numero=String(Numero);
	    nuevoNumero = "";    // REVISED/CORRECTED STRING
	    var nuevaParteEntera = "";
	    var parteDecimal;
	    coma=0;
	    punto=0;
	    // Aqui falta comprobar el numero.	    
	    vect = Numero.split(".");
	    parteEntera = vect[0];
	    if (Numero.indexOf(".") != -1){ 
	      parteDecimal = vect[1];
	    }else{
	      parteDecimal="";
	    } 	    
	    count=0;
	    for (var l = parteEntera.length; l > 0; l--) {
	        ch = Numero.substring(l-1, l);	        
	        if (count%3==0 && count!=0){	          
                  nuevaParteEntera=ch+'.'+nuevaParteEntera;count++;
                }else{
                  nuevaParteEntera=ch+nuevaParteEntera;count++;
                }
	    }
	    if (parteDecimal!=""){
	      nuevoNumero=nuevaParteEntera+','+parteDecimal;
	    }else {
	      nuevoNumero=nuevaParteEntera;
	    }
	    return nuevoNumero;
        } 
        
        function AntiFormateaNumero(Numero){
	    Numero=String(Numero);
	    newNumber = "";    // REVISED/CORRECTED STRING    
	    for (var l = 0; l < Numero.length; l++) {
	        ch = Numero.substring(l, l+1);
	        if (ch >= "0" && ch <= "9") {
	            newNumber += ch;
	        }
	        if (ch ==","){
	            newNumber += '.';
	        } 
	    } 
	    return newNumber;
        }
        
        function alineaCelda(){
            document.formBot.sum.style.textAlign="right";
            document.form['sumaTotal'].elements['sumaTotal'].style.textAlign="right";
        } 

	/************ FUNCIONES DEL FRAME ANALIZAR  ****************/
	  var estado=0;

          function Seleccionar(NombreCampoCheck){ 
	      for (i=0; i<document.forms.length;i++){
                for (j=0; j<document.forms[i].elements.length;j++) {
                //formu_analizar[k].elements['SELECCION'].disabled=true;
                  if ((document.forms[i].elements[j].name==NombreCampoCheck) && (!document.forms[i].elements[j].disabled)) {
        	    document.forms[i].elements[j].checked=!(estado);
	          }
	        }
	      }
	   estado=!estado;
  	     
          ]]></xsl:text> 
          <xsl:choose>
            <xsl:when test="$accion='DIRECTO'">sumar_pedidoDirecto();</xsl:when>
            <xsl:otherwise>sumar_Multioferta();</xsl:otherwise>
          </xsl:choose>
            <xsl:text disable-output-escaping="yes"><![CDATA[            
          }
          
          function abrirVentana(pag) {
          window.open(pag,toolbar='no',menubar='no',status='no',scrollbars='yes',resizable='yes');
          }
          
          /********* AQUI EMPIEZAN LAS FUNCIONES DEL FRAME DE ABAJO (FECHAS) ***************/
          /********* AQUI EMPIEZAN LAS FUNCIONES DEL FRAME DE ABAJO (FECHAS) ***************/
          
          
         //var signo='';
         
         function obtenerSignoDelProveedor(proveedor){

           for(var i=0;i<arrayProveedores.length;i++){
             //alert('obtener: '+arrayProveedores[i][0]+' '+arrayProveedores[i][1]);

             if(arrayProveedores[i][0]==proveedor){
               //alert('obtener: '+arrayProveedores[i][0]+' '+arrayProveedores[i][1]);
               return arrayProveedores[i][1];
             }
           }
         }
         
         function setSignoDelProveedor(proveedor, elSigno){
           for(var i=0;i<arrayProveedores.length;i++){
             
             if(arrayProveedores[i][0]==proveedor){
               //alert('set: '+arrayProveedores[i][0]+' '+elSigno);
               arrayProveedores[i][1]=elSigno;
             }
           }
         }
         
         function resetSignoDelProveedor(){
           
           for(var i=0;i<arrayProveedores.length;i++){
               arrayProveedores[i][1]='';
           }
         }
         
         function insertarSiNoExiste(proveedor){
           var existe=0;
           for(var i=0;i<arrayProveedoresConDiferenteSigno.length;i++){
             if(arrayProveedoresConDiferenteSigno[i]==proveedor){
               existe=1;
             }
           }
           if(!existe)
             arrayProveedoresConDiferenteSigno[arrayProveedoresConDiferenteSigno.length]=proveedor;
           return arrayProveedoresConDiferenteSigno;
         }
         
         function comprobarTodasCantidadesMismoSigno(){
           var form;
           var id;
           var signoLocal='';
           for(var i=0;i<document.forms.length;i++){
             form=document.forms[i];

             for(var j=0;j<form.length;j++){
               if(form.elements[j].name.substring(0,14)=='NuevaCantidad_' && form.elements['SELECCION'].checked==true){
                
                 id=obtenerId(form.elements[j].name);

                 signoLocal=obtenerSignoDelProveedor(form.elements['PRODUCTOPROVEEDOR_'+id].value);

                 if(parseFloat(desformateaDivisa(form.elements[j].value))<0){
                   if(signoLocal=='' || signoLocal=='-'){
                    
                     setSignoDelProveedor(form.elements['PRODUCTOPROVEEDOR_'+id].value,'-');
                
                   }
                   else{
                     
                     arrayProveedoresConDiferenteSigno=insertarSiNoExiste(form.elements['PRODUCTOPROVEEDOR_'+id].value);
                     //return false;
                   }
                 }
                 else{
                   if(signoLocal=='' || signoLocal=='+'){
                     
                     setSignoDelProveedor(form.elements['PRODUCTOPROVEEDOR_'+id].value,'+');
                   }
                   else{
                     
                     arrayProveedoresConDiferenteSigno=insertarSiNoExiste(form.elements['PRODUCTOPROVEEDOR_'+id].value);
                     //return false;
                   }
                 }
               }
             }
           }

           if(arrayProveedoresConDiferenteSigno.length==0)
             return true;
           else 
             return arrayProveedoresConDiferenteSigno; 
         }
         
         function algunProveedorConCantidadesNegativas(msgCantidadNegativa){
           msgCantidadNegativa='';
           var existe=0;
           for(var n=0;n<arrayProveedores.length;n++){
             if(arrayProveedores[n][1]=='-' && !existe){
               existe=1;
               msgCantidadNegativa+=document.forms['form_iddivisa'].elements['CANTIDADES_NEGATIVAS'].value;
               //arrayProveedores[n][0]
             }
           }
           return msgCantidadNegativa;
         }
          
         
         function asignarMensajeProveedoresDiferenteSigno(arrayProveedoresConDiferenteSigno){
           var msgDiferenteSigno='';
           if(arrayProveedoresConDiferenteSigno.length>0){
             for(var n=0;n<arrayProveedoresConDiferenteSigno.length;n++){
               msgDiferenteSigno+=document.forms['form_iddivisa'].elements['VERIFIQUE_CANTIDADES_ABONO'].value+' '+arrayProveedoresConDiferenteSigno[n]+' '+ document.forms['form_iddivisa'].elements['SON_TODAS_NEGATIVAS'].value+'.\n';
             }
           }
           
           return msgDiferenteSigno;
         }
    
    
    //pedido minimo compruebacion
    function pedidoMinimo(pedMinimo, total)
    {
        var msg = '';
    
        var tot = new String();
        var tot = total;
    
        if (tot.match('.')){
            var part = tot.split('.');
            var tots = part[0]+part[1];
            }
    
        if (parseInt(tots) < parseInt(pedMinimo)){
    
            msg += document.forms['form_iddivisa'].elements['PEDIDO_NO_LLEGA'].value +' '+ pedMinimo +' '+ document.forms['form_iddivisa'].elements['EUROS'].value +'.\n' + document.forms['form_iddivisa'].elements['POR_FAVOR_REVISE'].value;
            }
    
    
    
        return msg;
    }//fin pedidoMinimo
    
	//control pedido minimo
	function controlPedido(formu_botones,formu_analizar,accio, pedMinimo){
		//pedMinimo Ya no se tiene que pasar como parametro, sinó que se coje del input CEN_PEDIDOMINIMO
		pedMinimo	= document.getElementById('CEN_PEDIDOMINIMO').value;
		pedMinimoTipo	= document.getElementById('CEN_TIPOPEDIDOMINIMO').value;
                
		// Esconder boton de continuar para evitar doble-click
		jQuery('#divContinuar').hide();

		var pedidoOk	= pedidoMinimo(pedMinimo,document.forms['sumaTotal'].elements['sumaTotal'].value);

		if(pedidoOk != '' && pedidoOk != 0 && pedMinimoTipo == 'E'){
			alert(pedidoOk);
			// Volver a mostrar el boton de continuar ya que no cumple la validacion
			jQuery('#divContinuar').show();
		}else{
			Actua(formu_botones,formu_analizar,accio);
		}
	}//fin de control pedido minimo
         
         
	//  Validaciones y envío del formulario
	function Actua(formu_botones,formu_analizar,accio){
		//anadido 11-05-12 mi si no lugar entrega se quedaba en el por defecto, ahora lo cogemos del select
		var centro = document.forms['formBot'].elements['IDCENTRO'].value;
		document.forms['formBot'].elements['IDLUGARENTREGA'].value = document.forms['formBot'].elements['IDLUGARENTREGA_'+centro].value;

		select = new Array;
		selectCantidades = new Array;
		noselect = new Array;
		var mensajeError="";
		var fecha2;

		// Esconder boton de continuar para evitar doble-click
		jQuery('#divContinuar').hide();
		resetSignoDelProveedor();
		arrayProveedoresConDiferenteSigno.length=new Array();

	]]></xsl:text>
	<xsl:if test="$accion='DIRECTO'">
		if(comprobarTodasCantidadesMismoSigno()!=true){
			mensajeError=asignarMensajeProveedoresDiferenteSigno(arrayProveedoresConDiferenteSigno);
		}
	</xsl:if>
	<xsl:text disable-output-escaping="yes"><![CDATA[

		//for(var i=0;i<arrayProveedores.length;i++){
			//  alert('mostrar: '+arrayProveedores[i]);
		//}

	]]></xsl:text>
	<xsl:choose>
	<xsl:when test="$accion='DIRECTO'">
		InformaSeleccionaAlgun='<xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_puede_enviar_pedido']/node()"/>';
	</xsl:when>
	<xsl:otherwise>
		InformaSeleccionaAlgun='<xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_puede_enviar_oferta']/node()"/>';
	</xsl:otherwise>
	</xsl:choose>
	<xsl:text disable-output-escaping="yes"><![CDATA[

		AsignarAccion(formu_botones,accio);
		//comentado 10/12/13 envio solo cantidades de los select  > formu_botones.elements['STRING_CANTIDADES'].value=ConstruirStringCantidades();

		for(j=0;j<document.forms.length;j++){
			if(document.forms[j].name!='formBot' && document.forms[j].name!='form_iddivisa' && document.forms[j].name!='sumaTotal' && document.forms[j].name!='spiffyCal' && document.forms[j].name!='form_catpriv'){
				agrupaArray(formu_analizar[j],'SELECCION');

				//16jul09	ET	notAgrupaArray(formu_analizar[j],'SELECCION');

				// Concatenamos el elemento SELECCIONTOTAL creado en la variable select
				if (formu_analizar[j].elements['SELECCIONTOTAL'].value!=''){
					//MC 10/12/13 envio solo cantidades de los select

					var cant = formu_analizar[j].elements['NuevaCantidad_'+formu_analizar[j].elements['SELECCIONTOTAL'].value].value;
                selectCantidades += '('+formu_analizar[j].elements['SELECCIONTOTAL'].value+'|'+ cant +')';
                
              if (select == ''){                
                select+=formu_analizar[j].elements['SELECCIONTOTAL'].value;
              }              
              else{            
                select+=','+formu_analizar[j].elements['SELECCIONTOTAL'].value;	          
              }
            }
			/*	16jul09	ET Ya no enviamos los no seleccionados => mas rapido
            // Concatenamos el elemento NOSELECCIONTOTAL creado en la variable noselect
            if (formu_analizar[j].elements['NOSELECCIONTOTAL'].value!="")
			{
              if (noselect == ""){            	          
                noselect=formu_analizar[j].elements['NOSELECCIONTOTAL'].value;
              }
              else{
                noselect+=','+formu_analizar[j].elements['NOSELECCIONTOTAL'].value;
              }
            }
			*/
          }//if                         
        } // for (j...
        
        //MC 10/12/13 envio solo cantidades de los select

        formu_botones.elements['STRING_CANTIDADES'].value = selectCantidades;
        //alert('cant form ' + formu_botones.elements['STRING_CANTIDADES'].value);
        
        formu_botones.elements['SELECCIONTOTAL'].value=select;
       //16jul09	ET	 formu_botones.elements['NOSELECCIONTOTAL'].value=noselect;

        //alert(formu_botones.elements['SELECCIONTOTAL'].name+'='+formu_botones.elements['SELECCIONTOTAL'].value+' // '+formu_botones.elements['NOSELECCIONTOTAL'].name+'='+formu_botones.elements['NOSELECCIONTOTAL'].value);
        if (select==""){
          alert(InformaSeleccionaAlgun);
          jQuery('#divContinuar').show();
        }else{
          if  (test(formu_botones)){
            fechaActualTemp = new Date();
            fechaActual=fechaActualTemp.getDate()+'/'+eval(fechaActualTemp.getMonth()+1)+'/'+fechaActualTemp.getFullYear();
            ]]></xsl:text>  
            <xsl:choose>
            <xsl:when test="$accion='DIRECTO'">
              if (comparaFechas(formu_botones.elements['FECHA_PAGO'].value,fechaActual)=='&lt;'){ 

              mensajeError='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pago_mayor']/node()"/>\n'; 
            }

            if (comparaFechas(formu_botones.elements['FECHA_ENTREGA'].value,fechaActual)=='&lt;'){  
                mensajeError+='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite_respuesta']/node()"/>\n'; 
            }
            </xsl:when>

            <xsl:otherwise>
			
            
            // Copiamos el campo FECHANO_ENTREGA dentro de FECHA_ENTREGA para hacer el submit.
            formu_botones.elements['FECHA_ENTREGA'].value = formu_botones.elements['FECHANO_ENTREGA'].value;
            if (formu_botones.elements['FECHANO_ENTREGA'].value!='') 
            {
	            if (comparaFechas(formu_botones.elements['FECHANO_ENTREGA'].value,fechaActual)=='&lt;'){ 
	              mensajeError='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_mayor']/node()"/>\n'; 
	            }
	            if (comparaFechas(formu_botones.elements['FECHANO_ENTREGA'].value,formu_botones.elements['FECHA_DECISION'].value)=='&lt;') {
	                mensajeError+='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega_mayor_fecha_limite']/node()"/>\n';
	            }
	    	}
	    	if (comparaFechas(formu_botones.elements['FECHA_DECISION'].value,fechaActual)=='&lt;'){  
                mensajeError+='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite_respuesta']/node()"/>\n';
                }
	    	</xsl:otherwise>
	    </xsl:choose>

            <xsl:text disable-output-escaping="yes"><![CDATA[  
            copiarFormaPago();
			
			if (parseFloat(document.forms['formBot'].elements['sumanumerica'].value)>10000)
			{
				if (confirm(document.forms['form_iddivisa'].elements['PEDIDO_SUPERA_DIESMIL'].value)==false)
				return;
			}	
			
            //19-09-11 si es solicitud muestras compruebo que num solicitud sea minor de 15
            
            if (document.forms['sumaTotal'].elements['sumaTotal'].value=='Sol.Muestra' && document.forms['sumaTotal'].elements['NUM_MUESTRAS'].value > 14){
            		//alert('mi '+document.forms['sumaTotal'].elements['NUM_MUESTRAS'].value);
                    
                	alert(document.forms['form_iddivisa'].elements['LIMITE_MUESTRAS'].value);
                    document.getElementById('botonContinuar').disabled = true;
            }
            else{ 
                
                suma=parseFloat(desformateaDivisa(document.forms['formBot'].elements['sum'].value));
               
                suma = anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(suma),2)),2);
                
                
                //COPIO EN FORMU_BOTONES PARA QUE SE ENVIE
                //formu_botones.elements['sumaTotal'].value =  document.forms['sumaTotal'].elements['sumaTotal'].value;
                formu_botones.elements['COSTE_LOGISTICA'].value =  document.forms['sumaTotal'].elements['COSTE_LOGISTICA'].value;
                
                 //envio
                if (mensajeError==""){  
                  if((msgCantidadNegativa=algunProveedorConCantidadesNegativas(msgCantidadNegativa))!=''){
                    if(confirm(msgCantidadNegativa)){
                      SubmitForm(formu_botones, document);
                    }
                  }
                  else{
                    if(formu_botones.elements['STRING_CANTIDADES'].value!=''){
                    
                      SubmitForm(formu_botones, document);
                    }
                  }
                }
                else{
                  alert(mensajeError);
                  //16jul09	ET	volvemos a activar el botón
                    jQuery('#divContinuar').show();
                } 
                //fin if-else envio
                
           }//fin else de muestras       
          }
            
        }
      }
      
	function copiarFormaPago()
	{
		document.forms['formBot'].elements['LP_IDFORMAPAGO'].value=document.forms['formBot'].elements['IDFORMAPAGO'].value;
		document.forms['formBot'].elements['LP_IDPLAZOPAGO'].value=document.forms['formBot'].elements['IDPLAZOPAGO'].value;
		document.forms['formBot'].elements['LP_FORMAPAGO'].value=document.forms['formBot'].elements['FORMAPAGO'].value;
	}
      
        /**********************  Nuevas Funciones para el cambio de cantidades **********************/
        //
	//  Construimos el string de cantidades de las lineas de multioferta.
	//  (PLL_ID|CANTIDAD)(100|300.4)
	//
	
	function ConstruirStringCantidades() {
	     formu=document.forms;
	     var cadena="";
	     var cant;
	     for (i=0;i<formu.length;i++) // barrido de los forms
	       {
	       for (j=0;j<formu[i].length;j++) // barrido de los elementos
	        {
	        if (formu[i].elements[j].name.substring(0,14)=="NuevaCantidad_")
	            {
	              
	              ]]></xsl:text>
		        <xsl:if test="$accion='EDICION'">
		        if(checkNumber(desformateaDivisa(formu[i].elements[j].value),formu[i].elements[j])){
		        </xsl:if>
		      <xsl:text disable-output-escaping="yes"><![CDATA[

	                cant=Antiformatea(formu[i].elements[j].value);
	                cadena+="(" + formu[i].elements[j].name.substring(14,formu[i].elements[j].name.length) + "|" + cant + ")";	            
	              
	               ]]></xsl:text>
		        <xsl:if test="$accion='EDICION'">
		        }
	              else{
	                return '';
	              }
		        </xsl:if>
		      <xsl:text disable-output-escaping="yes"><![CDATA[
	              
	            }
	        }
	       }
	       return cadena;       
     	 }
         
         
     	 //
     	 // Recalculo el importe cuando cambia la cantidad
     	 //         
         function Cantidad2Importe(formu,pll_id,accion,hayPrecio){
          var formBot = document.forms['formBot'];

          if (hayPrecio){
                        
             if(esEnteroConSigno(desformateaDivisa(formu.elements['NuevaCantidad_'+pll_id].value)))
			 {
				var cant = desformateaDivisa(formu.elements['NuevaCantidad_'+pll_id].value);
				var precio = desformateaDivisa(formu.elements['PRECIOUNITARIO_'+pll_id].value);    
				var resultado = parseFloat(cant)*parseFloat(precio);
				formu.elements['NuevoImporte_'+pll_id].value=anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(resultado,2))),2);    
                //	ET 22feb11 Redondeamos a 2 decimales, forzamo en lugar de   Divisas[obtenerIdDivisa(formu,'IDDIVISA')][3]
				
                //alert(document.forms['form_iddivisa'].elements['OCULTARPRECIOREFERENCIA'].value);
                
            	if (document.forms['form_iddivisa'].elements['OCULTARPRECIOREFERENCIA'].value=='N')
				{
					var precioConIVA = desformateaDivisa(formu.elements['PRECIOUNITARIOCONIVA_'+pll_id].value);    
					var resultadoConIVA = parseFloat(cant)*parseFloat(precioConIVA);
					
                   
 					formu.elements['NuevoImporteConIVA_'+pll_id].value=anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(resultadoConIVA,2))),2);         //	ET 22feb11 Redondeamos a 2 decimales       
                } 
            	if (formu.elements['SELECCION'].checked==true)
				{
	        		if (accion=='EDICION') 
	        			sumar_Multioferta();
	        		else
	        			sumar_pedidoDirecto(); 
	       		}
	      }	
	    }    
          }
          
          function tienePuntuacion(valor){
            if(tienePunto(valor))
              return true;
            else
              if(tieneComa(valor))
                return true;
              else
                return false;
          }
          
          function esNegativo(valor){
            valor+='';
            for(var n=0;n<valor.length;n++){
              if(valor.substring(n,n+1)=='-')
                return true;
            }
            return false;
          }
          
          function confirmarSignoCantidad(valor){
            if(esNegativo(valor)){
              return confirm(msgCantidadNegativa);
            }else{
              return true;
            }
          }
          
          
         
	//
	// Comprueba que el numero de unidades introducidas coincide con un multiplo del
	// numero de lotes
	// Se pide confirmacion para redondearlo a la alza si no es asi.
	//	13mar07	ET	Permitir cantidad 0 para muestras, correcciones varias
	//	21set10	ET	Algunos proveedores tienen bloqueadas las muestras
     var v_SolicitudMuestras='NO';	<!--	10abr07	ET	control de solicitud de muestras	-->

	function UnidadesALotes(unidades,unidadesporlote,objeto,formu){
		var identificador=objeto.name.substr(14,objeto.name.length);
		var result=true;

		if(objeto.value == "" ){
			//alert('Cantidad incorrecta, se sustituye por 1');
			alert(document.forms['form_iddivisa'].elements['CANTIDAD_INCORRECTA'].value);

			unidades=1;
			objeto.value=1;
			//result=false;
		}else{
			var accion=']]></xsl:text><xsl:value-of select="$accion" /><xsl:text disable-output-escaping="yes"><![CDATA[';

			if(accion=='DIRECTO'){
				if(objeto.value == 0){
					if (document.forms['form_catpriv'].elements['CATPRIV_ESTRICTO'].value=='N'){
						alert(document.forms['form_iddivisa'].elements['CANTIDAD_NO_O'].value);
						unidades=1;
						objeto.value=1;
					}else{
						if (v_SolicitudMuestras=='NO'){
							if (SolicitudMuestras(formu)=='N')
								unidades = unidadesporlote;
							else
								result=false;
						}
					}
				}else if(!esEnteroConSigno(objeto.value)){
					alert(document.forms['form_iddivisa'].elements['CANTIDAD_INCORRECTA'].value);
					unidades=1;
					objeto.value=1;
					//result=false;
				}
			}else{
				if(objeto.value == 0 || !esEntero(objeto.value)){
					alert(document.forms['form_iddivisa'].elements['CANTIDAD_INCORRECTA'].value);
					unidades=1;
					objeto.value=1;
					//result=false;
				}
			}
		}

		if (result==true){
			var lotes;
			if (unidades%unidadesporlote==0){
				lotes=unidades/unidadesporlote;
				var nuevasUnidades=unidadesporlote*lotes;
				formu.elements['NuevaCantidad_'+identificador].value=nuevasUnidades;
				result=true;
			}else{
				lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;
				alert(unidades+ document.forms['form_iddivisa'].elements['REDONDEO_UNIDADES'].value +'\n'+ document.forms['form_iddivisa'].elements['REDONDEO_UNIDADES_2'].value +Math.abs(lotes)+ document.forms['form_iddivisa'].elements['CAJAS'].value + '. ('+Math.abs(unidadesporlote*lotes)+ document.forms['form_iddivisa'].elements['UNIDADES'].value + ')');	          

				var nuevasUnidades=unidadesporlote*lotes;
				if(unidades>0)
					formu.elements['NuevaCantidad_'+identificador].value=nuevasUnidades;
				else
					formu.elements['NuevaCantidad_'+identificador].value=-nuevasUnidades;
				result=true;
			}
		}
		return result;
	}

//	Esta función realiza los cambios en el pedido necesario para que sea considerado una solicitud de muestras
function PrepararSolicitudMuestras(form){
  
    SolicitudMuestras(form); 
}


//	Esta función realiza los cambios en el pedido necesario para que sea considerado una solicitud de muestras
function SolicitudMuestras(form){
	//if si cliente ya ha pedido muchas muestras
	if (document.forms['sumaTotal'].elements['NUM_MUESTRAS'].value > 14){
            		//alert('mi '+document.forms['sumaTotal'].elements['NUM_MUESTRAS'].value);
                    
                	alert(document.forms['form_iddivisa'].elements['SUPERADO_LIMITE_MUESTRAS'].value);
                    
                    document.getElementById('botonContinuar').style.display =='none';
            }
        else{
    
        if (document.forms['form_iddivisa'].elements['BLOQUEARMUESTRAS'].value=='S')
        {
            alert(document.forms['form_iddivisa'].elements['NO_MUESTRAS'].value);
            return('N');
        }
        else{
        
            alert(document.forms['form_iddivisa'].elements['SOLICITUD_MUESTRAS'].value);
            for(var i=0;i<document.forms.length;i++)
            {
              if(document.forms[i].name.substring(0,5)=='form_')
              {
                var form=document.forms[i];
                for(var n =0;n<form.length;n++)
                {
                  if(form.elements[n].name.substring(0,14)=='NuevaCantidad_')
                  {
                    var id=obtenerId(form.elements[n].name);
                    form.elements[n].value='0';
                    form.elements[n].disabled=true;
                    form.elements[n].grayed=true;
                    form.elements['NuevoImporte_'+id].value=document.forms['sumaTotal'].elements['sumaTotal'].value=document.forms['form_iddivisa'].elements['SOL_MUESTRAS'].value;
                  }
                }
              }
            }
            document.forms['sumaTotal'].elements['sumaTotal'].value=document.forms['sumaTotal'].elements['sumaTotal'].value=document.forms['form_iddivisa'].elements['SOL_MUESTRAS'].value;;
            v_SolicitudMuestras='SI';
            return('S');
        }
    }//fin de else si cliente ya ha pedido muchas muestras
}        


function inicializarFecha(nombreCombo,fecha)
{

  document.forms['formBot'].elements['COMBO_'+nombreCombo].value=0;
  document.forms['formBot'].elements[fecha].value='';

}


    function calculaFechaHidden(nom,mas){ // nom:nombre del combo; mas:incremento del "delay" cf sabado, domingo...
          
                            alert('mi');
          var hoy=new Date(); 
          
          
          if(nom=='ENTREGA' || nom=='DECISION'){
            var Resultado=calcularDiasHabiles(hoy,mas);
          }
          else{
            var Resultado=sumaDiasAFecha(hoy, mas);
          
               // gestion de los sabados y domingos...
               diaSemana = Resultado.getDay();
          
               if (diaSemana==0) 
                 Resultado=sumaDiasAFecha(Resultado,1);
               else 
                 if (diaSemana==6) 
                   Resultado=sumaDiasAFecha(Resultado,2);
          }
          
          // imprimir datos en los textbox en el formato dd/mm/aaaa....
          
          var elDia=Resultado.getDate();
          var elMes=Number(Resultado.getMonth())+1;
          var elAnyo=Resultado.getFullYear();
          var laFecha=elDia+'/'+elMes+'/'+elAnyo;
          document.forms['formBot'].elements[nom].value=laFecha;
    }


      
       function separadoresCorrectos(fecha){

         var separadores=0;
         for(var n=0;n<fecha.length;n++){
           if(fecha.substring(n,n+1)=='/')
             separadores++;
         }
         alert(separadores);
         if(separadores==2)
           return true;
         else
           return false;
       }
       
       /*
           funcion para obtener dias, meses, anyo de una cadena 'xx/xx/xxxx'
       
       */
       
       function obtenerSubCadena(fecha, posicion){
         
         var separador_1;
         var separador_2;
         
         var separadores=0;
         
         for(var n=0;n<fecha.length;n++){
           if(fecha.substring(n,n+1)=='/'){
             separadores++;
             if(separadores==1){
               separador_1=n;
             }
             else
               if(separadores==2)
                 separador_2=n;
           }
         }
         if(posicion==1){
           return fecha.substring(0,separador_1);
         }
         else
           if(posicion==2){
             return fecha.substring(separador_1+1,separador_2);
           }
           else{
             return fecha.substring(separador_2+1,fecha.length);
           }
             
       }
       
       
 

    function calculaFecha(nom,mas){ // nom:nombre del combo; mas:incremento del "delay" cf sabado, domingo...
    /*
      se calculan los dias habiles
     
      A la hora de calcular la fecha hay un caso especial que es que la fecha de entrega no se quiera informar.
      en ese caso la fecha es NULL
 
      Cambios introducidos:
      - Utiliza las funciones de suma de fechas de Javascript
      - Separar el tratamiento de los controles del tratamiento de las fechas
      - Corrección del error en Netscape y Mozilla que presenta la fecha 101 en lugar de 2001
      - Corrección del error en todas las plataformas que presenta fecha 0/mm/yyyy
    */
        
        if(nom=='ENTREGANO' && document.forms['formBot'].elements['IDPLAZO'+nom].options[document.forms['formBot'].elements['IDPLAZO'+nom].selectedIndex].value==0){
          document.forms['formBot'].elements['FECHANO_ENTREGA'].value='';
        }
        else{
            var hoy=new Date();
           
           /*
              nacho 13/11/2002
              para la entrega y la decision se calculan dias habiles
              para el pago naturales
           
           */
            
          if(nom=='ENTREGA' || nom=='DECISION'){
          
          /* para la fecha de entrega si el valor del desplegable es otros calculamos con el plazo minimo posible */
          
          if(mas==999){
            ]]></xsl:text>   
	          mas='<xsl:value-of select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>';
	          <xsl:text disable-output-escaping="yes"><![CDATA[ 
	        }
          
            var Resultado=calcularDiasHabiles(hoy,mas);
          }
          else{
            
            /* para la fecha de pago si el valor del desplegable es otros calculamos la de hoy */
            if(mas==999){
	            mas=0;
	          }
          
            var Resultado=sumaDiasAFecha(hoy, mas);
                      
               // gestion de los sabados y domingos...
               diaSemana = Resultado.getDay();
          
               if (diaSemana==0) 
                 Resultado=sumaDiasAFecha(Resultado,1);
               else 
                 if (diaSemana==6) 
                   Resultado=sumaDiasAFecha(Resultado,2);
          }
            
           
          // imprimir datos en los textbox en el formato dd/mm/aaaa....
          
          var elDia=Resultado.getDate();
          var elMes=Number(Resultado.getMonth())+1;
          var elAnyo=Resultado.getFullYear();
          var laFecha=elDia+'/'+elMes+'/'+elAnyo;
          if (nom=='ENTREGANO'){     
            document.forms['formBot'].elements['FECHANO_ENTREGA'].value = laFecha;
          }
          else{  
            document.forms['formBot'].elements['FECHA_'+nom].value = laFecha;
          }
        //if(document.forms['formBot'].elements['COMBO_'+nom].options[document.forms['formBot'].elements['COMBO_'+nom].options.selectedIndex].value!='0'){
          //alert(document.forms['formBot'].elements['COMBO_'+nom].options[document.forms['formBot'].elements['COMBO_'+nom].options.selectedIndex].value);
         // document.forms['formBot'].elements['COMBO_'+nom].options[document.forms['formBot'].elements['COMBO_'+nom].options.selectedIndex].value;      
        //}
      } 
      
    } 
    
    
    function realizarCalculos(form,PLL_ID,accion,hayPrecio){
      Cantidad2Importe(form,PLL_ID,accion,hayPrecio);  
    } 
    
    function realizarCalculosPorDefinir(form,PLL_ID,accion,hayPrecio){
    	//alert('mi '+form.elements['UNIDADESPORLOTE_'+PLL_ID].value);

    	if (document.forms['sumaTotal'].elements['NUM_MUESTRAS'].value > 14){ 
        	form.elements['NuevaCantidad_'+PLL_ID].value = form.elements['UNIDADESPORLOTE_'+PLL_ID].value;
        }
        else{
              if(form.elements['NuevoImporte_'+PLL_ID])
                form.elements['NuevoImporte_'+PLL_ID].value=document.forms['sumaTotal'].elements['sumaTotal'].value=document.forms['form_iddivisa'].elements['SOL_MUESTRAS'].value;;
              if (accion=='DIRECTO') 
                sumar_pedidoDirecto(); 
              //Cantidad2Importe(form,PLL_ID,accion,hayPrecio); 
            }
    }
      

        function obtenerValorMinimo(objDepl){
          var minimo;
          
          minimo=parseInt(objDepl.options[0].value);
          for(var n=1;n<objDepl.options.length;n++){
            if(parseInt(objDepl.options[n].value)<minimo){
              minimo=parseInt(objDepl.options[n].value);
            }
          }
          return minimo;
        }
        
        
        function calculaFechaMinima(objDespl,queCampo){
          var hoy=new Date();
          
          if(queCampo=='ENTREGA'){
            fechaEntregaMinima=calcularDiasHabiles(hoy,obtenerValorMinimo(objDespl));
          }
        }

      function validarCantidades(){
        
        var cambiosCantidadesInicio= document.forms['form_iddivisa'].elements['CAMBIOS_CANTIDADES_INICIO'].value +'\n\n';
        var cambiosCantidades='';
        var avisarCambios=0;
        var numLineas=0;
        var masLineas=0;
        for(var i=0;i<document.forms.length;i++){
          if(document.forms[i].name.substring(0,5)=='form_'){
            var form=document.forms[i];
            for(var n =0;n<form.length;n++){
              if(form.elements[n].name.substring(0,14)=='NuevaCantidad_'){
                
                var id=obtenerId(form.elements[n].name);
                
                var unidades=parseInt(form.elements[n].value);
                var nombre=form.elements['DESCRIPCION_PRODUCTO_'+id].value;
                var unidadesPorLote=parseInt(form.elements['PRO_UNIDADESPORLOTE_'+id].value);

                var lotes;
                var nuevasUnidades;
                
                if (unidades%unidadesPorLote==0){
	                lotes=unidades/unidadesPorLote;
	                nuevasUnidades=unidadesPorLote*lotes;	
	                form.elements['NuevaCantidad_'+id].value=nuevasUnidades;
	              }
	              else{
	                lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesPorLote))/unidadesPorLote+1;
	                nuevasUnidades=unidadesPorLote*lotes;	
	                if(!avisarCambios){
	                  avisarCambios=1;
	                }
	                numLineas++;
	                if(numLineas<=5){
	                  cambiosCantidades+='* '+nombre+'\n '+document.forms['form_iddivisa'].elements['CANTIDAD_ANTERIOR'].value+': '+unidades+document.forms['form_iddivisa'].elements['UNIDADES_NUEVA_CANTIDAD'].value+': '+nuevasUnidades+document.forms['form_iddivisa'].elements['UNIDADES_CORRESPONDE_A'].value+' '+lotes+document.forms['form_iddivisa'].elements['CAJAS'].value+'\n\n';
	                }
	                form.elements['NuevaCantidad_'+id].value=nuevasUnidades;
	                form.elements['NuevaCantidad_'+id].focus();
	                form.elements['NuevaCantidad_'+id].blur();
	              }  
              }
            }
          }
        }
        if(avisarCambios){
          if(numLineas>5){
            cambiosCantidadesInicio+= document.forms['form_iddivisa'].elements['MODIFICACIONES_CINCO_LINEAS'].value + '\n';
          }
          cambiosCantidadesInicio+= document.forms['form_iddivisa'].elements['MODIFICADO_CANTIDADES'].value + numLineas+ document.forms['form_iddivisa'].elements['LINEAS'].value + '.\n\n';
          
			//	12set07	ET	Por solicitud de AL no mostramos el mensaje al hacer el cambio
			// alert(cambiosCantidadesInicio+cambiosCantidades);
        }
      }
      
      function calculaFechaCalendarios(mas){
          var hoy=new Date();
          var Resultado=calcularDiasHabiles(hoy,mas);  
 
          var elDia=Resultado.getDate();
          var elMes=Number(Resultado.getMonth())+1;
          var elAnyo=Resultado.getFullYear();
          var laFecha=elDia+'/'+elMes+'/'+elAnyo;
          
          return laFecha;   
    }
    
    function asignarValorDesplegable(form,nombreObj,valor){
      var indiceSeleccionado=form.elements[nombreObj].length-1;
      for(var n=0;n<form.elements[nombreObj].length;n++){
        if(form.elements[nombreObj].options[n].value==valor){
          indiceSeleccionado=n;
        }
      }
      form.elements[nombreObj].selectedIndex=indiceSeleccionado;
    }
    
    
    function actualizarPlazo(form,nombreObj, fFechaOrigen){


      var fechaOrigen=fFechaOrigen.getDate()+'/'+(Number(fFechaOrigen.getMonth())+1)+'/'+fFechaOrigen.getFullYear();
      var fechaDestino=form.elements['FECHA_'+nombreObj].value;
      var nombreCombo;
     
      
      if(CheckDate(fechaDestino)==''){
        var fFechaDestino=new Date(formatoFecha(fechaDestino,'E','I'));
        
        
        if(nombreObj=='ENTREGA'){
          var diferencia=diferenciaDias(fFechaOrigen,fFechaDestino,'HABILES');
          nombreCombo='COMBO_'+nombreObj;
        }
        else{
          var diferencia=diferenciaDias(fFechaOrigen,fFechaDestino,'NATURALES');
          nombreCombo='IDPLAZOPAGO';
        }
        asignarValorDesplegable(form,nombreCombo,diferencia);     
      }
      else{
        alert(CheckDate(fechaDestino));
      }
    }
    
    //cuando selecionamos un  producto que requiere presupuesto 29-10-14
    function requierePresupuesto(){
        jQuery("#titulo").html(document.forms['form_iddivisa'].elements['SOLICITUD_DE_PRESUPUESTO'].value);
	
    }// fin requierePresupuesto
     
     /*
     function handleKeyPress(e) {
	
	  var keyASCII;
	  
	  if(navigator.appName.match('Microsoft')){
	    var keyASCII=event.keyCode;
	    var eSrc=event.srcElement;
	    if (keyASCII == 13)
	      FeSrc.blur();
	  }
	  else{
            keyASCII = (e.which);
          }  
                            
        } 
	
	if(navigator.appName.match('Microsoft')==false)
	  document.captureEvents();
	document.onkeypress = handleKeyPress;
        */
              
           
	  //-->
	</script>
	]]>
	</xsl:text>         	       
      </head>                       
      <!-- -->                
      <xsl:variable name="num_cols"><xsl:value-of select="count(//PRODUCTOS_ROW)"/></xsl:variable> 
      
      <body class="gris">  
       
      <xsl:choose><!-- error -->
          <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>         
          </xsl:when> 
          <xsl:when test="//SESION_CADUCADA">
            <xsl:apply-templates select="//SESION_CADUCADA"/>        
          </xsl:when> 
          <xsl:otherwise> 
        <!--Avisamos de que hemos terminado la carga del frame.	heAcabado - tipo 1=Multioferta   tipo 0=Pedido directo-->   
       
        <xsl:attribute name="onLoad">
          inicializarDivisas();
          validarCantidades();
          <xsl:choose>
            <xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">
               inicializarDesplegableCentros(<xsl:value-of select="//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID"/>);
            </xsl:when>
            <xsl:otherwise>
              
               inicializarDesplegableCentros(<xsl:value-of select="//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID"/>); 
               inicializarDesplegableCentrosConsumo(<xsl:value-of select="//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID"/>);
               
               <!--inicializarDesplegableLugaresEntrega(<xsl:value-of select="//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID"/>);
               inicializarDesplegableAlmacenesInternos(<xsl:value-of select="//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID"/>);-->
            </xsl:otherwise>
          </xsl:choose>
			
           
            
          <xsl:choose>
            <xsl:when test="$accion='DIRECTO'">
              heAcabado(0);calculaFecha('ENTREGA',document.forms[0].elements['COMBO_ENTREGA'].value);calculaFecha('PAGO',document.forms[0].elements['IDPLAZOPAGO'].value);calculaFechaMinima(document.forms[0].elements['COMBO_ENTREGA'],'ENTREGA');
            </xsl:when>
            <xsl:otherwise>
              inicializarPedidoMinimo(document);heAcabado(1);<!--inicializarFecha('ENTREGANO','FECHANO_ENTREGA');-->calculaFechaHidden('FECHA_DECISION',1);
            </xsl:otherwise>
          </xsl:choose>
          //inicializarDivisas();
        </xsl:attribute>
        
        <xsl:if test="$accion='DIRECTO'">
          <div id="spiffycalendar" class="text"></div>
          <script type="text/javascript">
            var calFechaEntrega = new ctlSpiffyCalendarBox("calFechaEntrega", "formBot", "FECHA_ENTREGA","btnDateFechaEntrega",calculaFechaCalendarios('<xsl:value-of select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>'),scBTNMODE_CLASSIC,'ONCHANGE|actualizarPlazo(document.forms[\'formBot\'],\'ENTREGA\',new Date());#CHANGEDAY|actualizarPlazo(document.forms[\'formBot\'],\'ENTREGA\',new Date());');
          </script>
          
          <script type="text/javascript">
            var calFechaPago = new ctlSpiffyCalendarBox("calFechaPago", "formBot", "FECHA_PAGO","btnDateFechaPago",calculaFechaCalendarios('<xsl:value-of select="/Analizar/ANALISIS/CABECERA/LISTA/PLAZOSPAGO/field/@current"/>'),scBTNMODE_CLASSIC,'ONCHANGE|actualizarPlazo(document.forms[\'formBot\'],\'PAGO\',new Date());#CHANGEDAY|actualizarPlazo(document.forms[\'formBot\'],\'PAGO\',new Date());');
          </script>
        </xsl:if>
             
              
        <!--Creamos un array con los productos y los precios-->
        <SCRIPT type="text/javascript">
          crearArray('<xsl:value-of select="$num_cols"/>');<xsl:for-each select="Analizar/ANALISIS/LINEAS/LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW">anadirArray('<xsl:value-of select="PLL_ID"/>','<xsl:value-of select="TOTAL"/>');</xsl:for-each>                       
        </SCRIPT>
 
		 <xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>
        
		
        <xsl:apply-templates select="Analizar/ANALISIS/CABECERA/LISTA"/>        
        
         <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>       <!--idioma fin-->
      
     
      
       
        <form name="form_iddivisa" target="mainFrame">
		<input type="hidden" name="OCULTARPRECIOREFERENCIA" value="{$OcultarPrecioReferencia}"/>
		<input type="hidden" name="IDDIVISA" value="0"/>
		<input type="hidden" name="LP_PLAZOENTREGA" value="{/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA}"/>
		<input type="hidden" name="CATEGORIA" value="{/Analizar/ANALISIS/CATEGORIA}"/>
		<input type="hidden" name="IDLUGARENTREGAANTERIOR" value="{/Analizar/ANALISIS/CABECERA/LISTA/IDLUGARENTREGAANTERIOR}"/>

		<!--	20set10	Bloquear Muestras	-->
		<input type="hidden" name="BLOQUEARMUESTRAS" value="{/Analizar/ANALISIS/BLOQUEARMUESTRASCLIENTE}"/>

		<!--MENSAJE JS-->
		<input type="hidden" name="CANTIDAD_INCORRECTA" value="{document($doc)/translation/texts/item[@name='cantidad_incorrecta_sostituye']/node()}" />
		<input type="hidden" name="MSG_ERROR" value="{document($doc)/translation/texts/item[@name='msg_error']/node()}" />
		<input type="hidden" name="FECHA_MINIMA" value="{document($doc)/translation/texts/item[@name='fecha_minima']/node()}"/>
		<input type="hidden" name="SOLICITUD_MUESTRAS" value="{document($doc)/translation/texts/item[@name='solicitud_muestras_pedido']/node()}"/>
		<input type="hidden" name="NO_MUESTRAS" value="{document($doc)/translation/texts/item[@name='no_muestras']/node()}"/>
		<input type="hidden" name="LIMITE_MUESTRAS" value="{document($doc)/translation/texts/item[@name='limite_muestras']/node()}"/>
		<input type="hidden" name="CANTIDAD_NO_O" value="{document($doc)/translation/texts/item[@name='cantidad_no_0']/node()}"/>
		<input type="hidden" name="CANTIDADES_NEGATIVAS" value="{document($doc)/translation/texts/item[@name='cantidades_negativas']/node()}"/>
		<input type="hidden" name="REDONDEO_UNIDADES" value="{document($doc)/translation/texts/item[@name='redondeo_unidades']/node()}"/>
		<input type="hidden" name="REDONDEO_UNIDADES_2" value="{document($doc)/translation/texts/item[@name='redondeo_unidades_2']/node()}"/>
		<input type="hidden" name="UNIDADES" value="{document($doc)/translation/texts/item[@name='unidades']/node()}"/>
		<input type="hidden" name="CAJAS" value="{document($doc)/translation/texts/item[@name='cajas']/node()}"/>
		<input type="hidden" name="CAMBIOS_CANTIDADES_INICIO" value="{document($doc)/translation/texts/item[@name='cambios_cantidades_inicio']/node()}"/>

		<input type="hidden" name="MODIFICACIONES_CINCO_LINEAS" value="{document($doc)/translation/texts/item[@name='modificaciones_cinco_lineas']/node()}"/>
		<input type="hidden" name="MODIFICADO_CANTIDADES" value="{document($doc)/translation/texts/item[@name='modificado_cantidades']/node()}"/>
		<input type="hidden" name="LINEAS" value="{document($doc)/translation/texts/item[@name='lineas']/node()}"/>

		<input type="hidden" name="PEDIDO_NO_LLEGA" value="{document($doc)/translation/texts/item[@name='pedido_no_llega']/node()}"/>
		<input type="hidden" name="EUROS" value="{document($doc)/translation/texts/item[@name='euros']/node()}"/>
		<input type="hidden" name="POR_FAVOR_REVISE" value="{document($doc)/translation/texts/item[@name='por_favor_revise']/node()}"/>
		<input type="hidden" name="SUPERADO_LIMITE_MUESTRAS" value="{document($doc)/translation/texts/item[@name='superado_limite_muestras']/node()}"/>
                <input type="hidden" name="SOL_MUESTRAS" value="{document($doc)/translation/texts/item[@name='sol_muestras']/node()}"/>
                <input type="hidden" name="PEDIDO_SUPERA_DIESMIL" value="{document($doc)/translation/texts/item[@name='pedido_supera_diesmil']/node()}"/>
                <input type="hidden" name="CANTIDAD_ANTERIOR" value="{document($doc)/translation/texts/item[@name='cantidad_anterior']/node()}"/>
                <input type="hidden" name="UNIDADES_NUEVA_CANTIDAD" value="{document($doc)/translation/texts/item[@name='unidades_nueva_cantidad']/node()}"/>
                <input type="hidden" name="UNIDADES_CORRESPONDE_A" value="{document($doc)/translation/texts/item[@name='unidades_corresponde_a']/node()}"/>

                 <input type="hidden" name="SON_TODAS_NEGATIVAS" value="{document($doc)/translation/texts/item[@name='son_todas_negativas']/node()}"/>
                 <input type="hidden" name="VERIFIQUE_CANTIDADES_ABONO" value="{document($doc)/translation/texts/item[@name='verifique_cantidades_abono']/node()}"/>
                 <input type="hidden" name="SOLICITUD_DE_PRESUPUESTO" value="{document($doc)/translation/texts/item[@name='solicitud_de_presupuesto']/node()}"/>
         
           
           
        
        <!--FIN MENSAJE JS-->
        </form>
      
        <xsl:apply-templates select="Analizar/ANALISIS/LINEAS"> 
			<xsl:with-param name="OcultarPrecioReferencia" select="$OcultarPrecioReferencia"></xsl:with-param>     
		</xsl:apply-templates>
 		
        
        
      </xsl:otherwise>
      </xsl:choose>
      
       
       
        
      </body>
      
    </html>
  </xsl:otherwise>
  </xsl:choose>    
  </xsl:template>

<xsl:template match="LISTA">     
   <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
      
 <h1 class="titlePage"> 
 	<xsl:choose>
            <xsl:when test="$accion='DIRECTO'">
                <span id="titulo">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='preparacion_pedido']/node()"/>
                </span>    
                <xsl:text>&nbsp;a&nbsp;</xsl:text>
                
                <xsl:choose>
                    <xsl:when test="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/CENTROPROVEEDOR != ''"><xsl:value-of select="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/CENTROPROVEEDOR"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="LP_NOMBRE"/></xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='preparacion_oferta']/node()"/><xsl:text>&nbsp;a&nbsp;</xsl:text>
                <xsl:choose>
                    <xsl:when test="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/CENTROPROVEEDOR != ''"><xsl:value-of select="CENTROPROVEEDOR"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="LP_NOMBRE"/></xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
 </h1>
 
 <div class="divLeft">      
  
    <table class="infoTable" border="0">
     <xsl:choose>
      <xsl:when test="../../ACCION='EDICION'">
        <form name="formBot" method="POST">
        <input type="hidden" name="LP_PLAZOENTREGA" value="{//Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA}"/>
        <input type="hidden" name="COSTE_LOGISTICA"/>
        <tr> 
         <td class="labelRight">
            <xsl:choose>
            <xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_entrega']/node()"/>:
            </xsl:when>
            <xsl:otherwise>
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:
            </xsl:otherwise>
          </xsl:choose>
          </td> 
          <td>
          	<xsl:attribute name="class">
            	<xsl:choose>
				<xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">datosLeft quince</xsl:when>
				<xsl:otherwise>datosLeft zerouno</xsl:otherwise>
			</xsl:choose>
            </xsl:attribute>
            
			<xsl:choose>
				<xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">
					<select name="IDCENTRO" onChange="inicializarDesplegableCentros(this.value);"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDCENTRO" value="{//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID}"/>
				</xsl:otherwise>
			</xsl:choose>
          </td>
          <td class="datosLeft dies"> 
             <xsl:for-each select="//TODOSLUGARESENTREGA/CENTRO/LUGARESENTREGA">
              <select name="IDLUGARENTREGA_{@idCentro}" class="lugarEntrega" onChange="ActualizarTextoLugarEntrega(this.value);" style="display:none;">
                  <xsl:for-each select="LUGARENTREGA">
                        <option value="{ID}">
                        <xsl:value-of select="NOMBRE"/></option>
                  </xsl:for-each>
              </select>
          </xsl:for-each>
          
          <input type="hidden" name="IDLUGARENTREGA" />
            
           </td>
          <td class="labelRight">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='facturar_a']/node()"/>:
          </td> 
          <td class="datosLeft">
            <select name="IDCENTROCONSUMO"/>
          </td>
        </tr>
        <tr>
          <td class="labelRight">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:
          </td> 
           <td class="datosLeft" colspan="4" >
            <xsl:call-template name="direccion">
              <xsl:with-param name="path" select="CENTRO"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr style="display:none;"> 
          <td class="labelRight">
          </td>
          <td class="textLeft" colspan="5">
            <xsl:call-template name="hiddensOferta"/>
            <xsl:call-template name="FORMASPAGO"/>           	           
	    <xsl:call-template name="PLAZOSPAGO"/>
	    <input type="text" name="FORMAPAGO" value="{LP_FORMAPAGO}" size="30"/>	    
          </td>
        </tr>
        </form>
      </xsl:when>
      <xsl:otherwise>
      <form name="formBot" method="POST">
        <input type="hidden" name="LP_PLAZOENTREGA" value="{//Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA}"/>
         <input type="hidden" name="COSTE_LOGISTICA"/>
        <tr> 
          <td class="labelRight">
            <xsl:choose>
            <xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_entrega']/node()"/>:
            </xsl:when>
            <xsl:otherwise>
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:
            </xsl:otherwise>
          </xsl:choose>
          </td> 
           <td>
          	<xsl:attribute name="class">
            	<xsl:choose>
				<xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">datosLeft quince</xsl:when>
				<xsl:otherwise>datosLeft zerouno</xsl:otherwise>
			</xsl:choose>
            </xsl:attribute>

            <xsl:choose>
            <xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">
              <select name="IDCENTRO" class="select200" onChange="inicializarDesplegableCentros(this.value);" />
            </xsl:when>
            <xsl:otherwise>
             <select name="IDCENTRO" class="select200" onChange="inicializarDesplegableCentros(this.value);" style="display:none;">
             	<option value="{//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID}" selected="selected"></option>
             </select>
              <!--<input type="hidden" name="IDCENTRO" value="{//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID}" />-->
            </xsl:otherwise>
          </xsl:choose>
         </td>
         <td class="datosLeft dies"> 
          <xsl:for-each select="//TODOSLUGARESENTREGA/CENTRO/LUGARESENTREGA">
              <select name="IDLUGARENTREGA_{@idCentro}" class="lugarEntrega" onChange="ActualizarTextoLugarEntrega(this.value);" style="display:none;">
                  <xsl:for-each select="LUGARENTREGA">
                        <option value="{ID}">
                        <xsl:value-of select="NOMBRE"/></option>
                  </xsl:for-each>
              </select>
          </xsl:for-each>
          
          <input type="hidden" name="IDLUGARENTREGA" />
           <!-- <select name="IDLUGARENTREGA" onChange="ActualizarTextoLugarEntrega(this.value);" />-->
          </td>
          <td class="labelRight">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:
          </td> 
          <td colspan="3" class="datosLeft">
            <select name="IDCENTROCONSUMO"/>    
          </td>
        </tr>
        <tr> 
          <td class="labelRight" valign="top">
          	<p style="margin-top:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:</p>
          </td> 
          <td class="textLeft" colspan="2">
          <!--direccion-->
               <xsl:call-template name="direccion">
              <xsl:with-param name="path" select="CENTRO"/>
            </xsl:call-template>
          </td>
          <td class="labelRight">
          	<p style="margin-top:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>:</p>
          </td>
          <td class="datosLeft">
            <p style="width:70px; float:left; margin-top:5px;">
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="/Analizar/field[@name='COMBO_ENTREGA']"/>
              <xsl:with-param name="IDAct" select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>
    	<xsl:with-param name="cambio">calculaFecha('ENTREGA',this.options[this.selectedIndex].value);</xsl:with-param>
    	<xsl:with-param name="valorMinimo" select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>
              </xsl:call-template>
              </p>
         	  <p style="width:100px; float:left; font-size:12px;">
				<script type="text/javascript">
                  calFechaEntrega.dateFormat="d/M/yyyy";
                  calFechaEntrega.labelCalendario='fecha de entrega';
                  calFechaEntrega.minDate=new Date(formatoFecha(calculaFechaCalendarios('<xsl:value-of select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>'),'E','I'));
                  calFechaEntrega.writeControl();
                </script>
              </p>
          
            <input type="hidden" name="FECHA_DECISION" size="10" maxlength="10" value="{/Analizar/ANALISIS/CABECERA/LISTA/LP_FECHADECISION}"/>
            
            <input type="hidden" name="sum" size="14" readonly="readonly"/>
            <input type="hidden" name="sumBrasil" size="14" readonly="readonly"/>
            <input type="hidden" name="sumanumerica" size="14" readonly="readonly"/>
          </td>
        </tr>
        <tr style="height:5px;"><td colspan="5">&nbsp;</td></tr>
		<tr style="border-top:1px solid #396BAD;">
        <input type="hidden" name="IDFORMAPAGO" value="{/Analizar/ANALISIS/CABECERA/LISTA/LP_IDFORMAPAGO}"/>
        <input type="hidden" name="FORMAPAGO" value="{/Analizar/ANALISIS/CABECERA/LISTA/LP_FORMAPAGO}"/>
		<xsl:call-template name="hiddensPedido"/>
        <input type="hidden" name="IDPLAZOPAGO" value="{/Analizar/ANALISIS/CABECERA/LISTA/LP_IDPLAZOPAGO}"/>
        <input type="hidden" name="FECHA_PAGO" value="{/Analizar/ANALISIS/CABECERA/LISTA/FECHA_PAGO}"/>
        
        <!--  pedido minimo -->
    	<xsl:choose>  
  		<xsl:when test="//ANALISIS/PEDIDO_MINIMO/ACTIVO!='N' and //ANALISIS/PEDIDO_MINIMO/IMPORTE>0">
            	  <td class="datosLeft" colspan="5"><span style="color:#000;font-family:Verdana;font-weight:bold;margin-left:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_de']/node()"/>&nbsp;<input type="text" id="CEN_PEDIDOMINIMO" name="CEN_PEDIDOMINIMO" size="10" value="{//ANALISIS/PEDIDO_MINIMO/IMPORTE_SINFORMATO}" class="noinput" style="text-align:left;width:55px; font-weight:bold; margin-bottom:3px;" onFocus="this.blur();"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euros']/node()"/>&nbsp;</span>
                              		<!--
					<xsl:value-of select="//ANALISIS/PEDIDO_MINIMO/PROVEEDOR" />:
					<xsl:value-of select="//ANALISIS/PEDIDO_MINIMO/IMPORTE" />&nbsp;euros&nbsp;<xsl:value-of select="//ANALISIS/PEDIDO_MINIMO/DETALLE" />
					-->
                    <input type="hidden" id="CEN_TIPOPEDIDOMINIMO" name="CEN_TIPOPEDIDOMINIMO" size="30" value="{//ANALISIS/PEDIDO_MINIMO/ACTIVO}" />
                    
                    <xsl:if test="//ANALISIS/PEDIDO_MINIMO/DETALLE != ''">
                    	<span class="font11">:&nbsp;<xsl:value-of select="//ANALISIS/PEDIDO_MINIMO/DETALLE"/></span>
                    </xsl:if>
                    <!--TEXTO INSERTADO SOLO PARA EL PROVEEDOR PFIZER ID_EMPRESA 7096-->
                    <xsl:if test="//ANALISIS/PEDIDO_MINIMO/ACTIVO != 'E' and //ANALISIS/PEDIDO_MINIMO/IDPROVEEDOR = '7096'">
                    <br />
                    <span class="font11" style="width:160px;float:left;">&nbsp;</span>
                    <span class="font11">-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_no_estricto_expli']/node()"/>.</span>
                    </xsl:if>
                    <!--texto retraso-->
                     <xsl:if test="RETRASO">
                     <br />
                        <span class="font11" style="width:160px;float:left;">&nbsp;</span>
                        <span class="font11">-&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_desde_quince']/node()"/></span>
                    </xsl:if>
        		  </td>
			</xsl:when>
    	  	<xsl:otherwise>
              <td class="datosLeft" colspan="5">
             	<input type="hidden" id="CEN_PEDIDOMINIMO" name="CEN_PEDIDOMINIMO" size="30" value="0" class="noinput"  onFocus="this.blur();"/>
                <input type="hidden" id="CEN_TIPOPEDIDOMINIMO" name="CEN_TIPOPEDIDOMINIMO" size="30" value="{//ANALISIS/PEDIDO_MINIMO/ACTIVO}" />

				<span style="color:#000;font-weight:bold;margin-left:10px;"><xsl:value-of select="//ANALISIS/PEDIDO_MINIMO/PROVEEDOR" /> <xsl:value-of select="document($doc)/translation/texts/item[@name='no_requiere_pedido_minimo']/node()"/></span>
            	
                <xsl:if test="RETRASO">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             	<span class="font11">-&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_desde_quince']/node()"/></span>
                    </xsl:if>
                    
             </td>       
    	  	</xsl:otherwise>
    	</xsl:choose>  
       <!-- <td>&nbsp;</td>
        <td class="datosLeft">
            <xsl:if test="RETRASO">
            	<span class="font11"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_desde_quince']/node()"/></span>
			</xsl:if>
        </td>-->
        </tr>
        
        </form>
      </xsl:otherwise>
    </xsl:choose>  
  </table> 
 
</div><!--fin de div divLeft-->
</xsl:template>

<xsl:template match="LINEAS">
	<xsl:param name="OcultarPrecioReferencia"/>
    
      <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
  
	  	<form name="form_catpriv">
	  	<input type="hidden" name="CATPRIV_ESTRICTO" value="{EMP_CATPRIV_ESTRICTO}" />
		</form>
      
       
<!--INICIO TABLA PRODUCTOS-->
	<table class="infoTable" border="0">
     	<tr>
            <td class="datosLeft">
            <!--si pueden pedir muestras-->
            <xsl:if test="/Analizar/ANALISIS/BLOQUEARMUESTRASCLIENTE != 'S'">
            
            <span class="margin25"><span class="camposObligatorios">*</span>&nbsp;<a href="javascript:PrepararSolicitudMuestras(document.forms['formBot']);"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_muestras']/node()"/></a>
            </span>
            </xsl:if>  
            
            </td>
            <td class="labelRight">
            <a href="javascript:window.print();"><img src="http://www.newco.dev.br/images/imprimir.gif" alt="Imprimir" title="Imprimir" /><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
     </table>
    
    <xsl:variable name="nuevoModeloNegocio">
    	<xsl:choose>
        <xsl:when test="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
        	<xsl:value-of select="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>
        </xsl:when>
        <xsl:when test="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
        	<xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>
        </xsl:when>
        </xsl:choose>
    </xsl:variable>
    
     <xsl:variable name="pedidoAntiguo">
    	<xsl:choose>
        <xsl:when test="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
        	<xsl:value-of select="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>
        </xsl:when>
        <xsl:when test="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
        	<xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>
        </xsl:when>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:choose>
    <!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
    <xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Analizar/ANALISIS/MOSTRAR_PRECIO_CON_IVA)) or /Analizar/ANALISIS/IDPAIS = '55'">
    	<!--asisa brasil-->
        <xsl:call-template name="asisaBrasilTablaProd"/>
    </xsl:when>
    <!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
     <xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Analizar/ANALISIS/MOSTRAR_PRECIO_CON_IVA">
    	<!--viamed nuevo--><xsl:call-template name="viamedNuevoTablaProd"/>
    </xsl:when>
    <!--NUEVO MODELO VIEJO PEDIDO alicante...PRECIO CON IVA-->
    <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
    	<!--nuevo modelo viejo pedido vissum alicante-->
        <xsl:call-template name="nuevoModeloViejoPedidoTablaProd"/>
    </xsl:when>
    <!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL--> 
    <xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
    	<!--vendrell viamed viejo gomosa-->
        <xsl:call-template name="nuevoModeloNuevoPedidoTablaProd"/>
    </xsl:when>
    </xsl:choose>
    
   
 <br /><br />
 
</xsl:template>

<!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
<xsl:template name="asisaBrasilTablaProd">

  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>       <!--idioma fin-->
   		<!--ocultar precio ref-->
        <xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>
 <!--inicio tabla productos-->
	<table class="encuesta" border="0">
       <thead>
			<tr class="titulosNoAlto"> <!-- ref mvm + provee -->
            		<th class="ocho" align="left">
                        
                    	<xsl:choose>
                        <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                        	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
                        </xsl:when>
                         <xsl:otherwise>
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>.
                        </xsl:otherwise>
                        </xsl:choose>
      				</th>
           			<!-- producto -->
           			<th align="left">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
                    </th>
                   
            		<!-- ref provee-->
            		<th class="center">
                   
                    	<xsl:attribute name="class">
                        	<xsl:choose>
                            <!--si es viamed5 ve ref.prov-->
                            <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">zerouno</xsl:when>
                         
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                        
                    	<xsl:choose>
                        <!--si es farmacia no veo ref prov, solo si es viamed5 veo ref prov-->
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                         </xsl:when>
                         <!--si no es viamed5 no veo ref prov-->
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                         </xsl:when>
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                        </xsl:when>
                        </xsl:choose>
            		</th>
                    <!--marca para todos 26/06/12-->
                    <th>
                    	<xsl:attribute name="class">
                        <xsl:choose>
                        	<xsl:when test="/Analizar/ANALISIS/SIN_MARCA">zerouno</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">quince</xsl:when>
                            <!--si es farmacia y viamed5 mas estrecho-->
                            <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">dies</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                    
                        <xsl:choose>
                        	<xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
                            <xsl:otherwise>
                        		<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </th>
            		<!-- ud base -->
            		<th>
                     <xsl:attribute name="class">
                        	<xsl:choose>
                            <!--si es farmacia mas estrecho-->
                            <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
                         	<xsl:otherwise>doce</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
            		</th>
                    <!-- precio ud base, solo viejo modelo -->
					<xsl:if test="$OcultarPrecioReferencia='N' or /Analizar/ANALISIS/IDPAIS = '55'">
						<th class="cuatro">
                        	<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_s_iva']/node()"/>
             			</th>
					</xsl:if>
            		
                    <!--flechas si precio ha bajado o subido solo para no asisa-->
                    <!--<th class="zerouno">precio ha bajado o subido&nbsp;          
            		</th>-->
            		<!-- cantidad -->
            		<th class="cinco">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
            		</th>
            		<!-- lote -->
           			<th class="tres">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/>
           			</th>
           			<!-- iva enseño solo para asisa-->
                   	<!--si es brasil no enseño iva-->
                   	<xsl:choose>
                    <xsl:when test="/Analizar/ANALISIS/IDPAIS = '55'"> 
                    	<th class="zerouno">&nbsp;</th></xsl:when>
                    <xsl:otherwise>
                        <th class="uno">
                            &nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>
                        </th>
                    </xsl:otherwise>
                    </xsl:choose>
					<!-- importe -->
			        <th class="dos" align="right">
                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_s_iva_2line']/node()"/>
            		</th>
                   
            		<!-- importe total linea-->
            		<th class="uno">
                    	<a href="javascript:Seleccionar('SELECCION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='sel']/node()"/></a>
            		</th>
         			</tr>
             </thead>
        <!--fin de titulos-->
		<xsl:for-each select="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW">
                          <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
                       
                        	
						<xsl:variable name="usarGrupo">
                        	<xsl:choose>
                            <xsl:when test="/Analizar/ANALISIS/UTILIZAR_GRUPO">S</xsl:when>
                            <xsl:otherwise>N</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        
							<xsl:choose>
								<xsl:when test="position()=1">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                        
                                                 <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="$usarGrupo = 'S' and GRUPO !=''">
																	<xsl:value-of select="SUBFAMILIA"/>&nbsp;>&nbsp;<xsl:value-of select="GRUPO"/>
															</xsl:when>
                                                            <xsl:when test="$usarGrupo = 'N' and SUBFAMILIA !=''">
																	<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                            	<xsl:if test="$usarGrupo = 'S'">
                                                                <!--es viamed5 enseño sin grupo-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
                                                                </xsl:if>
                                                                <xsl:if test="$usarGrupo = 'N'">
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
                                                                </xsl:if>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
									</th>
									</tr>
								</xsl:when>
								<xsl:otherwise>
                                	<xsl:choose>
                                	<xsl:when test="$usarGrupo = 'S' and GRUPO/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/GRUPO!=GRUPO">
                                    	<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                               <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="GRUPO !=''">
																	<xsl:value-of select="SUBFAMILIA"/>&nbsp;>&nbsp;<xsl:value-of select="GRUPO"/>
															</xsl:when>
															<xsl:otherwise>
                                                                <!--es viamed nuevo enseño sin familia-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
											</th>
										</tr>
                                    </xsl:when>
                                	<xsl:when test="$usarGrupo = 'N' and SUBFAMILIA/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/SUBFAMILIA!=SUBFAMILIA">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                               <strong><span class="subfamilia">
														<xsl:choose>
                                                            <xsl:when test="SUBFAMILIA !=''">
																	<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
										</th>
									</tr>
									</xsl:when>
                                    </xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
							
								<xsl:variable name="FormNum"><xsl:value-of select="position()"/></xsl:variable>
								<form method="POST" target="mainFrame">
   								<xsl:attribute name="name">form_<xsl:value-of select="$FormNum"/></xsl:attribute>
								
   									<input type="hidden" name="SELECCIONTOTAL"/>
      								<input type="hidden" name="PRECIO_PRODUCTO_DETERMINADO" value="{../../PRECIO_PRODUCTO_DETERMINADO}"/>
      								<input type="hidden" name="IDDIVISA"/>
      								<input type="hidden" name="PRODUCTOPROVEEDOR_{PLL_ID}" value="{PROVEEDOR}"/>
      
   									<tr>
                                    <!-- ref mvm si no es farmacia + ref prove si es farmacia -->
    										<td align="left">
                                                <span class="font11">&nbsp;
                                            	<xsl:choose>
                                                    <xsl:when test="PRO_CATEGORIA = 'F'">

                                                        <xsl:choose>
                                                        <xsl:when test="/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                                                            <xsl:value-of select="PRO_REFERENCIA"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:choose>
                                                            <xsl:when test="REFERENCIACLIENTE != ''">
                                                                <xsl:value-of select="REFERENCIACLIENTE"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="REFERENCIAPRIVADA"/>
                                                            </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when><!--fin si es farmacia-->
                                                    
                                                    <xsl:when test="PRO_CATEGORIA = 'N'">
                                                        <xsl:choose>
                                                            <xsl:when test="REFERENCIACLIENTE != ''">
                                                                <xsl:value-of select="REFERENCIACLIENTE"/>
                                                            </xsl:when>
                                                            <xsl:when test="REFERENCIAPRIVADA!=''">
                                                                <xsl:value-of select="REFERENCIAPRIVADA"/>   
                                                            </xsl:when>
                                                        </xsl:choose>
                                                     </xsl:when>
                                                </xsl:choose>
                                                </span>
         	 								 <!--</a>-->
      									</td>
									<!-- nombre link producto -->
										<td style="padding-left:5px;">
                                        <!--si producto es sin stock o descatalogado-->
                                            <xsl:if test="TIPO_SIN_STOCK !=''">
                                                <span class="rojo"><b>[*]</b></span>&nbsp;
                                            </xsl:if>
                                            <xsl:if test="REQUIERE_PRESUPUESTO = 'S'">
                                                <span class="rojo">[<xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_presupuesto']/node()"/>]</span>&nbsp;
                                            </xsl:if>
                                      
                                        
                                            <xsl:choose>
          									<xsl:when test="NOMBREPRIVADO!=''">
                                            	<a style="text-decoration:none;">
                                                  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
                                                  <span class="strongAzul"><xsl:value-of select="NOMBREPRIVADO"/></span>
                                                </a>
          									</xsl:when>
          									<xsl:otherwise>
            									 <a style="text-decoration:none;">
                                                  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
                                                  <xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
                                                  <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                                                  <span class="strongAzul"><xsl:value-of select="NOMBRE"/></span>
                                                 </a>
          									</xsl:otherwise>
        									</xsl:choose>
        									        									
      									</td>
    								
    									<xsl:variable name="HayPrecio">
   											<xsl:choose><xsl:when test="TOTAL_FORMATO[.='']">0</xsl:when><xsl:otherwise>1</xsl:otherwise></xsl:choose>
    									</xsl:variable> 
    									<input type="hidden" name="TARIFA_UNI_{PLL_ID}" value="{TARIFA}"/>   
    										
      									<!-- marca si es farmacia + ref provee si no es farmacia-->
      									<td class="center">
                                        	<!--si es farmacia no veo ref prov-->
                                            <xsl:if test="PRO_CATEGORIA = 'N'">
                                            	<xsl:value-of select="PRO_REFERENCIA"/> 
                                            </xsl:if>
         	 								
      									</td>
                                        <!--marca solo si es asisa-->
                                        <td class="center" style="font-size:11px;">
                                             <xsl:value-of select="MARCA"/>
                                        </td>
      									<!-- ud base -->
      									<td class="center">
        									<xsl:value-of select="PRO_UNIDADBASICA"/>&nbsp;
      									</td>
      									<!-- precio sin iva, viejo modelo ven precio provee, brasil y asisa-->
     	 								<td class="center">
											<!--tarifa sin iva-->
        									<input type="text" class="noinput" size="7" align="right" name="PRECIOUNITARIO_{PLL_ID}" value="{TARIFA}" onFocus="this.blur();" style="text-align:right;"/> 	
        							<!--<input type="text" class="noinput" size="7" align="right" name="PRECIOUNITARIO_{PLL_ID}" value="{TARIFA_TOTAL}" onFocus="this.blur();" style="text-align:right;"/> -->
													
        										<input type="hidden" name="PRO_UNIDADESPORLOTE_{PLL_ID}" value="{PRO_UNIDADESPORLOTE_SINFORMATO}"/>
        										<input type="hidden" name="DESCRIPCION_PRODUCTO_{PLL_ID}">
          										<xsl:choose>
            										<xsl:when test="NOMBREPRIVADO!=''">
              										<xsl:attribute name="value">
                										<xsl:value-of select="NOMBREPRIVADO"/>
              										</xsl:attribute>
            										</xsl:when>
            										<xsl:otherwise>
              										<xsl:attribute name="value">
                										<xsl:value-of select="NOMBRE"/>
              										</xsl:attribute>
            										</xsl:otherwise>
          										</xsl:choose>
        										</input>
      									</td>  
                                        <input type="hidden" name="PRECIOUNITARIOCONIVA_{PLL_ID}" value="{TARIFA_CONIVA}" onFocus="this.blur();" style="text-align:right;"/> 		
                                       
      									<!-- cantidad -->
      									<td class="center">
        									<xsl:element name="input">
          									<xsl:attribute name="value"><xsl:value-of select="CANTIDAD_SINFORMATO"/></xsl:attribute>
          									<xsl:attribute name="type">text</xsl:attribute>
          									<xsl:attribute name="name">NuevaCantidad_<xsl:value-of select="PLL_ID"/></xsl:attribute>
          									<xsl:attribute name="size">4</xsl:attribute>
          									<xsl:attribute name="maxlength">6</xsl:attribute>
          									<xsl:attribute name="style">text-align:right;</xsl:attribute>
          									<xsl:attribute name="onBlur">if(UnidadesALotes(this.value,'<xsl:value-of select="PRO_UNIDADESPORLOTE_SINFORMATO"/>',this,document.forms['form_<xsl:value-of select="$FormNum"/>'])) realizarCalculos(document.forms['form_<xsl:value-of select="$FormNum"/>'],<xsl:value-of select="PLL_ID"/>,'<xsl:value-of select="$accion"/>',<xsl:value-of select="$HayPrecio"/>); else realizarCalculosPorDefinir(document.forms['form_<xsl:value-of select="$FormNum"/>'],<xsl:value-of select="PLL_ID"/>,'<xsl:value-of select="$accion"/>',<xsl:value-of select="$HayPrecio"/>);</xsl:attribute>
        									</xsl:element>
      									</td>
      									<!-- lote -->
      									<td class="center">
                                        <xsl:text>&nbsp;&nbsp;</xsl:text>
                                        	<input type="hidden" name="UNIDADESPORLOTE_{PLL_ID}" value="{PRO_UNIDADESPORLOTE}" />
      										<xsl:value-of select="PRO_UNIDADESPORLOTE"/>
      									</td>
                                       
                                        <!--si es brasil no enseño iva-->
                                            <xsl:choose>
                                            <xsl:when test="/Analizar/ANALISIS/IDPAIS = '55'"> <td class="uno">&nbsp;</td></xsl:when>
                                            <xsl:otherwise>
                                                    <td class="textRight">
      													&nbsp;<xsl:value-of select="PLL_TIPOIVA"/>
                                        			</td>  
                                            </xsl:otherwise>
                                            </xsl:choose>
      									<!-- importe total-->              
      										<xsl:choose>
        										<xsl:when test="$HayPrecio=0">
              										<td class="textRight">
                                                      <xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>
              										</td>
        										</xsl:when>
        										<xsl:otherwise>
              										<td class="textRight">
              											<input type="text" name="NuevoImporte_{PLL_ID}" size="8" maxlength="10" value="{TOTAL_FORMATO}" class="noinput" onFocus="this.blur();" style="text-align:right;"/>
                                                         <input type="hidden" name="NuevoImporteConIVA_{PLL_ID}" size="8" maxlength="10"  value="{TARIFA_TOTAL_CONIVA}" class="noinput" onFocus="this.blur();" style="text-align:right;"/>
                                                       
              										</td>
              									</xsl:otherwise>
      										</xsl:choose>
      										<!-- seleccionado -->
      										<td class="center">
        										<input type="checkbox" name="SELECCION">
          										<xsl:attribute name="value"><xsl:value-of select="PLL_ID"/></xsl:attribute>
          										<xsl:choose>
            										<xsl:when test="$accion='DIRECTO'">
                                                        <xsl:if test="TARIFA[.=''] or (TIPO_SIN_STOCK != '' and TIPO_SIN_STOCK ='D') ">                                                            <xsl:attribute name="disabled">disabled</xsl:attribute>
                                                        </xsl:if>
                                                       <!-- <xsl:if test="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio = 'S' and TIPO_SIN_STOCK != '' and TIPO_SIN_STOCK ='D'">-->
            										</xsl:when>
          										</xsl:choose>

          										<xsl:attribute name="onClick">
            										<xsl:choose>
              											<xsl:when test="$accion='DIRECTO' and REQUIERE_PRESUPUESTO != 'S'">sumar_pedidoDirecto();</xsl:when>
                                                                                                <xsl:when test="$accion='DIRECTO' and REQUIERE_PRESUPUESTO = 'S'">sumar_pedidoDirecto(); requierePresupuesto();</xsl:when>
                                                                                                <xsl:otherwise>sumar_Multioferta();</xsl:otherwise>
            										</xsl:choose>
          										</xsl:attribute>
        										</input>  
      										</td>
    									</tr> 
                                        <!-- si sin stock enseño info en una nueva linea-->
                                        <xsl:if test="TIPO_SIN_STOCK !=''">
                                        <tr>
                                        	<td>&nbsp;</td>
                                        	<td style="background:#FFFF99;" colspan="13">
                                             &nbsp;<span class="rojo"><b>[*]</b></span>&nbsp;<xsl:value-of select="TEXTO_SIN_STOCK"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.&nbsp;<xsl:value-of select="REFERENCIAALTERNATIVA"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='Prod']/node()"/>.&nbsp;<xsl:value-of select="DESCRIPCIONALTERNATIVA"/>
                                            </td>
                                        </tr>
                                        </xsl:if>
    								</form>
					
						
  							</xsl:for-each>
					
   <tfoot>
 
<tr> 
      <td colspan="11">&nbsp;</td>
</tr>
<!--form sumaTotal + coste transporte brasil-->
<form name="sumaTotal">
<tr>
    
    <td class="textRight" colspan="6">&nbsp;</td> 
    
    <!--choose pais-->
    <xsl:choose>
    <!--si es brasil pongo subtotal-->
    <xsl:when test="/Analizar/ANALISIS/IDPAIS = '55'">
    	<xsl:choose>
      <xsl:when test="//ACCION='DIRECTO'">
       <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
       <td class="textRight" colspan="2">     
 	   <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='subtotal']/node()"/>:</strong>
       </td>
       <td colspan="2" class="textRight">
       		<input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
       </td>
      </xsl:when>
      
      <xsl:otherwise>
            <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
      <td class="textRight" colspan="2">        
 	    <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='subtotal']/node()"/>:</strong>
        </td>
        <td class="textRight" colspan="2">    
        	<input type="hidden" name="sumaTotal"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>   
    
    </xsl:when><!--fin si es brasil-->
    <xsl:otherwise>
    <!--si es españa-->
	<xsl:choose>
      <xsl:when test="//ACCION='DIRECTO'">
       <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
       <td class="textRight" colspan="2">    
 	   <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
       </td>
       <td class="textRight" colspan="2">
           <input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
       </td>
      </xsl:when>
      
      <xsl:otherwise>
            <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
        <td class="textRight" colspan="2">    
 	    <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
        </td>
        <td class="textRight" colspan="2">    
        	<input type="hidden" name="sumaTotal"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>   
    
    <input type="hidden" class="noinput" name="sumaTotalBrasil" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
    <input type="hidden" class="noinput" name="COSTE_LOGISTICA" size="8" maxlength="12" style="text-align:right;" value="0"/>
    
    </xsl:otherwise>
    </xsl:choose><!--fin choose pais-->
    <td>&nbsp;</td>
</tr> 
 

<!--coste de transporte + suma total brasil-->
    <xsl:if test="/Analizar/ANALISIS/IDPAIS = '55'">
     <tr>
        <td colspan="6">&nbsp;</td> 
       
        <td class="textRight" colspan="2">
        <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>:</strong>
        </td>
        <td colspan="2" class="textRight">
             <input type="text" class="noinput" name="COSTE_LOGISTICA" size="8" maxlength="12" style="text-align:right;" />
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6"></td>
       
        <td class="textRight" colspan="2">
          <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
        </td>
        <td colspan="2" class="textRight">
        	<input type="text" class="noinput" name="sumaTotalBrasil" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
        </td>
        <td>&nbsp;</td>
        </tr>
    </xsl:if>
</form>
<tr> 
      <td colspan="11">&nbsp;</td>
	</tr>

 <!-- Botones -->
 
   
    <tr> 
      <td colspan="7">
         
       		<span class="font11">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='busquedas_en_pagina']/node()"/></span>
            <!--solo para no asisa, no asisa = S => != N-->
            <br />
            <xsl:if test="$OcultarPrecioReferencia!='N'">
            <span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_bajado_desde_ultimo_pedido']/node()"/>.</span><br />
            <span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_subido_desde_ultimo_pedido']/node()"/>.</span>
            </xsl:if>
      </td>      
      <td colspan="4">
      <xsl:choose>
      <xsl:when test="//ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and //ANALISIS/PEDIDO_MINIMO/IMPORTE != ''">
       <div class="boton" id="divContinuar">
      	<a href="javascript:controlPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{//ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
       </div>
      </xsl:when>
      <xsl:otherwise>
       <div class="boton" id="divContinuar">
          <a href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
      </div>
      </xsl:otherwise>
      </xsl:choose>
      </td>             
    </tr>   
 
</tfoot>
</table><!--fin de encuesta tabla-->
</xsl:template>

<!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
<xsl:template name="viamedNuevoTablaProd">
  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>       <!--idioma fin-->
   		<!--ocultar precio ref-->
        <xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>
        
        
 <!--inicio tabla productos-->
	<table class="encuesta" border="0">
       <thead>
			<tr class="titulosNoAlto"> <!-- ref mvm + provee -->
            		<th class="cinco" align="left">
                    	<xsl:choose>
                        <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                        	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
                        </xsl:when>
                         <xsl:otherwise>
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>.
                        </xsl:otherwise>
                        </xsl:choose>
      				</th>
           			<!-- producto -->
           			<th align="left">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
                    </th>
                   
            		<!-- ref provee-->
            		<th class="center">
                   
                    	<xsl:attribute name="class">
                        	<xsl:choose>
                            <!--si es viamed5 ve ref.prov-->
                            <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">zerouno</xsl:when>
                         
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                        
                    	<xsl:choose>
                        <!--si es farmacia no veo ref prov, solo si es viamed5 veo ref prov-->
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                         </xsl:when>
                         <!--si no es viamed5 no veo ref prov-->
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                         </xsl:when>
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                           
                        </xsl:when>
                        </xsl:choose>
            		</th>
                    <!--marca solo si es asisa, para todos 26/06/12-->
                    <th>
                    	<xsl:attribute name="class">
                        <xsl:choose>
                        	<xsl:when test="/Analizar/ANALISIS/SIN_MARCA">zerouno</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">quince</xsl:when>
                            <!--si es farmacia y viamed5 mas estrecho-->
                            <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">dies</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                        
                    	
                        <xsl:choose>
                        	<xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
                            <xsl:otherwise>
                        		<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </th>
            		<!-- ud base -->
            		<th>
                     <xsl:attribute name="class">
                        	<xsl:choose>
                            <!--si es farmacia y viamed5 mas estrecho-->
                            <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
                         	<xsl:otherwise>doce</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
            		</th>
            		<!-- precio ud base con IVA -->
                    <th class="cuatro">
                         <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_c_iva']/node()"/>
                    </th>
                    <!--flechas si precio ha bajado o subido solo para no asisa-->
                    <th class="zerouno"><!--precio ha bajado o subido-->&nbsp;           
            		</th>
            		<!-- cantidad -->
            		<th class="cinco">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
            		</th>
            		<!-- lote -->
           			<th class="tres">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/>
           			</th>
                   	<!--iva-->
                    <th class="uno">
                         &nbsp;<!--&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>quitado 30-10-13-->
                    </th>
					<!-- importe con iva-->
			        <th class="dos" align="right">
                       <xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_c_iva_2line']/node()"/>
            		</th>
            		<!-- seleccionado -->
            		<th class="uno">
                    	<a href="javascript:Seleccionar('SELECCION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='sel']/node()"/></a>
            		</th>
         			</tr>
             </thead>
        <!--fin de titulos-->
		<xsl:for-each select="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW">
                          <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
       					<xsl:variable name="usarGrupo">
                        	<xsl:choose>
                            <xsl:when test="/Analizar/ANALISIS/UTILIZAR_GRUPO">S</xsl:when>
                            <xsl:otherwise>N</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        
							<xsl:choose>
								<xsl:when test="position()=1">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                        
                                                 <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="$usarGrupo = 'S' and GRUPO !=''">
																	<xsl:value-of select="SUBFAMILIA"/>&nbsp;>&nbsp;<xsl:value-of select="GRUPO"/>
															</xsl:when>
                                                            <xsl:when test="$usarGrupo = 'N' and SUBFAMILIA !=''">
																	<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                            	<xsl:if test="$usarGrupo = 'S'">
                                                                <!--es viamed5 enseño sin grupo-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_familia']/node()"/>
                                                                </xsl:if>
                                                                <xsl:if test="$usarGrupo = 'N'">
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subgrupo']/node()"/>
                                                                </xsl:if>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
									</th>
									</tr>
								</xsl:when>
								<xsl:otherwise>
                                	<xsl:choose>
                                	<xsl:when test="$usarGrupo = 'S' and GRUPO/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/GRUPO!=GRUPO">
                                    	<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                               <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="GRUPO !=''">
																	<xsl:value-of select="SUBFAMILIA"/>&nbsp;>&nbsp;<xsl:value-of select="GRUPO"/>
															</xsl:when>
															<xsl:otherwise>
                                                                <!--es viamed nuevo enseño sin familia-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_familia']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
											</th>
										</tr>
                                    </xsl:when>
                                	<xsl:when test="$usarGrupo = 'N' and SUBFAMILIA/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/SUBFAMILIA!=SUBFAMILIA">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                               <strong><span class="subfamilia">
														<xsl:choose>
                                                            <xsl:when test="SUBFAMILIA !=''">
																	<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subgrupo']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
										</th>
									</tr>
									</xsl:when>
                                    </xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
							
								<xsl:variable name="FormNum"><xsl:value-of select="position()"/></xsl:variable>
								<form method="POST" target="mainFrame">
   								<xsl:attribute name="name">form_<xsl:value-of select="$FormNum"/></xsl:attribute>
								
   									<input type="hidden" name="SELECCIONTOTAL"/>
      								<input type="hidden" name="PRECIO_PRODUCTO_DETERMINADO" value="{../../PRECIO_PRODUCTO_DETERMINADO}"/>
      								<input type="hidden" name="IDDIVISA"/>
      								<input type="hidden" name="PRODUCTOPROVEEDOR_{PLL_ID}" value="{PROVEEDOR}"/>
      
   									<tr>
                                    <!-- ref mvm si no es farmacia + ref prove si es farmacia -->
    										<td align="left">
                                                <span class="font11">&nbsp;
                                            	<xsl:choose>
                                                    <xsl:when test="PRO_CATEGORIA = 'F'">
                                                        <xsl:choose>
                                                        <xsl:when test="/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                                                            <xsl:value-of select="PRO_REFERENCIA"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:choose>
                                                            <xsl:when test="REFERENCIACLIENTE != ''">
                                                                <xsl:value-of select="REFERENCIACLIENTE"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="REFERENCIAPRIVADA"/>
                                                            </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="PRO_CATEGORIA = 'N'">
                                                        <xsl:choose>
                                                            <xsl:when test="REFERENCIACLIENTE != ''">
                                                                <xsl:value-of select="REFERENCIACLIENTE"/>
                                                            </xsl:when>
                                                            <xsl:when test="REFERENCIAPRIVADA!=''">
                                                                <xsl:value-of select="REFERENCIAPRIVADA"/>   
                                                            </xsl:when>
                                                        </xsl:choose>
                                                     </xsl:when>
                                                </xsl:choose>
                                                </span>
         	 								 <!--</a>-->
      									</td>
									<!-- nombre link producto -->
										<td style="padding-left:5px;">
                                            <xsl:if test="TIPO_SIN_STOCK !=''">
                                                <span class="rojo"><b>[*]</b></span>
                                            </xsl:if>
                                            <xsl:if test="REQUIERE_PRESUPUESTO = 'S'">
                                                <span class="rojo">[<xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_presupuesto']/node()"/>]</span>&nbsp;
                                            </xsl:if>
                                        
                                        <xsl:choose>
          									<xsl:when test="NOMBREPRIVADO!=''">
                                            	<a style="text-decoration:none;">
                                                  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
                                                  <span class="strongAzul"><xsl:value-of select="NOMBREPRIVADO"/></span>
                                                </a>
          									</xsl:when>
          									<xsl:otherwise>
            									 <a style="text-decoration:none;">
                                                  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
                                                  <xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
                                                  <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                                                  <span class="strongAzul"><xsl:value-of select="NOMBRE"/></span>
                                                 </a>
          									</xsl:otherwise>
        									</xsl:choose>
        									        									
      									</td>
    								
    									<xsl:variable name="HayPrecio">
   											<xsl:choose><xsl:when test="TOTAL_FORMATO[.='']">0</xsl:when><xsl:otherwise>1</xsl:otherwise></xsl:choose>
    									</xsl:variable> 
    									<input type="hidden" name="TARIFA_UNI_{PLL_ID}" value="{TARIFA}"/>   
    										
      									<!-- marca si es farmacia + ref provee si no es farmacia-->
      									<td class="center">
                                       		   <xsl:choose>
                                                     <!--si es farmacia no veo ref prov, solo si es viamed5 veo ref prov-->
                                                     <xsl:when test="PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">
                                                         <xsl:value-of select="PRO_REFERENCIA"/> 
                                                     </xsl:when>
                                                     <!--si no es viamed5 no veo ref prov-->
                                                     <xsl:when test="PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                                                     </xsl:when>
                                                    
                                                     <xsl:when test="PRO_CATEGORIA = 'N'">
                                                        <xsl:value-of select="PRO_REFERENCIA"/> 
                                                    </xsl:when>
                                                </xsl:choose>
         	 								
      									</td>
                                        <!--marca solo si es asisa-->
                                        <td class="center" style="font-size:11px;">
                                             <xsl:choose>
                                                <xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
                                                <xsl:otherwise>
                                               		<xsl:value-of select="MARCA"/>
                                                </xsl:otherwise>
                                             </xsl:choose>
                                        </td>
      									<!-- ud base -->
      									<td class="center">
        									<xsl:value-of select="PRO_UNIDADBASICA"/>&nbsp;
      									</td>
      									<!-- precio sin iva hidden-->
     	 								
                                                <input type="hidden" class="noinput" size="7" align="right" name="PRECIOUNITARIO_{PLL_ID}" value="{TARIFA_TOTAL}" onFocus="this.blur();" style="text-align:right;"/> 	
        										<input type="hidden" name="PRO_UNIDADESPORLOTE_{PLL_ID}" value="{PRO_UNIDADESPORLOTE_SINFORMATO}"/>
        										<input type="hidden" name="DESCRIPCION_PRODUCTO_{PLL_ID}">
          										<xsl:choose>
            										<xsl:when test="NOMBREPRIVADO!=''">
              										<xsl:attribute name="value">
                										<xsl:value-of select="NOMBREPRIVADO"/>
              										</xsl:attribute>
            										</xsl:when>
            										<xsl:otherwise>
              										<xsl:attribute name="value">
                										<xsl:value-of select="NOMBRE"/>
              										</xsl:attribute>
            										</xsl:otherwise>
          										</xsl:choose>
        										</input>
      									
                                        <!--precio con IVA-->
              							<td>
        									<input type="text" class="noinput" size="7" name="PRECIOUNITARIOCONIVA_{PLL_ID}" value="{TARIFA_CONIVA}" onFocus="this.blur();" style="text-align:right;"/> 		<!-- para pruebas: (<xsl:value-of select="TARIFA"/>)-->
                                                 
										</td>
                                              
                                        <!--flechas si precio ha bajado o subido--> 
                                        <td>
                                        <xsl:choose>
											<xsl:when test="$OcultarPrecioReferencia='N'">
                                             	<xsl:if test="CARO"><img src="http://www.newco.dev.br/images/order_a_rojo.gif"/></xsl:if>
                       						 	<xsl:if test="BARATO"><img src="http://www.newco.dev.br/images/order_d_verde.gif"/></xsl:if>
											</xsl:when>
                                            
                                            <xsl:when test="$OcultarPrecioReferencia='S'">
											
                                            	<xsl:if test="PRECIOFINAL_CARO"><img src="http://www.newco.dev.br/images/order_a_rojo.gif"/></xsl:if>
                       						 	<xsl:if test="PRECIOFINAL_BARATO"><img src="http://www.newco.dev.br/images/order_d_verde.gif"/></xsl:if>
                                            </xsl:when>
                                        </xsl:choose>
                                      
                                        </td>
                                        
                                       
      									<!-- cantidad -->
      									<td class="center">
        									<xsl:element name="input">
          									<xsl:attribute name="value"><xsl:value-of select="CANTIDAD_SINFORMATO"/></xsl:attribute>
          									<xsl:attribute name="type">text</xsl:attribute>
          									<xsl:attribute name="name">NuevaCantidad_<xsl:value-of select="PLL_ID"/></xsl:attribute>
          									<xsl:attribute name="size">4</xsl:attribute>
          									<xsl:attribute name="maxlength">6</xsl:attribute>
          									<xsl:attribute name="style">text-align:right;</xsl:attribute>
          									<xsl:attribute name="onBlur">if(UnidadesALotes(this.value,'<xsl:value-of select="PRO_UNIDADESPORLOTE_SINFORMATO"/>',this,document.forms['form_<xsl:value-of select="$FormNum"/>'])) realizarCalculos(document.forms['form_<xsl:value-of select="$FormNum"/>'],<xsl:value-of select="PLL_ID"/>,'<xsl:value-of select="$accion"/>',<xsl:value-of select="$HayPrecio"/>); else realizarCalculosPorDefinir(document.forms['form_<xsl:value-of select="$FormNum"/>'],<xsl:value-of select="PLL_ID"/>,'<xsl:value-of select="$accion"/>',<xsl:value-of select="$HayPrecio"/>);</xsl:attribute>
        									</xsl:element>
      									</td>
      									<!-- lote -->
      									<td class="center">
                                        <xsl:text>&nbsp;&nbsp;</xsl:text>
                                        	<input type="hidden" name="UNIDADESPORLOTE_{PLL_ID}" value="{PRO_UNIDADESPORLOTE}" />
      										<xsl:value-of select="PRO_UNIDADESPORLOTE"/>
      									</td>
      									<!-- iva -->
                                        <td class="textRight">
                                        	
      										&nbsp;<!--<xsl:value-of select="PLL_TIPOIVA"/> quitado 30-10-13-->
                                        </td>  
      									<!-- importe total con iva-->              
                                        <td class="textRight">
                                            <input type="hidden" name="NuevoImporte_{PLL_ID}" size="8" maxlength="10" value="{LINEASUMAFINAL_FORMATO}" class="noinput" onFocus="this.blur();" style="text-align:right;"/>
                                            <input type="text" name="NuevoImporteConIVA_{PLL_ID}" size="8" maxlength="10"  value="{TARIFA_TOTAL_CONIVA}" class="noinput" onFocus="this.blur();" style="text-align:right;"/>
										 </td>
                                           
      										<!-- seleccionado -->
      										<td class="center">
        										<input type="checkbox" name="SELECCION">
          										<xsl:attribute name="value"><xsl:value-of select="PLL_ID"/></xsl:attribute>
          										<xsl:choose>
            										<xsl:when test="$accion='DIRECTO'">
                                                                                            <xsl:if test="TARIFA[.=''] or (TIPO_SIN_STOCK != '' and TIPO_SIN_STOCK ='D') ">                                                            
                                                                                                <xsl:attribute name="disabled">disabled</xsl:attribute>
                                                                                            </xsl:if>
            										</xsl:when>
          										</xsl:choose>

          										<xsl:attribute name="onClick">
            										<xsl:choose>
              											<xsl:when test="$accion='DIRECTO' and REQUIERE_PRESUPUESTO != 'S'">sumar_pedidoDirecto();</xsl:when>
                                                                                                <xsl:when test="$accion='DIRECTO' and REQUIERE_PRESUPUESTO = 'S'">sumar_pedidoDirecto(); requierePresupuesto();</xsl:when>
                                                                                                <xsl:otherwise>sumar_Multioferta();</xsl:otherwise>
            										</xsl:choose>
          										</xsl:attribute>
        										</input>  
      										</td>
    									</tr> 
                                        <!-- si sin stock enseño info en una nueva linea-->
                                        <xsl:if test="TIPO_SIN_STOCK !=''">
                                        <tr>
                                        	<td>&nbsp;</td>
                                        	<td style="background:#FFFF99;" colspan="13">
                                             &nbsp;<span class="rojo"><b>[*]</b></span>&nbsp;<xsl:value-of select="TEXTO_SIN_STOCK"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.&nbsp;<xsl:value-of select="REFERENCIAALTERNATIVA"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='Prod']/node()"/>.&nbsp;<xsl:value-of select="DESCRIPCIONALTERNATIVA"/>
                                            </td>
                                        </tr>
                                        </xsl:if>
    								</form>
					
						
  							</xsl:for-each>
					
   <tfoot>
 
<tr> 
      <td>
       <xsl:attribute name="colspan">
				<xsl:choose>
				<xsl:when test="$OcultarPrecioReferencia='N'">14</xsl:when>
				<xsl:otherwise>11</xsl:otherwise>
				</xsl:choose>
		  </xsl:attribute>
      </td>
</tr>
<!--form sumaTotal + coste transporte brasil-->
<form name="sumaTotal">
<tr>
    <td class="textRight" colspan="7">&nbsp;</td> 
    <!--subtotal-->
	<xsl:choose>
      <xsl:when test="//ACCION='DIRECTO'">
       <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
       <td class="textRight" colspan="2">    
 	   <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
       </td>
       <td class="textRight" colspan="2">
           <input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
       </td>
      </xsl:when>
      
      <xsl:otherwise>
            <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
        <td class="textRight" colspan="2">    
 	    <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
        </td>
        <td class="textRight" colspan="2">    
        	<input type="hidden" name="sumaTotal"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>   
    
    <input type="hidden" class="noinput" name="sumaTotalBrasil" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
    <input type="hidden" class="noinput" name="COSTE_LOGISTICA" size="8" maxlength="12" style="text-align:right;" value="0"/>
       
    <td colspan="2">&nbsp;</td>
</tr> 
 

</form>
<tr><td colspan="12">&nbsp;</td></tr>
 <!-- Botones -->
    <tr> 
      <td colspan="8">
      
          <xsl:if test="$OcultarPrecioReferencia='S'">
					<span class="font11">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_mvm_iva']/node()"/></span><br />
		  </xsl:if>
       		<span class="font11">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='busquedas_en_pagina']/node()"/></span>
            <!--solo para no asisa, no asisa = S => != N-->
            <br />
            <xsl:if test="$OcultarPrecioReferencia!='N'">
            <span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_bajado_desde_ultimo_pedido']/node()"/>.</span><br />
            <span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_subido_desde_ultimo_pedido']/node()"/>.</span>
            </xsl:if>
      </td>      
      <td colspan="3">
      <xsl:choose>
      <xsl:when test="//ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and //ANALISIS/PEDIDO_MINIMO/IMPORTE != ''">
       <div class="boton" id="divContinuar">
      	<a href="javascript:controlPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{//ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
       </div>
      </xsl:when>
      <xsl:otherwise>
       <div class="boton" id="divContinuar">
          <a href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
      </div>
      </xsl:otherwise>
      </xsl:choose>
      </td>    
      <td>&nbsp;</td>         
    </tr>   
 
</tfoot>
</table><!--fin de encuesta tabla-->
</xsl:template>

<!--VISSUM ALICANTE - NUEVO MODELO - VIEJO PEDIDO - VEO PRECIO CON IVA Y SIN IVA-->
<xsl:template name="nuevoModeloViejoPedidoTablaProd">
  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>       <!--idioma fin-->
   		<!--ocultar precio ref-->
        <xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>
        
        
 <!--inicio tabla productos-->
	<table class="encuesta" border="0">
       <thead>
			<tr class="titulosNoAlto"> <!-- ref mvm + provee -->
            		<th class="ocho" align="left">
                        
                    	<xsl:choose>
                        <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                        	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
                        </xsl:when>
                         <xsl:otherwise>
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>.
                        </xsl:otherwise>
                        </xsl:choose>
      				</th>
           			<!-- producto -->
           			<th align="left">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
                    </th>
                   
            		<!-- ref provee-->
            		<th class="center">
                   
                    	<xsl:attribute name="class">
                        	<xsl:choose>
                            <!--si es viamed5 ve ref.prov-->
                            <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">zerouno</xsl:when>
                         
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                        
                    	<xsl:choose>
                        <!--si es farmacia no veo ref prov-->                        
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">
                         </xsl:when>
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                        </xsl:when>
                        </xsl:choose>
            		</th>
                    <th>
                    	<xsl:attribute name="class">
                        <xsl:choose>
                        	<xsl:when test="/Analizar/ANALISIS/SIN_MARCA">zerouno</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">quince</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                        
                        <xsl:choose>
                        	<xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
                            <xsl:otherwise>
                        		<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </th>
            		<!-- ud base -->
            		<th>
                     <xsl:attribute name="class">
                        	<xsl:choose>
                            <!--si es farmacia y viamed5 mas estrecho-->
                            <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
                         	<xsl:otherwise>doce</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
            		</th>
                    <!-- precio ud base sin IVA -->
                    <th class="cuatro">
                          <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_s_iva']/node()"/>
                    </th>
            		<!-- precio ud base con IVA -->
                    <th class="cuatro">
                          <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_c_iva']/node()"/>
                    </th>
                    <!--flechas si precio ha bajado o subido solo para no asisa-->
                    <th class="zerouno"><!--precio ha bajado o subido-->&nbsp;           
            		</th>
            		<!-- cantidad -->
            		<th class="cinco">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
            		</th>
            		<!-- lote -->
           			<th class="tres">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/>
           			</th>
                    <!-- importe total linea sin iva-->
                    <th class="ocho" align="right">
                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_s_iva_2line']/node()"/>
                    </th>
            		<!-- importe total linea con iva-->
                    <th class="ocho" align="right">
                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_c_iva_2line']/node()"/>
                    </th>
            		<!-- seleccionado -->
            		<th class="uno">
                    	<a href="javascript:Seleccionar('SELECCION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='sel']/node()"/></a>
            		</th>
         			</tr>
             </thead>
        <!--fin de titulos-->
		<xsl:for-each select="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW">
                          <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
                        
						<xsl:variable name="usarGrupo">
                        	<xsl:choose>
                            <xsl:when test="/Analizar/ANALISIS/UTILIZAR_GRUPO">S</xsl:when>
                            <xsl:otherwise>N</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        
							<xsl:choose>
								<xsl:when test="position()=1">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="13">
                                        
                                                 <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="$usarGrupo = 'S' and GRUPO !=''">
																	<xsl:value-of select="GRUPO"/>
															</xsl:when>
                                                            <xsl:when test="$usarGrupo = 'N' and SUBFAMILIA !=''">
																	<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                            	<xsl:if test="$usarGrupo = 'S'">
                                                                <!--es viamed5 enseño sin grupo-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
                                                                </xsl:if>
                                                                <xsl:if test="$usarGrupo = 'N'">
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
                                                                </xsl:if>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
									</th>
									</tr>
								</xsl:when>
								<xsl:otherwise>
                                	<xsl:choose>
                                	<xsl:when test="$usarGrupo = 'S' and GRUPO/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/GRUPO!=GRUPO">
                                    	<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="13">
                                               <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="GRUPO !=''">
																	<xsl:value-of select="GRUPO"/>
															</xsl:when>
															<xsl:otherwise>
                                                                <!--es viamed nuevo enseño sin familia-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
											</th>
										</tr>
                                    </xsl:when>
                                	<xsl:when test="$usarGrupo = 'N' and SUBFAMILIA/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/SUBFAMILIA!=SUBFAMILIA">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                               <strong><span class="subfamilia">
														<xsl:choose>
                                                            <xsl:when test="SUBFAMILIA !=''">
																	<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
										</th>
									</tr>
									</xsl:when>
                                    </xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
							
								<xsl:variable name="FormNum"><xsl:value-of select="position()"/></xsl:variable>
								<form method="POST" target="mainFrame">
   								<xsl:attribute name="name">form_<xsl:value-of select="$FormNum"/></xsl:attribute>
								
   									<input type="hidden" name="SELECCIONTOTAL"/>
      								<input type="hidden" name="PRECIO_PRODUCTO_DETERMINADO" value="{../../PRECIO_PRODUCTO_DETERMINADO}"/>
      								<input type="hidden" name="IDDIVISA"/>
      								<input type="hidden" name="PRODUCTOPROVEEDOR_{PLL_ID}" value="{PROVEEDOR}"/>
      
   									<tr>
                                    <!-- ref mvm si no es farmacia + ref prove si es farmacia -->
    										<td align="left">
                                                                                        
                                                <span class="font11">&nbsp;
                                            	<xsl:choose>
                                                    <xsl:when test="PRO_CATEGORIA = 'F'">
                                                        <xsl:choose>
                                                        <xsl:when test="/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                                                            <xsl:value-of select="PRO_REFERENCIA"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:choose>
                                                            <xsl:when test="REFERENCIACLIENTE != ''">
                                                                <xsl:value-of select="REFERENCIACLIENTE"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="REFERENCIAPRIVADA"/>
                                                            </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="PRO_CATEGORIA = 'N'">
                                                        <xsl:choose>
                                                            <xsl:when test="REFERENCIACLIENTE != ''">
                                                                <xsl:value-of select="REFERENCIACLIENTE"/>
                                                            </xsl:when>
                                                            <xsl:when test="REFERENCIAPRIVADA!=''">
                                                                <xsl:value-of select="REFERENCIAPRIVADA"/>   
                                                            </xsl:when>
                                                        </xsl:choose>
                                                     </xsl:when>
                                                </xsl:choose>
                                                </span>
      									</td>
									<!-- nombre link producto -->
										<td style="padding-left:5px;">
                                        <!--si producto es sin stock o descatalogado-->
                                            <xsl:if test="TIPO_SIN_STOCK !=''">
                                                <span class="rojo"><b>[*]</b></span>
                                            </xsl:if>
                                        <!--fin de prod sin stock o descat-->
                                        <xsl:if test="REQUIERE_PRESUPUESTO = 'S'">
                                                <span class="rojo">[<xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_presupuesto']/node()"/>]</span>&nbsp;
                                        </xsl:if>
                                        
                                        <xsl:choose>
          									<xsl:when test="NOMBREPRIVADO!=''">
                                            	<a style="text-decoration:none;">
                                                  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
                                                  <span class="strongAzul"><xsl:value-of select="NOMBREPRIVADO"/></span>
                                                </a>
          									</xsl:when>
          									<xsl:otherwise>
            									 <a style="text-decoration:none;">
                                                  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
                                                  <xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
                                                  <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                                                  <span class="strongAzul"><xsl:value-of select="NOMBRE"/></span>
                                                 </a>
          									</xsl:otherwise>
        									</xsl:choose>
        									        									
      									</td>
    								
    									<xsl:variable name="HayPrecio">
   											<xsl:choose><xsl:when test="TOTAL_FORMATO[.='']">0</xsl:when><xsl:otherwise>1</xsl:otherwise></xsl:choose>
    									</xsl:variable> 
    									<input type="hidden" name="TARIFA_UNI_{PLL_ID}" value="{TARIFA}"/>   
    										
      									<!-- marca si es farmacia + ref provee si no es farmacia-->
      									<td class="center">
                                       		   <xsl:choose>
                                                     <!--si es farmacia no veo ref prov-->
                                                     <xsl:when test="PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                                                     </xsl:when>
                                                     <xsl:when test="PRO_CATEGORIA = 'N'">
                                                        <xsl:value-of select="PRO_REFERENCIA"/> 
                                                    </xsl:when>
                                                </xsl:choose>
         	 								
      									</td>
                                        <!--marca -->
                                        <td class="center" style="font-size:11px;">
                                             <xsl:choose>
                                                <xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
                                                <xsl:otherwise>
                                               		<xsl:value-of select="MARCA"/>
                                                </xsl:otherwise>
                                             </xsl:choose>
                                         
                                        </td>
      									<!-- ud base -->
      									<td class="center">
        									<xsl:value-of select="PRO_UNIDADBASICA"/>&nbsp;
      									</td>
      									<!-- precio sin iva-->
     	 								<td class="center">
												<input type="text" class="noinput" size="7" align="right" name="PRECIOUNITARIO_{PLL_ID}" value="{TARIFA}" onFocus="this.blur();" style="text-align:right;"/>
        										
        										<input type="hidden" name="PRO_UNIDADESPORLOTE_{PLL_ID}" value="{PRO_UNIDADESPORLOTE_SINFORMATO}"/>
        										<input type="hidden" name="DESCRIPCION_PRODUCTO_{PLL_ID}">
          										<xsl:choose>
            										<xsl:when test="NOMBREPRIVADO!=''">
              										<xsl:attribute name="value">
                										<xsl:value-of select="NOMBREPRIVADO"/>
              										</xsl:attribute>
            										</xsl:when>
            										<xsl:otherwise>
              										<xsl:attribute name="value">
                										<xsl:value-of select="NOMBRE"/>
              										</xsl:attribute>
            										</xsl:otherwise>
          										</xsl:choose>
        										</input>
      									</td>  
                                        <!--precio con iva-->
                                        <td class="center">
                                        	 <input type="text" class="noinput" size="7" name="PRECIOUNITARIOCONIVA_{PLL_ID}" value="{TARIFA_CONIVA}" onFocus="this.blur();" style="text-align:right;"/> 
                                        </td>
                                        <!--flechas si precio ha bajado o subido--> 
                                        <td>
                                        <xsl:choose>
											<xsl:when test="$OcultarPrecioReferencia='N'">
                                             	<xsl:if test="CARO"><img src="http://www.newco.dev.br/images/order_a_rojo.gif"/></xsl:if>
                       						 	<xsl:if test="BARATO"><img src="http://www.newco.dev.br/images/order_d_verde.gif"/></xsl:if>
											</xsl:when>
                                            
                                            <xsl:when test="$OcultarPrecioReferencia='S'">
											
                                            	<xsl:if test="PRECIOFINAL_CARO"><img src="http://www.newco.dev.br/images/order_a_rojo.gif"/></xsl:if>
                       						 	<xsl:if test="PRECIOFINAL_BARATO"><img src="http://www.newco.dev.br/images/order_d_verde.gif"/></xsl:if>
                                            </xsl:when>
                                        </xsl:choose>
                                      
                                        </td>
                                        
                                       
      									<!-- cantidad -->
      									<td class="center">
        									<xsl:element name="input">
          									<xsl:attribute name="value"><xsl:value-of select="CANTIDAD_SINFORMATO"/></xsl:attribute>
          									<xsl:attribute name="type">text</xsl:attribute>
          									<xsl:attribute name="name">NuevaCantidad_<xsl:value-of select="PLL_ID"/></xsl:attribute>
          									<xsl:attribute name="size">4</xsl:attribute>
          									<xsl:attribute name="maxlength">6</xsl:attribute>
          									<xsl:attribute name="style">text-align:right;</xsl:attribute>
          									<xsl:attribute name="onBlur">if(UnidadesALotes(this.value,'<xsl:value-of select="PRO_UNIDADESPORLOTE_SINFORMATO"/>',this,document.forms['form_<xsl:value-of select="$FormNum"/>'])) realizarCalculos(document.forms['form_<xsl:value-of select="$FormNum"/>'],<xsl:value-of select="PLL_ID"/>,'<xsl:value-of select="$accion"/>',<xsl:value-of select="$HayPrecio"/>); else realizarCalculosPorDefinir(document.forms['form_<xsl:value-of select="$FormNum"/>'],<xsl:value-of select="PLL_ID"/>,'<xsl:value-of select="$accion"/>',<xsl:value-of select="$HayPrecio"/>);</xsl:attribute>
        									</xsl:element>
      									</td>
      									<!-- lote -->
      									<td class="center">
                                        <xsl:text>&nbsp;&nbsp;</xsl:text>
                                        	<input type="hidden" name="UNIDADESPORLOTE_{PLL_ID}" value="{PRO_UNIDADESPORLOTE}" />
      										<xsl:value-of select="PRO_UNIDADESPORLOTE"/>
      									</td>
                                        <!--importe sin iva-->
              								<td class="textRight">
                                                <input type="text" name="NuevoImporte_{PLL_ID}" size="8" maxlength="10" value="{TOTAL_FORMATO}" class="noinput" onFocus="this.blur();" style="text-align:right;"/>
										    </td>
      									<!--importe con iva-->
              								<td class="textRight">
              									<input type="text" name="NuevoImporteConIVA_{PLL_ID}" size="8" maxlength="10"  value="{TARIFA_TOTAL_CONIVA}" class="noinput" onFocus="this.blur();" style="text-align:right;"/>
										    </td>
      										<!-- seleccionado -->
      										<td class="center">
        										<input type="checkbox" name="SELECCION">
          										<xsl:attribute name="value"><xsl:value-of select="PLL_ID"/></xsl:attribute>
          										<xsl:choose>
            										<xsl:when test="$accion='DIRECTO'">
                                                        <xsl:if test="TARIFA[.=''] or (TIPO_SIN_STOCK != '' and TIPO_SIN_STOCK ='D') ">                                                            <xsl:attribute name="disabled">disabled</xsl:attribute>
                                                        </xsl:if>
                                                       <!-- <xsl:if test="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio = 'S' and TIPO_SIN_STOCK != '' and TIPO_SIN_STOCK ='D'">-->
            										</xsl:when>
          										</xsl:choose>

          										<xsl:attribute name="onClick">
            										<xsl:choose>
              											<xsl:when test="$accion='DIRECTO' and REQUIERE_PRESUPUESTO != 'S'">sumar_pedidoDirecto();</xsl:when>
                                                                                                <xsl:when test="$accion='DIRECTO' and REQUIERE_PRESUPUESTO = 'S'">sumar_pedidoDirecto(); requierePresupuesto();</xsl:when>
                                                                                                <xsl:otherwise>sumar_Multioferta();</xsl:otherwise>
            										</xsl:choose>
          										</xsl:attribute>
        										</input>  
      										</td>
    									</tr> 
                                        <!-- si sin stock enseño info en una nueva linea-->
                                        <xsl:if test="TIPO_SIN_STOCK !=''">
                                        <tr>
                                        	<td>&nbsp;</td>
                                        	<td style="background:#FFFF99;" colspan="13">
                                             &nbsp;<span class="rojo"><b>[*]</b></span>&nbsp;<xsl:value-of select="TEXTO_SIN_STOCK"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.&nbsp;<xsl:value-of select="REFERENCIAALTERNATIVA"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='Prod']/node()"/>.&nbsp;<xsl:value-of select="DESCRIPCIONALTERNATIVA"/>
                                            </td>
                                        </tr>
                                        </xsl:if>
    								</form>
					
						
  							</xsl:for-each>
					
   <tfoot>
 
<tr> 
      <td colspan="11">&nbsp;</td>
</tr>
<!--form sumaTotal-->
<form name="sumaTotal">
<tr>
  
    <td class="textRight" colspan="9">&nbsp;</td> 
   
    <!--si es españa-->
	<xsl:choose>
      <xsl:when test="//ACCION='DIRECTO'">
       <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
       <td class="textRight">    
 	   <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
       </td>
       <td class="textRight">
           <input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
       </td>
      </xsl:when>
      
      <xsl:otherwise>
            <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
        <td class="textRight">    
 	    <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
        </td>
        <td class="textRight">    
        	<input type="hidden" name="sumaTotal"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>   
    
    <input type="hidden" class="noinput" name="sumaTotalBrasil" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
    <input type="hidden" class="noinput" name="COSTE_LOGISTICA" size="8" maxlength="12" style="text-align:right;" value="0"/>
   
    <td colspan="2">&nbsp;</td>
</tr> 
 

</form>
<tr> 
      <td colspan="13">&nbsp;</td>
	</tr>

 <!-- Botones -->
 
   
    <tr> 
      <td colspan="10">
       		<span class="font11">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='busquedas_en_pagina']/node()"/></span>
            <!--solo para no asisa, no asisa = S => != N-->
            <br />
            <xsl:if test="$OcultarPrecioReferencia!='N'">
            <span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_bajado_desde_ultimo_pedido']/node()"/>.</span><br />
            <span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_subido_desde_ultimo_pedido']/node()"/>.</span>
            </xsl:if>
      </td>      
      <td colspan="3">
      <xsl:choose>
      <xsl:when test="//ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and //ANALISIS/PEDIDO_MINIMO/IMPORTE != ''">
       <div class="boton" id="divContinuar">
      	<a href="javascript:controlPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{//ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
       </div>
      </xsl:when>
      <xsl:otherwise>
       <div class="boton" id="divContinuar">
          <a href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
      </div>
      </xsl:otherwise>
      </xsl:choose>
      </td>             
    </tr>   
 
</tfoot>
</table><!--fin de encuesta tabla-->
</xsl:template>


<!--NUEVO MODELO - NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL... VEO PRECIO FINAL -->
<xsl:template name="nuevoModeloNuevoPedidoTablaProd">
  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>       <!--idioma fin-->
   		<!--ocultar precio ref-->
         <xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>
        
        
 <!--inicio tabla productos-->
	<table class="encuesta" border="0">
       <thead>
			<tr class="titulosNoAlto"> <!-- ref mvm + provee -->
            		<th class="ocho" align="left">
                                          
                    	<xsl:choose>
                        <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                        	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
                        </xsl:when>
                         <xsl:otherwise>
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>.
                        </xsl:otherwise>
                        </xsl:choose>
      				</th>
           			<!-- producto -->
           			<th align="left">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
                    </th>
                   
            		<!-- ref provee-->
            		<th class="center">
                    	<xsl:attribute name="class">
                        	<xsl:choose>
                             <!--si es farmacia no veo ref prov-->
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">zerouno</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                        
                    	<xsl:choose>
                        <!--si es farmacia no veo ref prov-->
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">
                         </xsl:when>
                         <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                        </xsl:when>
                        </xsl:choose>
            		</th>
                    <!--marca-->
                    <th>
                    	<xsl:attribute name="class">
                        <xsl:choose>
                        	<xsl:when test="/Analizar/ANALISIS/SIN_MARCA">zerouno</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">veinte</xsl:when>
                         	<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                    
                        <xsl:choose>
                        	<xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
                            <xsl:otherwise>
                        		<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </th>
            		<!-- ud base -->
            		<th>
                     <xsl:attribute name="class">
                        	<xsl:choose>
                            <!--si es farmacia y viamed5 mas estrecho-->
                            <xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
                         	<xsl:otherwise>doce</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
            		</th>
            		<!-- precio ud base con IVA -->
                    <th class="cinco">
                        <!--<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_c_iva']/node()"/>-->
                        <!--<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/>cambiado 26-11-13-->
                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_iva']/node()"/>
                    </th>
                    
                    <!--flechas si precio ha bajado o subido -->
                    <th class="zerouno"><!--precio ha bajado o subido-->&nbsp;           
            		</th>
            		<!-- cantidad -->
            		<th class="cinco">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
            		</th>
            		<!-- lote -->
           			<th class="tres">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/>
           			</th>
					
            		<!-- importe total linea-->
                    <th class="ocho" align="right">
                         <xsl:copy-of select="document($doc)/translation/texts/item[@name='total']/node()"/>
                    </th>
            		<!-- seleccionado -->
            		<th class="uno">
                    	<a href="javascript:Seleccionar('SELECCION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='sel']/node()"/></a> 
            		</th>
         			</tr>
             </thead>
        <!--fin de titulos-->
		<xsl:for-each select="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW">
                          <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
                        
							<xsl:variable name="usarGrupo">
                        	<xsl:choose>
                            <xsl:when test="/Analizar/ANALISIS/UTILIZAR_GRUPO">S</xsl:when>
                            <xsl:otherwise>N</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        
							<xsl:choose>
								<xsl:when test="position()=1">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                        
                                                 <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="$usarGrupo = 'S' and GRUPO !=''">
																	<xsl:value-of select="GRUPO"/>
															</xsl:when>
                                                            <xsl:when test="$usarGrupo = 'N' and SUBFAMILIA !=''">
																	<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                            	<xsl:if test="$usarGrupo = 'S'">
                                                                <!--es viamed5 enseño sin grupo-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
                                                                </xsl:if>
                                                                <xsl:if test="$usarGrupo = 'N'">
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
                                                                </xsl:if>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
									</th>
									</tr>
								</xsl:when>
								<xsl:otherwise>
                                	<xsl:choose>
                                	<xsl:when test="$usarGrupo = 'S' and GRUPO/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/GRUPO!=GRUPO">
                                    	<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                               <strong><span class="subfamilia">
														<xsl:choose>
															<xsl:when test="GRUPO !=''">
																	<xsl:value-of select="GRUPO"/>
															</xsl:when>
															<xsl:otherwise>
                                                                <!--es viamed nuevo enseño sin familia-->
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
											</th>
										</tr>
                                    </xsl:when>
                                	<xsl:when test="$usarGrupo = 'N' and SUBFAMILIA/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/SUBFAMILIA!=SUBFAMILIA">
									<tr class="subCategorias">
										<th>&nbsp;</th>
                                        <th align="left" colspan="11">
                                               <strong><span class="subfamilia">
														<xsl:choose>
                                                            <xsl:when test="SUBFAMILIA !=''">
																	<xsl:value-of select="SUBFAMILIA"/>
															</xsl:when>
															<xsl:otherwise>
                                                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
															</xsl:otherwise>
														</xsl:choose>
                                               </span></strong> 
										</th>
									</tr>
									</xsl:when>
                                    </xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
							
								<xsl:variable name="FormNum"><xsl:value-of select="position()"/></xsl:variable>
								<form method="POST" target="mainFrame">
   								<xsl:attribute name="name">form_<xsl:value-of select="$FormNum"/></xsl:attribute>
								
   									<input type="hidden" name="SELECCIONTOTAL"/>
      								<input type="hidden" name="PRECIO_PRODUCTO_DETERMINADO" value="{../../PRECIO_PRODUCTO_DETERMINADO}"/>
      								<input type="hidden" name="IDDIVISA"/>
      								<input type="hidden" name="PRODUCTOPROVEEDOR_{PLL_ID}" value="{PROVEEDOR}"/>
      
   									<tr>
                                    <!-- ref mvm si no es farmacia + ref prove si es farmacia -->
    										<td align="left">
                                           
                                                <span class="font11">&nbsp;
                                            	<xsl:choose>
                                                    <xsl:when test="PRO_CATEGORIA = 'F'">
                                                        <xsl:choose>
                                                        <xsl:when test="/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
                                                            <xsl:value-of select="PRO_REFERENCIA"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:choose>
                                                            <xsl:when test="REFERENCIACLIENTE != ''">
                                                                <xsl:value-of select="REFERENCIACLIENTE"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="REFERENCIAPRIVADA"/>
                                                            </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="PRO_CATEGORIA = 'N'">
                                                        <xsl:choose>
                                                            <xsl:when test="REFERENCIACLIENTE != ''">
                                                                <xsl:value-of select="REFERENCIACLIENTE"/>
                                                            </xsl:when>
                                                            <xsl:when test="REFERENCIAPRIVADA!=''">
                                                                <xsl:value-of select="REFERENCIAPRIVADA"/>   
                                                            </xsl:when>
                                                        </xsl:choose>
                                                     </xsl:when>
                                                </xsl:choose>
                                                </span>
         	 								 <!--</a>-->
      					</td>
					<!-- nombre link producto -->
					<td style="padding-left:5px;">
                                            <xsl:if test="TIPO_SIN_STOCK !=''">
                                                <span class="rojo"><b>[*]</b></span>
                                            </xsl:if>
                                            <xsl:if test="REQUIERE_PRESUPUESTO = 'S'">
                                                <span class="rojo">[<xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_presupuesto']/node()"/>]</span>&nbsp;
                                            </xsl:if>
                                            <xsl:choose>
          					<xsl:when test="NOMBREPRIVADO!=''">
                                                    <a style="text-decoration:none;">
                                                      <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
                                                      <span class="strongAzul"><xsl:value-of select="NOMBREPRIVADO"/></span>
                                                    </a>
          					</xsl:when>
          					<xsl:otherwise>
                                                    <a style="text-decoration:none;">
                                                    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
                                                    <xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
                                                    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                                                    <span class="strongAzul"><xsl:value-of select="NOMBRE"/></span>
                                                    </a>
          					</xsl:otherwise>
        					</xsl:choose>
        									        									
      									</td>
    								
    									<xsl:variable name="HayPrecio">
   											<xsl:choose><xsl:when test="TOTAL_FORMATO[.='']">0</xsl:when><xsl:otherwise>1</xsl:otherwise></xsl:choose>
    									</xsl:variable> 
    									<input type="hidden" name="TARIFA_UNI_{PLL_ID}" value="{TARIFA}"/>   
    										
      									<!-- ref provee si no es farmacia-->
      									<td class="center">
                                       		   <xsl:choose>
                                                     <!--farmacia nada ref prov-->
                                                     <xsl:when test="PRO_CATEGORIA = 'F'">
                                                     </xsl:when>
                                                     <xsl:when test="PRO_CATEGORIA = 'N'">
                                                        <xsl:value-of select="PRO_REFERENCIA"/> 
                                                    </xsl:when>
                                                </xsl:choose>
      									</td>
                                        <!--marca -->
                                        <td class="center" style="font-size:11px;">
                                             <xsl:choose>
                                                <xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
                                                <xsl:otherwise>
                                               		<xsl:value-of select="MARCA"/>
                                                </xsl:otherwise>
                                             </xsl:choose>
                                        </td>
      									<!-- ud base -->
      									<td class="center">
        									<xsl:value-of select="PRO_UNIDADBASICA"/>&nbsp;
      									</td>
      									
                                        <input type="hidden" class="noinput" size="7" align="right" name="PRECIOUNITARIO_{PLL_ID}" value="{TARIFA_TOTAL}" onFocus="this.blur();" style="text-align:right;"/>
        								<input type="hidden" name="PRO_UNIDADESPORLOTE_{PLL_ID}" value="{PRO_UNIDADESPORLOTE_SINFORMATO}"/>
        								<input type="hidden" name="DESCRIPCION_PRODUCTO_{PLL_ID}">
          										<xsl:choose>
            										<xsl:when test="NOMBREPRIVADO!=''">
              										<xsl:attribute name="value">
                										<xsl:value-of select="NOMBREPRIVADO"/>
              										</xsl:attribute>
            										</xsl:when>
            										<xsl:otherwise>
              										<xsl:attribute name="value">
                										<xsl:value-of select="NOMBRE"/>
              										</xsl:attribute>
            										</xsl:otherwise>
          										</xsl:choose>
        								</input>
                                        <!--precio con IVA-->
              							<td>
                                            <input type="text" class="noinput" size="7" name="PRECIOUNITARIOCONIVA_{PLL_ID}" value="{TARIFA_TOTAL}" onFocus="this.blur();" style="text-align:right;"/>  
										</td>
                                        <!--flechas si precio ha bajado o subido--> 
                                        <td>
                                        <xsl:choose>
											<xsl:when test="$OcultarPrecioReferencia='N'">
                                             	<xsl:if test="CARO"><img src="http://www.newco.dev.br/images/order_a_rojo.gif"/></xsl:if>
                       						 	<xsl:if test="BARATO"><img src="http://www.newco.dev.br/images/order_d_verde.gif"/></xsl:if>
											</xsl:when>
                                            
                                            <xsl:when test="$OcultarPrecioReferencia='S'">
											
                                            	<xsl:if test="PRECIOFINAL_CARO"><img src="http://www.newco.dev.br/images/order_a_rojo.gif"/></xsl:if>
                       						 	<xsl:if test="PRECIOFINAL_BARATO"><img src="http://www.newco.dev.br/images/order_d_verde.gif"/></xsl:if>
                                            </xsl:when>
                                        </xsl:choose>
                                      
                                        </td>
                                        
                                       
      									<!-- cantidad -->
      									<td class="center">
        									<xsl:element name="input">
          									<xsl:attribute name="value"><xsl:value-of select="CANTIDAD_SINFORMATO"/></xsl:attribute>
          									<xsl:attribute name="type">text</xsl:attribute>
          									<xsl:attribute name="name">NuevaCantidad_<xsl:value-of select="PLL_ID"/></xsl:attribute>
          									<xsl:attribute name="size">4</xsl:attribute>
          									<xsl:attribute name="maxlength">6</xsl:attribute>
          									<xsl:attribute name="style">text-align:right;</xsl:attribute>
          									<xsl:attribute name="onBlur">if(UnidadesALotes(this.value,'<xsl:value-of select="PRO_UNIDADESPORLOTE_SINFORMATO"/>',this,document.forms['form_<xsl:value-of select="$FormNum"/>'])) realizarCalculos(document.forms['form_<xsl:value-of select="$FormNum"/>'],<xsl:value-of select="PLL_ID"/>,'<xsl:value-of select="$accion"/>',<xsl:value-of select="$HayPrecio"/>); else realizarCalculosPorDefinir(document.forms['form_<xsl:value-of select="$FormNum"/>'],<xsl:value-of select="PLL_ID"/>,'<xsl:value-of select="$accion"/>',<xsl:value-of select="$HayPrecio"/>);</xsl:attribute>
        									</xsl:element>
      									</td>
      									<!-- lote -->
      									<td class="center">
                                        <xsl:text>&nbsp;&nbsp;</xsl:text>
                                        	<input type="hidden" name="UNIDADESPORLOTE_{PLL_ID}" value="{PRO_UNIDADESPORLOTE}" />
      										<xsl:value-of select="PRO_UNIDADESPORLOTE"/>
      									</td>
                                    
      									<!-- importe total con iva-->              
                                            <td class="textRight">
                                             <input type="text" name="NuevoImporte_{PLL_ID}" size="8" maxlength="10" value="{LINEASUMAFINAL_FORMATO}" class="noinput" onFocus="this.blur();" style="text-align:right;"/>
                                                <input type="hidden" name="NuevoImporteConIVA_{PLL_ID}" size="8" maxlength="10"  value="{TARIFA_TOTAL_CONIVA}" class="noinput" onFocus="this.blur();" style="text-align:right;"/>
                                            </td>
      										<!-- seleccionado -->
      										<td class="center">
        										<input type="checkbox" name="SELECCION">
          										<xsl:attribute name="value"><xsl:value-of select="PLL_ID"/></xsl:attribute>
          										<xsl:choose>
            										<xsl:when test="$accion='DIRECTO'">
                                                        <xsl:if test="TARIFA[.=''] or (TIPO_SIN_STOCK != '' and TIPO_SIN_STOCK ='D') ">                                                            <xsl:attribute name="disabled">disabled</xsl:attribute>
                                                        </xsl:if>
            										</xsl:when>
          										</xsl:choose>

          										<xsl:attribute name="onClick">
            										<xsl:choose>
              											<xsl:when test="$accion='DIRECTO' and REQUIERE_PRESUPUESTO != 'S'">sumar_pedidoDirecto();</xsl:when>
                                                                                                <xsl:when test="$accion='DIRECTO' and REQUIERE_PRESUPUESTO = 'S'">sumar_pedidoDirecto(); requierePresupuesto();</xsl:when>
                                                                                                <xsl:otherwise>sumar_Multioferta();</xsl:otherwise>
            										</xsl:choose>
          										</xsl:attribute>
        										</input>  
      										</td>
    									</tr> 
                                        <!-- si sin stock enseño info en una nueva linea-->
                                        <xsl:if test="TIPO_SIN_STOCK !=''">
                                        <tr>
                                        	<td>&nbsp;</td>
                                        	<td style="background:#FFFF99;" colspan="13">
                                             &nbsp;<span class="rojo"><b>[*]</b></span>&nbsp;<xsl:value-of select="TEXTO_SIN_STOCK"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.&nbsp;<xsl:value-of select="REFERENCIAALTERNATIVA"/>&nbsp;
                                             <xsl:value-of select="document($doc)/translation/texts/item[@name='Prod']/node()"/>.&nbsp;<xsl:value-of select="DESCRIPCIONALTERNATIVA"/>
                                            </td>
                                        </tr>
                                        </xsl:if>
    								</form>
					
						
  							</xsl:for-each>
					
   <tfoot>
 
<tr> 
      <td colspan="11">&nbsp;</td>
</tr>
<!--form sumaTotal-->
<form name="sumaTotal">
<tr>
   
    <td class="textRight" colspan="6">&nbsp;</td> 
    <!--si es españa-->
	<xsl:choose>
      <xsl:when test="//ACCION='DIRECTO'">
       <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
       <td class="textRight" colspan="2">    
 	   <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
       </td>
       <td class="textRight" colspan="2">
           <input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
           
       </td>
      </xsl:when>
      
      <xsl:otherwise>
            <input type="hidden" name="NUM_MUESTRAS" value="{//Analizar/ANALISIS/MUESTRASPREVIAS}"/>
        <td class="textRight" colspan="2">   
 	    <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
        </td>
        <td class="textRight" colspan="2">    
        	<input type="hidden" name="sumaTotal"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>   
    
    <input type="hidden" class="noinput" name="sumaTotalBrasil" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
    <input type="hidden" class="noinput" name="COSTE_LOGISTICA" size="8" maxlength="12" style="text-align:right;" value="0"/>
   
    <td colspan="2">&nbsp;</td>
</tr> 
</form>
<tr> 
      <td colspan="11">&nbsp;</td>
	</tr>

 <!-- Botones -->
 
   
    <tr> 
      <td colspan="8">
     
          <xsl:if test="$OcultarPrecioReferencia='S'">
					<span class="font11">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_mvm_iva']/node()"/></span><br />
		  </xsl:if>
       		<span class="font11">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='busquedas_en_pagina']/node()"/></span>
            <!--solo para no asisa, no asisa = S => != N-->
            <br />
            <xsl:if test="$OcultarPrecioReferencia!='N'">
            <span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_bajado_desde_ultimo_pedido']/node()"/>.</span><br />
            <span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_subido_desde_ultimo_pedido']/node()"/>.</span>
            </xsl:if>
      </td>      
      <td colspan="3">
      <xsl:choose>
      <xsl:when test="//ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and //ANALISIS/PEDIDO_MINIMO/IMPORTE != ''">
       <div class="boton" id="divContinuar">
      	<a href="javascript:controlPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{//ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
       </div>
      </xsl:when>
      <xsl:otherwise>
       <div class="boton" id="divContinuar">
          <a href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
      </div>
      </xsl:otherwise>
      </xsl:choose>
      </td>             
    </tr>   
 
</tfoot>
</table><!--fin de encuesta tabla-->
</xsl:template>



<xsl:template match="PROVEEDOR">
   <i><a class="suave">
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',100,80,0,0)</xsl:attribute> 
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    <!-- <xsl:attribute name="target">_new</xsl:attribute> -->
    
    <xsl:value-of select="."/>
   </a></i>
</xsl:template> 
  

  
  <!-- Aqui empiezan los templates del frame de abajo (fechas) -->
  <!-- Aqui empiezan los templates del frame de abajo (fechas) -->
  
  
<xsl:template match="ANALBOT">

<form name="formBot" method="POST">
  <input type="hidden" name="SELECCIONTOTAL"/>
  <!--<input type="hidden" name="NOSELECCIONTOTAL"/>-->
  <input type="hidden" name="LP_ID" value="{LP_ID}"/>
  <input type="hidden" name="ACCION" value="{$accion}"/>
  <input type="hidden" name="STRING_CANTIDADES"/>
  <input type="hidden" name="IDDIVISA"/>
  <input type="hidden" name="LP_IDFORMAPAGO"/>
  <input type="hidden" name="LP_IDPLAZOPAGO"/>
  <input type="hidden" name="LP_FORMAPAGO"/>
  <input type="hidden" name="COSTE_LOGISTICA"/>
  
  <xsl:choose>
  
   <!--
    |   En los pedidos directos solo pedimos la fecha de entrega
    |   FECHA_DECISION i LP_OFERTASVISIBLES norl.
    +-->
  <!--
   |    CASO 1: PEDIDO DIRECTO
   +-->
    
  <xsl:when test="$accion='DIRECTO'">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">	
    <tr valign="top" align="center">
      <td width="20%" class="tituloCamp"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_de_entrega']/node()"/>:</td>
      <td width="20%" class="tituloCamp"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_de_pago']/node()"/>:</td>
      <td width="20%" class="tituloCamp"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/>:</td>      
      <td width="20%" class="tituloCamp"><xsl:value-of select="document($doc)/translation/texts/item[@name='coste_total']/node()"/>:</td>  	
    </tr>
   
    <tr valign="top" align="center">
      <td colspan="4">&nbsp;</td>
    </tr>
    
    <tr valign="top" align="center">
      <td>

	  <!-- para añadir valores en el desplegable de COMBO_ENTREGA hay que hacerlo en el fichero xsql	-->
      <select name="COMBO_ENTREGA" size="1" onChange="calculaFecha('ENTREGA',this.options[this.selectedIndex].value);">
    		  <option value="1" selected="true">1</option>
    		  <option value="2">2</option>
    		  <option value="3">3</option>
    		  <option value="4">4</option>
              <option value="4">6</option>
    		  <option value="7">7</option>
    		  <option value="10">10</option>
    		  <option value="11">11</option>
    		  <option value="15">15</option>
    		  <option value="30">30</option>
  	        </select>
      <input type="text" name="FECHA_ENTREGA" size="10" maxlength="10" value="{/Analizar/ANALISIS/CABECERA/LISTA/LP_FECHAENTREGA}"/>
      <br/>día(s)&nbsp;&nbsp;&nbsp;dd/mm/aaaa&nbsp;&nbsp;&nbsp;
      </td>
      
      <td>
      
      <select name="COMBO_PAGO" size="1" onChange="calculaFecha('PAGO',this.options[this.selectedIndex].value);">
    		  <option value="30" selected="true">30</option>
    		  <option value="60">60</option>
    		  <option value="90">90</option>
    		  <option value="120">120</option>
  	        </select>
      <input type="text" name="FECHA_PAGO" size="10" maxlength="10" value="{/Analizar/FECHA_PAGO}"/>
      <br/>día(s)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dd/mm/aaaa&nbsp;&nbsp;&nbsp;
      </td> 
      <td><xsl:variable name="IDAct"/><xsl:apply-templates select="field[@name='LPP_IDFORMA']"/></td>
      <td><input type="text" name="sum" size="14" readonly="readonly"/><!--Pts--></td>

    </tr>
    
    <tr valign="top" align="center">
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td colspan="2">&nbsp;</td>
    </tr>
    </table>
  
  <!-- Botones -->
  <table width="100%" border="0" cellspacing="0" cellpadding="0">    
    <tr align="center"> 
      <td>
        <!--<xsl:apply-templates select="/Analizar/button[@label='Cancelar']"/>-->
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="/Analizar/button[@label='Cancelar']"/>
        </xsl:call-template>
      </td>      
      <td colspan="2" width="80%">&nbsp;</td>
      <td>
        <!--<xsl:apply-templates select="/Analizar/button[@label='Siguiente']"/>-->
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="/Analizar/button[@label='Siguiente']"/>
        </xsl:call-template>
      </td>             
    </tr>    
  </table>
  </xsl:when>
  <!--
   |    CASO 2: OFERTA
   +-->
  <xsl:otherwise>    
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">	
    <tr valign="top" align="center">
      <td width="25%" class="tituloCamp"></td>
      <td width="25%" class="tituloCamp"></td>	
    </tr>
    <!-- mencion 'opcional' -->
    <tr valign="top" align="center" height="25">
      <td>&nbsp;</td>
      <td>&nbsp;</td>
     
    </tr>
    
    <tr align="center" valign="top">
      <td>
         
  	     <input type="hidden" name="FECHA_DECISION" size="10" maxlength="10" value="{/Analizar/ANALISIS/CABECERA/LISTA/LP_FECHADECISION}"/>
      </td>
  	        <input type="hidden" name="FECHANO_ENTREGA" size="10" maxlength="10" value=""/>
       <td><input type="hidden" name="sum" size="14" readonly="readonly"/></td>
    </tr>
    
    <tr align="center" valign="top">
      <td>&nbsp;
      </td>
      <input type="hidden" name="FECHA_ENTREGA"/>
    
      <td>&nbsp;</td>
    
    </tr></table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr align="center"> 
      <td>
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="/Analizar/button[@label='Cancelar']"/>
        </xsl:call-template>
        </td>      
      <td colspan="2" width="80%">&nbsp;</td>
      <td>
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="/Analizar/button[@label='Siguiente']"/>
        </xsl:call-template>
        </td>             
    </tr>    
  </table>
  </xsl:otherwise>    
  </xsl:choose>
</form>
</xsl:template>





<!--     templates de la nueva version  -->

<xsl:template name="botones">
  <!-- Botones -->
  <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
    <xsl:choose>
      <xsl:when test="//ACCION='DIRECTO'">
        <tr>
          <td colspan="4" align="right">
            <form name="sumaTotal">
 	    <xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<input type="text" name="sumaTotal" class="inputOcultoBlancoBold" style="text-align:right;" onFocus="this.blur();"/>
 	    </form>
 	   
          </td>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr>
          <td colspan="4" align="right">
            <form name="sumaTotal">
 	    <input type="hidden" name="sumaTotal"/>
 	    </form>
          </td>
        </tr>
      </xsl:otherwise>
    </xsl:choose>   
    <tr align="center"> 
      <td>
        <!--<xsl:apply-templates select="/Analizar/button[@label='Cancelar']"/>-->
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="/Analizar/button[@label='Cancelar']"/>
        </xsl:call-template>
      </td>      
      <td colspan="2" width="80%">&nbsp;</td>
      <td>
        <!--<xsl:apply-templates select="/Analizar/button[@label='Siguiente']"/>-->
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="/Analizar/button[@label='Siguiente']"/>
        </xsl:call-template>
      </td>             
    </tr>    
  </table>
</xsl:template>







<xsl:template name="hiddensPedido">
  <input type="hidden" name="SELECCIONTOTAL"/>
  <!--<input type="hidden" name="NOSELECCIONTOTAL"/>-->
  <input type="hidden" name="LP_ID" value="{LP_ID}"/>
  <input type="hidden" name="ACCION" value="{$accion}"/>
  <input type="hidden" name="STRING_CANTIDADES"/>
  <input type="hidden" name="IDDIVISA" value="{../../field_plus/@current}"/>
  <input type="hidden" name="LP_IDFORMAPAGO"/>
  <input type="hidden" name="LP_IDPLAZOPAGO"/>
  <input type="hidden" name="LP_FORMAPAGO"/>
</xsl:template>









<xsl:template name="hiddensOferta">


  <input type="hidden" name="SELECCIONTOTAL"/>
  <!--<input type="hidden" name="NOSELECCIONTOTAL"/>-->
  <input type="hidden" name="LP_ID" value="{LP_ID}"/>
  <input type="hidden" name="ACCION" value="{$accion}"/>
  <input type="hidden" name="STRING_CANTIDADES"/>
  <input type="hidden" name="IDDIVISA"/>
  <input type="hidden" name="LP_IDFORMAPAGO"/>
  <input type="hidden" name="LP_IDPLAZOPAGO"/>
  <input type="hidden" name="LP_FORMAPAGO"/>  

  <input type="hidden" name="FECHA_DECISION" size="10" maxlength="10" value="{/Analizar/ANALISIS/CABECERA/LISTA/LP_FECHADECISION}"/>
  <input type="hidden" name="FECHANO_ENTREGA" size="10" maxlength="10" value=""/>
  <input type="hidden" name="sum" size="14" readonly="readonly"/>
  <input type="hidden" name="FECHA_ENTREGA"/>

</xsl:template>


<xsl:template name="direccion">
    <xsl:param name="path"/>
    <p class="textLeft">
    <input type="text" name="CEN_DIRECCION" size="50" value="{$path/CEN_DIRECCION}" style="text-align:left; margin-top:10px;" class="noinput" onFocus="this.blur();"/>
    <br />
   
    <!--spain-->
    <xsl:choose>
   <xsl:when test="/Analizar/ANALISIS/IDPAIS != '55'">
   <input type="text" name="CEN_CPOSTAL" size="5" value="{$path/CEN_CPOSTAL}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
   </xsl:when>
   <xsl:when test="/Analizar/ANALISIS/IDPAIS = '55'">
    <input type="text" name="CEN_CPOSTAL" size="10" value="{$path/CEN_CPOSTAL}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
   </xsl:when>
   </xsl:choose>
    -
    <input type="text" name="CEN_POBLACION" size="20" value="{$path/CEN_POBLACION}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
    
    <input type="hidden" name="CEN_PROVINCIA" size="30" value="{$path/CEN_PROVINCIA}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
    </p>
  </xsl:template>
  
<xsl:template name="FORMASPAGO">
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="FORMASPAGO/field"></xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="PLAZOSPAGO">
  <xsl:param name="onChange"/>
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="PLAZOSPAGO/field"></xsl:with-param>
    	<xsl:with-param name="onChange"><xsl:value-of select="$onChange"/></xsl:with-param>
    </xsl:call-template>
</xsl:template>                  

<xsl:template name="COMBO_ENTREGA">    
	<xsl:call-template name="field_funcion">
    	<xsl:with-param name="path" select="/Analizar/field[@name='COMBO_ENTREGA']"/>
    	<xsl:with-param name="IDAct" select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>
    	<xsl:with-param name="cambio">calculaFecha('ENTREGA',this.options[this.selectedIndex].value);</xsl:with-param>
    	<xsl:with-param name="valorMinimo" select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>
    </xsl:call-template>
</xsl:template>
                

<!-- fin templates de la nueva version   -->
  
 
</xsl:stylesheet>
