<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Tablon de anuncios de MedicalVM
 |
 |	(c) 30/8/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <!-- 
	<title><xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	-->
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        
       <script type="text/javascript">
	
	<!-- 
	
		var noticiaIndividual=null;
	
        /*
        
        function MostrarPag(pag,titulo){
          if (is_nav){
            ample=parseInt(window.outerWidth*80/100)-50;
            alcada=parseInt(window.innerHeight-23)-50;
            alt=parseInt(window.parent.innerHeight+18)-parseInt(window.innerHeight)+25;
            esquerra = parseInt(window.outerWidth*18/100)+25;
            if (noticiaIndividual && noticiaIndividual.open){
              noticiaIndividual=null; //.close();            
            }
            noticiaIndividual=window.open(pag,'Noticia','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
          }else{
            ample = window.screen.availWidth-window.screenLeft-15-50;
            alcada = document.body.offsetHeight-27-50;
            esquerra = window.screenLeft+25;
            alt = window.screenTop+25;
	    	noticiaIndividual=window.open(pag,'Noticia','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
          }
        }
        
        */	  	  	
 
        -->
        </script>
        
        
        ]]></xsl:text>
      </head>
      <body class="blanco" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
		<xsl:variable name="Mantenimiento">	
			<!--	Controlara si es un indice para mantenimiento o	consulta-->
			<xsl:value-of select="Facturas/Mantenimiento"/>
		</xsl:variable>
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo -->
          <xsl:when test="Facturas/xsql-error">
            <xsl:apply-templates select="Noticias/xsql-error"/>          
          </xsl:when>
	
        <xsl:when test="Facturas/FACTURA/Sorry">
          <xsl:apply-templates select="Noticias/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        <xsl:apply-templates select="Facturas/button"/>
        <xsl:value-of select="@TIPO"/>
	  <div class="tituloPag" align="center">Facturas creadas en MedicalVM</div>
	  <div align="center">
		Mantenimiento de facturas<br/><br/><br/>
	  </div>
	  
			<!--	Boton de nueva noticia 	-->
			<p  align="center">
				<xsl:choose>
					<xsl:when test="$Mantenimiento=1">
			 		<a>
			   			<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Facturacion/Factura.xsql')</xsl:attribute>
						Crear Nueva Factura<br/>
			 		</a>
			 		<a>
			   			<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Gestion/EIS/TotalComisionesMVM.xsql')</xsl:attribute>
						Ver comisiones devengadas<br/>
			 		</a>
					<br/>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</p>
          
            <table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="grisclaro">
			<tr>
	        	<td class="grisclaro">
        	  	<table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="blanco">
				<tr><td class="grisclaro">
				Facturas emitidas por MedicalVM
				</td></tr>
				</table>
				</td>
			</tr>
	      <tr>
	        <td>
        	  <table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="medio">
              <tr class="oscuro">
			  <xsl:choose>
				<xsl:when test="$Mantenimiento=1">
		      		<td width="5%">&nbsp;</td>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			  </xsl:choose>
		      <td align="center" width="8%">Código</td>
		      <td align="center" width="8%">Fecha</td>
		      <td align="center" width="15%">Empresa</td>
		      <td align="center" width="15%">Cliente</td>
		      <td align="center" width="8%">Subtotal</td>
		      <td align="center" width="8%">IVA</td>
		      <td align="center" width="8%">Suplidos</td>
		      <td align="center" width="8%">Total</td>
		      <td align="center" width="30%">Estado</td>
		      </tr>
          	 <xsl:for-each select="Facturas/FACTURA">
			<!--	Titulos de las noticias, consejos, FAQs, etc.		-->
            	<tr class="claro">
					<!--
					<xsl:attribute name="bgColor">
					<xsl:choose> 
					<xsl:when test='(position() mod 2)'>#EEFFFF</xsl:when> 
					<xsl:otherwise>#d0f8f7</xsl:otherwise>
					</xsl:choose> 
					</xsl:attribute>
					-->
					<xsl:choose>
						<xsl:when test="$Mantenimiento=1">
			   				<td align="center">
							<a>
			   				<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Facturacion/Factura.xsql?ID=<xsl:value-of select='ID'/>')</xsl:attribute>
							Edit
							</a>
							</td>
						</xsl:when>
						<xsl:otherwise>
						</xsl:otherwise>
					</xsl:choose>
		       		<td align="center">
			 		<a>
			   			<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Facturacion/VerFactura.xsql?ID=<xsl:value-of select='ID'/>')</xsl:attribute>
			  			<xsl:copy-of select="CODIGO"/>
					</a>
					<td>
			  			<xsl:copy-of select="FECHA"/>
					</td>
					<td>
			  			<xsl:copy-of select="PROVEEDOR"/>
					</td>
					<td>
			  			<xsl:copy-of select="CLIENTE"/>
					</td>
					<td align="right">
			  			<xsl:copy-of select="SUBTOTAL"/>
					</td>
					<td align="right">
			  			<xsl:copy-of select="IVA"/>
					</td>
					<td align="right">
			  			<xsl:copy-of select="SUPLIDOS"/>
					</td>
					<td align="right">
			  			<xsl:copy-of select="TOTAL"/>
					</td>
					<td>
			  			<xsl:copy-of select="ESTADO"/>
					</td>
		       </td>
		     </tr>
		     </xsl:for-each>	    
       	     </table> 
		   </td>
		 </tr>
	       </table>
             </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
