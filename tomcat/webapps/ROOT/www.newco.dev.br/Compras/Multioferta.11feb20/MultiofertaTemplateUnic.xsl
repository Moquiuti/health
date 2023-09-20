<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Multioferta (todos los estados): Templates
	Ultima revisión ET 20dic19 09:30
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  
  <!--multiframe -->
  
<!--titulo comun multioferta-->
<xsl:template name="tituloMOFtitle">
	<xsl:param name="numMOF"/>
    <xsl:param name="empresa"/>
    
   
	 <!--idioma-->                                              
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
      <!-- <xsl:value-of select="$numMOF"/> -->
     
    
    	<!--eligo si es muestra (32,33,34) o pedido-->
        <xsl:choose>
        <xsl:when test="contains($numMOF,'32') or contains($numMOF,'33') or contains($numMOF,'34') or contains($numMOF,'35') or contains($numMOF,'36') or contains($numMOF,'37')">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='muestra']/node()"/>&nbsp;
        </xsl:when>
        <xsl:otherwise>
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>&nbsp;
        </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="/Multioferta/MULTIOFERTA/PED_NUMERO"/>
        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;       
            <xsl:choose>
            <xsl:when test="/Multioferta/MULTIOFERTA/CENTRO/CEN_NOMBRECORTO != ''"><xsl:value-of select="/Multioferta/MULTIOFERTA/CENTRO/CEN_NOMBRECORTO"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="substring(/Multioferta/MULTIOFERTA/CENTRO/CEN_NOMBRE,0,30)"/></xsl:otherwise>
            </xsl:choose>
            &nbsp;
            <xsl:value-of select="document($doc)/translation/texts/item[@name='a']/node()"/>&nbsp;  
        <xsl:value-of select="/Multioferta/MULTIOFERTA/CENTROPROVEEDOR" />.&nbsp;
        
        <!--eligo titulo especifico de cada MOF-->
        <xsl:choose>
         <xsl:when test="contains($numMOF,'11')">
         	<xsl:choose>
              <xsl:when test="translate(translate(/Multioferta/MULTIOFERTA/IMPORTE_FINAL_PEDIDO,'.',''),',','.')>=0"><!--30ago18 superior o igual a 0, en Colombia hay pedidos de importe 0	-->
                &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptacion_del_pedido']/node()"/>.
              </xsl:when>
              <xsl:otherwise>
                &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_de_abono']/node()"/>.
              </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="contains($numMOF,'28')">
        	<xsl:choose>
        		<xsl:when test="/Multioferta/ESMODELO='N'">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='proximo_pedido']/node()"/>
        		</xsl:when>
        		<xsl:otherwise>
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_modelo']/node()"/>
	  			</xsl:otherwise>
	  		</xsl:choose>
        </xsl:when>
        <xsl:when test="contains($numMOF,'34')">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_muestra_rechazada']/node()"/>&nbsp;
        	<xsl:value-of select="Multioferta/MULTIOFERTA/PROVEEDOR"/>.&nbsp;
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='proceso_terminado']/node()"/>        
        </xsl:when>
        
        <xsl:otherwise>
        	<xsl:if test="contains($numMOF,'12') or contains($numMOF,'23')">
        	&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_NOMBRE"/>&nbsp;
        	</xsl:if>
            
            <!--enseño el texto de cada estado-->
        	<xsl:value-of select="document($doc)/translation/texts/item[@name=$numMOF]/node()"/>
            
        </xsl:otherwise>
        </xsl:choose>
        
        <!--si es titulo h1 de la pagina enseño nombre empresa
        <xsl:if test="$empresa = 'S' and contains($numMOF,'32_RO')">
        	&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_NOMBRE"/><xsl:text>.&nbsp;</xsl:text>   
        </xsl:if>-->
        
</xsl:template>      

<!--titulo comun multioferta-->
<xsl:template name="tituloMOF">
	<xsl:param name="numMOF"/>
    <xsl:param name="empresa"/>
    
   
	 <!--idioma-->                                              
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
      <!-- <xsl:value-of select="$numMOF"/> -->
     
    
    	<!-- muestra (32,33,34) o pedido-->
        <xsl:choose>
        <xsl:when test="contains($numMOF,'32') or contains($numMOF,'33') or contains($numMOF,'34') or contains($numMOF,'35') or contains($numMOF,'36') or contains($numMOF,'37')">
            <!--<span class="fondoAma" style="padding:2px 4px;">-->
                <xsl:value-of select="document($doc)/translation/texts/item[@name='muestra']/node()"/>&nbsp;
                <xsl:value-of select="/Multioferta/MULTIOFERTA/PED_NUMERO"/>
            <!--</span>-->
        </xsl:when>
        <xsl:otherwise>
            <!--<span class="fondoAma" style="padding:2px 4px;">-->
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/PED_NUMERO"/>
           <!-- </span>-->
        </xsl:otherwise>
        </xsl:choose>
        
        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;       
            <xsl:choose>
            <xsl:when test="/Multioferta/MULTIOFERTA/CENTRO/CEN_NOMBRECORTO != ''"><xsl:value-of select="/Multioferta/MULTIOFERTA/CENTRO/CEN_NOMBRECORTO"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="substring(/Multioferta/MULTIOFERTA/CENTRO/CEN_NOMBRE,0,30)"/></xsl:otherwise>
            </xsl:choose>
            &nbsp;
            <xsl:value-of select="document($doc)/translation/texts/item[@name='a']/node()"/>&nbsp;  
        <xsl:value-of select="/Multioferta/MULTIOFERTA/CENTROPROVEEDOR" />&nbsp;
        
        <!--eligo titulo especifico de cada MOF-->
        <span style="font-size:14px;">
        (<xsl:choose>
         <xsl:when test="contains($numMOF,'11')">
         	<xsl:choose>
              <xsl:when test="translate(translate(/Multioferta/MULTIOFERTA/IMPORTE_FINAL_PEDIDO,'.',''),',','.')>=0">
                &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptacion_del_pedido']/node()"/>.
              </xsl:when>
              <xsl:otherwise>
                &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_de_abono']/node()"/>.
              </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="contains($numMOF,'28')">
        	<xsl:choose>
        		<xsl:when test="/Multioferta/ESMODELO='N'">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='proximo_pedido']/node()"/>
        		</xsl:when>
        		<xsl:otherwise>
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_modelo']/node()"/>
	  			</xsl:otherwise>
	  		</xsl:choose>
        </xsl:when>
        <xsl:when test="contains($numMOF,'34')">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_muestra_rechazada']/node()"/>&nbsp;
        	<xsl:value-of select="Multioferta/MULTIOFERTA/PROVEEDOR"/>.&nbsp;
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='proceso_terminado']/node()"/>        
        </xsl:when>
        
        <xsl:otherwise>
        	<xsl:if test="contains($numMOF,'12') or contains($numMOF,'23')">
        	&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_NOMBRE"/>&nbsp;
        	</xsl:if>
            
            <!--enseño el texto de cada estado-->
        	<xsl:value-of select="document($doc)/translation/texts/item[@name=$numMOF]/node()"/>
            
        </xsl:otherwise>
        </xsl:choose>)
        </span>
        
</xsl:template>      

<xsl:template name="datosCliente">
	<xsl:param name="numMOF" />
    
       <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
  <!--datos del cliente --> 
        <!--	 <table class="mediaTabla borderRight" cellspacing="0" cellpadding="0">-->
       	 <!--<table class="borderRight" cellspacing="0" cellpadding="0">-->
       	 <table class="buscador">
         <tbody>
              <tr class="sinLinea"> 
               <!--<td class="trenta label">-->
               <td class="labelRight" style="width:150px;">
                  &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:
                  <!--<xsl:if test="DATOSCLIENTE/EMP_NOMBRE != CENTRO/CEN_NOMBRE"><br />
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</xsl:if>-->
               </td>
               <td class="textLeft">  
                   <strong><xsl:value-of select="CENTRO/CEN_NOMBRE"/></strong>&nbsp;
                    <xsl:choose>
                    <xsl:when test="DATOSCLIENTE/EMP_NIF!=CENTRO/CEN_NIF and CENTRO/CEN_NIF!=''">
                    	(<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:&nbsp;<xsl:value-of select="CENTRO/CEN_NIF"/>)
                    </xsl:when>
                    <xsl:otherwise> 
                    	(<xsl:value-of select="DATOSCLIENTE/EMP_NIF"/>)
                    </xsl:otherwise>
                  </xsl:choose>
               </td>
              </tr>
              <tr class="sinLinea">
                  <td class="labelRight" valign="top">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Direccion_entrega']/node()"/>:</td>
                  <td class="textLeft" valign="top">
                    <xsl:value-of select="ENTREGA/MO_DIRECCION"/>
    				<p><xsl:value-of select="ENTREGA/MO_CPOSTAL"/><xsl:text>&nbsp;</xsl:text>
                    <xsl:value-of select="ENTREGA/MO_POBLACION"/><xsl:text>&nbsp;(</xsl:text>
    				<xsl:value-of select="ENTREGA/MO_PROVINCIA"/><xsl:text>)&nbsp;</xsl:text>
                    </p>
                  </td>
               </tr>
               <tr class="sinLinea"> 
               <td class="labelRight"> 
              		&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:</td>
               <td class="textLeft"><xsl:value-of select="./ENTREGA/MO_LUGARENTREGA"/> </td>
              </tr> 
              <!--centro de consumo-->
               <tr class="sinLinea"> 
               <td class="labelRight">
                <xsl:if test="./CENTROCONSUMO/MO_REFCENTROCONSUMO != '' and /Multioferta/MULTIOFERTA/MOSTRARCENTROSCONSUMO"> 
                	&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:
                </xsl:if>
               </td>
               <td class="textLeft">
                <xsl:if test="./CENTROCONSUMO/MO_CENTROCONSUMO != '' and /Multioferta/MULTIOFERTA/MOSTRARCENTROSCONSUMO"> 
                <xsl:value-of select="./CENTROCONSUMO/MO_CENTROCONSUMO"/>

                </xsl:if>
               </td>
              </tr>
			</tbody>
            
       </table>
</xsl:template><!--fin de datosCliente-->

<!--PROVEEDOR-->
<xsl:template name="datosProveedor">
	<xsl:param name="numMOF" />
    	
          <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
     
      
	 <!--<table class="mediaTabla borderRight" cellspacing="0" cellpadding="0" border="0">-->
	 <!--<table class="borderRight" cellspacing="0" cellpadding="0" border="0">-->

	 <table class="buscador">
         <tbody>
              <tr class="sinLinea"> 
               <!--<td class="trenta label">-->
               <td class="labelRight" style="width:130px;">
			   <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</td>
               <td class="textLeft">
                  <strong>
				  <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={DATOSPROVEEDOR/EMP_ID}&amp;VENTANA=NUEVA','Detalle Empresa',90,80,0,-50);">
				  <xsl:value-of select="DATOSPROVEEDOR/EMP_NOMBRE"/>
				  </a>
				  </strong>
                  &nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:&nbsp;<xsl:value-of select="DATOSPROVEEDOR/EMP_NIF"/>)
                   &nbsp;<a href="javascript:AbrirNuevaValoracion();"><img src="http://www.newco.dev.br/images/star{DATOSPROVEEDOR/ESTRELLAS}.gif" alt="{DATOSPROVEEDOR/ESTRELLAS}"/></a>
               </td>
              </tr>
              <tr class="sinLinea">
              <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:</td>
               <td class="textLeft">
                <p><xsl:value-of select="DATOSPROVEEDOR/EMP_DIRECCION"/></p>
    			<p><xsl:value-of select="DATOSPROVEEDOR/EMP_CPOSTAL"/><xsl:text>&nbsp;-&nbsp;</xsl:text>
                <xsl:value-of select="DATOSPROVEEDOR/EMP_POBLACION"/><xsl:text>&nbsp;(</xsl:text>
    			<xsl:value-of select="DATOSPROVEEDOR/EMP_PROVINCIA"/><xsl:text>)&nbsp;</xsl:text>
                </p>
                </td>
              </tr>
           <!--enseño vendedor solo si es muestra-->                  
              <xsl:if test="VENDEDOR != '' and $numMOF != '' and contains($numMOF,'Muestras')">
               <tr class="sinLinea"> 
                <td class="labelRight">
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='comercial']/node()"/>:
                </td>
                <td class="textLeft">
                  <xsl:value-of select="VENDEDOR"/>
                </td>
              </tr>
              </xsl:if>
         </tbody>

      </table>
</xsl:template>
<!--fin de proveedor-->


<!--datos del pedido-->
<xsl:template name="datosPedido">
	<xsl:param name="numMOF" />
    
       <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
	<!--<table class="mediaTabla" cellspacing="0" cellpadding="0">-->
	<!--<table cellspacing="0" cellpadding="0">-->
	<table class="buscador">
    <tbody>
    <input type="hidden" name="NUMERO_OFERT_PED" size="10" maxlength="100" value="{PED_NUMERO}"/>
    <!--quitado 24-02-15 ponemos fecha de entrega real
    <tr> 
      <td class="label cinquenta">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='numero']/node()"/>:
      </td>
      <td>
          <span class="textAzul"><xsl:value-of select="PED_NUMERO"/></span>&nbsp;
      </td>
      </tr>-->
	<tr class="sinLinea">
		<td class="labelRight" style="width:120px;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:      
		</td>
		<td class="textLeft"><xsl:value-of select="PED_FECHA"/>&nbsp;(<xsl:value-of select="COMPRADOR"/>)</td>
	</tr>
    <xsl:if test="PED_FECHAACEPTACION != ''">
    <tr class="sinLinea">
      	<td class="labelRight">
	  		<xsl:value-of select="document($doc)/translation/texts/item[@name='Aceptacion']/node()"/>:
		</td>
   		<td class="textLeft"><xsl:value-of select="PED_FECHAACEPTACION"/>&nbsp;(<xsl:value-of select="VENDEDOR"/>)</td>
    </tr>
    </xsl:if>
    <tr class="sinLinea">
      <xsl:choose>
      <xsl:when test="LP_FECHAENTREGA != ''">
		<xsl:if test="/Multioferta/MULTIOFERTA/OCULTAR_FECHA_ENTREGA='N'">
       		<td class="textRight">
       			<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>:</strong>
      		</td>
		</xsl:if>
      <td class="textLeft">
        <xsl:choose>
	        <xsl:when test="MO_URGENCIA='S' and not(contains($numMOF,'RO'))">
            	<span class="urgente"><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente_maiu']/node()"/></span>
            </xsl:when>
            <!--si es proveedor y pedido RO no ve fecha entrega, ve urgente-->
            <xsl:when test="MO_URGENCIA='S' and /Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA = /Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID">
            	<span class="urgente"><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente_maiu']/node()"/></span>
            </xsl:when>
			<xsl:otherwise>
				<xsl:if test="/Multioferta/MULTIOFERTA/OCULTAR_FECHA_ENTREGA='N' or MO_URGENCIA='S'">
            		<p><xsl:value-of select="LP_FECHAENTREGA"/>
                	<xsl:if test="MO_URGENCIA='S'">&nbsp;
                		<span style="color:#FF0000; font-weight:bold; border:1px solid red; padding:3px 2px; background:#FFFF99;"><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente_maiu']/node()"/></span>
                	</xsl:if>
                	</p>
				</xsl:if>
            </xsl:otherwise>
		</xsl:choose>
        <input type="hidden" name="FECHANO_ENTREGA" size="12" maxlength="10" value="{LP_FECHAENTREGA}" onFocus="this.blur();" class="inputOcultoPar"/>
      </td>
     </xsl:when>
     <xsl:otherwise>
     </xsl:otherwise>
     </xsl:choose>
     </tr>
    <xsl:choose> 
          <xsl:when test="MO_STATUS&gt;10 and (PED_IDPADRE!='' or PED_IDHIJO!='')">
          <tr class="sinLinea">
            <td>&nbsp;</td>
            <td class="textLeft">
                <xsl:choose>
                  <xsl:when test="PED_IDPADRE!=''"> 
                    <a>
                    <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="PED_IDPADRE"/>','Pedido');</xsl:attribute>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_pedido']/node()"/>
                    </a>
                  </xsl:when>
                 <xsl:when test="PED_IDHIJO!=''">
                    <a>
                    <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="PED_IDHIJO"/>','Abono');</xsl:attribute>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_abono_o_backorder']/node()"/>
                    </a>
                  </xsl:when>
                </xsl:choose>
            </td>
          </tr>
          </xsl:when>
         </xsl:choose>
    
      <xsl:choose>
        <xsl:when test="contains($numMOF,'13_RW') or contains($numMOF,'25_RW') or contains($numMOF,'35_RW')">
            <!--fecha de entrega real modificable -->
            <tr class="sinLinea"> 
            <td class="labelRight">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='entrega_real']/node()"/>:
            </td>
            <td class="textLeft">
                <input type="text" name="FECHA_ENTREGA_REAL" class="medio" size="12" maxlength="10" onBlur="AvisarFechaRecepcion=0;">
                    <xsl:attribute name="value">
                        <xsl:choose>
                            <xsl:when test="PED_FECHAENTREGAREAL != ''"><xsl:value-of select="PED_FECHAENTREGAREAL" /></xsl:when>
                            <xsl:otherwise><xsl:value-of select="FECHA_ACTUAL" /></xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </input>  
                <input type="hidden" name="COMBO_ENTREGA_REAL">
                     <xsl:attribute name="value">
                        <xsl:choose>
                            <xsl:when test="PED_FECHAENTREGAREAL != ''"><xsl:value-of select="PED_FECHAENTREGAREAL" /></xsl:when>
                            <xsl:otherwise><xsl:value-of select="FECHA_ACTUAL" /></xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </input>
            </td>
            </tr>
        </xsl:when>
        <!--si estado 15-16-17 pedido recibido, 35-36-37 muestras recibidas-->
        <xsl:when test="PED_FECHAENTREGAREAL != '' and MO_URGENCIA != 'S' and (contains($numMOF,'15') or contains($numMOF,'16') or contains($numMOF,'17') or contains($numMOF,'34') or contains($numMOF,'36') or contains($numMOF,'37') )">
            <!--fecha de entrega real en pedidos finalizados -->
          <tr class="sinLinea">
          <td class="labelRight">
           	  <xsl:value-of select="document($doc)/translation/texts/item[@name='entrega_real']/node()"/>:
          </td>
          <td class="textLeft">    
             <span class="textAzul"><xsl:value-of select="PED_FECHAENTREGAREAL"/></span>
             
             <input type="hidden" name="COMBO_ENTREGA_REAL" value="{PED_FECHAENTREGAREAL}"/>
             <input type="hidden" name="FECHA_ENTREGA_REAL" value="{PED_FECHAENTREGAREAL}"/>
          </td>
          </tr>
        </xsl:when>
        </xsl:choose>
        
    </tbody>
     
	</table> 
