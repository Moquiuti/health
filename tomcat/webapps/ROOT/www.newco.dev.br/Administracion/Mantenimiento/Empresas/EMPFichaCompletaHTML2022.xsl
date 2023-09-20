<?xml version="1.0" encoding="iso-8859-1" ?>
<!--  
	Ficha completa de proveedor, para proveedores OHSJD
	ultima revision: ET 9ene23 18:26 EMPFichaCompleta2022_090123.js
--> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:import href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/Comentarios_lib.xsl"/>

<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
    	<xsl:choose>
        	<xsl:when test="/MantenimientoEmpresas/LANG"><xsl:value-of select="/MantenimientoEmpresas/LANG" /></xsl:when>
        	<xsl:otherwise>spanish</xsl:otherwise>
    	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>
	
	<title>
	<xsl:value-of select="substring(/FichaEmpresa/EMPRESA/EMP_NOMBRECORTO,0,60)"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_completa_proveedor']/node()"/>
	</title>
	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/parsley_2.8.1.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/parsley.es.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPFichaCompleta2022_090123.js"></script>

</head>

<body onload="javascript:onloadEvents();">
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:for-each select="//SESION_CADUCADA">
			<xsl:if test="position()=last()">
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="Lista/xsql-error">
		<xsl:apply-templates select="//xsql-error"/>
	</xsl:when>
	<!--
	|
	+-->
	<xsl:when test="FichaEmpresa/Status">
		<xsl:apply-templates select="FichaEmpresa/Status"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:choose>
		<xsl:when test="FichaEmpresa/EMPRESA/EMP_ID != 0 and FichaEmpresa/EMPRESA/EMP_IDTIPO = 0">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_datos_empresa']/node()"/>
			<xsl:value-of select="/FichaEmpresa/EMPRESA/EMP_ID" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="FichaEmpresa/EMPRESA"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:otherwise>
	</xsl:choose>

</body>
</html>
</xsl:template>


