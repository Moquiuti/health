<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  This stylesheet implements multi-language at the UI level
 |  It is based on the parameter 'lang' that is 'english' by default.
 |  It can be also 'french' or 'spanish' or 'german'.
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html>
      <head> 
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
	<xsl:text disable-output-escaping="yes">
    <![CDATA[
        <script type="text/javascript">
        <!--
        //Si PROGRAMADA esta checked miramos si 
        //FECHANO_ACTIVACION existe y es correcto
        //o si PERIODOACTIVACION y ademas FECHANO_ACTIVACION existen y son correctos
        //if (validaNombre(formu)==true &&  validaPeriodoActivacion(formu)==true && validaFechaSiEstaProgramada(formu)==true) {
        
        
     msgAfectaUsuarioPropietario='No se pueden quitar los derechos de acceso al propietario de la plantilla.';
     msgSinPlantilla='Ha de guardar la nueva plantilla antes de poder autorizar empresas a usarla.';
     
     
     ]]></xsl:text> 
     
     var Edicion='READ_ONLY';
     
     <xsl:if test="Mantenimiento/PLANTILLA/EDICION">
       Edicion='EDICION';
     </xsl:if>
     
     var idUsuarioPropietario='<xsl:value-of select="/Mantenimiento/PLANTILLA/USUARIOS/field/@current"/>';

     function CambioResponsable(propietarioNuevo){
       var propietarioAnterior=idUsuarioPropietario;
     
       idUsuarioPropietario=propietarioNuevo;
         document.forms[0].elements['ESCR_'+propietarioNuevo].checked=true;
         document.forms[0].elements['LECT_'+propietarioNuevo].checked=true;
         
         document.forms[0].elements['ESCR_'+propietarioAnterior].checked=false;
         document.forms[0].elements['LECT_'+propietarioAnterior].checked=false;
     } 
     
     <xsl:choose>
       <xsl:when test="/Mantenimiento/PLANTILLA/EDICION">
         var aplicarDerechos='S';
       </xsl:when>
       <xsl:otherwise>
         var aplicarDerechos='N';
       </xsl:otherwise>
     </xsl:choose>
     
     
          
          
          /*
          
            creo un array bidimensional en la primera posicion de cada registro guardo el id centro 
            y despues el id de todos los usuarios de este centro
            
                0 [idCentro],[idUsuario],[idUsuario],[idUsuario]
                1 [idCentro],[idUsuario]
                2 [idCentro],[idUsuario],[idUsuario],
                ...
           */
          
          if(aplicarDerechos=='S'){
          
          arrayUsuarios=new Array(<xsl:value-of select="count(/Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/CENTRO)"/>);

          <xsl:for-each select="/Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/CENTRO">
            var i='<xsl:value-of select="position()-1"/>';
            arrayUsuarios[parseInt(i)]=new Array(<xsl:value-of select="count(USUARIO)+1"/>);
            arrayUsuarios[i][0]=<xsl:value-of select="ID"/>;
            <xsl:for-each select="USUARIO">
              var j='<xsl:value-of select="position()"/>';
              arrayUsuarios[i][j]=<xsl:value-of select="ID"/>;
            </xsl:for-each>
            
          </xsl:for-each>   
          
          }   
        
    <xsl:text disable-output-escaping="yes"><![CDATA[      
        
        /*
           recorro todos los centros y todos los usuarios 
           para cada centro si TODOS los usuarios tienen permisos guardo
           en un hidden <ACCION>_TODOS_<ID> el valor true, esto es para cuando se pulse el link "Todos"
           saber que accion tiene que realizar dar o quitar privilegios
        */
        
      function inicializarDerechosPorUsuario(form){
        if(aplicarDerechos=='S'){
          for(i=0;i<arrayUsuarios.length;i++){
            var tienePermisosLect=1;
            var tienePermisosEscr=1;
            for(j=1;j<arrayUsuarios[i].length;j++){
              if(form.elements['LECT_'+arrayUsuarios[i][j]].checked==false)
                tienePermisosLect=0;
              if(form.elements['ESCR_'+arrayUsuarios[i][j]].checked==false)
                tienePermisosEscr=0;   
            }
              form.elements['LECT_TODOS_'+arrayUsuarios[i][0]].value=tienePermisosLect;
              form.elements['ESCR_TODOS_'+arrayUsuarios[i][0]].value=tienePermisosEscr;
          }
        }
      }
        
      //seleccionar todos en lectura o ecsritura
      
      function selTodosEscrituraLectura(accion,form){
      
      		    var form = document.forms['form1'];
                var Estado=null;
                
                for (var i=0;(i<form.length)&&(Estado==null);i++)
                {
                    var k=form.elements[i].name;
            
                    if (k.substr(0,5)==accion)
                    {
                        if (form.elements[i].checked == true )
                            Estado=false;
                        else
                            Estado=true;
                    }
                }		
                    
                for (var i=0;i<form.length;i++)
                {
                    var k=form.elements[i].name;
            
                    if (k.substr(0,5)==accion)
                    {
                        form.elements[i].checked = Estado;
                        //alert(form.elements[i].name+' vrvr '+form.elements[i].value);
                    }
                }
      }
      //fin seleccionar todos
        
        /*
        
          si es un check de usuario recibe la acion LECT / ESCR, el ID de usuario, y a quien afecta 'ESTE'   
          si es un link (Todos) recibe la accion LECT / ESCR, el ID del centro, y a quien afecta 'TODOS'
          si es un boton recibe la accion EMPRESA, se aplica a toda la empresa
        
        */
        
        function validacionEscrituraLectura(accion,id,tipo,form){
            // ESTE usuario
          if(tipo=='ESTE'){
            if(idUsuarioPropietario!=id){
              if(accion=='LECT'){
                if(form.elements[accion+'_'+id].checked==false){
                  form.elements['ESCR_'+id].checked=false;
                }
              }
              else{
                if(form.elements[accion+'_'+id].checked==true){
                  form.elements['LECT_'+id].checked=true;
                } 
              }
            }
            else{
               form.elements[accion+'_'+id].checked=true;
               alert(msgAfectaUsuarioPropietario);
            }
          }
          else{
            if(tipo=='TODOS'){
              //  TODOS los usuarios
              var afectaAlPropietario='';
              var posicionDelCentro=0;
            
              /*
                obtengo la posicion del centro en el array
              */
            
              for(var n=0;n<arrayUsuarios.length;n++){
                if(arrayUsuarios[n][0]==id)
                  posicionDelCentro=n;
              }
            
              /*
                para todos los usuarios activamos o desactivamos
            
              */
            
              for(var i=1;i<arrayUsuarios[posicionDelCentro].length;i++){
                if(idUsuarioPropietario!=arrayUsuarios[posicionDelCentro][i]){
                  if(form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value==1)
                    form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=false;
                  else
                    form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
             
               /*
                  miramos que no haya conflictos con los derechos lectura / escritura
                     si no puede leer tampoco puede escribir
                     si puede escribir puede leer
               */   
             
                  if(accion=='LECT' && form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked==false){
                    form.elements['ESCR_'+arrayUsuarios[posicionDelCentro][i]].checked=false;
                  }
                  else{
                    if(accion=='ESCR' && form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked==true){
                      form.elements['LECT_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
                    }
                  }
                }
                else{
                  afectaAlPropietario='S';
                  form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
                }
              }
            
              //if(afectaAlPropietario=='S' && form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value==1){
              //  alert(msgAfectaUsuarioPropietario);
              //}
            
              /*
                  guardamos la siguiente accion a realizar al pulsar el link "Todos"
                         dar / quitar alternativamente      
              */
            
              if(form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value==1){
                form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=0;
                if(accion=='LECT')
                  form.elements['ESCR_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=0; 
              }
              else{
                form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=1;
                if(accion=='ESCR')
                  form.elements['LECT_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=1;         
              }
            }
            else{
             // tipo = EMPRESA
              //alert('en empresa');
              
              //alert('accion '+accion+' id '+id+'tipo '+tipo+' form '+form.name);
              
              var afectaAlPropietario='';
              var posicionDelCentro=0;
              
              
              /*
                miramos que la accion global concuerde con las de los centros
                si lo centros son diferentes (alguno activar / alguno desactivar usamos la global)
                escojemos la opcion que esta para todos los centros. todos desactivar ==> desactivar
              */
              
              
              var accionGlobal=-1;
              var salir=0;
              
              for(var n=0;n<arrayUsuarios.length&&!salir;n++){
                  posicionDelCentro=n;
                  if(accionGlobal==-1){
                    accionGlobal=form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value;
                  }
                  else{
                    if(form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value!=accionGlobal){
                      salir=1;
                    }
                  }
              }
              
              if(!salir){
                 form.elements[accion+'_EMPRESA'].value=accionGlobal;
              }
              
            
              /*
                obtengo la posicion del centro en el array
              */
              
              
              arrayUsuarios
            
              // PARA TODOS LOS CENTROS
            
              for(var n=0;n<arrayUsuarios.length;n++){
                  posicionDelCentro=n;
             
              /*
                para todos los usuarios DEL CENTRO ACTUAL activamos o desactivamos
            
              */
            
                for(var i=1;i<arrayUsuarios[posicionDelCentro].length;i++){
                  if(idUsuarioPropietario!=arrayUsuarios[posicionDelCentro][i]){
                    if(form.elements[accion+'_EMPRESA'].value==1)
                      form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=false;
                    else
                      form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
             
                 /*
                     miramos que no haya conflictos con los derechos lectura / escritura
                       si no puede leer tampoco puede escribir
                       si puede escribir puede leer
                 */   
             
                    if(accion=='LECT' && form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked==false){
                      form.elements['ESCR_'+arrayUsuarios[posicionDelCentro][i]].checked=false;
                    }
                    else{
                      if(accion=='ESCR' && form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked==true){
                        form.elements['LECT_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
                      }
                    }
                  }
                  else{
                    afectaAlPropietario='S';
                    form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
                  }
                }
                
                /* guardamos la accion a realizar a nivel de centro para que concuerde con la de empresa */
                
                if(form.elements[accion+'_EMPRESA'].value==1){
                  form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=0;
                  if(accion=='LECT')
                    form.elements['ESCR_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=0; 
                }
                else{
                  form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=1;
                  if(accion=='ESCR')
                    form.elements['LECT_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=1;         
                }
                
                
             }
             
            
                /*
                    guardamos la siguiente accion a realizar al pulsar el link "Todos" empresa
                           dar / quitar alternativamente      
                */
            
                if(form.elements[accion+'_EMPRESA'].value==1){
                  form.elements[accion+'_EMPRESA'].value=0;
                  if(accion=='LECT')
                    form.elements['ESCR_EMPRESA'].value=0; 
                }
                else{
                  form.elements[accion+'_EMPRESA'].value=1;
                  if(accion=='ESCR')
                    form.elements['LECT_EMPRESA'].value=1;         
                }
                
                
             
              

              
              // FIN EMPRESA
            }
          }
        }
          
        
       
        function Actua(formu){
	  var Cadena='';
	  if(Edicion=='EDICION'){	
	    if (validaNombre(formu)==true) {
	       //  Construye la cadena con los derechos de los usuarios
  	      for (j=0;j<formu.elements.length;j++){
	        if (formu.elements[j].name.substring(0,10)=='USUARIO_ID'){
	          Cadena+=formu.elements[j].value+'|'+(formu.elements['LECT_'+formu.elements[j].value].checked==true?'S':'N')+'|'+(formu.elements['ESCR_'+formu.elements[j].value].checked==true?'S':'N')+'#';
	        }
	      }			 

	      //  Guarda la cadena de derechos en el campo asignado
	      
	      formu.elements['DERECHOS'].value=Cadena;
	      
              SubmitForm(formu);  
            }
          }
          else{
            SubmitForm(formu);
          }            
        }
        
        function validaNombre(formu){
          if (formu.elements['NOMBRE'].value==""){
            alert(' ]]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0340' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[');
            formu.elements['NOMBRE'].focus();
            return false;
          }
          else return true;
        }
        
        function validaPeriodoActivacion(formu){
          //Validamos PERIODOACTIVACION
          if (formu.PL_PERIODOACTIVACION.value!="" && (formu.PL_PERIODOACTIVACION.value <= 0 || isNaN(formu.PL_PERIODOACTIVACION.value))){
            alert(']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0260' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[');
            formu.PL_PERIODOACTIVACION.focus();
            return false;
          }
          else{
            return true;       
          }
        }
        
        function validaFechaSiEstaProgramada(formu){                         
           if (formu.PL_PROGRAMADA.checked){
            //Si PERIODOACTIVACION esta vacio obligamos a que FECHANO_ACTIVACION exista
            if(formu.PL_PERIODOACTIVACION.value==""){
              if (formu.FECHANO_ACTIVACION.value!=""){
                return test(formu);
              }
              else{
                alert(']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0275' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[');
                formu.FECHANO_ACTIVACION.focus();
                return false;
              }
            }
            //Si existe PERIODOACTIVACION obligamos a que exista FECHANO_ACTIVACION
            else{
                if (formu.FECHANO_ACTIVACION.value==""){
                  alert(']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0270' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[');
                  formu.FECHANO_ACTIVACION.focus();
                  return false;
                }
                else{
                  return test(formu);
                }
            }
          }
         else {return true};
        }



        function EmpresasAutorizadas(){
            
            var form=document.forms[0];
            if(form.elements['ID'].value==0){
              alert(msgSinPlantilla);
            }
            else{
              var opciones='?PL_ID='+ form.elements['ID'].value;	
              alert('mi');
              MostrarPag('http://www.newco.dev.br/Compras/Multioferta/PLEmpresasAutorizadas.xsql'+opciones,'empresasAutorizadas');    
            }
              
          }	
        //-->
        </script>
        ]]></xsl:text>
      </head>

      <body onLoad="inicializarDerechosPorUsuario(document.forms[0]);" class="gris">
        <xsl:choose>
          Mantenimiento/SESION_CADUCADA
          <xsl:when test="Mantenimiento/SESION_CADUCADA">
            <xsl:apply-templates select="Mantenimiento/SESION_CADUCADA"/>          
          </xsl:when>
          <xsl:when test="Mantenimiento/PLANTILLA/EDICION">
            <xsl:call-template name="MantenimientoEdicion"/>          
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="MantenimientoReadOnly"/>          
          </xsl:otherwise>
        </xsl:choose>        
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template name="MantenimientoEdicion">

<!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
      
<form>
    <xsl:attribute name="name">form1</xsl:attribute>
    <xsl:attribute name="action">PLMantenSave.xsql</xsl:attribute>
    <xsl:attribute name="method">post</xsl:attribute>
    <xsl:call-template name="ID"/>
    <xsl:call-template name="IDEMPRESA"/>
    <xsl:call-template name="NUMERO"/>
    <xsl:call-template name="CONDICIONESGENERALES"/>
    <xsl:call-template name="STATUS"/>
    <xsl:call-template name="IDDIVISA"/>
	<input type="hidden" name="DERECHOS" value=""/>
	<input type="hidden" name="IDUSUARIO_ACTUAL" value="{/Mantenimiento/US_ID}"/>
	<input type="hidden" name="TIPO_MODIFICACION">
	  <xsl:choose>
	    <xsl:when test="/Mantenimiento/PLANTILLA/EDICION">
	      <xsl:attribute name="value">EDICION</xsl:attribute>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:attribute name="value">READ_ONLY</xsl:attribute>
	    </xsl:otherwise>
	  </xsl:choose>
	</input>
    <!--
     |  Cuando generamos una plantilla no dejamos modificar el nombre ni la descripción 
     |  de la plantilla. Los copiamos en campos ocultos para que se copien en la lista
     |  de productos.
     +-->
    <xsl:if test="Mantenimiento/BOTON[.='Generar']">
      <input type="hidden" name="PL_NOMBRE" value="{PL_NOMBRE}" />
      <input type="hidden" name="PL_DESCRIPCION" value="{PL_DESCRIPCION}"/>            
    </xsl:if>
    
    <h1 class="titlePage">
    	<xsl:choose>
	  <xsl:when test="Mantenimiento/BOTON[.='Generar']">
      		<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/>
          </xsl:when>
          <xsl:otherwise>
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/>
          </xsl:otherwise>
        </xsl:choose>

	<xsl:if test="/Mantenimiento/PLANTILLA/ADMIN">
		<span style="float:right; padding:5px;" class="amarillo">PL_ID:&nbsp;<xsl:value-of select="/Mantenimiento/PLANTILLA/ID"/></span>
	</xsl:if>
     </h1>
    
  <table class="infoTable">	  
   <input type="checkbox" name="PUBLICA" style="display:none;">   
   <xsl:choose>
		<xsl:when test="Mantenimiento/PLANTILLA/PUBLICA='S'">
	    	<xsl:attribute name="checked"></xsl:attribute>      
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="unchecked"></xsl:attribute>      
		</xsl:otherwise>
	</xsl:choose> 
    </input>   
	<!--<xsl:if test="Mantenimiento/PLANTILLA/ADMINISTRADORMVM">
    <tr class="grisclaro"> 
      <td class="labelRight cinquenta">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla_publica']/node()"/>:
        </td>
      <td colspan="3" class="datosLeft">
	  	<xsl:call-template name="PUBLICA"/>          
      </td>
    </tr>
	</xsl:if>-->
    <tr> 
      <td class="labelRight cinquenta">
   		<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
      <td colspan="3" class="datosLeft ochanta">
            <xsl:call-template name="NOMBRE"/>  	                   
        </td>
    </tr>	
    
    <tr class="blanco"> 
      <td class="labelRight" align="right">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:<span class="camposObligatorios">*</span>:
        </td>
      <td colspan="3" class="datosLeft">
	    <xsl:call-template name="DESCRIPCION"/>      	                   
      </td>
    </tr>
    <tr> 
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:
        </td>
      <td colspan="3" class="datosLeft">
            <xsl:choose>
          <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">
            <xsl:call-template name="desplegable">
              <xsl:with-param name="path" select="Mantenimiento/PLANTILLA/USUARIOS/field"/>
              <xsl:with-param name="onChange">CambioResponsable(this.value);</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="USUARIO"/>
            <xsl:call-template name="IDUSUARIO"/>
          </xsl:otherwise>        
        </xsl:choose> 
      </td>
    </tr>
    <xsl:choose>
      <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">
      <input type="hidden" name="{Mantenimiento/PLANTILLA/CENTROS/field/@name}" value="{Mantenimiento/PLANTILLA/CENTROS/field/@current}"/>
    </xsl:when>
      <xsl:otherwise>
        <input type="hidden" name="{Mantenimiento/PLANTILLA/CENTROS/field/@name}" value="{Mantenimiento/PLANTILLA/CENTROS/field/@current}"/>
      </xsl:otherwise>        
    </xsl:choose>		
    <tr> 
      <td class="labelright">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='carpeta']/node()"/>:
        </td>
      <td colspan="3" class="datosLeft">
	  <xsl:call-template name="CARPETAS"/>                        
      </td>
    </tr>	
    <xsl:choose>
      <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">
      <input type="hidden" name="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@current}"/>
    </xsl:when>
      <xsl:otherwise>
        <input type="hidden" name="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@current}"/>
      </xsl:otherwise>        
    </xsl:choose>	 
	<tr> 
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_entrega']/node()"/>:
        </td>
      <td colspan="3" class="datosLeft">
        <xsl:choose>
          <xsl:when test="/Mantenimiento/PLANTILLA/PLAZOENTREGA=''">
            <xsl:call-template name="field_funcion">
    	      <xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_ENTREGA']"/>
    	      <xsl:with-param name="IDAct">3</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="field_funcion">
    	      <xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_ENTREGA']"/>
    	      <xsl:with-param name="IDAct" select="/Mantenimiento/PLANTILLA/PLAZOENTREGA"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>          
      </td>
    </tr>
    <!--plantilla de reserva-->
     
	      <input type="checkbox" name="URGENCIA" style="display:none;">
           <xsl:choose>
	          <xsl:when test="Mantenimiento/PLANTILLA/URGENCIA='N'">
	            <xsl:attribute name="unchecked"></xsl:attribute>      
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="checked"></xsl:attribute>      
              </xsl:otherwise>
           </xsl:choose> 
	      </input>
    <!--<tr> 
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla_de_reserva']/node()"/>:
        </td>
      <td colspan="3" class="datosLeft">
	  	<xsl:call-template name="URGENCIA"/>          
      </td>
    </tr>  -->
    </table>      
    
	<!--	Derechos de acceso a la plantilla para cada usuario		-->
   
	<table class="mediaTabla" border="0">
    	<thead>
		<tr>
		  <th colspan="5">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_acceso_plantilla']/node()"/>
		  </th>
		</tr>
        </thead>
		<tr class="tituloGris">
        	<td class="trentacinco">&nbsp;</td>
			<td class="veintecinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
			<td class="cinco">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='lectura']/node()"/><br />
                 &nbsp;<a href="javascript:selTodosEscrituraLectura('LECT_',document.forms[0]);">
			      <xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>							
			    </a>
            </td>
			<td class="cinco">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='escritura']/node()"/><br />
            	 &nbsp;<a href="javascript:selTodosEscrituraLectura('ESCR_',document.forms[0]);">
			      		<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>							
			     </a>    
            </td>
            <td>&nbsp;</td>
		</tr>
        <tbody>
	  	<xsl:for-each select="Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/CENTRO">
			<input type="hidden">
					<xsl:attribute name="name">CENTRO_ID_<xsl:value-of select="ID"/></xsl:attribute>
    				<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>      
 				</input>
			<tr>
              <td>&nbsp;</td>
			  <td>
	              <strong><xsl:value-of select="./NOMBRE"/></strong>
			  </td>
			  <td class="center">
			    <input type="hidden">							
		              <xsl:attribute name="name">LECT_TODOS_<xsl:value-of select="ID"/></xsl:attribute>
		              <xsl:attribute name="value">false</xsl:attribute>
		            </input>
			   
			  </td>
			  <td class="center">
			    <input type="hidden">							
		              <xsl:attribute name="name">ESCR_TODOS_<xsl:value-of select="ID"/></xsl:attribute>
		              <xsl:attribute name="value">false</xsl:attribute>
		            </input>
	               
			  </td>
              <td>&nbsp;</td>
			</tr>
	  		<xsl:for-each select="./USUARIO">
  				<input type="hidden">
					<xsl:attribute name="name">USUARIO_ID_<xsl:value-of select="ID"/></xsl:attribute>
    				<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>      
 				</input>
				<tr>
	                <td>&nbsp;</td>
					<td>&nbsp;&nbsp;&nbsp;-&nbsp;<xsl:value-of select="./NOMBRE"/></td>
					<td class="center"><input type="checkbox">							
						<xsl:attribute name="name">LECT_<xsl:value-of select="ID"/></xsl:attribute>
						<xsl:attribute name="onClick">validacionEscrituraLectura('LECT',<xsl:value-of select="ID"/>,'ESTE',document.forms[0]);</xsl:attribute>
	    				<xsl:choose>
	      					<xsl:when test="./LECTURA='S' or (/Mantenimiento/PLANTILLA/@ID='' and /Mantenimiento/PLANTILLA/IDUSUARIO=ID)">
								<xsl:attribute name="checked">
								</xsl:attribute>
	      					</xsl:when>
	      					<xsl:otherwise>
								<xsl:attribute name="unchecked">
								</xsl:attribute>
	      					</xsl:otherwise>
	    				</xsl:choose>
					</input></td>
					<td class="center"><input type="checkbox">							
						<xsl:attribute name="name">ESCR_<xsl:value-of select="ID"/></xsl:attribute>
						<xsl:attribute name="onClick">validacionEscrituraLectura('ESCR',<xsl:value-of select="ID"/>,'ESTE',document.forms[0]);</xsl:attribute>
	    				<xsl:choose>
	      					<xsl:when test="./ESCRITURA='S' or (/Mantenimiento/PLANTILLA/@ID='' and /Mantenimiento/PLANTILLA/IDUSUARIO=ID)">
								<xsl:attribute name="checked">
								</xsl:attribute>
	      					</xsl:when>
	      					<xsl:otherwise>
								<xsl:attribute name="unchecked">
								</xsl:attribute>
	      					</xsl:otherwise>
	    				</xsl:choose>
					</input>
                   </td>
                   <td>&nbsp;</td>
				</tr>
	  		</xsl:for-each>  
	  	</xsl:for-each>  
	</tbody>
    </table><!--fin usuarios-->
    
    <!--<table class="mediaTabla">
	<xsl:if test="Mantenimiento/PLANTILLA/ADMINISTRADORMVM">
    <tr class="tituloTabla"> 
		<th colspan="4">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla_publica']/node()"/>:
        </th>
    </tr>
    </xsl:if>
    </table>
    
    <xsl:if test="Mantenimiento/PLANTILLA/ADMINISTRADORMVM">
			<xsl:apply-templates select="Mantenimiento/PLANTILLA/EMPRESASAUTORIZADAS"/>          
	</xsl:if>-->
    <br /><br />
    <table class="mediaTabla">
    <tr>
	     <xsl:choose>
	      <xsl:when test="Mantenimiento/BOTON[.='CABECERA']">
              <td class="trenta">&nbsp;</td>
	          <td class="veinte">  
		        <xsl:call-template name="boton">
	                  <xsl:with-param name="path" select="Mantenimiento/button[@label='Cancelar']"/>
	                </xsl:call-template> 
		      </td>
		      <td class="quince">&nbsp;</td>      
		      <td> 
		        <xsl:call-template name="boton">
	          <xsl:with-param name="path" select="Mantenimiento/button[@label='Aceptar']"/>
	        </xsl:call-template>
		      </td>
	      </xsl:when>
	      <xsl:otherwise>
		      <td class="trenta">&nbsp;</td>
	          <td class="veinte">  
		        <xsl:call-template name="boton">
	                  <xsl:with-param name="path" select="Mantenimiento/button[@label='Cancelar']"/>
	                </xsl:call-template> 
		      </td>
		      <td class="quince">&nbsp;</td>      
		      <td> 
		        <xsl:call-template name="boton">
	          <xsl:with-param name="path" select="Mantenimiento/button[@label='Aceptar']"/>
	        </xsl:call-template>
		      </td>
	      </xsl:otherwise>
	     </xsl:choose> 
    </tr>
  </table>
</form>
</xsl:template>

<xsl:template name="MantenimientoReadOnly">
<!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
      
      
<form>

    <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:attribute name="action">PLMantenSave.xsql</xsl:attribute>
    <xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute>
    <xsl:call-template name="ID"/>
    <xsl:call-template name="IDEMPRESA"/>
    <xsl:call-template name="NUMERO"/>
    <xsl:call-template name="CONDICIONESGENERALES"/>
    <xsl:call-template name="STATUS"/>
    <xsl:call-template name="IDDIVISA"/>
    <input type="hidden" name="IDUSUARIO_ACTUAL" value="{/Mantenimiento/US_ID}"/>
    <input type="hidden" name="TIPO_MODIFICACION">
	  <xsl:choose>
	    <xsl:when test="/Mantenimiento/PLANTILLA/EDICION">
	      <xsl:attribute name="value">EDICION</xsl:attribute>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:attribute name="value">READ_ONLY</xsl:attribute>
	    </xsl:otherwise>
	  </xsl:choose>
	</input>
    <!--
     |  Cuando generamos una plantilla no dejamos modificar el nombre ni la descripción 
     |  de la plantilla. Los copiamos en campos ocultos para que se copien en la lista
     |  de productos.
     +-->
    <xsl:if test="Mantenimiento/BOTON[.='Generar']">
      <input type="hidden" name="PL_NOMBRE" value="{PL_NOMBRE}" />
      <input type="hidden" name="PL_DESCRIPCION" value="{PL_DESCRIPCION}"/>            
    </xsl:if>
    
 	
	<h1 class="titlePage">
	<xsl:choose>
	  <xsl:when test="Mantenimiento/BOTON[.='Generar']">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/>
          </xsl:otherwise>
        </xsl:choose>
     </h1>
     
    <table class="infoTable" border="0">
    <tr> 
      <td class="cinquenta labelRight">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:
      </td>
      <td class="datosLeft">    
            <xsl:value-of select="Mantenimiento/PLANTILLA/NOMBRE"/>  	                   
        </td>
    </tr>	
    <xsl:if test="Mantenimiento/PLANTILLA/DESCRIPCION != ''">
    <tr>
      <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:
      </td>
      <td class="datosLeft">    
	    <xsl:value-of select="Mantenimiento/PLANTILLA/DESCRIPCION"/>      	                   
      </td>
    </tr>
    </xsl:if>
    <tr>
      <td class="labelRight">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:
      </td>
      <td class="datosLeft">    
            <xsl:value-of select="Mantenimiento/PLANTILLA/USUARIO"/>  
      </td>
    </tr>
    <xsl:choose>
      <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">
        <input type="hidden" name="{Mantenimiento/PLANTILLA/CENTROS/field/@name}" value="{Mantenimiento/PLANTILLA/CENTROS/field/@current}"/>
      </xsl:when>
      <xsl:otherwise>
        <input type="hidden" name="{Mantenimiento/PLANTILLA/CENTROS/field/@name}" value="{Mantenimiento/PLANTILLA/CENTROS/field/@current}"/>
      </xsl:otherwise>        
    </xsl:choose>	
    <tr>
       <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='carpeta']/node()"/>:
        </td>
      <td class="datosLeft">    
	  <xsl:for-each select="Mantenimiento/PLANTILLA/CARPETAS/field/dropDownList/listElem">
                  <xsl:if test="ID=../../@current">
	  	    <xsl:value-of select="listItem"/> 
	  	  </xsl:if>
	  	</xsl:for-each>                            
      </td>
    </tr>
    <xsl:choose>
      <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">	
        <input type="hidden" name="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@current}"/>
      </xsl:when>
      <xsl:otherwise>
        <input type="hidden" name="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@current}"/>
      </xsl:otherwise>        
    </xsl:choose> 
    <!-- comentamos de momento
    <tr>
    <td class="labelRight">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0240' and @lang=$lang]" disable-output-escaping="yes"/>:
	</td>
    <td class="datosLeft">    
                <xsl:call-template name="FORMASPAGO"/>          
	  	<xsl:call-template name="PLAZOSPAGO"/>          
  	    <input type="text" size="50" name="FORMAPAGO" maxlength="100">     	                   
    		<xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/FORMAPAGO"/></xsl:attribute>      
  		</input>
        
      </td>
	</tr>
    <tr>
      <td class="labelRight">
        Plazo de Entrega:
      </td>
      <td class="datosLeft">    
        <xsl:choose>
          <xsl:when test="/Mantenimiento/PLANTILLA/PLAZOENTREGA=''">
            <xsl:call-template name="field_funcion">
    	      <xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_ENTREGA']"/>
    	      <xsl:with-param name="IDAct">3</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="field_funcion">
    	      <xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_ENTREGA']"/>
    	      <xsl:with-param name="IDAct" select="/Mantenimiento/PLANTILLA/PLAZOENTREGA"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>          
      </td>
    </tr>   
    <tr>
      <td class="labelRight">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0287' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td class="datosLeft">    
        <xsl:choose>
          <xsl:when test="Mantenimiento/PLANTILLA/URGENCIA='N'">
            No urgente
          </xsl:when>
          <xsl:otherwise>
            <font color="red">RESERVA</font>
          </xsl:otherwise>
          </xsl:choose>         
      </td>
    </tr>   -->
    <tr>
      <td colspan="2">
      	<div class="botonCenter">
        	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/AreaTrabajo.html"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
		</div>
      </td>
    </tr>
  </table>
</form>
</xsl:template>



<!-- CAMPS OCULTS -->

<xsl:template name="ID">
  <input type="hidden" name="ID">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/ID"/> </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="IDEMPRESA">
  <input type="hidden" name="IDEMPRESA">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/IDEMPRESA"/> </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="NUMERO">
  <input type="hidden" name="NUMERO">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/NUMERO"/> </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="CONDICIONESGENERALES">
  <input type="hidden" name="CONDICIONESGENERALES">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/CONDICIONESGENERALES"/> </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="IDDIVISA">
  <input type="hidden" name="IDDIVISA">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/IDDIVISA"/> </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="STATUS">
  <input type="hidden" name="STATUS">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/STATUS"/> </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="BOTON">
  <input type="hidden" name="BOTON">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/BOTON"/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template name="PUBLICA">
	<input type="checkbox" name="PUBLICA">
	<xsl:choose>
		<xsl:when test="Mantenimiento/PLANTILLA/PUBLICA='S'">
	    	<xsl:attribute name="checked"></xsl:attribute>      
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="unchecked"></xsl:attribute>      
		</xsl:otherwise>
	</xsl:choose> 
	</input>
</xsl:template>

<xsl:template name="NOMBRE">
  <input type="text" size="50" name="NOMBRE" maxlength="100">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/NOMBRE"/></xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="DESCRIPCION">
  <input type="text" size="50" name="DESCRIPCION" maxlength="300">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/DESCRIPCION"/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template name="USUARIO">
 <xsl:value-of select="Mantenimiento/PLANTILLA/USUARIO"/>
</xsl:template>  

<xsl:template name="URGENCIA">
        
	  <xsl:choose>
	    <xsl:when test="Mantenimiento/PLANTILLA/SOLOURGENCIAS">
	      <font color="RED">RESERVA</font>
	      <input type="hidden" value="on" name="URGENCIA"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <input type="checkbox" name="URGENCIA">
                <xsl:choose>
	          <xsl:when test="Mantenimiento/PLANTILLA/URGENCIA='N'">
	            <xsl:attribute name="unchecked"></xsl:attribute>      
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:attribute name="checked"></xsl:attribute>      
		  </xsl:otherwise>
                </xsl:choose> 
	      </input>
	    </xsl:otherwise>
	  </xsl:choose>
</xsl:template>

<xsl:template name="CENTROS">
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="Mantenimiento/PLANTILLA/CENTROS/field">
    	</xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="CARPETAS">
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="Mantenimiento/PLANTILLA/CARPETAS/field">
    	</xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="DERECHOSACCESO">
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="Mantenimiento/PLANTILLA/DERECHOSACCESO/field">
    	</xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="FORMASPAGO">
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="Mantenimiento/PLANTILLA/FORMASPAGO/field">
    	</xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="PLAZOSPAGO">
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="Mantenimiento/PLANTILLA/PLAZOSPAGO/field">
    	</xsl:with-param>
    </xsl:call-template>
</xsl:template>


    
<xsl:template name="PL_PROGRAMADA">
    <xsl:choose>
       <xsl:when test=". ='1' ">
	  <xsl:text disable-output-escaping="yes"> <![CDATA[
	  <input type="checkbox" name="PL_PROGRAMADA" checked>
	  ]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"> <![CDATA[
	  <input type="checkbox" name="PL_PROGRAMADA">
	  ]]></xsl:text>       
       </xsl:otherwise>
    </xsl:choose>     
  <xsl:text disable-output-escaping="yes"> <![CDATA[
  </input>
  ]]></xsl:text>
</xsl:template>
  
<xsl:template name="FECHANO_ACTIVACION">
  <input type="text" name="FECHANO_ACTIVACION" size="10" maxlength="10">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
  <text>dd/mm/aaaa</text>  
</xsl:template>

<xsl:template name="PL_PERIODOACTIVACION">
  <input type="text" size="3" name="PL_PERIODOACTIVACION">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>&nbsp;dias
</xsl:template>

<xsl:template name="PL_FORMAPAGO">
  <textarea name="PL_FORMAPAGO" cols="50" rows="5">
      <xsl:value-of select="."/> 
  </textarea>
</xsl:template>

<xsl:template name="PL_CONDICIONESGENERALES">
  <textarea name="PL_CONDICIONESGENERALES" cols="50" rows="5">
      <xsl:value-of select="."/> 
  </textarea>
</xsl:template>

<xsl:template name="IDUSUARIO">
  <input type="hidden" name="IDUSUARIO">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/IDUSUARIO"/></xsl:attribute>      
  </input>
</xsl:template>


<xsl:template match="EMPRESASAUTORIZADAS">
	<!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
      
	<table class="mediaTabla">
    	<tr>
        	<td class="dies">&nbsp;</td>
            <td>
               <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_autorizadas']/node()"/></strong><br />
               <xsl:value-of select="document($doc)/translation/texts/item[@name='puede_establecer_empresas_autorizadasa']/node()"/>
            </td>
            <td>
                   <xsl:call-template name="boton">
                     <xsl:with-param name="path" select="/Mantenimiento/button[@label='EmpresasAutorizadas']"/>
                   </xsl:call-template>
            </td>
            <td class="dies">&nbsp;</td>
        </tr>
        </table>
		<xsl:if test="./EMPRESA">
	
			<table class="mediaTabla">
				<tr class="tituloTabla">
				<th colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
				</tr>
				<xsl:for-each select="./EMPRESA">
				<tr>
                    <td class="trenta" colspan="2">&nbsp;</td>
					<td class="sesanta">
	    				<xsl:value-of select="NOMBRE"/>
					</td>
                    <td class="dies">&nbsp;</td>
				</tr>
				</xsl:for-each>
			</table> 
		
	    </xsl:if>
</xsl:template>







</xsl:stylesheet>