</xsl:template>
<!--fin de datosPedido-->



<!--datos del pedido-->
<xsl:template name="datosPedido_MOF_11">
	<xsl:param name="numMOF" />
       <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
     
      
	<!--<table class="mediaTabla" cellspacing="0" cellpadding="0" border="0">-->
	<table class="buscador">
    <tbody>
    <!--<tr> 
      <td class="label cinquenta">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='numero']/node()"/>:
      </td>
      <td>
          <span class="textAzul"><xsl:value-of select="PED_NUMERO"/></span>&nbsp;
      </td>
      </tr>  -->
		<tr class="sinLinea"> 
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="PED_FECHA"/>     
			</td>
		</tr>  
		<xsl:if test="/Multioferta/MULTIOFERTA/OCULTAR_FECHA_ENTREGA='N'">
		<tr class="sinLinea">
			<td class="textRight">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>:&nbsp;</strong>
			</td>
			<td class="textLeft">
				<strong>
				<xsl:choose>
				<xsl:when test="MO_URGENCIA='S'"><span class="urgente"><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente_maiu']/node()"/></span></xsl:when>
				<xsl:otherwise><span class="gris14"><xsl:value-of select="LP_FECHAENTREGA"/></span></xsl:otherwise>
				</xsl:choose>
				</strong>
				<input type="hidden" name="FECHANO_ENTREGA" size="12" maxlength="10" value="{LP_FECHAENTREGA}" onFocus="this.blur();" class="inputOcultoPar"/>
			</td>
		</tr>
		</xsl:if>
    </tbody>
	</table> 
</xsl:template>
<!--fin de datosPedido-->

<!--datos del pedido-->
<xsl:template name="datosPedido_Prog">
	<xsl:param name="numMOF" />
    
       <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
    
      
	<!--  <table class="mediaTabla" cellspacing="0" cellpadding="0">-->
      
	<table cellspacing="0" cellpadding="0">
    <tbody>
    <tr> 
      <td class="label cinquenta">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='numero']/node()"/>
      </td>
      <td>
      <xsl:choose>
          <xsl:when test="contains($numMOF,'28') or contains($numMOF,'30_RO')">
          	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
          </xsl:when>
          <xsl:when test="contains($numMOF,'29')"><span class="textAzul"><xsl:value-of select="MO_NUMERO_PROVISIONAL"/></span></xsl:when>
          <xsl:when test="contains($numMOF,'30')">
          		<input type="text" name="NUMERO_OFERT_PED" size="15" maxlength="100"/>
          </xsl:when>
      </xsl:choose>
      </td>
      </tr>  
  	 <tr> 
      <td class="label cinquenta">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:</td>
      <td>
      <xsl:choose>
        <xsl:when test="contains($numMOF,'30')"><xsl:value-of select="MO_FECHA"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/></xsl:otherwise>
      </xsl:choose>
      </td>
      </tr>  
   
      	<input type="hidden" name="FECHANO_ENTREGA" size="12" maxlength="10" value="{LP_FECHAENTREGA}" onFocus="this.blur();" class="inputOcultoPar"/>
      <input type="hidden" name="COMBO_ENTREGA_REAL" value="{FECHA_ACTUAL}"/>
      <input type="hidden" name="FECHA_ENTREGA_REAL" value="{FECHA_ACTUAL}"/>
      <xsl:if test="PEDIDO_MINIMO_ACTIVO!='N'">
            <tr>
              <td class="label cinquenta">
                  <b><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:&nbsp;</b>
              </td>
              <td>
                  <xsl:choose>
                    <xsl:when test="PEDIDO_MINIMO_ACTIVO='S'"><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></xsl:when>
                    <xsl:when test="PEDIDO_MINIMO_ACTIVO='E' or PEDIDO_MINIMO_ACTIVO='I'"><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></xsl:when>
                  </xsl:choose>
              </td>
            </tr>
            <tr>
               <td class="label cinquenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='importe_minimo']/node()"/>:
               </td>
               <td>
			   		<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/PREFIJO"/><xsl:value-of select="PEDIDO_MINIMO_IMPORTE"/><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>&nbsp;
              </td>
            </tr>
            <xsl:if test="PEDIDO_MINIMO_DETALLE!=''">
              <tr>
                 <td class="label cinquenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:</td>
                 <td><xsl:copy-of select="PEDIDO_MINIMO_DETALLE_HTML"/></td>
               </tr>
            </xsl:if>
        </xsl:if>
        <input type="hidden" name="PEDIDO_MINIMO_ACTIVO" value="{PEDIDO_MINIMO_ACTIVO}"/>
        <input type="hidden" name="PEDIDO_MINIMO_IMPORTE" value="{PEDIDO_MINIMO_IMPORTE}"/>
        <input type="hidden" name="PEDIDO_MINIMO_IMPORTE_SINFORMATO" value="{PEDIDO_MINIMO_IMPORTE_SINFORMATO}"/>
      
    </tbody>
	</table> 
</xsl:template>
<!--fin de datosPedido MOF 28,29-RO pedido programmado-->

<!--datos del pedido-->
<xsl:template name="datosAbono">
	<xsl:param name="numMOF" />
    
       <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
    
	<!--  <table class="mediaTabla" cellspacing="0" cellpadding="0">-->
	<table cellspacing="0" cellpadding="0">
    <tbody>
    <tr> 
      <td class="label">&nbsp;</td>
      <td align="center;">  
         <!--<span class="textAzul"><xsl:value-of select="PED_NUMERO"/></span>-->
         <input type="hidden" name="NUMERO_OFERT_PED" size="10" maxlength="100" value="{PED_NUMERO}"/>
         <xsl:choose> 
          <xsl:when test="MO_STATUS&gt;10 and (PED_IDPADRE!='' or PED_IDHIJO!='')">
                    <xsl:choose>
                      <xsl:when test="PED_IDPADRE!=''"> 
                      	<a>
                        <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="PED_IDPADRE"/>','Pedido');</xsl:attribute>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_pedido']/node()"/>
                        </a>
                      </xsl:when>
                     <xsl:when test="PED_IDHIJO!=''">
                     	<a>
                        <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="PED_IDHIJO"/>','Abono');</xsl:attribute>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_abono_o_backorder']/node()"/>
                        </a>
                      </xsl:when>
                    </xsl:choose>
          
          </xsl:when>
          <xsl:otherwise>&nbsp; </xsl:otherwise>
         </xsl:choose>
       </td>
       <td align="left;">&nbsp;</td>
    
    </tr>  
  	<tr>
      <td class="label">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;
      </td>
      <td>
       <xsl:value-of select="PED_FECHA"/>&nbsp;(<xsl:value-of select="COMPRADOR"/>)
     </td>
      <td>&nbsp;</td>
     </tr>
     <tr>
     <td class="label">
     	 <xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>:&nbsp;
      </td>
      <td>
        <xsl:choose>
	        <xsl:when test="MO_URGENCIA='S' and not(contains($numMOF,'RO'))"><span class="rojo14">URGENTE</span></xsl:when>
			<xsl:otherwise><span class="gris14"><xsl:value-of select="LP_FECHAENTREGA"/></span></xsl:otherwise>
		</xsl:choose>
       	<input type="hidden" name="FECHANO_ENTREGA" size="12" maxlength="10" value="{LP_FECHAENTREGA}" onFocus="this.blur();" class="inputOcultoPar"/>
      
      </td>
      <td>&nbsp;</td>
      </tr>
    </tbody>
	</table> 
</xsl:template>
<!--fin de datosAbono-->

<!--datos de la muestra-->
<xsl:template name="datosMuestra">
	<xsl:param name="numMOF" />
  
    
      <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
    
	<!--  <table class="mediaTabla" cellspacing="0" cellpadding="0">-->
	<table cellspacing="0" cellpadding="0">
    <tbody>
    <tr> 
      <!--<td class="label cinquenta">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='numero']/node()"/>:
      </td>
      <td>
         <span class="textAzul"><xsl:value-of select="PED_NUMERO"/></span>&nbsp;
      </td>-->
      
       <input type="hidden" name="NUMERO_OFERT_PED" size="10" maxlength="100" value="{PED_NUMERO}"/>
      
       <td colspan="2">
       	 <xsl:if test="MO_STATUS&gt;10">
            <xsl:choose>
              <xsl:when test="PED_IDPADRE!=''">
                <a>
                    <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="PED_IDPADRE"/>','MultiofertaAlt');</xsl:attribute>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_pedido']/node()"/>
                </a>
              </xsl:when>
             <xsl:when test="PED_IDHIJO!=''">
                <a>
                    <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="PED_IDHIJO"/>','MultiofertaAlt');</xsl:attribute>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_abono_o_backorder']/node()"/>
                </a>
              </xsl:when>
            </xsl:choose>
          </xsl:if>
       </td>
      </tr>
      <tr>
      <td class="label">
      		<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud']/node()"/>:
        <xsl:if test="PED_FECHAACEPTACION != ''">
        	<br /><br />
            <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptacion']/node()"/>:
        </xsl:if>
      </td>
      <td>
       <xsl:value-of select="PED_FECHA"/>
       <xsl:if test="PED_FECHAACEPTACION != ''">
       		<br /><br />
       		<strong><xsl:value-of select="PED_FECHAACEPTACION"/></strong>
       </xsl:if>
     </td>
     <xsl:choose>
      <xsl:when test="contains($numMOF,'RO') or contains($numMOF,'36_RW_Muestras') or contains($numMOF,'33_RW_Muestras') or contains($numMOF,'32_RW_Muestras')">
      <td class="label">&nbsp;</td>
      <td>&nbsp;</td>
     </xsl:when>
     <xsl:otherwise>
     <input type="hidden" name="FECHA_ENTREGA_REAL" value="{FECHA_ACTUAL}"/>
        <!--<td class="label">
        		 <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_de_recepcion']/node()"/>:
        </td>
      <td>
        <xsl:call-template name="COMBO_ENTREGA_REAL"/>
        <xsl:text>&nbsp;</xsl:text>
        
        <script type="text/javascript">
          calFechaEntregaReal.dateFormat="d/M/yyyy";
          calFechaEntregaReal.minDate=new Date(formatoFecha(calculaFechaCalendarios(-100),'E','I'));
          calFechaEntregaReal.maxDate=new Date(formatoFecha(calculaFechaCalendarios(0),'E','I'));
          calFechaEntregaReal.writeControl();
        </script>
       <xsl:text>&nbsp;</xsl:text>
        (dd/mm/aaaa)  
      </td>-->
      </xsl:otherwise>
      </xsl:choose>
      </tr>
      <tr>  
      <xsl:choose>
      <xsl:when test="LP_FECHAENTREGA != ''">
      <td class="label">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>:
      </td>
      <td>
        <xsl:choose>
	        <xsl:when test="MO_URGENCIA='S' and not(contains($numMOF,'RO'))"><span class="rojo14"><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente_maiu']/node()"/></span></xsl:when>
			<xsl:otherwise><span class="gris14"><xsl:value-of select="LP_FECHAENTREGA"/></span></xsl:otherwise>
		</xsl:choose>
        <input type="hidden" name="FECHANO_ENTREGA" size="12" maxlength="10" value="{LP_FECHAENTREGA}" onFocus="this.blur();" class="inputOcultoPar"/>
      </td>
      </xsl:when>
      <xsl:otherwise>
      	<td colspan="2">  <input type="hidden" name="FECHANO_ENTREGA" size="12" maxlength="10" value="{LP_FECHAENTREGA}" onFocus="this.blur();" class="inputOcultoPar"/></td>
      </xsl:otherwise>
      </xsl:choose>
         <td colspan="2">&nbsp;</td>
      </tr>
      <xsl:choose>
        <xsl:when test="contains($numMOF,'35_RW')">
            <!--fecha de entrega real modificable -->
            <tr> 
            <td class="label">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='entrega_real']/node()"/>:
            </td>
            <td>
                <input type="text" name="FECHA_ENTREGA_REAL" class="medio" size="12" maxlength="10" onBlur="AvisarFechaRecepcion=0;">
                    <xsl:attribute name="value">
                        <xsl:choose>
                            <xsl:when test="PED_FECHAENTREGAREAL != ''"><xsl:value-of select="PED_FECHAENTREGAREAL" /></xsl:when>
                            <xsl:otherwise><xsl:value-of select="FECHA_ACTUAL" /></xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </input>  
              <input type="hidden" name="COMBO_ENTREGA_REAL">
                  <xsl:attribute name="value">
                        <xsl:choose>
                            <xsl:when test="PED_FECHAENTREGAREAL != ''"><xsl:value-of select="PED_FECHAENTREGAREAL" /></xsl:when>
                            <xsl:otherwise><xsl:value-of select="FECHA_ACTUAL" /></xsl:otherwise>
                        </xsl:choose>
                  </xsl:attribute>
              </input>
            </td>
            </tr>
        </xsl:when>
        <!--si estado 34-36-37 muestras recibidas-->
        <xsl:when test="PED_FECHAENTREGAREAL != '' and MO_URGENCIA != 'S' and (contains($numMOF,'34') or contains($numMOF,'36') or contains($numMOF,'37') )">
            <!--fecha de entrega real en pedidos finalizados -->
          <tr>
          <td class="label">
           	  <xsl:value-of select="document($doc)/translation/texts/item[@name='entrega_real']/node()"/>:
          </td>
          <td>    
             <span class="textAzul"><xsl:value-of select="PED_FECHAENTREGAREAL"/></span>
             
             <input type="hidden" name="COMBO_ENTREGA_REAL" value="{PED_FECHAENTREGAREAL}"/>
             <input type="hidden" name="FECHA_ENTREGA_REAL" value="{PED_FECHAENTREGAREAL}"/>
          </td>
          </tr>
        </xsl:when>
        </xsl:choose>
      <xsl:if test="PED_FECHAENTREGAREAL != '' and not(contains($numMOF,'35'))">
      <tr>  
         <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega_real']/node()"/>:</td>
         <td><span class="gris14"> <xsl:value-of select="PED_FECHAENTREGAREAL"/></span></td>
         <td colspan="2">&nbsp;</td>
      </tr>
      </xsl:if>
    </tbody>
	</table> 
   