<xsl:template match="EMPRESA">

	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/FichaEmpresa/LANG"><xsl:value-of select="/FichaEmpresa/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:choose>
			<xsl:when test="BOTONES_APROBARACTUALIZAR">
				<xsl:value-of select="substring(/FichaEmpresa/EMPRESA/EMP_NOMBRECORTO,0,60)" />:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedor_solicita_actualizar_datos_ficha']/node()"/>
			</xsl:when>
			<xsl:otherwise>
        		<xsl:value-of select="substring(/FichaEmpresa/EMPRESA/EMP_NOMBRECORTO,0,60)" />:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_completa_proveedor']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			&nbsp;&nbsp;<span class="fuentePeq">(<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_modificacion']/node()"/>:&nbsp;<xsl:value-of select="/FichaEmpresa/EMPRESA/EMP_ULTIMOCAMBIO" />)</span>
			<span class="CompletarTitulo">
				<!--	Botones	-->
				<xsl:if test="BOTON_ENVIAR">
                	<a class="btnDestacado" href="javascript:PublicarFicha();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
                    </a>
					&nbsp;
				</xsl:if>
				<xsl:if test="BOTONES_APROBACION">
                	<a class="btnDestacado" href="javascript:AprobarFicha();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='Aprobar']/node()"/>
                    </a>
					&nbsp;
                	<a class="btnDestacado" href="javascript:RechazarFicha();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
                    </a>
					&nbsp;
				</xsl:if>
				<xsl:if test="BOTON_SOLICITARACTUALIZAR">
                	<a class="btnDestacado" href="javascript:SolicitarActualizar();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='SolicitarActualizar']/node()"/>
                    </a>
					&nbsp;
				</xsl:if>
				<xsl:if test="BOTONES_APROBARACTUALIZAR">
                	<a class="btnDestacado" href="javascript:AprobarActualizar();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='Aprobar']/node()"/>
                    </a>
					&nbsp;
                	<a class="btnDestacado" href="javascript:RechazarActualizar();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
                    </a>
					&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
 	<div class="divLeft">
		<ul class="pestannas">
			<li>
				<a id="pes_FichaBasica" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/FICHA">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_basica']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_UsRepresentante" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/US_REPRESENTANTE">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Us_representante']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_UsGerente" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/US_GERENTE">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Us_gerente']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_DirFinanciero" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/US_DIRFINANCIERO">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Us_dir_financiero']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_EncCartera" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/US_ENCARGADOCARTERA">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Us_enc_cartera']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_ServCliente" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/US_SERVCLIENTE">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Us_serv_cliente']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_DirComercial" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/US_DIRCOMERCIAL">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Us_dir_comercial']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_UsRepDirecto" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/US_REPDIRECTO">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Us_rep_directo']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_DatosFin" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/DATOSFIN">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Datos_financieros']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_Cuenta1" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/CUENTABANC1">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='C_bancaria']/node()"/>&nbsp;1
				</a>
			</li>
			<li>
				<a id="pes_Cuenta2" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/CUENTABANC2">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='C_bancaria']/node()"/>&nbsp;2
				</a>
			</li>
			<li>
				<a id="pes_DatosPago" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/DATOSPAGO">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Datos_pago']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_DatosEntrega" class="MenuInactivo">
            	<xsl:choose>
                	<xsl:when test="PESTANNAS_INFORMADAS/DATOSENTREGA">
						<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
          			</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Datos_entrega']/node()"/>
				</a>
			</li>
		</ul>
	</div>
	<br/>
	<br/>

	<div class="divLeft divForm" id="div_pes_FichaBasica">
	<form id="frmFicha" name="frmFicha" data-parsley-validate="" method="post" action="EMPFichaCompleta2022.xsql">
	<input type="hidden" name="EMP_ID" id="EMP_ID" value="{EMP_ID}"/>
	<input type="hidden" name="ACCION" id="ACCION" value=""/>
	<input type="hidden" name="PLAZO_PAGO" id="PLAZO_PAGO" value="{PLAZO_PAGO}"/>
	<input type="hidden" name="DESC_PAGO_30DIAS" id="DESC_PAGO_30DIAS" value="{DESC_PAGO_30DIAS}"/>
	<input type="hidden" name="DESC_PAGO_60DIAS" id="DESC_PAGO_60DIAS" value="{DESC_PAGO_60DIAS}"/>
	<input type="hidden" name="DESC_PAGO_90DIAS" id="DESC_PAGO_90DIAS" value="{DESC_PAGO_90DIAS}"/>
	<input type="hidden" name="DESC_PAGO_120DIAS" id="DESC_PAGO_120DIAS" value="{DESC_PAGO_120DIAS}"/>
	<table cellspacing="6px" cellpadding="6px">

	<tr class="sinLinea">
		<td colspan="2">
			<span class="naranja"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span><br/>
			<span class="sinLinea bs-callout bs-callout-info verde" id="msgOK" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_correcto']/node()"/></span>
			<span class="sinLinea bs-callout bs-callout-warning rojo" id="msgError" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_incorrecto']/node()"/></span>
			<br/>
		</td>
	</tr>
	
	<tr class="sinLinea">
		<!--
        <td class="quince" rowspan="3">
            <img src="{/FichaEmpresa/EMPRESA/URL_LOGOTIPO}" height="80px" width="160px"/>
		</td>
		-->
		<td class="labelRight cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="EMP_NOMBRE"/>
		</xsl:when>
		<xsl:otherwise>
        	<input type="hidden" name="EMP_NOMBRE_OLD" value="{EMP_NOMBRE}"/>
			<input type="text" name="EMP_NOMBRE" class="form-control grande" data-parsley-trigger="change" required="" maxlength="100" value="{EMP_NOMBRE}" />
		</xsl:otherwise>
		</xsl:choose>
		</td>
		<input type="hidden" id="EMP_IDPAIS" name="EMP_IDPAIS" value="{/FichaEmpresa/EMPRESA/EMP_IDPAIS}" />
	</tr>

    <tr class="sinLinea">
		<td class="labelRight">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto_publico']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
        <xsl:choose>
        <xsl:when test="NOEDICION">
                &nbsp;<xsl:value-of select="EMP_NOMBRECORTO"/>
        </xsl:when>
        <xsl:otherwise>
                <input type="text" name="EMP_NOMBRECORTO" class="form-control grande" data-parsley-trigger="change" required="" maxlength="40" size="23" value="{EMP_NOMBRECORTO}"/>
        </xsl:otherwise>
        </xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='NIF']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="EMP_NIF"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_NIF" class="form-control" data-parsley-trigger="change" required="" maxlength="20" value="{EMP_NIF}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<!-- Solo para Colombia	-->
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='control_NIF']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="EMP_CONTROLNIF"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_CONTROLNIF" class="form-control muypeq" data-parsley-trigger="change" data-parsley-type="number" required="" maxlength="1" style="height:20px;" value="{EMP_CONTROLNIF}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td colspan="2" class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="EMP_DIRECCION"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_DIRECCION" class="form-control grande" data-parsley-trigger="change" required="" maxlength="100" value="{EMP_DIRECCION}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="EMP_CPOSTAL"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_CPOSTAL" class="form-control" data-parsley-trigger="change" data-parsley-type="alphanum" required="" maxlength="20" value="{EMP_CPOSTAL}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="EMP_POBLACION"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_POBLACION" class="form-control" data-parsley-trigger="change" data-parsley-type="alphanum" required="" maxlength="200" value="{EMP_POBLACION}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
    <!--provincia-->
      <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
      <td class="textLeft">
        <xsl:choose>
          <xsl:when test="NOEDICION">
	         &nbsp; <xsl:value-of select="/FichaEmpresa/EMPRESA/EMP_PROVINCIA"/>
          </xsl:when>
          <xsl:otherwise>
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/FichaEmpresa/EMPRESA/PROVINCIA/field"></xsl:with-param>
                <xsl:with-param name="defecto" select="/FichaEmpresa/EMPRESA/EMP_PROVINCIA"/>
				<xsl:with-param name="claSel">form-control</xsl:with-param>
				<xsl:with-param name="required">required</xsl:with-param>
				</xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        </td>
	</tr>

	<tr class="sinLinea">
        <xsl:choose>
        <xsl:when test="PAISES/field/@current = '34'">
	        <td colspan="2">&nbsp;<input type="hidden" name="EMP_BARRIO" value="{EMP_BARRIO}"/></td>
		</xsl:when>
		<xsl:otherwise>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='barrio']/node()"/>:<span class="camposObligatorios">*</span>
			</td>
			<td class="textLeft">
				<xsl:choose>
				<xsl:when test="NOEDICION">
					<xsl:value-of select="EMP_BARRIO"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="text" name="EMP_BARRIO" class="form-control" data-parsley-trigger="change" data-parsley-type="alphanum" required="" maxlength="50" value="{EMP_BARRIO}"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:otherwise>
        </xsl:choose>
    </tr>
    <tr class="sinLinea">
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
      <td class="textLeft">
        <xsl:choose>
          <xsl:when test="NOEDICION">
            &nbsp;<xsl:value-of select="EMP_TELEFONO"/>
          </xsl:when>
          <xsl:otherwise>
        	<input type="text" name="EMP_TELEFONO" class="form-control" data-parsley-trigger="change" required="" maxlength="50" value="{EMP_TELEFONO}"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
	</tr>

	<tr class="sinLinea">
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>2:&nbsp;
        </td>
      <td class="textLeft">
        <xsl:choose>
          <xsl:when test="NOEDICION">
            &nbsp;<xsl:value-of select="EMP_TELEFONO2"/>
          </xsl:when>
          <xsl:otherwise>
        	<input type="text" name="EMP_TELEFONO2" class="form-control" data-parsley-trigger="change" maxlength="50" value="{EMP_TELEFONO2}"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>

	<tr class="sinLinea">
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='exped_camara']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
      <td class="textLeft">
        <xsl:choose>
          <xsl:when test="NOEDICION">
            &nbsp;<xsl:value-of select="EMP_EXPEDICIONCAMARA"/>
          </xsl:when>
          <xsl:otherwise>
        	<input type="text" name="EMP_EXPEDICIONCAMARA" class="form-control" data-parsley-trigger="change" required="" maxlength="50" value="{EMP_EXPEDICIONCAMARA}"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
	
    <tr class="sinLinea">
    	<td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='enlace']/node()"/>:&nbsp;
       </td>
       <td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="EMP_ENLACE"/>
			</xsl:when>
			<xsl:otherwise>
        		<input type="text" class="form-control grande" data-parsley-trigger="change" name="EMP_ENLACE" maxlength="200" size="30">
            		<xsl:attribute name="value">
                		<xsl:choose>
                		<xsl:when test="EMP_ENLACE != ''"><xsl:value-of select="EMP_ENLACE"/></xsl:when>
                    	<xsl:otherwise>http://</xsl:otherwise>
                    	</xsl:choose>
                	</xsl:attribute>
            	</input>
			</xsl:otherwise>
			</xsl:choose>
        </td>
    </tr>
    <tr class="sinLinea">
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='email']/node()"/>:<span class="camposObligatorios">*</span>
		</td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="EMP_EMAIL"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="email" class="form-control grande" data-parsley-trigger="change" required="" name="EMP_EMAIL" maxlength="100" value="{EMP_EMAIL}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
    </tr>
	<xsl:if test="not(NOEDICION)">
    <tr class="sinLinea">
		<td class="labelRight">
		</td>
		<td class="textLeft">
            <a class="btnDestacado" href="javascript:ValidarYEnviar('frmFicha');">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
			</a>
			&nbsp;
		</td>
    </tr>
	</xsl:if>
