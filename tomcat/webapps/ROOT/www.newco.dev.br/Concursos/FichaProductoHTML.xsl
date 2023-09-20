<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Estadisticas de acceso de los usuarios en MedicalVM
 |
 |	(c) 12/1/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.concursos.com/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
       <title>Concursos Sanitarios :: Material Sanitario :: <xsl:value-of select="Producto/PRODUCTO/NOMBREPRODUCTO"/> del proveedor <xsl:value-of select="Producto/PRODUCTO/NOMBREPROVEEDOR"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.concursos.com/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.concursos.com/General/general.js"></script>
	<script type="text/javascript" src="http://www.concursos.com/General/Miscelanea.js"></script>
	<script type="text/javascript" src="http://www.concursos.com/General/validaciones.js"></script>
	<script type="text/javascript" src="http://www.concursos.com/General/Acceso.js"></script>
	<script type="text/javascript" src="http://www.concursos.com/General/Ventanas.js"></script>
	<script type="text/javascript" src="http://www.concursos.com/General/loginNew.js"></script>
        ]]></xsl:text>
      </head>
      <body class="blanco" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
        <xsl:choose>
        <xsl:when test="Producto/SESION_CADUCADA">
          <xsl:apply-templates select="Producto/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="Producto/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="Producto/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        
        
  <table width="95%" border="0" align="center" cellspacing="1" cellpadding="1">
	<form name="Form1" method="POST">
	<tr>
		<td align="center" colspan="2">
			<a href="http://www.concursos.com/"><img src="http://www.concursos.com/Images/ConcursosSanitarios.gif" alt="Buscador de material sanitario, proveedores y precios en Concursos Sanitarios" border="0"/></a>
		</td>
	</tr>
	<tr>
	<td align="left"  >
				<!--
				< ! - -<br/><br/> - - >
				<table cellpadding="2" cellspacing="1" border="0" width="0px" class="muyoscuro">
					<tr class="claro">
					< ! - - <td align="center"><a href="javascript:window.close();" onMouseOver="window.status='Cerrar'; return true;" onMouseOut="window.status=''; return true;">Cerrar</a> - - >
					<td align="center"><a href="javascript:history.go(-1);" onMouseOver="window.status='Volver'; return true;" onMouseOut="window.status=''; return true;">Volver</a>
					</td>
					</tr>
				</table>
				< ! - - <br/>&nbsp; - - >
				-->
			</td>
	<td align="left">
		<br/>
				<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:history.go(-1);">Listado de Productos</a>
				&gt;&nbsp;<xsl:value-of select="Producto/PRODUCTO/NOMBREPRODUCTO"/>
			  </b>
	</td>
	
			
	
	
	</tr>
    <tr>
      <td colspan="2">
			<br/>
			<br/>
        <table width="600px" border="0" align="center" cellspacing="1" cellpadding="1" class="gris">
		<tr class="grisclaro">
		<td align="left">
		<table width="100%" class="blanco" cellspacing="1" cellpadding="1">
				    <tr  class="grisclaro">
				      <td align="left" class="grisclaro">
				        <B>Ficha de Producto</B>	
				        <br/>
				        <i><xsl:value-of select="Producto/PRODUCTO/NOMBREPRODUCTO"/></i>
				      </td>
				    </tr>
		</table>
        	<table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="oscuro">
            			<tr class="oscuro">
            				<td align="left" class="claro" width="40px">&nbsp;Ref.Proveedor&nbsp;</td>
            				<td class="blanco" width="*">&nbsp;<xsl:value-of select="Producto/PRODUCTO/REFERENCIAPROVEEDOR"/></td>
            				<td align="left" class="claro" width="40px">&nbsp;Ref.Cliente&nbsp;</td>
            				<td class="blanco" width="*">&nbsp;<xsl:value-of select="Producto/PRODUCTO/REFERENCIACLIENTE"/></td>
            			</tr>
            			<tr class="oscuro">
            				<td align="left" class="claro">&nbsp;Producto</td>
            				<td class="blanco" colspan="3">&nbsp;<xsl:value-of select="Producto/PRODUCTO/NOMBREPRODUCTO"/></td>
            			</tr>
            			<tr class="oscuro">
            				<td align="left" class="claro">&nbsp;Proveedor</td>
            				<td class="blanco" colspan="3">&nbsp;<xsl:value-of select="Producto/PRODUCTO/NOMBREPROVEEDOR"/></td>
            			</tr>
            			<tr class="oscuro">
            				<td align="left" class="claro">&nbsp;Marca</td>
            				<td class="blanco" colspan="3">&nbsp;<xsl:value-of select="Producto/PRODUCTO/MARCA"/></td>
            			</tr>
            			<tr class="oscuro">
            				<td align="left" class="claro">&nbsp;Familia</td>
            				<td class="blanco" colspan="3">&nbsp;<xsl:value-of select="Producto/PRODUCTO/FAMILIA"/></td>
            			</tr>
            			<tr class="oscuro">
            				<td align="left" class="claro">&nbsp;Centro</td>
            				<td class="blanco" colspan="3">&nbsp;<xsl:value-of select="Producto/PRODUCTO/NOMBRECENTRO"/></td>
            			</tr>
            			<tr class="oscuro">
            				<td align="left" class="claro">&nbsp;Provincia</td>
            				<td class="blanco" colspan="3">&nbsp;<xsl:value-of select="Producto/PRODUCTO/PROVINCIA"/></td>
            			</tr>
            			<tr class="oscuro">
            				<td align="left" class="claro" >&nbsp;Expediente&nbsp;Año</td>
            				<td class="blanco">&nbsp;<xsl:value-of select="Producto/PRODUCTO/ANNO_EXPEDIENTE"/></td>
            				<td align="left" class="claro" >&nbsp;Estado</td>
            				<td class="blanco">&nbsp;<xsl:value-of select="Producto/PRODUCTO/ESTADO"/></td>
            			</tr>
            			<xsl:if test="Producto/PRODUCTO/CADNACIONAL!=''">
            			<tr class="oscuro">
            				<td align="left" class="claro"  >&nbsp;CAD Nacional</td>
					<td align="left" class="blanco" colspan="3">&nbsp;<xsl:value-of select="Producto/PRODUCTO/CADNACIONAL"/></td>
				</tr>
            			</xsl:if>
            			<xsl:if test="Producto/PRODUCTO/CAE!=''">
            			<tr class="oscuro">
            				<td align="left" class="claro" >&nbsp;CAE</td>
					<td align="left" class="blanco" colspan="2">&nbsp;<xsl:value-of select="Producto/PRODUCTO/CAE"/></td>
				</tr>
            			</xsl:if>
            			<tr class="oscuro">
            				<td align="left" class="claro">&nbsp;Ud.Base</td>
            				<td class="blanco" colspan="3">&nbsp;<xsl:value-of select="Producto/PRODUCTO/UNIDADBASICA"/></td>
            			</tr>
            			<tr class="oscuro">
            				<td align="left" class="claro" >&nbsp;Precio Ud.Base</td>
            				<td class="blanco">
            				
            				<xsl:choose>
                				<xsl:when test="/Producto/PRODUCTO/ERROR_PRECIO">
                				  &nbsp;<a href="http://www.concursos.com/index.htm"><b><xsl:value-of select="/Producto/PRODUCTO/ERROR_PRECIO/@Msg"/></b></a>
       									</xsl:when>
       									<xsl:otherwise>
       										&nbsp;<b><xsl:value-of select="Producto/PRODUCTO/PRECIO"/>&nbsp;€</b>
       									</xsl:otherwise>
       								</xsl:choose>
            				</td>
            				<td align="left" class="claro" >&nbsp;Consumo &nbsp;Anual</td>
            				<td class="blanco">
            				<!--<xsl:choose>
                				<xsl:when test="/Producto/PRODUCTO/IDUSUARIO!=''">-->
        									&nbsp;<xsl:value-of select="Producto/PRODUCTO/CONSUMOUNIDADES"/>&nbsp;
       									<!--</xsl:when>
       									<xsl:otherwise>
       										<b>oculto</b>
       									</xsl:otherwise>
       								</xsl:choose>-->
            				</td>
            			</tr>
                </table> 
        	</td>
	    </tr>
		
	  </table>
	</td>
  </tr>
  <tr>
  	<td height="50px"></td>
  </tr>
  </form>
  </table>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
