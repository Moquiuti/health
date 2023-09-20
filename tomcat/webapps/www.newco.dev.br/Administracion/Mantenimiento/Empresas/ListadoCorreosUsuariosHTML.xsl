<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Consulta de emails de usuarios
	Ultima revision: ET 16oct17	09:50
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>

	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--
		//	Funciones de Javascript

		//	Selecciona/Deselecciona todos los checkboxes
		function SeleccionarTodas(){
			var form=document.forms[0],Valor='';

			for(var n=0;n<form.length;n++){
				if(form.elements[n].name.match('CHK_')){
					if(Valor=='')
						if(form.elements[n].checked==true)
							Valor='N';
						else
							Valor='S';

					if(Valor=='S')
						form.elements[n].checked=true;
					else
						form.elements[n].checked=false;
				}
			}
			PulsadoCheck();
		}

		//	Recorre el formulario y muestra la dirección de los usuarios activos
		function PulsadoCheck(){
			var form=document.forms[0],Valor='',ListaDirecciones='';

			for(var n=0;n<form.length;n++){
				if(form.elements[n].name.match('CHK_')){
					if(form.elements[n].checked==true && form.elements['EMAIL_'+Piece(form.elements[n].name,'_',1)].value != '')
						ListaDirecciones=ListaDirecciones
							+'"'+form.elements['NOMBRE_'+Piece(form.elements[n].name,'_',1)].value+'"'
							+'<'+form.elements['EMAIL_'+Piece(form.elements[n].name,'_',1)].value+'>,';
				}
			}

			form.elements['ListaDirecciones'].value=ListaDirecciones;
		}

		function CambiarEmpresa(idEmpresa){
			//var objFrame=new Object();
			//objFrame=obtenerFrame(top, 'zonaEmpresa');
			//objFrame.CambioEmpresaActual(idEmpresa);
			parent.zonaEmpresa.CambioEmpresaActual(idEmpresa);
		}

		function CambiarCentro(idEmpresa, idCentro){
			//var objFrame=new Object();
			//objFrame=obtenerFrame(top, 'zonaEmpresa');
			//objFrame.CambioCentroActual(idEmpresa, idCentro);
			parent.zonaEmpresa.CambioCentroActual(idEmpresa, idCentro);
		}

		function Enviar(){
			var form=document.forms[0];
			SubmitForm(form);
		}

		function EditarUsuario(url,idempresa){
			//var emp_id=empresa;
			//var objFrame=new Object();
			//objFrame=obtenerFrame(top,'areaTrabajo');
			//objFrame.location.href=url+'&EMP_ID='+idempresa
			parent.areaTrabajo.location.href=url+'&EMP_ID='+idempresa
		}

		
		function Buscar() {document.forms[0].elements['PAGINA'].value=0; Enviar();}
		function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=document.forms[0].elements['PAGINA'].value-1; Enviar();}
		function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Enviar();}

	-->
	</script>
	]]></xsl:text>
