<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Buscador de prodcutos en el catalogo de proveedores utilizado desde el primer paso de Evaluacion de producto. Nuevo disenno 2022.
	Ultima revision ET 12may22 11:10
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Lista/form/LANG"><xsl:value-of select="/Lista/form/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<title></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
    <!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/BuscaProd.js"></script>

	<script type="text/javascript">
		var error_buscador_min_char	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_error_min_char']/node()"/>';
		var confirm_buscador_continuar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_confirm_continuar']/node()"/>';
	</script>
        
        <xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--

	function Busqueda(formu,accion){

	if((formu.elements['LLP_NOMBRE'].value=='') && (formu.elements["SIN_STOCKS"].checked==false) && (formu.elements['FIDProveedor'].value =='' || formu.elements['FIDProveedor'].value == '-1')){
		alert(document.forms['mensajeJS'].elements['INTRODUZCA_CRITERIO_BUSQUEDA'].value);
	}else{
        var sinStock = '';
        var nombreProd = formu.elements['LLP_NOMBRE'].value;
        var provee = formu.elements['FIDProveedor'].value;
        if (formu.elements["SIN_STOCKS"].checked == true){
            var sinStock = 'S';
            }

        if (formu.elements["ORIGEN"].value == 'OFERTASTOCK'){
            formu.action = "BuscarProveedoresEval2022.xsql?NOMBRE_PROD="+nombreProd+"&PROVEE="+provee+"&SIN_STOCK="+sinStock+"&ORIGEN=OFERTASTOCK";
        }
        else if (formu.elements["ORIGEN"].value == 'EVAL'){
            formu.action = "BuscarProveedoresEval2022.xsql?NOMBRE_PROD="+nombreProd+"&PROVEE="+provee+"&SIN_STOCK="+sinStock+"&ORIGEN=EVAL";
        }
        else if (formu.elements["ORIGEN"].value == 'SOLICITUD'){
            formu.action = "BuscarProveedoresEval2022.xsql?NOMBRE_PROD="+nombreProd+"&PROVEE="+provee+"&SIN_STOCK="+sinStock+"&ORIGEN=SOLICITUD";
        }
        else{
            formu.action = "BuscarProveedoresEval2022.xsql?NOMBRE_PROD="+nombreProd+"&PROVEE="+provee+"&SIN_STOCK="+sinStock;
            }
			SubmitForm(formu);
		}
	}
        
    function Navega(formu,NombreCampo,pagina){
        //guardamos la ultima pagina en el campo oculto ULTIMAPAG.
        formu.elements['ULTIMAPAGINA'].value=pagina;
		SubmitForm(formu);
	}

	function handleKeyPress(e){
		var keyASCII;

		if(navigator.appName.match('Microsoft'))
			keyASCII=event.keyCode;
		else
			keyASCII = (e.which);

		if(keyASCII == 13)
			Busqueda(document.forms[0],'');
	}

	// Asignamos la función handleKeyPress al evento
	if(navigator.appName.match('Microsoft')==false)
		document.captureEvents();
	document.onkeypress = handleKeyPress;


	function EnviarBusqueda(){
		if(LimitarCantidadPalabras(document.forms[0].elements['LLP_NOMBRE'],5)){
			var longMax = CalcularLongMaxPalabra(document.forms[0].elements['LLP_NOMBRE']);

			if(document.forms[0].elements['LLP_NOMBRE'].value.length != 0 && longMax < 3){
				alert(error_buscador_min_char);
			}else if(longMax == 3){
				if(confirm(error_buscador_min_char + '\n' + confirm_buscador_continuar))
					Busqueda(document.forms[0],'');
			}else{
				Busqueda(document.forms[0],'');
			}
		}
	}

	function LimitarCantidadPalabras(obj,numPalabras){
		var nombreCampo;

		if(obj.name=='LLP_NOMBRE')
			nombreCampo='Producto';
		/*else
			if(obj.name=='LLP_PROVEEDOR')
				nombreCampo='Proveedor';*/

		var numEspacios=0;
		obj.value=obj.value.trim();

		for(var n=0;n<obj.value.length;n++){
			if(obj.value.substring(n,n+1)==' '){
				numEspacios++;
			}
			if(numEspacios>=numPalabras){
				var cadTemp=obj.value.substring(0,n);
				if(confirm(document.forms['mensajeJS'].elements['CRITERIO_DEMASIADO_LARGO'].value)){
					obj.value=obj.value.substring(0,n);
					return true;
				}else{
					return false;
				}
			}
		}
		return true;
	}
        
        //cuando cambio proveedor o marca
        function CambioRestriccion(){
            var form=document.forms['Productos'];
            form.elements['ULTIMAPAGINA'].value=0; 
            SubmitForm(form);
        }
            
	// Funcion que recorre todas las palabras de un input text y calcula longitud de la mas larga
	function CalcularLongMaxPalabra(obj){
		var aPalabras = new Array();
		var maxLength = 0;

		aPalabras = obj.value.split(' ');

		for(var i=0; i<aPalabras.length; i++){
			aPalabras[i] = aPalabras[i].trim();
			if(aPalabras[i].length > maxLength)
				maxLength = aPalabras[i].length;
		}

		return maxLength;
	}

	//	7dic10	Si se selecciona el catalogo de proveedores activamos el check de "sin stock"
	function CambioCatalogo(){
		var form=document.forms[0];
		if((form.elements["LLP_LISTAR"].value=='PRO')||(form.elements["LLP_LISTAR"].value=='PLA'))
			form.elements["SIN_STOCKS"].disabled=false;
		else
			form.elements["SIN_STOCKS"].disabled=true;
	}
            

    //insertar la ref producto en campo input de nueva evaluacion producto
   function InsertarPROEvaluacion(prove,ref_prove,descr_prove,id_producto){

            var objFrameTop=new Object();  
            objFrameTop=window.opener.top;
            objFrameTop=window.opener.top;
            var FrameOpenerName=window.opener.name;
            var objFrame=new Object();

            objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
		//alert (objFrameTop.name);
		//alert (objFrame.name);
		//inserto ref en campo input referencia
		var form = objFrame.document.forms['EvaluacionProducto'];
		form.elements['PROVEEDOR'].value = prove;
                    form.elements['REF_PROV'].value = ref_prove;
                    form.elements['DESCR_PROV'].value = descr_prove;
                    form.elements['ID_PROD'].value = id_producto;

                    objFrame.document.getElementById("descrProd").style.display = '';
                    objFrame.document.getElementById("refProv").style.display = '';
                    objFrame.document.getElementById("provee").style.display = '';

		window.close();
	 } 

    //insertar la ref producto en campo input de nueva oferta de stock
    function InsertarPROstockOferta(prove,ref_prove,id_producto, pro_nombre){

        var objFrameTop=new Object();  
        objFrameTop=window.opener.top;
        objFrameTop=window.opener.top;
        var FrameOpenerName=window.opener.name;
        var objFrame=new Object();

        objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
	//alert (objFrameTop.name);
	//alert (objFrame.name);
	//inserto ref en campo input referencia
	var form = objFrame.document.forms['frmStockOfertaID'];
                form.elements['STOCK_PRODUCTO'].value = pro_nombre;
                form.elements['STOCK_ID_PROD'].value = id_producto;

	window.close();
 	} 
		


    //insertar la ref producto en campo input de una solicitud de catalogación        
    function InsertarPROSolicitud(prove,ref_prove,id_producto,solProdID){

        var objFrameTop=new Object();  
        objFrameTop=window.opener.top;
        var FrameOpenerName=window.opener.name;
        var objFrame=new Object();

        objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
		//alert (objFrameTop.name);
		//alert (objFrame.name);
		//inserto ref en campo input referencia
		var form = objFrame.document.forms['SolicitudCatalogacion'];

        form.elements['PROVE_CAT_'+solProdID].value = prove;
        form.elements['REF_PROV_'+solProdID].value = ref_prove;
        form.elements['IDPROD_'+solProdID].value = id_producto;

        window.opener.top.anadirProductoConID(id_producto,solProdID);

		window.close();
	}   


    function OrdenarPor(Orden){
        var form=document.forms['Productos'];
        if (form.elements['ORDEN'].value==Orden)
        {
                if (form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';

                else  form.elements['SENTIDO'].value='ASC';
        }
        else
        {
                form.elements['ORDEN'].value=Orden; 
                form.elements['SENTIDO'].value='ASC';
        }	
        form.elements['ULTIMAPAGINA'].value=0; 
        SubmitForm(form);
    }
       
            
            
	//-->
	</script>
	]]></xsl:text>
	
	
