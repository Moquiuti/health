<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
<xsl:template match="/">
<html>
  <head>
    <title>MedicalVM</title>
    <xsl:text disable-output-escaping="yes"><![CDATA[
    <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">	

    <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
    </script>
    <script language="javascript">
            <!--
            
            
            function pop(array){
              if(array.length>0)
                array.length=array.length-1;
              return array;
            }
            
            function push(array, elemento){
              array[array.length]=elemento;
              return array;
            }
            
            
            ]]></xsl:text>    
              var usuario=<xsl:value-of select="//US_ID"/>   
            <xsl:text disable-output-escaping="yes"><![CDATA[
            
            pila=new Array();	 
            textos=new Array();  
            
            arrayFamilias=new Array();
            arraySubfamilias=new Array();
            
            var ultimoTexto='';
            
            var categoria=-1;
            var familia=-1;
            var subfamilia=-1;
            
        
            function montarLista(array,lista){
              
              var textoCabecera;
              var seleccionado;
              
              if(lista,name=='LISTA1')
                seleccionado=0;
              else
                seleccionado=1; 
              
              if(lista.length>0) 
                lista.length=0;
                
                
              /*
                valores de:
                
                 'subir al nivel superior' = -2
                 'TODOS LOS PRODUCTOS'     = -1
              
              */  
                
              if(lista.name=='LISTA1'){//monto texto 'Subir al nivel superior'                                      
                textoCabecera=']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='NOM-0010' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
                addOption=new Option(textoCabecera,-1);
                var longitud=lista.length;
                lista.options[longitud]=addOption;
              }
              else{//monto texto 'TODOS LOS PRODUCTOS' y 'Subir al nivel superior'
                textoCabecera=']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='NOM-0010' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
                addOption=new Option(textoCabecera,-2);
                var longitud=lista.length;
                lista.options[longitud]=addOption;
                
                textoCabecera=']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='NOM-0020' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
                addOption=new Option(textoCabecera,-1);
                var longitud=lista.length;
                lista.options[longitud]=addOption;
              }
         
              //monto la lista
              for(var n=0;n<(array.length)/3;n++){
                addOption=new Option(extraerSubcadena(array[(n*3)+1],'(',')'),array[n*3]);
                if(lista.name=='LISTA1'){
                  if(array[n*3]==textos[textos.length-2]){
                    seleccionado=n+1;
                  }
                }
                longitud=lista.length;
                lista.options[longitud]=addOption;
              }
              
            //selecciono 'TODOS LOS PRODUCTOS'  
            if(lista.name=='LISTA2')
              lista.options[1].selected=true;
            else
              if(pila.length>0)              
                lista.options[seleccionado].selected=true;       
            }
            
            function extraerSubcadena(cadena,caracterInicio, caracterFin){
              var posInicio, posFin;
              for(var n=0; n<cadena.length;n++){
                var caracter=cadena.substring(n,n+1);
                if(caracter=='(')
                  posInicio=n;
                else
                  if(caracter==')')
                    posFin=n;
              }
              cadenaAux=cadena.substring(0,posInicio-1)+cadena.substring(posFin+1,cadena.length);
              return cadenaAux;
            }
 

            function copiarArray(arrayOrigen,arrayDestino){
              arrayDestino.length=0;
              for(var n=0;n<arrayOrigen.length;n++)
                  arrayDestino[n]=arrayOrigen[n]; 
            } 
            
 
            function guardarEstado(lista, array){
            
            	if(!isObject(lista)){
            		return;
            	}
            
                // nacho 8.8.2003
                // se hace una comprobacion del elemento seleccionado en la lista dos con datos anticuados
                // la vaciamos
                if(lista.name=='LISTA1'){
                  document.forms['form1'].elements['LISTA2'].length=0;
                }
                
                var indice=lista.selectedIndex;
                var indiceSecuencial=lista.options[indice].index;
                
                ultimoTexto='';
                
                
                if(pila.length>0){//pila mayor que 0  
                  if(esIExplorer()){
                    pila[pila.length-1]=parent.frameListas.form1.LISTA1.options[indice].value;
                    if(lista.options[indice].value!=-1){//no es el texto por defecto
                      if(pila[pila.length-1]!=-1){
                        //textos.pop();
                        //textos.pop();
                        textos=pop(textos);
                        textos=pop(textos);
                      }
                      //textos.push(lista.options[indice].value);
                      //textos.push(cortarCadena(array[((indiceSecuencial-1)*3)+1]));
                      textos=push(textos,lista.options[indice].value);
                      textos=push(textos, cortarCadena(array[((indiceSecuencial-1)*3)+1]));        
                    }
                    else{//es el texto por defecto 
                      subirNivel(parent.frames['frameListas'].form1.LISTA1,parent.frames['frameListas'].form1.LISTA2);       
                    }
                  }
                  else{//netscape
                    pila[pila.length-1]=parent.frameListas.document.form1.LISTA1.options[indice].value;
                    if(lista.options[indice].value!=-1){//no es texto por defecto
                      if(pila[pila.length-1]!=-1){
                        //textos.pop();
                        //textos.pop();
                        textos=pop(textos);
                        textos=pop(textos);
                      }
                      //textos.push(lista.options[indice].value);
                      //textos.push(cortarCadena(array[((indiceSecuencial-1)*3)+1]));
                      textos=push(textos,lista.options[indice].value);
                      textos=push(textos, cortarCadena(array[((indiceSecuencial-1)*3)+1]));
                    }
                    else{//texto por defecto
                      subirNivel(parent.frames['frameListas'].document.form1.LISTA1,parent.frames['frameListas'].document.form1.LISTA2);
                    }
                  }//fin netscape
                }//fin pila>0
                
                else{//pila=0
                  if(esIExplorer()){
                    pila[pila.length]=parent.frameListas.form1.LISTA1.options[indice].value;
                    if(lista.options[indice].value!=-1){//no es texto por defecto     
                      //textos.push(lista.options[indice].value);
                      //textos.push(cortarCadena(array[((indiceSecuencial-1)*3)+1]));
                      textos=push(textos, lista.options[indice].value);
                      textos=push(textos, cortarCadena(array[((indiceSecuencial-1)*3)+1]));
                    }
                  }
                  else{//netscape
                    pila[pila.length]=parent.frameListas.document.form1.LISTA1.options[indice].value;
                    if(lista.options[indice].value!=-1){//no es texto por defecto                    
                      //textos.push(lista.options[indice].value);
                      //textos.push(cortarCadena(array[((indiceSecuencial-1)*3)+1]));
                      textos=push(textos, lista.options[indice].value);
                      textos=push(textos, cortarCadena(array[((indiceSecuencial-1)*3)+1]));
                    }
                  }//fin netscape
                }//fin pila=0
                
              if(indice){
                if(navigator.appName.match('Microsoft')){
                  if(parent.frameListas.form1.LISTA1.options[indice].value!=-1){
                    parent.frameXML.location.href='NavegarNomenclatorSave.xsql?IDPadre='+pila[pila.length-1];                      
                  }               
                }
                else{
                  if(parent.frameListas.document.form1.LISTA1.options[indice].value!=-1)
                    parent.frameXML.location.href='NavegarNomenclatorSave.xsql?IDPadre='+pila[pila.length-1];
                }
              }              
              montarTextos();                                    
            }
            

            function remplazarListas(listaOrigen,listaDestino, array){
            
            if(!isObject(listaOrigen) || !isObject(listaDestino)){
            	return;
            }
            
            
              var indice=listaOrigen.selectedIndex;
              var indiceSecuencial=listaOrigen.options[indice].index;
              
              ultimoTexto='';
              
           //subir nivel
           if(listaOrigen.selectedIndex==0){
             if(esIExplorer()){
               subirNivel(parent.frames['frameListas'].form1.LISTA1,parent.frames['frameListas'].form1.LISTA2);
             }
             else{//netscape
               subirNivel(parent.frames['frameListas'].document.form1.LISTA1,parent.frames['frameListas'].document.form1.LISTA2);
             }
           }
           else{  
             //todos los productos seleccionados  
             if(listaOrigen.selectedIndex==1){
                if(esIExplorer()){
                  montarTextos();                
                }   
                else{//netscape
                  montarTextos();
                }
              }
              else{              
                for(var n=0;n<arraySubfamilias.length;n+=3){
                  if(listaOrigen.options[indice].value==arraySubfamilias[n]){
                    if(arraySubfamilias[n+2]==0){ //es una hoja   
                      ultimoTexto=' > '+cortarCadena(array[((indiceSecuencial-2)*3)+1]);
                    }
                    if(arraySubfamilias[n+2]!=0){//es un nodo    
                      pila[pila.length]=listaOrigen.options[indice].value;
                      copiarArray(arraySubfamilias, arrayFamilias);
                      montarLista(arrayFamilias,listaDestino);
                      listaDestino.options[indice-1].selected=true;
                      if(listaOrigen.options[indice].value!=-1){ 
                        //textos.push(listaDestino.options[indice-1].value);
                        //textos.push(cortarCadena(array[((indiceSecuencial-2)*3)+1])); 
                        textos=push(textos, listaDestino.options[indice-1].value);
                        textos=push(textos, cortarCadena(array[((indiceSecuencial-2)*3)+1]));       
                      }   
                      if(pila[pila.length-1]!=-1){
                        if(esIExplorer())
                          parent.frameXML.location.href='NavegarNomenclatorSave.xsql?IDPadre='+pila[pila.length-1];
                        else
                          parent.frameXML.location.href='NavegarNomenclatorSave.xsql?IDPadre='+pila[pila.length-1];
                      }
                    }
                  } 
                }//for
              }     
              montarTextos(); 
            }       
          } 
            
            //
            //
            //
            function cortarCadena(cad){
              for(var n=0;n<cad.length;n++){
                if(cad.charAt(n)=='['){
                  cad=cad.substring(0,n);
                }
              }
              return cad;    
            }
            
            function subirNivel(listaOrigen,listaDestino){
              
                var indice=listaOrigen.selectedIndex;
                
                ultimoTexto='';
  
                if(pila.length!=0){
                   //si hay algo en la pila
                  if(pila.length==1){
                    //si hay un elemento
                    listaDestino.length=0;
                    if(esIExplorer()){
                      parent.frameListas.form1.RUTA.value='';
                    }
                    else{
                      parent.frameListas.document.form1.RUTA.value='';
                    }
                    listaOrigen.options[0].selected=true;
                    pila.length=0;
                    textos.length=0;
                  } 
                  else{
                    //si longitud pila>1
                    copiarArray(arrayFamilias,arraySubfamilias);
                    montarLista(arraySubfamilias,listaDestino);
                    listaDestino.options[1].selected=true;
                    listaOrigen.length=0;
                    pila.length=pila.length-1;
                    //textos.pop();
                    //textos.pop(); 
                    textos=pop(textos);
                    textos=pop(textos);
                    var padre;
                    if(pila[pila.length-2])
                      padre=pila[pila.length-2];
                    else
                      padre='';
                    if(esIExplorer())
                      parent.frameXML.location.href='NavegarNomenclator.xsql?IDPadre='+padre;
                    else
                      parent.frameXML.location.href='NavegarNomenclator.xsql?IDPadre='+padre;
                  }
                montarTextos(); 
              } 
            }
              
            function verPila(){
              if(pila.length>0)
                for(var n=0;n<pila.length;n++)
                  alert(pila[n]);
            }
            
            function verTextos(){
              if(textos.length>0)
                for(var n=0;n<textos.length;n++)
                  alert(textos[n]);
            }
            
            function montarTextos(){
              
                if(pila.length==0){
                  categoria=-1;
                  familia=-1;
                  subfamilia=-1;
                }
                else{
                  if(pila.length==1){
                    categoria=pila[pila.length-1];
                    familia=-1;
                    subfamilia=-1
                  }
                  else{
                    if(pila.length==2){
                      familia=pila[pila.length-1];
                      subfamilia=-1
                    }
                    else{
                     subfamilia=pila[pila.length-1];
                    }
                  }
                }
                
                var cad='';    
                         
                if(textos.length>0){
                  for(var n=1;n<=textos.length;n+=2)
                    if(n!=textos.length-1)
                      cad+=extraerSubcadena(textos[n],'(',')')+' > ';
                    else
                      if(ultimoTexto=='' && (usuario==1 ||usuario==5))
                        cad+=textos[n];
                      else
                        cad+=extraerSubcadena(textos[n],'(',')');
                  if(usuario==1 || usuario==5)
                    cad+=ultimoTexto;
                  else
                    cad+=extraerSubcadena(ultimoTexto,'(',')');
                } 
                  if(esIExplorer()){
                    /*if(cad.length>parent.frames['frameListas'].form1.RUTA.size)
                      cad=cad.substring((parseInt(cad.length)-5)-parseInt(parent.frames['frameListas'].form1.RUTA.size),cad.length);*/
                    parent.frames['frameListas'].form1.RUTA.value=cad;
                  }
                  else{//navigator
                    /*if(cad.length>65){
                      cad=cad.substring((parseInt(cad.length)-5)-80,cad.length); 
                    }*/
                    parent.frames['frameListas'].document.form1.RUTA.value=cad;
                  }                    
            }
            
            function alineaTexto(obj,alineacion){
              if(esIExplorer())
                obj.style.textAlign=alineacion;
            }
            
            
            
            //-------------------------------------------------
            
        function Submit(form){
        
          if(esIExplorer()){
            
            if(document.form1.LISTA2.selectedIndex!=-1){         
              if(document.form1.LISTA2.options.value!=-1){
                subfamilia=document.form1.LISTA2.options.value;
              }
            }
          }
          else{
            if(parent.frames['frameListas'].document.form1.LISTA2.selectedIndex!=-1){      
              if(parent.frames['frameListas'].document.form1.LISTA2.options[parent.frames['frameListas'].document.form1.LISTA2.options.selectedIndex].value!=-1){ 
                subfamilia=parent.frames['frameListas'].document.form1.LISTA2.options[parent.frames['frameListas'].document.form1.LISTA2.options.selectedIndex].value;
              }
            }
          }
          
          
          form.LLP_CATEGORIA.value=categoria;
          form.LLP_FAMILIA.value=familia;
          form.LLP_SUBFAMILIA.value=subfamilia; 
          
          form.action='../Compras/Multioferta/ListaProductos.xsql';
          SubmitForm(form);
	}
        
        //
        //
	function Actualizar() {
	  var formu = window.document.forms['BuscaProductos'];
	    ]]></xsl:text>
	    <xsl:if test="BusquedaProductos/BuscForm/ROWSET/ROW/LLP_CATEGORIA[.!='-1']">
	      seleccionarCombo(formu.elements['LLP_CATEGORIA'],'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/LLP_CATEGORIA"/>');
	      refillFamilias(formu,'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/LLP_CATEGORIA"/>'); 	      
	    </xsl:if>
	    <xsl:if test="BusquedaProductos/BuscForm/ROWSET/ROW/LLP_FAMILIA[.!='-1']">
	      seleccionarCombo(formu.elements['LLP_FAMILIA'],'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/LLP_FAMILIA"/>');
	      refillSubfamilias(formu,'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/LLP_FAMILIA"/>',0);
	    </xsl:if>

	    <xsl:if test="BusquedaProductos/BuscForm/ROWSET/ROW/LLP_SUBFAMILIA[.!='-1']">
	      seleccionarCombo(formu.elements['LLP_SUBFAMILIA'],'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/LLP_SUBFAMILIA"/>');
	    </xsl:if>
	    <xsl:text disable-output-escaping="yes"><![CDATA[
	}
	
	function Actua(formu){
	  
	  SetCookie('LLPManten', categoria+':'+familia+':'+subfamilia);	
	 
	  if (document.forms[0].LLP_PRESENTACION_CHECKBOX.checked==false){  
	    document.forms[0].LLP_PRESENTACION.value='LIN';
	  }else{
	    document.forms[0].LLP_PRESENTACION.value='AMP';	  
	  }
	  uneCampos(formu.elements['TIPOS_CERTIFICACIONES'].value,formu.elements['LLP_VALOR_CERTIFICACION'].value,formu.elements['LLP_CERTIFICACION'].value);	  
	  Submit(formu);
	}
	
	function Load(){
	  if(is_nav==false || navigator.appVersion>5){
	    if(GetCookie('LLPManten')!=null){
	      array=GetCookie('LLPManten').split(":");
	      categoria=array[0];
	      familia=array[1];
	      subfamilia=array[2];
	      if(document.forms[0].elements['LLP_CATEGORIA'].options[document.forms[0].elements['LLP_CATEGORIA'].selectedIndex].value!='-1' && categoria!=""){
	        document.forms[0].elements['LLP_CATEGORIA'].value=categoria;
	        refillFamilias(document.forms[0],categoria);	      
	        if(familia!=""){
	          document.forms[0].elements['LLP_FAMILIA'].value=familia;
	          refillSubfamilias(document.forms[0],familia,subfamilia);
	        }
	      }
	    }
	  }
	}
		
	function uneCampos(campo1,campo2,campoTotal){
	  if (campo1!="SIN") {
	    document.forms['BuscaProductos'].elements['LLP_CERTIFICACION'].value=campo1+'-'+campo2;
	  }
	}
	
	//
	//
	//
	//
	function SelContrario(casilla){
	  if (casilla=='LLP_PROV_HABITUALES'){
	    if (document.forms['BuscaProductos'].elements['LLP_PROV_HABITUALES'].checked==true) {
	      document.forms['BuscaProductos'].elements['LLP_PROV_HABITUALES_NEGADO'].checked=false;
	    }else {
	      document.forms['BuscaProductos'].elements['LLP_PROV_HABITUALES_NEGADO'].checked=true;
	    }
	  }else{
	    if (document.forms['BuscaProductos'].elements['LLP_PROV_HABITUALES_NEGADO'].checked==true) {
	      document.forms['BuscaProductos'].elements['LLP_PROV_HABITUALES'].checked=false;
	    }else {
	      document.forms['BuscaProductos'].elements['LLP_PROV_HABITUALES'].checked=true;	  
	    }
	  }
	}
	
	   //
	   //
	   //
           function ValidaUnSoloNumero(nota){
	        // ENSURE CHARACTER IS A DIGIT	     
	      numero = nota.value;
	      if (numero!=""){
	        if (numero < "0" || numero > "9") {
	          alert('Introduczca un valor númerico correcto');
	          nota.focus();
	          return (false);
	        } 
	        else{
	          return (true);
	        }
	      }
           }
           
           //
           // Cuando se busca por empresas, se desactiva el campo de ORDEN.
           function ActivarDesactivar(){
             objeto=document.forms['BuscaProductos'].elements['LLP_ORDERBY'];objeto.disabled=false;
             //alert(document.forms['BuscaProductos'].elements['LLP_LISTAR'].selectedIndex);
             //if (document.forms['BuscaProductos'].elements['LLP_LISTAR'].value=="-1") document.forms['BuscaProductos'].elements['LLP_LISTAR'].value="PRO";          
             for (i=0;i<document.forms['BuscaProductos'].elements.length;i++){
               if ((document.forms['BuscaProductos'].elements[i].name=="LLP_LISTAR")){
                 if (document.forms['BuscaProductos'].elements[i].checked){
	           if (document.forms['BuscaProductos'].elements[i].value=='PRO'){
	             objeto.disabled=false;
	           }else{
	             objeto.disabled=true;
	           }
	           break;
	         }
               }
             }             
           } 
           
           //
           //
           function mostrarDatos(){
             alert('categoria: '+categoria+'\nfamilia: '+familia+'\nsubfamilia'+subfamilia);
           }
           
            
            //-------------------------------------------------
            
           function esIExplorer(){
             if(navigator.appName.match('Microsoft'))
               return true;
             else
               return false;
           }
           
           function handleKeyPress(e) {
	
	  var keyASCII;
	  
	  if(navigator.appName.match('Microsoft'))
	    var keyASCII=event.keyCode;
	  else
            keyASCII = (e.which);
            
          if (keyASCII == 13)
            Actua(document.forms['BuscaProductos']);                  
        }
        
        function borrarDatosRuta(){
          if(navigator.appName.match('Microsoft'))
            parent.frameListas.form1.RUTA.value='';
          else
            parent.frameListas.document.form1.RUTA.value='';
          
        }
	
	if(navigator.appName.match('Microsoft')==false)
	  document.captureEvents();
	document.onkeypress = handleKeyPress;
                 
       var LaHistoria=0;

function historico(){
  LaHistoria++;
}

function VolverBusquedaHistoria(){
           history.go(-LaHistoria);
}
            
            
      //-->
    </script>
    
    ]]></xsl:text>
  </head>
  <body class="blanco" onLoad="borrarDatosRuta();parent.frameXML.location.href='NavegarNomenclator.xsql';"> 
  <table width="100%" cellpadding="0" cellspacing="0" border="0">
      <tr align="center">       
      <td width="70%" align="center">	
        <p class="tituloPag">        	           
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0100' and @lang=$lang]" disable-output-escaping="yes"/>	        
        </p>
      </td>        
      <td>   
	<!--<xsl:apply-templates select="//button[@label='Buscar']"/>-->
          <xsl:call-template name="boton">
            <xsl:with-param name="path" select="//button[@label='Buscar']"/>
          </xsl:call-template>
      </td>	     
      </tr>
    </table>
    <br/>
    <table width="100%" border="0">
      <tr>
        <td>
          <xsl:apply-templates select="BusquedaProductos/BuscForm"/>
          <xsl:call-template name="Nomenclator"/>
        </td>
      </tr>
    </table>
    <table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
            <tr>       
              <td align="center">
                <!--<xsl:apply-templates select="//jumpTo[@name='anterior']"/> -->
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="//button[@label='Volver']"/>
                </xsl:call-template>
              </td>       
              <td align="center">   
          <xsl:call-template name="boton">
            <xsl:with-param name="path" select="//button[@label='Buscar']"/>
          </xsl:call-template> 
              </td>	     
            </tr>
          </table>
          <br/>
  </body>