</xsl:template>
<!--fin de datosMuestra-->

<!-- COMENTARIOS - NEGOCIACION -->  
<xsl:template name="NEGOCIACION">    
 	<xsl:param name="numMOF" />  
    <xsl:param name="insertCome" />  
    
     <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
        
    <xsl:choose>
    <xsl:when test="contains($numMOF,'MOF') ">  
    <!-- ZONA DE COMENTARIOS - Para Estados que no sean un rechazo -->  
  
    <!--<table class="mediaTabla" cellpadding="0" cellspacing="0">-->
    <table cellpadding="0" cellspacing="0">
        <tfoot> 
             <!--observaciones pedidos-->
            <xsl:if test="/Multioferta/MULTIOFERTA/MO_OBSERVACIONES != '' or /Multioferta/MULTIOFERTA/MO_COMENTARIOS != ''">
                <tr>
                <td class="uno">&nbsp;</td>
                <td colspan="3" class="ochenta datosLeft"> 
                    <p style="margin:5px 0px;"><span style="color:#000;margin-top:5px;font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedidos']/node()"/>:</span></p>
                    <p style="font-weight:normal; color:#000; border:1px solid #666; padding:2px;"><xsl:copy-of select="/Multioferta/MULTIOFERTA/MO_OBSERVACIONES"/><xsl:copy-of select="/Multioferta/MULTIOFERTA/MO_COMENTARIOS"/></p>
                </td>
                </tr>    
                <tr><td colspan="4">&nbsp;</td></tr>                
            </xsl:if>
    <!--SI HAY COMENTARIOS
         	<xsl:choose>
            <!- -si son algunos estados de ya entregado inutil enseñar comentario- ->
          	<xsl:when test="contains($numMOF,'36') or contains($numMOF,'37')"></xsl:when>
            <xsl:otherwise>
            <tr>
              <td class="uno">&nbsp;</td>
              <td colspan="3" class="ochenta datosLeft"> 
              <xsl:for-each select="NEGOCIACION/NEGOCIACION_ROW">
              <!- -	<xsl:value-of select="CENTRO"/> - <xsl:value-of select="../../CLIENTE"/>
                <xsl:value-of select="CENTRO"/> - <xsl:value-of select="../../CENTRO/CEN_NOMBRE"/>- ->
                  
                  <xsl:if test="(CENTRO = ../../CLIENTE or CENTRO = ../../CENTRO/CEN_NOMBRE or IDEMPRESA = ../../DATOSCLIENTE/EMP_ID) and NMU_COMENTARIOS != ''">
                      <p style="margin:5px 0px;"><img src="http://www.newco.dev.br/images/urgente.gif" />&nbsp;<span style="text-decoration:underline; color:#000;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_cliente_maiu']/node()"/>:</span></p>
                        <p style="font-weight:normal; color:#000;"><xsl:copy-of select="NMU_COMENTARIOS"/></p>
                  </xsl:if>
              </xsl:for-each>
              </td>
            </tr>
          	</xsl:otherwise>
            </xsl:choose>-->
       
         <input type="hidden" name="NMU_COMENTARIOS" value=""/>

			<!--	21jun18	Datos del paciente (opcional)	-->
			<xsl:if test="/Multioferta/MULTIOFERTA/MO_NIFPACIENTE != ''">
			<tr>
				<td class="uno">&nbsp;</td>
				<td colspan="3" class="datosLeft">
					<!--<span class="rojo">-->
					<strong>
    					<xsl:value-of select="document($doc)/translation/texts/item[@name='Paciente']/node()"/>:&nbsp;(<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_NIFPACIENTE"/>)&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_NOMBREPACIENTE"/>
					</strong>
					<!--</span>-->
				</td>
			</tr>
			</xsl:if>

			<xsl:if test="/Multioferta/MULTIOFERTA/DOCUMENTO_PEDIDO">
			<tr>
				<td class="uno">&nbsp;</td>
				<td colspan="3" class="datosLeft">
					<img src="http://www.newco.dev.br/images/atencion.gif" width="16px" height="16px"/>&nbsp;
					<span class="rojo">
    					<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento']/node()"/>:&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/{/Multioferta/MULTIOFERTA/DOCUMENTO_PEDIDO/URL}','DocumentoPedido',90,80,0,-50);"><xsl:value-of select="/Multioferta/MULTIOFERTA/DOCUMENTO_PEDIDO/NOMBRE"/></a>
					</span>
				</td>
			</tr>
			</xsl:if>

        
           <!--numero de albaran de salida o documento-->
          <xsl:if test="PED_ALBARAN != '' or ALBARANENVIO != ''">
          	<tr>
                <td class="uno">&nbsp;</td>
                <td class="datosLeft" colspan="4">
                    
                <xsl:if test="PED_ALBARAN != ''">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='numero_albaran_salida']/node()"/>:&nbsp;
                    <xsl:value-of select="PED_ALBARAN"/>&nbsp;&nbsp;&nbsp;
                </xsl:if>
                
                <!--documento albaran-->
                <xsl:if test="ALBARANENVIO != ''">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='albaran_salida']/node()"/>:&nbsp;
                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/{ALBARANENVIO/URL}','DocumentoPedido',90,80,0,-50);" title="{ALBARANENVIO/NOMBRE}"><img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga" /></a>
                </xsl:if>
                
                </td>
       		</tr>   
            </xsl:if>
            
            <input type="hidden" name="ALBARAN_SALIDA" value="{PED_ALBARAN}" />
			<input type="hidden" name="ALBARAN_OBLIGATORIO" value="{ALBARAN_OBLIGATORIO}"/>
       <!--fin de numero de albaran de salida--> 


			<!--	2oct18	Incluimos la hoja de gasto asociada a la multioferta, para estados posteriores al 13 o 25, ya que es cuando se legalizan los pedidos	-->
         	<xsl:choose>
          	<xsl:when test="(/Multioferta/MULTIOFERTA/DERECHOS != '13_RW') and (/Multioferta/MULTIOFERTA/DERECHOS != '25_RW')">
				<xsl:if test="/Multioferta/MULTIOFERTA/HOJADEGASTO">
				<tr>
					<td class="uno">&nbsp;</td>
					<td colspan="4" class="datosLeft">
						<img src="http://www.newco.dev.br/images/atencion.gif" width="16px" height="16px"/>&nbsp;
						<span class="rojo">
    						<xsl:value-of select="document($doc)/translation/texts/item[@name='Hoja_gasto']/node()"/>:&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/{/Multioferta/MULTIOFERTA/HOJADEGASTO/URL}','DocumentoPedido',90,80,0,-50);"><xsl:value-of select="/Multioferta/MULTIOFERTA/HOJADEGASTO/NOMBRE"/></a>
						</span>
					</td>
				</tr>
				</xsl:if>
			</xsl:when>
            <xsl:otherwise>

				<!--2oct18	subir documento hoja de gasto (para Colombia), estados 13 y 25 -->
          		<tr>
                	<td class="uno">&nbsp;</td>
                	<td class="datosLeft" colspan="5">
						<br/>
						<input type="hidden" name="CADENA_DOCUMENTOS"/>
						<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
						<input type="hidden" name="BORRAR_ANTERIORES"/>
						<!--<input type="hidden" name="ID_USUARIO" value="{SOLICITUD/IDUSUARIO}"/>
						<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{SOLICITUD/IDEMPRESAUSUARIO}"/>-->
						<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB" value="HOJADEGASTO"/>
						<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML" value="HOJADEGASTO"/>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Adjuntar_hoja_gasto']/node()"/>:&nbsp;
						<input id="inputFileDoc" name="inputFileDoc" type="file" onChange="javascript:cargaDoc();" style="width:400px">
							<xsl:attribute name="style">
         						<xsl:choose>
          						<xsl:when test="/Multioferta/MULTIOFERTA/HOJADEGASTO">width:400px;display:none;</xsl:when>
            					<xsl:otherwise>width:400px;</xsl:otherwise>
            					</xsl:choose>
							</xsl:attribute>
						</input>

         				<xsl:choose>
          				<xsl:when test="/Multioferta/MULTIOFERTA/HOJADEGASTO">
							<span id="docBox" align="center">&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/{/Multioferta/MULTIOFERTA/HOJADEGASTO/URL}','DocumentoPedido',90,80,0,-50);"><xsl:value-of select="/Multioferta/MULTIOFERTA/HOJADEGASTO/NOMBRE"/></a><a href="javascript:borrarDoc({/Multioferta/MULTIOFERTA/HOJADEGASTO/ID});"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>&nbsp;
						</xsl:when>
            			<xsl:otherwise>
							<span id="docBox" style="display:none;" align="center"></span>&nbsp;
          				</xsl:otherwise>
            			</xsl:choose>

						<span id="borraDoc" style="display:none;" align="center"></span>
						<!--frame para los documentos-->
						<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
						<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
						<div id="waitBoxDoc" align="center">&nbsp;</div>
						<input type="hidden" name="IDDOCUMENTO" id="IDDOCUMENTO" value=""/>
                	</td>
       			</tr>   
				<!--fin de hoja de gasto--> 
          	</xsl:otherwise>
            </xsl:choose>
       
        </tfoot>
      </table>
      </xsl:when>
      </xsl:choose>
  
</xsl:template>
<!--fin de comentarios-->

<!-- COMENTARIOS - NEGOCIACION -->  
<xsl:template name="NEGOCIACION_MOF_11">    
 	<xsl:param name="numMOF" />  
    
       <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
        
        <!--<table class="mediaTabla" cellspacing="0" cellpadding="0">-->
        <table cellspacing="0" cellpadding="0">
            <tfoot>
            
            <xsl:if test="/Multioferta/MULTIOFERTA/MO_OBSERVACIONES != '' or /Multioferta/MULTIOFERTA/MO_COMENTARIOS != ''">
                <tr>
                <td class="uno">&nbsp;</td>
                <td colspan="3" class="ochenta datosLeft"> 
                    <p style="margin:5px 0px;"><span style="color:#000;margin-top:5px;font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedidos']/node()"/>:</span></p>
                    <p style="font-weight:normal; color:#000; border:1px solid #666; padding:2px;"><xsl:copy-of select="/Multioferta/MULTIOFERTA/MO_OBSERVACIONES"/><xsl:copy-of select="/Multioferta/MULTIOFERTA/MO_COMENTARIOS"/></p>
                </td>
                </tr>    
                <tr><td colspan="4">&nbsp;</td></tr>                
            </xsl:if>


			<!--	21jun18	Datos del paciente (opcional)	-->
			<xsl:if test="/Multioferta/MULTIOFERTA/MO_NIFPACIENTE !=''">
			<tr>
				<td class="uno">&nbsp;</td>
				<td colspan="2">
					<!--<span class="rojo">-->
					<strong>
    					<xsl:value-of select="document($doc)/translation/texts/item[@name='Paciente']/node()"/>:&nbsp;(<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_NIFPACIENTE"/>)&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_NOMBREPACIENTE"/>
					</strong>
					<!--</span>-->
				</td>
			</tr>
			</xsl:if>


			<!--	30jun17	Incluimos el documento asociado a la multioferta	-->
			<xsl:if test="/Multioferta/MULTIOFERTA/DOCUMENTO_PEDIDO">
			<tr>
				<td class="uno">&nbsp;</td>
				<td colspan="2">
					<img src="http://www.newco.dev.br/images/atencion.gif" width="16px" height="16px"/>&nbsp;
					<span class="rojo">
    					<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento']/node()"/>:&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/{/Multioferta/MULTIOFERTA/DOCUMENTO_PEDIDO/URL}','DocumentoPedido',90,80,0,-50);"><xsl:value-of select="/Multioferta/MULTIOFERTA/DOCUMENTO_PEDIDO/NOMBRE"/></a>
					</span>
				</td>
			</tr>
			</xsl:if>

			<!--	2oct18	Incluimos la hoja de gasto asociada a la multioferta	-->
			<xsl:if test="/Multioferta/MULTIOFERTA/HOJADEGASTO">
			<tr>
				<td class="uno">&nbsp;</td>
				<td colspan="2">
					<img src="http://www.newco.dev.br/images/atencion.gif" width="16px" height="16px"/>&nbsp;
					<span class="rojo">
    					<xsl:value-of select="document($doc)/translation/texts/item[@name='Hoja_de_gasto']/node()"/>:&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/{/Multioferta/MULTIOFERTA/HOJADEGASTO/URL}','DocumentoPedido',90,80,0,-50);"><xsl:value-of select="/Multioferta/MULTIOFERTA/HOJADEGASTO/NOMBRE"/></a>
					</span>
				</td>
			</tr>
			</xsl:if>



           <!--SI HAY COMENTARIOS-->
           <!--comentarios del cliente-->
            <tr>
              <td class="uno">&nbsp;</td>
              <td colspan="2" class="ochenta datosLeft">
              <!--si es pedido programado-->
              <xsl:if test="/Multioferta/MULTIOFERTA/MO_IDPEDIDOPROGRAMADO!=''">
              	 <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_programado_respetar_fecha']/node()"/></strong><br />
              </xsl:if>

                  <xsl:for-each select="NEGOCIACION/NEGOCIACION_ROW">
                  <xsl:if test="(CENTRO = ../../CLIENTE or CENTRO = ../../CENTRO/CEN_NOMBRE or IDEMPRESA = ../../DATOSCLIENTE/EMP_ID) and NMU_COMENTARIOS != ''">
                        <p style="margin:5px; 0px"><img src="http://www.newco.dev.br/images/urgente.gif" style="vertical-align:middle;" />&nbsp;<span style="text-decoration:underline; color:#000; font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_cliente_maiu']/node()"/>:</span></p>
                        <p style="font-weight:normal; color:#000;"><xsl:copy-of select="NMU_COMENTARIOS"/></p>
                  </xsl:if>
                  </xsl:for-each> 
              </td>
            </tr> 
            <input type="hidden" name="ALBARAN_SALIDA" size="20" maxlength="100" value="{PED_ALBARAN}" />
         <xsl:choose>
          <xsl:when test="NEGOCIACION/TOTAL = '0' and contains($numMOF,'RO') and PED_ALBARAN != ''">
           
            <tr>
            	<td class="uno">&nbsp;</td>
                <td class="labelRight ochenta">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='numero_albaran_salida']/node()"/>:</td>
                <td class="datosleft">
               		<xsl:value-of select="PED_ALBARAN"/>
                </td>
		    </tr>
            
          </xsl:when> 
         
		<!--si no es RO y no es urgente-->    
    	<xsl:when test="not(contains($numMOF,'RO'))">  
       
      <!--25/04/12 input hidden, quitamos posibilidad de poner comentarios, NMU_COMENTARIOS normalmente se informa con la funcion comentariosToForm1, dado que quitamos añadimos NMU_COMENTARIOS hidden <input type="hidden" name="NMU_COMENTARIOS" />-->
        <input type="hidden" name="NMU_COMENTARIOS_PEDIDO" />
        
      
     	<input type="hidden" name="DISPONEDESTOCK" value="S" />
		
		<tr>
         <td class="uno">&nbsp;</td>
		<td colspan="2">
        	<img src="http://www.newco.dev.br/images/atencion.gif" width="16px" height="16px"/>&nbsp;
			<span class="rojo">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='al_aceptar_el_pedido_el_proveedor']/node()"/>
            </span>
		</td>
		</tr>
	  	<xsl:choose>
 	    	<xsl:when test="SOLICITAR_CONFIRMACION">
 	    	 	<tr>
                 <td class="uno">&nbsp;</td>
				 <td colspan="2">
 	            	<input type="checkbox" class="muypeq" name="SOLICITAR_CONFIRMACION"/>
 	                <xsl:value-of select="document($doc)/translation/texts/item[@name='confirmo_la_lectura_y_confirmo']/node()"/>.
 	        	</td>
 	    	  	</tr>
 	    	</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="SOLICITAR_CONFIRMACION" value="" />
			</xsl:otherwise>
	  	</xsl:choose>
       
  </xsl:when><!--fin if si no es RO-->
  </xsl:choose>
   </tfoot>
      </table>
</xsl:template>
<!--fin de comentarios-->

