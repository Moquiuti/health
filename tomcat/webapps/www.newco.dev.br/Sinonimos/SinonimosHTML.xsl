<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Tablon de anuncios de MedicalVM
 |
 |	(c) 30/8/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
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
	  
	case 0:// Clave
		   var error='El campo \'Clave\' esta vacío pero es obligatorio.';
		    msgError=error+msgErrorStd;
		    if(form.elements[n].value==''){
		    return false;
		    }
		    break;  
	/*	   
	
	Permitimos sinonimo vacio para eliminar determinantes
	   	    	  
	case 1:// Sinonimo
		   var error='El campo \'Sinonimo\' esta vacío pero es obligatorio.';
		    msgError=error+msgErrorStd;
		    if(form.elements[n].value==''){
		    return false;
		    }
		    break;  
	  */           
		  		  	  
		}//switch
  }//for  
  return true;
}

//	Presenta un mensaje para avisar al usuario de que la actulizacion resultara lenta
function AvisoActualizacion()
{
	alert("Se va a proceder a actualizar la base de datos. El proceso tardara"
	+" algunos minutos.");
}

//	Presenta un mensaje para avisar al usuario de que la actulizacion resultara lenta
function NuevoSinonimo(form)
{
	if(validarFormulario(form))
	{
		AvisoActualizacion();
		SubmitForm(form);
	} 
	else alert(msgError);
	return true;
}
-->
	</script>
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo -->
          <xsl:when test="Sinonimos/xsql-error">
            <xsl:apply-templates select="Sinonimos/xsql-error"/>          
          </xsl:when>
	
        <xsl:when test="Sinonimos/ROW/Sorry">
          <xsl:apply-templates select="Sinonimos/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
		<p class="tituloPag" align="center">Sinónimos</p>
		<p align="center">
		Página para el uso exclusivo por parte de administradores de MedicalVM<br/>
		Si usted dispone de acceso a esta página sin ser administrador, por favor, informe
		a su comercial de MedicalVM.<br/><br/>
		<form action="NuevoSinonimoSave.xsql" method="POST" name="form1">
        <table width="50%" border="0" align="center" cellspacing="0" cellpadding="0" >
            <tr bgColor="#a0d8d7">
				<td align="center" width="50%">
					Clave:
				</td>
				<td align="center" width="50%">
                	<input type="text" name="CLAVE" size="25" maxlength="20"/>
				</td>
			</tr>
            <tr bgColor="#a0d8d7">
				<td align="center" width="50%">
					Sinónimo:
				</td>
				<td align="center" width="50%">
                	<input type="text" name="SINONIMO" size="25" maxlength="20"/>
				</td>
			</tr>
    		<tr>
      			<td align="center" colspan="2">
        			<input  type="button" name="SUBMIT" value="Aceptar"
					onClick="NuevoSinonimo(document.forms[0]);"/>
      			</td>
    		</tr>
		</table>
		</form>
		</p>
        	<table width="50%" border="1" align="center" cellspacing="0" cellpadding="0" >
			<tr><td>
        	<table width="100%" border="1" align="center" cellspacing="0" cellpadding="0" >
            <tr bgColor="#a0d8d7">
				<td align="center" width="5%">
					&nbsp;
				</td>
				<td align="center" width="20%">
					Clave
				</td>
				<td align="center" width="20%">
					Sinónimo
				</td>
				<td align="center" width="55%">
					Cadena Completa
				</td>
			</tr>
          	<xsl:for-each select="Sinonimos/ROW">
            	<tr bgColor="#EEFFFF">
					<td align="center">
						<a>
							<xsl:attribute name="href">BorrarSinonimo.xsql?CLAVE=<xsl:value-of select="NOMBRE"/>&amp;SINONIMO=<xsl:value-of select="SINONIMO"/>							</xsl:attribute>
							<xsl:attribute name="onClick">AvisoActualizacion();</xsl:attribute>
							<img src="../images/Botones/EliminarPeq.gif"/>
						</a>
					</td>
					<td align="center">
						<xsl:value-of select="NOMBRE"/>
					</td>
					<td align="center">
						<xsl:value-of select="SINONIMO"/>
					</td>
					<td align="center">
						<xsl:value-of select="CADENACOMPLETA"/>
					</td>
				</tr>
		  	</xsl:for-each>	    
        	</table> 
			</td></tr>
			</table>
			<br/>
        <br/><br/>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  

</xsl:stylesheet>