</html>
</xsl:template>

<xsl:template name="Nomenclator">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro">
    <tr class="oscuro"> 
      <td colspan="5">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0402' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
    </tr> 
    <tr class="blanco">
      <td>
        <table width="100%" border="0">    
          <tr>
            <td colspan="3" align="center" valign="top" >
          <xsl:call-template name="boton">
            <xsl:with-param name="path" select="//button[@label='CatalogoProductos']"/>
          </xsl:call-template>
          <br/><br/>
        </td>
      </tr>
      <form name="form1">
      <tr>
        <td class="tituloCamp" align="right">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='NOM-0030' and @lang=$lang]" disable-output-escaping="yes"/>
        </td>
        <td colspan="2">
          <!--<input type="text" class="javascript:if(navigator.appName.match('Microsoft')) inputInvisible else inputInvisibleNets" value=""  name="RUTA" size="65" onFocus="this.blur();"/>-->
          
          
          <textarea class="javascript:if(navigator.appName.match('microsoft')) inputInvisible else inputInvisibleNets" value="" name="RUTA" rows="3" cols="65" onFocus="this.blur();"/>
          <!--<input type="text" class="javascript:if(navigator.appName.match('microsoft')) inputInvisible else inputInvisibleNets" value="" name="RUTA" size="65" onFocus="this.blur();"/>-->
          
        </td>
      </tr>
      <tr>
        <td class="tituloCamp" align="right">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='NOM-0040' and @lang=$lang]" disable-output-escaping="yes"/>
        </td>
        <td rowspan="2">
          <select name="LISTA1" size="8" maxlength="65" onChange="guardarEstado(this, arrayFamilias);" >
            <option value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;</option>
          </select>
        </td>
        <td rowspan="2" align="right" valign="middle">
          <xsl:call-template name="boton">
            <xsl:with-param name="path" select="//button[@label='Buscar']"/>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td align="right" valign="top">
          <!--<xsl:apply-templates select="//button_Extended[@label='Subir']"/>-->
          <xsl:call-template name="boton">
            <xsl:with-param name="path" select="//button_Extended[@label='Subir']"/>
            <xsl:with-param name="ancho">0px</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td class="tituloCamp" align="right">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='NOM-0050' and @lang=$lang]" disable-output-escaping="yes"/>
        </td>
        <td rowspan="2" colspan="3">
          <select name="LISTA2" size="8" maxlength="55" onChange="if(esIExplorer()) remplazarListas(this,parent.frames['frameListas'].form1.LISTA1, arraySubfamilias); else remplazarListas(this,parent.frames['frameListas'].document.form1.LISTA1, arraySubfamilias);">
            <option value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              &nbsp;</option>
          </select>
          <br/>
        
        <!--<input type="button" name="aa" value="ver pila" onClick="verPila();"/>
        <input type="button" name="bb" value="ver textos" onClick="verTextos();"/>
        <input type="button" name="cc" value="ver variables" onClick="alert('categoria: '+categoria+' familia: '+familia+' subfamilia: '+subfamilia);"/>
       -->
      
        </td>
      </tr>
      <tr>
        <td align="right" valign="top">
          <!--<xsl:apply-templates select="//button_Extended[@label='Subir']"/>-->
          <xsl:call-template name="boton">
            <xsl:with-param name="path" select="//button_Extended[@label='Subir']"/>
            <xsl:with-param name="ancho">0px</xsl:with-param>
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td>
          &nbsp;
        </td>
        <td>
          &nbsp;
        </td>
        <td>
          &nbsp;
        </td>
      </tr>
      </form>
    </table>
  </td>
  </tr>
  </table>

