<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Buscador de productos en catalogo de proveedor
	Última revisión ET 17feb23 15:31
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:param name="usuario" select="@US_ID"/>
<xsl:template match="/">

<html>
<head>
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/CatalogoProveedor/LANG"><xsl:value-of select="/CatalogoProveedor/LANG"/></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <title><xsl:value-of select="/CatalogoProveedor/CATALOGO/PROVEEDOR"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Catalogo_proveedor']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

<xsl:text disable-output-escaping="yes">
<![CDATA[
  <script type="text/javascript">
  <!--
	function Buscar(){
		SubmitForm(document.forms['catalogo']);
	}


    //insertar la ref producto en campo input de mantenimiento de pedidos
    function InsertarCatalogoRapido(id,ref, prod, marca, udbasica, udlote, precio)
	{
		//window.opener.document.forms['frmProducto'].elements['IDPRODUCTO'].value = id;
		window.opener.ActualizarCampos(id,ref, prod, marca, udbasica, udlote, precio);
	}

  //-->

 	//	18ago16	Funciones para paginación del listado
	function Pagina0() {document.forms[0].elements['PAGINA'].value=0; Buscar();}
	function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Buscar();}
	function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Buscar();}

	</script>
]]>
</xsl:text>
</head>

<body>
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/CatalogoProveedor/LANG"><xsl:value-of select="/CatalogoProveedor/LANG"/></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="CatalogoProveedor/xsql-error">
		<xsl:apply-templates select="CatalogoProveedor/xsql-error"/>
	</xsl:when>
	<xsl:otherwise>
		<!--	/AreaPublica	-->
		<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/CatalogoProveedor/CATALOGO/PROVEEDOR"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Catalogo_proveedor']/node()"/>
			<span class="CompletarTitulo" style="width:100px;">
				<a class="btnNormal" href="javascript:window.close();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
				</a>
			</span>
		</p>
		</div>
		<br/>		
		<br/>		
		<br/>		

		<form name="catalogo" action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoProveedor2022.xsql">
		<input type="hidden" id="IDPROVEEDOR" name="IDPROVEEDOR" value="{/CatalogoProveedor/CATALOGO/FILTROS/IDPROVEEDOR}"/>
		<input type="hidden" id="IDEMPRESA" name="IDEMPRESA" value="{/CatalogoProveedor/CATALOGO/FILTROS/IDEMPRESA}"/>
		<input type="hidden" id="ORIGEN" name="ORIGEN" value="{/CatalogoProveedor/ORIGEN}"/>
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/CatalogoProveedor/CATALOGO/FILTROS/PAGINA}"/>

	<div class="tabela tabela_redonda">
	<table>
	<thead class="cabecalho_tabela">
        <xsl:choose>
        <xsl:when test="/CatalogoProveedor/CATALOGO/FILTROS/PUBLICO = 'N'"><!--si publico = N enseño tb ref cliente-->
        	<tr class="subTituloTabla">
				<th class="w1px">&nbsp;</th>
            	<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
            	<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
            	<th class="w600px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
				<th>&nbsp;</th>
				<th class="cuarenta">&nbsp;</th>
			</tr>

          <tr class="subTituloTabla">
			<th class="w1px">&nbsp;</th>
            <th colspan="2">
				&nbsp;
                <input type="text" class="campopesquisa" id="REFERENCIA" name="REFERENCIA" maxlength="8" size="20" value="{/CatalogoProveedor/CATALOGO/FILTROS/REFERENCIA}" />
             </th>
            <th class="textLeft" colspan="3">
				<input type="text" class="campopesquisa" id="DESCRIPCION" name="PRODUCTO" maxlength="50" size="30" value="{/CatalogoProveedor/CATALOGO/FILTROS/PRODUCTO}" />
              &nbsp;&nbsp;&nbsp;&nbsp;<a class="btnDestacado" href="javascript:Buscar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
            </th>
			</tr>
			<tr class="subTituloTabla">
				<th align="right">
					<xsl:if test="/CatalogoProveedor/CATALOGO/ANTERIOR">
						<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
				</th>
				<th colspan="3">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/CatalogoProveedor/CATALOGO/LINEASPORPAGINA/field"/>
						<xsl:with-param name="onChange">javascript:Pagina0();</xsl:with-param>
					</xsl:call-template>&nbsp;&nbsp;&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
					<xsl:value-of select="/CatalogoProveedor/CATALOGO/PAGINA_ACTUAL"/>&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
					<xsl:value-of select="/CatalogoProveedor/CATALOGO/TOTAL_PAGINAS"/>
				</th>
				<th align="left">
					<xsl:if test="/CatalogoProveedor/CATALOGO/SIGUIENTE">
						<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>
				</th>
			</tr>

        </xsl:when>
        <xsl:otherwise>
          <tr class="subTituloTabla">
			<th class="w1px">&nbsp;</th>
            <th><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/><br/>
              <xsl:choose>
              <xsl:when test="/CatalogoProveedor/REFERENCIA != '' and /CatalogoProveedor/IDEMPRESA != ''">
                <input type="text" class="campopesquisa w100px" id="REFERENCIA" name="REFERENCIA" maxlength="20" size="20" value="{/CatalogoProveedor/REFERENCIA}" />
              </xsl:when>
              <xsl:otherwise>
                <input type="text" class="campopesquisa w100px" id="REFERENCIA" name="REFERENCIA" maxlength="20" size="20" value="{/CatalogoProveedor/CATALOGO/FILTROS/REFERENCIA}" />
              </xsl:otherwise>
              </xsl:choose>
            </th>
            <th><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/><br/>
				<input type="text" class="campopesquisa w300px" id="PRODUCTO" name="PRODUCTO" maxlength="50" size="50" value="{/CatalogoProveedor/CATALOGO/FILTROS/PRODUCTO}"/>
            </th>
			<th>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/><br/>
				<input type="text" class="campopesquisa w200px" id="MARCA" name="MARCA" maxlength="50" size="50" value="{/CatalogoProveedor/CATALOGO/FILTROS/MARCA}"/>
			</th>
			<th>
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/>&nbsp;
			</th>
			<th>
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>&nbsp;
			</th>
			<th>
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;
			</th>
			<th>
                &nbsp;&nbsp;<a class="btnDestacado" href="javascript:Buscar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>&nbsp;&nbsp;
			</th>
			<th>
			&nbsp;
			</th>
		  </tr>
        </xsl:otherwise>
        </xsl:choose>
      </thead>

     <tbody class="corpo_tabela">
		<!--	Cuerpo de la tabla	-->
        <xsl:for-each select="/CatalogoProveedor/CATALOGO/PRODUCTO">
          <tr class="conhover">
			<td class="color_status">&nbsp;</td>
          	<td class="ref" align="left">
                 &nbsp;&nbsp;<a href="javascript:InsertarCatalogoRapido('{ID}','{REFERENCIA}','{PRODUCTO}','{MARCA}','{UNIDADBASICA}','{UNIDADESPORLOTE}','{PRECIO}')">
                    <xsl:value-of select="REFERENCIA"/>
                  </a>
            </td>

            <td class="textLeft">
				<xsl:value-of select="PRODUCTO"/>
            </td>

            <td class="textLeft">
				<xsl:value-of select="MARCA"/>
            </td>

            <td class="textLeft">
				<xsl:value-of select="UNIDADBASICA"/>
            </td>

            <td class="textLeft">
				<xsl:value-of select="UNIDADESPORLOTE"/>
            </td>

            <td class="textRight">
				<xsl:value-of select="PRECIO"/>&nbsp;
            </td>
			<td colspan="2">&nbsp;</td>
          </tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<td colspan="9">&nbsp;</td>
		</tfoot>
      </table>
	  </div>
	</form>

    <!--form de mensaje de error de js-->
    <form name="mensajeJS">
      <input type="hidden" name="REF_YA_INSERTADA" value="{document($doc)/translation/texts/item[@name='ref_ya_insertada']/node()}"/>
    </form>

  </xsl:otherwise>
  </xsl:choose>
  <br/>
</body>
</html>
</xsl:template>

<xsl:template match="Sorry">
  <xsl:apply-templates select="Noticias/ROW/Sorry"/>
</xsl:template>
</xsl:stylesheet>
