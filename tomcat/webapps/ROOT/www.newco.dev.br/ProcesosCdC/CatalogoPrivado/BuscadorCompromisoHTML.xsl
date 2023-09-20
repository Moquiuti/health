<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>
     
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript">
	  <!--

	//	Envia la busqueda en funcion del listado seleccionado
	function Busqueda(formu)
	{
	  	// mostramos un mensaje de alerta si es el listado completo
     	AsignarAccion(formu,'Compromiso.xsql');
	    SubmitForm(formu);
	}
	
	function handleKeyPress(e) {
	  var keyASCII;
	  
	  if(navigator.appName.match('Microsoft'))
	    var keyASCII=event.keyCode;
	  else
            keyASCII = (e.which);
            
          if (keyASCII == 13) {
             Busqueda(document.forms[0]);
          }
        }
        
	// Asignamos la función handleKeyPress al evento 
	if(navigator.appName.match('Microsoft')==false)
	  document.captureEvents();
	document.onkeypress = handleKeyPress;
	
    //cambio de subfamilias segun la familia
	function SeleccionaSubFamilia(familia){
	//alert('SUBFAM '+familia);
	var ACTION="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/SubFamilias.xsql";;
	var post='IDFAMILIA='+familia;
    
	if (familia != -1 && familia!=0) sendRequest(ACTION,handleRequestSubFamilia,post);
    
    if (familia == -1 || familia ==0 ) { 
    	$("#IDSUBFAMILIA").hide(); 
        $("#labelSubFamilia").hide(); 
        document.forms[0].elements['IDSUBFAMILIA'].value = '-1';
        //alert('sf '+document.forms[0].elements['IDSUBFAMILIA'].value);
        }
	}
    
    function handleRequestSubFamilia(req)
	{

		var response = eval("(" + req.responseText + ")");
		var Resultados = new String('');

		if (response.Filtros != '')
		{
			for (var i=0; i < response.Filtros.length; i++) 
			{
				Resultados =Resultados+' <option value="'+response.Filtros[i].Fitro.id+'">'+response.Filtros[i].Fitro.nombre+'</option>';
			}
			//$("#IDSUBFAMILIA").show();
            $("#labelSubFamilia").show();
			$("#IDSUBFAMILIA").html(Resultados);
            document.forms['Busqueda'].elements['IDSUBFAMILIA'].value = '-1';
		}
		return true;
	}
	
	
	      
	  //-->
	</script>
        ]]></xsl:text>
      </head>
      <body>      
      	<!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Buscador/LANG"><xsl:value-of select="/Buscador/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
		<!--idioma fin-->
        <xsl:choose>
        <xsl:when test="Buscador/SESION_CADUCADA">
          <xsl:apply-templates select="Buscador/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="Buscador/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="Buscador/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
			<form name="Busqueda" method="POST" target="Resultados" action="BuscadorCompromiso.xsql">
			<input type="hidden" name="VENTANA" value="{Buscador/VENTANA}"/>
            <div class="divLeft">
            <div class="divLeft15nopa">&nbsp;</div>
            <div class="divLeft65">
			<table class="busca" border="0">
				<tr>
				<td class="buscaLeft">&nbsp;</td>
				<td class="veintecinco"> <xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>:<br/>
					<xsl:call-template name="desplegable">
    					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAFAMILIAS/field"></xsl:with-param>
    					<xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
					</xsl:call-template>				
				</td>
				<td id="labelSubFamilia" style="display:none;" class="veinte">
               <!-- <span id="labelSubFamilia" style="display:none;">
        			<xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>:</span>
					<br/>
					<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" style="width:200px; display:none;"/>-->
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>:
					<br/>
					<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="select200" />
                    
				</td>
				<td> <xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:<br/>
				<input type="text" name="PRODUCTO" maxlength="100" size="15">
					<xsl:attribute name="VALUE">
					<xsl:value-of select="Buscador/BUSCADOR/PRODUCTO"/>
					</xsl:attribute>
				</input>
				</td>
				<td class="quince"> <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:<br/>
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAPROVEEDORES/field"></xsl:with-param>
      				</xsl:call-template>				
				</td>
				<td class="dies">
					<a href="javascript:Busqueda(document.forms[0]);" onMouseOver="window.status='Buscar'; return true;" onMouseOut="window.status=''; return true;"> <img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Boton Buscar" title="Buscar en MedicalVM"/>
					</a>
				</td>
                <td class="buscaRight">&nbsp;</td>
				</tr>
			</table>
           
            </div><!--fin de divLeft70-->
            </div><!--fin de divLeft-->
		</form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
