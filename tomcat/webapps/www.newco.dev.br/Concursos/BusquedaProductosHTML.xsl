<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Estadisticas de acceso de los usuarios en MedicalVM
 |
 |	(c) 12/1/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.concursos.com/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html  xmlns="http://www.w3.org/1999/xhtml">
      <head>
       <title>Material Médico y Material Sanitario: <xsl:value-of select="/Productos/PRODUCTOS/TITULO"/> - ConcursosSanitarios.com</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.concursos.com/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.concursos.com/General/general.js"></script>
	<script type="text/javascript" src="http://www.concursos.com/General/Miscelanea.js"></script>
	<script type="text/javascript" src="http://www.concursos.com/General/loginNew.js"></script>
	<script type="text/javascript" src="http://www.concursos.com/General/Acceso.js"></script>
	<script type="text/javascript" src="http://www.concursos.com/General/validaciones.js"></script>
	<script type="text/javascript">
	  <!--


		]]></xsl:text>
			<xsl:variable name="textoMuestra">[Introduce tu busqueda]</xsl:variable>
			var textoMuestra='<xsl:value-of select="$textoMuestra"/>';
		<xsl:text disable-output-escaping="yes"><![CDATA[

	//	Muestra una nueva ventana con el formulario de contacto
	function Contacto()
	{
		//MostrarPag('./Contacto.html', 'ContactoConcursos');
		MostrarPagPersonalizada('http://www.concursos.com/Contacto.html', 'ContactoConcursos',60,60,0,0);
	}

	//	Muestra una nueva ventana con el formulario de contacto
	function Recomendar()
	{
		MostrarPagPersonalizada('http://www.concursos.com/Recomendar.html', 'RecomendarConcursos',50,90,0,-50);
	}

	//	Muestra una nueva ventana con los datos "acerca de"
	function AcercaDe()
	{
		MostrarPagPersonalizada('http://www.concursos.com/AcercaDe.html', 'AcercaDeConcursos',50,90,0,-50);
	}

	//	Muestra una nueva ventana con los datos de la ayuda
	function Ayuda()
	{
		MostrarPagPersonalizada('http://www.concursos.com/Ayuda.html', 'AyudaConcursos',80,70,0,-50);
	}


	function ValidarNumero(obj,decimales){
          
          if(checkNumberNulo(obj.value,obj)){
            if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
              var valor=parseInt(reemplazaComaPorPunto(obj.value));
              /*
              if(valor<10){
                decimales=4;
              }
              else{
                if(valor<100){
                  decimales=3;
                }
                else{
                  if(valor<1000){
                    decimales=2;
                  }
                  else{
                    decimales=0;
                  }
                }
              
              }
              
              
              obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
			  */
            }
          return true;
          }
          return false;
        }
	
	
	function Busqueda(formu)
	{
		if (formu.elements['PRODUCTO'].value==textoMuestra)
			formu.elements['PRODUCTO'].value='';
		//PresentaCampos(formu);
	    	formu.action='./BusquedaProductos.xsql?PAGINA='+formu.elements['PAGINA'].value;
	    	SubmitForm(formu);
	}

	function BusquedaSinFiltros(formu)
	{
	  
		formu.elements['PAGINA'].value='0';
		if (formu.elements['NUMEROPRODUCTOS'].value>0)
		{
			//formu.elements['CENTRO'].value='';
			//formu.elements['PROVEEDOR'].value='';
			//formu.elements['FAMILIA'].value='';
			//formu.elements['ANNO'].value='';		//ET 28/10/2003 Ya no utilizamos este desplegable
			//formu.elements['MARCA'].value='';		//ET 28/10/2003 Ya no utilizamos este desplegable
			//formu.elements['PRECIOMIN'].value='';
			//formu.elements['PRECIOMAX'].value='';
			formu.elements['AVANZADA'].value='S';
		}
		
		Busqueda(formu);
		
	}

	//	Busqueda avanzada
	function BusquedaAvanzada(formu)
	{
		formu.elements['AVANZADA'].value='S';
		Busqueda(formu);
	}

	//	Funcion llamada al seleccionar algun desplegable
	//	Inicializa la pagina a 0
	function SeleccionFiltro(formu)
	{
		formu.elements['PAGINA'].value='0';
		BusquedaAvanzada(formu);
	}

	//	Muestra la siguiente pagina de precios
	function SiguientesPrecios(formu)
	{
		formu.elements['PRECIOMIN'].value=formu.elements['NUEVOPRECIOMINIMO'].value;
		Busqueda(formu);
	}

	//	Presenta la ficha de un producto
	function FichaProducto(ID)
	{
		//MostrarPag('http://www.concursos.com/FichaProducto.xsql?ID='+ID, 'Concursos_FichaProducto');
		MostrarPagPersonalizada('./FichaProducto.xsql?ID='+ID,'Concursos_FichaProducto',60,60,0,0);
	}

	
  setHandleKeyPress()

	function EnviarBusqueda()
	{
		if (LimitarCantidadPalabras(document.forms['Form1'].elements['PRODUCTO'],5))
			Busqueda(document.forms['Form1'],'Material-Sanitario.xsql');
	}
	
	function LimitarCantidadPalabras(obj, numPalabras){
	  var nombreCampo;
	  
	   if(obj.name=='PRODUCTO')
	      
	     nombreCampo='Producto';
	   else
	     if(obj.name=='LLP_PROVEEDOR')
	       nombreCampo='Proveedor';
	       
	  var numEspacios=0;
	  obj.value=quitarEspacios(obj.value);
	  
	  for(var n=0;n<obj.value.length;n++){
	    if(obj.value.substring(n,n+1)==' '){
	      numEspacios++;
	    }
	    if(numEspacios>=numPalabras){
	      var cadTemp=obj.value.substring(0,n);
	      if(confirm(msg_DemasiadosCriteriosDefault+nombreCampo+msg_DemasiadosCriteriosExtra_1+cadTemp+msg_DemasiadosCriteriosExtra_2)){
	        obj.value=obj.value.substring(0,n);
	        return true;
	      }
	      else{
	        return false;
	      }
	    }
	  }
	  return true;
	}
	
	function asignarTexto(obj,texto,evento){
		if(evento=='FOCUS'){
			if(obj.value==texto){
				obj.value='';
			}
		}
		else{
			if(evento=='BLUR'){
				if(obj.value==''){
					obj.value=texto;
				}
			}
		}
	}
	
	//funcion que cambia la visibilidad de un objeto (div)
				function cambiarVisibilidad(obj){
				
					
					
					if(obj!=null){
						if(arguments.length==2){
							obj.style.visibility=arguments[1];	
						}
						else{
							if(obj.style.visibility=='hidden'){
								obj.style.visibility='visible';	
							}
							else{
								obj.style.visibility='hidden';	
							}
						}
					}
				}
				
				function Acceso(form)
				{
	
					var MsgError='';
	
					for(var n=0;n<form.length;n++)
					{
						if(form.elements[n].type=='text')
						{
							form.elements[n].value=quitarEspacios(form.elements[n].value);
						}
					}	
				
			
		
					// EMAIL
					if (form.elements['USER'].value=='')
						MsgError=MsgError+'* Tu dirección de correo electrónico es obligatoria.\n';
					else
					{
						if (CompruebaDireccionEmail(form.elements['USER'].value)==false)
							MsgError=MsgError+'* La dirección de correo electrónico no tiene el formato correcto: direccion@servidor.ext.\n'
					}
		
					//CLAVE
					if (form.elements['PASS'].value=='')
						MsgError=MsgError+'* La contraseña de acceso es obligatoria.\n';
			
		
		
					if (MsgError=='')		
					{
						var Enviar=true;
			
	  					if (Enviar==true){
	  						guardar(form);
							SubmitForm(form);         /*Form1.submit();*/				
						}
					}
					else
						alert("Por favor, compruebe las siguientes incidencias:\n\n"+MsgError);
				}
	
				// MR Comprobamos cual de los dos formularios esta informado, en caso de estar los dos informdos
				// se envia el primer formulario
	
				function funcionAEjecutarPorHandleKeyPress(){
	  
	  				
	  				var Informado1 = 0;

          // comprobar que formulario de acceso esta informado mediante un bucle
					for(var n=0;n<document.forms['formLogin'].length;n++)
		 			{
						if(document.forms['formLogin'].elements[n].type=='text' || document.forms['formLogin'].elements[n].type=='password')
						{
							// si formulario acceso esta informado
							if(document.forms['formLogin'].elements[n].value!=''){
								Informado1 = 1;
							}
						}
	   				}
		   			if (Informado1!=0){
			   			Acceso(document.forms['formLogin']);
	   				}
	   				else{
	   					BusquedaSinFiltros(document.forms['Form1']);
	   				}
	  				
				}
	
	
	   
	  //-->
	</script>
        ]]></xsl:text>
      </head>
      <body class="blanco" text="#000000" link="#333366" vlink="#333366" alink="#3399ff" topmargin="0">      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="/Productos/SESION_CADUCADA">
          <xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="/Productos/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="FamiliasYProductos/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        
 	
  <xsl:choose>
  <!-- si el usuario tiene acceso -->
  <xsl:when test="/Productos/PRODUCTOS">

  <table width="100%" border="0" align="center" cellspacing="1" cellpadding="1">
  
	<form name="Form1" method="POST" action="./Material-Sanitario.xsql">
    
      
			<input type="hidden" name="AVANZADA">
				<xsl:attribute name="value"><xsl:value-of select="/Productos/PRODUCTOS/CRITERIOS/AVANZADA"/></xsl:attribute>
			</input>
			<input type="hidden" name="PAGINA">
				<xsl:attribute name="value"><xsl:value-of select="/Productos/PRODUCTOS/CRITERIOS/PAGINA"/></xsl:attribute>
			</input>
			<input type="hidden" name="NUEVOPRECIOMINIMO">
				<xsl:attribute name="value"><xsl:value-of select="/Productos/PRODUCTOS/CRITERIOS/NUEVOPRECIOMINIMO"/></xsl:attribute>
			</input>
			<!--
			<td width="500px">
			<table width="100%" class="blanco" cellpadding="1" cellspacing="1" border="1" align="left" valign="center">
			
				<tr>
  					<td colspan="2">
							<table width="100%" class="blanco" cellpadding="0" cellspacing="0" border="0" align="center">
        						<tr class="blanco">
        							<td width="25%" align="center">&nbsp;<a href="javascript:AcercaDe()">Acerca de</a></td>
        							<td width="25%" align="center">&nbsp;<a href="javascript:Ayuda()">Como Buscar?</a></td>
        							<td width="25%" align="center">&nbsp;<a href="javascript:Recomendar()">Recomendar</a></td>
        							<td width="25%" align="center">&nbsp;<a href="http://www.concursos.com/Sitemap/sitemap.htm">Catálogo</a></td>
        						</tr>
							</table>
					</td>
				</tr>
        		<tr class="claro">
        		<td width="85%" align="center">
				<table width="100%" class="oscuro" cellpadding="1" cellspacing="1" border="0" align="left" valign="center">
        			<tr class="claro">
        			   <td width="70%" align="center">
					   	
        			   </td>
        			   <td width="*" align="center" valign="middle">
            			  <table cellpadding="3" cellspacing="1" border="0" width="0px" class="muyoscuro">
                			 <tr class="medio">
                    			<td align="center"><a href="javascript:BusquedaSinFiltros(document.forms[0]);" onMouseOver="window.status='Nueva Búsqueda'; return true;" onMouseOut="window.status=''; return true;">Nueva Búsqueda</a>
                    			</td>
                			 </tr>

            			  </table>
        			   </td>
        			</tr>
				</table>
        		</td>
        		</tr>-->
        		
        		<!--	29/10/2003 Pasamos a buscar solo en el campo de producto
					19/11/2003 Volvemos a permitir varios campos, aunque ahora el orden SI afecta
			-->
			<!--
        		<tr>
        		   <td align="center" colspan="2">
					El buscador acepta los siguientes campos: Familia, Producto, Proveedor, Centro, Ref.proveedor
        		   </td>
        		</tr>
			</table>
			
		</td>-->
	
	
	
	<!--
	<tr>
    	<td>
    			<br/>
    			<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.concursos.com/">Inicio</a>&nbsp;
						&gt;&nbsp;Listado de Productos
					</b>
    	</td>
    </tr>
	-->
	

    <tr>
      <td colspan="2">
		<input type="hidden" name="NUMEROPRODUCTOS">
			<xsl:attribute name="value"><xsl:value-of select="/Productos/PRODUCTOS/TOTALES/PRODUCTOS"/></xsl:attribute>
		</input>
		<xsl:choose>
		<xsl:when test="/Productos/PRODUCTOS/TOTALES/PRODUCTOS=0">
				<table width="100%" class="oscuro" cellspacing="1" cellpadding="3" align="center">
				    <tr  class="blanco">
				      <td align="left">
				        <B>&nbsp;Listado de Productos y Precios.</B>	
				        <br/>
				        <i>
						&nbsp;No se han encontrado productos. Por favor, modifique los criterios de búsqueda.
						</i>
				        <br/>
				        <br/>
						&nbsp;Si desea saber como buscar con mas eficacia, consulte <a href="javascript:Ayuda()">"Como Buscar?"</a>
				        <br/>
				        <br/>
						<table cellpadding="3" cellspacing="1" border="0" width="0px" class="muyoscuro" align="center">
							<tr class="medio">
            				<td align="center"><a href="javascript:history.back(-1)" onMouseOver="window.status='Volver'; return true;" onMouseOut="window.status=''; return true;">Volver</a>
            				</td>
							</tr>
						</table>
				        <br/>
				      </td>
				    </tr>
				  </table>
		</xsl:when>
		<xsl:otherwise>
        <table width="100%" border="0" align="center" cellspacing="1" cellpadding="1" class="gris">
		<tr class="grisclaro">
		<td align="left">
				<table width="100%" class="blanco" cellspacing="0" cellpadding="0">
				    <tr  class="claro">
				      <td align="left">
				        <B>&nbsp;Listado de Material Médico y Material Sanitario: Precios en Concursos.</B>	
				        <br/>
				        <i>
						&nbsp;<xsl:value-of select="/Productos/PRODUCTOS/TOTALES/PRODUCTOS"/> productos
						<!--<xsl:value-of select="/Productos/PRODUCTOS/TOTALES/MARCAS"/> marcas-->
						de <xsl:value-of select="/Productos/PRODUCTOS/TOTALES/PROVEEDORES"/> proveedores
						ordenados por precio. Puede utilizar los filtros y pulsar 'Buscar en sus resultados' para refinar la búsqueda.
						</i>
				      </td>
				    </tr>
				  </table>
        			<table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="blanco">
            			<tr class="grisclaro">
                		
                		<td align="center" width="10%">Centro
						<xsl:if test="/Productos/PRODUCTOS/CRITERIOS/AVANZADA='S'">
							<br/>
							<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select="/Productos/PRODUCTOS/DESPLEGABLES/CENTRO/field">
        						</xsl:with-param>
      						</xsl:call-template>	
						</xsl:if>
						</td>
                		<td align="center" width="14%">Familia
						<xsl:if test="/Productos/PRODUCTOS/CRITERIOS/AVANZADA='S'">
							<br/>
							<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select="/Productos/PRODUCTOS/DESPLEGABLES/FAMILIA/field">
        						</xsl:with-param>
      						</xsl:call-template>				
						</xsl:if>
						</td>
				<!--<td align="center" width="5%">Ref.</td>-->
                		<td align="center" valign="middle" colspan="2" width="*">
                		<table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
                			<tr>
                				<td  width="80px">
                				&nbsp;&nbsp;&nbsp;Ref.
                				</td>
                				<td  width="*">
                				Buscar por: producto, proveedor, centro, ref.
                				</td>
                				<td align="left" rowspan="2" width="*" valign="middle" cellpadding="0" cellspacing="0"> 
                				
                					<table cellpadding="3" cellspacing="1" border="0" width="60%" class="muyoscuro">
                			 			<tr class="claro">
                    					<td align="center" rowspan="2"><a href="javascript:BusquedaSinFiltros(document.forms['Form1']);" onMouseOver="window.status='Buscar'; return true;" onMouseOut="window.status=''; return true;">Buscar</a>
                    					</td>
                			 			</tr>
            			  			</table>
                				</td>
                			</tr>
                			<tr>
                				<td>&nbsp;</td>
                				<td>
                				<xsl:if test="/Productos/PRODUCTOS/CRITERIOS/AVANZADA='S'">
							<input type="text" name="PRODUCTO" maxlength="200" size="55" onFocus="asignarTexto(this,textoMuestra,'FOCUS');" onBlur="asignarTexto(this,textoMuestra,'BLUR');">
							
								<xsl:variable name="textoMuestra">[Introduce tu busqueda]</xsl:variable>
								<xsl:if test="/Productos/PRODUCTOS/CRITERIOS/PRODUCTO=''"> 
									<xsl:attribute name="value"><xsl:value-of select="$textoMuestra"/></xsl:attribute>	 
								</xsl:if>
								<xsl:if test="/Productos/PRODUCTOS/CRITERIOS/PRODUCTO!=''">
									<xsl:attribute name="value"> <xsl:value-of select="/Productos/PRODUCTOS/CRITERIOS/PRODUCTO"/></xsl:attribute>
								</xsl:if>
							</input>
								
						</xsl:if>
                				</td>
                				
                			</tr>
                		</table>
						</td>
                		<td align="center" width="13%">Proveedor
						<xsl:if test="/Productos/PRODUCTOS/CRITERIOS/AVANZADA='S'">
							<br/>
							<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select="/Productos/PRODUCTOS/DESPLEGABLES/PROVEEDOR/field">
        						</xsl:with-param>
      						</xsl:call-template>				
						</xsl:if>
						</td>
					<xsl:choose>
                				<xsl:when test="/Productos/PRODUCTOS/PRODUCTO/PRECIO/PRECIO"> 
        									<td align="center" width="7%">Precio<br/>Ud.Base<br/>s/IVA</td>
       									</xsl:when>
       									<xsl:otherwise>
       										<td align="center" width="18%">Precio<br/>Ud.Base<br/>s/IVA</td>
       									</xsl:otherwise>
       								</xsl:choose>
        	
						</tr>
				
          				<xsl:for-each select="/Productos/PRODUCTOS/PRODUCTO">
            			<tr class="blanco" onMouseOver="this.className='claro'" onMouseOut="this.className='blanco'">
                			
                			
                			<td align="center" width="10%"><xsl:value-of select="NOMBRECORTOCENTRO"/></td>
                			<!--<td align="center"><xsl:value-of select="ANNO"/></td>-->
                			<td align="center" width="14%"><xsl:value-of select="FAMILIA"/></td>
                			<td align="center" colspan="2" width="*">
                				<table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
                					<tr>
                					<td align="center" width="80px"><xsl:value-of select="REFERENCIAPROVEEDOR"/></td>
                					<td align="left" width="*">
								<a>
									<xsl:attribute name="href">./FichaProducto.xsql?ID=<xsl:value-of select="ID"/></xsl:attribute>
									<xsl:value-of select="NOMBREPRODUCTO"/>
								</a>
							</td>
							
							</tr>
						</table>
					</td>
                			<td align="center" width="13%"><xsl:value-of select="NOMBRECORTOPROVEEDOR"/></td>
                			<xsl:choose>
                				<xsl:when test="/Productos/PRODUCTOS/PRODUCTO/PRECIO/ERROR_PRECIO"> 
                					<td align="center"  width="18%"><a href="http://www.concursos.com/index.htm"><b><xsl:value-of select="/Productos/PRODUCTOS/PRODUCTO/PRECIO/ERROR_PRECIO/@Msg"/></b></a></td>
       									</xsl:when>
       									<xsl:otherwise>
       										<td align="center"  width="7%"><b><xsl:value-of select="PRECIO"/>&nbsp;€</b></td>
       									</xsl:otherwise>
       								</xsl:choose>
                			
						</tr>
						<tr><td align="center" colspan="7" height="1px" class="grisclaro"></td></tr>
		  				</xsl:for-each>	    
                	</table> 
              </td>
	    </tr>
		<tr class="blanco" height="30px" valign="center">
			<td align="center" colspan="1"> 
     			<xsl:for-each select="/Productos/PRODUCTOS/PAGINAS/PAGINA">
     			
     					<xsl:choose>
						<xsl:when test="./FIJO">
						<b><xsl:value-of select="TEXTO"/></b>&nbsp;
						</xsl:when>
						<xsl:otherwise>
									
						<xsl:variable name="TextoStatus">
						<xsl:choose>
						<xsl:when test="contains(TEXTO,'&gt;')"> ir a la <xsl:value-of select="translate(TEXTO,'&gt;','')"/></xsl:when>
						 <xsl:when test="contains(TEXTO,'&lt;')">ir a la <xsl:value-of select="translate(TEXTO,'&lt;','')"/></xsl:when>
						<xsl:otherwise>ir a la Página <xsl:value-of select="TEXTO"/></xsl:otherwise>
						</xsl:choose>
						</xsl:variable>
									
						<a>
									
							<xsl:attribute name="href">BusquedaProductos.xsql?<xsl:value-of select="URL"/></xsl:attribute>
							<xsl:attribute name="onMouseOver">asignarTextoEstado('<xsl:value-of select="$TextoStatus"/>');return true;</xsl:attribute>
							<xsl:attribute name="onMouseOut">asignarTextoEstado('');return true;</xsl:attribute>
							<xsl:value-of select="TEXTO"/>
						</a>&nbsp;
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</td>
		</tr>
		<tr class="blanco">
			<td>
				<input type="hidden" name="INCLUIRFAMILIAS" value=""/>
				<br/>
				<xsl:choose>
				<xsl:when test="/Productos/PRODUCTOS/CRITERIOS/AVANZADA='S'">
					<table cellpadding="0" cellspacing="0" border="0" width="100%" class="blanco" align="center">
						<xsl:choose>
						<xsl:when test="/Productos/PRODUCTOS/PRODUCTO/PRECIO/PRECIO">
						<tr>
							<td align="left" width="45%">				
							&nbsp;<span class="rojo">*</span>&nbsp;Incluir productos con importe incluido entre <input type="text" name="PRECIOMIN" maxlength="10" size="8" onBlur="ValidarNumero(this,4);">
							<xsl:attribute name="value"><xsl:value-of select="/Productos/PRODUCTOS/CRITERIOS/PRECIOMINIMO"/></xsl:attribute>
							</input> 
							y <input type="text" name="PRECIOMAX" maxlength="10" size="8" onBlur="ValidarNumero(this,4);">
							<xsl:attribute name="value"><xsl:value-of select="/Productos/PRODUCTOS/CRITERIOS/PRECIOMAXIMO"/></xsl:attribute>
							</input>
							</td>
							
							<td align="left" width="15%">
							<table cellpadding="3" cellspacing="1" border="0" width="0px" class="muyoscuro" align="center">
								<tr class="medio">
									<td align="center"><a href="javascript:EnviarBusqueda(document.forms['Form1']);" onMouseOver="window.status='Buscar'; return true;" onMouseOut="window.status=''; return true;">Buscar Precios</a>
									</td>
								</tr>
							</table>
							</td>
							
							<td align="right" width="40%">&nbsp;
							
							</td>

							<td align="right" width="5%">&nbsp;
							
							</td>
						</tr>
						</xsl:when>
						<xsl:otherwise>
        				<tr class="blanco">
        				   <td align="left" colspan="4">&nbsp;<span class="rojo">*</span>&nbsp;Comprador: Si desea más información sobre este servicio o sobre <b>como puede ahorrar en sus compras</b> de productos sanitarios, <a href="http://www.concursos.com/Contacto.html">CONTACTE</a> con nosotros.</td>
        				</tr>
        				<tr class="blanco">
        				   <td align="left" colspan="4">&nbsp;<span class="rojo">*</span>&nbsp;Proveedor: Si quiere que <b>incluyamos gratuitamente sus productos</b> adjudicados en concursos sanitarios, <a href="http://www.concursos.com/Contacto.html">CONTACTE</a> con nosotros.</td>
        				</tr>
        				
        		</xsl:otherwise>
        	</xsl:choose>
					</table>
				</xsl:when>
				<xsl:otherwise>
				&nbsp;* Puede utilizar la <u><a href="javascript:BusquedaAvanzada(document.forms['Form1']);">BUSQUEDA AVANZADA</a></u> para realizar selecciones más precisas 
				</xsl:otherwise>
				</xsl:choose>
			</td>
	    </tr>
	  </table>
	</xsl:otherwise>
	</xsl:choose>
	</td>
  </tr>
  </form>
  </table>
  	</xsl:when>
  	<!-- si el usuario no tiene acceso -->
  	<xsl:otherwise>
  	<table width="95%" border="0" align="center" cellspacing="1" cellpadding="1" height="100%">
  	 

	<tr valign="top" height="20%">
	
		<td align="center"><br/>
			<a href="http://www.concursos.com/"><img src="http://www.concursos.com/Images/ConcursosSanitarios.gif" alt="Concursos Sanitarios" border="0"/></a>
		</td>
	</tr>
	<tr>
		<td height="10px"></td>
	</tr>
	
	<tr height="20%">
		<td>
			<table width="40%" class="muyoscuro" cellpadding="1" cellspacing="0" border="0" align="center"  valign="center">
            		<tr>
            		<td>
            		<table width="100%" class="blanco" cellpadding="1" cellspacing="0" border="0" align="center"  valign="center">
            			<tr>
            				<td>
            				<table width="100%" class="claro" cellpadding="0" cellspacing="0" border="0"   valign="center">
            				<tr class="blanco">
            				<td width="5px"></td>
            				<td align="center">Acceso denegado: <xsl:value-of select="Productos/ERROR"/>
		    			</td>
		    			<td></td>
		    			</tr>
		    			</table>	
					</td>
            			</tr>
            		</table>
            		</td>
            		</tr>
            		</table>
		</td>
		
	</tr>
	
	<tr>
		<td height="10px"></td>
	</tr>
	<tr valign="top" height="30%">			
            <td>	
            	<table cellpadding="3" cellspacing="1" border="0" width="10%" class="muyoscuro" align="center">
                	<tr class="medio">
                             <td align="center"><a href="javascript:history.go(-1);" onMouseOver="window.status='Volver a la página principal'; return true;" onMouseOut="window.status=''; return true;">Volver</a></td>
                         </tr>
                </table>                                 
            </td>
        </tr>
        <tr>
        	<td>
        		<table width="70%" align="center">
			<tr>
				<td colspan="3" height="1px" class="grisclaro"></td>
			</tr>
			<tr>
				<td>
			  	<table width="100%" class="blanco" cellpadding="0" cellspacing="0" border="0" align="center">
			    	<tr class="blanco">
			    		<td align="center">&nbsp;<a onMouseOver="asignarTextoEstado('Registrarse ahora');return true;" onMouseOut="asignarTextoEstado('');return true;" href="http://www.concursos.com/index.htm">Regístrate</a></td>
			    		<td align="center">&nbsp;<a onMouseOver="asignarTextoEstado('Acceder al buscador de ConcurosSanitarios.com');return true;" onMouseOut="asignarTextoEstado('');return true;" href="http://www.concursos.com/Material-Sanitario.xsql">Buscador</a></td>
							<td align="center">&nbsp;<a onMouseOver="asignarTextoEstado('Averca de');return true;" onMouseOut="asignarTextoEstado('');return true;" href="http://www.concursos.com/AcercaDe.html">Acerca de</a></td>
							<td align="center">&nbsp;<a onMouseOver="asignarTextoEstado('Contactar con ConcursosSanitarios.com');return true;" onMouseOut="asignarTextoEstado('');return true;" href="http://www.concursos.com/Contacto.html">Contactar</a></td>
							<td align="center">&nbsp;<a onMouseOver="asignarTextoEstado('Recomienda ConcursosSanitoarios.com');return true;" onMouseOut="asignarTextoEstado('');return true;" href="http://www.concursos.com/Recomendar.html">Recomendar</a></td>
							<td align="center">&nbsp;<a onMouseOver="asignarTextoEstado('Acceder al catalógo de ConcurosSanitarios.com');return true;" onMouseOut="asignarTextoEstado('');return true;" href="http://www.concursos.com/Sitemap/sitemap.htm">Catálogo</a></td>
							<td align="center">&nbsp;<a onMouseOver="asignarTextoEstado('Ir a MedicalVM');return true;" onMouseOut="asignarTextoEstado('');return true;" target="_blank" href="http://www.newco.dev.br/?origen=concursos">MedicalVM</a></td>
			      </tr>
			    </table>
			  </td>
			</tr>
			<tr>
				<td colspan="3" height="1px" class="grisclaro"></td>
			</tr>
    </table>
        	</td>
        </tr>
  	</table>
  	
  	</xsl:otherwise>
  	</xsl:choose>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
