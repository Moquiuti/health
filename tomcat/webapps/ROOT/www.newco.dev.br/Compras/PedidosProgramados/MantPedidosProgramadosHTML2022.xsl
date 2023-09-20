<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Ficha de PROGRAMA. Nuevo disenno 2022
	Ultima revision: ET 22feb23 09:00 MantPedidosProgramados2022_220223.js
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
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
	<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
	<!--idioma fin-->
      
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_pedido_programado']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CENTRO"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->  
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramados2022_220223.js"></script>
    
    <script type="text/javascript">
        var arrProveedores=new Array();
        var arrPedidos=new Array();
        var arrUsuarios=new Array();
            
        var pedp_id='<xsl:value-of select="/PedidosProgramados/PEDP_ID"/>';
		var IDUsuario='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIO"/>';
		var idpedido='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/ID"/>';
        var idOfertaModelo='<xsl:value-of select="/PedidosProgramados/IDOFERTAMODELO"/>';
		var IDProveedor='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDPROVEEDOR"/>';
		var ventanaNueva='<xsl:choose><xsl:when test="//VENTANA='NUEVA'">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var ExisteProg='<xsl:choose><xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var esAdmin='<xsl:choose><xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/ADMIN">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var estadoProg='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA"/>';
		var tipoPeriodo='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO"/>';
		var progManual='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL"/>';
		
		var IDUsuario='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIO"/>';
		var inicioProg='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/INICIOPROGRAMA"/>';
		var fecActual='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FECHA"/>';
		var fecLanzamiento='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DIALANZAMIENTO"/>';

        var listaPedidos='<xsl:value-of select="/PedidosProgramados/LISTAPEDIDOS"/>';
        var listaUsuariosCentro='<xsl:value-of select="/PedidosProgramados/LISTAUSUARIOSCENTRO"/>';
        var ventana='<xsl:value-of select="/PedidosProgramados/VENTANA"/>';

		var read_only='<xsl:choose><xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) and not(PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA)">S</xsl:when><xsl:otherwise></xsl:otherwise></xsl:choose>';
		var cadRead_only='<xsl:choose><xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) and not(PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA)">-RO</xsl:when><xsl:otherwise></xsl:otherwise></xsl:choose>';

      
      /*  
          utilizamos un flag con tres estados para saber si hemos de recalcular,
          recalcularPrograma=0  no hemos de recalcular, pero puede cambiar su estado
          recalcularPrograma=1; hemos de recalcular
          recalcularPrograma=-1;  no hemos de recalcular, y este estado no puede cambiar
      */

    <xsl:choose>
      <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA or not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) or PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA='F'">
        var recalcularPrograma=1;
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S'">
            var recalcularPrograma=-1;
          </xsl:when>
          <xsl:otherwise>
            var recalcularPrograma=0;
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>


      <xsl:for-each select="PedidosProgramados/PEDIDOPROGRAMADO/PROVEEDORES/PROVEEDOR">
        arrProveedores[arrProveedores.length]=new Array('<xsl:value-of select="@ID"/>','<xsl:value-of select="@NOMBRE"/>');
        <xsl:for-each select="PEDIDOS/PEDIDO">
          arrPedidos[arrPedidos.length]=new Array('<xsl:value-of select="../../@ID"/>','<xsl:value-of select="ID"/>','<xsl:value-of select="NUMERO"/>','<xsl:value-of select="IDUSUARIO"/>','<xsl:value-of select="IDOFERTAMODELO"/>','<xsl:value-of select="ESTADOOFERTA"/>','<xsl:value-of select="PLAZOENTREGA"/>');
        </xsl:for-each> 
      </xsl:for-each>

      <xsl:for-each select="PedidosProgramados/PEDIDOPROGRAMADO/USUARIOS_DEL_CENTRO/USUARIO">
        arrUsuarios[arrUsuarios.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="NOMBRE"/>');
      </xsl:for-each>
    </script>
</head>
<body onLoad="javascript:Inicio();">   
    <xsl:choose>
      <xsl:when test="ListaDerechosUsuarios/xsql-error">
        <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
      </xsl:when>
    <xsl:when test="PedidosProgramados/SESION_CADUCADA">
      <xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> 
    </xsl:when>
    <xsl:when test="PedidosProgramados/ROWSET/ROW/Sorry">
      <xsl:apply-templates select="PedidosProgramados/ROWSET/ROW/Sorry"/> 
    </xsl:when>
    <xsl:otherwise>

		<!--13set22 Quitamos los antiguos calendarios
        <div id="spiffycalendar" class="text"></div>
                 
        <!- - si el programa es manual no tiene sentido mostrar el calendario - ->
        <xsl:choose>
            <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S')">
              <script type="text/javascript">
                var calFechaFin = new ctlSpiffyCalendarBox("calFechaFin", "form1", "FECHANO_FIN","btnDateFechaFin",'',scBTNMODE_CLASSIC,'ONBLUR|calculaFecha(document.forms[\'form1\'],document.forms[\'form1\'].elements[\'FECHANO_FIN\'],0);#CHANGEDAY|calculaFecha(document.forms[\'form1\'],document.forms[\'form1\'].elements[\'FECHANO_FIN\'],0);');
              </script>
              <script type="text/javascript">
                var calFechaEntrega = new ctlSpiffyCalendarBox("calFechaEntrega", "form1", "FECHANO_ENTREGA","btnDateFechaEntrega",'',scBTNMODE_CLASSIC,'ONBLUR|calculaFecha(document.forms[\'form1\'],document.forms[\'form1\'].elements[\'FECHANO_ENTREGA\'],\'-\'+document.forms[\'form1\'].elements[\'PLAZOENTREGA\'].value);#CHANGEDAY|calculaFecha(document.forms[\'form1\'],document.forms[\'form1\'].elements[\'FECHANO_ENTREGA\'],\'-\'+document.forms[\'form1\'].elements[\'PLAZOENTREGA\'].value);');
              </script>
           </xsl:when>
        </xsl:choose>
		-->
       
        
 <form name="form1" action="MantPedidosProgramados2022.xsql" method="post">
      <xsl:choose>
        <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
          <input type="hidden" name="FECHA_CREACION" size="14" maxlength="10" value="{PedidosProgramados/PEDIDOPROGRAMADO/CREACION}"/>
        </xsl:when>
        <xsl:otherwise>
          <input type="hidden" name="FECHA_CREACION" size="14" maxlength="10"  value="{PedidosProgramados/PEDIDOPROGRAMADO/FECHA}"/>
        </xsl:otherwise>
      </xsl:choose>
      
	<input type="hidden" name="ACCION"/>
	<input type="hidden" name="FECHA_ACTUAL" size="14" maxlength="10"  value="{PedidosProgramados/PEDIDOPROGRAMADO/FECHA}"/>
	<input type="hidden" name="IDEMPRESA" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDEMPRESA}"/>
	<input type="hidden" name="PEDP_ID" value="{PedidosProgramados/PEDIDOPROGRAMADO/ID}"/>
	<input type="hidden" name="IDCENTRO" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDCENTRO}"/>
	<input type="hidden" name="VENTANA" value="{//VENTANA}"/>
	<input type="hidden" name="FINALICACION_FECHA"/>
	<input type="hidden" name="FECHANO_LANZAMIENTO_ALMACENADA"/>
	<input type="hidden" name="IDUSUARIOCONSULTA" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIOCONSULTA}"/>
	<input type="hidden" name="EDITAR_FECHAS"/>
	<input type="hidden" name="IDFRECUENCIA_ANTERIOR" value="{PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO}"/>
	<input type="hidden" name="LISTAPEDIDOS" value="{PedidosProgramados/LISTAPEDIDOS}"/>
	<!--<input type="hidden" name="LISTAUSUARIOSCENTRO" value="{PedidosProgramados/LISTAUSUARIOSCENTRO}"/>-->
      
	<!--14set22 <input type="hidden" name="FECHA_INICIO"  size="14" maxlength="10" onBlur="calculaFecha(document.forms['form1'],this,document.forms['form1'].elements['PLAZOENTREGA'].value);"/>-->
    <input type="hidden" name="FECHA_INICIO" value="{PedidosProgramados/PEDIDOPROGRAMADO/INICIOPROGRAMA}"/>
	
	
	<input type="hidden" name="MANUAL">
    <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA='F'">
            <xsl:attribute name="value">N</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
    </input>
      
    <input type="hidden" name="DESDEOFERTA">
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
            <xsl:attribute name="value">S</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value">N</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
    </input>
      
      
    <!-- si es desde oferta(el prograsma no existe), o el programa tadavia no existe,  hemos de recalcular (realmente es la primera vez que lo calculamos) -->
    <input type="hidden" name="RECALCULAR">
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA or not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE)">
            <xsl:attribute name="value">S</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
              <!-- el programa si existe, si el programa esta marcado como manual no recalculamos-->
            <xsl:choose>
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S'">
                <xsl:attribute name="value">N</xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="value">N</xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
    </input>
    <input type="hidden" name="PLAZOENTREGAOFERTAMODELO" value="{PedidosProgramados/PEDIDOPROGRAMADO/PLAZOENTREGAOFERTAMODELO}"/>
    <input type="hidden" name="ACTUALIZARPAGINA">
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='N'">
            <xsl:attribute name="value">S</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value">S</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </input>
      
      <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/PedidosProgramados/LANG"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_pedido_programado']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<xsl:choose>
					<xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
						<a class="btnDestacado" href="javascript:EliminarPrograma();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
						</a>&nbsp;
					</xsl:when>
					<xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE and not(PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA)">
						<a class="btnNormal" href="javascript:window.close();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
						</a>&nbsp;
						<a class="btnDestacado" href="javascript:EliminarPrograma();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
						</a>&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<a class="btnNormal" href="javascript:window.close();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
						</a>&nbsp;
					</xsl:otherwise>
				</xsl:choose>
              	<a class="btnDestacado" href="javascript:GuardarCambios();" id="aceptarBoton">
               		<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
                </a>&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
     <div class="divLeft">
      <div class="divLeft80">
          
      <table cellspacing="6px" cellpadding="6px">
        <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA='F'">
          <tr class="sinLinea">
            <td class="labelRight grisMed">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='estado_del_programa']/node()"/>:&nbsp;
            </td>
            <td class="datosleft">
              <span class="rojo14"> <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_finalizado']/node()"/></span>
            </td>
          </tr>
        </xsl:if>
        <tr class="sinLinea">
          <td class="labelRight trenta grisMed">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_del_programa']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
          </td>
          <td class="datosleft">
            <!-- pendiente los tamanyos -->
            <input type="text" class="w500px campopesquisa" name="DESCRIPCION" maxlength="100">
              <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                <xsl:attribute name="value">
                  <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION"/>
                </xsl:attribute>
              </xsl:if>
            </input>
          </td>
        </tr>
        <tr class="sinLinea">
           <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_de_creacion']/node()"/>:&nbsp;
          </td>
           <td class="datosleft">
            <xsl:choose>
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                <b><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CREACION"/></b>
              </xsl:when>
              <xsl:otherwise>
                <b><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FECHA"/></b>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <xsl:choose>
           <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/ADMIN">
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
          </td>
           <td class="datosleft">
                <select name="IDUSUARIO" class="w400px" onChange="CargarPedidosProveedor('IDOFERTAMODELO',document.forms['form1'].elements['IDPROVEEDOR'].value,document.forms['form1'].elements['IDOFERTAMODELO'].value);">  
                </select>
          </td>
        </tr>
        </xsl:when>
        <xsl:otherwise>
               <input type="hidden" name="IDUSUARIO" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIOCONSULTA}"/>  
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <!-- existe -->
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
            <tr class="sinLinea">
              <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
              </td>
              <td class="datosLeft">
                <a href="javascript:FichaEmpresa('{PedidosProgramados/PEDIDOPROGRAMADO/IDPROVEEDOR}')"><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/PROVEEDOR"/></a>
                <input type="hidden" name="IDPROVEEDOR" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDPROVEEDOR}"/>  
              </td>
            </tr>
            
          </xsl:when>
         <!-- no existe -->
          <xsl:otherwise>
            <tr class="sinLinea">
              <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
              </td>
              <td class="datosLeft">
                      <select name="IDPROVEEDOR"  onChange="CargarPedidosProveedor('IDOFERTAMODELO',this.value,'-1');">
                      </select>
                    <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                      <a href="javascript:MostrarVacacionesProveedor(document.forms['form1'].elements['IDPROVEEDOR'].value);">
                      	<xsl:value-of select="document($doc)/translation/texts/item[@name='dias_habiles']/node()"/>
                      </a>
              </td>
            </tr>
          </xsl:otherwise>
        </xsl:choose>
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:choose>
              <!-- existe -->
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
               <xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_programa']/node()"/>:&nbsp;
              </xsl:when>
                <!-- no existe -->
              <xsl:otherwise>
                <xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_programa']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
              </xsl:otherwise>
            </xsl:choose>
            
          </td>
          <td class="datosLeft">
          
                <xsl:choose>
                  <!-- existe -->
                  <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                    <xsl:choose>
                      <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/NUMERO!=''">
                        <font color="NAVY">
                          &nbsp;&nbsp;&nbsp;&nbsp;<b><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/NUMERO"/></b>
                        </font>
                      </xsl:when>
                      <xsl:otherwise>
                        <font color="NAVY">
                          <strong> <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/></strong>
                        </font>
                      </xsl:otherwise>
                    </xsl:choose>
                    <input type="hidden" name="IDOFERTAMODELO" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDOFERTAMODELO}"/>
                    <input type="hidden" name="ESTADOOFERTA" value="{PedidosProgramados/PEDIDOPROGRAMADO/ESTADOOFERTA}"/>
                    
                  </xsl:when>
                    <!-- no existe -->
                  <xsl:otherwise>
                    <select name="IDOFERTAMODELO" onChange="CargarPlazoEntrega('PLAZOENTREGA',this.value);calculaFecha(document.forms['form1'],document.forms['form1'].elements['FECHANO_LANZAMIENTO'],document.forms['form1'].elements['PLAZOENTREGA'].value);habilitarDeshabilitarFechas(document.forms['form1'].elements['IDFRECUENCIA'].value)">
                    </select>
                    <input type="hidden" name="ESTADOOFERTA" value="{PedidosProgramados/PEDIDOPROGRAMADO/ESTADOOFERTA}"/>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                  <a class="btnDiscreto" href="javascript:MostrarMultioferta(document.forms['form1'].elements['IDOFERTAMODELO'].value,'S');">
				  	<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_pedido_modelo']/node()"/>
                      <!--13set22	<xsl:choose>
                          <xsl:when test="/PedidosProgramados/LANG= 'spanish'"><img src="http://www.newco.dev.br/images/modificarPedidoModelo.gif" alt="Modificar pedido modelo" /></xsl:when>
                          <xsl:otherwise><img src="http://www.newco.dev.br/images/modificarPedidoModelo-BR.gif" alt="Modificar modelo de pedido" /></xsl:otherwise>
                      </xsl:choose>-->
                  </a> 
                <!--boton mostrar multioferta--> 
                <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/PEDIDO_SIGUIENTE_DIFERENTE='S'">
                	 <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                    <a>
                    <xsl:attribute name="href">javascript:MostrarMultioferta('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/PROXIMA_OFERTA"/>','N');</xsl:attribute>
                      <xsl:choose>
                          <xsl:when test="/PedidosProgramados/LANG= 'spanish'"><img src="http://www.newco.dev.br/images/modificarProximoPedido.gif" alt="Modificar próximo pedido" /></xsl:when>
                          <xsl:otherwise><img src="http://www.newco.dev.br/images/modificarPedidoModelo-BR.gif" alt="Modificar próximo pedido" /></xsl:otherwise>
                      </xsl:choose>
                    </a>  
                </xsl:if>
           
          </td>
        </tr>
        
        <!-- si es manual, mostramos el calendario (edicion) -->
        <xsl:choose>
          <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S')">
            <tr class="sinLinea">
              <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_prima_entrega']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
              </td>
              <td class="datosLeft">
              <!-- 13set22     <script type="text/javascript">
                      calFechaEntrega.dateFormat="d/M/yyyy";
                      calFechaEntrega.writeControl();
                    </script>-->
				  <!--solodebug<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FECHA_ENTREGA"/>-->
				  <input type="hidden" id="FECHANO_ENTREGA" name="FECHANO_ENTREGA" value="{PedidosProgramados/PEDIDOPROGRAMADO/FECHA_ENTREGA}"/>	<!--Utilizar para inicializar dtFECHAENTREGA-->
				  <!--7oct22 <input type="date" class="campopesquisa" id="dtFECHAENTREGA" name="dtFECHAENTREGA" onChange="javascript:calculaFechaLanzamiento();"/>&nbsp;-->
				  <input type="date" class="campopesquisa" id="dtFECHAENTREGA" name="dtFECHAENTREGA" onChange="javascript:calculaFechaEntrega();"/>&nbsp;
            	  <span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_posterior_entrega']/node()"/>.</span>
					
            </td>
          </tr>
        </xsl:when>
        <xsl:otherwise>
			<tr class="sinLinea">
				<td class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_prox_entrega']/node()"/>:&nbsp;
				</td>
				<td class="datosLeft">
					<!--16set22	<input type="text" name="FECHANO_ENTREGA" size="14" maxlength="10" style="text-align:left;" class="inputOculto" onFocus="this.blur();"/>-->
				  <!--solodebug<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FECHA_ENTREGA"/>-->
					<input type="hidden" id="FECHANO_ENTREGA" name="FECHANO_ENTREGA" value="{PedidosProgramados/PEDIDOPROGRAMADO/FECHA_ENTREGA}"/>	<!--Utilizar para inicializar dtFECHAENTREGA-->
					<input type="date" class="campopesquisa" id="dtFECHAENTREGA" name="dtFECHAENTREGA" onChange="javascript:calculaFechaLanzamiento();"/>&nbsp;
					<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_posterior_entrega']/node()"/>.</span>
				</td>
			</tr>
        </xsl:otherwise>
      </xsl:choose> 
        <!-- no mostramos la frecuencia, ya que es manual -->
      <xsl:choose>
        <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S')">
        <tr class="sinLinea">
          <td class="labelRight grisMed">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='frecuencia_de_entregas']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
          </td>
          <td class="datosLeft">
                  <xsl:call-template name="field_funcion">
                    <xsl:with-param name="path" select="PedidosProgramados/field[@name='IDFRECUENCIA']"/>
                    <xsl:with-param name="IDAct">
                      <xsl:choose><xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA"><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO"/></xsl:when><xsl:otherwise>-1</xsl:otherwise></xsl:choose>
                    </xsl:with-param>
                    <xsl:with-param name="cambio">habilitarDeshabilitarFechas(this.value);actualizarRecalculo(this);</xsl:with-param>
                  </xsl:call-template>
               
                <!-- mostramos el boton programacion manual cuando ya existe el programa -->
                  <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">
                   <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                    <!-- pasamos el valor de no recargar la pagina, si en ella hacemos cambios (...Save) entonces le pasaremos 'S' desde la propia pagina -  originalmente ponia 'S' -->
                      <xsl:variable name="actualizarPagina">
                        <xsl:if test="//PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='N'">N</xsl:if>
                      </xsl:variable>
                      <a class="btnDiscreto" href="javascript:Calendario();">
	                  	<!--16set22 <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados2022.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;ACTUALIZARPAGINA=<xsl:value-of select="$actualizarPagina"/>&amp;TITULO=Programación manual&amp;READ_ONLY=S','lanzamientosProgramas');</xsl:attribute>-->
                      	<!--16sset22<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_fechas_entrega']/node()"/>-->
                      	<xsl:value-of select="document($doc)/translation/texts/item[@name='Calendario']/node()"/>
					</a>  
                  </xsl:if>
                 
           </td>
        </tr>
        <tr class="sinLinea">
        	<td>&nbsp;</td>
            <td class="datosLeft"><span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_automatico_no_modificar']/node()"/></span></td>
        </tr>
        </xsl:when>
        <xsl:otherwise>
          <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:copy-of select="document($doc)/translation/texts/item[@name='frecuencia_de_entregas']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='asignada_manualmente_usuario']/node()"/></strong>
                  <input type="hidden" name="IDFRECUENCIA" value="{PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO}"/>
         
               <!-- mostramos el boton programacion manual cuando ya existe el programa -->
                  <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">
                    <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                    <!-- pasamos el valor de no recargar la pagina, si en ella hacemos cambios (...Save) entonces le pasaremos 'S' desde la propia pagina - originalmente ponia 'S' -->
                      <xsl:variable name="actualizarPagina">
                        <xsl:if test="//PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='N'">N</xsl:if>
                      </xsl:variable>
                   	
                      <a class="btnDiscreto" href="javascript:Calendario();">
                    	<!--16set22 <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados2022.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;ACTUALIZARPAGINA=<xsl:value-of select="$actualizarPagina"/>&amp;TITULO=Programación manual','lanzamientosProgramas');</xsl:attribute>-->
                      	<!--16set22 <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_programacion_manual']/node()"/>-->
                      	<xsl:value-of select="document($doc)/translation/texts/item[@name='Calendario']/node()"/>
                    </a>  
                  </xsl:if>
              </td> 
        </tr>
        </xsl:otherwise>
      </xsl:choose>            
      <xsl:choose>
        <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S')">
        	<tr class="sinLinea">
        	  <td class="labelRight grisMed">
          		<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_finalizacion_programa']/node()"/>:&nbsp;
        	  </td>
        	  <td class="datosLeft">
		  		<!--13set22 Quitamos antiguo calendario
            	  <script type="text/javascript">
                	calFechaFin.dateFormat="d/M/yyyy";
                	<xsl:choose> 
                	  <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE)">
                    	calFechaFin.minDate=new Date(formatoFecha(calculaFechaCalendarios('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CREACION"/>',1),'E','I'));
                	  </xsl:when>
                	  <xsl:otherwise>
                    	calFechaFin.minDate=new Date(formatoFecha(calculaFechaCalendarios('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/INICIOPROGRAMA"/>',0),'E','I'));
                	  </xsl:otherwise>
                	</xsl:choose>
                	calFechaFin.writeControl();
                	<xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                	  <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA!='F'">
                    	calFechaFin.setTextBoxValue('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FINPROGRAMA"/>');
                	  </xsl:if>
                	</xsl:if>
            	  </script>
				  -->
				  <input type="hidden" id="FECHANO_FIN" name="FECHANO_FIN" value="{PedidosProgramados/PEDIDOPROGRAMADO/FINPROGRAMA}"/><!--Utilizar para inicializar dtFECHAFIN-->
				  <input type="date" class="campopesquisa" id="dtFECHAFIN" name="dtFECHAFIN" onChange="calculaFechaFin()"/>&nbsp;
            	<!--** <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FINPROGRAMA"/> ** -->
					<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_posterior_entrega']/node()"/>.</span>
        	  </td>
        	</tr>
        </xsl:when>
        <xsl:otherwise>
        	<tr class="sinLinea">
        	  <td class="labelRight grisMed">
          		<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_finalizacion_programa']/node()"/>:&nbsp;
        	  </td>
        	  <td class="datosLeft">
				<input type="hidden" id="FECHANO_FIN" name="FECHANO_FIN" value="{PedidosProgramados/PEDIDOPROGRAMADO/FINPROGRAMA}"/><!--Utilizar para inicializar dtFECHAFIN-->
				<input type="date" class="campopesquisa" id="dtFECHAFIN" name="dtFECHAFIN" onChange="javascript:calculaFechaFin();"/>&nbsp;
				<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_posterior_entrega']/node()"/>.</span>
                <!--16set22	  <input type="text" name="FECHANO_FIN" size="14" maxlength="10" onFocus="this.blur();" style="text-align:left;" class="inputOculto">
                    	<xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                    	  <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA!='F'">
                        	<xsl:attribute name="value">
                        	  <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FINPROGRAMA"/>
                        	</xsl:attribute>
                    	  </xsl:if>
                    	</xsl:if>
                	  </input>
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_posterior_entrega']/node()"/>.-->
        	  </td>
        	</tr>
        </xsl:otherwise>
        </xsl:choose>
      
            <input type="hidden" size="2" maxlength="5" name="PLAZOENTREGA" value="{PedidosProgramados/PEDIDOPROGRAMADO/PLAZOENTREGA}" class="inputOculto"  onFocus="this.blur();">
              <xsl:choose>
                <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                  <xsl:attribute name="value">
                    <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/PLAZOENTREGA"/>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="value">3</xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
            </input>
          
            <input type="hidden" name="FECHANO_LANZAMIENTO" size="14" maxlength="10" onblur="calculaFecha(document.forms['form1'],this,document.forms['form1'].elements['PLAZOENTREGA'].value);"/>
          
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_conf_envio']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <input class="muypeq" type="checkbox" name="CONFIRMAR" onCLick="SolicitarFecha('FIN',this);">
                    <xsl:choose>
                      <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                        <xsl:attribute name="valor">EXISTE or DESDEOFERTA</xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:choose>
                          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/CONFIRMAR='S'">
                            <xsl:attribute name="checked">checked</xsl:attribute>
                            <xsl:attribute name="valor">s</xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                            <xsl:attribute name="valor">n</xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>
                  </input>
               <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
               <span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_conf_cada_pedido_programado']/node()"/>.</span>
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight grisMed">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_anexos_ped_programado']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
	          <textarea name="COMENTARIOS" cols="50" rows="3">
                    <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/COMENTARIOS"/>
                  </textarea>&nbsp;&nbsp;&nbsp;           
              <a class="btnDiscreto" href="javascript:ultimosComentarios('COMENTARIOS','form1','MULTIOFERTAS');">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>
              </a>
	             
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_visible_proveedor']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
          
                  <input class="muypeq" type="checkbox" name="MOSTRARALPROVEEDOR">
                    <xsl:choose>
                      <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">           
                        <xsl:attribute name="checked">checked</xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:choose>
                          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/PEDP_MOSTRARALPROVEEDOR='S'">
                            <xsl:attribute name="checked">checked</xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>
                  </input> 
                <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>  
                <span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='programa_visible_proveedor_expli']/node()"/>. </span>
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_activo']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
           
            	<input class="muypeq" type="checkbox" name="ACTIVO">
            	  <xsl:choose>
                	<xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                	  <xsl:attribute name="checked">checked</xsl:attribute>
                	</xsl:when>
                	<xsl:otherwise>
                	  <xsl:choose>
                    	<xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/INACTIVO='S'">
                    	  <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                    	</xsl:when>
                    	<xsl:otherwise>
                    	  <xsl:attribute name="checked">checked</xsl:attribute>
                    	</xsl:otherwise>
                	  </xsl:choose>
                	</xsl:otherwise>
            	  </xsl:choose>
            	</input>
            	<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>   
        		<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='programa_activo_expli']/node()"/>.</span>

      </td>
     </tr>
     <tr class="sinLinea">
        <td colspan="2">&nbsp;</td>
     </tr>       
     <tr class="sinLinea">
       <td>&nbsp;</td><td class="labelLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/> (<span class="camposObligatorios">*</span>) <xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.</td>
     </tr>
    </table>
    
    
   
     <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
      
         
  </div><!--fin de divLeft-->
  </div>
  </form>

      </xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
