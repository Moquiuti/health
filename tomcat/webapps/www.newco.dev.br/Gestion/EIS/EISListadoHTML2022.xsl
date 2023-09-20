<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Listado de resgistros desde el resumen mensual del EIS
	Ultima revision: ET 11may23 10:45
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>  
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
    
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/ListadoEIS/LANG" />
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="/ListadoEIS/INDICADOR/TITULO"/>:&nbsp;<xsl:value-of select="/ListadoEIS/INDICADOR/NOMBREINDICADOR"/></title>
    
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- 3may21 Para descargas excel	-->
    <script type="text/javascript">
	 	var IncluirLicitacion='<xsl:choose><xsl:when test="/ListadoEIS/INDICADOR/INCLUIR_LICITACION">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		
		var strTitExcel='<xsl:value-of select="document($doc)/translation/texts/item[@name='contador']/node()"/>;'
					+'<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>;'
					+'<xsl:value-of select="document($doc)/translation/texts/item[@name='numero']/node()"/>;';
					
		if (IncluirLicitacion=='S')					
			strTitExcel+='<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>;';
			
		strTitExcel+='<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>;'
					+'<xsl:value-of select="ListadoEIS/INDICADOR/NOMBREEMPRESA2"/>;'
					+'<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>;'
					+'<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>;';

		
		var arrRegistros	= [];
		<xsl:for-each select="/ListadoEIS/INDICADOR/REGISTROS/REGISTRO">
			var Reg= [];
			Reg['Cont']	= '<xsl:value-of select="CONTADOR"/>';
			Reg['Url']		= '<xsl:value-of select="ENLACE"/>';
			Reg['Fecha']	= '<xsl:value-of select="FECHA"/>';
			Reg['Codigo']	= '<xsl:value-of select="CODIGO"/>';
			Reg['CodLicitacion']	= '<xsl:value-of select="CODLICITACION"/>';
			Reg['Centro']	= '<xsl:value-of select="CENTRO"/>';
			Reg['Empresa2']	= '<xsl:value-of select="EMPRESA2"/>';
			Reg['Estado']	= '<xsl:value-of select="ESTADO"/>';
			Reg['Total']	= '<xsl:value-of select="TOTAL"/>';
			arrRegistros.push(Reg);
			<!--debug('Cargando registro ('+Reg['Cont']+') '+Reg['Codigo']+' '+Reg['Centro']+'-'+Reg['Empresa2']+' tot:'+Reg['Total']+' en '+Reg['Url']);-->
		</xsl:for-each>
		
	</script>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript
	
	//	Presenta la pagina con el registro correspondiente a la seleccion del usuario
	
	function MostrarRegistro(Enlace)
	{				
		//alert (Enlace);
				
		MostrarPag(Enlace.replace('.xsql','2022.xsql'), 'Registro');		//	29mar22 Cambiamos a la URL del nuevo disenno, ACTIVADO 3NOV22
		//MostrarPag(Enlace, 'Registro');
	}

	var sepCSV			=';';
	var sepTextoCSV		='';
	var saltoLineaCSV	='\r\n';

	//	Exporta la seleccion del usuario a CSV
	function DescargarExcel()
	{
		var oForm=document.forms['frmDocumentos'], cadenaCSV=strTitExcel+saltoLineaCSV;

		debug("DescargarExcel");

		jQuery.each(arrRegistros, function(key, linea){
			cadenaCSV+=linea.Cont+sepCSV+linea.Fecha+sepCSV+linea.Codigo+sepCSV;

			if (IncluirLicitacion=='S')					
				cadenaCSV+=linea.CodLicitacion+sepCSV;
				
			cadenaCSV+=linea.Centro+sepCSV+linea.Empresa2+sepCSV+linea.Estado+sepCSV+linea.Total+saltoLineaCSV;
		});

		var Fecha=new Date;
		DescargaMIME(StringToISO(cadenaCSV), 'Pedido_'+Fecha.getDay()+(Fecha.getMonth()+1)+Fecha.getYear()+'.csv', 'text/csv');
	}

	
	//--->
	</script>
	]]></xsl:text>	
	
      <body>
      <xsl:choose>
        <xsl:when test="//SESION_CADUCADA">
              <xsl:apply-templates select="//SESION_CADUCADA"/>    
        </xsl:when>
        <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>
           </xsl:when>
        <xsl:otherwise>
        <div class="divLeft">
        
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:value-of select="/ListadoEIS/LANG" />
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="/ListadoEIS/INDICADOR/TITULO"/>&nbsp;<span class="fuentePeq">(<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizado']/node()"/>: <xsl:value-of select="ListadoEIS/INDICADOR/ACTUALIZACION"/>)</span>
				<span class="CompletarTitulo200">
					<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>
					&nbsp;
					<a class="btnNormal" href="javascript:print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
        <input type="hidden" id="SQL" value="{ListadoEIS/INDICADOR/REGISTROS/SQL}"/>
        <input type="hidden" id="ORIGEN">
        <xsl:attribute name="value">
           <xsl:if test="ListadoEIS/request/parameters/IDINDICADOR!=''">
                <xsl:value-of select="ListadoEIS/request/parameters/IDINDICADOR"/>
                <xsl:text>_</xsl:text>
           </xsl:if>
          
           <xsl:if test="ListadoEIS/INDICADOR/NOMBREEMPRESA2!='Proveedor'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/NOMBREEMPRESA2,' ','_')"/>
               <xsl:text>_</xsl:text>
           </xsl:if>
           
           <xsl:if test="ListadoEIS/INDICADOR/EMPRESA!='Todas'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/EMPRESA,' ','_')"/>
               <xsl:text>_</xsl:text>
           </xsl:if>
           <xsl:if test="ListadoEIS/INDICADOR/CENTRO!='Todas'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/CENTRO,' ','_')"/>
               <xsl:text>_</xsl:text>
           </xsl:if>
            
           <xsl:if test="ListadoEIS/INDICADOR/PRODUCTO!='Todos'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/PRODUCTO,' ','_')"/>
               <xsl:text>_</xsl:text>
           </xsl:if>
           <xsl:if test="ListadoEIS/INDICADOR/FAMILIA!='Todas'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/FAMILIA,' ','_')"/>
               <xsl:text>_</xsl:text>
           </xsl:if>
           <xsl:if test="ListadoEIS/INDICADOR/ESTADO!='Todos'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/ESTADO,' ','_')"/>
               <xsl:text>_</xsl:text>
           </xsl:if>
            <xsl:if test="ListadoEIS/INDICADOR/REFERENCIA!='Todas'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/REFERENCIA,' ','_')"/>
               <xsl:text>_</xsl:text>
           </xsl:if>
           <xsl:if test="ListadoEIS/INDICADOR/CODIGO!='Todos'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/CODIGO,' ','_')"/>
               <xsl:text>_</xsl:text>
           </xsl:if>
           <xsl:if test="ListadoEIS/INDICADOR/ANNO!='Últimos 12 meses'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/ANNO,' ','_')"/>
               <xsl:text>_</xsl:text>
           </xsl:if>
            <xsl:if test="ListadoEIS/INDICADOR/NOMBREMES!='Todos'">
               <xsl:value-of select="translate(ListadoEIS/INDICADOR/NOMBREMES,' ','_')"/>
           </xsl:if>
            </xsl:attribute>
        </input>    
                
        <!--<table class="azul">-->
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
	    	<th class="w1px"></th>
	    	<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/> </th>
	    	<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero']/node()"/> </th>
			<xsl:if test="/ListadoEIS/INDICADOR/INCLUIR_LICITACION">
	    		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/> </th>
	        </xsl:if>
	   		<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/> </th>
	    	<th class="textLeft"><xsl:value-of select="ListadoEIS/INDICADOR/NOMBREEMPRESA2"/></th>
	   		<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/> </th>
	    	<th class="textRight w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/> &nbsp;&nbsp;&nbsp;</th>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
       		<xsl:for-each select="ListadoEIS/INDICADOR/REGISTROS/REGISTRO">
            <tr class="conhover">
				<td class="color_status">
					<xsl:value-of select="CONTADOR"/>
				</td>
				<td class="textCenter">
					<a>
					<xsl:attribute name="href">javascript:MostrarRegistro('<xsl:value-of select="ENLACE"/>');</xsl:attribute>
					<xsl:value-of select="FECHA"/>
					</a>
				</td>
				<td class="textCenter">
					<a>
					<xsl:attribute name="href">javascript:MostrarRegistro('<xsl:value-of select="ENLACE"/>');</xsl:attribute>
					<xsl:value-of select="CODIGO"/>
					</a>
				</td>
				<xsl:if test="/ListadoEIS/INDICADOR/INCLUIR_LICITACION">
	    			<td>
						<xsl:if test="IDLICITACION!=''">
							<a href="http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={IDLICITACION}" target="Licitacion"><xsl:value-of select="CODLICITACION"/></a>
						</xsl:if>
					</td>
	        	</xsl:if>
				<td class="textLeft">
					<xsl:value-of select="CENTRO"/>
				</td>
				<td class="textLeft">
					<xsl:value-of select="EMPRESA2"/>
				</td>
				<td class="textLeft">
					<a>
					<xsl:attribute name="href">javascript:MostrarRegistro('<xsl:value-of select="ENLACE"/>');</xsl:attribute>
					<xsl:value-of select="ESTADO"/>
					</a>
				</td>
				<td class="textRight">
					<xsl:value-of select="TOTAL"/>&nbsp;&nbsp;&nbsp;
				</td>
            </tr>
			</xsl:for-each> 
            <tr class="claro">
				<td class="color_status">&nbsp;</td>
				<td align="right">
					<xsl:attribute name="colspan">
				    <xsl:choose>
						<xsl:when test="/ListadoEIS/INDICADOR/INCLUIR_LICITACION">6</xsl:when>
						<xsl:otherwise>5</xsl:otherwise>
				    </xsl:choose> 
					</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/> :
                </td>
				<td align="right">
					<xsl:value-of select="ListadoEIS/INDICADOR/REGISTROS/TOTAL"/>&nbsp;&nbsp;&nbsp;
				</td>
            </tr>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td>
				<xsl:attribute name="colspan">
				<xsl:choose>
					<xsl:when test="/ListadoEIS/INDICADOR/INCLUIR_LICITACION">8</xsl:when>
					<xsl:otherwise>7</xsl:otherwise>
				</xsl:choose> 
				</xsl:attribute>&nbsp;
			</td></tr>
		</tfoot>
		</table> 
		</div>
	</div><!--fin de divLeft-->
	</xsl:otherwise>
    </xsl:choose> 
    </body>
    </html>
</xsl:template>  
</xsl:stylesheet>
