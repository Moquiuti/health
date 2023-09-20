<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Buscador en "Enviar pedidos"
	Ultima revisión ET 21feb19 13:53
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
			<xsl:when test="/BusquedaProductos/LANG"><xsl:value-of select="/BusquedaProductos/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/BuscaProd.js"></script>

	<script type="text/javascript">
		var error_buscador_min_char	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_error_min_char']/node()"/>';
		var confirm_buscador_continuar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_confirm_continuar']/node()"/>';
	</script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--

	function Linka(pag){
		parent.frames['zonaTrabajo'].document.location.href=pag;
	}

	function Busqueda(formu,accion){
		if(formu.elements['CHECK_LISTADO_PLANTILLA'].checked == true){
			formu.elements['LLP_LISTAR'].value = 'PLA';
		}else{
			formu.elements['LLP_LISTAR'].value = 'PRO';
		}

		if(formu.elements['LLP_LISTAR'].value=='PLA'){
			AsignarAccion(formu,'../Multioferta/BuscadorCatalogoPrivado.xsql?DONDE_SE_BUSCA='+formu.elements['LLP_LISTAR'].value);
			SubmitForm(formu);
		}else{
			if(formu.elements['LLP_LISTAR'].value=='CP'){
				AsignarAccion(formu,'../Multioferta/BuscadorCatalogoPrivadoAdjudicado.xsql?DONDE_SE_BUSCA='+formu.elements['LLP_LISTAR'].value);
				SubmitForm(formu);
			}else{
				if(formu.elements['LLP_LISTAR'].value=='NOPLA'){
					AsignarAccion(formu,'../Multioferta/BuscadorCatalogoPrivadoAdjudicado.xsql?ENPLANTILLADO=N&DONDE_SE_BUSCA='+formu.elements['LLP_LISTAR'].value);
					SubmitForm(formu);
				}else{
					if((formu.elements['LLP_NOMBRE'].value=='') && (formu.elements["SIN_STOCKS"].checked==false) && (formu.elements['FIDProveedor'].value =='' || formu.elements['FIDProveedor'].value == '-1')){
						alert(document.forms['mensajeJS'].elements['INTRODUZCA_CRITERIO_BUSQUEDA'].value);
					}else{
						if(formu.elements['LLP_LISTAR'].value=='EMP'){
							AsignarAccion(formu,'../Multioferta/P3Empresas.xsql');
							SubmitForm(formu);
						}else{
							AsignarAccion(formu,'../Multioferta/ListaProductos.xsql');
							SubmitForm(formu);
						}
					}
				}
			}
		}
	}

/*
	// Permite manipular los checkbox como si fueran 'Radio'
	function ValidarCheckBox(formu,seleccionado){
		for(var i=0;i<formu.elements.length;i++){
			if(formu.elements[i].type=="checkbox")
				if(formu.elements[i].name != seleccionado)
					formu.elements[i].checked=false;
				else
					formu.elements[i].checked=true;
		}

		// Por defecto buscamos productos.
		formu.elements['LLP_LISTAR'].value = 'PRO';

		if(seleccionado == 'BuscarProveedores'){
			formu.elements['LLP_LISTAR'].value = 'EMP';
		}
	}
*/

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
		obj.value=quitarEspacios(obj.value);

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

	// Funcion que recorre todas las palabras de un input text y calcula longitud de la mas larga
	function CalcularLongMaxPalabra(obj){
		var aPalabras = new Array();
		var maxLength = 0;

		aPalabras = obj.value.split(' ');

		for(var i=0; i<aPalabras.length; i++){
			aPalabras[i] = quitarEspacios(aPalabras[i]);
			if(aPalabras[i].length > maxLength)
				maxLength = aPalabras[i].length;
		}

		return maxLength;
	}

