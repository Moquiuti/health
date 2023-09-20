<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 |	Responder a un anuncio para el Tablón de Anuncios de MedicalVM
 |	
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:import href = "http://www.newco.dev.br/TablonAnuncios/FichaAnuncio.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Anuncio</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>
		
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
        <!--

var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';

function validarFormulario(form){

 
  for(var n=0;n<form.length;n++){
      switch (n){
	  
	case 0:// Explicacion
		   var error='El campo \'Texto\' esta vacío pero es obligatorio.';
		  if(validarNoNulo(form.elements[n])==false){
			msgError=error+msgErrorStd;
			return false;
		  }
		  break;
		  	  
		}//switch
  }//for  
  return true;
}
//---------declaracion-funciones--------------------------------------	  
function validarNoNulo(obj){
  if(obj.value=="")
    return false
  else
    return true;
}

function validarEsCaracter(obj){
   var cadena=obj.value.toLowerCase();
   for(var n=0;n<cadena.length;n++){
     var car=cadena.substring(n,n+1);
     if((car>='0') && (car<='9'))
       return false;  
   }	
  return true;
}

function validarEsEntero(obj){

  var error=0;
  
  for(var n=0;n<obj.value.length;n++){
    var car=obj.value.substring(n,n+1);
    if((car<"0") || ("9"<car))
      error=1;   
  }	
  if (error==1){
    return false;
  }
  else
    return true;
}

function validarEsMail(obj){
   var cadena=obj.value.toLowerCase();
     for(var n=0;n<cadena.length;n++){
       var car=cadena.substring(n,n+1);
       if(car=='@')
         return true;   
     }	
  return false;
}

function validarTextoNoNulo(obj){
  if(validarNoNulo(obj)==true)
    return validarEsCaracter(obj);		
  else 
    return false;
}

function validarNumericoNoNulo(obj){
  if(validarNoNulo(obj)==true)
    return validarEsEntero(obj);		
  else 
    return false;
}

function validarLongitud(obj, longitud){
  if(obj.value.length==longitud)
    return true;		
  else 
    return false;
}

-->
	</script>
        ]]></xsl:text>
</head>  
	<xsl:choose>
		<xsl:when test="//xsql-error"> 
			<P class="tituloform">     
			<xsl:apply-templates select="//xsql-error"/>
			</P>
		</xsl:when>
		<xsl:otherwise>

			<body bgColor="#ffffff" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0"><br/>
			<!--	en principio ya no necesitamos esta variable
			<xsl:variable name="TipoAnuncio">
				<xsl:value-of select="RespuestasAnuncio/ANUNCIO/TIPO"/>
			</xsl:variable>		
			-->

			<br/>

			<!--	Presenta el anuncio		-->
			<xsl:apply-templates select="RespuestasAnuncio/ANUNCIO"/>

			<!--	Si existe alguna respuesta presenta tambien estas		-->
			<xsl:if test="RespuestasAnuncio/ANUNCIO/RESPUESTAS/RESPUESTA">
				<xsl:apply-templates select="RespuestasAnuncio/ANUNCIO/RESPUESTAS"/>
			</xsl:if>
			<br/><br/>
	<table width="75%" border="0" align="center" cellspacing="1" cellpadding="3">
	  <tr align="center">
	    <td>
	      <xsl:call-template name="botonPersonalizado">
	        <xsl:with-param name="funcion">window.close();</xsl:with-param>
	        <xsl:with-param name="label">Volver</xsl:with-param>
	        <xsl:with-param name="status">Volver</xsl:with-param>
	        <xsl:with-param name="ancho">120px</xsl:with-param>
	        <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	        <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	      </xsl:call-template> 
	    </td>
	  </tr>
	</table>	

		</body>


		</xsl:otherwise>
	</xsl:choose>
</html>
</xsl:template>
 
 
<xsl:template match="RESPUESTAS">
<br/>
<br/>
<br/>
  	<table width="75%" border="0" align="center" cellspacing="1" cellpadding="3" class="oscuro">
		<tr bgColor="#a0d8d7"><td align="center">
		.........::::::: Respuestas al Anuncio :::::::......... 
		</td></tr>
		<tr bgColor="#EEFFFF"><td>
		<xsl:for-each select="RESPUESTA">
 		<table width="100%" border="0" align="center" cellspacing="3" cellpadding="1" >
	    <tr>
	  	<td> 
        	<table border="0" width="100%" cellspacing="1" cellpadding="3" class="oscuro">
            <tr>
				<td width="30%" align="left" class="claro">
					Fecha de respuesta:
				</td>
				<td width="70%" align="left" class="blanco">
					<xsl:value-of select="FECHA"/>
				</td>
			</tr>
            <tr>
				<td width="30%" align="left" class="claro">
					Respuesta de:
				</td>
				<td width="70%" align="left" class="blanco">
					<a   onMouseOver="window.status='Ver Anuncio';return true;" onMouseOut="window.status='';return true;">
					<xsl:attribute name="href">javascript:MostrarPag('./Contacto.xsql?IDRespuesta=<xsl:value-of select="ID"/>','Contacto')
					</xsl:attribute>
						<xsl:value-of select="EMPRESA"/>
					</a>
				</td>
			</tr>
            <tr> 
				<td width="30%" align="left" class="claro">
					Comentarios:
				</td>
				<td width="70%" align="left" class="blanco">
					<xsl:copy-of select="EXPLICACION"/>
				</td>
			</tr>
    		<tr> 
				<td align="center" class="claro" colspan="2">
					<table align="center" cellspacing="1" cellpadding="2" class="oscuro">
						<tr class="blanco"><td>
						<a   onMouseOver="window.status='Ver Anuncio';return true;" onMouseOut="window.status='';return true;">
						<xsl:attribute name="href">javascript:MostrarPag('./Contacto.xsql?IDRespuesta=<xsl:value-of select="ID"/>','Contacto')
						</xsl:attribute>
							Ver Contacto
						</a>
						</td></tr>
					</table>
				</td>
            </tr> 
			</table>
		  </td>
		</tr>
  		</table>
		<!--tr><td bgcolor="#d0f8f7">&nbsp;</td></tr>-->
	</xsl:for-each>
		</td></tr>
	</table>
	
</xsl:template>
  
</xsl:stylesheet>
