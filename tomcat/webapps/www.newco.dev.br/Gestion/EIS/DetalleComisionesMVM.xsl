<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Listado de comisiones devengadas de la plataforma MedicalVM
 |
 |	(c) 12/1/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
	  <title>Comisiones de proveedores entre dos fechas</title>
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    
	<xsl:text disable-output-escaping="yes"><![CDATA[
		<script type="text/javascript">
	
	function PrepararFactura(IDProveedor)
	{
		var form=document.forms[0];
		var Enlace='http://www.newco.dev.br/Facturacion/CrearFacturaDeProveedor.xsql?'
				+'IDPROVEEDOR='+form.elements['IDPROVEEDOR'].value
				+'&'+'FECHAINICIO='+form.elements['FECHAINICIO'].value
				+'&'+'FECHAFINAL='+form.elements['FECHAFINAL'].value;
				
		MostrarPag(Enlace, 'DetalleComisiones');
	}
	</script>
        ]]></xsl:text>
      </head>
      <body>      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="ListadoComisiones/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="ListadoComisiones/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
		
		<form name="Parametros" action="DetalleComisionesMVM.xsql">
			<input type="hidden" name="IDPROVEEDOR">
			<xsl:attribute name="value">
			<xsl:value-of select="/ListadoComisiones/IDPROVEEDOR"/>
			</xsl:attribute>	
			</input>
			<table class="infoTable">
			<tr>
				<td class="labelRight quince">
				Fecha inicio (dd/mm/yyyy):
				</td>
				<td class="datosLeft trenta">
					<input type="text" name="FECHAINICIO">
					<xsl:attribute name="value">
					<xsl:value-of select="/ListadoComisiones/FECHAINICIO"/>
					</xsl:attribute>	
					</input>
				</td>
				<td class="labelRight quince">
				Fecha final (dd/mm/yyyy):
				</td>
				<td class="datosLeft trenta">
					<input type="text" name="FECHAFINAL">
					<xsl:attribute name="value">
					<xsl:value-of select="/ListadoComisiones/FECHAFINAL"/>
					</xsl:attribute>	
					</input>
				</td>
				<td class="dies">
					<a href="javascript:SubmitForm(document.forms[0])">Enviar</a>
				</td>
			</tr>
			</table>
		</form>
		<br/>
		<br/>
          <table class="grandeInicio" >
          <thead>
          <tr class="titleTabla"><th colspan="5">Comisiones devengadas</th></tr>
         
	    	<!-- Titulo -->
          	<tr class="titulos">
	      		<td class="quince">Fecha</td>
	      		<td class="quince">Pedido</td>
	      		<td class="quarenta">Cliente</td>
          		<td class="quince">Pedido(Euros)</td>
          		<td class="quince">Comisión(Euros)</td>
			</tr> 
            </thead>
            <tbody>
            	<xsl:for-each select="ListadoComisiones/ROW">
            	<tr>
                	<td><xsl:value-of select="FECHA"/>;</td>
                	<td><xsl:value-of select="NUMERO"/></td>
                	<td><xsl:value-of select="NOMBRECLIENTE"/></td>
                	<td><xsl:value-of select="IMPORTE"/></td>
                	<td><xsl:value-of select="COMISION"/></td>
				</tr>
            	</xsl:for-each>	    
          	  <tr>
               	<td colspan="2">&nbsp;</td>
                <td>
				<div class="boton">
					<a><xsl:attribute name="href">javascript:PrepararFactura(<xsl:value-of select="IDEMPRESA"/>);</xsl:attribute>
					Preparar Factura</a>
				</div>
				</td>
               	<td colspan="2">&nbsp;</td>
			</tr>
            </tbody>
          </table> 
		  
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