</table>
</form>
</div><!--fin ficha empresa-->

<div class="divLeft divForm" id="div_pes_DatosFin">
<form id="frmDatosFin" name="frmDatosFin" data-parsley-validate="" method="post" action="EMPDatosFinancieros2022.xsql">
<input type="hidden" name="EMP_ID" id="EMP_ID" value="{EMP_ID}"/>
<table cellspacing="6px" cellpadding="6px">

	<tr class="sinLinea">
		<td colspan="2">
			<span class="naranja"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span><br/>
			<span class="sinLinea bs-callout bs-callout-info verde" id="msgOK" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_correcto']/node()"/></span>
			<span class="sinLinea bs-callout bs-callout-warning rojo" id="msgError" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_incorrecto']/node()"/></span>
			<br/>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='Regimen']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_REGIMEN/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_REGIMEN/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		
		<!--	Esta estructura no funcioa, parece error de XSLT
		<xsl:call-template name="desplegable">
		<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_REGIMEN/field"></xsl:with-param>
		<xsl:with-param name="claSel">form-control</xsl:with-param>
		<xsl:with-param name="required">required</xsl:with-param>
		<xsl:if test="NOEDICION">
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
		</xsl:if>
		</xsl:call-template>
		-->
		</td>
	</tr>

    <tr class="sinLinea">
		<td class="labelRight">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_proveedor']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_TIPOPROVEEDOR/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_TIPOPROVEEDOR/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_persona']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_TIPOPERSONA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_TIPOPERSONA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Gran_contribuyente']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_GRANCONTRIBUYENTE/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w100px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_GRANCONTRIBUYENTE/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w100px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Num_resolucion']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td colspan="2" class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSFINANCIEROS/NUMRESOLUCION"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="NUMRESOLUCION" class="form-control" data-parsley-trigger="change" required="" maxlength="100" value="{DATOSFINANCIEROS/NUMRESOLUCION}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Declara_renta']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_DECLARARENTA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w100px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_DECLARARENTA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w100px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_empresa']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_TIPOEMPRESA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_TIPOEMPRESA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Exento_retencion']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_EXENTORETENCION/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w100px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_EXENTORETENCION/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w100px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Autoretenedor_IVA']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_AUTORETENEDORIVA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w100px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="DATOSFINANCIEROS/EMP_FIF_AUTORETENEDORIVA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w100px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Actividad_economica']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSFINANCIEROS/ACTIVIDADECONOMICA"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="ACTIVIDADECONOMICA" class="form-control grande" data-parsley-trigger="change" required="" maxlength="200" value="{DATOSFINANCIEROS/ACTIVIDADECONOMICA}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<xsl:if test="not(NOEDICION)">
    <tr class="sinLinea">
		<td class="labelRight">
		</td>
		<td class="textLeft">
            <a class="btnDestacado" href="javascript:ValidarYEnviar('frmDatosFin');">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
			</a>
			&nbsp;
		</td>
    </tr>
	</xsl:if>