</xsl:template>


<xsl:template match="jumpTo | JUMPTO_OK | JUMPTO_DATAERROR | JUMPTO_DBERROR | JUMPTO_XSQLERROR">
    <xsl:variable name="code-img-on">DB-<xsl:value-of select="picture-on"/></xsl:variable>
    <xsl:variable name="code-img-off">DB-<xsl:value-of select="picture-off"/></xsl:variable> 
    <xsl:variable name="code-link"><xsl:value-of select="page"/></xsl:variable>   
    <xsl:variable name="code-text"><xsl:value-of select="text"/></xsl:variable>  
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>    
    <xsl:variable name="link"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-link]" disable-output-escaping="yes"/></xsl:variable>    
    <xsl:variable name="texto"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-text]" disable-output-escaping="yes"/></xsl:variable>    
    <xsl:variable name="code-status"><xsl:value-of select="status"/></xsl:variable>
    <xsl:variable name="status">
      <xsl:choose>
        <xsl:when test="status">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="code-alt"><xsl:value-of select="alt"/></xsl:variable>
    <xsl:variable name="alt">
      <xsl:choose>
        <xsl:when test="alt">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>        
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="picture-off">  
	  <a>
	    <xsl:attribute name="href"><xsl:value-of select="$link"/><xsl:value-of select="//LLP_IDLISTA"/></xsl:attribute>
	    <xsl:attribute name="onMouseOver">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-on"/>');window.status='<xsl:value-of select="$status"/>';return true</xsl:attribute>
	    <xsl:attribute name="onMouseOut">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
	    <xsl:choose>
	    <!-- Imagen dinamica. Efecto encendido/apagado -->
            <xsl:when test="picture-on">
	      <img name="{picture-off}" alt="{$alt}" src="{$draw-off}" border="0"/>
            </xsl:when>	                
            <xsl:otherwise>
            <!-- Imagen estatica -->
	      <img name="{picture-off}" alt="{$alt}" src="{$draw-off}" border="0"/>
            </xsl:otherwise> 
            </xsl:choose>     
          </a>
          <br/>
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>        
      </xsl:when> 
      <!-- Link sin imagen -->
      <xsl:otherwise>
        <a>
          <xsl:attribute name="href"><xsl:value-of select="$link"/><xsl:value-of select="//LLP_IDLISTA"/></xsl:attribute>      
          <xsl:value-of select="name"/>
        </a>        
      </xsl:otherwise>      
    </xsl:choose>        
  </xsl:template>




