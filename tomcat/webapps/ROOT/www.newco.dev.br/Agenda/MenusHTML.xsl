<?xml version="1.0" encoding="iso-8859-1" ?>
<!--

	Presenta un mes completo de la CALENDARIO a un usuario
	
	Permite tratar citas o tareas
	
	(c) may 2003 ET

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:import href = "http://www.newco.dev.br/Agenda/ControlCalendario.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Agenda de MedicalVM</title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript
	
	//	Abrir pagina
	function AbrirPagina(Enlace)
	{
		var objFrame=new Object();
		alert(top);
		objFrame=obtenerFrame(top,'AgendaTrabajo');
		objFrame.location.href=Enlace+'FECHAACTIVA='+FechaActiva()+'&IDUSUARIOAGENDA='+document.forms[1].elements['IDUSUARIOAGENDA'].value;
	}

	//	Pulsaci�n de un d�a en el calendario
	function PulsarDia(Dia)
	{
		AbrirPagina('AgendaDiaria.xsql?');
	}
	
	//	Pulsaci�n de una semana en el calendario
	function PulsarSemana(Semana)
	{
		AbrirPagina('AgendaSemanal.xsql?');
	}
	
	function frameVacio(nombreFrame){
	  
	  var objFrame=new Object();
		
		objFrame=obtenerFrame(top,nombreFrame);
		objFrame.location.href='about:blank';
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
          
          <xsl:variable name="PulsacionCalendario">PulsarDia()</xsl:variable>
          
           
          
<body leftMargin="0" topMargin="0" marginheight="0" marginwidth="0" class="blanco" onLoad="if(AsignarDiaPulsado(document.forms[0],obtenerDiaDeFecha(document.forms[0].elements['FECHAACTIVA'].value))) {$PulsacionCalendario}; else frameVacio('AgendaTrabajo');">
<table class="blanco" align="center" cellspacing="1" cellpadding="1" border="0" width="100%">
<!--	Espacio para el control calendario	-->
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<xsl:if test="MenuAgenda/MENUS/EDICION">
<!--	Separador: linea en blanco	-->
<tr><td>&nbsp;</td></tr>
<!--	Men�: Nueva Cita	-->
<tr>
<td>
	<table class="muyoscuro" align="center" cellspacing="1" cellpadding="1" border="0" width="80%">
	<tr class="claro">
	<td>
	<a 	onMouseOver="window.status='Crear una Nueva Cita';return true;" 
		onMouseOut="window.status='';return true;" 
		href="javascript:MostrarPag('Tarea.xsql?IDTIPOTAREA=C&amp;','Tarea');">Nueva Cita</a>
	</td>
	</tr>
	</table>
</td>
</tr>
<!--	Separador: linea en blanco	-->
<tr><td>&nbsp;</td></tr>
<!--	Men�: Nueva Tarea	-->
<tr>
<td>
	<table class="muyoscuro" align="center" cellspacing="1" cellpadding="1" border="0" width="80%">
	<tr class="claro">
	<td>
	<a 	onMouseOver="window.status='Crear una Nueva Tarea';return true;" 
		onMouseOut="window.status='';return true;"
		href="javascript:MostrarPag('Tarea.xsql?IDTIPOTAREA=R&amp;', 'Tarea');">Nueva Tarea</a>
	</td>
	</tr>
	</table>
</td>
</tr>
</xsl:if>
<!--	Separador: linea en blanco	-->
<tr><td>&nbsp;</td></tr>
<tr>
<td>
		<xsl:apply-templates select="MenuAgenda/MENUS/CALENDARIO">
			<xsl:with-param name="ACCION">Menus.xsql</xsl:with-param>
			<xsl:with-param name="PULSAR_DIA"><xsl:value-of select="$PulsacionCalendario"/></xsl:with-param>
			<xsl:with-param name="ACTIVO">SIEMPRE</xsl:with-param> <!-- el boton no funciona del modo activo / desactivo (siempre activo)-->
		</xsl:apply-templates>
</td>
</tr>
<!--	Separador: linea en blanco	-->
<tr><td>&nbsp;</td></tr>
<!--	Men�: Agenda Diaria	-->
<!--	No es necesario, se abre desde el propio calendario
<tr>
<td>
	<table class="muyoscuro" align="center" cellspacing="1" cellpadding="1" border="0" width="80%">
	<tr class="blanco">
	<td>
	<a	onMouseOver="window.status='Agenda Diaria';return true;" 
		onMouseOut="window.status='';return true;" 
		href="javascript:AbrirPagina('AgendaDiaria.xsql?');">Agenda Diaria</a>
	</td>
	</tr>
	</table>
</td>
</tr>
-->
<!--	Separador: linea en blanco	-->
<tr><td>&nbsp;</td></tr>
<!--	Men�: Agenda Semanal	-->
<tr>
<td>
	<table class="muyoscuro" align="center" cellspacing="1" cellpadding="1" border="0" width="80%">
	<tr class="blanco">
	<td>
	<a	onMouseOver="window.status='Agenda Semanal';return true;" 
		onMouseOut="window.status='';return true;"
		href="javascript:AbrirPagina('AgendaSemanal.xsql?');">Agenda Semanal</a>
	</td>
	</tr>
	</table>
</td>
</tr>
<!--	Separador: linea en blanco	-->
<tr><td>&nbsp;</td></tr>
<!--	Men�: Agenda Mensual	-->
<tr>
<td>
	<table class="muyoscuro" align="center" cellspacing="1" cellpadding="1" border="0" width="80%">
	<tr class="blanco">
	<td>
	<a	onMouseOver="window.status='Agenda Mensual';return true;" 
		onMouseOut="window.status='';return true;" 
		href="javascript:AbrirPagina('AgendaMensual.xsql?');">Agenda Mensual</a>
	</td>
	</tr>
	</table>
</td>
</tr>
<!--	Separador: linea en blanco	-->
<tr><td>&nbsp;</td></tr>
<!--	Men�: Lista de Tareas	-->
<tr>
<td>
	<table class="muyoscuro" align="center" cellspacing="1" cellpadding="1" border="0" width="80%">
	<tr class="blanco">
	<td>
	<a	onMouseOver="window.status='Lista de Tareas';return true;" 
		onMouseOut="window.status='';return true;" 
		href="javascript:AbrirPagina('ListaTareas.xsql?MODO=C&amp;');">Lista de Tareas</a>
	</td>
	</tr>
	</table>
</td>
</tr>
<!--	Separador: linea en blanco	-->
<tr><td>&nbsp;</td></tr>
<!--	Men�: Vacaciones	-->
<tr>
<td>
	<table class="muyoscuro" align="center" cellspacing="1" cellpadding="1" border="0" width="80%">
	<tr class="blanco">
	<td>
	<a 	onMouseOver="window.status='Seleccionar fechas de Vacaciones y otros d�as no h�biles';return true;" 
		onMouseOut="window.status='';return true;" 
		href="javascript:AbrirPagina('CalendarioAnual.xsql?ACCION=VacacionesSave.xsql&amp;TITULO=Fechas no laborables&amp;');">
		Fechas no laborables</a>
	</td>
	</tr>
	</table>
</td>
</tr>
<!--	Men�: Otros usuarios	-->
<!--
<tr>
<td>
	<table class="muyoscuro" align="center" cellspacing="1" cellpadding="1" border="0" width="80%">
	<tr class="blanco">
	<td>
	<a 	onMouseOver="window.status='Ver la agenda de otros usuarios';return true;" 
		onMouseOut="window.status='';return true;" 
		href="javascript:AbrirPagina('OtrosUsuarios.xsql?');">Otros Usuarios</a>
	</td>
	</tr>
	</table>
</td>
</tr>
-->
<!--	Separador: linea en blanco	-->
<tr><td>&nbsp;</td></tr>
<!--	Desplegable con los usuarios de la empresa	-->
<tr>
<td align="center">
<form name="form1" action="Menus.xsql" method="POST">
	<xsl:call-template name="desplegable">
        <xsl:with-param name="path" select="MenuAgenda/MENUS/IDUSUARIOAGENDA/field"></xsl:with-param>
        <xsl:with-param name="onChange">javascript:SubmitForm(document.forms[1]);</xsl:with-param>
    </xsl:call-template>				
</form>
</td>
</tr>
</table>
</body>
  

</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>
 
</xsl:stylesheet>
