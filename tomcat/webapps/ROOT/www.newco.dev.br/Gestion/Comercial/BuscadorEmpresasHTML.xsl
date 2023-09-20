<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado de empresas de MedicalVM con sus datos principales

	14set10		ET
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/ListadoEmpresas/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--
		function Enviar(){
			var form=document.forms[0];
			SubmitForm(form);
		}

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
		}

		function Continuar(){
			var form=document.forms[0],ListaIDs='';

			for(var n=0;n<form.length;n++){
				if(form.elements[n].name.match('CHK_')){
					if(form.elements[n].checked==true)
						ListaIDs=ListaIDs+Piece(form.elements[n].name,'_',1)+'|';
				}
			}

			if(ListaIDs=='')
				alert('Debe seleccionar al menos una empresa para poder continuar');
			else{
				form.elements['LISTAEMPRESAS'].value=ListaIDs;
				form.action="./ListadoCentros.xsql";
				SubmitForm(form);
			}
		}
	-->
	</script>
	]]></xsl:text>
</head>
<body>
	<form action="BuscadorEmpresas.xsql" method="POST" name="form1">
	<xsl:choose>
	<xsl:when test="ListadoEmpresas/SIN_DERECHOS">
		<!--	Sin derechos -> Página en blanco	-->
	</xsl:when>
	<xsl:otherwise>
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:value-of select="/ListadoEmpresas/LANG"/>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<!-- Campos ocultos para transmision de datos	-->
		<input type="hidden" name="LISTAEMPRESAS"/>
		<input type="hidden" id="IDENCUESTA" name="IDENCUESTA"/>
		<input type="hidden" id="FECHA"  name="FECHA"/>
		<input type="hidden" id="IDUSUARIO" name="IDUSUARIO"/>
		<input type="hidden" id="LISTACENTROS" name="LISTACENTROS"/>
		<input type="hidden" id="REFERENCIA" name="REFERENCIA"/>
		<input type="hidden" id="PRODUCTO" name="PRODUCTO"/>
		<input type="hidden" id="PROVEEDOR" name="PROVEEDOR"/>
		<input type="hidden" id="PRECIO" name="PRECIO"/>
		<input type="hidden" id="UNIDADBASICA" name="UNIDADBASICA"/>
		<input type="hidden" id="ESTADO" name="ESTADO" value="O" />
		<input type="hidden" id="ACCION" name="ACCION"/>
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/ListadoEmpresas/EMPRESAS/FILTROS/PAGINA}"/>



		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/>&nbsp;</span></p>
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/>&nbsp;
				(<xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_encontradas']/node()"/>: <xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL"/>)
				<span class="CompletarTitulo">
				<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>
				&nbsp;
				</span>
			</p>
		</div>
		<br/>



		<div class="divLeft">
		<!--
		<h1 class="titlePage">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_encontradas']/node()"/>: <xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL"/>)
			<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
			<a href="javascript:window.print();">
				<img src="http://www.newco.dev.br/images/imprimir.gif"/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
			</a>
		</h1>
		-->

		<!--<table class="grandeInicio" border="1">-->
		<table class="buscador">
		<thead>
			<tr class="subTituloTabla">
				<td class="tres">&nbsp;</td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></td>
				<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/></td>
				<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></td>

				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_30_dias_2line']/node()"/></td>
				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_365_dias_2line']/node()"/></td>
				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_catalogo_2line']/node()"/></td>

                <!--columnas diferentes de listadoEmpresa-->
				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='tareas_activas']/node()"/></td>
				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='estado_meddicc']/node()"/></td>
				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='meddicc_informado']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='meddicc_ok']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='meddicc_?']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='meddicc_ko']/node()"/></td>

			</tr>

			<tr class="select">
				<td><a href="javascript:SeleccionarTodas();"><strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></strong></a></td>
				<td><input type="text" id="FNOMBRE" name="FNOMBRE" maxlength="18" size="18" value="{/ListadoEmpresas/EMPRESAS/FILTROS/NOMBRE}"/></td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FPROVINCIA"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FPROVINCIA/field"/>
		                <xsl:with-param name="claSel">medio</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FIDTIPO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/TIPOEMPRESA/field"/>
		                <xsl:with-param name="claSel">medio</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCOMPRAS30DIAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/COMPRAS30DIAS/field"/>
		                <xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCOMPRAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/COMPRAS/field"/>
		                <xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCATALOGO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/CATALOGO/field"/>
		                <xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<!--inicio lineas diferentes gestion comercial-->
				<td>
                <!--tareas activas-->
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FTAREASACTIVAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/TAREASACTIVAS/field"/>
		                <xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
                <!--estadoo meddicc-->
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FMEDDICC_ESTADO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/MEDDICC_ESTADO/field"/>
		                <xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><!--meddicc informado-->
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FMEDDICC_INFORMADO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/MEDDICC_INFORMADO/field"/>
		                <xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>

				<td> <!--meddicc ok-->
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FMEDDICC_OK"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/MEDDICC_OK/field"/>
		                <xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><!--meddicc in-->
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FMEDDICC_IN"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/MEDDICC_IN/field"/>
		                <xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
                <td><!--meddicc ko-->
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FMEDDICC_KO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/MEDDICC_KO/field"/>
		                <xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td colspan="13" align="center">
					<!--<div class="botonCenter">-->
					<a class="btnDestacado" href="javascript:Enviar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='filtrar']/node()"/></a>
					<!--</div>-->
				</td>
			</tr>
		</thead>

		<tbody>
		<xsl:for-each select="/ListadoEmpresas/EMPRESAS/EMPRESA">
 			<tr>
				<td><xsl:value-of select="CONTADOR"/></td>
				<td class="textLeft">
					<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={EMP_ID}"><xsl:value-of select="NOMBRE"/></a>
				</td>
				<td class="textLeft"><xsl:value-of select="EMP_PROVINCIA"/></td>
				<td><xsl:value-of select="TIPOEMPRESA"/></td>

				<td><xsl:if test="EMP_CONSUMOMES != 'N'"><xsl:value-of select="EMP_CONSUMOMES"/></xsl:if></td>
				<td><xsl:if test="EMP_CONSUMOANNO != 'N'"><xsl:value-of select="EMP_CONSUMOANNO"/></xsl:if></td>
				<td><xsl:if test="EMP_LINEASCATALOGO != 'N'"><xsl:value-of select="EMP_LINEASCATALOGO"/></xsl:if></td>

                <!--nuevas lineas gestion comercial-->
				<td><xsl:if test="EMP_TAREASACTIVAS != ''">
                		<xsl:choose>
                        <xsl:when test="EMP_TAREASACTIVAS &gt; 0">
                        	<a href="http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql?FIDEMPRESA={EMP_ID}" style="font-weight:bold; background:#FF6; padding:2px 5px;">
                            	<xsl:value-of select="EMP_TAREASACTIVAS"/>
                            </a>
                        </xsl:when>
                        <xsl:otherwise>
                        	<a href="http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql?FIDEMPRESA={EMP_ID}">
                            	<xsl:value-of select="EMP_TAREASACTIVAS"/>
                            </a>
                        </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </td>
                <td><xsl:if test="EMP_ESTADOMEDDICC != ''"><xsl:value-of select="../FILTROS/MEDDICC_ESTADO/field/dropDownList/listElem[ID = ../../../../../EMPRESA/EMP_ESTADOMEDDICC]/listItem"/></xsl:if></td>

				<td><xsl:if test="EMP_MEDDICC_INFORMADO != ''">
                		<xsl:choose>
                        <xsl:when test="EMP_MEDDICC_INFORMADO = 'S'">
                        	<a href="http://www.newco.dev.br/Gestion/Comercial/Meddicc.xsql?FIDEMPRESA={EMP_ID}" style="font-weight:bold; background:#FF6; padding:2px 5px;">
                            	<xsl:value-of select="EMP_MEDDICC_INFORMADO"/>
                            </a>
                        </xsl:when>
                        <xsl:otherwise>
                        	<a href="http://www.newco.dev.br/Gestion/Comercial/Meddicc.xsql?FIDEMPRESA={EMP_ID}">
                            	<xsl:value-of select="EMP_MEDDICC_INFORMADO"/>
                            </a>
                        </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </td>
				<td><xsl:if test="EMP_MEDDICC_ENTRADASOK != ''">
                		<span style="font-weight:bold; color:#36970B;"><xsl:value-of select="EMP_MEDDICC_ENTRADASOK"/></span>
                    </xsl:if>
                </td>
				<td><xsl:if test="EMP_MEDDICC_ENTRADASIN != ''">
                		<span style="font-weight:bold; color:#F60;"><xsl:value-of select="EMP_MEDDICC_ENTRADASIN"/></span>
                    </xsl:if>
                </td>
				<td><xsl:if test="EMP_MEDDICC_ENTRADASKO != ''">
                		<span style="font-weight:bold; color:#F00;"><xsl:value-of select="EMP_MEDDICC_ENTRADASKO"/></span>
                    </xsl:if>
                </td>

			</tr>
		</xsl:for-each>
		</tbody>

		<!--<tfoot>
			<tr>
				<td colspan="13">
					<div class="botonCenter">
						<a href="javascript:Continuar();" title="Buscar los centros correspondientes a las empresas seleccionadas"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar_centros']/node()"/></a>
					</div>
				</td>
			</tr>
		</tfoot>-->
		</table>
        </div><!--fin de divLeft-->
	</xsl:otherwise>
	</xsl:choose>
		</form>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