<!--PRODUCTOS TABLA GRANDE-->
<xsl:template name="templateProductos">
	<xsl:param name="numMOF" />
       
    <xsl:variable name="cantRecibida">
        <xsl:choose>
        <xsl:when test="contains($numMOF,'13_RW') or contains($numMOF,'25_RW')">si</xsl:when>
        <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="insertCome">
        <xsl:choose>
        <xsl:when test="contains($numMOF,'14_RW') or contains($numMOF,'40_RW')">si</xsl:when>
        <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
       <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
	<div class="divLeft marginTop20">
	<!--<table class="grandeInicio" cellspacing="0" cellpadding="0" border="1">-->
	<br/>
	<br/>
	<xsl:if test="/Multioferta/MULTIOFERTA/MO_PROV_PEDIDOMINIMO and /Multioferta/MULTIOFERTA/MO_PROV_PEDIDOMINIMO!=''">
			<span style="color:#000;font-family:Verdana;font-weight:bold;margin-left:10px;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_de']/node()"/>&nbsp;
				<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/PREFIJO"/><xsl:value-of select="/Multioferta/MULTIOFERTA/MO_PROV_PEDIDOMINIMO"/><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>
			</span>
	</xsl:if>
	<table class="buscador">
    	<xsl:element name="input"> 
    	  <xsl:attribute name="name">IDDIVISA</xsl:attribute>
    	  <xsl:attribute name="type">hidden</xsl:attribute>
    	  <xsl:attribute name="value"><xsl:value-of select="//@current"/></xsl:attribute>
    	</xsl:element>
    	<thead>
    	<!--<tr class="titulos">-->
    	<tr class="subTituloTabla">
    	<!--si es pedido de farmacia una columna más para texto de añadir a pedido-->
    	<th>
    	<xsl:attribute name="class">
        	<xsl:choose>
        	<xsl:when test="/Multioferta/MULTIOFERTA/PRODUCTOSMANUALES">ocho</xsl:when>
        	<xsl:otherwise>uno</xsl:otherwise>
        	</xsl:choose>
    	 </xsl:attribute>
    	 &nbsp;</th>
    	 <!-- ref mvm + cod nacional si es farmacia -->
    	 <th class="ocho" align="center">  
			<xsl:choose>
    			<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F' and /Multioferta/MULTIOFERTA/UTILIZAR_REFERENCIA_PROVEEDOR">
        			 <xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
    			</xsl:when>
    			<!--<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N'">-->
    			<xsl:otherwise>
        			<!--<xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente_2line']/node()"/>-->
					<xsl:choose>
					<xsl:when test="/Multioferta/MULTIOFERTA/NOMBREREFCLIENTE">
						<xsl:value-of select="/Multioferta/MULTIOFERTA/NOMBREREFCLIENTE"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente_2line']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
    			</xsl:otherwise>
			</xsl:choose>   
    	  </th>
    	  <!--nombre-->
    	  <th align="left">     
      		<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
    	  </th>
    	  <!-- ref provee -->   
			<xsl:if test="not(/Multioferta/MULTIOFERTA/OCULTAR_REFERENCIA_PROVEEDOR)">
    		  <th align="left"> 
				<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F' and /Multioferta/MULTIOFERTA/UTILIZAR_REFERENCIA_PROVEEDOR">catorce</xsl:when>
				<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N'">ocho</xsl:when>
				</xsl:choose>
				</xsl:attribute>

				<xsl:choose>
				<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F' and /Multioferta/MULTIOFERTA/UTILIZAR_REFERENCIA_PROVEEDOR">
    				 <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_comercial']/node()"/>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</xsl:otherwise>
				</xsl:choose> 
    		  </th>
			 </xsl:if>
    	  <!-- marca -->   
    	  <th align="left"> 
				<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
    	  </th>
		  
		  
		  
    	  <!--unidad basica-->
    	  <th class="dies" align="center">     
	    	  <xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
    	  </th> 
    	  <!--precio unidad basica-->
    	  <th class="ocho" align="center"> 
      		 <xsl:choose>
    	  <!--vieja version asisa, brasil enseño solo precio sin iva, para todos los demas tb enseño importe sin iva -->
        	<xsl:when test="(/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' or /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM !='S') and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_PRECIOSCONIVA != 'S'">
      			   <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_ud_basica_2line']/node()"/>
			</xsl:when>
        	<!--viamed nuevo veo precios con iva-->
        	 <xsl:when test="(/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' or /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM !='S') and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_PRECIOSCONIVA = 'S' and /Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID != /Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA">
      			   <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_ud_basica_c_iva_2line']/node()"/>
			</xsl:when>
        	<!--nueva version-->
        	<xsl:when test="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF ='S' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM ='S'">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_ud_basica_2line']/node()"/>
			</xsl:when>
        	<xsl:otherwise>
            	   <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_ud_basica_2line']/node()"/>
        	</xsl:otherwise>
        	</xsl:choose>
			&nbsp;(<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/PREFIJO"/><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>)&nbsp;
    	  </th>
    	  <!--cantidad solicitada-->
    	  <th class="ocho" align="center"> 
    	   <xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad_solicitada_ud_basica_3line']/node()"/>    
    	  </th>
    	   <!--cantidad recibida-->
    	  <xsl:choose>
    	  <xsl:when test="$cantRecibida = 'no'">
    		<th class="uno">&nbsp;</th>
    	  </xsl:when>
    	  <xsl:otherwise>  
    	  <th class="diez" align="center">      
      		 <xsl:value-of select="document($doc)/translation/texts/item[@name='recibida']/node()"/>&nbsp;(*)  
        	<br/>
        	  <a href="javascript:todasRecibidas(document.forms['form1'].elements['RECIBIDO_GLOBAL'])">
            	<span class="textoComentario"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/>    </span>
        	  </a>
    	  </th>
    	  </xsl:otherwise>
    	  </xsl:choose>
    	  <th class="cinco" align="center"> 

    	  <xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_basica_lote_2line']/node()"/>        
    	  </th>
    	  <!--si brasil no enseño IVA--><!--si es viamed5 no enseño iva ni subtotal 30-10-13-->
    	  <xsl:if test="/Multioferta/MULTIOFERTA/IDPAIS != '55' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_NOMBRE != 'VIAMED'">
        	  <th class="tres">     	 <!-- Tipo IVA -->
        	  <xsl:copy-of select="document($doc)/translation/texts/item[@name='tipo_iva_2line']/node()"/>    
        	  </th>
    	  </xsl:if>

    	  <xsl:choose>
    	  <!--vieja version asisa, brasil enseño solo precio sin iva, para todos los demas tb enseño importe sin iva -->
    	  <xsl:when test="(DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' or DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM !='S') and DATOSCLIENTE/EMP_PRECIOSCONIVA != 'S'">
      			<th class="ocho" align="center">   <!-- Importe -->
            	 <xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_s_iva_2line']/node()"/>        
            	 (<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/PREFIJO"/><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>)<!-- 17dic18-->
				</th>
				<!-- 17dic18
				<th class="tres" align="center">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='div']/node()"/> .   
				</th>
				-->
			</xsl:when>
        	<!--viamed nuevo veo precios con iva cliente-->
        	 <xsl:when test="(DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' or DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM !='S') and DATOSCLIENTE/EMP_PRECIOSCONIVA = 'S' and /Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID != /Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA">
      			<th class="ocho" align="center">   <!-- Importe -->
            	 <xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_c_iva_2line']/node()"/>        
            	 (<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/PREFIJO"/><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>)<!-- 17dic18-->
				</th>
				<!-- 17dic18
				<th class="tres" align="center">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='div']/node()"/> .   
				</th>
				-->
			</xsl:when>
        	 <!--viamed nuevo lado proveedor veo precios sin iva-->
        	 <xsl:when test="(DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' or DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM !='S') and DATOSCLIENTE/EMP_PRECIOSCONIVA = 'S' and /Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID = /Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA">
      			<th class="ocho" align="center">   <!-- Importe -->
            	 <xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_s_iva_2line']/node()"/>        
            	 (<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/PREFIJO"/><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>)<!-- 17dic18-->
				</th>
				<!-- 17dic18
				<th class="tres" align="center">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='div']/node()"/> .   
				</th>
				-->
			</xsl:when>
        	<!--nueva version-->
        	<xsl:when test="DATOSCLIENTE/EMP_OCULTARPRECIOREF ='S' and DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM ='S'">
				<th align="center">
            		<xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_prov_s_iva_3line']/node()"/>    
            	</th>
            	 <!--si brasil no enseño importe IVA-->
      			 <xsl:if test="/Multioferta/MULTIOFERTA/IDPAIS != '55'">
                	<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_prov_c_iva_3line']/node()"/>    
                	</th>
            	 </xsl:if>
            	<!--si es proveedor no enseño estas columnas-->
            	<xsl:choose>
            	<xsl:when test="/Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA = /Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID">
            		<th colspan="2">&nbsp;</th>
            	</xsl:when>
            	<xsl:otherwise>
                	<th align="center">
                		<xsl:copy-of select="document($doc)/translation/texts/item[@name='comision_mvm_c_iva_3line']/node()"/>    
                	</th>
                	<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='total_clinica_c_iva_3line']/node()"/>    
            	   </th>
            	</xsl:otherwise>
            	</xsl:choose>
			</xsl:when>
        	</xsl:choose>
    	</tr>
    	</thead>
    	<tbody>
    	<!-- FOR EACH PARA CADA LINEA DE PRODUCTO -->    
	 <xsl:for-each select="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW">
	  <!--idioma-->                                             
        	<xsl:variable name="lang">
         		<xsl:choose>
                	<xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                	<xsl:otherwise>spanish</xsl:otherwise>
            	</xsl:choose>  
        	</xsl:variable>
        	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    	  <!--idioma fin-->
 		<xsl:if test="contains($numMOF,'28') or contains($numMOF,'30')">
    	  <input type="hidden" name="IMPORTE{LMO_IDPRODUCTO}" value="{IMPORTESINFORMATO}"/>
    	  <input type="hidden" name="IVA{LMO_IDPRODUCTO}" value="{LMO_TIPOIVA}"/>
    	  <input type="hidden" name="PRECIO_UNITARIO{LMO_ID}" value="{LMO_PRECIO}"/>
    	  <input type="hidden" name="CANTIDAD_SINFORMATO{LMO_ID}" value="{LMO_CANTIDAD_SINFORMATO}"/>
    	</xsl:if>

	<!--enseño productos solo si la cantidad es mayor que 0LMO_CANTIDAD_SINFORMATO>0-->
	 <xsl:if test="LMO_CANTIDAD_SINFORMATO>0 or contains($numMOF, 'Abono') ">
	 <tr>
    	 <xsl:attribute name="class">
        	 <xsl:choose>
            	 <xsl:when test="LMO_ESPACK='S'">amarillo</xsl:when>
            	 <xsl:when test="LMO_CANTIDAD_SINFORMATO>0"></xsl:when>
            	 <xsl:otherwise>gris</xsl:otherwise>
        	 </xsl:choose>
    	 </xsl:attribute>
 		<!--<xsl:attribute name="class">
    		 <xsl:if test="ALTERNATIVA and ($numMOF = 'MOF_11' or $numMOF = 'MOF_11_RO' or $numMOF = 'MOF_13' or $numMOF = 'MOF_13_RO' or $numMOF = 'MOF_15' or $numMOF = 'MOF_15_RO' or $numMOF = 'MOF_25' or $numMOF = 'MOF_25_RO' or $numMOF = 'MOF_16' or $numMOF = 'MOF_16_RO' or $numMOF = 'MOF_17_RO')">fondoAlternativa</xsl:if>
    	</xsl:attribute>-->
    	<td><xsl:value-of select="LINEA"/></td><!--columna para texto añadir a pedido de productos manuales-->
  		<td>
    		<xsl:if test="ALTERNATIVA and ($numMOF = 'MOF_11_RW' or $numMOF = 'MOF_11_RO' or $numMOF = 'MOF_13_RW' or $numMOF = 'MOF_13_RO' or $numMOF = 'MOF_15_RW' or $numMOF = 'MOF_15_RO' or $numMOF = 'MOF_25_RW' or $numMOF = 'MOF_25_RO' or $numMOF = 'MOF_16_RW' or $numMOF = 'MOF_16_RO' or $numMOF = 'MOF_17_RO')"><span class="rojo"><b>[*]</b></span>&nbsp;</xsl:if>


    		<!--si es farmacia pro ref , si es normal ref priv-->
                <xsl:choose>
                    <xsl:when test="LMO_CATEGORIA = 'F' and /Multioferta/MULTIOFERTA/UTILIZAR_REFERENCIA_PROVEEDOR">
                       <xsl:choose>
                           <xsl:when test="/Multioferta/MULTIOFERTA/MVM or /Multioferta/MULTIOFERTA/CDC">
                              <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={LMO_IDPRODUCTO}','Ficha Catalogación',100,80,0,-20);">
                                  <xsl:value-of select="PRO_REFERENCIA"/>   
                              </a>
                           </xsl:when>
                           <xsl:otherwise>
                              <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={LMO_IDPRODUCTO}','Ficha Catalogación',100,80,0,-20);">
                               <xsl:value-of select="PRO_REFERENCIA"/>
                              </a>
                           </xsl:otherwise>
                       </xsl:choose>   

                    </xsl:when>
                    <!-- <xsl:when test="LMO_CATEGORIA = 'N'">-->
                    <xsl:when test="REFERENCIA_CLIENTE!=''">
                        <xsl:choose>
                           <xsl:when test="/Multioferta/MULTIOFERTA/MVM or /Multioferta/MULTIOFERTA/CDC">
                              <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={LMO_IDPRODUCTO}','Ficha Catalogación',100,80,0,-20);">
                                  <xsl:apply-templates select="REFERENCIA_CLIENTE"/>
                              </a>
                           </xsl:when>
                           <xsl:otherwise><xsl:apply-templates select="REFERENCIA_CLIENTE"/></xsl:otherwise>
                       </xsl:choose>&nbsp;   
        	    </xsl:when>
                    <xsl:otherwise>
                         <xsl:choose>
                           <xsl:when test="/Multioferta/MULTIOFERTA/MVM or /Multioferta/MULTIOFERTA/CDC">
                              <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={LMO_IDPRODUCTO}','Ficha Catalogación',100,80,0,-20);">
                                  <xsl:value-of select="REFERENCIA_PRIVADA"/>  
                              </a>
                           </xsl:when>
                           <xsl:otherwise><xsl:value-of select="REFERENCIA_PRIVADA"/></xsl:otherwise>
                       </xsl:choose>&nbsp;  

                    </xsl:otherwise>
                </xsl:choose>
    	  </td>
		 
    	  <td class="trenta" style="text-align:left;">   
        	  <xsl:choose>
            	  <xsl:when test="/Multioferta/MULTIOFERTA/MINIMALISTA"><!--usuario minimalista proveedores, ven ficha producto reducida-->
                	   <a href="javascript:verDetalleProducto('{LMO_IDPRODUCTO}');" title="Detalle producto">
                        	<xsl:if test="NOMBRE_PRIVADO!=''"><xsl:value-of select="NOMBRE_PRIVADO"/></xsl:if>
                        	<xsl:if test="NOMBRE_PRIVADO ='' and PRO_NOMBRE !=''"><xsl:value-of select="PRO_NOMBRE"/></xsl:if>
                    	  </a>&nbsp;
            	  </xsl:when>
            	  <xsl:otherwise>
                	  <!--usuarios normales-->
                	  <xsl:choose>
                    	<!--si es proveedor-->
                    	<xsl:when test="//USUARIO/IDEMPRESA = //DATOSPROVEEDOR/EMP_ID">
                        	   <xsl:value-of select="PRO_NOMBRE" />
                    	</xsl:when>
                    	<xsl:when test="NOMBRE_PRIVADO!=''">
                    	  <a href="javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={LMO_IDPRODUCTO}&amp;IDEMPRESA_COMPRADORA={/Multioferta/MULTIOFERTA/MO_IDCLIENTE}','producto',100,80,0,0)" title="Detalle producto">
                        	<xsl:value-of select="NOMBRE_PRIVADO"/>
                    	  </a>&nbsp;
                    	</xsl:when>
                    	<xsl:otherwise>
                    	  <a href="javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={LMO_IDPRODUCTO}&amp;IDEMPRESA_COMPRADORA={/Multioferta/MULTIOFERTA/MO_IDCLIENTE}','producto',100,80,0,0)" title="Detalle producto">
                        	<xsl:value-of select="PRO_NOMBRE"/>
                    	  </a>&nbsp;
                    	</xsl:otherwise>
                	  </xsl:choose>
            	  </xsl:otherwise>
        	  </xsl:choose>

    	</td> 


    	  <!--ref provee si normal, marca si farmacia
    	  <td>
      		<xsl:choose>
                <xsl:when test="LMO_CATEGORIA = 'F' and /Multioferta/MULTIOFERTA/UTILIZAR_REFERENCIA_PROVEEDOR">
                   <span style="font-size:11px;"><xsl:value-of select="PRO_MARCA"/></span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="/Multioferta/MULTIOFERTA/MINIMALISTA"><!- -usuario minimalista proveedores, ven ficha producto reducida- ->
                            <a href="javascript:verDetalleProducto('{LMO_IDPRODUCTO}');" title="Detalle producto">
                                 <xsl:apply-templates select="PRO_REFERENCIA"/>
                            </a>&nbsp;
                        </xsl:when>
                        <xsl:otherwise>
                            <a href="javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={LMO_IDPRODUCTO}&amp;IDEMPRESA_COMPRADORA={/Multioferta/MULTIOFERTA/MO_IDCLIENTE}','producto',100,80,0,0)" title="Detalle producto">
                                <xsl:apply-templates select="PRO_REFERENCIA"/>
                            </a>&nbsp;
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:if test="../../DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' and PRO_MARCA != ''">
                        <xsl:if test="$numMOF != 'MOF_11'"><br />(<xsl:value-of select="PRO_MARCA"/>)</xsl:if> 
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
    	  </td> -->    
			<xsl:if test="not(/Multioferta/MULTIOFERTA/OCULTAR_REFERENCIA_PROVEEDOR)">
    		  <td>
      			<xsl:choose>
                	<xsl:when test="LMO_CATEGORIA = 'F' and /Multioferta/MULTIOFERTA/UTILIZAR_REFERENCIA_PROVEEDOR">
                	   <span style="font-size:11px;"><xsl:value-of select="PRO_MARCA"/></span>
                	</xsl:when>
                	<xsl:otherwise>
                    	<xsl:choose>
                        	<xsl:when test="/Multioferta/MULTIOFERTA/MINIMALISTA"><!--usuario minimalista proveedores, ven ficha producto reducida-->
                            	<a href="javascript:verDetalleProducto('{LMO_IDPRODUCTO}');" title="Detalle producto">
                                	 <xsl:apply-templates select="PRO_REFERENCIA"/>
                            	</a>&nbsp;
                        	</xsl:when>
                        	<xsl:otherwise>
                            	<a href="javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={LMO_IDPRODUCTO}&amp;IDEMPRESA_COMPRADORA={/Multioferta/MULTIOFERTA/MO_IDCLIENTE}','producto',100,80,0,0)" title="Detalle producto">
                                	<xsl:apply-templates select="PRO_REFERENCIA"/>
                            	</a>&nbsp;
                        	</xsl:otherwise>
                    	</xsl:choose>
                	</xsl:otherwise>
            	</xsl:choose>
    		  </td>
		  </xsl:if>
    	  <td>
      		<xsl:value-of select="PRO_MARCA"/>
    	  </td> 
	   <td>
    	 <xsl:choose>
    	   <xsl:when test="PRO_UNIDADBASICA">
        	 <xsl:value-of select="PRO_UNIDADBASICA"/>
    	   </xsl:when>
    	 </xsl:choose>

	   </td>
	   <!-- en todos los estados mostramos "PRECIO UNITARIO", excepto que sea un pack que ya vendrá la columna en blanco	-->
	   <td class="textCenter">
   		<xsl:choose>
    	  <!--vieja version asisa, brasil enseño solo precio sin iva, para todos los demas tb enseño importe sin iva -->
    	  <xsl:when test="(/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' or /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM !='S') and DATOSCLIENTE/EMP_PRECIOSCONIVA != 'S'">
      			<input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;" value="{LMO_PRECIO}" OnFocus="this.blur();" class="noinput medio" />&nbsp;
			</xsl:when>
        	<!--viamed nuevo veo precios con iva-->
        	 <xsl:when test="(/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' or /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM !='S') and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_PRECIOSCONIVA = 'S' and /Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID != /Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA">
      			<input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;" value="{LMO_PRECIO_CONIVA}" OnFocus="this.blur();" class="noinput medio" />&nbsp;
			</xsl:when>
        	<!--nueva version-->
        	<xsl:when test="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF ='S' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM ='S'">
				<input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;" value="{LMO_PRECIO}" OnFocus="this.blur();" class="noinput medio" />&nbsp;
			</xsl:when>
        	<xsl:otherwise>
        		<input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;" value="{LMO_PRECIO}" OnFocus="this.blur();" class="noinput medio" />&nbsp;
        	</xsl:otherwise>
        	</xsl:choose>
	   </td>  
	   <td>
   			<xsl:choose>
   	    	<xsl:when test="$numMOF = 'MOF_28_RW'"><xsl:call-template name="CANTIDAD_MOF28" /></xsl:when>
        	<xsl:when test="$numMOF = 'MOF_30_RW'"><xsl:call-template name="CANTIDAD_MOF28" /></xsl:when>
			<xsl:otherwise>
    	   <input type="text" name="NuevaCantidad_{LMO_ID}" size="8" maxlength="7" style="text-align:center" value="{LMO_CANTIDAD}" OnFocus="this.blur();" class="noinput peq" />
        	</xsl:otherwise>
        	</xsl:choose>
	   </td>
	   <!--cantidad recibida-->
	   <td> 
   			<xsl:if test="$numMOF = 'MOF_25_RW'"><xsl:call-template name="CANTIDAD_ENTREGADA_MOF25" /></xsl:if>
        	<xsl:if test="$numMOF = 'MOF_25_RO'"><xsl:call-template name="CANTIDAD_ENTREGADA_MOF25_RO" /></xsl:if>
        	<xsl:if test="$numMOF = 'MOF_13_RW'"><xsl:call-template name="CANTIDAD_ENTREGADA_MOF13" /></xsl:if>
        	<xsl:if test="$cantRecibida = 'no'">&nbsp;</xsl:if>
	   </td> 
	   <td>
        	<xsl:apply-templates select="PRO_UNIDADESPORLOTE"/>&nbsp;
	   </td>
	   <!--si brasil quito IVA--><!--si es viamed5 no enseño iva ni subtotal 30-10-13-->
	   <xsl:if test="/Multioferta/MULTIOFERTA/IDPAIS != '55' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_NOMBRE != 'VIAMED'">
    	   <td>
        	   <xsl:if test="LMO_ESPACK='N'"><xsl:if test="LMO_TIPOIVA"><xsl:value-of select="LMO_TIPOIVA"/></xsl:if></xsl:if>&nbsp;
    	   </td>
	   </xsl:if>	
	   <xsl:choose>
	   <!--precio sin iva para todos, tb brasil meno viamed nuevo-->
	   <xsl:when test="((/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' or /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM !='S') and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_PRECIOSCONIVA != 'S') or /Multioferta/MULTIOFERTA/IDPAIS = '55'">
	   		<td align="center">
        		<input type="text" name="NuevoImporte_{LMO_ID}" size="11" maxlength="11" style="text-align:right;font-weight:bold;" value="{IMPORTE}" onFocus="this.blur();" class="noinput medio" />
	   		</td>
			<!--
    		<td>
				<xsl:if test="LMO_ESPACK='N'">
    	  			<input type="text" name="divisa_{LMO_ID}" size="4" value="{/Multioferta/MULTIOFERTA/DIVISA/SUFIJO}" style="text-align:center" OnFocus="this.blur();" class="noinput peq" />
				</xsl:if>
    		</td>
			-->
    	</xsl:when>
    	<!--precio con iva para viamed nuevo-->
    	<xsl:when test="(/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' or /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM !='S') and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_PRECIOSCONIVA = 'S' and /Multioferta/MULTIOFERTA/IDPAIS != '55' and /Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID != /Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA">
    		<td align="center">
        		<input type="text" name="NuevoImporte_{LMO_ID}" size="11" maxlength="11" style="text-align:right;font-weight:bold;" value="{IMPORTE_CONIVA}" onFocus="this.blur();" class="noinput medio" />
	   		</td>
    		<td>
				<!--
				<xsl:if test="LMO_ESPACK='N'">
    	  			<input type="text" name="divisa_{LMO_ID}" size="4" value="{/Multioferta/MULTIOFERTA/DIVISA/SUFIJO}" style="text-align:center" OnFocus="this.blur();" class="noinput peq" />
				</xsl:if>
				-->
    		</td>
    	</xsl:when>
    	<xsl:when test="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF='S' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM='S'">
			<td><xsl:value-of select="IMPORTE"/>
			</td>
        	<!--si brasil no enseño importe IVA-->
      		<xsl:if test="/Multioferta/MULTIOFERTA/IDPAIS != '55'">
				<td><xsl:value-of select="IMPORTE_TOTAL_PROV"/></td>
        	</xsl:if>

        	<!--si es proveedor-->
        	 <xsl:choose>
            	<xsl:when test="/Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA = /Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID">
            		<td colspan="2">&nbsp;</td>
            	</xsl:when>
            	<xsl:otherwise>
                	<td><xsl:value-of select="COMISION_MVM"/> </td>
                	<td><xsl:value-of select="IMPORTE_TOTAL_CLI"/></td>
            	</xsl:otherwise>
        	 </xsl:choose>
		</xsl:when>
    	<xsl:otherwise>
			<td align="center">
        		<input type="text" name="NuevoImporte_{LMO_ID}" size="11" maxlength="11" style="text-align:right;font-weight:bold;" value="{IMPORTE}" onFocus="this.blur();" class="noinput medio" />
			</td>
    		<td>
				<!--
				<xsl:if test="LMO_ESPACK='N'">
					<input type="text" name="divisa_{LMO_ID}" size="4" value="{/Multioferta/MULTIOFERTA/DIVISA/SUFIJO}" style="text-align:center" OnFocus="this.blur();" class="noinput peq" />
				</xsl:if>
				-->
    		</td>
    	</xsl:otherwise>
    	</xsl:choose>
	  </tr>  
	  <!--sin stock-->
	  <xsl:if test="ALTERNATIVA and ($numMOF = 'MOF_11_RW' or $numMOF = 'MOF_11_RO' or $numMOF = 'MOF_13_RW' or $numMOF = 'MOF_13_RO' or $numMOF = 'MOF_15_RW' or $numMOF = 'MOF_15_RO' or $numMOF = 'MOF_25_RW' or $numMOF = 'MOF_25_RO' or $numMOF = 'MOF_16_RW' or $numMOF = 'MOF_16_RO' or $numMOF = 'MOF_17_RO')">
	  <tr>
  		  <td>&nbsp;</td>
  		  <td style="background:#FF9;"><span class="rojo"><b>[*]</b></span><xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/></td>
    	  <td style="background:#FF9;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.&nbsp;<xsl:value-of select="ALTERNATIVA/REFERENCIA"/></td>
    	  <td style="text-align:left; background:#FF9;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Prod']/node()"/>.&nbsp;<xsl:value-of select="ALTERNATIVA/NOMBRE"/></td>
    	  <td colspan="11">&nbsp;</td>

	  </tr>
	  </xsl:if>
	  <!--sin stock-->
	 </xsl:if> 
	 </xsl:for-each>

	 <!--PRODUCTOS MANUALES-->
	 <xsl:if test="/Multioferta/MULTIOFERTA/PRODUCTOSMANUALES">
	 <xsl:for-each select="/Multioferta/MULTIOFERTA/PRODUCTOSMANUALES/PRODUCTOMANUAL">
 		  <xsl:choose>
    	  <!--si es pedido de farmacia-->
        	<xsl:when test="//Multioferta/MULTIOFERTA/LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F'">
            	<tr>
                	<td class="naranja"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_al_pedido']/node()"/></strong></td>
                	<td class="naranja"><xsl:value-of select="MOP_REFPROVEEDOR"/></td>
                	<td class="naranja">&nbsp;</td>
                	<td class="naranja textLeft"><xsl:value-of select="MOP_DESCRIPCION"/></td>

                	<td class="naranja"><xsl:value-of select="MOP_UNIDADBASICA"/></td>
                	<td class="naranja"><!--<xsl:value-of select="MOP_PRECIOUNITARIO"/>--></td>
                	<td class="naranja"><xsl:value-of select="MOP_CANTIDAD"/></td>
                	<td>&nbsp;</td>
                	<td>&nbsp;</td>
                	<td><!--<xsl:value-of select="MOP_PCTGE_IVA"/>--></td>
                	<td>&nbsp;</td>
                	<td>&nbsp;</td>
            	</tr>  
        	</xsl:when>
        	<!--si es pedido normal-->
        	<xsl:otherwise>
        		<tr>
                	<td class="naranja"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_al_pedido']/node()"/></strong></td>
                	<td class="naranja">&nbsp;</td>
                	<td class="naranja"><xsl:value-of select="MOP_REFPROVEEDOR"/></td>
                	<td class="naranja textLeft"><xsl:value-of select="MOP_DESCRIPCION"/></td>
                	<td class="naranja"><xsl:value-of select="MOP_UNIDADBASICA"/></td>
                	<td class="naranja"><!--<xsl:value-of select="MOP_PRECIOUNITARIO"/>--></td>
                	<td class="naranja"><xsl:value-of select="MOP_CANTIDAD"/></td>
                	<td>&nbsp;</td>
                	<td>&nbsp;</td>
                	<td><!--<xsl:value-of select="MOP_PCTGE_IVA"/>--></td>
                	<td>&nbsp;</td>
                	<td>&nbsp;</td>
            	</tr>  
        	</xsl:otherwise>
    	 </xsl:choose>
	 </xsl:for-each>
	 </xsl:if>
	 <!--FIN DE PRODUCTOS MANUALES-->

	 </tbody>
	  <tfoot style="background:#FFF; border-bottom:1px solid #ccc;">
	 <!--<tr class="gris">
	  <td colspan="14">
  		<xsl:if test="not(contains($numMOF, 'RO')) and not(contains($numMOF,'MOF_11')) and not(contains($numMOF,'15')) and not(contains($numMOF,'12')) and not(contains($numMOF,'Abono')) and not(contains($numMOF,'28')) and not(contains($numMOF,'30'))">
			<p><strong><img src="http://www.newco.dev.br/images/atencion.gif" width="16px" height="16px"/>
        	 <xsl:value-of select="document($doc)/translation/texts/item[@name='puede_indicar_la_cantidad_recibida']/node()"/>
    	   .</strong></p>
    	</xsl:if>
	  </td> 
	  </tr> -->
 
      <xsl:choose>
        <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW/IMPORTE[.=''] and MO_STATUS[.=6]">	  
           <tr>
  			<td colspan="11">
            <strong>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='debe_asignar_todos_los_precios']/node()"/></strong>
  			</td>
 		   </tr>
        </xsl:when>
        </xsl:choose>
    
	 </tfoot>
	 </table>

	 <br/>
	<!-- <table class="grandeInicio" border="1">-->
	 <table class="buscador">
	 <tfoot>
	 <!--totales-->
	 <!--choose si es brasil, si es brasil solo un total-->
	 <xsl:choose>
	 <xsl:when test="/Multioferta/MULTIOFERTA/IDPAIS = '55'">
 		<!--input hidden del trozo que no se enseña, por el js.-->
 		   <input type="hidden" name="MO_SUBTOTAL" size="12" maxlength="12" style="text-align:right;" value="{IMPORTE_TOTAL_FORMATO}" class="noinput" onFocus="this.blur();"/>

    	   <input type="hidden" name="divisa_subtotal" onFocus="this.blur();" value="{/Multioferta/MULTIOFERTA/DIVISA/PREFIJO/Multioferta/MULTIOFERTA/DIVISA/SUFIJO}" class="noinput" size="3" />

    	   <input type="hidden" name="MO_DESCUENTOGENERAL" size="6" maxlength="6" style="text-align:right;font-weight:bold;" value="{MO_DESCUENTOGENERAL}" onFocus="this.blur();"/>

        	<input type="hidden" name="MO_IMPORTEIVA" size="12" maxlength="12" onFocus="this.blur();" value="{MO_IMPORTEIVA_FORMATO}" class="noinput" style="text-align:right"/>
        	<!--input hidden de template IMPORTE_TOTAL_FORMATO
        	  <input type="hidden" name="MO_SUBTOTAL" size="12" maxlength="12" style="text-align:right;" value="{.}" class="noinput" onFocus="this.blur();"/>-->

    	  <tr>
	 <!-- pongo aqui la parte de comentarios y lo demas-->
 		<td class="setenta" rowspan="3">
    		<xsl:choose>
    		<xsl:when test="contains($numMOF,'MOF_11')">
        		 <xsl:call-template name="NEGOCIACION_MOF_11">      
            		<xsl:with-param name="numMOF"><xsl:value-of select="$numMOF"/></xsl:with-param>     
        		</xsl:call-template> 

    		</xsl:when>
        	<xsl:otherwise>
        		<xsl:call-template name="NEGOCIACION">        
            		<xsl:with-param name="numMOF"><xsl:value-of select="$numMOF"/></xsl:with-param>     
                	<xsl:with-param name="insertCome"><xsl:value-of select="$insertCome"/></xsl:with-param> 
        		</xsl:call-template>
        	</xsl:otherwise>
        	</xsl:choose>

    	&nbsp;</td>
    	<td colspan="3">&nbsp;</td>
    	</tr>
    	  <tr>


    	  <td class="label textRight">  
        	  <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>:</td>       
    	  <td class="textRight">
        	<input type="text" name="COSTE_LOGISTICA" size="12" maxlength="12" value="{MO_COSTELOGISTICA_FORMATO}" class="noinput" style="text-align:right"/>&nbsp;
        	</td>
		<!--    
    	  <td><strong><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>
					  </strong></td>
		-->
					
    	</tr>
	 </xsl:when>
	 <xsl:otherwise>
	 <!--España o Colombia-->
	  <xsl:choose>
        	<!--SI ES PROVEEDOR ENSEÑO SIEMPRE TOTAL SIN IVA, IVA Y TOTAL-->
        	<xsl:when test="/Multioferta/MULTIOFERTA/USUARIO/ROL = 'VENDEDOR'">
            	 <tr>
	 <!-- pongo aqui la parte de comentarios y lo demas-->
 		<td class="setenta" rowspan="3">
    		<xsl:choose>
    		<xsl:when test="contains($numMOF,'MOF_11')">
        		 <xsl:call-template name="NEGOCIACION_MOF_11">      
            		<xsl:with-param name="numMOF"><xsl:value-of select="$numMOF"/></xsl:with-param>     
        		</xsl:call-template> 

    		</xsl:when>
        	<xsl:otherwise>
        		<xsl:call-template name="NEGOCIACION">        
            		<xsl:with-param name="numMOF"><xsl:value-of select="$numMOF"/></xsl:with-param>     
                	<xsl:with-param name="insertCome"><xsl:value-of select="$insertCome"/></xsl:with-param> 
        		</xsl:call-template> 
        	</xsl:otherwise>
        	</xsl:choose>

    	&nbsp;</td>

    	  <td class="label textRight dies">
    	   <xsl:choose>
				<xsl:when test="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF='S' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM='S'">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='total_prov_s_iva']/node()"/>
				</xsl:when>
				<xsl:otherwise>
            		 <xsl:value-of select="document($doc)/translation/texts/item[@name='subtotal']/node()"/>
            	</xsl:otherwise>
				</xsl:choose>:
        	</td>     
    	  <td class="quince textRight">
      		<xsl:choose>
        	<xsl:when test="contains($numMOF,'MOF_11_RO')">
        	   <!-- <xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>
					  <!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>- ->&nbsp;
            	<xsl:value-of select="DIV_PREFIJO"/>-->
            	<input type="text" name="MO_SUBTOTAL" size="12" maxlength="12" style="text-align:right;" value="{IMPORTE_TOTAL_FORMATO}" class="noinput" onFocus="this.blur();"/>&nbsp;
        	</xsl:when>
        	<xsl:otherwise>
        		<!--<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>
					  <!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>- ->
            	<xsl:value-of select="DIV_PREFIJO"/>--><xsl:apply-templates select="IMPORTE_TOTAL_FORMATO"/>
        	</xsl:otherwise>
        	</xsl:choose>
    	  </td>
		  <!--
    	  <td class="tres">
				<td><p><strong><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>
					  </strong></p></td>
    	  </td>
		  -->

	 </tr>
    	<tr>
    	  <td class="label textRight">  
       		<xsl:choose>
				<xsl:when test="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF='S' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM='S'">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='total_iva_prov']/node()"/>
				</xsl:when>
				<xsl:otherwise>
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='importe_iva']/node()"/>
				</xsl:otherwise>
				</xsl:choose>:
    	  </td>       
    	  <td class="textRight">
        	 <!--para multioferta-frame 28-->
        	 <input type="hidden" name="MO_DESCUENTOGENERAL" size="6" maxlength="6" style="text-align:right;font-weight:bold;" value="{MO_DESCUENTOGENERAL}" onFocus="this.blur();"/>&nbsp;

        	<!--<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>
					  <!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>- -><xsl:value-of select="DIV_PREFIJO"/>--><input type="text" name="MO_IMPORTEIVA" size="12" maxlength="12" onFocus="this.blur();" value="{MO_IMPORTEIVA_FORMATO}" class="noinput" style="text-align:right"/>
        	</td>  
			<!--    
    	  <td><p><strong><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>
					 </strong></p></td>
			-->
    	</tr>
    	</xsl:when><!--FIN WHEN SI ES PROVEEDOR-->


    	<!--****************SI ES CLIENTE COMO ANTES***********************-->
    	<xsl:when test="/Multioferta/MULTIOFERTA/USUARIO/ROL = 'COMPRADOR'">
	   <tr class="sinLinea">
	 <!-- pongo aqui la parte de comentarios y lo demas-->
 		<td class="setenta" rowspan="3">
    		<xsl:choose>
    		<xsl:when test="contains($numMOF,'MOF_11')">
        		 <xsl:call-template name="NEGOCIACION_MOF_11">      
            		<xsl:with-param name="numMOF"><xsl:value-of select="$numMOF"/></xsl:with-param>     
        		</xsl:call-template> 

    		</xsl:when>
        	<xsl:otherwise>
        		<xsl:call-template name="NEGOCIACION">        
            		<xsl:with-param name="numMOF"><xsl:value-of select="$numMOF"/></xsl:with-param>     
                	<xsl:with-param name="insertCome"><xsl:value-of select="$insertCome"/></xsl:with-param> 
        		</xsl:call-template> 
        	</xsl:otherwise>
        	</xsl:choose>

    	&nbsp;</td>

    	  <td class="label textRight" style="width:250px;"><!--class="dies" -->
    	   <xsl:choose>
				<xsl:when test="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF='S' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM='S'">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='total_prov_s_iva']/node()"/>
				</xsl:when>
				<xsl:otherwise>
            		 <xsl:value-of select="document($doc)/translation/texts/item[@name='subtotal']/node()"/>&nbsp;&nbsp;&nbsp;
            	</xsl:otherwise>
				</xsl:choose>:
        	</td>     
    	  <td class="textRight"><!--class="quince" -->
      		<xsl:choose>
        	<xsl:when test="contains($numMOF,'MOF_11_RO')">
        	   <!-- <xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>
					  <!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>- ->&nbsp;
            	<xsl:value-of select="DIV_PREFIJO"/>-->
            	<input type="text" name="MO_SUBTOTAL" size="12" maxlength="12" style="text-align:right;" value="{IMPORTE_TOTAL_FORMATO}" class="noinput" onFocus="this.blur();"/>
        	</xsl:when>
        	<xsl:otherwise>
        		<!--<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>
					  <!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>- ->
            	<xsl:value-of select="DIV_PREFIJO"/>--><xsl:apply-templates select="IMPORTE_TOTAL_FORMATO"/>&nbsp;&nbsp;&nbsp;
        	</xsl:otherwise>
        	</xsl:choose>
    	  </td>
		  <!--
    	  <td style="width:70px;">
     			<p><strong><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/></strong></p>
		 </td>
		 -->
	 </tr>

    	<tr class="sinLinea">
    	  <td class="label textRight">  
       		<xsl:choose>
				<xsl:when test="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF='S' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM='S'">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='total_iva_prov']/node()"/>
				</xsl:when>
				<xsl:otherwise>
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='importe_iva']/node()"/>
				</xsl:otherwise>
				</xsl:choose>:
    	  </td>       
    	  <td class="textRight">
        	 <!--para multioferta-frame 28-->
        	 <input type="hidden" name="MO_DESCUENTOGENERAL" size="6" maxlength="6" style="text-align:right;font-weight:bold;" value="{MO_DESCUENTOGENERAL}" onFocus="this.blur();"/>
			<input type="text" name="MO_IMPORTEIVA" size="12" maxlength="12" onFocus="this.blur();" value="{MO_IMPORTEIVA_FORMATO}" class="noinput" style="text-align:right"/>&nbsp;&nbsp;&nbsp;
        	</td>
		<!--
    	  <td><p><strong><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/></strong></p></td>
		  -->
    	</tr>


        	</xsl:when><!--FIN WHEN SI ES COMPRADOR ESPAÑA-->
    	</xsl:choose>
    	<!--*************************************************************************-->
    	</xsl:otherwise><!--FIN OTHERWISE SI ES BRASIL-->
    	</xsl:choose>
    	<!--fin choose si es brasil, si es brasil solo un total-->

    	 <tr class="sinLinea">

    	  <td class="label textRight">    
    	  <xsl:choose>
				<xsl:when test="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_OCULTARPRECIOREF='S' and /Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_MOSTRARCOMISIONES_NM='S'">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='total_proveedor']/node()"/>(<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/PREFIJO"/><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>):
				</xsl:when>
				<xsl:otherwise>
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='importe_total']/node()"/>(<xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/PREFIJO"/><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/>):
				</xsl:otherwise>
				</xsl:choose></td>       
    	  <td class="textRight">
        	<input type="text" name="IMPORTE_FINAL_PEDIDO" size="12" maxlength="12" onFocus="this.blur();" value="{IMPORTE_FINAL_PEDIDO}" class="noinput" style="text-align:right"/>&nbsp;&nbsp;&nbsp;
        	</td>
			<!--
    	  <td>
		  	<p><strong><xsl:value-of select="/Multioferta/MULTIOFERTA/DIVISA/SUFIJO"/></strong></p>
			</td>
			-->
    	</tr>
		<!--	30ene17	Para las empresas que lo requieran, mostrar forma y plazo de pago
		26ago19 Movemos este bloque a la cabecera
		<xsl:if test="/Multioferta/MULTIOFERTA/CAMBIARFORMAPAGO and /Multioferta/MULTIOFERTA/FORMAPAGO!=''">
    	<tr><td colspan="2">&nbsp;</td></tr>
    	<tr class="sinLinea">
			<td colspan="2" style="textLeft">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/FORMAPAGO"/>.&nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>:&nbsp;<xsl:value-of select="/Multioferta/MULTIOFERTA/PLAZOPAGO"/>.
			</td>
		</tr>
		</xsl:if>
		-->
    	</tfoot>
	 </table> 
	 <!--si es multiframe 28 pedido programmado-->
	   <xsl:if test="/Multioferta/ESMODELO='S'">
        	<table class="infoTable">
        		<tr>     
                	<td class="labelRight cinquenta">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_todos_pedidos']/node()"/>

                	</td>
                	<td class="datosLeft"><input type="checkbox" name="CHK_TODOSPEDIDOS_TODOS"  onClick="validarChecks(this.form, this.name);" checked="checked"/>
                	</td>
            	</tr>
            	<tr>
					<td class="labelRight">
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_todos_meno_siguiente']/node()"/>
                	</td>
                	<td class="datosLeft">
          			<input type="checkbox" name="CHK_TODOSPEDIDOS_EXCEPTO"  onClick="validarChecks(this.form, this.name);"/>
          			</td>
            	</tr>
            	<tr>
          			<td class="labelRight">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_solo_el_siguiente_pedido']/node()"/>
                	</td>
                	<td class="datosLeft"><input type="checkbox" name="CHK_TODOSPEDIDOS_SIGUIENTE"  onClick="validarChecks(this.form, this.name);"/> 	
          	    	</td>
        		</tr>
        	</table>
        	<br /><br />
	   </xsl:if><!--fin de mof28-->

	</div><!--fin divLeft-->
    <br />
	<br />