</head>
<body> <!-- onLoad="ActivarAccion(); return true;"-->
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Lista/form/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">

		<form name="Busqueda" method="POST">
		<!--	Orden alfabetico en la busqueda		-->
		<input type="hidden" name="LLP_ORDERBY" value="ALF"/>
		<input type="hidden" name="LLP_LISTAR"/>
		<input type="hidden" name="TIPO_BUSQUEDA" value="RAPIDA"/>
		<input type="hidden" name="SOL_PROD_ID" value="{/Lista/SOL_PROD_ID}"/>
		<input type="hidden" name="ORIGEN" value="{/Lista/ORIGEN}"/>
		<input type="hidden" name="FIDProveedor"/>
		<input type="hidden" name="SIN_STOCKS"/>
		<input type="hidden" name="SOLO_VISIBLES"/>
		<input type="checkbox" name="CHECK_LISTADO_PLANTILLA" style="display:none;" />

		<br/>
		<table cellspacing="6px" cellpadding="6px">
		<tr>
        	<td>&nbsp;</td>
			<td class="w300px">  
			<xsl:choose>
    			<xsl:when test="/Lista/DESCRIPCION !=''">
        			<input type="text" name="LLP_NOMBRE" class="campopesquisa w300px" maxlength="100" value="{/Lista/DESCRIPCION}" />
				</xsl:when>
    			<xsl:otherwise>
        			<input type="text" name="LLP_NOMBRE" class="campopesquisa w300px" maxlength="100" value="{/Lista/NOMBRE_PROD}" />
    			</xsl:otherwise>
			</xsl:choose>
			</td>
			<td class="w100px">
				<a class="btnDestacado" href="javascript:EnviarBusqueda();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</td>
        	<!--<td>
            	<xsl:if test="/Lista/form/BUSCADOR/ADMIN or /Lista/form/BUSCADOR/MVM or /Lista/form/BUSCADOR/MVMB">
                	<div class="boton" style="margin-top:10px;">
                	<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten2022.xsql','Mantenimiento Producto',100,80,0,0);">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
                	</a>
                	</div>
            	</xsl:if>
        	</td>-->
        	<td>&nbsp;</td>
        </tr>  
        <tr>
            <td class="buscaLeftCorto">&nbsp;</td>
            <td colspan="3">&nbsp;</td>
            <td class="buscaRightCorto">&nbsp;</td>
        </tr>
        </table>
       
          
			
      </form>  
      
		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
		<input type="hidden" name="INTRODUZCA_CRITERIO_BUSQUEDA" value="{document($doc)/translation/texts/item[@name='introduzca_criterio_busqueda']/node()}"/>
		<input type="hidden" name="CRITERIO_DEMASIADO_LARGO" value="{document($doc)/translation/texts/item[@name='criterio_demasiado_largo']/node()}"/>
		</form>

      </div><!--fin de divLeft-->     
      
      <!--lista productos proveedores-->
      <xsl:if test="Lista/form/ROWSET/ROW">
       <form name="Productos" method="post" action="BuscarProveedoresEval2022.xsql">    
		<input type="hidden" name="ORDEN" value="{/Lista/form/ROWSET/ORDEN}" />
		<input type="hidden" name="SENTIDO" value="{/Lista/form/ROWSET/SENTIDO}" />
		<input type="hidden" name="xml-stylesheet" value="{../xml-stylesheet}"/>           
		<input type="hidden" name="STOCKS_ACCION" value="" />
		<input type="hidden" name="STOCKS_IDPRODUCTO" value="" />
		<input type="hidden" name="STOCKS_COMENTARIOS" value="" />
        <input type="hidden" name="EMPLANTILLAR" value="" />
        <input type="hidden" name="IDPRODUCTO" value="{/Lista/form/ROWSET/IDPRODUCTO}" />
        <input type="hidden" name="STOCKS_TIPO" />
        <input type="hidden" name="SIN_STOCKS" value="{/Lista/form/ROWSET/TEXTO_SIN_STOCK}" />
        <input type="hidden" name="STOCKS_REF_ALT" value="{/Lista/form/ROWSET/REFERENCIAALTERNATIVA}" />
        <input type="hidden" name="STOCKS_PROD_ALT" value="{/Lista/form/ROWSET/DESCRIPCIONALTERNATIVA}" />
        <input type="hidden" name="SOL_PROD_ID" value="{/Lista/SOL_PROD_ID}"/>
        <input type="hidden" name="ORIGEN" value="{/Lista/ORIGEN}" />
      
		<input type="hidden" name="SELECCIONARTOTAL"><!--	utilizado en la paginación		-->
			<xsl:attribute name="value"><xsl:value-of select="Lista/form/SELECCIONARTOTAL"/></xsl:attribute>
		</input> 
		<input type="hidden" name="ULTIMAPAGINA">
			<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/BUTTONS/ACTUAL/@PAG"/></xsl:attribute>
		</input>   
        <input type="hidden" name="SOLO_VISIBLES">
			<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/SOLOVISIBLES"/></xsl:attribute>
		</input>   
        <input type="hidden" name="GRUPOPRODUCTOS">
			<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/GRUPOPRODUCTOS"/></xsl:attribute>
		</input>   

	<div class="divLeft">
		<p class="textRight fuentePeq">
			<xsl:if test="Lista/form/ROWSET/BUTTONS/ATRAS">
				<a class="btnNormal" href="javascript:Navega(document.forms['Productos'],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ATRAS/@PAG});"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
			</xsl:if>&nbsp;
			<xsl:if test="Lista/form/ROWSET/BUTTONS/ADELANTE">
				<a class="btnNormal" href="javascript:Navega(document.forms['Productos'],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ADELANTE/@PAG});"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
			</xsl:if>

			<!-- Pagina 1 de 10 -->
			<xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>
			<span class="textoForm"><xsl:value-of select="(Lista/form/ROWSET/BUTTONS/ACTUAL/@PAG)+1"/></span>
			&nbsp;de&nbsp;
			<span class="textoForm"><xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_PAGINAS"/></span>
			<b>&nbsp;|&nbsp;</b>
			<!-- 100 Productos -->
			<span class="textoForm"><xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_FILAS"/></span>
			<xsl:choose>
			<xsl:when test="Lista/form/ROWSET/TOTALES/TOTAL_FILAS[.>1]">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
				<b>&nbsp;|&nbsp;</b><xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_PROVEEDORES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/>
				<b>&nbsp;|&nbsp;</b><xsl:value-of select="Lista/form/ROWSET/TOTALES/TOTAL_MARCAS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
			</xsl:otherwise>
			</xsl:choose>&nbsp;&nbsp;&nbsp;&nbsp;
			<xsl:if test="Lista/form/ROWSET/BUTTONS/ATRAS">
				<a class="btnNormal" href="javascript:Navega(document.forms['Productos'],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ATRAS/@PAG});"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
			</xsl:if>&nbsp;
			<xsl:if test="Lista/form/ROWSET/BUTTONS/ADELANTE">
				<a class="btnNormal" href="javascript:Navega(document.forms['Productos'],'CANTIDAD_UNI',{Lista/form/ROWSET/BUTTONS/ADELANTE/@PAG});"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
			</xsl:if>&nbsp;&nbsp;&nbsp;&nbsp;

			<xsl:variable name="IDAct">nulo</xsl:variable>
		</p>
    <div>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr class="titulos">
			<th class="w1px"></th>
			<th class="w1px">&nbsp;</th>
			<th>
				<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
				<xsl:choose>
                               
				<xsl:when test="/Lista/form/ROWSET/GRUPOPRODUCTOS!=''">
					: <input type="textbox" name="LLP_NOMBRE" width="20">
						<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/PRODUCTO"/></xsl:attribute>
					</input>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="LLP_NOMBRE">
						<xsl:attribute name="value"><xsl:value-of select="Lista/form/ROWSET/PRODUCTO"/></xsl:attribute>
					</input>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="/Lista/form/ROWSET/GRUPOPRODUCTOS!=''">
					<xsl:text>&nbsp;</xsl:text>
					<a href="javascript:BuscadorCatalogoEspecializado(document.forms[0]);"><img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Boton Buscar" title="Buscar en Catalogo"/></a>
					<!--<div class="botonMenu">
						&nbsp;<a href="javascript:Enviar();" style="text-decoration:none;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>&nbsp;
					</div>-->
				</xsl:if>
			</th>
			<th class="textLeft">
				<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a><br/>
				<!--	proveedor	-->
				<xsl:if test="/Lista/form/ROWSET/FIDProveedor/field">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Lista/form/ROWSET/FIDProveedor/field"/>
						<xsl:with-param name="onChange">javascript:CambioRestriccion();</xsl:with-param>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
			<th class="w150px">
				<a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a><br/>
				<!--	marca	-->
				<xsl:if test="/Lista/form/ROWSET/FMarca/field">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Lista/form/ROWSET/FMarca/field"/>
						<xsl:with-param name="onChange">javascript:CambioRestriccion();</xsl:with-param>
						<xsl:with-param name="claSel">w150px</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</th>
			
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">

		<xsl:apply-templates select="Lista/form/ROWSET/ROW"/>

		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
 	</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  

 	</div>
  </form>
  </xsl:if>
   
