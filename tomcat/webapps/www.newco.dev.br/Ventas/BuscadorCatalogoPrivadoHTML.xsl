<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Para proveedores: Buscador en los Catalogos Privados de MedicalVM
 |
 |	(c) 27/7/2004 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <!-- 
	<title><xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	-->
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes">
	<![CDATA[
		<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
		<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/Lista.js"></script>	
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
 		<script type="text/javascript">
		
		<!--

	var msg_SinCriterios = 'Introduzca algún criterio de busqueda antes de buscar. \nGracias.';
	var msg_DemasiadosCriteriosDefault = 'El criterio de búsqueda en el campo: \"';
	var msg_DemasiadosCriteriosExtra_1 = '\" contiene demasiadas palabras.\nEl máximo de palabras es de 5.\n\n    * Pulse \'Aceptar\' para enviar \"';
	var msg_DemasiadosCriteriosExtra_2 = '\"\n\n    * Pulse \'Cancelar\' para modificar los criterios manualmente.';
	
	
	function Linka(pag){ 
	  parent.frames['zonaTrabajo'].document.location.href=pag; 
	}
	
	function Busqueda(formu,accion)
	{
		formu.elements['PAGINA'].value=0;
     	AsignarAccion(formu,'BuscadorCatalogoPrivado.xsql');
	    	SubmitForm(formu);
	}

	// 
	// 
	// 
	function handleKeyPress(e) {
	  var keyASCII;
	  
	  if(navigator.appName.match('Microsoft'))
	    var keyASCII=event.keyCode;
	  else
            keyASCII = (e.which);
            
          if (keyASCII == 13) {
             Busqueda(document.forms[0],'BuscadorCatalogoPrivado.xsql');
          }
        }
        
	// Asignamos la función handleKeyPress al evento 
	if(navigator.appName.match('Microsoft')==false)
	  document.captureEvents();
	document.onkeypress = handleKeyPress;
	
	
	function EnviarBusqueda(){
	  if(LimitarCantidadPalabras(document.forms[0].elements['LLP_NOMBRE'],5) &&LimitarCantidadPalabras(document.forms[0].elements['LLP_CLIENTE'],5))
	    Busqueda(document.forms[0],'BuscadorCatalogoPrivado.xsql');
	}
	
	function LimitarCantidadPalabras(obj, numPalabras){
	  var nombreCampo;
	  
	   if(obj.name=='LLP_NOMBRE')
	     nombreCampo='Producto';
	   else
	     if(obj.name=='LLP_CLIENTE')
	       nombreCampo='Proveedor';
	       
	  var numEspacios=0;
	  obj.value=quitarEspacios(obj.value);
	  
	  for(var n=0;n<obj.value.length;n++){
	    if(obj.value.substring(n,n+1)==' '){
	      numEspacios++;
	    }
	    if(numEspacios>=numPalabras){
	      var cadTemp=obj.value.substring(0,n);
	      if(confirm(msg_DemasiadosCriteriosDefault+nombreCampo+msg_DemasiadosCriteriosExtra_1+cadTemp+msg_DemasiadosCriteriosExtra_2)){
	        obj.value=obj.value.substring(0,n);
	        return true;
	      }
	      else{
	        return false;
	      }
	    }
	  }
	  return true;
	}


//
//	Guarda en el campo oculto CAMBIOS el contenido de los campos editables por el usuario
//	en formato (ID, UnidadBasica, UnidadesPorLote, Precio)
//
//	y envia el formulario
//
function Enviar(formDestino, Accion)
{
	if (Accion=='ANTERIOR')		//	Guarda resultados y retrocede a la pagina anterior
	{
	  formDestino.elements['PAGINA'].value=parseInt(formDestino.elements['PAGINA'].value)-1;
	}
	else if (Accion=='SIGUIENTE')	//	Guarda resultados y avanza a la pagina siguiente
	{
	  formDestino.elements['PAGINA'].value=parseInt(formDestino.elements['PAGINA'].value)+1;
	}
	SubmitForm(formDestino); 
	    
}	

/*
 var msg_SinCriterios = 'Introduzca algún criterio de busqueda antes de buscar. \nGracias.';
	
	function Linka(pag){ 
	  parent.frames['zonaTrabajo'].document.location.href=pag; 
	}
	
	function Busqueda(formu,accion){
	  if ((formu.elements['LLP_NOMBRE'].value=='') &&
(formu.elements['LLP_CLIENTE'].value=='')) {
		alert(msg_SinCriterios);	      
	   } else {	     
	     AsignarAccion(formu,accion);
	     SubmitForm(formu);
	  }
	}

//
//	Guarda en el campo oculto CAMBIOS el contenido de los campos editables por el usuario
//	en formato (ID, UnidadBasica, UnidadesPorLote, Precio)
//
//	y envia el formulario
//
function Enviar(formDestino, Accion)
{
	if (Accion=='ANTERIOR')		//	Guarda resultados y retrocede a la pagina anterior
	{
	  formDestino.elements['PAGINA'].value=parseInt(formDestino.elements['PAGINA'].value)-1;
	}
	else if (Accion=='SIGUIENTE')	//	Guarda resultados y avanza a la pagina siguiente
	{
	  formDestino.elements['PAGINA'].value=parseInt(formDestino.elements['PAGINA'].value)+1;
	}
	SubmitForm(formDestino); 
	    
}	

     function EjecutarFuncionDelFrame(nombreFrame,idPlantilla){
	      var objFrame=new Object();
	      objFrame=obtenerFrame(top, nombreFrame);
	      objFrame.CambioPlantillaExterno(idPlantilla);
	    }

*/

		-->
		</script>
        ]]></xsl:text>
      </head>
      <body bgcolor="#FFFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
		<!-- 
			Almacena en una variable si se tiene que bloquear los enlaces 
			(necesario en la zona publica para que no puedan ver contenidos) o no
		 -->
		<xsl:variable name="Bloquear">
			<xsl:value-of select="/ProductosEnPlantillas/BloquearEnlaces"/>
		</xsl:variable>		
		<xsl:variable name="TipoAnuncio">
			<xsl:value-of select="/ProductosEnPlantillas/ANUNCIOS/TIPO"/>
		</xsl:variable>		
		<p class="tituloPag" align="center">
		Buscador de Productos adjudicados (en catálogo privado de los clientes)
		</p>
		<!--	Campos ocultos para avanzar y retroceder en la busqueda	-->
 		<form action="BuscadorCatalogoPrivado.xsql" name="Busqueda" method="POST">

     	<input type="hidden" name="LLP_ORDERBY" value="ALF"/>
     	<input type="hidden" name="TIPO_BUSQUEDA" value="RAPIDA"/>
		<br/>
		<table width="50%" cellpadding="1" cellspacing="1" bgcolor="#015E4B" border="0" align="center"><!-- class="muyoscuro"-->
		<tr bgcolor="#EEFFFF">
			<td width="*" align="center">  
				Producto:<br/>
				<input type="text" name="LLP_NOMBRE" maxlength="200" size="25">
					<xsl:attribute name="value">
						<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTOBUSCADO"/>
					</xsl:attribute>
				</input>
			</td>
			<td width="*" align="center">
				Cliente:<br/>
				<input type="text" name="LLP_CLIENTE" maxlength="200" size="25">
					<xsl:attribute name="value">
						<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/CLIENTEBUSCADO"/>
					</xsl:attribute>
				</input>
			</td>
			<xsl:choose>
     	    <xsl:when test="/BusquedaProductos/BUSCADOR/AVANZADO">
				<td width="20%" align="center">  
					Listar por:<br/>
					<select NAME="LLP_LISTAR">
						<option VALUE="PLA">Catálogo Privado</option>
						<option VALUE="PRO">Catálogo General</option>
						<option VALUE="EMP">Proveedores</option>
					</select>
				</td>
			</xsl:when>
			<xsl:otherwise>
		     	<input type="hidden" name="LLP_LISTAR" value="PLA"/>
			</xsl:otherwise>
			</xsl:choose>	
			<td width="10%" align="center" valign="middle">
				<table cellpadding="3" cellspacing="1" border="0" width="0px" class="muyoscuro">
                  <tr class="medio">
                    <td align="center">
                      <a href="javascript:EnviarBusqueda();" onMouseOver="window.status='Buscar'; return true;" onMouseOut="window.status=''; return true;">Buscar</a>
                    </td>
                  </tr>
                </table>
			</td>
		</tr>
		</table>
		<br/>

		<input type="hidden" name="PAGINA">
			<xsl:attribute name="value">
				<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINA"/>
			</xsl:attribute>
		</input>
		</form>

        <xsl:choose>
        <xsl:when test="ProductosEnPlantillas/SESION_CADUCADA">
             <xsl:apply-templates select="ProductosEnPlantillas/SESION_CADUCADA"/>            
          </xsl:when>
        <xsl:when test="ProductosEnPlantillas/LISTAPRODUCTOS/Sorry">
          <xsl:apply-templates select="ProductosEnPlantillas/LISTAPRODUCTOS/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
		
			<!--	Botones de avanzar y retroceder	-->
        	<table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" >
            	<tr><td align="left">
			<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINAANTERIOR">
        	
        	<xsl:call-template name="boton">
 	          <xsl:with-param name="path" select="/ProductosEnPlantillas/botones_nuevo/button[@label='NavegarAtras']"/>
 	        </xsl:call-template>
			</xsl:if>
	       </td>
	       <td align="right">
			<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINASIGUIENTE">
			
			<xsl:call-template name="boton">
 	                  <xsl:with-param name="path" select="/ProductosEnPlantillas/botones_nuevo/button[@label='NavegarAdelante']"/>
 	                </xsl:call-template>

			</xsl:if>
			</td></tr>
			</table>
			<br/>
			
		<table width="100%" class="blanco" cellspacing="1" cellpadding="0">
		<tr>
		<td>
		<table width="100%"><tr><td align="right">
			<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/MENSAJE"/>
			</td></tr></table>
        	<table  class="muyoscuro" width="100%" border="0" align="center" cellspacing="1" cellpadding="0">
				<!--	Cabecera de la tabla	-->
            	  <tr class="oscuro">
            	    <td colspan="9">
            	      <table width="100%" border="0" class="medio" cellspacing="1" cellpadding="1">
            	        <tr class="oscuro" cellspacing="1" cellpadding="0">
						<td width="30%" align="Center">Cliente</td>
						<td width="30%" align="Center">Marca/Fabricante</td>
						<td width="10%" align="Center">Ud.básica</td>
						<td width="15%" align="Center">Precio Privado</td>
						<td width="15%" align="Center">Ud.básica/Lote</td>
		        	  </tr>
		        	</table>
		    	  </td>
				</tr>
		
				<!--	Cuerpo de la tabla	-->
          		<xsl:for-each select="ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTO">
				<xsl:variable name="ColorPrincipal">
				<xsl:choose>
		  			<xsl:when test="position() mod 2">claro</xsl:when>
		  			<xsl:otherwise>blanco</xsl:otherwise>
	        	</xsl:choose>
				</xsl:variable>
				<xsl:variable name="ColorSecundario">
				<xsl:choose>
		  			<xsl:when test="position() mod 2">blanco</xsl:when>
		  			<xsl:otherwise>claro</xsl:otherwise>
	        	</xsl:choose>
				</xsl:variable>
				
				
            	<tr height="22px">
            	<td colspan="9">
            	  <table width="100%" cellspacing="1" cellpadding="0" class="oscuro">
            	    <tr>
            	<xsl:attribute name="class"><xsl:value-of select="$ColorPrincipal"/></xsl:attribute>
	
				  <td align="left" colspan="8">
				    <table width="100%" border="0">
				      <tr>
						<td align="left" width="*">
						<a>
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada(&#39;http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&#39;,&#39;producto&#39;,70,50,0,-50);</xsl:attribute>
						<xsl:choose>
	 						<xsl:when test="NOMBRE_PRIVADO">
								<xsl:value-of select="NOMBRE_PRIVADO"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="PRODUCTO"/>
							</xsl:otherwise>
            			</xsl:choose>
						</a>
						</td>
						<td align="right" width="15%">Ref.Cliente:&nbsp;<xsl:value-of select="REF_PRIVADA"/></td>
						<td align="right" width="15%">Ref.Proveedor:&nbsp;<xsl:value-of select="REF_PUBLICA"/></td>
						</tr>
						</table>
					</td>

				</tr>
            	<tr height="22px"><xsl:attribute name="class"><xsl:value-of select="$ColorPrincipal"/></xsl:attribute>
      
					<td align="left" width="30%">
 						<a>
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada(&#39;http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="IDCLIENTE"/>&#39;,&#39;empresa&#39;,65,58,0,-50);</xsl:attribute>
						<xsl:value-of select="CLIENTE"/></a>
					</td> 
					<td align="left" width="30%">
						<!--<xsl:value-of select="MARCA"/>-->
            			<xsl:choose>
              				<xsl:when test="MARCA!=''">
                				<xsl:value-of select="MARCA"/>
              				</xsl:when>
              				<xsl:otherwise>
               					 &nbsp;
              				</xsl:otherwise>
            			</xsl:choose>
            
           				<xsl:if test="MARCA!=FABRICANTE">   
              				<xsl:if test="MARCA!='' and FABRICANTE!=''">
                				/
              				</xsl:if>
            
            				<xsl:choose>
              					<xsl:when test="FABRICANTE!=''">
                					<xsl:value-of select="FABRICANTE"/>
              					</xsl:when>
              					<xsl:otherwise>
                				&nbsp;
              					</xsl:otherwise>
            				</xsl:choose>
          				</xsl:if>  
					</td> 
					<td align="right" width="10%">
						<xsl:value-of select="UNIDADBASICA"/>
					</td>
					<td align="right" width="15%">
						<xsl:choose>
							<xsl:when test="TARIFAPRIVADA_PTS">
								<font color="blue">
								<xsl:value-of select="TARIFAPRIVADA_EURO"/>&nbsp;<xsl:text disable-output-escaping="yes"><![CDATA[&euro;]]></xsl:text>
								</font>
							</xsl:when>
							<xsl:otherwise>
								&nbsp;
							</xsl:otherwise>
						</xsl:choose>
					</td> 
					<td align="right" width="15%">
						<xsl:value-of select="UNIDADESPORLOTE"/>
					</td>
			        </tr>
			        </table>
			        </td>
				</tr>
		  	</xsl:for-each>	    
            	<tr class="oscuro">
            	    <td colspan="9">
            	      <table width="100%" border="0" class="medio" cellspacing="1" cellpadding="1">
            	        <tr class="oscuro" cellspacing="1" cellpadding="0">
						<td width="30%" align="Center">Cliente</td>
						<td width="30%" align="Center">Marca/Fabricante</td>
						<td width="10%" align="Center">Ud.básica</td>
						<td width="15%" align="Center">Precio Privado</td>
						<td width="15%" align="Center">Ud.básica/Lote</td>
		        	  </tr>
		        	</table>
		    	  </td>
			</tr>
        	</table> 
			<br/>
      		</td>
			</tr>
      		</table>
    		<br/>
			<!--	Botones de avanzar y retroceder	-->
        	<table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" >
            	<tr><td align="left">
			<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINAANTERIOR">
        	
        	<xsl:call-template name="boton">
 	          <xsl:with-param name="path" select="/ProductosEnPlantillas/botones_nuevo/button[@label='NavegarAtras']"/>
 	        </xsl:call-template>


     <!--<center>Existen más resultados. Únicamente se presentan los 10 primeros.</center>-->
			</xsl:if>
	       </td>
	       <td align="right">
			<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINASIGUIENTE">
			
			<xsl:call-template name="boton">
 	                  <xsl:with-param name="path" select="/ProductosEnPlantillas/botones_nuevo/button[@label='NavegarAdelante']"/>
 	                </xsl:call-template>

			</xsl:if>
			</td></tr>
			</table>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  <xsl:template match="Sorry">
      <br/><br/><br/>
      <table  bgColor="#015E4B" width="80%" border="0" align="center" cellspacing="1" cellpadding="5" >
        <tr bgColor="#d0f8f7">
          <td>
          <br/>
          El producto buscado no ha sido encontrado en los Catálogos Privados de sus clientes.
          <br/>
          <br/>
          Por favor, compruebe la ortografía de su búsqueda.
          <br/><br/>
          Muchas Gracias
          <br/>
          <br/>
          </td>
        </tr>
      </table>				
  </xsl:template>
  

</xsl:stylesheet>
