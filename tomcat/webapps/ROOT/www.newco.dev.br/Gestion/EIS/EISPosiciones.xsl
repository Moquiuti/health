<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Presentacion de datos estadisticos de utilizacion de la plataforma MedicalVM
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
     
	<title>Sistema de Informacion para la Direccion (E.I.S.)</title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
	<xsl:text disable-output-escaping="yes">
	<![CDATA[	
	
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript
	
	//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
	
	function MostrarListado(Indicador, Grupo, Anno, Mes)
	{
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Gestion/EIS/EISListado.xsql?'
				+'US_ID='+form.elements['OR_US_ID'].value
				+'&'+'IDINDICADOR='+Indicador
				+'&'+'ANNO='+Anno
				+'&'+'MES='+Mes
				+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
				+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
				+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
				+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
				+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
				+'&'+'IDFAMILIA='+form.elements['OR_IDFAMILIA'].value
				+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
				+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
				+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
				+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
				+'&'+'CODIGO='+form.elements['OR_CODIGO'].value
				//+'&'+'IDNOMENCLATOR='+
				//+'&'+'URGENCIA='+
				+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
				+'&'+'IDGRUPO='+Grupo;
				
		//alert (Enlace);
		
		//alert('IDINDICADOR='+Indicador+' ANNO='+Anno+' MES='+Mes);
				
		MostrarPag(Enlace, 'Listado');
	}
	
	function MostrarGraficos(Tipo){	//	Grafico de barras o de lineas
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/cocoon/EIS_SVG.svg?'
				+'SES_ID='+form.elements['OR_SES_ID'].value
				+'&'+'IDCUADROMANDO='+form.elements['OR_IDCUADRO'].value
				+'&'+'ANNO='+form.elements['OR_ANNO'].value
				+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
				+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
				+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
				+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
				+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
				+'&'+'IDFAMILIA='+form.elements['OR_IDFAMILIA'].value
				+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
				+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
				+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
				+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
				+'&'+'CODIGO='+form.elements['OR_CODIGO'].value
				+'&'+'IDRESULTADOS='+form.elements['OR_IDRESULTADOS'].value
				+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
				+'&'+'IDRATIO='+form.elements['OR_IDRATIO'].value
				+'&'+'TIPOGRAFICO='+Tipo;
		
		//alert (Enlace);
				
	  MostrarPag(Enlace, 'Grafico');
	}
	
	function HabilitarRatios(form,valor,dspOrigen, dspDestino){
	  if(form.elements[dspOrigen].value==valor){
	    form.elements[dspDestino].disabled=false;
	  }
	  else{
	    form.elements[dspDestino].selectedIndex=0;
	    form.elements[dspDestino].disabled=true;
	  }
	}
	
	
	function MostrarFuenteSVG(){
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/images/svg/EIS_SVG.xsql?'
				+'SES_ID='+form.elements['OR_SES_ID'].value
				+'&'+'IDCUADROMANDO='+form.elements['OR_IDCUADRO'].value
				+'&'+'ANNO='+form.elements['OR_ANNO'].value
				+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
				+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
				+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
				+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
				+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
				+'&'+'IDFAMILIA='+form.elements['OR_IDFAMILIA'].value
				+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
				+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDIDTIPOINCIDENCIA'].value
				+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
				+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
				+'&'+'CODIGO='+form.elements['OR_CODIGO'].value
				+'&'+'IDRESULTADOS='+form.elements['OR_IDRESULTADOS'].value
				+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
				+'&'+'TIPOGRAFICO=BARRAS';
				
	  MostrarPag(Enlace, 'Grafico');
	}
	
	function MostrarEISInicio()
	{
	  MostrarPag('http://www.newco.dev.br/Gestion/EIS/EISInicio.xsql', 'Consulta');
	}
	
	//	Solo para pruebas con XML
	function MostrarXML()
	{
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatosXML.xsql?'
				+'US_ID='+form.elements['OR_US_ID'].value
				+'&'+'IDCUADROMANDO='+form.elements['OR_IDCUADRO'].value
				+'&'+'ANNO='+form.elements['OR_ANNO'].value
				+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
				+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
				+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
				+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
				+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
				+'&'+'IDFAMILIA='+form.elements['OR_IDFAMILIA'].value
				+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
				+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDIDTIPOINCIDENCIA'].value
				+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
				+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
				+'&'+'CODIGO='+form.elements['OR_CODIGO'].value
				//+'&'+'IDNOMENCLATOR='+
				//+'&'+'URGENCIA='+
				+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
				+'&'+'IDRESULTADOS='+form.elements['OR_IDRESULTADOS'].value;
				
				
		MostrarPag(Enlace, 'Prueba');
	}
       
	
	//-->
	</script>

	]]>
	</xsl:text>	
    </head>
    <body>
		<!--	Comprueba si la sesión ha caducado	-->
	<xsl:choose>
        <xsl:when test="//SESION_CADUCADA">
        	<xsl:apply-templates select="//SESION_CADUCADA"/> 
        </xsl:when>
		<xsl:otherwise>
	    <!-- Cabecera -->
	  	<form method="post" action="EISPosiciones.xsql"><!--?xml-stylesheet=none-->
       	<input type="hidden" name="Indicadores" value=""/>
		<!--	Guardamos los valores originales en campos ocultos		-->
       	<input type="hidden" name="OR_US_ID">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/US_ID"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_SES_ID">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/SES_ID"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDCUADRO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDCUADRO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_ANNO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/ANNO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDEMPRESA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDEMPRESA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDCENTRO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDCENTRO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDUSUARIOSEL">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDUSUARIOSEL"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDEMPRESA2">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDEMPRESA2"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDPRODUCTO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDPRODUCTO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDFAMILIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDFAMILIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDESTADO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDESTADO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDTIPOINCIDENCIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDTIPOINCIDENCIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDGRAVEDAD">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDGRAVEDAD"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDNOMENCLATOR">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDNOMENCLATOR"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_URGENCIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/URGENCIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_REFERENCIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/REFERENCIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_CODIGO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CODIGO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDRESULTADOS">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDRESULTADOS"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_AGRUPARPOR">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/AGRUPARPOR"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDRATIO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDRATIO"/></xsl:attribute>
		</input>
		<!--	Comprueba si no hay datos	-->
        <xsl:choose>
        <xsl:when test=" not (/EIS_XML/EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR/GRUPO/ROW/TOTAL)">
      <!--titulo-->
       <div class="titlePage"><strong>La consulta no ha devuelto ningún dato. Pruebe a utilizar otras restricciones en la búsqueda.</strong></div>
		<div class="divLeft">
        <br /><br />
        	<div class="divLeft30">&nbsp;</div>
            <div class="divLeft15nopa">
            	<div class="boton">
                <xsl:call-template name="botonPersonalizado">
                    <xsl:with-param name="funcion">history.go(-1);</xsl:with-param>
                    <xsl:with-param name="status">Volver a la página anterior</xsl:with-param>
                    <xsl:with-param name="label">Volver</xsl:with-param>
                </xsl:call-template>
                </div>
			</div>
            <div class="divLeft15nopa">
            	<div class="boton">
                <xsl:call-template name="botonPersonalizado">
                    <xsl:with-param name="funcion">window.close();</xsl:with-param>
                    <xsl:with-param name="status">Cerrar la página</xsl:with-param>
                    <xsl:with-param name="label">Cerrar</xsl:with-param>
                </xsl:call-template>
                </div>
            </div>
            <div class="divLeft15nopa">
	            <div class="boton">
                <xsl:call-template name="botonPersonalizado">
                    <xsl:with-param name="funcion">MostrarEISInicio();</xsl:with-param>
                    <xsl:with-param name="status">Inicio</xsl:with-param>
                    <xsl:with-param name="label">Acceso inicial al EIS</xsl:with-param>
                </xsl:call-template>
                </div>
			</div>
          </div><!--fin de divLeft-->
        </xsl:when>
        <xsl:otherwise>
        <table class="infoTable">
		<tr class="tituloTabla">
			<th colspan="7">
			Sistema de Información para la Dirección (actualizado: <xsl:value-of select="/EIS_XML/EISANALISIS/ACTUALIZACION"/>) - Posiciones relativas
			</th>
        </tr>
		<tr><td colspan="7">&nbsp;</td></tr>
	    <tr>
      		<xsl:for-each select="/EIS_XML/EISANALISIS/FILTROS/field">
				<xsl:choose>
				  <xsl:when test="count(/EIS_XML/EISANALISIS/FILTROS/field) mod 2!=0 and position()=last()">
				    <td class="labelRight">
					<xsl:value-of select="./@label"/>:
				    </td>
				    <td class="datosLeft" colspan="3">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select=".">
        				</xsl:with-param>
      				       </xsl:call-template>				
				    </td>
				  </xsl:when>
				  <xsl:otherwise>
				    <td class="labelRight" >
					<xsl:value-of select="./@label"/>:
				    </td>
				    <td class="datosLeft">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select=".">
        				</xsl:with-param>
      				       </xsl:call-template>				
				    </td>
				  </xsl:otherwise>
				</xsl:choose>
				
      		</xsl:for-each>
			<tr>
				<td class="labelRight dies">
					<xsl:value-of select="/EIS_XML/EISANALISIS/AGRUPARPOR/field/@label"/>:&nbsp;
				</td>
				<td class="datosLeft cuarenta">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/AGRUPARPOR/field">
        				</xsl:with-param>
      				</xsl:call-template>				
				</td>
				<td class="dies">&nbsp;</td>
				<td class="cuarenta">&nbsp;</td>
			</tr>
			<!-- ET 20nov06, incluimos busqueda por numero de pedido. inicio nuevo bloque	-->
			<tr>
				<td class="dies labelRight">Documento:&nbsp;</td>
				<td class="cuarenta datosLeft">
					<table><tr>
					<td>
					<input type="text" name="CODIGO">
					<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CODIGO"/></xsl:attribute>
					</input>
					</td>
					<td>
					<small>&nbsp;'?': Un único carácter: '0604?01'<br/>&nbsp;'*': Una cadena: '*jering*'</small>
					</td>
					</tr></table>
				</td>
				<td class="dies labelRight">Producto:&nbsp;</td>
				<td class="cuarenta datosLeft">
					<table><tr>
					<td>
					<input type="text" name="REFERENCIA">
					<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/REFERENCIA"/></xsl:attribute>
					</input>
					</td>
					<td>
					<small>&nbsp;'?': Un único carácter: '0604?01'<br/>&nbsp;'*': Una cadena: '*jering*'</small>
					</td>
					</tr></table>
				</td>
			</tr>
			<!-- fin nuevo bloque	-->
			<tr>
				<td class="dies labelRight">
					<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@label"/>:
				</td>
				<td class="cuarenta datosLeft">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRESULTADOS/field">
        				</xsl:with-param>
        				<xsl:with-param name="onChange">HabilitarRatios(document.forms[0],'RATIO','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@name"/>','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@name"/>');</xsl:with-param>
      				</xsl:call-template>				
				</td>
				<td class="dies labelRight">
					<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@label"/>:
				</td>
				<td class="cuarenta datosLeft">
				  <xsl:variable name="vDeshabilitado">
				    <xsl:if test="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@current!='RATIO'">
        		              disabled
        		            </xsl:if>
				  </xsl:variable>
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRATIO/field"> 
        				</xsl:with-param>
        				<xsl:with-param name="deshabilitado"><xsl:value-of select="$vDeshabilitado"/></xsl:with-param>
      				</xsl:call-template>				
				</td>
			</tr>
			<tr>
            	<td>&nbsp;</td>
				<td colspan="2">
                	<div class="boton">
					<a href="javascript:SubmitForm(document.forms[0])">Actualizar</a>
                    </div>
   				</td>
                <td>&nbsp;</td>
			</tr>
		</tr>
		</table>

	<br />
    <br />
	 <table class="tablaEIS" >
	    <tr>	 
			<th>Indicadores</th>
      		<xsl:for-each select="/EIS_XML/EISANALISIS/DATOSEIS/LISTAMESES/MES">
	      		<th class="seis">
					<xsl:value-of select="NOMBRE"/>
				</th>
      		</xsl:for-each>
		</tr>
      	<xsl:for-each select="/EIS_XML/EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR">
            <xsl:variable name="IDINDICADOR">
                <xsl:value-of select="./IDINDICADOR"/>
            </xsl:variable>
        </xsl:for-each>
	    <tr>	 
	      	<th><xsl:value-of select="./NOMBREINDICADOR"/></th>
		</tr>
      		<xsl:for-each select="GRUPO">
				<xsl:variable name="IDGRUPO">
					<xsl:value-of select="./IDGRUPO"/>
				</xsl:variable>
				<tr>	
					<th><xsl:value-of select="./NOMBREGRUPO"/></th>
      				<xsl:for-each select="ROW">
						<th>
							<a>
							<xsl:if test="./ROJO">
								<xsl:attribute name="class">rojo</xsl:attribute>
							</xsl:if>
							<xsl:attribute name="HREF">javascript:MostrarListado('<xsl:value-of select="$IDINDICADOR"/>','<xsl:value-of select="$IDGRUPO"/>','<xsl:value-of select="./ANNO"/>','<xsl:value-of select="./MES"/>');</xsl:attribute>
							<xsl:value-of select="./TOTAL"/>
							</a>
						</th>
      				</xsl:for-each>
				</tr>
      		</xsl:for-each>
		</table> 
		
		<div class="divleft">
        	<div class="divLeft40">&nbsp;</div>
            	<div class="divLeft15nopa">
			      <xsl:call-template name="botonPersonalizado">
			        <xsl:with-param name="funcion">Imprimir();</xsl:with-param>
			        <xsl:with-param name="status">Imprimir</xsl:with-param>
			        <xsl:with-param name="label">Imprimir</xsl:with-param>
			      </xsl:call-template>
			   </div>
            </div>
			
      </xsl:otherwise>
      </xsl:choose>
		</form>
      </xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