</head>
<body>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Correos/LANG"><xsl:value-of select="/Correos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<form method="post" action="ListadoCorreosUsuarios.xsql">
		<input type="hidden" name="LISTAEMPRESAS"/>
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/Correos/USUARIOS/FILTROS/PAGINA}" />
		<input type="hidden" id="IDPAIS" name="IDPAIS" value="{/Correos/USUARIOS/FILTROS/IDPAIS}" />
		<!-- <div class="titlePage"> <xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios']/node()"/></div>-->

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_empresas']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios']/node()"/></span></p>
			<p class="TituloPagina">
        	  <xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/>: <xsl:value-of select="/Correos/USUARIOS/TOTAL"/>)
			  <span class="CompletarTitulo">
			  <!--	Botones	-->
			  </span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>

		<div class="divLeft">
			<table class="buscador">
			<!--<table class="grandeInicio">-->
			<!-- Titulo -->
			<thead>
				<!--
				<tr class="tituloTabla">
					<td colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/>: <xsl:value-of select="/Correos/USUARIOS/TOTAL"/>)</td>
				</tr>
				-->
				<!--<tr class="titulos">-->
				<tr class="subTituloTabla">
					<!--<td class="uno">&nbsp;</td>-->
					<td class="tres" colspan="2"><a href="javascript:SeleccionarTodas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></td>
					<td class="ocho" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></td>
					<td class="ocho" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
					<td class="quince" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='rol']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='admin']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cdc']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='navegar_provee']/node()"/>&nbsp;</td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='control_acessos']/node()"/>&nbsp;</td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_controlado']/node()"/>&nbsp;</td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_catalogo']/node()"/>&nbsp;</td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ofertas']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear_ocultos']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ultimo_acceso']/node()"/></td>
				</tr>
				<!--<tr class="select">-->
				<tr class="filtros">
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="3"><input type="text" id="US_NOMBRE" name="US_NOMBRE" maxlength="20" size="50" value="{/Correos/USUARIOS/FILTROS/NOMBRE}"/></td>
					<td>&nbsp;</td>
                        <td>
                        	<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_TIPO_EMPRESA"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/TIPOEMPRESA/field" />
                            </xsl:call-template>
                        </td>
                        <td>
                        	<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_DERECHOS"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/DERECHOS/field" />
							<xsl:with-param name="claSel">peq</xsl:with-param>
                            </xsl:call-template>
                        </td>
                        <td>
                        	<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_CDC"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/CDC/field" />
							<xsl:with-param name="claSel">peq</xsl:with-param>
							</xsl:call-template>
                        </td>
                        <td>
                       		<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_DERECHOSEIS"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/DERECHOSEIS/field" />
							<xsl:with-param name="claSel">peq</xsl:with-param>
                            </xsl:call-template>
                        </td>
                        <td>
                        	<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_NAVEGAR_PROVEE"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/NAVEGARPROVEEDORES/field" />
							<xsl:with-param name="claSel">peq</xsl:with-param>
                            </xsl:call-template>
                        </td>
                        <td>
                        	<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_CONTROL_ACCESOS"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/CONTROLACCESOS/field" />
							<xsl:with-param name="claSel">peq</xsl:with-param>
                            </xsl:call-template>
                        </td>
                        <td><!--usuario_controlado-->
                        	<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_PEDIDOS_CONTROLADOS"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/PEDIDOSCONTROLADOS/field" />
 							<xsl:with-param name="claSel">peq</xsl:with-param>
                           </xsl:call-template>
                        </td>
                        <td><!--avisos catalogo-->
                        	<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_AVISOS_CATALOGOS"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/AVISOSCATALOGOS/field" />
							<xsl:with-param name="claSel">peq</xsl:with-param>
                            </xsl:call-template>
                        </td>
                        <td>
                        	<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_VER_OFERTAS"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/VEROFERTAS/field" />
							<xsl:with-param name="claSel">peq</xsl:with-param>
                            </xsl:call-template>
                        </td>
                        <td>
                            <xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="US_BLOQUEAR_OCULTOS"/>
							<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/BLOQUEAROCULTOS/field" />
							<xsl:with-param name="claSel">peq</xsl:with-param>
                            </xsl:call-template>
                        </td>
                        <td>&nbsp;</td>
					</tr>	
					<!--<tr class="select">	-->
					<tr class="filtros">	
						<td colspan="5" align="right">
							<xsl:if test="/Correos/USUARIOS/ANTERIOR">
								<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
							</xsl:if>
						</td>
						<td colspan="4">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;
							<xsl:call-template name="desplegable">
								<xsl:with-param name="id" value="LINEASPORPAGINA"/>
								<xsl:with-param name="path" select="/Correos/USUARIOS/FILTROS/LINEASPORPAGINA/field"/>
							</xsl:call-template>
						</td>
						<!--<td colspan="17" align="center">-->
						<td align="center">
                        	<!--div class="botonCenter">-->
                            <a class="btnDestacado" href="javascript:Enviar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='filtrar']/node()"/></a>
                           	<!--</div>-->
						</td>
						<td colspan="7" align="left">
							<xsl:if test="/Correos/USUARIOS/SIGUIENTE">
								<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
							</xsl:if>
						</td>
					</tr>	
              </thead>
		<xsl:choose>
		<xsl:when test="/Correos/USUARIOS/USUARIO">
              <tbody>
        	  <xsl:for-each select="/Correos/USUARIOS/USUARIO">
            	<tr>
				<td><xsl:value-of select="CONTADOR"/></td>
                	<td>
						<input class="muypeq" type="checkbox" name="CHK_{ID}" onchange="javascript:PulsadoCheck();"/>
						<input type="hidden" name="EMAIL_{ID}" value="{EMAIL}"/>
						<input type="hidden" name="NOMBRE_{ID}" value="{NOMBRE}"/>
					</td>
                	<td class="textLeft">
                            <a href="javascript:CambiarEmpresa({IDEMPRESA});">
                                <xsl:choose>
                                    <xsl:when test="EMPRESA_NOMBRECORTO != ''"><xsl:value-of select="EMPRESA_NOMBRECORTO"/></xsl:when>
                                    <xsl:otherwise><xsl:value-of select="EMPRESA"/></xsl:otherwise>
                                </xsl:choose>
                            </a>
                        </td>
                	<td class="textLeft">
                            <a href="javascript:CambiarCentro({IDEMPRESA},{IDCENTRO});">
                                 <xsl:choose>
                                    <xsl:when test="CENTRO_NOMBRECORTO != ''"><xsl:value-of select="CENTRO_NOMBRECORTO"/></xsl:when>
                                    <xsl:otherwise><xsl:value-of select="CENTRO"/></xsl:otherwise>
                                </xsl:choose>
                            </a>
                        </td>
                	<td class="textLeft">
                    	<a href="javascript:EditarUsuario('./USManten.xsql?ID_USUARIO={ID}',{IDEMPRESA}); CambiarCentro({IDEMPRESA},{IDCENTRO});"><xsl:value-of select="NOMBRE"/></a>
                    </td>
                	<td><xsl:value-of select="TELEFONO"/>&nbsp;</td>
                    <td><xsl:value-of select="ROL"/></td>
               		<td><xsl:value-of select="DERECHOS"/></td>
               		<td><xsl:value-of select="CDC"/></td>
               		<td><xsl:value-of select="DERECHOSEIS"/></td>
               		<td><xsl:value-of select="NAVEGARPROVEEDORES"/></td>
                    <td><xsl:value-of select="CONTROLACCESOS"/></td>
                    <td><xsl:value-of select="USUARIOCONTROL"/></td>
                    <td><xsl:value-of select="AVISOSCAMBIOSCAT"/></td>
               		<td><xsl:value-of select="VEROFERTAS"/></td>
               		<td><xsl:value-of select="BLOQUEAROCULTOS"/></td>
               		<td><xsl:value-of select="ULTIMOACCESO"/></td>
				</tr>
			  </xsl:for-each>	   
              </tbody> 
        	  <tfoot>
			<tr class="sinLinea">
			<td colspan="17">
			&nbsp;
			</td>
			</tr>
            <tr class="sinLinea">
              <td colspan="5">&nbsp;</td>
              <td colspan="2">
                  <!--<div class="boton">-->
                    <a class="btnDestacado" href="javascript:history.go(-1);" title="Volver al paso anterior"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a>
                  <!--</div>-->
			  </td>
              <td colspan="10">&nbsp;</td>
			</tr>
			<tr class="sinLinea">
			<td colspan="17">
			<textarea name="ListaDirecciones" rows="20" cols="150">
			</textarea>
			</td>
			</tr>
            </tfoot>
	</xsl:when>
	<xsl:otherwise>
		<tr><td colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></td></tr>
	</xsl:otherwise>
	</xsl:choose>
		</table>
        </div>   
		</form>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>