</xsl:template>
<!--fin de productos-->



<!--TEMPLATE DE LA 7IMA COLUMNA DE LA TABLA GRANDE--> 
<xsl:template name="CANTIDAD_ENTREGADA_MOF25_RO">
 
      <input type="text" name="CantidadEntregada_{LMO_ID}" size="3" maxlength="7" class="noInput peq" value="{LPE_CANTIDADENTREGADA_CONFORMATO}" onFocus="this.blur();">
            </input>
            <xsl:choose>
            <xsl:when test="LPE_ENTREGADA='S'">
              <img src="http://www.newco.dev.br/images/recibido.gif" width="16px" height="16px"/>
            </xsl:when>
            <xsl:otherwise>
              <img src="http://www.newco.dev.br/images/norecibido.gif" width="16px" height="16px"/>
            </xsl:otherwise>
          </xsl:choose>
</xsl:template>

<xsl:template name="CANTIDAD_ENTREGADA_MOF25">
    <input type="hidden" name="IDLINEAPEDIDO_{LMO_ID}"  value="{LMO}"/>
    <input type="hidden" name="CANTIDADSINFORMATO_{LMO_ID}"  value="{LMO_CANTIDAD_SINFORMATO}"/>
    <input type="hidden" name="LPE_CANTIDADENTREGADA_{LMO_ID}"  value="{LPE_CANTIDADENTREGADA}"/>

    <xsl:choose>
      <xsl:when test="LMO_ESPACK='S'">
        <input type="hidden" name="CantidadEntregada_{LMO_ID}" value="{LMO_CANTIDAD_SINFORMATO}"/>
      </xsl:when>
      <xsl:when test="LPE_ENTREGADA='S'">
        <input type="text" class="peq" name="CantidadEntregada_{LMO_ID}" size="6" style="text-align:right" maxlength="7"  value="{LMO_CANTIDAD_SINFORMATO}" OnBlur="UnidadesALotesRecibidasImagen(this.value,'{PRO_UNIDADESPORLOTE}','{LMO_CANTIDAD_SINFORMATO}',this);"  onFocus="this.select();AvisarCantidadesIntactas=0;"/>
      </xsl:when>
      <xsl:otherwise>
        <input type="text" class="peq" name="CantidadEntregada_{LMO_ID}" size="6" style="text-align:right" maxlength="7"  value="{LPE_CANTIDADENTREGADA}" OnBlur="UnidadesALotesRecibidasImagen(this.value,'{PRO_UNIDADESPORLOTE}','{LMO_CANTIDAD_SINFORMATO}',this);" onFocus="this.select();AvisarCantidadesIntactas=0;" />
      </xsl:otherwise>
    </xsl:choose> 
    <xsl:text>&nbsp;</xsl:text>
	<xsl:if test="LMO_ESPACK!='S'">
    <a href="javascript:cambioRecibido({LMO_ID});">
		<img width="16px" height="16px" name="IMGRECIBIDO_{LMO_ID}" id="IMGRECIBIDO_{LMO_ID}">
			<xsl:choose><xsl:when test="LPE_ENTREGADA='S'"><xsl:attribute name="src">http://www.newco.dev.br/images/recibido.gif</xsl:attribute></xsl:when><xsl:otherwise><xsl:attribute name="src">http://www.newco.dev.br/images/norecibido.gif</xsl:attribute></xsl:otherwise></xsl:choose>   
	    </img>
	</a>
	</xsl:if>

    <input type="hidden" name="CHKRECIBIDO_{LMO_ID}">
      <xsl:choose><xsl:when test="LPE_ENTREGADA='S'"><xsl:attribute name="value">checked</xsl:attribute></xsl:when><xsl:otherwise><xsl:attribute name="value">unchecked</xsl:attribute></xsl:otherwise></xsl:choose>   
    </input>
        
