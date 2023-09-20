<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	9jul09	ET	Navegación de proveedores
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
		<html> 
		<head>

		<title>MedicalVM - Navegación de proveedores</title>
        
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

        <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		</head>
		<body>
		<xsl:choose>
			<xsl:when test="/NavegarProveedores/NAVEGARPROVEEDORES/PRODUCTOS">
				<xsl:apply-templates select="/NavegarProveedores/NAVEGARPROVEEDORES/PRODUCTOS"/>
			</xsl:when>
			<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="/NavegarProveedores/NAVEGARPROVEEDORES/SUBFAMILIAS">
					<xsl:apply-templates select="/NavegarProveedores/NAVEGARPROVEEDORES/SUBFAMILIAS"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="/NavegarProveedores/NAVEGARPROVEEDORES/FAMILIAS">
							<xsl:apply-templates select="/NavegarProveedores/NAVEGARPROVEEDORES/FAMILIAS"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="/NavegarProveedores/NAVEGARPROVEEDORES/PROVEEDORES"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		</body>
	</html>
</xsl:template>

<xsl:template match="PRODUCTOS">
  	<div class="divLeft">
    
    <div class="breadcrumbs">  
      <a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql" onmouseover="window.status='Ver las subfamilias de productos de {NOMBRE}'; return true;" onmouseout="window.status=''; return true;">Navegación de proveedores</a>
        <xsl:text>&nbsp;&gt;&nbsp;</xsl:text>
         
    	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql?IDPROVEEDOR={IDPROVEEDOR}" onmouseover="window.status='Volver atrás'; return true;" onmouseout="window.status=''; return true;"><xsl:value-of select="PROVEEDOR"/></a>
          <xsl:text>&nbsp;&gt;&nbsp;</xsl:text>
           <a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql?IDPROVEEDOR={IDPROVEEDOR}&amp;IDFAMILIA={IDFAMILIA}&amp;NOMBREFAMILIA={FAMILIA_NORM}&amp;IDSUBFAMILIA={ID}" onmouseover="window.status='Volver atrás'; return true;" onmouseout="window.status=''; return true;"><xsl:value-of select="FAMILIA"/></a>
         <xsl:text>&nbsp;&gt;&nbsp;</xsl:text>
    </div><!--fin de breadcrumbs-->
    
  	 <h1 class="titlePage">Producto/s<xsl:if test="SUBFAMILIA != ''">:&nbsp;<xsl:value-of select="SUBFAMILIA"/></xsl:if></h1>

              <table class="grandeInicio">
                 <thead>
					<tr class="tituloTabla trcenter">
                    <th>&nbsp;</th>
                        <th class="quince">
							Referencia
                        </th>
                        <th>
							Nombre
                        </th>
                        <th class="dies">
							Unidad Básica
                        </th>
                        <th class="dies">
							Unidades por lote
                        </th>
                        <th class="dies">
							Precio
                        </th>
                       <th>&nbsp;</th>
                    </tr>
                    </thead>
                    <tbody>
					<xsl:for-each select="./PRODUCTO">
					<tr class="trcenter">
                     <td>&nbsp;</td>
                        <td>
							<xsl:value-of select="REFERENCIA"/>
                        </td>
                        <td>
							<xsl:value-of select="NOMBRE"/>
                        </td>
                        <td>
							<xsl:value-of select="UNIDADBASICA"/>
                        </td>
                        <td>
							<xsl:value-of select="UNIDADESPORLOTE"/>
                        </td>
                        <td>
							<xsl:value-of select="PRECIO"/>
                        </td>
                       <td>&nbsp;</td>
                    </tr>
					</xsl:for-each>
                </tbody>
			  </table>
         
     </div><!--fin de divLeft-->
    <!--salir-->
    <div class="divLeft" style="margin:10px 0px 0px 5px;">
        	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/PaginaEnBlanco.xsql" onmouseover="window.status='Salir de la navegación de proveedores'; return true;" onmouseout="window.status=''; return true;">
            <img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar"/>
            </a>
      	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/PaginaEnBlanco.xsql" onmouseover="window.status='Salir de la navegación de proveedores'; return true;" onmouseout="window.status=''; return true;">Salir</a>
   </div><!--fin de salir-->
</xsl:template>


