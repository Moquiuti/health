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
        <title>Agenda Diario de MedicalVM</title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript
        
	//	Edita los datos de una tarea
	function EditarTarea(IDTarea){
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Agenda/Tarea.xsql?IDTIPOTAREA=R&VENTANA=NUEVA'+'&'+'IDTarea='+IDTarea;
		
				
	  MostrarPag(Enlace, 'Tarea');
	}
	
	//	Crea una nueva tarea
	function NuevaTarea(IDTarea){
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Agenda/Tarea.xsql?IDTIPOTAREA=R&VENTANA=NUEVA'
						+'&FECHAACTIVA='+form.elements['FECHAACTIVA'].value;
				
	  MostrarPag(Enlace, 'Tarea');
	}
	
	//	Busca el estado de una tarea
	function BuscaValorEstado(pID, pEstado)
	{
		var form=document.forms[0];
		var Valor=null;
		
		for (j=0;(j<form.elements.length)&&(Valor==null);j++)
		{
			if	(form.elements[j].type=='checkbox')			
			{
				ID=Piece(form.elements[j].name,'_',2);
				Estado=Piece(form.elements[j].name,'_',0);
				
				if ((pID==ID) &&(pEstado==Estado))
					if(form.elements[j].checked) 
					  	Valor='S';
					else 
					  	Valor='N';
			}
		}
		return Valor;
	}
	
	//	Construye y envia la cadena con los resultados segun el formulario
	function Guardar()
	{	
		var Tareas=new Array(256);		//espero que no se necesiten mas de 256!
		var Resultado='';
		var form=document.forms[0];
		var ID;
		var Estado;
		var Marcado;
		
		var EstadoCurso;
		var EstadoFin;
		var EstadoBorrar;
		
		//	Recorre todos los checks

		for (j=0;j<form.elements.length;j++)
		{

			if	(form.elements[j].type=='checkbox')			
			{
				ID=Piece(form.elements[j].name,'_',2);
				Estado=Piece(form.elements[j].name,'_',0);


    			if  (Resultado.search(ID)==-1)     //(!existeSubCadena(Resultado,ID))
				{
					//	Busca el resto de estados de la misma tarea
					
					EstadoCurso=BuscaValorEstado(ID,'ENCURSO');
					EstadoFin=BuscaValorEstado(ID,'FIN');
					EstadoBorrar=BuscaValorEstado(ID,'BORRAR');
					
					Resultado=Resultado+ID+'|'+EstadoCurso+'|'+EstadoFin+'|'+EstadoBorrar+'#';
				}
			}
			
		}

		form.elements['RESULTADO'].value=Resultado;

		//	Envia el formulario
     	AsignarAccion(form,'ListaTareasSave.xsql?MODO='+form.elements['MODO'].value);
		SubmitForm(form);
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
<form action="ListaTareasSave.xsql" method="POST" name="form1">
	<input type="hidden" name="RESULTADO">
		<xsl:attribute name="value"/>
	</input>
	<input type="hidden" name="FECHAACTIVA">
		<xsl:attribute name="value"><xsl:value-of select="/ListaTareas/LISTATAREAS/@Dia"/></xsl:attribute>
	</input>
	<input type="hidden" name="MODO">
		<xsl:attribute name="value"><xsl:value-of select="/ListaTareas/LISTATAREAS/MODO"/></xsl:attribute>
	</input>
	<input type="hidden" name="IDUSUARIOAGENDA">
		<xsl:attribute name="value"><xsl:value-of select="/ListaTareas/LISTATAREAS/USUARIOAGENDA/@ID"/></xsl:attribute>
	</input>
<p class="tituloPag" align="center"><br/>
	<xsl:value-of select="/ListaTareas/LISTATAREAS/USUARIOAGENDA"/>	<!--	Falta incluir el nombre del usuario	o desplegable con usuarios	-->
</p><br/>
<table width="95%" border="0" align="center" cellspacing="1" cellpadding="3" class="medio">
	<tr class="oscuro" align="center">
		<!--<td width="15%" align="center" class="oscuro">Prioridad</td>-->
		<td width="10%">Estado</td>
		<td width="10%">Tipo</td>
		<td width="10%">Responsable</td>
		<td width="10%">Cliente</td>
		<td width="10%">Proveedor</td>
		<td width="10%">Inicio</td>
		<xsl:if test="/ListaTareas/LISTATAREAS/MODO!='C'">
			<td width="10%">Final</td>
		</xsl:if>
		<td width="*">Nombre de la Actividad</td>
		<xsl:if test="/ListaTareas/LISTATAREAS/EDICION">
			<td width="5%">En Curso</td>
			<td width="5%">Fin</td>
			<td width="5%">Borrar</td>
		</xsl:if>
	</tr>
	<xsl:for-each select="/ListaTareas/LISTATAREAS/TAREA">
		<tr class="claro" align="center">
		<td align="left"><xsl:apply-templates select="./COLOR"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="./ESTADO"/></td>
		<td><xsl:value-of select="./ACTIVIDAD"/></td>
		<td><xsl:value-of select="./RESPONSABLE"/></td>
		<td><xsl:value-of select="./CLIENTE"/></td>
		<td><xsl:value-of select="./PROVEEDOR"/></td>
		<td><xsl:value-of select="./FECHAINICIOPREVISTA"/></td>
		<xsl:if test="/ListaTareas/LISTATAREAS/MODO!='C'">
			<td><xsl:value-of select="./FECHAFINALPREVISTA"/></td>
		</xsl:if>
		<td align="left">
			<xsl:choose>
				<xsl:when test="./EDICION">
					<a>								 
						<xsl:attribute name="href">javascript:EditarTarea(<xsl:value-of select="./ID"/>);</xsl:attribute>
						<xsl:value-of select="./TITULO"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="./TITULO"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<xsl:if test="/ListaTareas/LISTATAREAS/EDICION">
			<td align="center">
				<xsl:choose>
					<xsl:when test="./EDICION">
					<input type="checkbox">
						<xsl:attribute name="name">ENCURSO_<xsl:value-of select="../../@ID"/>_<xsl:value-of select="./ID"/></xsl:attribute>
						<xsl:attribute name="onClick">javascript:Pulsado('ENCURSO_<xsl:value-of select="../../@ID"/>_<xsl:value-of select="./ID"/>');</xsl:attribute>
						<xsl:choose>
							<xsl:when test="./CURSO='S'">
								<xsl:attribute name="checked">S</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="unchecked">unchecked</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</input>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td align="center">
				<xsl:choose>
					<xsl:when test="./EDICION">
					<input type="checkbox">
						<xsl:attribute name="name">FIN_<xsl:value-of select="../../@ID"/>_<xsl:value-of select="./ID"/></xsl:attribute>
						<xsl:attribute name="onClick">javascript:Pulsado('FIN_<xsl:value-of select="../../@ID"/>_<xsl:value-of select="./ID"/>');</xsl:attribute>
						<xsl:choose>
							<xsl:when test="./FIN='S'">
								<xsl:attribute name="checked">S</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="unchecked">unchecked</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</input>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td align="center">
				<xsl:choose>
					<xsl:when test="./EDICION">
					<input type="checkbox">
						<xsl:attribute name="name">BORRAR_<xsl:value-of select="../../@ID"/>_<xsl:value-of select="./ID"/></xsl:attribute>
						<xsl:attribute name="onClick">javascript:Pulsado('BORRAR_<xsl:value-of select="../../@ID"/>_<xsl:value-of select="./ID"/>');</xsl:attribute>
						<xsl:choose>
							<xsl:when test="./BORRAR='S'">
								<xsl:attribute name="checked">S</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="unchecked">unchecked</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</input>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:if>
		</tr>
	</xsl:for-each>	
	<!--	Boton de enviar formulario	-->
	<xsl:if test="/ListaTareas/LISTATAREAS/EDICION">
		<xsl:choose>
			<xsl:when test="/ListaTareas/LISTATAREAS/MODO='C'">
			<tr valign="top">
				<td class="blanco" align="left" colspan="6">
	        		<xsl:call-template name="botonPersonalizado">
	        		  <xsl:with-param name="funcion">NuevaTarea();</xsl:with-param>
	        		  <xsl:with-param name="label">Crear una nueva tarea</xsl:with-param>
	        		  <xsl:with-param name="status">Nueva Tarea</xsl:with-param>
	        		  <xsl:with-param name="ancho">120px</xsl:with-param>
	        		  <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	        		  <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	        		</xsl:call-template> 
				</td>				
				<td class="blanco" align="right" colspan="4">
	        		<xsl:call-template name="botonPersonalizado">
	        		  <xsl:with-param name="funcion">Guardar();</xsl:with-param>
	        		  <xsl:with-param name="label">Guardar los cambios</xsl:with-param>
	        		  <xsl:with-param name="status">Guardar</xsl:with-param>
	        		  <xsl:with-param name="ancho">120px</xsl:with-param>
	        		  <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	        		  <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	        		</xsl:call-template> 
				</td>				
			</tr>
			</xsl:when>
			<xsl:otherwise>
				<td class="blanco" align="right" colspan="9">
	        		<xsl:call-template name="botonPersonalizado">
	        		  <xsl:with-param name="funcion">Guardar();</xsl:with-param>
	        		  <xsl:with-param name="label">Guardar los cambios</xsl:with-param>
	        		  <xsl:with-param name="status">Guardar</xsl:with-param>
	        		  <xsl:with-param name="ancho">120px</xsl:with-param>
	        		  <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	        		  <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	        		</xsl:call-template> 
				</td>				
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</table>
<br/>
<table width="80%" border="0" align="center" cellspacing="0" cellpadding="0" class="medio">
	<tr class="blanco" align="left"><td>
			<img src="../images/SemaforoVerde.gif"/>&nbsp;Tarea sin ningun aviso<br/>
	</td></tr>
	<tr class="blanco" align="left"><td>
			<img src="../images/SemaforoAmbar.gif"/>&nbsp;Tarea no iniciada con fecha prevista de inicio superada<br/>
	</td></tr>
	<tr class="blanco" align="left"><td>
			<img src="../images/SemaforoRojo.gif"/>&nbsp;Tarea no finalizada con fecha prevista de final superada<br/>
	</td></tr>
</table>
</form>	
</body>
  

</xsl:otherwise>
</xsl:choose>
</html>
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