</body>      
     
</html>   
 </xsl:template>
 
 <xsl:template match="ROW">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Lista/LANG"><xsl:value-of select="/Lista/LANG" /></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<tr>
		<td>
            <xsl:choose>
                <!--si sol_prod_id no vacío venimos de solicitud => insertamos en solicitud-->
                <xsl:when test="/Lista/SOL_PROD_ID != '' or /Lista/ORIGEN = 'SOLICITUD'">
                    <a class="btnDiscreto" href="javascript:InsertarPROSolicitud('{PROVEEDOR}','{REFERENCIA_PROVEEDOR}','{PRO_ID}','{/Lista/SOL_PROD_ID}');">
                       <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    </a>
                </xsl:when>
                <xsl:when test="/Lista/ORIGEN = 'EVAL'">
                    <a class="btnDiscreto" href="javascript:InsertarPROEvaluacion('{PROVEEDOR}','{REFERENCIA_PROVEEDOR}','{PRO_NOMBRE}','{PRO_ID}');">
                       <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    </a>
                </xsl:when>
                <xsl:when test="/Lista/ORIGEN = 'OFERTASTOCK'">
                    <a class="btnDiscreto" href="javascript:InsertarPROstockOferta('{PROVEEDOR}','{REFERENCIA_PROVEEDOR}','{PRO_ID}','{PRO_NOMBRE}');">
                       <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                     <a class="btnDiscreto" href="javascript:InsertarPROEvaluacion('{PROVEEDOR}','{REFERENCIA_PROVEEDOR}','{PRO_NOMBRE}','{PRO_ID}');">
                       <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
                    </a>
                </xsl:otherwise>
            </xsl:choose>
		</td>
		<td>
			<xsl:if test="OCULTO and /Lista/form/ROWSET/GRUPOPRODUCTOS = ''">
				<img src="http://www.newco.dev.br/images/prodOculto.gif" alt="Oculto" title="Oculto" style="margin-top:1px;"/>
			</xsl:if>
		</td>
		<td class="textLeft">
			<a>  
				<xsl:attribute name="href">javascript:FichaProducto('<xsl:value-of select="PRO_ID"/>');</xsl:attribute>
				<span class="strongAzul"><xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/></span>
			</a>
		</td>
		<td class="textLeft">
			<xsl:value-of select="PROVEEDOR"/>
		</td>
		<td class="tres" align="center">
			<xsl:value-of select="REFERENCIA_PROVEEDOR"/>
		</td>
		<td align="center">
			<xsl:if test="PRO_MARCA!=''">
				<xsl:value-of select="substring(PRO_MARCA,1,15)"/>
			</xsl:if>
		</td>
	</tr>
