<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
    Mantenimiento de Carpetas y Plantillas por Usuario
 	Ultima revisión: ET 18nov19 14:50
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html> 
      <head> 
      
		<!--idioma-->
		<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->
      
		<title>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_de_carpetas_y_plantillas']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='medicalvm']/node()"/>
		</title>

       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  	
   	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    
      
	<xsl:text disable-output-escaping="yes"><![CDATA[

        <SCRIPT type="text/javascript">
        <!-- 
        
        var msgMaximoBotones='Ha seleccionado un número de botones superior al permitido para mostrar en su menú principal. El máximo es 5';
        var msgMinimoBotones='No ha seleccionado ningún botón para el menú principal. Debe seleccionar al menos uno.';




        /*
          
            creo un array bidimensional en la primera posicion de cada registro guardo el id de la carpeta 
            y despues el id de todos las plantillas de esta carpeta
            
                0 [idCarpeta],[idPlantilla],[idPlantilla],[idPlantilla]
                1 [idCarpeta],[idPlantilla]
                2 [idCarpeta],[idPlantilla],[idPlantilla]
                ...
           */
           
           
           ]]></xsl:text>
          
          arrayPlantillas=new Array(<xsl:value-of select="count(/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/CARPETA)"/>);

          <xsl:for-each select="/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/CARPETA">
            var i='<xsl:value-of select="position()-1"/>';
            arrayPlantillas[parseInt(i)]=new Array(<xsl:value-of select="count(PLANTILLA)+1"/>);
            arrayPlantillas[i][0]=<xsl:value-of select="ID"/>;
            <xsl:for-each select="PLANTILLA">
              var j='<xsl:value-of select="position()"/>';
              arrayPlantillas[i][j]=<xsl:value-of select="ID"/>;
            </xsl:for-each>
            
          </xsl:for-each>   
            
        
    <xsl:text disable-output-escaping="yes"><![CDATA[      
        
        /*
           recorro todos las carpetas y todas las plantillas, 
           para cada carpeta si TODOS las plantillas tienen permisos guardo
           en un hidden <ACCION>_TODOS_<ID> el valor true, esto es para cuando se pulse el link "Todas"
           saber que accion tiene que realizar dar o quitar privilegios
        */
        
      function inicializarDerechosPorPlantilla(form){
          for(i=0;i<arrayPlantillas.length;i++){
            var tienePermisosLect=1;
            var tienePermisosEscr=1;
            for(j=1;j<arrayPlantillas[i].length;j++){
              if(form.elements['LECT_'+arrayPlantillas[i][j]].checked==false)
                tienePermisosLect=0;
              if(form.elements['ESCR_'+arrayPlantillas[i][j]].checked==false)
                tienePermisosEscr=0;   
            }
              form.elements['LECT_TODOS_'+arrayPlantillas[i][0]].value=tienePermisosLect;
              form.elements['ESCR_TODOS_'+arrayPlantillas[i][0]].value=tienePermisosEscr;
          }
      }
        
        
        /*
        
          si es un check de plantilla recibe la acion LECT / ESCR, el ID de la plantilla, y a quien afecta 'ESTE'   
          si es un check de carpeta recibe la acion LECT / ESCR, el ID de la carpeta, y a quien afecta 'CARPETA'
              afecta a la carpeta y a las plantillas que contiene
              actualizamos el valor de la siguiente accion a realizar con el valor del check
          
          si es un link (Todas) recibe la accion LECT / ESCR, el ID de la carpeta, y a quien afecta 'TODOS'
             afecta solo a las plantillas no a las carpetas
             el valor de la siguiente accion a realizar se va alternando ==> dar / quitar
          
        
        */
        
        function validacionEscrituraLectura(accion,id,tipo,form){
        
          // ESTE 
          if(tipo=='ESTE'){
            if(accion=='LECT'){
              if(form.elements[accion+'_'+id].checked==false){
                //if(form.elements['ESCR_'+id].disabled==false){
                  form.elements['ESCR_'+id].checked=false;
                //}
              }
            }
            else{
              if(form.elements[accion+'_'+id].checked==true){
                if(form.elements['LECT_'+id].disabled==false){
                  form.elements['LECT_'+id].checked=true;
                }
              } 
            }
          }
          else{
            if(tipo=='TODOS' || tipo=='CARPETA'){
              /*  
              afecta a TODOS / CARPETA 
             
               la primera parte de este bloque es comun
               en la segunda, guardar la siguiente accion a realizar, diferenciamos
               entre los casos
             
              */ 
              var posicionDeLaCarpeta=0;
              
              /*
                obtengo la posicion de la carpeta en el array
              */
              
              for(var n=0;n<arrayPlantillas.length;n++){
                if(arrayPlantillas[n][0]==id){
                  posicionDeLaCarpeta=n;
                }
              }
              
              
               /*
                solo tipo='CARPETAS' 
                
                si es un check de carpeta, actualizamos la accion a realizar con el valor que queremos realizar ahora, 
                mas adelante, antes de salir de la funcion actualizamos con la accion a realizar la siguiente 
                vez que entremos en la funcion.
                
              */
              
              /*if(tipo=='CARPETA'){
                if(form.elements[accion+'_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked==true){
                  form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0;
                  if(accion=='LECT'){
                  	alert('mi');
                    form.elements['ESCR_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0; 
                  }
                }
                else{
                  form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;
                  if(accion=='ESCR'){
                  alert('maaaa');
                    form.elements['LECT_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;         
                  }
                }
              }*/
              
              
              
              /*
                para todas las plantillas
              
              */
              if(tipo=='TODOS'){
                for(var i=1;i<arrayPlantillas[posicionDeLaCarpeta].length;i++){
                  if(form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value==1){
                    if(form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].disabled==false){
                      form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked=false;
                    }
                  }
                  else{
                    if(form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].disabled==false){
                      form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked=true;
                      //if(form.elements['LECT_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked==false && form.elements[accion+'_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].disabled==false){
                      //  form.elements['LECT_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked=true;
                      //}
                    }
                  }
               
               /*
                  miramos que no haya conflictos con los derechos lectura / escritura
                     si no puede leer tampoco puede escribir
                     si puede escribir puede leer
               */   
               
                  if(accion=='LECT' && form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked==false){
                    //if(form.elements['ESCR_'+arrayPlantillas[posicionDeLaCarpeta][i]].disabled==false)
                      form.elements['ESCR_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked=false;
                  }
                  else{
                    if(accion=='ESCR' && form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked==true){
                      if(form.elements['LECT_'+arrayPlantillas[posicionDeLaCarpeta][i]].disabled==false)
                        form.elements['LECT_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked=true;
                      //form.elements['LECT_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked=true;
                    }
                  }
                }
              }
            
              if(tipo=='CARPETA'){
                if(accion=='LECT'){
                  if(form.elements[accion+'_TODOS_CHK_'+id].checked==false){
                    //if(form.elements['ESCR_TODOS_CHK_'+id].disabled==false)
                      form.elements['ESCR_TODOS_CHK_'+id].checked=false;
                  }
                }
                else{
                  if(form.elements[accion+'_TODOS_CHK_'+id].checked==true){
                    if(form.elements['LECT_TODOS_CHK_'+id].disabled==false)
                      form.elements['LECT_TODOS_CHK_'+id].checked=true;
                  } 
                }
              }
            
            
              /*
                  guardamos la siguiente accion a realizar al pulsar el link "Todos" o Check CARPETA
                         dar / quitar alternativamente      
              */
            
            
            
            
              if(tipo=='TODOS'){
                if(form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value==1){
                  form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0;
                  if(accion=='LECT')
                    form.elements['ESCR_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0; 
                }
                else{
                  form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;
                  if(accion=='ESCR')
                    form.elements['LECT_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;         
                }
              }
             /* else{
                if(form.elements[accion+'_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked==false){
                  form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0;
                  if(accion=='LECT')
                    form.elements['ESCR_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0; 
                }
                else{
                  form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;
                  if(accion=='ESCR')
                    form.elements['LECT_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;         
                }
              }*/
            }
            else{
            
              /*
                carpetas y plantillas
              */
              
             
             /*
               obtenemos la accion a realizar ahora. recorremos todos los check
               si alguno esta desactivado la accion es dar derechos. Si todos estan activados
               la accion es quitar derechos
             */
             
             var accionARealizar
             
             if(form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value==''){
               form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value=obtenerAccionARealizar(accion,form);
             }
             
             accionARealizar=form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value;
             
             for(var n=0;n<form.length;n++){
               if(form.elements[n].type=='checkbox'){
                 if(form.elements[n].name.substring(0,4)==accion){
                   if(accionARealizar==0){
                     if(form.elements[n].disabled==false){
                       form.elements[n].checked=false;
                       if(accion=='LECT'){
                         form.elements['ESCR'+form.elements[n].name.substring(4,form.elements[n].name.length)].checked=false;
                       }
                     }
                       
                   }
                   else{
                     if(form.elements[n].disabled==false){
                       form.elements[n].checked=true;
                       if(accion=='ESCR'){
                         form.elements['LECT'+form.elements[n].name.substring(4,form.elements[n].name.length)].checked=true;
                       }
                     }
                   }
                 }
               }
             }

                 /* 
                 
                 asignamos la siguiente accion a realizar a nivel de ABSOLUTAMENTE_TODOS  
                 y tenemos en cuenta los derechos de escritura / lectura
                 
                 */

             if(accionARealizar==0){
               form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value=1;
               if(form.elements['LECT_ABSOLUTAMENTE_TODOS'].value==1) 
                 form.elements['ESCR_ABSOLUTAMENTE_TODOS'].value=1;
             } 
             else{
               form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value=0; 
                if(form.elements['ESCR_ABSOLUTAMENTE_TODOS'].value==0) 
                  form.elements['LECT_ABSOLUTAMENTE_TODOS'].value=0;
             }
             
             /* para cada bloque de plantillas tambien hemos de actualizar con la siguiente accion a realizar */
             
             for(var n=0;n<form.length;n++){
               //if(form.elements[n].type=='checkbox'){
                 if(form.elements[n].name.substring(5,10)=='TODOS' && form.elements[n].name.substring(11,14)!='CHK'){
                   if(form.elements[n].name.substring(0,4)=='LECT'){
                     if(form.elements['LECT_ABSOLUTAMENTE_TODOS'].value==0)
                       form.elements[n].value=1;
                     else
                       form.elements[n].value=0;
                   }
                   else{
                     if(form.elements[n].name.substring(0,4)=='ESCR'){
                       if(form.elements['ESCR_ABSOLUTAMENTE_TODOS'].value==0)  
                         form.elements[n].value=1;
                       else
                         form.elements[n].value=0;
                     }  
                   }
                 }
               //}
             }
             
             
            }
          }
          
        }
        
        
        function obtenerAccionARealizar(accion, form){
          for(var n=0;n<form.length;n++){
            if(form.elements[n].type=='checkbox'){
              if(form.elements[n].name.substring(0,4)==accion){
                if(form.elements[n].checked==false){
                  return 1;
                }
              }
            }
          }
          return 0;
        }

/*
        function ValidaySubmit_old(formu){
          var id;
          var cadenaDerechosCarpetas='';
          var cadenaDerechosPlantillas='';
          var lectura;
          var escritura;
        
          if(validarFormulario(formu)){
            for(var i=0;i<formu.length;i++){
              if(formu.elements[i].value=='PLANTILLA_LECT'){
                id=obtenerId(formu.elements[i].name);
                if(formu.elements['LECT_'+id].checked==true){
                  lectura='S';
                }
                else{
                  lectura='N';
                }
                
                if(formu.elements['ESCR_'+id].checked==true){
                  escritura='S';
                }
                else{
                  escritura='N';
                } 
                cadenaDerechosPlantillas+=id+'|'+lectura+'|'+escritura+'#';
              }
              else{
                if(formu.elements[i].value=='CARPETA_LECT'){
                  id=formu.elements[i].name.substring(15,formu.elements[i].name.length);
                  if(formu.elements['LECT_TODOS_CHK_'+id].checked==true){
                    lectura='S';
                  }
                  else{
                    lectura='N';
                  }
                  
                  if(formu.elements['ESCR_TODOS_CHK_'+id].checked==true){
                    escritura='S';
                  }
                  else{
                    escritura='N';
                  } 
                  cadenaDerechosCarpetas+=id+'|'+lectura+'|'+escritura+'#';
                  
                }
              }
            }
            
            formu.elements['DERECHOSPLANTILLAS'].value=cadenaDerechosPlantillas;
            formu.elements['DERECHOSCARPETAS'].value=cadenaDerechosCarpetas;

			console.log('CarpyPLMante. cadenaDerechosPlantillas:'+cadenaDerechosPlantillas+ 'cadenaDerechosCarpetas:'+cadenaDerechosCarpetas);

            SubmitForm(formu);
          }
        }
        
        
        function validarFormulario_old(form){  
          if(comprobarCarpetasYPlantillas(form)){
            return true;
          }
          else{
            return false;
          }
        }
        
        function comprobarCarpetasYPlantillas_old(form){
        // por defecto no hacemos ninguna comprobacion de las carpetas y plantillas
          return true;
        }	
		
	*/	
		
		
	function ValidaySubmit(formu)
	{
          var id;
          var cadenaDerechosCarpetas='';
          var cadenaDerechosPlantillas='';
          var lectura;
          var escritura;
        
          for(var i=0;i<formu.length;i++){
              if(formu.elements[i].value=='PLANTILLA_LECT'){
                id=obtenerId(formu.elements[i].name);
                if(formu.elements['LECT_'+id].checked==true){
                  lectura='S';
                }
                else{
                  lectura='N';
                }
                
                if(formu.elements['ESCR_'+id].checked==true){
                  escritura='S';
                }
                else{
                  escritura='N';
                } 
				if ((lectura!=formu.elements['LECT_ORIG_'+id].value)||(escritura!=formu.elements['ESCR_ORIG_'+id].value))
                	cadenaDerechosPlantillas+=id+'|'+lectura+'|'+escritura+'#';
              }
              else{
                if(formu.elements[i].value=='CARPETA_LECT'){
                  id=formu.elements[i].name.substring(15,formu.elements[i].name.length);
                  if(formu.elements['LECT_TODOS_CHK_'+id].checked==true){
                    lectura='S';
                  }
                  else{
                    lectura='N';
                  }
                  
                  if(formu.elements['ESCR_TODOS_CHK_'+id].checked==true){
                    escritura='S';
                  }
                  else{
                    escritura='N';
                  } 
				 if ((lectura!=formu.elements['LECT_TODOS_ORIG_'+id].value)||(escritura!=formu.elements['ESCR_TODOS_ORIG_'+id].value))
                 	cadenaDerechosCarpetas+=id+'|'+lectura+'|'+escritura+'#';
                }
              }
            }
            
            formu.elements['DERECHOSPLANTILLAS'].value=cadenaDerechosPlantillas;
            formu.elements['DERECHOSCARPETAS'].value=cadenaDerechosCarpetas;

			//solodebug	alert('CarpyPLMante. cadenaDerechosPlantillas:'+cadenaDerechosPlantillas+ 'cadenaDerechosCarpetas:'+cadenaDerechosCarpetas);

            SubmitForm(formu);
	}

	
        
        
        //-->
        </SCRIPT>        
        ]]></xsl:text>	
      </head>

      <body bgcolor="#FFFFFF">
	<!-- Formulario de datos -->	        
	<xsl:choose>
	  <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>
          </xsl:when>   
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="/Manrenimiento/SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="//SESION_CADUCADA"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when> 
          <xsl:otherwise>  
            <xsl:attribute name="onLoad">inicializarDerechosPorPlantilla(document.forms[0]);</xsl:attribute>            
            <xsl:apply-templates select="Mantenimiento/CATEGORIAS"/>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
 
<!--
 |  Templates
 +-->


<xsl:template match="CATEGORIAS">
   <form method="post" name="frmDerechos" action="CARPyPLMantenSave.xsql">
     <xsl:apply-templates select="//ID_PROPIETARIO"/>
     <xsl:apply-templates select="//ID_USUARIO"/>   
     
     <input type="hidden" name="DERECHOSCARPETAS"/>
     <input type="hidden" name="DERECHOSPLANTILLAS"/>
     
		 <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->


	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_de_carpetas_y_plantillas']/node()"/></span></p>
		<p class="TituloPagina">
    		<xsl:value-of select="/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/@usuario"/>
			<span class="CompletarTitulo" style="width:300px;">
        		<a class="btnDestacado" href="javascript:ValidaySubmit(document.forms[0]);"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>&nbsp;
        		<a class="btnNormal" href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
    
  <table class="buscador">	
        <tr class="sinLinea">
          <td class="labelLeft">&nbsp;&nbsp;&nbsp;*&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_todas_plantillas']/node()"/>.</td>  
        </tr>
        <tr class="sinLinea">             
           <td class="labelLeft">&nbsp;&nbsp;&nbsp;*&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_carpetas']/node()"/>.</td>    
        </tr>
        <tr class="sinLinea">             
          <td class="labelLeft">&nbsp;&nbsp;&nbsp;*&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_plantillas_carpeta']/node()"/>.</td>    
         </tr>
         <tr class="sinLinea">             
           <td class="labelLeft">&nbsp;&nbsp;&nbsp;*&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_plantilla']/node()"/>.</td>  
         </tr>
     </table>    
    
  <!--buttons selecion...totales-->
      <table class="buscador">
      <tr class="sinLinea">
        <td class="trenta">&nbsp;</td>
        <td class="doce">&nbsp;</td>
        <td class="catorce">
            <input type="hidden" name="LECT_ABSOLUTAMENTE_TODOS"/>
 			<a class="btnNormal" href="javascript:validacionEscrituraLectura('LECT',-1,'LECT_ABSOLUTAMENTE_TODOS',document.forms[0]);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='todas_lectura']/node()"/>
			</a>
       </td>
       <td class="catorce">
            <input type="hidden" name="ESCR_ABSOLUTAMENTE_TODOS"/>
 			<a class="btnNormal" href="javascript:validacionEscrituraLectura('LECT',-1,'ESCR_ABSOLUTAMENTE_TODOS',document.forms[0]);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='todas_escritura']/node()"/>
			</a>
       </td>
        <td>&nbsp;</td>
      </tr>
    </table>
    <!--buttons arriba total-->
    
  
    	
  <!--tabla cuerpo-->
    <table class="buscador">
      <xsl:for-each select="CATEGORIA">
        <tr class="tituloTabla">
        
        <th colspan="5">
          <xsl:if test="@actual = 'N'"><xsl:value-of select="document($doc)/translation/texts/item[@name='material_sanitario']/node()"/> </xsl:if>
          <xsl:if test="@actual = 'F'"><xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/> </xsl:if>
             
        </th>
        </tr>
        <xsl:for-each select="CARPETAS/CARPETA">
        <tr class="subTituloTabla">
        <th class="trenta">&nbsp;</th>
        <th class="quince"><xsl:value-of select="NOMBRE"/></th>
       
       
        <th class="dies">
          <xsl:choose>
            <xsl:when test="LECTURA='S'">  
              <input type="checkbox" name="LECT_TODOS_CHK_{ID}" value="CARPETA_LECT" checked="checked" onClick="validacionEscrituraLectura('LECT',{ID},'CARPETA',document.forms[0]);"/>
              <input type="hidden" name="LECT_TODOS_{ID}"/>
			  <input type="hidden" name="LECT_TODOS_ORIG_{ID}" value="S"/>
            </xsl:when>
            <xsl:otherwise>
              <input type="checkbox" name="LECT_TODOS_CHK_{ID}" value="CARPETA_LECT" unchecked="unchecked" onClick="validacionEscrituraLectura('LECT',{ID},'CARPETA',document.forms[0]);"/> 
              <input type="hidden" name="LECT_TODOS_{ID}"/>
 			  <input type="hidden" name="LECT_TODOS_ORIG_{ID}" value="N"/>
            </xsl:otherwise>
          </xsl:choose>
        </th>
         <th class="dies">
          <xsl:choose>
            <xsl:when test="ESCRITURA='S'">  
              <input type="checkbox" name="ESCR_TODOS_CHK_{ID}" value="CARPETA_ESCR" checked="checked" onClick="validacionEscrituraLectura('ESCR',{ID},'CARPETA',document.forms[0]);">
                <xsl:if test="BLOQUEADO">
                  <xsl:attribute name="disabled">disabled</xsl:attribute>
                </xsl:if>
              </input>
              <input type="hidden" name="ESCR_TODOS_{ID}"/>
			  <input type="hidden" name="ESCR_TODOS_ORIG_{ID}" value="S"/>
            </xsl:when>
            <xsl:otherwise>
              <input type="checkbox" name="ESCR_TODOS_CHK_{ID}" value="CARPETA_ESCR" unchecked="unchecked" onClick="validacionEscrituraLectura('ESCR',{ID},'CARPETA',document.forms[0]);"> 
                <xsl:if test="BLOQUEADO">
                  <xsl:attribute name="disabled">disabled</xsl:attribute>
                </xsl:if>
              </input>
              <input type="hidden" name="ESCR_TODOS_{ID}"/>
			  <input type="hidden" name="ESCR_TODOS_ORIG_{ID}" value="N"/>
            </xsl:otherwise>
          </xsl:choose>
      
      </th>
      <th>&nbsp;</th>
      </tr>
     
            <xsl:choose>
              <xsl:when test="count(PLANTILLA)&gt;0">
              
              <tr class="grisOscuroB">
              	<td>&nbsp;</td>
                <td>
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas']/node()"/>
                </td>
                 <td>
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='lectura']/node()"/>
                </td>
                 <td>
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='escritura']/node()"/>
                </td>
                <td>&nbsp;</td>
              </tr>
               <tr class="sinLinea">
                <td>&nbsp;</td>
                 <td>&nbsp;</td>
                  <td>
                  <a class="btnNormal" href="javascript:validacionEscrituraLectura('LECT',{ID},'TODOS',document.forms[0]);">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='todas_plantillas_de_carpeta']/node()"/>
                  </a>
                  </td>
                  <td >
                  <a class="btnNormal" href="javascript:validacionEscrituraLectura('ESCR',{ID},'TODOS',document.forms[0]);">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='todas_plantillas_de_carpeta']/node()"/>
                  </a>
                  </td>
                  <td>&nbsp;</td>
              </tr>
             
              <xsl:for-each select="PLANTILLA">
              <tbody>
                  <tr class="sinLinea">
                  <td>&nbsp;</td>
                  <td class="textLeft">
                  	<a href="http://www.newco.dev.br/Compras/Multioferta/PLManten.xsql?PL_ID={ID}"><xsl:value-of select="NOMBRE"/>&nbsp;[<xsl:value-of select="LINEAS"/>]</a>
                  </td>
                  <td align="center">
                    <xsl:choose>
                      <xsl:when test="LECTURA='S'">  
                        <input type="checkbox" name="LECT_{ID}" value="PLANTILLA_LECT" checked="checked" onClick="validacionEscrituraLectura('LECT',{ID},'ESTE',document.forms['frmDerechos']);"/>
						<input type="hidden" name="LECT_ORIG_{ID}" value="S"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="LECT_{ID}" value="PLANTILLA_LECT" unchecked="unchecked" onClick="validacionEscrituraLectura('LECT',{ID},'ESTE',document.forms['frmDerechos']);"/> 
						<input type="hidden" name="LECT_ORIG_{ID}" value="N"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td align="center">
                    <xsl:choose>
                      <xsl:when test="ESCRITURA='S'">  
                        <input type="checkbox" name="ESCR_{ID}" value="PLANTILLA_ESCR" checked="checked" onclick="validacionEscrituraLectura('ESCR',{ID},'ESTE',document.forms['frmDerechos']);">
                       <xsl:if test="BLOQUEADO">
                            <xsl:attribute name="disabled">disabled</xsl:attribute>
                          </xsl:if>
                        </input>
						<input type="hidden" name="ESCR_ORIG_{ID}" value="S"/>
                       </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="ESCR_{ID}" value="PLANTILLA_ESCR" unchecked="unchecked" onclick="validacionEscrituraLectura('ESCR',{ID},'ESTE',document.forms['frmDerechos']);">
                        <xsl:if test="BLOQUEADO">
                            <xsl:attribute name="disabled">disabled</xsl:attribute>
                          </xsl:if>
                        </input> 
 						<input type="hidden" name="ESCR_ORIG_{ID}" value="N"/>
                     </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td>&nbsp;</td>
                  </tr>
                  </tbody>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                  <tr class="sinLinea">
                  <td align="center" colspan="5">
                  	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_plantillas']/node()"/>
                  </td>
                  </tr>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each><!--FIN FOR-EACH DE CARPETAS-->
      </xsl:for-each>
    </table>
  <!--tabla cuerpo fin-->
    
    <table class="buscador">
      <tr class="sinLinea">
        <td class="trenta">&nbsp;</td>
        <td class="doce">&nbsp;</td>
        <td class="catorce">
          <!--<xsl:choose>
            <xsl:when test="LECTURA='S'"> 
            	<!- -<div class="botonLargo"> 
            	  <xsl:call-template name="botonPersonalizado">
                	<xsl:with-param name="funcion">validacionEscrituraLectura('LECT',-1,'LECT_ABSOLUTAMENTE_TODOS',document.forms[0]);</xsl:with-param>
                	<xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_lectura']/node()"/>  </xsl:with-param>
	        	<xsl:with-param name="status"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_lectura']/node()"/></xsl:with-param>	
            	  </xsl:call-template>
            	  </div>- ->
				<a class="btnNormal" href="javascript:validacionEscrituraLectura('LECT',-1,'LECT_ABSOLUTAMENTE_TODOS',document.forms[0]);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='todas_lectura']/node()"/>
				</a>
            </xsl:when>
            <xsl:otherwise>
            	<!- -<div class="botonLargo"> 
            	  <xsl:call-template name="botonPersonalizado">
                	<xsl:with-param name="funcion">validacionEscrituraLectura('LECT',-1,'LECT_ABSOLUTAMENTE_TODOS',document.forms[0]);</xsl:with-param>
                	<xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_lectura']/node()"/></xsl:with-param>
	        	<xsl:with-param name="status"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_lectura']/node()"/></xsl:with-param>	
				</xsl:call-template>
            	</div>- ->
				<a class="btnNormal" href="javascript:validacionEscrituraLectura('LECT',-1,'LECT_ABSOLUTAMENTE_TODOS',document.forms[0]);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='todas_lectura']/node()"/>
				</a>
            </xsl:otherwise>
          </xsl:choose>-->
			<a class="btnNormal" href="javascript:validacionEscrituraLectura('LECT',-1,'LECT_ABSOLUTAMENTE_TODOS',document.forms[0]);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='todas_lectura']/node()"/>
			</a>

        </td>
        <td class="catorce">
          <!--<xsl:choose>
            <xsl:when test="ESCRITURA='S'">  
              <div class="boton">
              <xsl:call-template name="botonPersonalizado">
                <xsl:with-param name="funcion">validacionEscrituraLectura('ESCR',-1,'ESCR_ABSOLUTAMENTE_TODOS',document.forms[0]);</xsl:with-param>
                <xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_escritura']/node()"/></xsl:with-param>
	        	<xsl:with-param name="status"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_escritura']/node()"/></xsl:with-param>
              </xsl:call-template>
              </div>
            </xsl:when>
            <xsl:otherwise>
            <div class="botonLargo"> 
              <xsl:call-template name="botonPersonalizado">
                <xsl:with-param name="funcion">validacionEscrituraLectura('ESCR',-1,'ESCR_ABSOLUTAMENTE_TODOS',document.forms[0]);</xsl:with-param>
                <xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_escritura']/node()"/></xsl:with-param>
	        	<xsl:with-param name="status"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_escritura']/node()"/></xsl:with-param>	
              </xsl:call-template>
              </div>
            </xsl:otherwise>
          </xsl:choose>-->
			<a class="btnNormal" href="javascript:validacionEscrituraLectura('ESCR',-1,'ESCR_ABSOLUTAMENTE_TODOS',document.forms[0]);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='todas_escritura']/node()"/>
			</a>
        </td>
        <td>&nbsp;</td>
     </tr>
  </table><!--fin de buttons abajo total-->
  <br /><br />
  <!--
   <div class="divLeft">
    <div class="divLeft30">&nbsp;</div>
    <div class="divLeft20">
        <div class="boton">
        	<a href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>
        </div>
     </div>
     <div class="divLeft10">&nbsp;</div>
     <div class="divLeft20">
      <div class="boton">
        	<a href="javascript:ValidaySubmit(document.forms[0]);"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
        </div>
       
      </div>
      </div>
	  -->
  </form>	      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>
  

<xsl:template match="ID_USUARIO">
  <input type="hidden" name="ID_USUARIO">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template> 


<xsl:template match="ID_PROPIETARIO">
  <input type="hidden" name="ID_PROPIETARIO">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>


</xsl:stylesheet>