</xsl:template>

<!--MULTI OFERTA FRAME 13-->
<xsl:template name="CANTIDAD_ENTREGADA_MOF13">
	<input type="hidden" name="IDLINEAPEDIDO_{LMO_ID}"  value="{LMO}"/>
	<input type="hidden" name="CANTIDADSINFORMATO_{LMO_ID}"  value="{LMO_CANTIDAD_SINFORMATO}"/>
    <xsl:choose>
      <xsl:when test="LMO_ESPACK='S'">
        <input type="hidden" name="CantidadEntregada_{LMO_ID}" value="{LMO_CANTIDAD_SINFORMATO}"/>
      </xsl:when>
      <xsl:otherwise>
		<input type="text" class="peq" name="CantidadEntregada_{LMO_ID}" size="8" style="text-align:right" maxlength="7"  value="{LMO_CANTIDAD_SINFORMATO}" OnBlur="UnidadesALotesRecibidasImagen(this.value,'{PRO_UNIDADESPORLOTE}','{LMO_CANTIDAD_SINFORMATO}',this);" onFocus="this.select();"/>
      </xsl:otherwise>
    </xsl:choose> 
	&nbsp;
	<xsl:if test="LMO_ESPACK!='S'">
    <a href="javascript:cambioRecibido({LMO_ID});">
		<img src="http://www.newco.dev.br/images/recibido.gif" width="16px" height="16px" name="IMGRECIBIDO_{LMO_ID}" id="IMGRECIBIDO_{LMO_ID}" value="checked" class="imgRecibido"/>
	</a>
	</xsl:if>
	<input type="hidden" name="CHKRECIBIDO_{LMO_ID}" value="checked"/>