<!--
	<tr class="sinLinea">
      <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
      <td class="textLeft">
        <xsl:choose>
          <xsl:when test="NOEDICION">
	          <xsl:value-of select="/FichaEmpresa/EMPRESA/EMP_PROVINCIA"/>
          </xsl:when>
          <xsl:otherwise>
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/FichaEmpresa/EMPRESA/PROVINCIA/field"></xsl:with-param>
                <xsl:with-param name="defecto" select="/FichaEmpresa/EMPRESA/EMP_PROVINCIA"/>
				</xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        </td>
	</tr>
-->
</table>
</form>

</div><!--fin divLeft datos financieros-->

<!--	USUARIOS: REPRESENTANTE, GERENTE, DIRFINANCIERO, ENCARGADOCARTERA, SERVCLIENTE, DIRCOMERCIAL, REPDIRECTO		-->
<xsl:call-template name="frmUsuario">
	<xsl:with-param name="path" select="USUARIOS/USUARIO_REPRESENTANTE/USUARIO"/>
	<xsl:with-param name="nombreForm">UsRepresentante</xsl:with-param>
	<xsl:with-param name="doc" select="$doc"/>
</xsl:call-template>

<xsl:call-template name="frmUsuario">
	<xsl:with-param name="path" select="USUARIOS/USUARIO_GERENTE/USUARIO"/>
	<xsl:with-param name="nombreForm">UsGerente</xsl:with-param>
	<xsl:with-param name="doc" select="$doc"/>
