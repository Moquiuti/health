<?xml version="1.0" encoding="iso-8859-1" ?>
<!--  
	Mantenimiento de convocatoria + funciones avanzadas
	ultima revision: ET 21dic21 08:30 Convocatoria_211221.js
--> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl"/>

  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

  <xsl:template match="/">
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
		<xsl:value-of select="substring(/Convocatoria/CONVOCATORIA/CLIENTE,0,60)"/>:&nbsp;
		<xsl:choose>
		<xsl:when test="/Convocatoria/CONVOCATORIA/LIC_CONV_NOMBRE">
			<xsl:value-of select="/Convocatoria/CONVOCATORIA/LIC_CONV_NOMBRE" />
		</xsl:when>
		<xsl:otherwise>
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
	</title>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
		IDConvocatoria=<xsl:value-of select="/Convocatoria/CONVOCATORIA/LIC_CONV_ID"/>;
		strEstaSeguroDeBorrar="<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_de_borrar_proveedor']/node()"/>";
		strEstaSeguroDeBorrarUsu="<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_de_borrar_usuario']/node()"/>";
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script><!--	27nov21	para abrir fichero excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatoria_211221.js"></script>
</head>

<body onload="javascript:Inicializa();">
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
	<xsl:otherwise>
		<xsl:apply-templates select="/Convocatoria/CONVOCATORIA"/>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>


