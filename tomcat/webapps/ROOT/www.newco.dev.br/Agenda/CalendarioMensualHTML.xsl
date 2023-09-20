<?xml version="1.0" encoding="iso-8859-1" ?>
<!--

	Presenta un mes completo de la CALENDARIO a un usuario
	
	Permite tratar citas o tareas
	
	(c) may 2003 ET

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Calendario de MedicalVM</title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript
	function Actualizar(form)
	{
		//	Actualiza la fecha actual
		AsignarFechaActiva('1/'+form.elements['MES'].value+'/'+form.elements['ANYO'].value);
		
		//	Envia el formulario
		SubmitForm(form);
	};
	
	function FechaActiva()
	{
		return (document.forms[0].elements['FECHAACTUAL'].value);
	}

	function AsignarFechaActiva(Fecha)
	{
		document.forms[0].elements['FECHAACTUAL'].value=Fecha;
	}
	
	//-->
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
          
           
          
<body leftMargin="0" topMargin="0" marginheight="0" marginwidth="0" class="blanco">
<form action="CalendarioMensual.xsql" method="POST" name="form1">
	<input type="hidden" name="FECHAACTUAL">
		<xsl:attribute name="value"><xsl:value-of select="CalendarioMensual/CALENDARIO/@Fecha"/></xsl:attribute>
	</input>
	<table width="200" border="0" align="center" cellspacing="1" cellpadding="1" class="medio">
		<tr class="oscuro">
			<td align="right" colspan="5">
			<xsl:call-template name="desplegable">
    			<xsl:with-param name="path" select="CalendarioMensual/CALENDARIO/MES/field">
    			</xsl:with-param>
				<xsl:with-param name="onChange">javascript:Actualizar(document.forms[0]);</xsl:with-param>
			</xsl:call-template>
			</td>				
			<td align="left" colspan="3">
			<xsl:call-template name="desplegable">
    			<xsl:with-param name="path" select="CalendarioMensual/CALENDARIO/ANYO/field">
    			</xsl:with-param>
				<xsl:with-param name="onChange">javascript:Actualizar(document.forms[0]);</xsl:with-param>
			</xsl:call-template>				
			</td>				
		</tr>
		<tr class="oscuro">
			<td width="9%" align="center">&nbsp;</td>
			<td width="13%" align="center">L</td>
			<td width="13%" align="center">M</td>
			<td width="13%" align="center">X</td>
			<td width="13%" align="center">J</td>
			<td width="13%" align="center">V</td>
			<td width="13%" align="center">S</td>	
			<td width="13%" align="center">D</td>
		</tr>
		<xsl:apply-templates select="CalendarioMensual/CALENDARIO"/>
	</table>
</form>
		
</body>
  

</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>

<xsl:template match="CALENDARIO">
	<xsl:for-each select="./SEMANA">
		<tr>
			<!--	Semana		-->
			<td align="center" class="oscuro" >
				S<xsl:value-of select="./@Numero"/>
			</td>
			<xsl:for-each select="./DIA">
				<td align="center" valign="top">
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="./Laborable='S'">claro</xsl:when>
							<xsl:otherwise>grisclaro</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<a>
					<xsl:attribute name="href"><xsl:value-of select="./@Accion"/>;</xsl:attribute>
					<xsl:value-of select="./@Numero"/>!
					</a>
				</td>
			</xsl:for-each>	
		</tr>
	</xsl:for-each>	
</xsl:template>

 
</xsl:stylesheet>
