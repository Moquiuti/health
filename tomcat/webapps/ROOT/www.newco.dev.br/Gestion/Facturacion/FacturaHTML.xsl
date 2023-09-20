<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="usuario" select="@US_ID"/>
<xsl:template match="/Factura">

<html>
<head>
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

  <meta http-equiv="Cache-Control" Content="no-cache"/>

  <title><xsl:value-of select="document($doc)/translation/texts/item[@name='factura']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

  <script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
</head>
<body>
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

  <xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="AreaPublica/xsql-error">
		<xsl:apply-templates select="AreaPublica/xsql-error"/>
	</xsl:when>
	<xsl:otherwise>

    <div class="divLeft80" style="border:0px solid #939494;border-top:0;margin-left:10%;">
        <table class="infoTable" style="border-bottom:1px solid #000;font-size:14px;line-height:20px;">
            <tr><td colspan="4">&nbsp;</td></tr>
            <tr>
                <td width="200">
                    <img src="http://www.newco.dev.br/images/logoMVMpeq.jpg" />
                </td>
                <td class="datosLeft cuarenta">
                    <span style="text-transform:uppercase;"><b><xsl:value-of select="FACTURA/FACTURA/PROVEEDOR/NOMBRE" /></b></span><br />
                    <xsl:value-of select="FACTURA/FACTURA/PROVEEDOR/DIRECCION" /><br />
                    <xsl:value-of select="FACTURA/FACTURA/PROVEEDOR/COD_POSTAL" />&nbsp;<xsl:value-of select="FACTURA/FACTURA/PROVEEDOR/PROVINCIA" /><br />
                    <xsl:value-of select="FACTURA/FACTURA/PROVEEDOR/NIF" />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td class="labelRight quince" style="color:#000;">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='factura_n']/node()"/>:
                </td>
                <td class="datosLeft">
                    <xsl:value-of select="FACTURA/FACTURA/CODIGO" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td class="labelRight" style="color:#000;">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:
                </td>
                <td class="datosLeft">
                    <xsl:value-of select="FACTURA/FACTURA/FECHA" />
                </td>

            </tr>
            <tr><td colspan="4">&nbsp;</td></tr>
        </table>

        <table class="infoTable" border="0">
            <tr><td colspan="3">&nbsp;</td></tr>
            <tr>
                <td class="datosLeft" style="line-height:20px;">
                    <span style="text-transform:uppercase;"><b><xsl:value-of select="FACTURA/FACTURA/CLIENTE/NOMBRE" /></b></span><br />
                    <xsl:value-of select="FACTURA/FACTURA/CLIENTE/DIRECCION" /><br />
                    <xsl:value-of select="FACTURA/FACTURA/CLIENTE/COD_POSTAL" />&nbsp;<xsl:value-of select="FACTURA/FACTURA/CLIENTE/PROVINCIA" /><br />
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:&nbsp;<xsl:value-of select="FACTURA/FACTURA/CLIENTE/NIF" />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr><td colspan="3">&nbsp;</td></tr>
        </table>
        <table class="infoTable" border="1">
            <tr style="background:#5c7eb5;color:#000;text-transform:uppercase;font-weight:bold;">
                <td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
                <td colspan="2" style="border-right:1px solid #000;border-left:1px solid #000;text-align:left;padding-left:20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='concepto']/node()"/></td>
                <td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></td>
            </tr>
            <tr>
                <td style="padding-top:12px;" valign="top">1</td>
                <td colspan="2" style="border-right:1px solid #000;border-left:1px solid #000;text-align:left;padding:12px 0 250px 40px;line-height:20px;"><xsl:copy-of select="FACTURA/FACTURA/TEXTOFACTURA" /></td>
                <td style="padding-top:12px;" valign="top"><xsl:value-of select="FACTURA/FACTURA/IMPORTE" /></td>
            </tr>
            <!--abajo-->
            <tr>
                <td colspan="2" style="border:none; text-align:left;"><u><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/>:</u></td>
                <td style="border-right:1px solid #000;">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr style="border:none;">
                <td colspan="2" style="border:none; text-align:left;"><b><xsl:value-of select="FACTURA/FACTURA/CLIENTE/FORMAPAGO" /></b></td>
                <td class="veinte datosLeft" style="border-top:1px solid #fff;border-bottom:1px solid #fff;padding-left:20px;text-transform:uppercase;">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='base_imponible']/node()"/>
                </td>
                <!--importe-->
                <td class="veinte" style="border-top:1px solid #fff;border-bottom:1px solid #fff;"><xsl:value-of select="FACTURA/FACTURA/IMPORTE" /></td>

            </tr>
            <tr>
                <td colspan="2" style="border:none; text-align:left;"><u><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/>:</u></td>
                <td class="veinte datosLeft" style="border-top:1px solid #fff;border-bottom:1px solid #fff;padding-left:20px;text-transform:uppercase;">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>&nbsp;
                    (<xsl:value-of select="FACTURA/FACTURA/TIPO_IVA" />%)
                </td>
                <!--iva-->
                <td class="veinte" style="border-top:1px solid #fff;border-bottom:1px solid #fff;"><xsl:value-of select="FACTURA/FACTURA/IMPORTE_IVA" /></td>
            </tr>
            <tr>
                <td colspan="2" style="border:none; text-align:left;"><xsl:value-of select="FACTURA/FACTURA/COMENTARIOS" /></td>
                <td class="veinte datosLeft" style="border-top:1px solid #fff;padding-left:20px;text-transform:uppercase;">
                    <b>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>
                    </b>
                </td>
                <!--total-->
                <td class="veinte"><xsl:value-of select="FACTURA/FACTURA/TOTAL_IVA" /></td>
            </tr>
        </table>
        <p class="font12" style="text-align:center; margin-top:5%;">
					<xsl:value-of select="FACTURA/FACTURA/DATOS_LEGALES" />
				</p>
    </div>

    <p>&nbsp;</p>
    <p>&nbsp;</p>
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