</xsl:template>

<!--
 |	Los caracteres extraños vienen codificados de la base de datos, hemos de poner:
 |	disable-output-escaping="yes"
 +-->

<xsl:template match="ATRAS">
    <xsl:variable name="code-img-on">DB-Anterior_mov</xsl:variable>
    <xsl:variable name="code-img-off">DB-Anterior</xsl:variable>
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>
	  <a>
            <xsl:attribute name="href">javascript:Navega(document.forms['Productos'],'CANTIDAD_UNI','<xsl:value-of select="@PAG"/>');</xsl:attribute>
            <xsl:attribute name="onMouseOver">cambiaImagen('Anterior','<xsl:value-of select="$draw-on"/>');window.status='Retroceder pagina';return true</xsl:attribute>
            <xsl:attribute name="onMouseOut">cambiaImagen('Anterior','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
            <img name="Anterior" alt="Pagina anterior" border="0" src="{$draw-off}"/>
          </a>
          <br/>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0110' and @lang=$lang]" disable-output-escaping="yes"/>
</xsl:template>
	          
<xsl:template match="ADELANTE">	  		  
    <xsl:variable name="code-img-on">DB-Siguiente_mov</xsl:variable>
    <xsl:variable name="code-img-off">DB-Siguiente</xsl:variable>    
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>   
    <a>	    
      <xsl:attribute name="href">javascript:Navega(document.forms['Productos'],'CANTIDAD_UNI','<xsl:value-of select="@PAG"/>');</xsl:attribute>
      <xsl:attribute name="onMouseOver">cambiaImagen('Siguiente','<xsl:value-of select="$draw-on"/>');window.status='Avanzar pagina';return true</xsl:attribute>
      <xsl:attribute name="onMouseOut">cambiaImagen('Siguiente','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
      <img name="Siguiente" alt="Siguiente pagina" border="0" src="{$draw-off}"/>
    </a>
    <br/>
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0100' and @lang=$lang]" disable-output-escaping="yes"/>
</xsl:template> 

</xsl:stylesheet>