</xsl:call-template>

<xsl:call-template name="frmUsuario">
	<xsl:with-param name="path" select="USUARIOS/USUARIO_DIRFINANCIERO/USUARIO"/>
	<xsl:with-param name="nombreForm">DirFinanciero</xsl:with-param>
	<xsl:with-param name="doc" select="$doc"/>
</xsl:call-template>

<xsl:call-template name="frmUsuario">
	<xsl:with-param name="path" select="USUARIOS/USUARIO_ENCARGADOCARTERA/USUARIO"/>
	<xsl:with-param name="nombreForm">EncCartera</xsl:with-param>
	<xsl:with-param name="doc" select="$doc"/>
</xsl:call-template>

<xsl:call-template name="frmUsuario">
	<xsl:with-param name="path" select="USUARIOS/USUARIO_SERVCLIENTE/USUARIO"/>
	<xsl:with-param name="nombreForm">ServCliente</xsl:with-param>
	<xsl:with-param name="doc" select="$doc"/>
</xsl:call-template>

<xsl:call-template name="frmUsuario">
	<xsl:with-param name="path" select="USUARIOS/USUARIO_DIRCOMERCIAL/USUARIO"/>
	<xsl:with-param name="nombreForm">DirComercial</xsl:with-param>
	<xsl:with-param name="doc" select="$doc"/>
</xsl:call-template>

<xsl:call-template name="frmUsuario">
	<xsl:with-param name="path" select="USUARIOS/USUARIO_REPDIRECTO/USUARIO"/>
	<xsl:with-param name="nombreForm">UsRepDirecto</xsl:with-param>
	<xsl:with-param name="doc" select="$doc"/>
</xsl:call-template>

<xsl:call-template name="frmCuenta">
	<xsl:with-param name="path" select="CUENTAS/CUENTA_1/CUENTA"/>
	<xsl:with-param name="nombreForm">Cuenta1</xsl:with-param>
	<xsl:with-param name="doc" select="$doc"/>
</xsl:call-template>

<xsl:call-template name="frmCuenta">
	<xsl:with-param name="path" select="CUENTAS/CUENTA_2/CUENTA"/>
	<xsl:with-param name="nombreForm">Cuenta2</xsl:with-param>
	<xsl:with-param name="doc" select="$doc"/>
</xsl:call-template>

</xsl:template>



<xsl:template name="frmUsuario">
<xsl:param name="path" />
<xsl:param name="nombreForm" />
<xsl:param name="doc" />

<div class="divLeft divForm" id="div_pes_{$nombreForm}">
<form id="{$nombreForm}" name="{$nombreForm}" data-parsley-validate="" method="post" action="EMPUsuario2022.xsql">
<input type="hidden" name="EMP_ID" id="EMP_ID" value="{$path/EMP_ID}"/>&nbsp;&nbsp;
<input type="hidden" name="CARGO" id="CARGO" value="{$path/CARGO}"/>&nbsp;&nbsp;
<table cellspacing="6px" cellpadding="6px">

	<tr class="sinLinea">
		<td colspan="2">
			<span class="naranja"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span><br/>
			<span class="sinLinea bs-callout bs-callout-info verde" id="msgOK" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_correcto']/node()"/></span>
			<span class="sinLinea bs-callout bs-callout-warning rojo" id="msgError" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_incorrecto']/node()"/></span>
			<br/>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_completo']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="$path/NOMBRECOMPLETO"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="NOMBRECOMPLETO" class="form-control" data-parsley-trigger="change" required="" maxlength="100" value="{$path/NOMBRECOMPLETO}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='email']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="$path/EMAIL"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="email" name="EMAIL" class="form-control" data-parsley-trigger="change" data-parsley-type="alphanum" required="" maxlength="100" value="{$path/EMAIL}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="$path/TELEFONO"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="TELEFONO" class="form-control" data-parsley-trigger="change" required="" maxlength="50" value="{$path/TELEFONO}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_identificacion']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="$path/EMP_FIU_TIPOIDENTIFICACION/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="$path/EMP_FIU_TIPOIDENTIFICACION/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		<!--
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="$path/TIPOIDENTIFICACION"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="TIPOIDENTIFICACION" class="form-control" data-parsley-trigger="change" required="" maxlength="200" value="{$path/TIPOIDENTIFICACION}"/>
		</xsl:otherwise>
		</xsl:choose>
		-->
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Identificacion']/node()"/>:&nbsp;</td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="$path/IDENTIFICACION"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="IDENTIFICACION" class="form-control" data-parsley-trigger="change" maxlength="50" value="{$path/IDENTIFICACION}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<xsl:if test="not(NOEDICION)">
    <tr class="sinLinea">
		<td class="labelRight">
		</td>
		<td class="textLeft">
            <a class="btnDestacado" href="javascript:ValidarYEnviar('{$nombreForm}');">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
			</a>
			&nbsp;
		</td>
    </tr>
	</xsl:if>
	</table>
	</form>
	</div>