</xsl:template>

<!--MULTI OFERTA FRAME 28-->
<xsl:template name="CANTIDAD_MOF28">
	<input type="text" name="NuevaCantidad_{LMO_ID}" size="8" maxlength="7" style="text-align:right" value="{LMO_CANTIDAD_SINFORMATO}" OnBlur="if(UnidadesALotes(this.value,'{PRO_UNIDADESPORLOTE}',this)) realizarCalculos(this.value,this,document.forms['form1'],{LMO_ID},{LMO_IDPRODUCTO}); else realizarCalculosPorDefinir(this.value,{LMO_ID},{LMO_IDPRODUCTO},document.forms['form1']);"/>
    <img name="CHKSOLICITAR_{LMO_ID}">
    <xsl:choose>
         <xsl:when test="LMO_CANTIDAD_SINFORMATO>0">
           <xsl:attribute name="src">http://www.newco.dev.br/images/recibido.gif</xsl:attribute>
           <xsl:attribute name="value">checked</xsl:attribute>
         </xsl:when>
         <xsl:otherwise>
           <xsl:attribute name="src">http://www.newco.dev.br/images/norecibido.gif</xsl:attribute>
           <xsl:attribute name="value">unchecked</xsl:attribute>
         </xsl:otherwise>
	</xsl:choose>
	</img>
</xsl:template>

<!--FIN DE TEMPLATES DE LA 7IMA COLUMNA DE LA TABLA GRANDE--> 

<!--PRODUCTOS TABLA GRANDE-->
<xsl:template name="templateMuestras">
	<xsl:param name="numMOF" />
    <xsl:param name="insertCome" />  
    
      <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
    
	<table class="grandeInicio">
  
        <xsl:element name="input"> 
          <xsl:attribute name="name">IDDIVISA</xsl:attribute>
          <xsl:attribute name="type">hidden</xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="//@current"/></xsl:attribute>
    	</xsl:element>
    <thead>
    <tr class="titulos">
     <!-- ref mvm + cod nacional si es farmacia -->
		<th class="ocho">  
			<xsl:choose>
				<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F'">
    				<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
				</xsl:when>
				<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N'">
    				<!--<xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente_2line']/node()"/>-->
					<xsl:choose>
					<xsl:when test="/Multioferta/MULTIOFERTA/NOMBREREFCLIENTE">
						<xsl:value-of select="/Multioferta/MULTIOFERTA/NOMBREREFCLIENTE"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente_2line']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>      
		</th>
     <!-- marca si es farmacia + ref provee si es normal-->   
      <th class="ocho"> 
      
       			<xsl:choose>
                        <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F'">
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_comercial']/node()"/>
                        </xsl:when>
                         <xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N'">
                         	<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                            <xsl:if test="DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S'">
                             	<xsl:if test="$numMOF != 'MOF_11'"><br />(<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>)</xsl:if>
                             </xsl:if>
                        </xsl:when>
                 </xsl:choose>    
	  </th>
      <!--nombre-->
      <th class="trenta" align="left">     
       <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>    </th>
    </tr>
    </thead>
    <tbody>
    <!-- FOR EACH PARA CADA LINEA DE PRODUCTO -->    
 <xsl:for-each select="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW">
 <tr>
	<td>
    <!--si es farmacia pro ref , si es normal ref priv-->
		<xsl:choose>
		   <xsl:when test="LMO_CATEGORIA = 'F'">
        		  <xsl:value-of select="PRO_REFERENCIA"/>   
		   </xsl:when>
		   <xsl:when test="LMO_CATEGORIA = 'N'">
        		  <xsl:if test="REFERENCIA_PRIVADA!=''">
         			 <xsl:apply-templates select="REFERENCIA_PRIVADA"/>&nbsp;
        		</xsl:if>
    		</xsl:when>
		</xsl:choose>
	</td>
	<td>
        <!--ref provee si normal, marca si farmacia-->
      			<xsl:choose>
                    <xsl:when test="LMO_CATEGORIA = 'F'">
                       <xsl:value-of select="PRO_MARCA"/>   
                    </xsl:when>
                    <xsl:when test="LMO_CATEGORIA = 'N'">
                       <xsl:apply-templates select="PRO_REFERENCIA"/>&nbsp;
                        	 <xsl:if test="../../DATOSCLIENTE/EMP_OCULTARPRECIOREF !='S' and PRO_MARCA != ''">
                             	<xsl:if test="$numMOF != 'MOF_11'"><br />(<xsl:value-of select="PRO_MARCA"/>)</xsl:if>
                             </xsl:if>
                    </xsl:when>
                 </xsl:choose>
      
	</td>      
	<td class="trenta" style="text-align:left;">   
        <xsl:choose>
        <!--si es proveedor (muestras)-->
          <xsl:when test="//USUARIO/IDEMPRESA = //DATOSPROVEEDOR/EMP_ID">
          	 <xsl:value-of select="PRO_NOMBRE" />  
          </xsl:when>
          <xsl:when test="NOMBRE_PRIVADO!=''">
            <a>
              <xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;IDEMPRESA_COMPRADORA=<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_IDCLIENTE"/>','producto',70,50,0,-50)</xsl:attribute>
              <xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
              <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
              <xsl:value-of select="NOMBRE_PRIVADO"/>
            </a>&nbsp;
          </xsl:when>
          <xsl:otherwise>
            <a>
              <xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;IDEMPRESA_COMPRADORA=<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_IDCLIENTE"/>','producto',70,50,0,-50)</xsl:attribute>
              <xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
              <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
              <xsl:value-of select="PRO_NOMBRE" />
            </a>&nbsp;
          </xsl:otherwise>
        </xsl:choose>
	</td> 
   </tr>
  </xsl:for-each>
  </tbody>
 
    
 </table> 
 	<xsl:call-template name="NEGOCIACION">        
        <xsl:with-param name="numMOF"><xsl:value-of select="$numMOF"/></xsl:with-param>     
        <xsl:with-param name="insertCome"><xsl:value-of select="$insertCome"/></xsl:with-param> 
    </xsl:call-template> 
    <br />
	<br />
</xsl:template>
<!--fin de muestras-->

<!--BOTONES Mostramos 2 botones RO-->       
<xsl:template name="botonesDosMultioferta"> 

 <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
    <a class="btnNormal" href="javascript:parent.window.close();">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
    </a>
	&nbsp;
    <a class="btnNormal" href="javascript:window.print();">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
    </a>
   <!--
	<table class="botonesMOF">
        <tr>
		<td class="veinte">&nbsp;</td>       
 	      <td class="cuarenta">
          		<!- - <div class="boton">- ->
            	<a class="btnDestacado" href="javascript:parent.window.close();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                </a>
            	<!- - </div>- ->
 	      </td>
	      <td class="cuarenta">
          	<!- - <div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
            <!- - 	</div>- ->
 	      </td>
	    </tr>
	  </table>
	  -->
</xsl:template>

<!--BOTONES Mostramos 2 botones RO-->       
<xsl:template name="botonesDosAbonoMultioferta"> 
		<!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 
	  
        <a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONFIRMAR');">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
        </a>
		&nbsp;
        <a class="btnDestacado" href="javascript:Rechazar(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECHAZAR');">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
        </a>

	<!--
	<table class="botonesMOF">
	<tr>
	<td class="veinte">&nbsp;</td>       
	  <td class="cuarenta">
	  <!- - <div class="boton">- ->
        	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONFIRMAR');">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
        	</a>
    	<!- -</div>- ->
	  </td>
	  <td class="cuarenta">
    	  <!- -<div class="boton">- ->
        	<a class="btnDestacado" href="javascript:Rechazar(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECHAZAR');">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
        	</a>
    	 <!- - </div>- ->
	  </td>
	</tr>
	</table>
	-->
</xsl:template>

<!--BOTONES para el usuario aprobador, caso 40_RW + PERMITIR_MANTENIMIENTO-->       
<xsl:template name="botonesUsuarioAprobador"> 
		<!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 
	  
        <a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos.xsql?IDMULTIOFERTA={/Multioferta/MULTIOFERTA/MO_ID}','Historico',65,58,0,-50);">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='Historico']/node()"/>
        </a>
		&nbsp;
        <a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONFIRMAR');">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
        </a>
		&nbsp;
        <xsl:call-template name="botonMantPedido" />
		&nbsp;
        <a class="btnDestacado" href="javascript:Rechazar(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECHAZAR');">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
        </a>

	<!--
	<table class="botonesMOF">
	<tr>
	<td class="veinte">&nbsp;</td>       
	  <td class="cuarenta">
	  <!- - <div class="boton">- ->
        	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONFIRMAR');">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
        	</a>
    	<!- -</div>- ->
	  </td>
	  <td class="cuarenta">
    	  <!- -<div class="boton">- ->
        	<a class="btnDestacado" href="javascript:Rechazar(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECHAZAR');">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
        	</a>
    	 <!- - </div>- ->
	  </td>
	</tr>
	</table>
	-->
</xsl:template>

<!--BOTONES Mostramos 3 botones-->       
<xsl:template name="botonesTresMultioferta">  
 <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 
      
    <a class="btnNormal" href="javascript:window.close()">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
    </a>
	&nbsp;
    <a class="btnDestacado" href=" javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=COBRO_OK');">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar_pedido']/node()"/>
    </a>
	&nbsp;
    <a class="btnNormal" href="javascript:window.print();">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
    </a>
	<!--
	<table class="botonesMOF">
	<tr>
		<td class="dies">&nbsp;</td>       
 		<td class="trenta">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
            	</a>
        	<!- -</div>- ->
 		</td>
 		  <td class="trenta">
    	  <!- -<div class="boton">- ->
            	<a class="btnDestacado" href=" javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=COBRO_OK');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar_pedido']/node()"/>
            	</a>
    	   <!- - </div>- ->
		</td> 
 		 <td class="trenta">
 	    	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
            	</a>
        	<!- -</div>- ->
 		</td> 
	  </tr>
	</table>
	-->
</xsl:template>

<!--BOTONES Mostramos 3 botones guardar-->       
<xsl:template name="botonesGuardarMultioferta">  
 <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 
	<a class="btnNormal" href="javascript:window.close()">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_cambios']/node()"/>
	</a>
	&nbsp;
	<a class="btnNormal" href="javascript:window.print();">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
	</a>
    <!--
	<table class="botonesMOF">
	<tr>
		<td class="dies">&nbsp;</td>       
 	    <td class="trenta">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
            <!- -</div>- ->
           
 	    </td>
 	      <td class="trenta">
          	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_cambios']/node()"/>
                </a>
           <!- - </div>- ->
	    </td> 
 	     <td class="trenta">
         	 <!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td> 
	  </tr>
	</table>
	-->
    
   </xsl:template>
   
<!--BOTONES Mostramos 3 botones muestras aceptar-->       
<xsl:template name="botonesTresRechazoMultioferta">  
 <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 
      
	<a class="btnNormal" href="javascript:window.close()">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
	</a>
	&nbsp;
	<a class="btnNormal" href="javascript:window.print();">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
	</a>
	<!--
	<table class="botonesMOF">
	<tr>
		<td class="dies">&nbsp;</td>       
 	    <td class="trenta">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td>
 	      <td class="trenta">
          	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
                </a>
            <!- -</div>- ->
	    </td> 
 	     <td class="trenta">
 	        <!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td> 
	  </tr>
	</table>
	-->
</xsl:template>

<!--BOTONES Mostramos 3 botones muestras recibida-->       
<xsl:template name="botonesTresRecibidaMultioferta">  
 <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 
        
	<a class="btnNormal" href="javascript:window.close()">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECEPCION_OK');">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras_recibidas']/node()"/>
	</a>
	&nbsp;
	<a class="btnNormal" href="javascript:window.print();">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
	</a>
	<!--
	<table class="botonesMOF">
	<tr>
		<td class="dies">&nbsp;</td>       
 	    <td class="trenta">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td>
 	    <td class="trenta">
          	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECEPCION_OK');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='muestras_recibidas']/node()"/>
                </a>
            <!- -</div>- ->
          
	    </td> 
 	     <td class="trenta">
 	       <!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td> 
	  </tr>
	</table>
	-->
</xsl:template>

<!--BOTONES Mostramos 3 botones abonos-->       
<xsl:template name="botonesTresAbonoMultioferta">  
 <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

	<a class="btnNormal" href="javascript:window.close()">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
	</a>
	&nbsp;
	<a class="btnNormal" href="javascript:window.print();">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
	</a>

	<!--
	<table class="botonesMOF">
	<tr>
		<td class="dies">&nbsp;</td>       
 	    <td class="trenta">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td>
 	      <td class="trenta">
          	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
                </a>
            <!- -</div> - ->
	    </td> 
 	     <td class="trenta">
         	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td> 
	  </tr>
	</table>
	-->
</xsl:template>

<!--BOTONES Mostramos 3 botones abonos-->       
<xsl:template name="botonesTresAbonoPendienteMultioferta">  
  <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

	<a class="btnNormal" href="javascript:window.close()">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='abono_aceptado']/node()"/>
	</a>
	&nbsp;
	<a class="btnNormal" href="javascript:window.print();">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
	</a>
	<!--
	<table class="botonesMOF">
	<tr>
		<td class="dies">&nbsp;</td>       
 	    <td class="trenta">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
           <!- - </div>- ->
 	    </td>
 	     <td class="trenta">
         	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='abono_aceptado']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td> 
 	      <td class="trenta">
          	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
            <!- -</div>- ->
	    </td> 
	  </tr>
	</table>
	-->
</xsl:template>

<xsl:template name="botonesCuatroMultioferta">    

	<!--	
	
		CUIDADO: ESTE CASO ES MAS COMPLEJO, REVISAR
		
	-->

    <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->


	<xsl:choose>
  	<xsl:when test="/Multioferta/MULTIOFERTA/BLOQUEARBANDEJA">
        <span class="urgente">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_problematicos']/node()"/><br />
        <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_problematicos1']/node()"/>
        </span>
    </xsl:when>
	<xsl:otherwise>
        <a class="btnNormal" href="javascript:window.close()">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
        </a>
		&nbsp;
        <a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONFIRMAR');">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
        </a>
		&nbsp;
        <a class="btnDestacado" href="javascript:Rechazar(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECHAZAR');">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
        </a>
		&nbsp;
        <a class="btnNormal" href="javascript:window.print();">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
        </a>
	</xsl:otherwise>
	</xsl:choose>   
	
	<!-- 
	<table class="botonesMOF">
     <!- -si pedido bloqueado en bandeja de entrada tiene que estar bloqueado tb aqui, provee no puede aceptar desde aqui- ->   
         <xsl:choose>
        	<xsl:when test="/Multioferta/MULTIOFERTA/BLOQUEARBANDEJA">
            	<tr>
                    <td>&nbsp;</td>
                    <td colspan="4">
                        <span class="urgente">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_problematicos']/node()"/><br />
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_problematicos1']/node()"/>
                        </span>
                        <br /><br />
                    </td>
      			</tr>
                <tr>
                    <td colspan="5">&nbsp; </td>
      			</tr>
            </xsl:when>
            <xsl:otherwise>
            	 &nbsp;
            </xsl:otherwise>
         </xsl:choose>   
     
	  <tr>  
      <!- -si pedido bloqueado en bandeja de entrada tiene que estar bloqueado tb aqui, provee no puede aceptar desde aqui- ->   
         <xsl:choose>
       
        	<xsl:when test="/Multioferta/MULTIOFERTA/BLOQUEARBANDEJA"><td width="35%">&nbsp;</td></xsl:when>
            <xsl:otherwise><td width="10%">&nbsp;</td></xsl:otherwise>
         </xsl:choose>   
         
 	    <td width="20%">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
           <!- - </div>- ->
 	    </td>
       
        <!- -si pedido bloqueado en bandeja de entrada tiene que estar bloqueado tb aqui, provee no puede aceptar desde aqui- ->
        <xsl:choose>
        
        	<xsl:when test="/Multioferta/MULTIOFERTA/BLOQUEARBANDEJA">
            	<td colspan="2">&nbsp;</td>
            </xsl:when>
            <xsl:otherwise> 
                <td width="20%">
                	<!- -<div class="boton">- ->
                        <a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONFIRMAR');">
                             <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
                        </a>
                   <!- - </div>- ->
                </td>
                <td width="20%">
                	<!- -<div class="boton">- ->
                        <a class="btnDestacado" href="javascript:Rechazar(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECHAZAR');">
                             <xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
                        </a>
                    <!- -</div>- ->
                </td>
         	</xsl:otherwise>
        </xsl:choose>
 	    <td width="20%">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td>
	  </tr>
	</table>
	-->
  
