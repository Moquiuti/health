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
      <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	
        <script type="text/javascript">
        <!--
        
        
         msgAfectaUsuarioPropietario='No se pueden quitar los derechos de acceso al propietario de la carpeta.';
         msgSinCarpeta='Ha de guardar la nueva carpeta antes de poder autorizar empresas a usarla.';
       
        ]]></xsl:text> 
     
 
     
     var idUsuarioPropietario='<xsl:value-of select="/Mantenimiento/CARPETA/IDUSUARIO"/>';
     
      
     
     <xsl:choose>
       <xsl:when test="/Mantenimiento/CARPETA/EDICION">
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
          
          arrayUsuarios=new Array(<xsl:value-of select="count(/Mantenimiento/CARPETA/DERECHOSPORUSUARIO/CENTRO)"/>);

          <xsl:for-each select="/Mantenimiento/CARPETA/DERECHOSPORUSUARIO/CENTRO">
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
           saber que accion tiene que realizar dar o quitar privilegios cuando se pulse
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
        
        
        /*
        
          si es un check de usuario recibe la acion LECT / ESCR, el ID de usuario, y a quien afecta 'ESTE'   
          si es un link (Todos) recibe la accion LECT / ESCR, el ID del centro, y a quien afecta 'TODOS'
        
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
        
        function Actua(formu)
		{
			var Cadena='';
		
			if (validaNombre(formu)==true) 
			{

				//	Construye la cadena con los derechos de los usuarios
  				for (j=0;j<formu.elements.length;j++)
				{
					if (formu.elements[j].name.substring(0,10)=='USUARIO_ID')
					{
					
						
						
						Cadena=Cadena	+formu.elements[j].value+'|'
										+(formu.elements['LECT_'+formu.elements[j].value].checked==true?'S':'N')+'|'
										+(formu.elements['ESCR_'+formu.elements[j].value].checked==true?'S':'N')+'#';
					}
				}			 

				//	Guarda la cadena de derechos en el campo asignado
				formu.elements['DERECHOS'].value=Cadena;
            	SubmitForm(formu);  
          	}            
        }
        
        function validaNombre(formu){
          if (formu.elements['NOMBRE'].value==""){
            alert(' ]]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0280' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[');
            formu.elements['NOMBRE'].focus();
            return false;
          }
          else return true;
        }
        
        function EmpresasAutorizadas(){
          
          var form=document.forms[0];
          
          if(form.elements['ID'].value==0){
            alert(msgSinCarpeta);
          }
          else{
            var opciones='?CARP_ID='+ form.elements['ID'].value;
			
            MostrarPag('http://www.newco.dev.br/Compras/NuevaMultioferta/CARPEmpresasAutorizadas.xsql'+opciones,'empresasAutorizadas');      
          }
        }
        
        
        //-->
        </script>
        ]]></xsl:text>
      </head>

      <body bgcolor="#FFFFFF" onLoad="inicializarDerechosPorUsuario(document.forms[0]);">
        <xsl:choose>
          <xsl:when test="Mantenimiento/SESION_CADUCADA">
             <xsl:apply-templates select="Mantenimiento/SESION_CADUCADA"/>            
          </xsl:when>
          <xsl:when test="Mantenimiento/CARPETA/EDICION">
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
<form>
    <xsl:attribute name="name">form1</xsl:attribute>
    <!--<xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>-->
    <xsl:attribute name="action">CARPMantenSave.xsql</xsl:attribute>
    <xsl:attribute name="method">post</xsl:attribute>
    <xsl:call-template name="ID"/>
    <xsl:call-template name="IDEMPRESA"/>
    <input type="hidden" name="DERECHOS" value=""/>
    
    <!--
     |  Cuando generamos una CARPETA no dejamos modificar el nombre ni la descripción 
     |  de la CARPETA. Los copiamos en campos ocultos para que se copien en la lista
     |  de productos.
     +-->
    <xsl:if test="Mantenimiento/BOTON[.='Generar']">
      <input type="hidden" name="CARP_NOMBRE" value="{CARP_NOMBRE}" />
      <input type="hidden" name="CARP_DESCRIPCION" value="{CARP_DESCRIPCION}"/>
    </xsl:if>
    
  <table class="infoTable">	    
    <tr class="grisclaro">      
      <td colspan="4">
       
	<xsl:choose>
	  <xsl:when test="Mantenimiento/BOTON[.='Generar']">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0162' and @lang=$lang]" disable-output-escaping="yes"/>      
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0162' and @lang=$lang]" disable-output-escaping="yes"/> 
          </xsl:otherwise>
        </xsl:choose>
     
      </td>
    </tr>
    <tr class="blanco"><td colspan="4">&nbsp;</td></tr>
	<xsl:if test="Mantenimiento/CARPETA/ADMINISTRADORMVM">
    <tr class="grisclaro"> 
      <td class="labelRight cinquenta">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0286' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td colspan="3">
	  	<xsl:call-template name="PUBLICA"/>          
      </td>
    </tr>
	</xsl:if>
    <tr class="blanco"> 
      <td width="20%" nowrap="nowrap" class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0170' and @lang=$lang]" disable-output-escaping="yes"/>:<span class="camposObligatorios">*</span>
        </td>
      <td colspan="3" width="80%" nowrap="nowrap">
            <xsl:call-template name="NOMBRE"/>
        </td>
    </tr>	
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0180' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td colspan="3">
            <xsl:call-template name="DESCRIPCION"/>
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0200' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td colspan="3">
        <xsl:choose>
          <xsl:when test="Mantenimiento/CARPETA/CENTRALCOMPRAS">
            <xsl:call-template name="desplegable">
              <xsl:with-param name="path" select="Mantenimiento/CARPETA/USUARIOS/field"/>
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
      <xsl:when test="Mantenimiento/CARPETA/CENTRALCOMPRAS">
        <!--<tr class="blanco"> 
          <td class="claro" align="right">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0190' and @lang=$lang]" disable-output-escaping="yes"/>:
            </td>
          <td colspan="3">
	    <xsl:call-template name="CENTROS"/>                        
          </td>
        </tr>	
        <tr class="blanco"> 
          <td class="claro" align="right">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0205' and @lang=$lang]" disable-output-escaping="yes"/>:
          </td>
          <td colspan="3">
	    <xsl:call-template name="DERECHOSACCESO"/>          
          </td>
        </tr>-->
        <input type="hidden" name="{Mantenimiento/CARPETA/CENTROS/field/@name}" value="{Mantenimiento/CARPETA/CENTROS/field/@current}"/>
        <input type="hidden" name="{Mantenimiento/CARPETA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/CARPETA/DERECHOSACCESO/field/@current}"/>
      </xsl:when>
      <xsl:otherwise>
        <input type="hidden" name="{Mantenimiento/CARPETA/CENTROS/field/@name}" value="{Mantenimiento/CARPETA/CENTROS/field/@current}"/>
        <input type="hidden" name="{Mantenimiento/CARPETA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/CARPETA/DERECHOSACCESO/field/@current}"/>
      </xsl:otherwise>        
    </xsl:choose>
	<!--	Derechos de acceso a la CARPETA para cada usuario		-->
	<tr> 
		<td class="blanco" colspan="4"><br/><br/>
		<table width="70%" cellspacing="1" cellpadding="1" class="muyoscuro" align="center">
		<tr class="medio">
		  <td align="center" width="50%">
		    Derechos de acceso a la carpeta
		  </td>
		  <td align="center"  width="25%">
		       <xsl:call-template name="botonPersonalizado">
	  	          <xsl:with-param name="label">Todos</xsl:with-param>
	  	          <xsl:with-param name="funcion">validacionEscrituraLectura('LECT',-1,'EMPRESA',document.forms[0]);</xsl:with-param>
	  	          <xsl:with-param name="status">Asignar derechos lectura a toda la empresa</xsl:with-param>
	  	        </xsl:call-template>
	  	        
	  	        <input type="hidden">							
		              <xsl:attribute name="name">LECT_EMPRESA</xsl:attribute>
		              <xsl:attribute name="value">false</xsl:attribute>
		            </input>
	  	        
	  	        
		</td>
		<td align="center" width="25%">
			<xsl:call-template name="botonPersonalizado">
	  	          <xsl:with-param name="label">Todos</xsl:with-param>
	  	          <xsl:with-param name="funcion">validacionEscrituraLectura('ESCR',-1,'EMPRESA',document.forms[0]);</xsl:with-param>
	  	          <xsl:with-param name="status">Asignar derechos lectura a toda la empresa</xsl:with-param>
	  	        </xsl:call-template>
	  	        
	  	        <input type="hidden">							
		              <xsl:attribute name="name">ESCR_EMPRESA</xsl:attribute>
		              <xsl:attribute name="value">false</xsl:attribute>
		            </input>
		</td>
		</tr>
		<tr class="medio">
			<td width="50%" align="center">Nombre</td>
			<td width="25%" align="center">Lectura</td>
			<td width="25%" align="center">Escritura</td>
		</tr>
	  	<xsl:for-each select="Mantenimiento/CARPETA/DERECHOSPORUSUARIO/CENTRO">
			<input type="hidden">
					<xsl:attribute name="name">CENTRO_ID_<xsl:value-of select="ID"/></xsl:attribute>
    				<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>      
 				</input>
			<tr class="claro">
			  <td>
	                    <xsl:value-of select="./NOMBRE"/>
			  </td>
			  <td align="center" valign="center">
			    <input type="hidden">							
		              <xsl:attribute name="name">LECT_TODOS_<xsl:value-of select="ID"/></xsl:attribute>
		              <xsl:attribute name="value">false</xsl:attribute>
		            </input>
			    <a href="javascript:validacionEscrituraLectura('LECT',{ID},'TODOS',document.forms[0]);">
			      Todos							
			    </a>
			  </td>
			  <td align="center" valign="center">
			    <input type="hidden">							
		              <xsl:attribute name="name">ESCR_TODOS_<xsl:value-of select="ID"/></xsl:attribute>
		              <xsl:attribute name="value">false</xsl:attribute>
		            </input>
	                    <a href="javascript:validacionEscrituraLectura('ESCR',{ID},'TODOS',document.forms[0]);">
			      Todos							
			    </a>
			  </td>
			</tr>
	  		<xsl:for-each select="./USUARIO">
  				<input type="hidden">
					<xsl:attribute name="name">USUARIO_ID_<xsl:value-of select="ID"/></xsl:attribute>
    				<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>      
 				</input>
				<tr class="blanco">
					<td><xsl:value-of select="./NOMBRE"/></td>
					<td align="center"><input type="checkbox">							
						<xsl:attribute name="name">LECT_<xsl:value-of select="ID"/></xsl:attribute>
						<xsl:attribute name="onClick">validacionEscrituraLectura('LECT',<xsl:value-of select="ID"/>,'ESTE',document.forms[0]);</xsl:attribute>
	    				<xsl:choose>
	    				    <!-- lo marcamos como activo si tiene derechos o es nueva y es el propietario -->
	      					<xsl:when test="./LECTURA='S' or (/Mantenimiento/CARPETA/@ID='' and /Mantenimiento/CARPETA/IDUSUARIO=ID)">
								<xsl:attribute name="checked">
								</xsl:attribute>
	      					</xsl:when>
	      					<xsl:otherwise>
								<xsl:attribute name="unchecked">
								</xsl:attribute>
	      					</xsl:otherwise>
	    				</xsl:choose>
					</input></td>
					<td align="center"><input type="checkbox">							
						<xsl:attribute name="name">ESCR_<xsl:value-of select="ID"/></xsl:attribute>
						<xsl:attribute name="onClick">validacionEscrituraLectura('ESCR',<xsl:value-of select="ID"/>,'ESTE',document.forms[0]);</xsl:attribute>
	    				<xsl:choose>
	      					<xsl:when test="./ESCRITURA='S' or (/Mantenimiento/CARPETA/@ID='' and /Mantenimiento/CARPETA/IDUSUARIO=ID)">
								<xsl:attribute name="checked">
								</xsl:attribute>
	      					</xsl:when>
	      					<xsl:otherwise>
								<xsl:attribute name="unchecked">
								</xsl:attribute>
	      					</xsl:otherwise>
	    				</xsl:choose>
					</input></td>
				</tr>
	  		</xsl:for-each>  
	  	</xsl:for-each>  
		</table><br/><br/>
		</td>
    </tr>   
    <xsl:if test="Mantenimiento/CARPETA/ADMINISTRADORMVM">
    <tr class="grisclaro"> 
		<td align="center" colspan="4">
        	<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0286' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
    </tr>
    <tr class="blanco"> 
		<td align="center" colspan="4">
			<xsl:apply-templates select="Mantenimiento/CARPETA/EMPRESASAUTORIZADAS"/>          
        </td>
    </tr>
	</xsl:if>
    <tr valign="bottom" class="blanco" height="40px">
      <td colspan="4">
        <table width="90%" align="center">
          <tr align="center" valign="bottom">     
	     <xsl:choose>
	      <xsl:when test="Mantenimiento/BOTON[.='CABECERA']">
	              <td>  
		        <xsl:call-template name="boton">
	                  <xsl:with-param name="path" select="Mantenimiento/button[@label='Cancelar']"/>
	                </xsl:call-template> 
		      </td>
		      <td colspan="2" width="80%">&nbsp;</td>      
		      <td> 
		        <xsl:call-template name="boton">
	          <xsl:with-param name="path" select="Mantenimiento/button[@label='Aceptar']"/>
	        </xsl:call-template>
		      </td>	
	      </xsl:when>
	      <xsl:otherwise>
		      <td>  
		        <xsl:call-template name="boton">
	                  <xsl:with-param name="path" select="Mantenimiento/button[@label='Cancelar']"/>
	                </xsl:call-template> 
		      </td>
		      <td colspan="2" width="80%">&nbsp;</td>      
		      <td> 
		        <xsl:call-template name="boton">
	          <xsl:with-param name="path" select="Mantenimiento/button[@label='Aceptar']"/>
	        </xsl:call-template>
		      </td>
	      </xsl:otherwise>
	     </xsl:choose> 
          </tr>
        </table>      
      </td>
    </tr>
  </table>
</form>
</xsl:template>


<xsl:template name="MantenimientoReadOnly">
<form>
    <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
    <!--<xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>-->
    <xsl:attribute name="action">CARPMantenSave.xsql</xsl:attribute>
    <xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute>
    <xsl:call-template name="ID"/>
    <xsl:call-template name="IDEMPRESA"/>
    <xsl:call-template name="IDUSUARIO"/>
    <!--
     |  Cuando generamos una CARPETA no dejamos modificar el nombre ni la descripción 
     |  de la CARPETA. Los copiamos en campos ocultos para que se copien en la lista
     |  de productos.
     +-->
    <xsl:if test="Mantenimiento/BOTON[.='Generar']">
      <input type="hidden" name="CARP_NOMBRE" value="{CARP_NOMBRE}" />
      <input type="hidden" name="CARP_DESCRIPCION" value="{CARP_DESCRIPCION}"/>
    </xsl:if>
    
  <table width="100%" border="0" cellspacing="1" cellpadding="2" class="muyoscuro">	    
    <tr class="oscuro">      
      <td colspan="4">
        <table width="100%" border="0" cellspacing="1" cellpadding="0">
          <tr>       
           <td>
	<xsl:choose>
	  <xsl:when test="Mantenimiento/BOTON[.='Generar']">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0162' and @lang=$lang]" disable-output-escaping="yes"/>      
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0162' and @lang=$lang]" disable-output-escaping="yes"/> 
          </xsl:otherwise>
        </xsl:choose>
      </td>
      </tr>
      </table>
      </td>
    </tr>
    <tr class="blanco"><td colspan="4">&nbsp;</td></tr>
    <tr class="blanco"> 
      <td width="20%" nowrap="nowrap" class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0170' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td colspan="3" width="80%" nowrap="nowrap">
            <xsl:value-of select="Mantenimiento/CARPETA/NOMBRE"/>
        </td>
    </tr>	
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0180' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td colspan="3">
            <xsl:value-of select="Mantenimiento/CARPETA/DESCRIPCION"/>
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0200' and @lang=$lang]" disable-output-escaping="yes"/>:
        </td>
      <td colspan="3">
            <xsl:value-of select="Mantenimiento/CARPETA/USUARIO"/>
      </td>
    </tr>
    <xsl:choose>
      <xsl:when test="Mantenimiento/CARPETA/CENTRALCOMPRAS">
        <!--<tr class="blanco"> 
          <td class="claro" align="right">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0190' and @lang=$lang]" disable-output-escaping="yes"/>:
            </td>
          <td colspan="3"> 
  	    <xsl:for-each select="Mantenimiento/CARPETA/CENTROS/field/dropDownList/listElem">
              <xsl:if test="ID=../../@current">
	        <xsl:value-of select="listItem"/>  
   	      </xsl:if>
 	    </xsl:for-each>                        
          </td>
        </tr>	
        <tr class="blanco"> 
          <td class="claro" align="right">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CARP-0205' and @lang=$lang]" disable-output-escaping="yes"/>:
            </td>
          <td colspan="3">
            <xsl:for-each select="Mantenimiento/CARPETA/DERECHOSACCESO/field/dropDownList/listElem">
              <xsl:if test="ID=../../@current">
	        <xsl:value-of select="listItem"/> 
	      </xsl:if>
	    </xsl:for-each>         
          </td>
        </tr>-->
        <input type="hidden" name="{Mantenimiento/CARPETA/CENTROS/field/@name}" value="{Mantenimiento/CARPETA/CENTROS/field/@current}"/>
        <input type="hidden" name="{Mantenimiento/CARPETA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/CARPETA/DERECHOSACCESO/field/@current}"/>
      </xsl:when>
      <xsl:otherwise>
        <input type="hidden" name="{Mantenimiento/CARPETA/CENTROS/field/@name}" value="{Mantenimiento/CARPETA/CENTROS/field/@current}"/>
        <input type="hidden" name="{Mantenimiento/CARPETA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/CARPETA/DERECHOSACCESO/field/@current}"/>
      </xsl:otherwise>
    </xsl:choose>        
    <tr valign="bottom" class="blanco" height="40px">
      <td colspan="4">
        <table width="90%" align="center">
          <tr align="center" valign="bottom">     
	     <xsl:choose>
	      <xsl:when test="Mantenimiento/BOTON[.='CABECERA']">
	      <td colspan="4">
	        <xsl:call-template name="boton">
	          <xsl:with-param name="path" select="Mantenimiento/button[@label='AceptarReadOnly']"/>
	        </xsl:call-template>
	      </td>	
	      </xsl:when>
	      <xsl:otherwise>      
		      <td> 
		        <xsl:call-template name="boton">
	          <xsl:with-param name="path" select="Mantenimiento/button[@label='AceptarReadOnly']"/>
	        </xsl:call-template>
		      </td>
	      </xsl:otherwise>
	     </xsl:choose> 
          </tr>
        </table>      
      </td>
    </tr>
  </table>
</form>
</xsl:template>


<!-- Campos ocultos -->

<xsl:template name="ID">
  <input type="hidden" name="ID">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/CARPETA/ID"/> </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="IDEMPRESA">
  <input type="hidden" name="IDEMPRESA">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/CARPETA/IDEMPRESA"/> </xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="CENTROS">
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="Mantenimiento/CARPETA/CENTROS/field">
    	</xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="DERECHOSACCESO">
	<xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="Mantenimiento/CARPETA/DERECHOSACCESO/field">
    	</xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="IDUSUARIO">
  <input type="hidden" name="IDUSUARIO">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/CARPETA/IDUSUARIO"/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template name="USUARIO">
  <xsl:value-of select="Mantenimiento/CARPETA/USUARIO"/>
</xsl:template>

<xsl:template name="PUBLICA">
	<input type="checkbox" name="PUBLICA">
	<xsl:choose>
		<xsl:when test="Mantenimiento/CARPETA/PUBLICA='S'">
	    	<xsl:attribute name="checked"></xsl:attribute>      
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="unchecked"></xsl:attribute>      
		</xsl:otherwise>
	</xsl:choose> 
	</input>
</xsl:template>

<xsl:template name="NOMBRE">
  <input type="text" size="70" name="NOMBRE" maxlength="100">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/CARPETA/NOMBRE"/></xsl:attribute>      
  </input>
</xsl:template>  

<xsl:template name="DESCRIPCION">
  <input type="text" size="70" name="DESCRIPCION" maxlength="1000">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/CARPETA/DESCRIPCION"/></xsl:attribute>      
  </input>
</xsl:template>  


<xsl:template match="EMPRESASAUTORIZADAS">
	<table width="90%" align="center" class="gris" cellpadding="0" cellspacing="1">
    	<tr class="grisClaro">
        <td>
        <table width="100%">
        	<tr>
            <td align="left">
                    <b>Empresas autorizadas</b>
                    <br/>
                    <i>Puede establecer las empresas autorizadas a utilizar esta carpeta pulsando el botón "Empresas Autorizadas"</i>
            </td>
            <td align="right">
                   <xsl:call-template name="boton">
                     <xsl:with-param name="path" select="/Mantenimiento/button[@label='EmpresasAutorizadas']"/>
                   </xsl:call-template>
            </td>
            </tr>
		</table>
        </td>
        </tr>
		<xsl:if test="./EMPRESA">
		<tr class="claro">
        <td class="blanco">
          
            <br/>
            <br/>
			<table width="100%" class="medio" align="center" cellpadding="1" cellspacing="1">
				<tr class="oscuro" align="center">
				<td>
              	Empresa
				</td>
				</tr>

				<xsl:for-each select="./EMPRESA">
          
				<tr class="claro" align="center">
				<td align="left">
				<table width="100%">
					<tr>
					<td width="20%"  align="center">
				<!--
              		<xsl:call-template name="botonPersonalizado">
	      			<xsl:with-param name="funcion">BorrarEmpresa(document.forms[0],'<xsl:value-of select="ID"/>');</xsl:with-param>
	      			<xsl:with-param name="label">Eliminar</xsl:with-param>
	      			<xsl:with-param name="status">Eliminar empresa</xsl:with-param>
					</xsl:call-template>
					-->
					</td>
					<td width="80%"  align="left">
	    				&nbsp;&nbsp;<xsl:value-of select="NOMBRE"/>
					</td>
					</tr>
				</table>
				</td>
				</tr>
				</xsl:for-each>
			</table> 
		</td>
    	</tr>
	    </xsl:if>
	</table> 
</xsl:template>



</xsl:stylesheet>