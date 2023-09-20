<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 *	Contratación de Palabras Clave de MedicalVM
 *
 *	(c) 5/9/2001 ET
 *
 *	Este fichero genera una pagina HTML que permite a los usuarios contratar
 *	banners para palabras clave durante los tres meses siguientes al actual.
 *
 *	Los valores se pasan a traves de un campo Hidden "Parametros" al fichero XSQL
 *	ContratarPalabrasClaveSave.xsql en el formato:
 *
 *	(Columna|IDPalabra)(Columna|IDPalabra)...(Columna|IDPalabra)
 *
 *
 -->
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
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript">
	
	
	<!--
	/////////////////////////////////INFORMACION DEL FICHERO\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	//	Version 12/9/2001   ET, IG
	////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	  
	    function swapImagen(obj,objOculto){
			
	      //miArray=new Array[][];
	      //alert(objOculto.name+' '+objOculto.value);
	      if(obj.src=='http://www.newco.dev.br/images/reservar.gif'){
	        obj.src='http://www.newco.dev.br/images/reservado.gif';
	        aceptarReserva(objOculto);
	        return obj;
	      }
	      else{
	        obj.src='http://www.newco.dev.br/images/reservar.gif';
	        rechazarReserva(objOculto);
	        return obj;
	      }
		  
		  
	    }
	    
	    function aceptarReserva(objAInsertar){
             objAInsertar.value='1'; 
	    }
	    
	    function rechazarReserva(objAExtraer){
             objAExtraer.value='0'; 
	    }

		//	Prepara el campo hidden para ser enviado
	    function EnviarForm(formOrigen, formEnvio)
		{
		  //	Construye la cadena parametro
	      var msg='';
          for(var n=0;n<formOrigen.length;n++)
		  {
		  	//	Utiliza únicamente las palabras y los meses seleccionados
		  	if ((formOrigen.elements[n].name.substr(0,4)=='mes|')
					&&(formOrigen.elements[n].value=='1'))
			{
	        	msg=msg+'('+formOrigen.elements[n].name.substr(4,formOrigen.elements[n].name.length-4)+')';
			}
          }
		  		  
		  //	Enviar el form
		  
		  formEnvio.elements["Parametros"].value=msg;
		  SubmitForm(formEnvio);
		  
	    }
		
		//	Inicializa los campos hidden
		//	Sin esta funcion, en algunos casos la recarga no se hacia correctamente
		function Inicializar(form)
		{
	      var msg='';
          for(var n=0;n<form.length;n++)
		  {
		  	//	Utiliza únicamente las palabras y los meses seleccionados
		  	if (form.elements[n].name.substr(0,4)=='mes|')
			{
				form.elements[n].value='0';
			}
          }
		}


	  -->
	</script>
        ]]></xsl:text>
      </head>
      <body bgcolor="#FFFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff" onload="Inicializar(document.forms[0])">      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo -->
          <xsl:when test="ContratarPalabrasClave/xsql-error">
            <xsl:apply-templates select="ContratarPalabrasClave/xsql-error"/>          
          </xsl:when>
	
        <xsl:when test="ContratarPalabrasClave/ROW/Sorry">
          <xsl:apply-templates select="ContratarPalabrasClave/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        <form name="form1" action="ContratarPalabrasClaveSave.xsql" method="post" >      
          <table width="90%" border="0" align="center" cellspacing="1" cellpadding="1">
            <tr>
			
              <td width="10%"><!--<xsl:apply-templates select="//jumpTo"/>-->&nbsp;</td>
              <td align="center" width="80%">
			  <p class="tituloPag">Solicitud de reserva de Palabra Clave</p>
		<p align="left">
		-> Para solicitar la reserva de una Palabra Clave pulse el botón "Reservar"<br/>
		-> Cuando haya finalizado su selección pulse el botón "Aceptar"<br/>
		-> Recibirá por email la confirmación de la reserva<br/>
		-> Para anular una reserva, por favor, póngase en contacto con su comercial MedicalVM<br/>
		</p>
		</td>
              <td width="10%">
 				<p align="right">
 				<!--<xsl:apply-templates select="/ContratarPalabrasClave/button[@label='Aceptar']"/>-->
 				<xsl:call-template name="boton">
 				  <xsl:with-param name="path" select="/ContratarPalabrasClave/button[@label='Aceptar']"/>
 				</xsl:call-template>
 				</p>
              </td>
            </tr>
          </table>
		  <br/>
          <table width="95%" border="0" align="center" cellspacing="0" cellpadding="0" >
          
		  <tr><td>
          <table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="muyoscuro">
            <tr class="medio">
				<td width="15%" align="center">Palabra Clave</td>
				<td width="10%" align="center">Tarifa Mensual</td>
				<td width="5%" align="center">Divisa</td>
				<!--<td width="10%" align="center">Consultas<br/>(30 días)</td>-->
				<td width="20%" align="center">
				<xsl:value-of select="ContratarPalabrasClave/PALABRASCLAVE/MESES/MES_0/NOMBRE"/>
				</td>
				<td width="20%" align="center">
				<xsl:value-of select="ContratarPalabrasClave/PALABRASCLAVE/MESES/MES_1/NOMBRE"/>
				</td>
				<td width="20%" align="center">
				<xsl:value-of select="ContratarPalabrasClave/PALABRASCLAVE/MESES/MES_2/NOMBRE"/>
				</td>
			</tr>
            <!--<tr bgColor="#a0d8d7">
				<td width="15%" align="center">&nbsp;</td>
				<td width="10%" align="center">(Pesetas/Mes)</td>
				<td width="5%" align="center">&nbsp;</td>
				<td width="10%" align="center">(30 días)</td>
				<td width="15%" align="center">
				&nbsp;
				</td>
				<td width="15%" align="center">
				&nbsp;
				</td>
				<td width="15%" align="center">
				&nbsp;
				</td>
			</tr>-->
            <!--<tr bgColor="#a0d8d7"><td colspan="8">&nbsp;</td></tr>-->
          <xsl:for-each select="ContratarPalabrasClave/PALABRASCLAVE/PALABRACLAVE">
            <tr class="blanco">
				<td width="15%" align="left"  class="medio">
					<xsl:value-of select="PALABRA"/>
				</td>
				<td width="10%" align="center">
					<xsl:value-of select="PRECIO"/>
				</td>
				<td width="5%" align="center">
					<xsl:value-of select="DIVISA"/>
				</td>
				<!--
				<td width="10%" align="center">
					<xsl:value-of select="APARICIONES"/>
				</td>
				-->
				<!--
				<td width="15%" align="left">&nbsp;</td>
				-->
				<!--	Version antigua del codigo
				<td width="20%" align="center">
				  <xsl:choose>
				    <xsl:when test="MES_0/PROPIETARIO">
				      <xsl:copy-of select="MES_0"/>
				    </xsl:when>
				    <xsl:otherwise>
				      <xsl:apply-templates select="MES_0"/>
				    </xsl:otherwise>
				  </xsl:choose>
				</td>
				<td width="20%" align="center">
				  <xsl:choose>
				    <xsl:when test="MES_1/PROPIETARIO">
				      <xsl:copy-of select="MES_1"/>
				    </xsl:when>
				    <xsl:otherwise>
				      <xsl:apply-templates select="MES_1"/>
				    </xsl:otherwise>
				  </xsl:choose>
				</td>
				<td width="20%" align="center">
				  <xsl:choose>
				    <xsl:when test="MES_2/PROPIETARIO">
				      <xsl:copy-of select="MES_2"/>
				    </xsl:when>
				    <xsl:otherwise>
				      <xsl:apply-templates select="MES_2"/>
				    </xsl:otherwise>
				  </xsl:choose>
				</td>
				-->
				<td width="20%" align="center">
				      <xsl:copy-of select="MES_0/PROPIETARIO"/>
				</td>
				<td width="20%" align="center">
				      <xsl:copy-of select="MES_1/PROPIETARIO"/>
				</td>
				<td width="20%" align="center">
				      <xsl:copy-of select="MES_2/PROPIETARIO"/>
				</td>
				
			</tr>
		  </xsl:for-each>	    
          </table> 
		  </td></tr>
		  </table>
          <table width="90%" border="0" align="center" cellspacing="0" cellpadding="0">
            <tr>
              <td width="25%">&nbsp;<!--<xsl:apply-templates select="//jumpTo"/>--></td>
              <td width="50%">&nbsp;</td>
              <td width="25%">
              <br/><br/>
 				<p align="right">
 				  <!--<xsl:apply-templates select="/ContratarPalabrasClave/button[@label='Aceptar']"/>-->
 				  <xsl:call-template name="boton">
 				    <xsl:with-param name="path" select="/ContratarPalabrasClave/button[@label='Aceptar']"/>
 				  </xsl:call-template>
 				  </p>
              </td>
            </tr>
          </table>
		  
		  <br/><br/>
          
	  </form>
	  <!-- Campo oculto con los parametros de la llamada		-->
      <form name="form2" action="ContratarPalabrasClaveSave.xsql" method="post" >
		<input type="hidden" name="Parametros" value=""/>
	  </form>
      </xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  <xsl:template match="MES_0">
    
    <xsl:element name="input">
      <xsl:attribute name="type">hidden</xsl:attribute>
	  <!--
      <xsl:attribute name="name">mes|<xsl:value-of select="//MES_0/NUMERO"/>|<xsl:value-of select="../ID"/></xsl:attribute>
	  -->
      <xsl:attribute name="name">mes|0|<xsl:value-of select="../ID"/></xsl:attribute>
      <xsl:attribute name="value">0</xsl:attribute>
    </xsl:element>
    
    
    <xsl:element name="img" >
      <xsl:attribute name="border">0</xsl:attribute>
      <xsl:attribute name="width">64</xsl:attribute>
      <xsl:attribute name="height">32</xsl:attribute>
      <xsl:attribute name="src">http://www.newco.dev.br/images/reservar.gif</xsl:attribute>
      <xsl:attribute name="onClick">swapImagen(this,document.forms[0].elements['mes|0|<xsl:value-of select="../ID"/>']);</xsl:attribute>
    </xsl:element>
    
  </xsl:template>
  
  <xsl:template match="MES_1">
    <xsl:element name="input">
      <xsl:attribute name="type">hidden</xsl:attribute>
	  <!--
      <xsl:attribute name="name">mes|<xsl:value-of select="//MES_1/NUMERO"/>|<xsl:value-of select="../ID"/></xsl:attribute>
	  -->
      <xsl:attribute name="name">mes|1|<xsl:value-of select="../ID"/></xsl:attribute>
      <xsl:attribute name="value">0</xsl:attribute>
    </xsl:element>
    
    
    <xsl:element name="img">
      <xsl:attribute name="border">0</xsl:attribute>
      <xsl:attribute name="width">64</xsl:attribute>
      <xsl:attribute name="height">32</xsl:attribute>
      <xsl:attribute name="src">http://www.newco.dev.br/images/reservar.gif</xsl:attribute>
      <xsl:attribute name="onClick">swapImagen(this,document.forms[0].elements['mes|1|<xsl:value-of select="../ID"/>']);</xsl:attribute>
    </xsl:element>
  </xsl:template>
  
  
  
  
  <xsl:template match="MES_2">
    <xsl:element name="input">
      <xsl:attribute name="type">hidden</xsl:attribute>
	  <!--
      <xsl:attribute name="name">mes|<xsl:value-of select="//MES_2/NUMERO"/>|<xsl:value-of select="../ID"/></xsl:attribute>
	  -->
      <xsl:attribute name="name">mes|2|<xsl:value-of select="../ID"/></xsl:attribute>
      <xsl:attribute name="value">0</xsl:attribute>
    </xsl:element>
    
    
    <xsl:element name="img">
      <xsl:attribute name="border">0</xsl:attribute>
      <xsl:attribute name="width">64</xsl:attribute>
      <xsl:attribute name="height">32</xsl:attribute>
      <xsl:attribute name="src">http://www.newco.dev.br/images/reservar.gif</xsl:attribute>
	  <!--
      <xsl:attribute name="onClick">swapImagen(this,document.forms[0].elements['mes|<xsl:value-of select="//MES_2/NUMERO"/>|<xsl:value-of select="../ID"/>']);</xsl:attribute>
	  -->
      <xsl:attribute name="onClick">swapImagen(this,document.forms[0].elements['mes|2|<xsl:value-of select="../ID"/>']);</xsl:attribute>
    </xsl:element>
  </xsl:template>
  
  
  
  
  <!--
  <xsl:template match="PROPIETARIO">
  
    <xsl:param name="elMes"/>
    
    <xsl:element name="input">
      <xsl:attribute name="type">hidden</xsl:attribute>
      <xsl:attribute name="name"><xsl:value-of select="$elMes"/>|<xsl:value-of select="ContratarPalabrasClave/PALABRASCLAVE/PALABRACLAVE/PALABRA"/></xsl:attribute>
      <xsl:attribute name="value"><xsl:value-of select="$elMes"/>|<xsl:value-of select="ContratarPalabrasClave/PALABRASCLAVE/PALABRACLAVE/PALABRA"/></xsl:attribute>
    </xsl:element>
    
    
    <xsl:element name="img">
      <xsl:attribute name="border">0</xsl:attribute>
      <xsl:attribute name="src">http://www.newco.dev.br/images/reservar.gif</xsl:attribute>
      <xsl:attribute name="onClick">swapImagen(this,document.forms[0].elements['<xsl:value-of select="$elMes"/><xsl:value-of select="ContratarPalabrasClave/PALABRASCLAVE/PALABRACLAVE/PALABRA"/>']);</xsl:attribute>
    </xsl:element>
      
  </xsl:template>
	-->

</xsl:stylesheet>