<xsl:template match="BuscForm">
  <form>
    <xsl:attribute name="name">
      <xsl:value-of select="@name"/>
    </xsl:attribute>

    <xsl:attribute name="method">
      <xsl:value-of select="@method"/>
    </xsl:attribute>
    
    <xsl:attribute name="action">
      <xsl:value-of select="@action"/>
    </xsl:attribute>
    
    <!-- Para construir la certificacion -->
    <input type="hidden" name="LLP_CERTIFICACION" value="{LLP_CERTIFICACION}"/>        
    <!-- Operación con la linea: ALTA | EDICION -->
    <input type="hidden" name="OPERACION" value="{../OP}"/>
    <!-- ET 24/4/2002: Cambiamos el xsql para que llame a Oracle en lugar de crear la consulta
    <input type="hidden" name="LLP_ID" value="{ROWSET/ROW/LLP_ID}"/>          
    <input type="hidden" name="LP_ID" value="{ROWSET/ROW/LLP_IDLISTA}"/>  -->  
    <input type="hidden" name="LLP_ID" value="{BUSQUEDA/LLP_ID}"/>          
    <input type="hidden" name="LP_ID" value="{BUSQUEDA/LLP_IDLISTA}"/>
    <!-- Presentación: LIN | AMP -->
    <input type="hidden" name="LLP_PRESENTACION"/> 
    
    <input type="hidden" name="LLP_CATEGORIA"/>
    <input type="hidden" name="LLP_FAMILIA"/>
    <input type="hidden" name="LLP_SUBFAMILIA"/>
         
    <!-- ET 24/4/2002: Cambiamos el xsql para que llame a Oracle en lugar de crear la consulta
	<xsl:apply-templates select="ROWSET/ROW"/>-->
    <xsl:apply-templates select="BUSQUEDA"/>
  </form>
