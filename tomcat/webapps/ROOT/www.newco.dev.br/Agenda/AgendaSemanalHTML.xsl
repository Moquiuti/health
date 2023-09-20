<?xml version="1.0" encoding="iso-8859-1" ?>
<!--

	Presenta un dia completo de la agenda a un usuario
	
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
        <title>Agenda Semanal de MedicalVM</title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript
        

	function EditarTarea(IDTarea){	//	Posiciones relativas de los conceptos
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Agenda/Tarea.xsql?'+'&'+'IDTarea='+IDTarea+'&VENTANA=NUEVA';
		
		//alert (Enlace);
				
	  MostrarPag(Enlace, 'Tarea');
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
          
           
          
<body bgColor="#FFFFFF" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
<p class="tituloPag" align="center"><br/>
	<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/USUARIOAGENDA"/> (<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/@DiaInicio"/>-<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/@DiaFinal"/>)
</p><br/>
<table width="95%" border="0" align="center" cellspacing="1" cellpadding="1" class="medio">
	<tr class="oscuro">
		<td width="9%" align="center">&nbsp;</td>
		<td width="13%" align="center">Lunes<br/>
			<a>
				<xsl:attribute name="href">AgendaDiaria.xsql?FECHAACTIVA=<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/LUNES/@Fecha"/></xsl:attribute>
				<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/LUNES/@Fecha"/>
			</a>
		</td>
		<td width="13%" align="center">Martes<br/>
			<a>
				<xsl:attribute name="href">AgendaDiaria.xsql?FECHAACTIVA=<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/MARTES/@Fecha"/></xsl:attribute>
				<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/MARTES/@Fecha"/>
			</a>
		</td>
		<td width="13%" align="center">Miércoles<br/>
			<a>
				<xsl:attribute name="href">AgendaDiaria.xsql?FECHAACTIVA=<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/MIERCOLES/@Fecha"/></xsl:attribute>
				<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/MIERCOLES/@Fecha"/>
			</a>
		</td>
		<td width="13%" align="center">Jueves<br/>
			<a>
				<xsl:attribute name="href">AgendaDiaria.xsql?FECHAACTIVA=<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/JUEVES/@Fecha"/></xsl:attribute>
				<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/JUEVES/@Fecha"/>
			</a>
		</td>
		<td width="13%" align="center">Viernes<br/>
			<a>
				<xsl:attribute name="href">AgendaDiaria.xsql?FECHAACTIVA=<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/VIERNES/@Fecha"/></xsl:attribute>
				<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/VIERNES/@Fecha"/>
			</a>
		</td>
		<td width="13%" align="center">Sábado<br/>
			<a>
				<xsl:attribute name="href">AgendaDiaria.xsql?FECHAACTIVA=<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/SABADO/@Fecha"/></xsl:attribute>
				<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/SABADO/@Fecha"/>
			</a>
		</td>
		<td width="13%" align="center">Domingo<br/>
			<a>
				<xsl:attribute name="href">AgendaDiaria.xsql?FECHAACTIVA=<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/DOMINGO/@Fecha"/></xsl:attribute>
				<xsl:value-of select="AgendaSemanal/AGENDA_SEMANAL/AGENDA/DOMINGO/@Fecha"/>
			</a>
		</td>
	</tr>
	<xsl:apply-templates select="AgendaSemanal/AGENDA_SEMANAL/AGENDA"/>
</table>
		
</body>
  

</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>

<xsl:template match="AGENDA">
	<xsl:for-each select="./TRAMO">
		<!--<table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="claro">-->
		<tr>
			<!--	Hora		-->
			<td align="center" class="claro" widht="20%">
				<xsl:value-of select="./@ID"/>:00<!--<br/><xsl:value-of select="./@ID"/>:59-->
			</td>
			<xsl:for-each select="./DIA">
				<td align="left" class="claro" widht="80%">
					<xsl:for-each select="TAREA">
						<xsl:apply-templates select="./COLOR"/>&nbsp;
						<a>								 
							<xsl:attribute name="href">javascript:EditarTarea(<xsl:value-of select="./ID"/>);</xsl:attribute>
							<xsl:value-of select="./ACTIVIDAD"/>:&nbsp;<xsl:value-of select="./TITULO"/>
						</a>
						<br/>
					</xsl:for-each>	
				</td>
			</xsl:for-each>	
		</tr>
		<!--</table>-->
	</xsl:for-each>	
</xsl:template>

<xsl:template match="COLOR">
	<xsl:choose>
		<xsl:when test=".='VERDE'"> 
			<img src="../images/SemaforoVerde.gif"/>
		</xsl:when>
		<xsl:when test=".='ROJO'"> 
			<img src="../images/SemaforoRojo.gif"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="../images/SemaforoAmbar.gif"/>
		</xsl:otherwise>
		</xsl:choose>
</xsl:template>

 
</xsl:stylesheet>
