<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Listado de resgistros desde el reumen mensual del EIS
	Ultima revision: ET 13set21 9:35
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
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
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
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
				
		MostrarPag(Enlace, 'Registro');
	}
/* 
	13set21 Sustituimos esta funcion por una que genera directamente el listado           
    function DescargarExcel(){
        var v_ORIGEN = jQuery('#ORIGEN').val();
        var v_SQL= encodeURIComponent(' ' + jQuery('#SQL').val().replace(/'/g,"''"));

        jQuery.ajax({
                url: 'http://www.newco.dev.br/Gestion/EIS/Exceles.xsql',
                data: "ORIGEN="+v_ORIGEN+"&SQL="+v_SQL,
                type: "GET",
                contentType: "application/xhtml+xml",
                beforeSend: function(){
                        null;
                },
                error: function(objeto, quepaso, otroobj){
                        alert('error'+quepaso+' '+otroobj+''+objeto);
                },
                success: function(objeto){
                        var data = eval("(" + objeto + ")");

                        if(data.estado == 'ok')
                                window.location='http://www.newco.dev.br/Descargas/'+data.url;
                        else
                                alert('Se ha producido un error. No se puede descargar el fichero.');
                }
        });

	}
*/
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
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="/ListadoEIS/INDICADOR/NOMBREINDICADOR"/></span>
				<span class="CompletarTitulo">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizado']/node()"/>: <xsl:value-of select="ListadoEIS/INDICADOR/ACTUALIZACION"/>
				</span>
			</p>
			<p class="TituloPagina">
				<xsl:value-of select="/ListadoEIS/INDICADOR/TITULO"/>
				<span class="CompletarTitulo" style="width:200px;">
					<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" /></a>
					&nbsp;
					<a class="btnNormal" href="javascript:print();">Imprimir</a>
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
        <table class="buscador">
	    <tr class="subTituloTabla">	      
	    	<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='contador']/node()"/></td>
	    	<td><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/> </td>
	    	<td><xsl:value-of select="document($doc)/translation/texts/item[@name='numero']/node()"/> </td>
			<xsl:if test="/ListadoEIS/INDICADOR/INCLUIR_LICITACION">
	    		<td><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/> </td>
	        </xsl:if>
	   		<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/> </td>
	    	<td class="textLeft"><xsl:value-of select="ListadoEIS/INDICADOR/NOMBREEMPRESA2"/></td>
	   		<td class="textLeft veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/> </td>
	    	<td class="textRight diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/> &nbsp;&nbsp;&nbsp;</td></tr>
       		<xsl:for-each select="ListadoEIS/INDICADOR/REGISTROS/REGISTRO">
            <tr class="conhover">
				<td class="textCenter">
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
				<td align="right" colspan="6">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/> :
                </td>
				<td align="right">
					<xsl:value-of select="ListadoEIS/INDICADOR/REGISTROS/TOTAL"/>&nbsp;&nbsp;&nbsp;
				</td>
            </tr>
		</table> 
		<!--
		<br/>
		<br/>
		<div class="divCenter20">
            <div class="boton">
            <a href="javascript:Imprimir();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/> </a>            
            </div>
		</div>-->
		</div><!--fin de divLeft-->
		</xsl:otherwise>
      </xsl:choose> 
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
