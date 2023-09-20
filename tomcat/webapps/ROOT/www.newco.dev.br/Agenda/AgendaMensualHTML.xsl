<?xml version="1.0" encoding="iso-8859-1" ?>
<!--

	Presenta un mes completo de la agenda a un usuario
	
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
        <title>Agenda Mensual de MedicalVM</title>

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
	<xsl:value-of select="AgendaMensual/AGENDA/USUARIOAGENDA"/> (<xsl:value-of select="AgendaMensual/AGENDA/@Mes"/>&nbsp;<xsl:value-of select="AgendaMensual/AGENDA/@Anyo"/>)
</p><br/>
<table width="95%" border="0" align="center" cellspacing="1" cellpadding="1" class="medio">
	<tr class="oscuro">
		<td width="*%" align="center">&nbsp;</td>
		<td width="13%" align="center">Lunes<br/><xsl:value-of select="AgendaMensual/AGENDA/LUNES/@Fecha"/></td>
		<td width="13%" align="center">Martes<br/><xsl:value-of select="AgendaMensual/AGENDA/MARTES/@Fecha"/></td>
		<td width="13%" align="center">Miércoles<br/><xsl:value-of select="AgendaMensual/AGENDA/MIERCOLES/@Fecha"/></td>
		<td width="13%" align="center">Jueves<br/><xsl:value-of select="AgendaMensual/AGENDA/JUEVES/@Fecha"/></td>
		<td width="13%" align="center">Viernes<br/><xsl:value-of select="AgendaMensual/AGENDA/VIERNES/@Fecha"/></td>
		<td width="10%" align="center">Sábado<br/><xsl:value-of select="AgendaMensual/AGENDA/SABADO/@Fecha"/></td>
		<td width="10%" align="center">Domingo<br/><xsl:value-of select="AgendaMensual/AGENDA/DOMINGO/@Fecha"/></td>
	</tr>
	<xsl:apply-templates select="AgendaMensual/AGENDA"/>
</table>
		
</body>
  

</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>

<xsl:template match="AGENDA">
	<xsl:for-each select="./SEMANA">
		<tr>
			<!--	Semana		-->
			<td align="center" class="oscuro" widht="20%">
				S<xsl:value-of select="./@Numero"/>
			</td>
			<xsl:for-each select="./DIA">
				<td align="left" valign="top" widht="80%">
					<xsl:attribute name="class">
					<xsl:value-of select="./@Clase"/>
<!--						<xsl:choose>
							<xsl:when test="./Laborable='S'">claro</xsl:when>
							<xsl:otherwise>grisclaro</xsl:otherwise>
						</xsl:choose>-->
					</xsl:attribute>
					<xsl:value-of select="./@Numero"/><br/>
					<xsl:choose>
					<xsl:when test="TAREA">
						<xsl:for-each select="TAREA">
							<a>								 
								<xsl:attribute name="href">javascript:EditarTarea(<xsl:value-of select="./ID"/>);</xsl:attribute>
								>&nbsp;<xsl:value-of select="./ACTIVIDAD"/>:&nbsp;<xsl:value-of select="./TITULO"/><br/>
							</a>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<br/><br/><br/><br/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:for-each>	
		</tr>
	</xsl:for-each>	
</xsl:template>

 
</xsl:stylesheet>
