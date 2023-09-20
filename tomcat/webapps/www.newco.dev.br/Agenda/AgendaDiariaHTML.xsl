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
        

	function EditarTarea(IDTarea){	//	Posiciones relativas de los conceptos
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Agenda/Tarea.xsql?'+'&'+'IDTarea='+IDTarea+'&VENTANA=NUEVA';
		
		//alert (Enlace);
				
	  MostrarPag(Enlace, 'Tarea');
	}

	function Pulsado(NombreCheck)
	{	
		var form=document.forms[0];
		var	Msg='';
		var Marcado;
		
		//alert('Pulsado:'+NombreCheck+' ID='+Piece(NombreCheck,'_',2));

		if (form.elements[NombreCheck].checked) Marcado=true;
		else Marcado=false;
		
		//	Recorre todos los checks con el mismo nombre (estado) e ID (tarea) para poner en mismo marca

		for (j=0;j<form.elements.length;j++)
		{
    		if (	//	Comprueba si el check es el mismo que se ha pasado como parametro
					(form.elements[j].type=='checkbox')
					&&(Piece(form.elements[j].name,'_',0)==Piece(NombreCheck,'_',0))
					&&(Piece(form.elements[j].name,'_',2)==Piece(NombreCheck,'_',2))
				)
			{
    		  form.elements[j].checked=Marcado;
			}
		}
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
<form action="AgendaDiariaSave.xsql" method="POST" name="form1">
	<input type="hidden" name="RESULTADO">
		<xsl:attribute name="value"/>
	</input>
	<input type="hidden" name="FECHAACTIVA">
		<xsl:attribute name="value"><xsl:value-of select="/AgendaDiaria/AGENDA/@Dia"/></xsl:attribute>
	</input>
	<input type="hidden" name="IDUSUARIOAGENDA">
		<xsl:attribute name="value"><xsl:value-of select="/AgendaDiaria/AGENDA/USUARIOAGENDA/@ID"/></xsl:attribute>
	</input>
<p class="tituloPag" align="center"><br/>
	<xsl:value-of select="/AgendaDiaria/AGENDA/USUARIOAGENDA"/> (<xsl:value-of select="/AgendaDiaria/AGENDA/@Dia"/>)
</p><br/>
<table width="80%" border="0" align="center" cellspacing="1" cellpadding="1" class="medio">
	<tr class="oscuro">
		<td width="20%" align="center">Hora</td>
		<td width="80%" align="center">
							<table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="oscuro">
							<tr>
								<!--<td width="15%" align="center" class="oscuro">Prioridad</td>-->
								<td width="20%" align="center" class="oscuro">Tipo</td>
								<td width="50%" align="left" class="oscuro">Nombre de la Actividad</td>
								<xsl:if test="/AgendaDiaria/AGENDA/EDICION">
									<td width="10%" align="center">En Curso</td>
									<td width="10%" align="center">Fin</td>
									<td width="10%" align="center">Borrar</td>
								</xsl:if>
							</tr>
							<!--<tr><td height="1" colspan="3" class="medio"></td></tr>-->
							</table>
		</td>
	</tr>
	<xsl:for-each select="/AgendaDiaria/AGENDA/TRAMO">
		<tr>
			<!--	Hora		-->
			<td align="center" class="claro">
				<xsl:value-of select="./@ID"/>:00<!--<br/><xsl:value-of select="./@ID"/>:59-->
			</td>
			<td align="left" class="claro">
				<xsl:choose>
					<xsl:when test="./DIA/TAREA">
						<xsl:for-each select="./DIA/TAREA">
							<table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="claro">
							<tr>
								<!--<td width="15%" align="center" class="claro"><xsl:value-of select="./PRIORIDAD"/></td>-->
								<td width="20%" align="left" class="claro"><xsl:apply-templates select="./COLOR"/>&nbsp;<xsl:value-of select="./ACTIVIDAD"/></td>
								<td width="50%" align="left" class="claro">
									<a>								 
										<xsl:attribute name="href">javascript:EditarTarea(<xsl:value-of select="./ID"/>);</xsl:attribute>
										<xsl:value-of select="./TITULO"/>
									</a>
								</td>
								<xsl:if test="/AgendaDiaria/AGENDA/EDICION">
								<td width="10%" align="center">
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
								</td>
								<td width="10%" align="center">
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
								</td>
								<td width="10%" align="center">
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
								</td>
								</xsl:if>
							</tr>
							<!--<tr><td height="1" colspan="3" class="medio"></td></tr>-->
							</table>
						</xsl:for-each>	
					</xsl:when>
					<xsl:otherwise>
							&nbsp;
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</xsl:for-each>	
	<!--	Boton de enviar formulario	-->
	<xsl:if test="/AgendaDiaria/AGENDA/EDICION">
	<tr valign="top">
		<td class="blanco" align="right" colspan="5">
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
	</xsl:if>
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
