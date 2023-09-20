<?xml version="1.0" encoding="iso-8859-1" ?>
<!--  
	Mantenimiento de proveedor en convocatoria + funciones avanzadas
	ultima revision: ET 10jun22 09:50 ProveedorConvocatoria2022_070422.js
--> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
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

	<meta http-equiv="Cache-Control" Content="no-cache"/>
	
	<title>
		<xsl:value-of select="substring(/Proveedor/CONVOCATORIA/CLIENTE,0,60)"/>:&nbsp;
		<xsl:choose>
		<xsl:when test="/Proveedor/CONVOCATORIA/LIC_CONV_NOMBRE">
			<xsl:value-of select="/Proveedor/CONVOCATORIA/LIC_CONV_NOMBRE" />
		</xsl:when>
		<xsl:otherwise>
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/Convocatorias/ProveedorConvocatoria2022_070422.js"></script>
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
		<xsl:apply-templates select="/Proveedor/CONVOCATORIA"/>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>


<xsl:template match="CONVOCATORIA">

	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Proveedor/LANG"><xsl:value-of select="/Proveedor/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/Proveedor/CONVOCATORIA/LIC_CONV_NOMBRE" />:&nbsp;<xsl:value-of select="/Proveedor/CONVOCATORIA/PROVEEDOR" />
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				&nbsp;
                <a class="btnNormal" href="javascript:chConvocatoria({/Proveedor/CONVOCATORIA/LIC_CONV_ID})">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>
                </a>
				&nbsp;
                <a class="btnNormal"> <!--href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatorias.xsql">-->
					<xsl:attribute name="href">
						<xsl:choose>
						<xsl:when test="/Proveedor/CONVOCATORIA/LIC_CONV_TIPO='E'">javascript:VerConvocatoriaEspecial();</xsl:when>
						<xsl:otherwise>javascript:VerConvocatoriaNormal();</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>
                </a>
				&nbsp;
				<xsl:if test="/Proveedor/CONVOCATORIA/BOTON_REACTIVAR">
        			<a class="btnDestacado" href="javascript:ReactivarProveedor({/Proveedor/CONVOCATORIA/IDPROVEEDOR});">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='Reactivar']/node()"/>
        			</a>
					&nbsp;
				</xsl:if>
				<xsl:if test="/Proveedor/CONVOCATORIA/BOTON_INCLUIR">
        			<a class="btnDestacado" href="javascript:ProveedorATodas({/Proveedor/CONVOCATORIA/IDPROVEEDOR});">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>
        			</a>
					&nbsp;
				</xsl:if>
        		<xsl:if test="/Proveedor/CONVOCATORIA/BOTON_SUSPENDER">
        			<a class="btnDestacado" href="javascript:SuspenderProveedor({/Proveedor/CONVOCATORIA/IDPROVEEDOR});">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='suspender']/node()"/>
        			</a>
					&nbsp;
				</xsl:if>
        		<xsl:if test="/Proveedor/CONVOCATORIA/BOTON_BORRAR">
        			<a class="btnDestacado" href="javascript:BorrarProveedor({/Proveedor/CONVOCATORIA/IDPROVEEDOR});">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
        			</a>
					&nbsp;
				</xsl:if>
        		<xsl:if test="/Proveedor/CONVOCATORIA/BOTON_RECUPERAR">
        			<a class="btnDestacado" href="javascript:RecuperarProveedor({/Proveedor/CONVOCATORIA/IDPROVEEDOR});">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='recuperar']/node()"/>
        			</a>
					&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>

	<div class="divLeft">
	<form id="frmConv" name="frmConv" data-parsley-validate="" method="post" action="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Proveedor.xsql">
	<input type="hidden" name="EMP_ID" id="EMP_ID" value="{/Proveedor/CONVOCATORIA/EMP_ID}"/>
	<input type="hidden" name="LIC_CONV_ID" id="LIC_CONV_ID" value="{/Proveedor/CONVOCATORIA/LIC_CONV_ID}"/>
	<input type="hidden" name="ACCION" id="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" id="PARAMETROS" value=""/>
	<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/Proveedor/CONVOCATORIA/IDPROVEEDOR}"/>
	<table cellspacing="6px" cellpadding="6px">

	<tr>
		<td>&nbsp;</td>
		<td>
			<span class="naranja"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span><br/>
			<span class="bs-callout bs-callout-info verde" id="msgOK" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_correcto']/node()"/></span>
			<span class="bs-callout bs-callout-warning rojo" id="msgError" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Form_incorrecto']/node()"/></span>
			<br/>
		</td>
	</tr>
	
	<tr>
		<td class="labelRight w40"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
			&nbsp;<xsl:value-of select="LIC_CONV_NOMBRE"/>
		</td>
	</tr>

    <tr>
		<td class="labelRight">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="textLeft">
        &nbsp;<xsl:value-of select="FECHADECISION"/>
		</td>
	</tr>

	<tr>
    <!--provincia-->
      <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
      <td class="textLeft">
         &nbsp;<xsl:value-of select="TIPO"/>
        </td>
	</tr>

    <tr>
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>:&nbsp;
      </td>
      <td class="textLeft">
            &nbsp;<xsl:value-of select="NUMLICITACIONES"/>
      </td>
	</tr>

    <tr>
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
      </td>
      <td class="textLeft">
            &nbsp;<xsl:value-of select="NUMPROVEEDORES"/>
      </td>
	</tr>
	
    <tr>
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:&nbsp;
      </td>
      <td class="textLeft">
            &nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/Proveedor/CONVOCATORIA/USUARIOS/field"></xsl:with-param>
			<xsl:with-param name="onChange">javascript:cbIDusuarioChange();</xsl:with-param>
			<xsl:with-param name="claSel">w300px</xsl:with-param>
		</xsl:call-template>
		&nbsp;
        <a class="btnDestacado" id="btnIncluir" href="javascript:ModificarResponsable();">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>
        </a>
      </td>
	</tr>
	
	</table>
	
	<xsl:if test="/Proveedor/CONVOCATORIA/LICITACIONES/LICITACION">
	<br/>
	<br/>
	<br/>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>
			</th>
			<th>
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>
			</th>
			<th class="w150px">
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>
			</th>
			<th class="w50px">
				 <xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>
			</th>
			<th class="w50px azul">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_mejor_precio']/node()"/></th>
			<th class="w100px azul">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Importe_global_mejor_precio']/node()"/></th>
			<th class="w50px verde">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_con_ahorro']/node()"/></th>
			<th class="w100px verde">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Importe_global_con_ahorro']/node()"/></th>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
		<xsl:for-each select="/Proveedor/CONVOCATORIA/LICITACIONES/LICITACION">
			<tr>
				<td class="color_status">&nbsp;</td>
				<td class="textLeft">
					&nbsp;<a href="javascript:FichaLicitacion({LIC_ID});" ><xsl:value-of select="LIC_TITULO"/></a>
				</td>
				<td class="textLeft">
					<xsl:value-of select="RESPONSABLE"/>&nbsp;
				</td>
				<td class="textLeft">
					<xsl:value-of select="ESTADOLICITACION"/>&nbsp;
				</td>
				<td class="textRight">
					<xsl:value-of select="LIC_PROV_NUMEROLINEAS"/>&nbsp;
				</td>
				<td class="textRight azul">
					<xsl:value-of select="LIC_PROV_OFERTASCONMEJORPRECIO"/>&nbsp;
				</td>
				<td class="textRight azul">
					<xsl:value-of select="LIC_PROV_CONSUMOCONMEJORPRECIO"/>&nbsp;
				</td>
				<td class="textRight verde">
					<xsl:value-of select="LIC_PROV_OFERTASCONAHORRO"/>&nbsp;
				</td>
				<td class="textRight verde">
					<xsl:value-of select="LIC_PROV_CONSUMOCONAHORRO"/>&nbsp;
				</td>
			</tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="9">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
	</xsl:if>
</form>
</div><!--fin ficha empresa-->
	
</xsl:template>

</xsl:stylesheet>
