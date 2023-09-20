<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Buscador con paginacion y filtros de uso general
	para el uso en diversos proyectos de MedicalVM
	
	
	Primera Versión: ET		18 feb 2004
	
	(c) 2004 MedicalVM
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="./General.xsl" />
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/> 
<xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
  	<xsl:text disable-output-escaping="yes">
	<![CDATA[
  	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	]]>
	</xsl:text>		
    <html>
	<head>	
    <title>MedicalVM - <xsl:value-of select="/Buscador/BUSCADOR_GENERAL/TITULO"/></title>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css"/>
	<xsl:text disable-output-escaping="yes">
	<![CDATA[	
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript


	//	Abre una pagina posicionandola y con unas dimensiones especificas
	function MostrarPagPersonalizada(pag,titulo,p_ancho,p_alto,p_desfaseLeft,p_desfaseTop)
	{  
		var ventana=null;
    	var agt=navigator.userAgent.toLowerCase(); 
    	var is_nav  = ((agt.indexOf('mozilla')!=-1) && (agt.indexOf('spoofer')==-1) 
                	&& (agt.indexOf('compatible') == -1) && (agt.indexOf('opera')==-1) 
                	&& (agt.indexOf('webtv')==-1)); 

		if(titulo==null)
            var titulo='MedicalVM';
            
            
		if(is_nav)
		{
           
            ample = (top.screen.availWidth*p_ancho)/100;
            alcada = (top.screen.availHeight*p_alto)/100;
                        
            esquerra = parseInt(((top.screen.availWidth-ample) / 2)+((((top.screen.availWidth-ample) / 2)*p_desfaseLeft)/100));
            alt = parseInt(((top.screen.availHeight-alcada) / 2)+((((top.screen.availHeight-alcada) / 2)*p_desfaseTop)/100));  
            
            if(ventana && ventana.open){
              ventana.close();            
            }
            
            titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
            titulo.focus();
            
        }
		else
		{
  
            ample = (top.screen.availWidth*p_ancho)/100;
            alcada = (top.screen.availHeight*p_alto)/100;
                        
            esquerra = parseInt(((top.screen.availWidth-ample) / 2)+((((top.screen.availWidth-ample) / 2)*p_desfaseLeft)/100));
            alt = parseInt(((top.screen.availHeight-alcada) / 2)+((((top.screen.availHeight-alcada) / 2)*p_desfaseTop)/100));  
            
            if(ventana &&  ventana.open && !ventana.closed){
              ventana.close();
		}
            
	    titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
	    titulo.focus();
		}
	}


	//	Muestra una nueva ventana con el formulario de contacto
	function AbrirFichaTienda(Sesion, IDUsuario)
	{
		MostrarPagPersonalizada('http://www.liquidaciones.com/FichaEstaticaTienda.xsql?IDUSUARIO='+IDUsuario, 'FichaTienda',80,70,0,-50);
	}

	//	Monta el filtro
	function PrepararFiltro()
	{
		var Restriccion='';
		var Condicion='';
		
		for (i=1;i<=document.forms[0].elements['NUMEROCOLUMNAS'].value;++i)
		{
			var NombreCampo=document.forms[0].elements['NOMBRECAMPO_'+i].value;
			var ValorCampo=document.forms[0].elements[NombreCampo].value;

			if (document.forms[0].elements[NombreCampo].type=='text')
				Condicion='LIKE'
			else
				Condicion='='

			if (ValorCampo!='')
				Restriccion=Restriccion+NombreCampo+'|'+Condicion +'|'+document.forms[0].elements[NombreCampo].value+'#';
		}
		
		document.forms[0].elements['RESTRICCION'].value=Restriccion;
	}
	
	//	Recarga la pagina recuperando la pagina
	function Recargar()
	{
		PrepararFiltro();
	
		document.forms[0].elements['PAGINA'].value=0;
		document.forms[0].submit(); 
	}
	
	//	Recarga la pagina recuperando la pagina
	function PaginaSiguiente()
	{
		PrepararFiltro();
		document.forms[0].submit(); 
	}
	
	//	Recarga la pagina recuperando la pagina
	function PaginaAnterior()
	{
		PrepararFiltro();
		document.forms[0].elements['PAGINA'].value=document.forms[0].elements['PAGINA'].value-2;
		document.forms[0].submit(); 
	}


	//	Accion sobre los checkboxes
	function BotonPulsado()
	{
		var ID_on='';
		var ID_off='';
		
		for (i=1;i<=document.forms[0].elements['NUMEROFILAS'].value;++i)
		{
			if (document.forms[0].elements['CHECK_'+i].checked)
				ID_on=ID_on+document.forms[0].elements['ID_'+i].value+'|';
			else
				ID_off=ID_off+document.forms[0].elements['ID_'+i].value+'|';
		}
		
		document.forms[0].elements['ACCION'].value=ID_on+'#'+ID_off;
		Recargar();
	}

	//	Captura la pulsacion de la tecla de "RETURN"        
	function handleKeyPress(e) 
	{

		var keyASCII;

		if(navigator.appName.match('Microsoft'))
			keyASCII=event.keyCode;
		else
			keyASCII = (e.which);

		if (keyASCII == 13)
		{
			Recargar();                
		}
	}


	//	Asigna la funcion de captura de pulsaciones
	if(navigator.appName.match('Microsoft')==false) 
		document.captureEvents(Event.KEYPRESS); 
	document.onkeypress = handleKeyPress;

	//-->
	</script>
	]]>
	</xsl:text>	

	</head>
	<body class="blanco" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<!--	Inicio del formulario	-->
		<form name="FiltrosListado" action="BuscadorGeneral.xsql" method="post">
		<table width="100%" class="blanco" cellpadding="0" cellspacing="0" border="0" align="center" valign="center">
		<tr>
		<td align="center" width="*" class="blanco" valign="top">
		<xsl:choose>
			<xsl:when test="/Buscador/ERROR">
				<table cellpadding="0" cellspacing="0" border="0" align="center" valign="center" width="700px">
				<tr class="blanco">
					<td align="center">
					<br/>
					<br/>
					<br/>
					<xsl:value-of select="/Buscador/ERROR/@Msg"/>
					</td>
				</tr>
				<!--	Pie de pagina: boton de cerrar pagina	-->
				<tr>
				<td align="center" colspan="2">
				<br/>
					<table width="10%" class="BordeTabla" cellpadding="1" cellspacing="1" border="0" align="center" valign="center">
					<tr>
						<td width="100%" align="center" class="claro">  
							<a href="javascript:window.close();">Cerrar</a>
						</td>
					</tr>
					</table>
				<br/>&nbsp;
				</td>
				</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
			<!--	Texto de explicación del servicio	-->
				<table cellpadding="0" cellspacing="0" border="0" align="center" valign="center" width="100%">
				<tr class="blanco">
					<td align="center">
					<H1><xsl:value-of select="/Buscador/BUSCADOR_GENERAL/TITULO"/></H1><br/>
					<xsl:value-of select="/Buscador/BUSCADOR_GENERAL/EXPLICACION"/><br/>
					<br/>&nbsp;
					</td>
				</tr>
				<tr class="blanco">
					<td align="center">
					<!--	Tabla con los resumenes globales de usuarios	-->
 					<table cellpadding="3" cellspacing="1" border="0" align="center" valign="center" width="90%" class="medio">
					<tr class="oscuro" align="center">
						<!--	Inicio del formulario	-->
       					<input type="hidden" name="SES_ID">
							<xsl:attribute name="value"><xsl:value-of select="/Buscador/SES_ID"/></xsl:attribute>
						</input>
       					<input type="hidden" name="IDCONSULTA">
							<xsl:attribute name="value"><xsl:value-of select="/Buscador/BUSCADOR_GENERAL/IDCONSULTA"/></xsl:attribute>
						</input>
       					<input type="hidden" name="PAGINA">
							<xsl:attribute name="value"><xsl:value-of select="/Buscador/BUSCADOR_GENERAL/FILTROS/PAGINA"/></xsl:attribute>
						</input>
       					<input type="hidden" name="NUMEROCOLUMNAS">
							<xsl:attribute name="value"><xsl:value-of select="/Buscador/BUSCADOR_GENERAL/TITULOS_CAMPOS/NUMERO"/></xsl:attribute>
						</input>
       					<input type="hidden" name="NUMEROFILAS">
							<xsl:attribute name="value"><xsl:value-of select="/Buscador/BUSCADOR_GENERAL/NUMEROFILAS"/></xsl:attribute>
						</input>
       					<input type="hidden" name="RESTRICCION" value="">
						</input>
       					<input type="hidden" name="RESTRICCIONEXTERNA">
							<xsl:attribute name="value"><xsl:value-of select="/Buscador/BUSCADOR_GENERAL/RESTRICCIONEXTERNA"/></xsl:attribute>
						</input>
       					<input type="hidden" name="ACCION" value="">
						</input>
						<!--	Viñeta		-->
						<td width="*">
							<xsl:choose>
								<xsl:when test="/Buscador/BUSCADOR_GENERAL/CHECKBOX">
									<a href="javascript:BotonPulsado();">
									<xsl:value-of select="/Buscador/BUSCADOR_GENERAL/CHECKBOX/NOMBRE"/>
									</a>
								</xsl:when>
								<xsl:otherwise>
									&nbsp;
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<xsl:for-each select="/Buscador/BUSCADOR_GENERAL/TITULOS_CAMPOS/TITULO_CAMPO">
						<td align="center">
							<xsl:attribute name="width"><xsl:value-of select="./ANCHO"/></xsl:attribute>
							<xsl:value-of select="./TITULO"/>
							<input type="hidden">
								<xsl:attribute name="name">NOMBRECAMPO_<xsl:value-of select="./@Pos"/></xsl:attribute>
								<xsl:attribute name="value"><xsl:value-of select="./NOMBRE"/></xsl:attribute>
							</input>
							<br/>
							<!--	Falta incluir filtro	-->
							<xsl:choose>
								<xsl:when test="./FILTRO='T'">
									<input type="text">
										<xsl:attribute name="name"><xsl:value-of select="./NOMBRE"/></xsl:attribute>
										<xsl:attribute name="value"><xsl:value-of select="./VALORACTUAL"/></xsl:attribute>
										<xsl:attribute name="size"><xsl:value-of select="./CARACTERES"/></xsl:attribute>
									</input>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="./field"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
						</xsl:for-each>
					</tr>
     				<xsl:for-each select="/Buscador/BUSCADOR_GENERAL/LINEAS/LINEA">
						<tr>
							<xsl:attribute name="class"><xsl:value-of select="CLASE"/></xsl:attribute>
							<xsl:attribute name="onMouseOver">this.className='medio'</xsl:attribute>
							<xsl:attribute name="onMouseOut">this.className='<xsl:value-of select="CLASE"/>'</xsl:attribute>
							<!--	Viñeta		-->
							<td align="center">
								<input type="hidden">
									<xsl:attribute name="name">ID_<xsl:value-of select="./NUMERO"/></xsl:attribute>
									<xsl:attribute name="value"><xsl:value-of select="./ID"/></xsl:attribute>
								</input>
								<xsl:choose>
									<xsl:when test="/Buscador/BUSCADOR_GENERAL/CHECKBOX">
										<input type="checkbox">
										<xsl:attribute name="name">CHECK_<xsl:value-of select="NUMERO"/></xsl:attribute>
										<xsl:choose>
											<xsl:when test="./ESTADOCHECK='S'">
												<xsl:attribute name="checked">checked</xsl:attribute>
											</xsl:when>
											<xsl:when test="./ESTADOCHECK='N'">
												<xsl:attribute name="unchecked">unchecked</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										</input>
									</xsl:when>
									<xsl:otherwise>
										<img src="http://www.newco.dev.br/images/BuscadorGeneral/Vinyeta1.gif"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
     						<xsl:for-each select="COLUMNA">
								<td>
									<xsl:attribute name="align"><xsl:value-of select="ALINEACION"/></xsl:attribute>
									<xsl:choose>
										<xsl:when test="./ACCION">
											<a>
												<xsl:attribute name="href"><xsl:value-of select="ACCION"/></xsl:attribute>
												<xsl:value-of select="NOMBRE"/>
											</a>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="NOMBRE"/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</xsl:for-each>
						</tr>
      				</xsl:for-each>
					</table>
					<br/><br/>
					<table width="100%" class="blanco" cellpadding="0" cellspacing="0" border="0" align="center" valign="center">
					<tr>
						<td width="40%" align="right">
							<xsl:if test="/Buscador/BUSCADOR_GENERAL/BOTONANTERIOR"> 
							<table width="20%" class="muyoscuro" cellpadding="1" cellspacing="1" border="0" align="center" valign="center">
							<tr>
								<td width="100%" align="center" class="claro">  
									<a href="javascript:PaginaAnterior();">Anterior</a>
								</td>
							</tr>
							</table>
							</xsl:if>
							&nbsp;
						</td>
						<td width="20%" align="center">
							<xsl:choose>
								<xsl:when test="/Buscador/BUSCADOR_GENERAL/TOTALREGISTROS=0">
									No se han encontrado resultados
								</xsl:when>
								<xsl:otherwise>
									Mostrando resultados <xsl:value-of select="/Buscador/BUSCADOR_GENERAL/PRIMERREGISTRO"/>
									..&nbsp;<xsl:value-of select="/Buscador/BUSCADOR_GENERAL/ULTIMOREGISTRO"/> 
									de  <xsl:value-of select="/Buscador/BUSCADOR_GENERAL/TOTALREGISTROS"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td width="40%" align="left">  
							<xsl:if test="/Buscador/BUSCADOR_GENERAL/BOTONSIGUIENTE"> 
							<table width="20%" class="muyoscuro" cellpadding="1" cellspacing="1" border="0" align="center" valign="center">
							<tr>
								<td width="100%" align="center" class="claro">  
									<a href="javascript:PaginaSiguiente();">Siguiente</a>
								</td>
							</tr>
							</table>
							</xsl:if>
							&nbsp;
						</td>
					</tr>
					</table>
				</td>
				</tr>
				</table>
			</xsl:otherwise>
		</xsl:choose>
		</td>
		</tr>
		</table>
		</form>
	</body>
    </html>
  </xsl:template>
  
  
<xsl:template match="LISTA_DATOS">
	<table cellpadding="1" cellspacing="1" border="0" align="center" valign="center" width="90%" class="BordeTabla">
	<tr class="claro" align="center">
	<td width="70%">
		<xsl:value-of select="./TITULO"/>
	</td>
	<td width="30%">
		Total
	</td>
	</tr>
	<xsl:for-each select="./LINEA_DATOS">
		<tr class="blanco">
		<td>
			<xsl:value-of select="NOMBRE"/>
		</td>
		<td align="center">
			<xsl:value-of select="TOTAL"/>
		</td>
		</tr>
	</xsl:for-each>
	</table>
</xsl:template>



</xsl:stylesheet>