<xsl:template match="CONVOCATORIA">

	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Convocatoria/LANG"><xsl:value-of select="/Convocatoria/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/></span>
			<span class="CompletarTitulo">
				<!--<span class="amarillo">EMP_ID=<xsl:value-of select="/Convocatoria/EMPRESA/EMP_ID"/></span>&nbsp;&nbsp;-->
				<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_modificacion']/node()"/>:&nbsp;<xsl:value-of select="/Convocatoria/EMPRESA/EMP_ULTIMOCAMBIO" />-->
			</span>
		</p>
		<p class="TituloPagina">
			<xsl:choose>
			<xsl:when test="/Convocatoria/CONVOCATORIA/LIC_CONV_NOMBRE">
				<xsl:value-of select="/Convocatoria/CONVOCATORIA/LIC_CONV_NOMBRE" />
			</xsl:when>
			<xsl:otherwise>
        		<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			&nbsp;&nbsp;
			<span class="CompletarTitulo" style="width:800px">
				<xsl:if test="/Convocatoria/CONVOCATORIA/LIC_CONV_TIPO!='E'">
					<a class="btnNormal" style="text-decoration:none;" href="javascript:listadoExcel('S');">
						<img src="http://www.newco.dev.br/images/iconoExcel.gif">
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>)</xsl:attribute>
						</img>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" style="text-decoration:none;" href="javascript:listadoExcel('N');">
						<img src="http://www.newco.dev.br/images/iconoExcel.gif">
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>)</xsl:attribute>
						</img>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>
					</a>
					&nbsp;
				</xsl:if>
				<xsl:if test="not (/Convocatoria/CONVOCATORIA/NOEDICION)">
					<a class="btnDestacado" href="javascript:Guardar();">
    					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
					&nbsp;
				</xsl:if>
				<xsl:if test="/Convocatoria/CONVOCATORIA/LIC_CONV_TIPO!='E'">
                	<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/licOfertasSeleccionadasTodasLic.xsql?FIDCONVOCATORIA={/Convocatoria/CONVOCATORIA/LIC_CONV_ID}&amp;IDEMPRESA={/Convocatoria/CONVOCATORIA/IDCLIENTE}">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/>
                	</a>
				</xsl:if>
				&nbsp;
                <a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatorias.xsql">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>
                </a>
				&nbsp;
                <a class="btnNormal"> <!--href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatorias.xsql">-->
					<xsl:attribute name="href">
						<xsl:choose>
						<xsl:when test="/Convocatoria/CONVOCATORIA/LIC_CONV_TIPO='E'">javascript:VerConvocatoriaEspecial();</xsl:when>
						<xsl:otherwise>javascript:VerConvocatoriaNormal();</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>
                </a>
				&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>

	<div class="divLeft">
	<form id="frmConv" name="frmConv" data-parsley-validate="" method="post" action="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatoria.xsql">
	<input type="hidden" name="EMP_ID" id="EMP_ID" value="{EMP_ID}"/>
	<input type="hidden" name="LIC_CONV_ID" id="LIC_CONV_ID" value="{LIC_CONV_ID}"/>
	<input type="hidden" name="ACCION" id="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" id="PARAMETROS" value=""/>
	<input type="hidden" name="LICTIPO" id="LICTIPO" value="{LIC_CONV_TIPO}"/>
	<table class="buscador">

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
            <img src="{/Convocatoria/EMPRESA/URL_LOGOTIPO}" height="80px" width="160px"/>
		</td>
		-->
		<td class="labelRight cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="datosLeft">
		<xsl:choose>
		<xsl:when test="/Convocatoria/CONVOCATORIA/NOEDICION">
			&nbsp;<xsl:value-of select="LIC_CONV_NOMBRE"/>
		</xsl:when>
		<xsl:otherwise>
        	<input type="hidden" name="LIC_CONV_NOMBRE_OLD" value="{LIC_CONV_NOMBRE}"/>
			&nbsp;<input type="text" name="LIC_CONV_NOMBRE" class="form-control grande" data-parsley-trigger="change" required="" maxlength="100" value="{LIC_CONV_NOMBRE}" />
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

    <tr class="sinLinea">
		<td class="labelRight">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="datosLeft">
        <xsl:choose>
        <xsl:when test="/Convocatoria/CONVOCATORIA/NOEDICION">
                &nbsp;<xsl:value-of select="FECHADECISIONCOMPLETA"/>
        </xsl:when>
        <xsl:otherwise>
                &nbsp;<input type="text" name="FECHADECISION" class="form-control" data-parsley-trigger="change" required="" maxlength="40" size="23" value="{FECHADECISION}"/>&nbsp;<input type="text" name="FECHADECISION" class="form-control" data-parsley-trigger="change" required="" maxlength="40" size="23" value="{FECHADECISION}"/>
				&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="LIC_HORADECISION/field"></xsl:with-param>
					<xsl:with-param name="claSel">medio</xsl:with-param>
				</xsl:call-template>
        </xsl:otherwise>
        </xsl:choose>
		</td>
	</tr>

	<tr class="sinLinea">
    <!--provincia-->
      <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
      <td class="datosLeft">
        <xsl:choose>
          <xsl:when test="LIC_CONV_ID!=''">
	         &nbsp;<xsl:value-of select="TIPO"/>
          </xsl:when>
          <xsl:otherwise>
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="IDTIPO/field"></xsl:with-param>
				<xsl:with-param name="claSel">form-control</xsl:with-param>
				<xsl:with-param name="required">required</xsl:with-param>
				</xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        </td>
	</tr>

    <tr class="sinLinea">
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>:&nbsp;
      </td>
      <td class="datosLeft">
            &nbsp;<xsl:value-of select="NUMLICITACIONES"/>
      </td>
	</tr>

    <tr class="sinLinea">
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
      </td>
      <td class="datosLeft">
            &nbsp;<xsl:value-of select="NUMPROVEEDORES"/>
      </td>
	</tr>
	</table>

	<br/>
	<br/>
 	<div class="divLeft">
		<ul class="pestannas">
			<li>
				<a id="pes_Licitaciones" class="MenuLic">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_Proveedores" class="MenuLic">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
				</a>
			</li>
			<li>
				<a id="pes_Usuarios" class="MenuLic">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/>
				</a>
			</li>

		</ul>
	</div>
	<!--
    <tr class="sinLinea">
      <td class="labelLeft" colspan="3">
			<a id="aProveedores" href="javascript:VerProveedores();"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>
			<a id="aLicitaciones" href="javascript:VerLicitaciones();"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones']/node()"/></a>
      </td>
	</tr>
	-->
    <!--<tr class="sinLinea">
      <td class="labelLeft" colspan="3">-->
	<br/>
	<br/>
	<br/>
	<br/>
	<div id="div_pes_Licitaciones" class="divForm">
		<xsl:if test="(/Convocatoria/CONVOCATORIA/LIC_CONV_TIPO!='E') and not (/Convocatoria/CONVOCATORIA/NOEDICION)">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_fuera_convocatoria']/node()"/></label>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Convocatoria/CONVOCATORIA/LICITACIONES_NOINCLUIDAS/field"></xsl:with-param>
				<xsl:with-param name="onChange">javascript:cbIDLicitacionChange();</xsl:with-param>
				<xsl:with-param name="style">width:300px;font-size:15px;height:22px;</xsl:with-param>
			</xsl:call-template>
			&nbsp;
        	<a class="btnDestacado" id="btnIncluirLic" href="javascript:IncluirLicitacion();">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>
        	</a>
		</xsl:if>
		<xsl:if test="/Convocatoria/CONVOCATORIA/LIC_CONV_TIPO!='E' and /Convocatoria/CONVOCATORIA/LICITACIONES/LICITACION">
		<br/>
		<br/>
		<br/>
		<table class="buscador" style="width:100%;margin:auto;">
		<tr class="subTituloTabla">
			<td class="uno">
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>
			</td>
			<td>
				 <a href="http://www.newco.dev.br/Gestion/Comercial/Licitaciones.xsql?FIDCONVOCATORIA={/Convocatoria/CONVOCATORIA/LIC_CONV_ID}&amp;FESTADO=-1&amp;PLAZOCONSULTA=T"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones_convocatoria']/node()"/></a>
			</td>
			<td>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
			</td>
			<td>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
			</td>
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='prov_pend_pub']/node()"/>
				<xsl:if test="(/Convocatoria/CONVOCATORIA/BOTON_PUBLICAR) and not (/Convocatoria/CONVOCATORIA/NOEDICION)"><a class="btnDestacadoPeq" href="javascript:PublicarPendientes();"><xsl:value-of select="document($doc)/translation/texts/item[@name='publicar']/node()"/></a></xsl:if>
			</td>
			<td>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>
			</td>
			<td>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/>
			</td>
		</tr>
		<xsl:for-each select="/Convocatoria/CONVOCATORIA/LICITACIONES/LICITACION">
			<tr>
				<td class="datosRight">
					<xsl:value-of select="POS"/>&nbsp;
				</td>
				<td class="datosLeft">
					&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={LIC_ID}&amp;VENTANA=NUEVA','Licitacion',100,80,0,0)" >
					<xsl:value-of select="LIC_TITULO"/>
					</a>
				</td>
				<td>
					<xsl:value-of select="PRODUCTOSADJ"/>&nbsp;/&nbsp;<xsl:value-of select="PRODUCTOSOFE"/>&nbsp;/&nbsp;<xsl:value-of select="NUMLINEAS"/>&nbsp;
				</td>
				<td>
					<xsl:value-of select="PROVEEDORESADJ"/>&nbsp;/&nbsp;<xsl:value-of select="PROVEEDORESINF"/>&nbsp;/&nbsp;<xsl:value-of select="NUMPROVEEDORES"/>&nbsp;
				</td>
				<td>
					<xsl:value-of select="PROVEEDORESPEND"/>&nbsp;
				</td>
				<td class="datosRight">
					<xsl:value-of select="ESTADO"/>&nbsp;
				</td>
				<td>
					&nbsp;
					<xsl:if test="not (/Convocatoria/CONVOCATORIA/NOEDICION)">
        				<a class="btnDestacado" href="javascript:QuitarLicitacion({LIC_ID});">
            				<xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/>
        				</a>
					</xsl:if>
					<!--
					&nbsp;
					<xsl:if test="BOTON_REACTIVAR">
        				<a class="btnDestacado" href="javascript:ReactivarProveedor({ID});">
            				<xsl:value-of select="document($doc)/translation/texts/item[@name='Reactivar']/node()"/>
        				</a>
						&nbsp;
					</xsl:if>
        			<xsl:if test="BOTON_SUSPENDER">
        				<a class="btnDestacado" href="javascript:SuspenderLicitacion({ID});">
            				<xsl:value-of select="document($doc)/translation/texts/item[@name='suspender']/node()"/>
        				</a>
						&nbsp;
					</xsl:if>
        			<xsl:if test="BOTON_BORRAR">
        				<a class="btnDestacado" href="javascript:BorrarLicitacion({ID});">
            				<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
        				</a>
						&nbsp;
					</xsl:if>
					-->
				</td>
			</tr>
		</xsl:for-each>
		</table>
	</xsl:if>
	</div>


	<div id="div_pes_Proveedores" class="divForm">
		<xsl:if test="not (/Convocatoria/CONVOCATORIA/NOEDICION)">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_fuera_convocatoria']/node()"/></label>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Convocatoria/CONVOCATORIA/PROVEEDORES_NOINCLUIDOS/field"></xsl:with-param>
				<xsl:with-param name="onChange">javascript:cbIDProveedorChange();</xsl:with-param>
				<xsl:with-param name="style">width:300px;font-size:15px;height:22px;</xsl:with-param>
			</xsl:call-template>
			&nbsp;
        	<a class="btnDestacado" id="btnIncluirProv" href="javascript:IncluirProveedor();">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>
        	</a>
		</xsl:if>
		<xsl:if test="/Convocatoria/CONVOCATORIA/PROVEEDORES/PROVEEDOR">
		<br/>
		<br/>
		<br/>
		<table class="buscador" style="width:100%;margin:auto;">
		<tr class="subTituloTabla">
			<td class="uno">
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>
			</td>
			<td>
				 <a href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Proveedores.xsql?LIC_CONV_ID={/Convocatoria/CONVOCATORIA/LIC_CONV_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_convocatoria']/node()"/></a>
			</td>
			<td>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>
			</td>
			<td>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>
			</td>
			<xsl:if test="not (/Convocatoria/CONVOCATORIA/NOEDICION)">
				<td>
					 <xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/>
				</td>
			</xsl:if>
		</tr>
		<xsl:for-each select="/Convocatoria/CONVOCATORIA/PROVEEDORES/PROVEEDOR">
			<tr>
				<td class="datosRight">
					<xsl:value-of select="POS"/>&nbsp;
				</td>
				<td class="datosLeft">
					&nbsp;<a href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Proveedor.xsql?LIC_CONV_ID={/Convocatoria/CONVOCATORIA/LIC_CONV_ID}&amp;IDPROVEEDOR={ID}"><xsl:value-of select="NOMBRE"/></a>
				</td>
				<td class="datosRight">
					<xsl:value-of select="NUMLICITACIONES"/>&nbsp;
				</td>
				<td class="datosCenter">
					<xsl:value-of select="ESTADO"/>&nbsp;
				</td>
				<xsl:if test="not (/Convocatoria/CONVOCATORIA/NOEDICION)">
					<td>
						&nbsp;
						<xsl:if test="BOTON_REACTIVAR">
        					<a class="btnDestacado" href="javascript:ReactivarProveedor({ID});">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='Reactivar']/node()"/>
        					</a>
							&nbsp;
						</xsl:if>
						&nbsp;
						<xsl:if test="BOTON_INCLUIR">
        					<a class="btnDestacado" href="javascript:ProveedorATodas({ID});">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>
        					</a>
							&nbsp;
						</xsl:if>
        				<xsl:if test="BOTON_SUSPENDER">
        					<a class="btnDestacado" href="javascript:SuspenderProveedor({ID});">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='suspender']/node()"/>
        					</a>
							&nbsp;
						</xsl:if>
        				<xsl:if test="BOTON_BORRAR">
        					<a class="btnDestacado" href="javascript:BorrarProveedor({ID});">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
        					</a>
							&nbsp;
						</xsl:if>
        				<xsl:if test="BOTON_RECUPERAR">
        					<a class="btnDestacado" href="javascript:RecuperarProveedor({ID});">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='recuperar']/node()"/>
        					</a>
							&nbsp;
						</xsl:if>
					</td>
				</xsl:if>
			</tr>
		</xsl:for-each>
		</table>
	</xsl:if>
	</div>
	
	
	<div id="div_pes_Usuarios" class="divForm">
		<xsl:if test="not (/Convocatoria/CONVOCATORIA/NOEDICION)">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Usuarios_fuera_convocatoria']/node()"/></label>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Convocatoria/CONVOCATORIA/USUARIOS_NOINCLUIDOS/field"></xsl:with-param>
				<xsl:with-param name="onChange">javascript:cbIDUsuarioChange();</xsl:with-param>
				<xsl:with-param name="style">width:300px;font-size:15px;height:22px;</xsl:with-param>
			</xsl:call-template>
			&nbsp;
        	<a class="btnDestacado" id="btnIncluirUsu" href="javascript:IncluirUsuario();">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>
        	</a>
		</xsl:if>
		
		<xsl:if test="/Convocatoria/CONVOCATORIA/USUARIOS/USUARIO">
		<br/>
		<br/>
		<br/>
		<table class="buscador" style="width:100%;margin:auto;">
		<tr class="subTituloTabla">
			<td class="uno">
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>
			</td>
			<td>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/>
			</td>
			<td>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>
			</td>
			<td>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>
			</td>
			<xsl:if test="not (/Convocatoria/CONVOCATORIA/NOEDICION)">
				<td>
					 <xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/>
				</td>
			</xsl:if>
		</tr>
		<xsl:for-each select="/Convocatoria/CONVOCATORIA/USUARIOS/USUARIO">
			<tr>
				<td class="datosRight">
					<xsl:value-of select="POS"/>&nbsp;
				</td>
				<td class="datosLeft">
					<xsl:value-of select="NOMBRE"/>
				</td>
				<td class="datosCenter">
					<xsl:value-of select="NUMLICITACIONES"/>&nbsp;
				</td>
				<td class="datosCenter">
					<xsl:value-of select="NUMAUTOR"/>&nbsp;
				</td>
				<xsl:if test="not (/Convocatoria/CONVOCATORIA/NOEDICION)">
					<td>
						&nbsp;
						<xsl:if test="BOTON_INCLUIR">
        					<a class="btnDestacado" href="javascript:UsuarioATodas({ID});">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>
        					</a>
							&nbsp;
						</xsl:if>
        				<xsl:if test="BOTON_BORRAR">
        					<a class="btnDestacado" href="javascript:QuitarUsuario({ID});">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/>
        					</a>
							&nbsp;
						</xsl:if>
        				<xsl:if test="BOTON_AUTOR">
        					<a class="btnDestacado" href="javascript:UsuarioAutor({ID});">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>
        					</a>
							&nbsp;
						</xsl:if>
					</td>
				</xsl:if>
			</tr>
		</xsl:for-each>
		</table>
	</xsl:if>
	</div>
	
	
</form>
</div><!--fin ficha empresa-->
	
</xsl:template>

</xsl:stylesheet>