</xsl:template>

<!-- ET 24/4/2002: Cambiamos el xsql para que llame a Oracle en lugar de crear la consulta
<xsl:template match="ROW">-->
<xsl:template match="BUSQUEDA">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="muyoscuro">       
    <tr class="oscuro"> 
      <td colspan="5">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0403' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
    </tr>
    <tr class="blanco"> 
      <td width="15%" class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0150' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td>  
	<xsl:apply-templates select="LLP_NOMBRE"/>
      </td>
      <td class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0190' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td>  
	<xsl:apply-templates select="LLP_PROVEEDOR"/>
      </td>                            
    </tr>
    <tr class="blanco">   
      <td class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0180' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td>  
	<xsl:apply-templates select="LLP_MARCA"/>
      </td>
      <td class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0170' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
	<xsl:apply-templates select="LLP_FABRICANTE"/>
      </td>
    </tr> 
    <tr class="blanco"> 
      <td colspan="4">&nbsp;</td>
    </tr>
    
    <tr class="blanco">   
      <td class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0390' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td>
	<xsl:apply-templates select="LLP_REFERENCIA_PROVEEDOR"/></td>
      <td class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0400' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td>
	<xsl:apply-templates select="LLP_REFERENCIA_CLIENTE"/></td>	
      </tr>	
    <tr class="blanco">   
      <td class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0135' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td colspan="3">
        <xsl:variable name="IDAct"><xsl:value-of select="LLP_IDESPECIALIDAD_ACTUAL"/></xsl:variable>
	<xsl:apply-templates select="/BusquedaProductos/field[@name='LLP_ESPECIALIDADES']"/></td>	
      </tr>	

    <tr class="blanco"> 
      <td colspan="4" align="right" valign="middle" height="35px">
      <xsl:call-template name="boton">
        <xsl:with-param name="path" select="//button[@label='Buscar']"/>
      </xsl:call-template>
      </td>
    </tr>
    
    <!-- Opciones de la busqueda -->
    <tr class="oscuro">
      <td colspan="5">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0400' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
    </tr>         
    <tr class="blanco"> 
      <td class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0410' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
        <input type="radio" name="LLP_LISTAR" value="PRO">
          <xsl:attribute name="OnClick">ActivarDesactivar();</xsl:attribute>
          <xsl:choose>
            <xsl:when test="LLP_LISTAR_ACTUAL[.='PRO'] or LLP_LISTAR_ACTUAL[.='']">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:when>
          </xsl:choose>                
        </input>
  
      Producto<!--<img src="http://www.newco.dev.br/images/Producto.gif" border="0"/>-->
      <input type="radio" name="LLP_LISTAR" value="EMP">
        <xsl:attribute name="OnClick">ActivarDesactivar();</xsl:attribute>
          <xsl:choose>
            <xsl:when test="LLP_LISTAR_ACTUAL[.='EMP']">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:when>
          </xsl:choose>               
        </input>
        Proveedor<!--<img src="http://www.newco.dev.br/images/Proveedor.gif" border="0"/>-->
      </td>
      <td colspan="2" class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0200' and @lang=$lang]" disable-output-escaping="yes"/>:&nbsp;
        <input type="checkbox" name="LLP_PRESENTACION_CHECKBOX">
         <xsl:choose>                 
          <xsl:when test="LLP_PRESENTACION_ACTUAL[.='AMP']">
           <xsl:attribute name="checked">checked</xsl:attribute>           
          </xsl:when>
         </xsl:choose>         
        </input>
	</td>
    </tr>        
    <tr class="blanco">     
      <td class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0390' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td colspan="3" >
        <xsl:variable name="IDAct">
          <xsl:value-of select="LLP_ORDERBY_ACTUAL"/>
        </xsl:variable>
        <xsl:apply-templates select="../field[@name='LLP_ORDERBY']"/>      
      </td>
    </tr>               	
    <tr class="blanco"> 
      <td colspan="4">&nbsp;</td>
    </tr>             
    <tr class="blanco">
     <td colspan="2" class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0195' and @lang=$lang]" disable-output-escaping="yes"/>:&nbsp;
        <xsl:apply-templates select="LLP_PROV_HABITUALES"/> Todos
        <input type="checkbox" name="LLP_PROV_HABITUALES_NEGADO" OnClick="SelContrario('LLP_PROV_HABITUALES_NEGADO');">
         <xsl:choose>
          <xsl:when test="LLP_PROV_HABITUALES[.!='S']">
           <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:when>
         </xsl:choose>
        </input>
	
     </td>     
      <td colspan="2" class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0220' and @lang=$lang]" disable-output-escaping="yes"/>:&nbsp;
                     <input name="LLP_NIVEL_CALIDAD" size="1" maxlength="1" onChange="ValidaUnSoloNumero(this)">
                      <xsl:attribute name="value">
                        <xsl:choose>
                          <xsl:when test="LLP_NIVEL_CALIDAD_ACTUAL[.=-1]">
                          </xsl:when>                      	
                          <xsl:otherwise>
                      	    <xsl:value-of select="LLP_NIVEL_CALIDAD_ACTUAL"/>
                          </xsl:otherwise>                          
                        </xsl:choose>                      	
                      </xsl:attribute>
                    </input>
      </td>
    </tr>
    <tr class="blanco"> 
      <td colspan="4">&nbsp;</td>
    </tr>	
    <tr class="blanco">     
      <td class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0380' and @lang=$lang]" disable-output-escaping="yes"/>
        </td>
      <td width="35%">  
        <xsl:variable name="IDAct" select="LLP_TIPO_PRODUCTO_ACTUAL"/>
	<xsl:apply-templates select="../field[@name='LLP_TIPO_PRODUCTO']"/>
      </td>      
     <td width="15%" class="claro">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0210' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td width="35%">
        <xsl:variable name="IDAct" select="LLP_TIPO_CERTIFICACION"/>
	<xsl:apply-templates select="../field[@name='TIPOS_CERTIFICACIONES']"/>-<xsl:apply-templates select="LLP_VALOR_CERTIFICACION"/>
      </td>
    </tr>                 	            	
  </table>    	  
