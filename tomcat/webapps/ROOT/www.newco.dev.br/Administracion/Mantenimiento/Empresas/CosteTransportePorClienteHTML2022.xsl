<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Coste transporte por cliente
	Ultima revision: ET 9may22 10:05 CosteTransportePorCliente2022_090522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
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

		<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_coste_trasporte_cliente']/node()"/></title>
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->  

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
		<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CosteTransportePorCliente2022_090522.js"></script>
        
      </head>
      <body>
      	<!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/MantenimientoEmpresas/LANG"><xsl:value-of select="/MantenimientoEmpresas/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      	<!--idioma fin-->
           
     
        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
                <xsl:attribute name="onLoad">
                  cargarValoresDescripcionCosteTrasporte('<xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_DETALLE"/>','EMP_DESCRIPCIONCOSTETRANSPORTE');
                </xsl:attribute>
              </xsl:when>
            </xsl:choose>


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/PROVEEDOR/NOMBRE"/>
				<span class="CompletarTitulo">
                    <a class="btnNormal" href="javascript:chMantenEmpresa({/MantenimientoEmpresas/COSTESTRANSPORTE/PROVEEDOR/ID});">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
                    </a>
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>

        <form name="form1" action="CosteTransportePorCliente2022.xsql" method="post">
          <input type="hidden" name="IDPROVEEDOR" value="{MantenimientoEmpresas/COSTESTRANSPORTE/PROVEEDOR/ID}"/>
          <input type="hidden" name="ACCION"/>
          <input type="hidden" name="DESDE"/>
          <input type="hidden" name="NUEVO_CLIENTE"/>
          <input type="hidden" name="NUEVO_CENTRO"/>
          
          
           <input type="hidden" name="EMP_COSTETRANSPORTE_ACTIVO" value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO}"/>
           <input type="hidden" name="EMP_COSTETRANSPORTE_IMPORTE"  value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_IMPORTE}"/>
           <input type="hidden" name="EMP_COSTETRANSPORTE_DETALLE"  value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_DETALLE}"/>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
            <th class="w1px">&nbsp;</th>
            <th align="textLeft">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>
            </th>
            <th class="w150px">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>
            </th>
            <th class="w150px">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte_eur']/node()"/>
            </th>
            <th align="textLeft">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='descr_coste_trasporte']/node()"/>
            </th>
            <th class="w1px">&nbsp;</th>
        </tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <!-- si hay empresas las listamos con sus centros indentados (si los hay) -->
        <xsl:choose>
            <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA">
              <!-- mostramos cada empresa -->
              <xsl:for-each select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA">
              <tr class="con_hover">
				<td class="color_status">&nbsp;</td>
	          <td class="textLeft">
	            <a href="javascript:ModificarCosteTransporte({ID},'','MODIFICARCLIENTE');">
	              <xsl:value-of select="NOMBRE"/>
	            </a>
	          </td>
                <td>
                 <input type="hidden" name="EMP_COSTETRANSPORTE_ACTIVO_{ID}" value="{ACTIVO}"/>
                 <xsl:choose>
                   <xsl:when test="ACTIVO='N'">
                     <b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
                   </xsl:when>
                   <xsl:when test="ACTIVO='S'">
                     <b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
                   </xsl:when>
                   <xsl:when test="ACTIVO='E'">
                     <b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
                   </xsl:when>
                   <xsl:when test="ACTIVO='I'">
                     <b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
                   </xsl:when>
                 </xsl:choose>
                </td>
                <td>
                  <xsl:value-of select="IMPORTE"/>
                </td>
                <td align="left">
                      <xsl:copy-of select="DESCRIPCION_HTML"/>
                </td>
                <td>
                	<a href="javascript:BorrarCosteTrasporte('{ID}','','BORRARCLIENTE','');">
                    	<img src="http://www.newco.dev.br/images/2022/icones/del.svg" />
                    </a>
	          	</td>
              </tr>
              <!-- si tiene centros con pedidos minimos los listamos tambien -->
                 <xsl:for-each select="CENTROS_CON_COSTE_TRANSPORTE/CENTRO">
                 <tr class="con_hover">
				 	<td class="color_status">&nbsp;</td>
	                <td class="textLeft">
	                   &nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;<a href="javascript:ModificarCosteTransporte('{../../ID}','{ID}','MODIFICARCENTRO');">
	                    <xsl:value-of select="NOMBRE"/>
	                   </a>
	                </td>
                   	<td>
                    	<input type="hidden" name="EMP_COSTETRANSPORTE_ACTIVO_{ID}" value="{ACTIVO}"/>
                    	<xsl:choose>
                    	  <xsl:when test="ACTIVO='N'">
                        	<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
                    	  </xsl:when>
                    	  <xsl:when test="ACTIVO='S'">
                        	<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
                    	  </xsl:when>
                    	  <xsl:when test="ACTIVO='E'">
                        	<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
                    	  </xsl:when>
                    	  <xsl:when test="ACTIVO='I'">
                        	<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
                    	  </xsl:when>
                    	</xsl:choose>
                   </td>
                   <td>
                     <xsl:value-of select="IMPORTE"/>
                   </td>
                   <td>
                         <xsl:copy-of select="DESCRIPCION_HTML"/>
                   </td>
                   <td>
                   		<a href="javascript:BorrarCosteTrasporte('{../../ID}','{ID}','BORRARCENTRO','');">
                    		<img src="http://www.newco.dev.br/images/2022/icones/del.svg" />
                    	</a>
	               </td>
                 </tr>
                   
                 </xsl:for-each>
              
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <tr>
                <td colspan="5">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_empresa_coste_trasporte']/node()"/>
                </td>
              </tr>
            </xsl:otherwise>
          </xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
	<br /><br />
     <!--tabla abajo mantenimiento-->
    	<table cellspacing="6px" cellpadding="6px">
    	<tr class="fondoGris h40px">
              <th class="labelRight w200px">
                <!--<xsl:choose>
                    <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCLIENTE' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCENTRO'">
                      <xsl:choose>
                        <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCLIENTE' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO'">
                         <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>
                    </xsl:otherwise>
                  </xsl:choose>-->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:&nbsp;
               </th>
               <th class="textLeft">
                  <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INICIO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='CENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCLIENTE'">
 						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="IDEMPRESACLIENTE"/>
						<xsl:with-param name="path" select="/MantenimientoEmpresas/COSTESTRANSPORTE/EMPRESAS/field" />
						<xsl:with-param name="claSel">w400px</xsl:with-param>
						</xsl:call-template> 
                  </xsl:when>
                  <xsl:otherwise>
                      <input type="hidden" name="IDEMPRESACLIENTE" value=""/>
                  </xsl:otherwise>
                 </xsl:choose>
				 
				<!-- &nbsp;&nbsp; [<xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION"/>] SOLO PRUEBAS!&nbsp;&nbsp;-->
				 
              </th>
       			<xsl:choose>
				<xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INICIO' and /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='BORRARCLIENTE' and /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION !='MODIFICARCLIENTE'">
            		<th align="labelRight w200px">
            	  		<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
            		</th>
              		<th class="textLeft">
						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="IDCENTROCLIENTE"/>
						<xsl:with-param name="path" select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/LISTACENTROS/field" />
						<xsl:with-param name="claSel">w400px</xsl:with-param>
					</xsl:call-template>

            	</th>
				</xsl:when>
				<xsl:otherwise>
	            	<th colspan="2">&nbsp;</th>
                	<input type="hidden" name="IDCENTROCLIENTE" value=""/>
				</xsl:otherwise>
				</xsl:choose>
          </tr>
          
           
           <!-- si hay alguna empresa seleccionada mostramos el desplegable de centros o el centro seleccionado - ->
			<xsl:choose>
			<xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INICIO' and /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='BORRARCLIENTE' and /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION !='MODIFICARCLIENTE'">
                	  <tr>
                    	<th align="right">
                    	  <xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
                    	</th>
                        <th colspan="2" align="left">
                    	  &nbsp;&nbsp;&nbsp;&nbsp;>>&nbsp;&nbsp;
							<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="IDCENTROCLIENTE"/>
							<xsl:with-param name="path" select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/LISTACENTROS/field" />
							<xsl:with-param name="claSel">w400px</xsl:with-param>
							</xsl:call-template>

                    	</th>
                        <th colspan="2">&nbsp;</th>
                	  </tr>
			</xsl:when>
			<xsl:otherwise>
                 <input type="hidden" name="IDCENTROCLIENTE" value=""/>
			</xsl:otherwise>
			</xsl:choose>-->
	      </table>   
          <br/> 
          <table cellspacing="6px" cellpadding="6px" > 
            <!--   <tr class="subTituloTabla">
                  <td colspan="3">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>
                  </td>
                </tr>-->
			<tr>
             <td class="labelRight">
               <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>:
             </td>
             <td class="tres">
               <xsl:choose>
                  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='S' or MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='E'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='I'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <!--modificar, insertar centro-->
                  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='S' or //CENTRO_SELECCIONADO/ACTIVO='E'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='I'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='S' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='E'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='I'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>   
                  </xsl:otherwise>
                </xsl:choose>
             </td>
           <td class="datosLeft" >
             <xsl:value-of select="document($doc)/translation/texts/item[@name='activar_coste_trasporte']/node()"/>.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           		<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:</strong>&nbsp;<input type="hidden" name="EMP_COSTETRANSPORTEACTIVO" value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO}"/>
        		<xsl:choose>
        		  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
            		<xsl:choose>
            		  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='S' or MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='E' or MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='I'">
            		 <input type="text" class="campopesquisa w80px" name="EMP_COSTETRANSPORTE" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_IMPORTE}"/>
	    		  </xsl:when>
	    		  <xsl:otherwise>
	        		<input type="text" class="campopesquisa w80px" name="EMP_COSTETRANSPORTE" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
	    		  </xsl:otherwise>
   	    		</xsl:choose>  
   			  </xsl:when>
   			  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO'">
   	    		<xsl:choose>
            		  <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='S' or //CENTRO_SELECCIONADO/ACTIVO='E' or //CENTRO_SELECCIONADO/ACTIVO='I'">
	        		<input type="text" class="campopesquisa w80px" name="EMP_COSTETRANSPORTE" onBlur="ValidarNumero(this,2);" value="{//CENTRO_SELECCIONADO/IMPORTE}"/>
	    		  </xsl:when>
	    		  <xsl:otherwise>
	        		<input type="text" class="campopesquisa w80px" name="EMP_COSTETRANSPORTE" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
	    		  </xsl:otherwise>
   	    		</xsl:choose>
   			  </xsl:when>
   			  <xsl:otherwise>
   	    		<xsl:choose>
            	<xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='S' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='E' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='I'">
	        		<input type="text" class="campopesquisa w80px" name="EMP_COSTETRANSPORTE" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/IMPORTE}"/>
	    		</xsl:when>
	    		<xsl:otherwise>
	        		<input type="text" class="campopesquisa w80px" name="EMP_COSTETRANSPORTE" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
	    		</xsl:otherwise>
   	    		</xsl:choose>
   			  </xsl:otherwise>
   			  </xsl:choose>
    		  </td>
         </tr>
         <tr>
           <td class="labelRight">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/>:
           </td>
           <td>
             <xsl:choose>
               <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='S'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='E'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='I'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" disabled="disabled" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:when>
   	          <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='S'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='E'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='I'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" disabled="disabled" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:when>
   	          <xsl:otherwise>
   	            <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='S'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='E'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='I'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" disabled="disabled" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:otherwise>
   	        </xsl:choose>
   	   </td>
   	   <td class="datosLeft">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='no_permitir_pedidos_sin_coste_trasporte']/node()"/>.
           </td>
   	 </tr>
   	 <tr>
           <td class="labelRight">
           	<xsl:value-of select="document($doc)/translation/texts/item[@name='no_aceptar_ofertas']/node()"/>:
           </td>
           <td>
             <xsl:choose>
               <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
                 <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='I'">
   	             <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:when>
   	       <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO'">
   	         <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/ACTIVO='I'">
	             <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:when>
   	       <xsl:otherwise>
   	         <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='I'">
   	             <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:otherwise>
   	     </xsl:choose>
   	   </td>
   	   <td class="datosLeft">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='permitir_unicamente_envio_pedidos']/node()"/>.
       </td>
      </tr>
      <tr>
     <td class="labelRight">
     	<xsl:value-of select="document($doc)/translation/texts/item[@name='descr_coste_trasporte']/node()"/>
      </td>
      <td colspan="2" class="datosLeft">
        <xsl:choose>
          <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
            <xsl:choose> 
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='' or MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5" disabled="disabled"></textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5">
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>    
   	  </xsl:when>
   	  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO'">
            <xsl:choose> 
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/EMP_COSTETRANSPORTE_ACTIVO='' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/EMP_COSTETRANSPORTE_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5" disabled="disabled">
   	        </textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5">
   	          <xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/DESCRIPCION"/>
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:when>
   	  <xsl:otherwise>
   	    <xsl:choose> 
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/EMP_COSTETRANSPORTE_ACTIVO='' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/EMP_COSTETRANSPORTE_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5" disabled="disabled">
   	        </textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5">
   	          <xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/DESCRIPCION"/>
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:otherwise>
   	</xsl:choose>
      </td>
    </tr>
	</table>
      <br/>
      <br />
      <table width="100%">
		<tr align="center">
        	<td class="dies">&nbsp;</td>
             <!--9may22 ya volvemos desde el boton de la cabecera<td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="/MantenimientoEmpresas/button[@label='Cerrar']"/>
                </xsl:call-template>
              </td>-->
              <xsl:choose>
                <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION ='MODIFICARCLIENTE'">
                  <!--9MAY22 No queda claro para que sirve este boton<td> 
                  	<a class="btnDestacado" href="javascript:NuevoCosteTrasportePorCliente(document.forms[0]);"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver_a_empresas']/node()"/></a>
                  </td>-->
                   
                  <xsl:choose>
                  <xsl:when test="(/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO') and /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE'">
                      <td>
                        	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTARCENTRO');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_centro']/node()"/>
                            </a>
                      </td>
                    </xsl:when>
                    <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCENTRO'">
                       <td>
                        	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTARCENTRO');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_centro']/node()"/>
                            </a>
                      </td>
                    </xsl:when>
                    <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCLIENTE'">
                    	 <td> 
                        	<a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTARCLIENTE');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_empresa']/node()"/>
                            </a>
                         </td>
                    </xsl:when>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <td  align="center">
                        <a class="btnDestacado" href="javascript:ActualizarDatos(document.forms[0],'INSERTARCLIENTE');">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_empresa']/node()"/>
                        </a>
                  </td>
                </xsl:otherwise>
              </xsl:choose>
            </tr>
          </table>
        </form>
        
        <form name="MensajeJS">
        	<input type="hidden" name="COSTE_TRANSPORTE_ACTIVO_ALERT" value="{document($doc)/translation/texts/item[@name='coste_trasporte_activo_alert']/node()}"/>
            
            <input type="hidden" name="RELLENE_COSTE_TRANSPORTE_NO_ACEPTAR" value="{document($doc)/translation/texts/item[@name='rellene_coste_trasporte_no_aceptar']/node()}"/>
            
            <input type="hidden" name="SEL_EMPRESA_COSTE_TRANSPORTE" value="{document($doc)/translation/texts/item[@name='seleccione_empresa_coste_trasporte']/node()}"/>
            
            <input type="hidden" name="SEL_CENTRO_COSTE_TRANSPORTE" value="{document($doc)/translation/texts/item[@name='seleccione_centro_coste_trasporte']/node()}"/>
            
            <input type="hidden" name="BORRAR_COSTE_TRANSPORTE_EMPRESA" value="{document($doc)/translation/texts/item[@name='borrar_coste_trasporte_empresa']/node()}"/>
            
            <input type="hidden" name="BORRAR_COSTE_TRANSPORTE_CENTRO" value="{document($doc)/translation/texts/item[@name='borrar_coste_trasporte_centro']/node()}"/>
            
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