</xsl:template>

<xsl:template name="botonesProvAceptarPedido">    

	<!--	
	
		CUIDADO: ESTE CASO ES MAS COMPLEJO, REVISAR
		
	-->

    <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->


	<xsl:choose>
  	<xsl:when test="/Multioferta/MULTIOFERTA/BLOQUEARBANDEJA">
        <span class="urgente">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_problematicos']/node()"/><br />
        <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_problematicos1']/node()"/>
        </span>
    </xsl:when>
	<xsl:otherwise>
		<span id="despOpciones" style="display:none;">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Multioferta/MULTIOFERTA/MOTIVOS/field"/>
				<xsl:with-param name="onChange">javascript:SeleccionadoMotivo();</xsl:with-param>
				<xsl:with-param name="style">width:400px;</xsl:with-param>
				<!--<xsl:with-param name="claSel">filtro</xsl:with-param>-->
			</xsl:call-template>
		</span>
        <a class="btnNormal" id="btnPendiente" href="javascript:window.close()">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
        </a>
		&nbsp;
        <a class="btnDestacado" id="btnAceptar" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONFIRMAR');">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
        </a>
		&nbsp;
        <a class="btnDestacado" id="btnConsultar" href="javascript:Consultar(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONSULTAR');">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='Consultar']/node()"/>
        </a>
		&nbsp;
        <a class="btnDestacado" id="btnRechazar" href="javascript:Rechazar(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECHAZAR');">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/>
        </a>
		&nbsp;
        <a class="btnNormal" id="btnImprimir" href="javascript:window.print();">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
        </a>
	</xsl:otherwise>
	</xsl:choose>   
  
</xsl:template>

<xsl:template name="botonesIncidenciaMultioferta">    
 <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
   <br/> 


	<a class="btnDestacado" href="javascript:window.close()">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONFIRMAR');">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:window.print();">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
	</a>

<!--
	<table class="botonesMOF">
	  <tr>        
        <td class="veinte">&nbsp;</td>
 	    <td class="veinte">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td>
	    <td class="veinte">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=CONFIRMAR');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
                </a>
           <!- - </div>- ->
	    </td>
 	    <td class="veinte">
 	       	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
           <!- - </div>- ->
 	    </td> 
	  
	  </tr>
	</table>
-->
</xsl:template>

<xsl:template name="botonesCuatroCobroMultioferta">  
	 <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 
	<br/> 
	<a class="btnDestacado" href="javascript:window.close()">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=COBRO_OK');">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar_pedido']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:window.print();">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
	</a>
   
   <!--
	<table class="botonesMOF">
	  <tr>        
        <td class="veinte">&nbsp;</td>
 	    <td class="veinte">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td>
	    <td class="veinte">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=COBRO_OK');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar_pedido']/node()"/>
                </a>
            <!- -</div>- ->
	    </td>
 	    <td class="veinte">
 	     <!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
           <!- - </div>- ->
 	    </td> 
	  </tr>
	</table>
	-->
</xsl:template>
<!--pedidos programados-->
<xsl:template name="botonesCuatroProgramaMultioferta">   
	<!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin--> 
	<br/> 
	<a class="btnDestacado" href="javascript:window.close()">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECHAZAR');">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar_envio']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pedido']/node()"/>
	</a>
	&nbsp;
	<a class="btnDestacado" href="javascript:window.print();">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
	</a>
	<!--
	<table class="botonesMOF">
	  <tr>        
        <td class="dies">&nbsp;</td>
 	    <td class="veinte">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td>
	    <td class="veinte">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECHAZAR');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar_envio']/node()"/>
                </a>
            <!- -</div>- ->
	    </td>
	    <td class="veinte">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=OK');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pedido']/node()"/>
                </a>
            <!- -</div>- ->
	    </td>
 	    <td class="veinte">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td> 
	  </tr>
	</table>
	-->
</xsl:template>

<!--BOTONES Mostramos todos los botones del xsql - O sea, el choose ya se hace en la base de datos para esta parte - El estado 10 es un caso aparte-->       
<xsl:template name="botonesMultioferta">    
 <!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

        <a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECEPCION_OK');" id="botonRecibido" style="display:;">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_recibido']/node()"/>
        </a>
		&nbsp;
        <a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECEPCION_PARCIAL');" id="botonRecibidoParc" style="display:none;">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='recibido_parcialmente']/node()"/>
        </a>
		<xsl:if test="not(/Multioferta/MULTIOFERTA/OBLIGAR_PEDIDO_COMPLETO)">
			&nbsp;
        	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=ABONO');" id="botonAbono" style="display:none;">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='crear_abono']/node()"/>
        	</a>
			&nbsp;
        	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=BACKORDER');" id="botonBackorder" style="display:none;">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='crear_backorder']/node()"/>
        	</a>
			&nbsp;
        	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=LEGALIZAR');" id="botonLegalizar" style="display:none;">
            	 <xsl:value-of select="document($doc)/translation/texts/item[@name='legalizar']/node()"/>
        	</a>
		</xsl:if>
		&nbsp;
        <a class="btnNormal" href="javascript:window.close()">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
        </a>
		&nbsp;
        <a class="btnNormal" href="javascript:window.print();">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
        </a>

	<!--<br/>
	<table class="botonesMOF">
        <tr>
             <td colspan="6"><p>&nbsp;&nbsp;(*)&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='text_expli_boton_pedido_parcial']/node()"/></p></td>
        </tr>
        <tr><td colspan="6">&nbsp;</td></tr>
		<tr> 
        <td class="dies">&nbsp;</td>       
 	    <td class="quince">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.close()">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td>
	    <td class="quince">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECEPCION_OK');" id="botonRecibido" style="display:;">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_recibido']/node()"/>
                </a>
                <span id="textRecibido" style="font-weight:bold;color:#666666;margin-top:4px;font-size:13px;display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_recibido']/node()"/></span>
                
           <!- - </div>- ->
	    </td>  
	    <td class="quince">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=RECEPCION_PARCIAL');" id="botonRecibidoParc" style="display:none;">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='recibido_parcialmente']/node()"/>
                </a>
                <span id="textRecibidoParc" style="font-weight:bold;color:#666666;margin-top:4px;font-size:13px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='recibido_parcialmente']/node()"/></span>
           <!- -     </div>- ->
                
	    </td> 
	    <td class="quince">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:Actua(document.forms['form1'],'MultiofertaSave.xsql?BOTON=ABONO');">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='crear_abono']/node()"/>
                </a>
           <!- - </div>- ->
	    </td>
 	    <td class="quince">
        	<!- -<div class="boton">- ->
            	<a class="btnDestacado" href="javascript:window.print();">
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                </a>
            <!- -</div>- ->
 	    </td> 
	  </tr>
         
	</table>
	-->	
</xsl:template>

<!--BOTONES Mostramos 2 botones RO-->       
<xsl:template name="botonesMVM"> 

	<!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 
	
	<table class="botonesMOF">
        <tr> 
          <td class="veinte">&nbsp;</td>       
 	      <td>
			<xsl:if test="/Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA = '1' or /Multioferta/MULTIOFERTA/USUARIO/IDEMPRESA = '6316'">
             <a class="btnNormal" href="javascript:VerXML('{/Multioferta/MULTIOFERTA/MO_ID}');">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_xml']/node()"/>
             </a>&nbsp;
			 </xsl:if>
			<xsl:if test="/Multioferta/MULTIOFERTA/PERMITIR_CONTROL_PEDIDOS">
             <a class="btnNormal" href="javascript:ControlPedidos('{/Multioferta/MULTIOFERTA/MO_IDPEDIDO}');">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='control_pedido']/node()"/>
             </a>&nbsp;
			</xsl:if>
			<xsl:if test="/Multioferta/MULTIOFERTA/PERMITIR_MANTENIMIENTO">
            <a class="btnNormal">
                <xsl:attribute name="href">javascript:MantenPedido('<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_ID"/>','<xsl:value-of select="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_ID"/>','<xsl:value-of select="/Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID"/>');</xsl:attribute>
                <xsl:value-of select="document($doc)/translation/texts/item[@name='manten_pedido']/node()"/>
            </a>&nbsp;
			</xsl:if>
            <a class="btnNormal">
                <xsl:attribute name="href">javascript:EnviarPDF('<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_ID"/>','CLIENTE');</xsl:attribute>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pdf_cliente']/node()"/>
            </a>&nbsp;
            <a class="btnNormal">
                <xsl:attribute name="href">javascript:EnviarPDF('<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_ID"/>','PROVEE');</xsl:attribute>
                <xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pdf_provee']/node()"/>
            </a>
			<!--
			&nbsp;
            <a class="btnNormal">
                <xsl:attribute name="href">javascript:EnviarPDF('<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_ID"/>','USUARIO');</xsl:attribute>
                <xsl:value-of select="document($doc)/translation/texts/item[@name='recibir_pdf']/node()"/>
            </a>
			-->
 	      </td>
          <td>&nbsp;</td>       
	    </tr>
	  </table>
</xsl:template>

<!--BOTON Mostramos botones MantPedido si es modelo de pedido programado (estado 28) y es el usuario que ha generado el pedido programado -->       
<xsl:template name="botonMantPedido"> 

<!--idioma-->                                             
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Multioferta/LANG"><xsl:value-of select="/Multioferta/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 

	<a class="btnDestacado">
		<xsl:attribute name="href">javascript:MantenPedido('<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_ID"/>','<xsl:value-of select="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_ID"/>','<xsl:value-of select="/Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID"/>');</xsl:attribute>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='manten_pedido']/node()"/>
	</a>

<!--
	<table class="botonesMOF">
        <tr>
		<td class="trenta">&nbsp;</td>
	      <td class="cuarenta">
          	   <!- -<div class="boton">- ->
            	<a class="btnDestacado">
                <xsl:attribute name="href">javascript:MantenPedido('<xsl:value-of select="/Multioferta/MULTIOFERTA/MO_ID"/>','<xsl:value-of select="/Multioferta/MULTIOFERTA/DATOSCLIENTE/EMP_ID"/>','<xsl:value-of select="/Multioferta/MULTIOFERTA/DATOSPROVEEDOR/EMP_ID"/>');</xsl:attribute>
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='manten_pedido']/node()"/>
                </a>
              <!- - </div>- ->
 	      </td>
	    </tr>
	  </table>
-->
</xsl:template>

<!--TEMPLATE A FONDO PAGINA-->
<xsl:template match="IMPORTE_TOTAL_FORMATO">
      <input type="text" name="MO_SUBTOTAL" size="12" maxlength="12" style="text-align:right;" value="{.}" class="noinput" onFocus="this.blur();"/>
      <!--input type="hidden" name="MO_SUBTOTAL_PRUEBAET3" value="{.}" />&nbsp;-->
</xsl:template> 

<xsl:template match="MO_COSTELOGISTICA">
  <input type="text" name="MO_COSTELOGISTICA" size="12" maxlength="12" style="text-align:right;font-weight:bold;">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
    <xsl:attribute name="onFocus">this.blur();</xsl:attribute>
  </input>
</xsl:template>  

<xsl:template match="MO_COSTELOGISTICA_FORMATO">
  <input type="text" name="MO_COSTELOGISTICA" size="12" maxlength="12" style="text-align:right;font-weight:bold;">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
    <xsl:attribute name="onFocus">this.blur();</xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="LMO_DESCUENTO">
  <input type="text" name="LMO_DESCUENTO" size="6" maxlength="6" style="text-align:right;">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="MO_STATUS">
  <input type="hidden" name="MO_STATUS">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="MO_ID">
  <input type="hidden" name="MO_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="ROL">
  <input type="hidden" name="ROL">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="TIPO">
  <input type="hidden" name="TIPO">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>


<xsl:template match="MO_IDPEDIDO">
  <input type="hidden" name="PED_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>


<xsl:template match="LPP_IDPEDIDO">
  <input type="hidden" name="PED_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="LPP_ID">
  <input type="hidden" name="LPP_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

  <xsl:template match="fieldTipoIVA">
  <xsl:variable name="IDAct" select="$IDAct"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="../@name"/><xsl:value-of select="../LMO_IDPRODUCTO"/></xsl:attribute>
      <xsl:attribute name="onChange">actualizaIVA('<xsl:value-of select="../LMO_IDPRODUCTO"/>',this.options[this.selectedIndex].value)</xsl:attribute>
      <xsl:for-each select="listElem">
      <xsl:value-of select="$IDAct"/>
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  
  <xsl:template name="fieldTipoIVA_funcion">
    <xsl:param name="path"/>
    <xsl:param name="IDAct"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="$path/../@name"/><xsl:value-of select="$path/../LMO_IDPRODUCTO"/></xsl:attribute>
      <xsl:attribute name="onChange">actualizaIVA('<xsl:value-of select="$path/../LMO_IDPRODUCTO"/>',this.options[this.selectedIndex].value)</xsl:attribute>
      <xsl:for-each select="$path/listElem">
      <xsl:value-of select="$IDAct"/>
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  

<!--combo entrega real   **ya no se usa, val por default de fecha actual 24-3-14 mc**
 <xsl:template name="COMBO_ENTREGA_REAL">
	<xsl:call-template name="field_funcion">
    	<xsl:with-param name="path" select="/Multioferta/field[@name='COMBO_ENTREGA_REAL']"/>
    	<xsl:with-param name="IDAct">0</xsl:with-param>
    	<xsl:with-param name="cambio">calculaFecha('ENTREGA_REAL',this.options[this.selectedIndex].value);</xsl:with-param>
    	<xsl:with-param name="perderFoco">AvisarFechaRecepcion=0;</xsl:with-param>
    </xsl:call-template>
 </xsl:template>-->
 
<!--pedido programado   **ya no se usa, val por default de fecha actual 24-3-14 mc**
  <xsl:template name="COMBO_ENTREGA">
  <xsl:variable name="plazoEntregaNormalizado">
    <xsl:choose>
      <xsl:when test="/Multioferta/MULTIOFERTA/LP_PLAZOENTREGA!='1' and /Multioferta/MULTIOFERTA/LP_PLAZOENTREGA!='2' and /Multioferta/MULTIOFERTA/LP_PLAZOENTREGA!='3' and /Multioferta/MULTIOFERTA/LP_PLAZOENTREGA!='4' and /Multioferta/MULTIOFERTA/LP_PLAZOENTREGA!='5' and /Multioferta/MULTIOFERTA/LP_PLAZOENTREGA!='7' and /Multioferta/MULTIOFERTA/LP_PLAZOENTREGA!='15' and /Multioferta/MULTIOFERTA/LP_PLAZOENTREGA!='30' and /Multioferta/MULTIOFERTA/LP_PLAZOENTREGA!='999'">999</xsl:when>
      <xsl:otherwise><xsl:value-of select="/Multioferta/MULTIOFERTA/LP_PLAZOENTREGA"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
	<xsl:call-template name="field_funcion">
    	<xsl:with-param name="path" select="/Multioferta/field[@name='COMBO_ENTREGA']"/>
    	<xsl:with-param name="IDAct"><xsl:value-of select="$plazoEntregaNormalizado"/></xsl:with-param>
    	<xsl:with-param name="cambio">calculaFecha('ENTREGA',this.options[this.selectedIndex].value);</xsl:with-param>
    	<xsl:with-param name="valorMinimo" select="/Multioferta/MULTIOFERTA/CENTRO/CEN_PLAZOENTREGA"/>
    </xsl:call-template>
</xsl:template>-->
 
</xsl:stylesheet>