</xsl:template>

<xsl:template match="LLP_DESCRIPCION_LINEA">
 <input type="text" SIZE="50" name="LLP_DESCRIPCION_LINEA">
 <xsl:attribute name="value">
  <xsl:value-of select="."/>
 </xsl:attribute>
 </input>
</xsl:template>

<xsl:template match="LLP_NOMBRE">
 <input type="text" size="20" name="LLP_NOMBRE">
 <xsl:attribute name="value">
  <xsl:value-of select="."/>
 </xsl:attribute>
 </input>
</xsl:template>

<!--
<xsl:template match="LLP_DESCRIPCION">
 <input type="text" SIZE="71" name="LLP_DESCRIPCION">
 <xsl:attribute name="value">
  <xsl:value-of select="."/>
 </xsl:attribute>
 </input>
</xsl:template>
-->

<xsl:template match="LLP_FABRICANTE">
 <input type="text" size="20" name="LLP_FABRICANTE"  value="{.}"/>
</xsl:template>

<xsl:template match="LLP_MARCA">
 <input type="text" size="20" name="LLP_MARCA" value="{.}"/>
</xsl:template>

<xsl:template match="LLP_PROVEEDOR">
 <input type="text" size="20" name="LLP_PROVEEDOR" value="{.}"/>
</xsl:template>