</xsl:template>

<xsl:template name="frmCuenta">
    <xsl:param name="path" />
    <xsl:param name="nombreForm" />
    <xsl:param name="doc" />
        
	<div class="divLeft divForm" id="div_pes_{$nombreForm}">
	<form id="{$nombreForm}" name="{$nombreForm}" data-parsley-validate="" method="post" action="EMPCuentaBancaria2022.xsql">
	<input type="hidden" name="EMP_ID" id="EMP_ID" value="{$path/EMP_ID}"/>&nbsp;&nbsp;
	<input type="hidden" name="ORDEN" id="ORDEN" value="{$path/ORDEN}"/>&nbsp;&nbsp;
	<table cellspacing="6px" cellpadding="6px">
	<tr class="sinLinea">
		<td colspan="2">
			<span class="naranja"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span><br/>
			<span class="sinLinea bs-callout bs-callout-info verde" id="msgOK" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_correcto']/node()"/></span>
			<span class="sinLinea bs-callout bs-callout-warning rojo" id="msgError" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_incorrecto']/node()"/></span>
			<br/>
		</td>
	</tr>
	<!--
	<tr class="sinLinea">
		<td class="labelRight cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_banco']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="$path/NOMBREBANCO"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="NOMBREBANCO" class="form-control grande" data-parsley-trigger="change" data-parsley-type="alphanum" required="" maxlength="200" value="{$path/NOMBREBANCO}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	-->
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_banco']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="$path/EMP_FIB_CODIGOBANCO/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="$path/EMP_FIB_CODIGOBANCO/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_cuenta']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="$path/EMP_FIB_TIPOCUENTA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w200px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="$path/EMP_FIB_TIPOCUENTA/field"></xsl:with-param>
			<xsl:with-param name="claSel">form-control w200px</xsl:with-param>
			<xsl:with-param name="required">required</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_cuenta']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="$path/NUMEROCUENTA"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="NUMEROCUENTA" class="form-control grande" data-parsley-trigger="change" required="" maxlength="200" value="{$path/NUMEROCUENTA}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='titular_cuenta']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="$path/TITULARCUENTA"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="TITULARCUENTA" class="form-control grande" data-parsley-trigger="change" required="" maxlength="200" value="{$path/TITULARCUENTA}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>
	<xsl:if test="not(NOEDICION)">
    <tr class="sinLinea">
		<td class="labelRight">
		</td>
		<td class="textLeft">
            <a class="btnDestacado" href="javascript:ValidarYEnviar('{$nombreForm}');">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
			</a>
			&nbsp;
		</td>
    </tr>
	</xsl:if>
	</table>
	</form>
	</div>
	