/*	8oct09	ET	No presentamos la lista de clientes
	function MostrarOcultarListaEmpresas(){
		if(document.forms[0].elements["LLP_LISTAR"].value=='PLA'){
			//	mostrar desplegable empresas
			document.getElementById("TD_CLIENTES").style.display='block';
		}else{
			//	ocultar desplegable empresas
			document.getElementById("TD_CLIENTES").style.display='none';
		}
	}
*/

	//	7dic10	Si se selecciona el catalogo de proveedores activamos el check de "sin stock"
	function CambioCatalogo(){
		var form=document.forms[0];
		if((form.elements["LLP_LISTAR"].value=='PRO')||(form.elements["LLP_LISTAR"].value=='PLA'))
			form.elements["SIN_STOCKS"].disabled=false;
		else
			form.elements["SIN_STOCKS"].disabled=true;
	}
	//-->
	</script>
	]]></xsl:text>
</head>
<body> <!-- onLoad="ActivarAccion(); return true;"-->
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/BusquedaProductos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div>
	<xsl:attribute name="class">
		<xsl:choose>
		<xsl:when test="/BusquedaProductos/BUSCADOR/MVMB or /BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES or /BusquedaProductos/BUSCADOR/NOCDC or /BusquedaProductos/BUSCADOR/REDUCIDA or /BusquedaProductos/BUSCADOR/GERENTE">divLeft</xsl:when>
		<xsl:otherwise>divLeft40</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>

		<form action="" name="Busqueda" method="POST" target="zonaTrabajo">
			<!--	Orden alfabetico en la busqueda		-->
			<input type="hidden" name="LLP_ORDERBY" value="ALF"/>
			<input type="hidden" name="LLP_LISTAR"/>
			<input type="hidden" name="TIPO_BUSQUEDA" value="RAPIDA"/>

			<!--<table class="busca" border="0">-->
			<table class="buscador" border="0"><!-- class="muyoscuro"-->
			<tr class="filtros">
				<td width="10px" style="text-align:left;">  
                </td>
				<td style="width:210px;text-align:left;">  
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
                    <xsl:choose>
                        <!--si descripcion no esta vacía, pongo el valor en campo texto-->
                        <xsl:when test="/BusquedaProductos/DESCRIPCION != ''">
                            <input type="text" class="grande" name="LLP_NOMBRE" maxlength="200" size="30" style="font-size:14px;width:200px;" value="{/BusquedaProductos/DESCRIPCION}" />
                        </xsl:when>
                        <xsl:otherwise>
                            <input type="text" class="grande" name="LLP_NOMBRE" maxlength="200" size="30" style="font-size:14px;width:200px;"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
                <!--todos usuarios ven desple proveedor-->
                <td style="width:140px;text-align:left;">   
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/BusquedaProductos/BUSCADOR/PROVEEDORES/field"/>
						<xsl:with-param name="style">font-size:14px;width:200px;</xsl:with-param>
      				</xsl:call-template>
				</td>
                <td style="width:140px;text-align:left;">
                	<!--para todos casi enseño, si es asisa no-->
                	<xsl:attribute name="class">
                    	<xsl:choose>
                    	<xsl:when test="/BusquedaProductos/BUSCADOR/MVMB or /BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES or /BusquedaProductos/BUSCADOR/NOCDC or /BusquedaProductos/BUSCADOR/REDUCIDA or /BusquedaProductos/BUSCADOR/GERENTE">doce</xsl:when>
                    	<xsl:otherwise>tres</xsl:otherwise>
                    	</xsl:choose>
                	</xsl:attribute> 
				    <!--sin stock-->
                    <p class="textLeft">
                    <xsl:choose>
     	      		<!--<xsl:when test="/BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES or /BusquedaProductos/BUSCADOR/GERENTE"> quitado si es gerente el5-11-13 para cdc viamed-->
                    <xsl:when test="/BusquedaProductos/BUSCADOR/MVMB or /BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES">
						<input class="muypeq" type="checkbox" name="SIN_STOCKS"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></label>
					</xsl:when>
					<xsl:otherwise>
		     	   		<input type="hidden" name="SIN_STOCKS"/>
					</xsl:otherwise>
					</xsl:choose>	
                    </p>
				</td>
                <td style="width:180px;text-align:left;">
                	<xsl:attribute name="class">
                     <xsl:choose>
     	      			<xsl:when test="/BusquedaProductos/BUSCADOR/MVMB or /BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES or /BusquedaProductos/BUSCADOR/GERENTE or /BusquedaProductos/BUSCADOR/NOCDC or /BusquedaProductos/BUSCADOR/REDUCIDA">veinte</xsl:when>
                        <xsl:otherwise>uno</xsl:otherwise>
                     </xsl:choose>
                    </xsl:attribute>
                	<!--solo visibles
                    <p>
                    <xsl:choose>
     	      		<xsl:when test="/BusquedaProductos/BUSCADOR/MVMB or /BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES">
						<input class="muypeq" type="checkbox" name="SOLO_VISIBLES"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_visibles']/node()"/></label>
					</xsl:when>
					<xsl:otherwise>
		     	   		<input type="hidden" name="SOLO_VISIBLES"/>
					</xsl:otherwise>
					</xsl:choose>	
                    </p>
					-->
                    
                    <!--checkbox si plantillas o catalogo prove-->
                    <p> <!--class="textLeft"-->
                    <xsl:choose>
					<!--28oct16	<xsl:when test="/BusquedaProductos/BUSCADOR/MVMB or /BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES or /BusquedaProductos/BUSCADOR/NOCDC or /BusquedaProductos/BUSCADOR/REDUCIDA">-->
					<xsl:when test="/BusquedaProductos/BUSCADOR/MVMB or /BusquedaProductos/BUSCADOR/MVM or /BusquedaProductos/BUSCADOR/NAVEGAR_PROVEEDORES">
                    	<input class="muypeq" type="checkbox" name="CHECK_LISTADO_PLANTILLA" />&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_en_plantillas']/node()"/></label>
					</xsl:when>
                    <!--si es asisa no enseño el buscador
					<xsl:when test="/BusquedaProductos/BUSCADOR/CDC">	
                    	<input type="checkbox" name="CHECK_LISTADO_PLANTILLA" style="display:none;">
                        <xsl:attribute name="checked">true</xsl:attribute>
                        </input>
					</xsl:when>-->
                    <xsl:otherwise>
                    	<input class="peq" type="checkbox" name="CHECK_LISTADO_PLANTILLA" style="display:none;">
                        <xsl:attribute name="checked">true</xsl:attribute>
                        </input>
                    </xsl:otherwise>
					</xsl:choose>
                	</p>
                </td>
				<!--<td class="aster">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_marca']/node()"/>:</label><br/>
					<input type="text" name="LLP_PROVEEDOR" maxlength="200" size="25"/>
				</td>-->
					
			
				<td style="width:140px;text-align:left;">
					<a class="btnDestacado" href="javascript:EnviarBusqueda();" onMouseOver="window.status='Buscar'; return true;" onMouseOut="window.status=''; return true;">
					<!--<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Boton Buscar" title="Buscar en MedicalVM" id="buscarPedido" style="vertical-align:middle; margin-top:10px;"/>-->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</td>
                <td>&nbsp;</td>
			</tr>  
            <!--<tr>
            <td>&nbsp;</td>
            <td colspan="5">&nbsp;</td>
            <td>&nbsp;</td>
            </tr>-->
        </table>
       
          
			
      </form>  
      
         <!--form de mensaje de error de js-->
                   <form name="mensajeJS">
                        
                        <input type="hidden" name="INTRODUZCA_CRITERIO_BUSQUEDA" value="{document($doc)/translation/texts/item[@name='introduzca_criterio_busqueda']/node()}"/>
                        
                         <input type="hidden" name="CRITERIO_DEMASIADO_LARGO" value="{document($doc)/translation/texts/item[@name='criterio_demasiado_largo']/node()}"/>
                        
                                            
                  </form>
      </div><!--fin de divLeft-->      
   
</body>      
     
</html>   
 </xsl:template>
</xsl:stylesheet>