<xsl:template match="LLP_REFERENCIA_PROVEEDOR">
 <input type="text" size="20" name="LLP_REFERENCIA_PROVEEDOR" value="{.}"/>
</xsl:template>

<xsl:template match="LLP_REFERENCIA_CLIENTE">
 <input type="text" size="20" name="LLP_REFERENCIA_CLIENTE" value="{.}"/>
</xsl:template>

<xsl:template match="LLP_PROV_HABITUALES">
  <input type="checkbox" name="LLP_PROV_HABITUALES">
  <xsl:attribute name="OnClick">SelContrario('LLP_PROV_HABITUALES');</xsl:attribute>
  <xsl:choose>
    <xsl:when test=".='S'">
      <xsl:attribute name="checked">checked</xsl:attribute>
    </xsl:when>
    
  </xsl:choose>      
  </input>
</xsl:template>

<xsl:template match="LLP_VALOR_CERTIFICACION">
  <input type="text" name="LLP_VALOR_CERTIFICACION" size="10" value="{.}"/>
</xsl:template>

<xsl:template match="button_Extended">
    <xsl:variable name="code-img-on">DB-<xsl:value-of select="@label"/>_mov</xsl:variable>
    <xsl:variable name="code-img-off">DB-<xsl:value-of select="@label"/></xsl:variable>    
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>
    
    <!-- Status Line -->
    <xsl:variable name="code-status"><xsl:value-of select="@status"/></xsl:variable>
    <xsl:variable name="status">
      <xsl:choose>
        <xsl:when test="@status">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <!-- Texto alternativo -->
    <xsl:variable name="code-alt"><xsl:value-of select="@alt"/></xsl:variable>
    <xsl:variable name="alt">
      <xsl:choose>
        <xsl:when test="@alt">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>        
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
	  <a>
	    <xsl:attribute name="onMouseOver">cambiaImagen('<xsl:value-of select="@label"/>','<xsl:value-of select="$draw-on"/>');window.status='<xsl:value-of select="$status"/>';return true</xsl:attribute>
	    <xsl:attribute name="onMouseOut">cambiaImagen('<xsl:value-of select="@label"/>','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
	      <!--
	       |   Construimos la llamada a la función por este orden:
	       |    1.- Copiamos los parametros <param>, de forma literal.
	       |    2.- Copiamos los parametros <param_msg>, previa consulta en el fichero de mensajes.
	       +-->
	       
	      <xsl:attribute name="href">javascript:<xsl:value-of select="name_function"/></xsl:attribute>	  
	    <img name="{@label}" src="{$draw-off}" border="0" alt="{$alt}"/>    
          </a>
          
          <!-- Texto debajo del boton -->
          <xsl:if test="@caption">
            <br/>
            <xsl:variable name="caption"><xsl:value-of select="@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
          </xsl:if>
          
  </xsl:template>
  
</xsl:stylesheet>