<div class="divLeft divForm" id="div_pes_DatosPago">
	<form id="frmDatosPago" name="frmDatosPago" data-parsley-validate="" method="post" action="EMPDatosPago2022.xsql">
	<input type="hidden" name="EMP_ID" id="EMP_ID" value="{EMP_ID}"/>
	<table cellspacing="6px" cellpadding="6px">

	<tr class="sinLinea">
		<td colspan="2">
			<span class="naranja"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span><br/>
			<span class="sinLinea bs-callout bs-callout-info verde" id="msgOK" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_correcto']/node()"/></span>
			<span class="sinLinea bs-callout bs-callout-warning rojo" id="msgError" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_incorrecto']/node()"/></span>
			<br/>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Plazo_pago']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft" style="width:50%;">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSPAGO/PLAZOPAGO"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_FIP_PLAZOPAGO" class="form-control peq" data-parsley-trigger="change" required="" maxlength="100" value="{DATOSPAGO/PLAZOPAGO}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Desc_30dias']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft" style="width:50%;">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSPAGO/DESC_PAGO30DIAS"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_FIP_DESC_PAGO30DIAS" class="form-control peq" data-parsley-trigger="change" required="" maxlength="100" value="{DATOSPAGO/DESC_PAGO30DIAS}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Desc_60dias']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSPAGO/DESC_PAGO60DIAS"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_FIP_DESC_PAGO60DIAS" class="form-control peq" data-parsley-trigger="change" required="" maxlength="100" value="{DATOSPAGO/DESC_PAGO60DIAS}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Desc_90dias']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSPAGO/DESC_PAGO90DIAS"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_FIP_DESC_PAGO90DIAS" class="form-control peq" data-parsley-trigger="change" required="" maxlength="100" value="{DATOSPAGO/DESC_PAGO90DIAS}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Desc_120dias']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSPAGO/DESC_PAGO120DIAS"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_FIP_DESC_PAGO120DIAS" class="form-control peq" data-parsley-trigger="change" required="" maxlength="100" value="{DATOSPAGO/DESC_PAGO120DIAS}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td colspan="2" class="textCenter"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Medicamentos_regulados']/node()"/></strong></td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Plazo_pago']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSPAGO/REGUL_PLAZOPAGO"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_FIP_REGUL_PLAZOPAGO" class="form-control peq" data-parsley-trigger="change" required="" maxlength="100" value="{DATOSPAGO/REGUL_PLAZOPAGO}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Dias_pronto_pago']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSPAGO/REGUL_DIASPRNTOPAGO"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_FIP_REGUL_DIASPRNTOPAGO" class="form-control peq" data-parsley-trigger="change" required="" maxlength="100" value="{DATOSPAGO/REGUL_DIASPRNTOPAGO}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Descuento']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			&nbsp;<xsl:value-of select="DATOSPAGO/REGUL_DESCUENTO"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_FIP_REGUL_DESCUENTO" class="form-control peq" data-parsley-trigger="change" required="" maxlength="100" value="{DATOSPAGO/REGUL_DESCUENTO}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<xsl:if test="not(NOEDICION)">
    <tr class="sinLinea">
		<td class="labelRight">
		</td>
		<td class="textLeft">
            <a class="btnDestacado" href="javascript:ValidarYEnviar('frmDatosPago');">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
			</a>
			&nbsp;
		</td>
    </tr>
	</xsl:if>
</table>
</form>
</div><!--fin divLeft datos pago-->