<xsl:template match="SUBFAMILIAS">
   	<div class="divLeft">
    		
          
         <div class="breadcrumbs">
           <a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql" onmouseover="window.status='Ver las subfamilias de productos de {NOMBRE}'; return true;" onmouseout="window.status=''; return true;">Navegación de proveedores</a>
        <xsl:text>&nbsp;&gt;&nbsp;</xsl:text>
            <a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql?IDPROVEEDOR={IDPROVEEDOR}" onmouseover="window.status='Volver atrás'; return true;" onmouseout="window.status=''; return true;"><xsl:value-of select="PROVEEDOR"/></a>
          <xsl:text>&nbsp;&gt;&nbsp;</xsl:text>
          </div>
          
          <h1 class="titlePage">
          <a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql?IDPROVEEDOR={IDPROVEEDOR}&amp;IDFAMILIA={IDFAMILIA}&amp;NOMBREFAMILIA={FAMILIA_NORM}&amp;IDSUBFAMILIA={ID}" onmouseover="window.status='Volver atrás'; return true;" onmouseout="window.status=''; return true;"><xsl:value-of select="FAMILIA"/></a>
   
         </h1>
			<xsl:for-each select="./SUBFAMILIA">
				<div class="divLeft50">
					 &nbsp;&nbsp;&nbsp;<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql?IDPROVEEDOR={../IDPROVEEDOR}&amp;IDFAMILIA={../IDFAMILIA}&amp;NOMBREFAMILIA={../FAMILIA_NORM}&amp;IDSUBFAMILIA={ID}&amp;NOMBRESUBFAMILIA={NOMBRE_NORM}" onmouseover="window.status='Ver los productos de {NOMBRE}'; return true;" onmouseout="window.status=''; return true;"><xsl:value-of select="NOMBRE"/></a>
                  </div>
			 </xsl:for-each>
       
     	</div>
   <!--salir-->
    <div class="divLeft salir">
        	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/PaginaEnBlanco.xsql" onmouseover="window.status='Salir de la navegación de proveedores'; return true;" onmouseout="window.status=''; return true;">
            <img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar"/>
            </a>
      	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/PaginaEnBlanco.xsql" onmouseover="window.status='Salir de la navegación de proveedores'; return true;" onmouseout="window.status=''; return true;">Salir</a>
   </div><!--fin de salir-->
</xsl:template>


<xsl:template match="FAMILIAS">
   	<div class="divLeft">
           
        <div class="breadcrumbs">
        <a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql" onmouseover="window.status='Ver las subfamilias de productos de {NOMBRE}'; return true;" onmouseout="window.status=''; return true;">Navegación de proveedores</a>
        <xsl:text>&nbsp;&gt;&nbsp;</xsl:text>
        </div>
        
        <h1 class="titlePage">
         <a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql?IDPROVEEDOR={IDPROVEEDOR}" onmouseover="window.status='Volver atrás'; return true;" onmouseout="window.status=''; return true;"><xsl:value-of select="PROVEEDOR"/></a>
        </h1>
					<xsl:for-each select="./FAMILIA">
					<div class="divLeft50">
						 &nbsp;&nbsp;&nbsp;<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql?IDPROVEEDOR={../IDPROVEEDOR}&amp;IDFAMILIA={ID}&amp;NOMBREFAMILIA={NOMBRE_NORM}" onmouseover="window.status='Ver las subfamilias de productos de {NOMBRE}'; return true;" onmouseout="window.status=''; return true;"><xsl:value-of select="NOMBRE"/></a>
                      </div>
					</xsl:for-each>
            
    </div><!--fin de divleft-->
        
   <!--salir-->
    <div class="divLeft salir">
        	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/PaginaEnBlanco.xsql" onmouseover="window.status='Salir de la navegación de proveedores'; return true;" onmouseout="window.status=''; return true;">
            <img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar"/>
            </a>
      	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/PaginaEnBlanco.xsql" onmouseover="window.status='Salir de la navegación de proveedores'; return true;" onmouseout="window.status=''; return true;">Salir</a>
   </div><!--fin de salir-->
</xsl:template>


<xsl:template match="PROVEEDORES">

		<div class="divLeft">
    	
           <h1 class="titlePage">Navegación de proveedores - Listado de proveedores</h1>
     
			<xsl:for-each select="./PROVEEDOR">
				<div class="divLeft30">
                &nbsp;&nbsp;&nbsp;
							<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/NavegarProveedores.xsql?IDPROVEEDOR={ID}" onmouseover="window.status='Ver las familias de productos de {NOMBRE}'; return true;" onmouseout="window.status=''; return true;"><xsl:value-of select="NOMBRE"/></a>
                    </div>
			</xsl:for-each>
            
          
 </div>	
 
<!--salir-->
    <div class="divLeft salir">
        	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/PaginaEnBlanco.xsql" onmouseover="window.status='Salir de la navegación de proveedores'; return true;" onmouseout="window.status=''; return true;">
            <img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar"/>
            </a>
      	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/PaginaEnBlanco.xsql" onmouseover="window.status='Salir de la navegación de proveedores'; return true;" onmouseout="window.status=''; return true;">Salir</a>
   </div><!--fin de salir-->
</xsl:template>

</xsl:stylesheet>