<div class="divLeft divForm" id="div_pes_DatosEntrega">
	<form id="frmDatosEntrega" name="frmDatosEntrega" data-parsley-validate="" method="post" action="EMPDatosEntrega2022.xsql">
	<input type="hidden" name="EMP_ID" id="EMP_ID" value="{EMP_ID}"/>
	<table cellspacing="6px" cellpadding="6px">
	<tr class="sinLinea">
		<td class="labelLeft">
        	&nbsp;
		</td>
		<td colspan="2">
			<span class="naranja"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span><br/>
			<span class="sinLinea bs-callout bs-callout-info verde" id="msgOK" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_correcto']/node()"/></span>
			<span class="sinLinea bs-callout bs-callout-warning rojo" id="msgError" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_incorrecto']/node()"/></span>
			<br/>
		</td>
		<td colspan="2" class="labelLeft">
        	&nbsp;
		</td>
	</tr>

    <tr class="sinLinea">
		<td class="labelLeft" style="width:25%;">
        	&nbsp;
		</td>
		<td class="labelLeft" style="width:300px;">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='ENTREGAS_URGENTES']/node()"/>
		</td>
		<td class="labelLeft" style="width:300px;">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Plazo_entrega']/node()"/>
		</td>
		<td class="labelLeft" style="width:300px;">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedido_minimo']/node()"/>
		</td>
		<td class="labelLeft" style="width:*;">
        	&nbsp;
		</td>
	</tr>

    <tr class="sinLinea">
		<td class="labelLeft">
        	&nbsp;
		</td>
		<td class="labelLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Zona_Centro']/node()"/>:<span class="camposObligatorios">*</span>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/EMER_PLAZO_CENTRO"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_EMER_PLAZO_CENTRO" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/EMER_PLAZO_CENTRO}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/EMER_PEDMIN_CENTRO"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_EMER_PEDMIN_CENTRO" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/EMER_PEDMIN_CENTRO}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="labelLeft">
        	&nbsp;
		</td>
	</tr>

    <tr class="sinLinea">
		<td class="labelLeft">
        	&nbsp;
		</td>
		<td class="labelLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Zona_Eje_Cafetero']/node()"/>:<span class="camposObligatorios">*</span>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/EMER_PLAZO_EJECAFE"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_EMER_PLAZO_EJECAFE" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/EMER_PLAZO_EJECAFE}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/EMER_PEDMIN_EJECAFE"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_EMER_PEDMIN_EJECAFE" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/EMER_PEDMIN_EJECAFE}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="labelLeft">
        	&nbsp;
		</td>
	</tr>

    <tr class="sinLinea">
		<td class="labelLeft">
        	&nbsp;
		</td>
		<td class="labelLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Zona_Pacifico']/node()"/>:<span class="camposObligatorios">*</span>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/EMER_PLAZO_PACIFICO"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_EMER_PLAZO_PACIFICO" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/EMER_PLAZO_PACIFICO}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/EMER_PEDMIN_PACIFICO"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_EMER_PEDMIN_PACIFICO" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/EMER_PEDMIN_PACIFICO}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="labelLeft">
        	&nbsp;
		</td>
	</tr>

    <tr class="sinLinea">
		<td class="labelLeft">
        	&nbsp;
		</td>
		<td class="labelLeft" style="width:300px;">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='ENTREGAS_NORMALES']/node()"/>
		</td>
		<td class="labelLeft" style="width:300px;">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Plazo_entrega']/node()"/>
		</td>
		<td class="labelLeft" style="width:300px;">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedido_minimo']/node()"/>
		</td>
		<td class="labelLeft">
        	&nbsp;
		</td>
	</tr>
    <tr class="sinLinea">
		<td class="labelLeft">
        	&nbsp;
		</td>
		<td class="labelLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Zona_Centro']/node()"/>:<span class="camposObligatorios">*</span>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/NORM_PLAZO_CENTRO"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_NORM_PLAZO_CENTRO" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/NORM_PLAZO_CENTRO}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/NORM_PEDMIN_CENTRO"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_NORM_PEDMIN_CENTRO" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/NORM_PEDMIN_CENTRO}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="labelLeft">
        	&nbsp;
		</td>
	</tr>

    <tr class="sinLinea">
		<td class="labelLeft">
        	&nbsp;
		</td>
		<td class="labelLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Zona_Eje_Cafetero']/node()"/>:<span class="camposObligatorios">*</span>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/NORM_PLAZO_EJECAFE"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_NORM_PLAZO_EJECAFE" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/NORM_PLAZO_EJECAFE}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/NORM_PEDMIN_EJECAFE"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_NORM_PEDMIN_EJECAFE" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/NORM_PEDMIN_EJECAFE}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="labelLeft">
        	&nbsp;
		</td>
	</tr>

    <tr class="sinLinea">
		<td class="labelLeft">
        	&nbsp;
		</td>
		<td class="labelLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Zona_Pacifico']/node()"/>:<span class="camposObligatorios">*</span>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/NORM_PLAZO_PACIFICO"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_NORM_PLAZO_PACIFICO" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/NORM_PLAZO_PACIFICO}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="textLeft">
			<xsl:choose>
			<xsl:when test="NOEDICION">
				&nbsp;<xsl:value-of select="DATOSENTREGA/NORM_PEDMIN_PACIFICO"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="EMP_FIE_NORM_PEDMIN_PACIFICO" class="form-control peq" data-parsley-trigger="change" data-parsley-type="digits" required="" maxlength="100" value="{DATOSENTREGA/NORM_PEDMIN_PACIFICO}"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="labelLeft">
        	&nbsp;
		</td>
	</tr>
	<xsl:if test="not(NOEDICION)">
    <tr class="sinLinea">
		<td class="labelRight">
		</td>
		<td class="textLeft">
            <a class="btnDestacado" href="javascript:ValidarYEnviar('frmDatosEntrega');">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
			</a>
			&nbsp;
		</td>
    </tr>
	</xsl:if>
</table>
</form>

</div><!--fin divLeft datos entrega-->
	
	
	
	
	
	
</xsl:template>

</xsl:stylesheet>
