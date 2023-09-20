<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Derechos de usuarios sobre una plantilla
	ultima revisión:	ET 20nov19 	16:20 PLManten_201119.js
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

<html>
<head>
  	<!--style-->
  	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<title>
		<xsl:value-of select="/Mantenimiento/PLANTILLA/NOMBRE"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/>
	</title>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/PLManten_201119.js"></script>

<script type="text/javascript">
<!--
    //Si PROGRAMADA esta checked miramos si
    //FECHANO_ACTIVACION existe y es correcto
    //o si PERIODOACTIVACION y ademas FECHANO_ACTIVACION existen y son correctos
    //if (validaNombre(formu)==true &&  validaPeriodoActivacion(formu)==true && validaFechaSiEstaProgramada(formu)==true) {
-->
    msgAfectaUsuarioPropietario='No se pueden quitar los derechos de acceso al propietario de la plantilla.';
    msgSinPlantilla='Ha de guardar la nueva plantilla antes de poder autorizar empresas a usarla.';

    var Edicion='READ_ONLY';

    <xsl:if test="Mantenimiento/PLANTILLA/EDICION">
      Edicion='EDICION';
    </xsl:if>

    var idUsuarioPropietario='<xsl:value-of select="/Mantenimiento/PLANTILLA/USUARIOS/field/@current"/>';

    <xsl:choose>
    <xsl:when test="/Mantenimiento/PLANTILLA/EDICION">
      var aplicarDerechos='S';
    </xsl:when>
    <xsl:otherwise>
      var aplicarDerechos='N';
    </xsl:otherwise>
    </xsl:choose>

/*
    creo un array bidimensional en la primera posicion de cada registro guardo el id centro
    y despues el id de todos los usuarios de este centro

    0 [idCentro],[idUsuario],[idUsuario],[idUsuario]
    1 [idCentro],[idUsuario]
    2 [idCentro],[idUsuario],[idUsuario],
    ...
*/
    if(aplicarDerechos=='S'){
      arrayUsuarios=new Array(<xsl:value-of select="count(/Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/CENTRO)"/>);

      <xsl:for-each select="/Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/CENTRO">
        var i='<xsl:value-of select="position()-1"/>';
        arrayUsuarios[parseInt(i)]=new Array(<xsl:value-of select="count(USUARIO)+1"/>);
        arrayUsuarios[i][0]=<xsl:value-of select="ID"/>;
        <xsl:for-each select="USUARIO">
          var j='<xsl:value-of select="position()"/>';
          arrayUsuarios[i][j]=<xsl:value-of select="ID"/>;
        </xsl:for-each>
      </xsl:for-each>
    }
	
	var msgPL0340='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0340']"/>';
	var msgPL0275='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0275']"/>';
	var msgPL0270='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0270']"/>';

</script>
</head>

<!--<body onLoad="inicializarDerechosPorUsuario(document.forms[0]);" class="gris">-->
<body onLoad="inicializarDerechosPorUsuario(document.forms[0]);">
  <xsl:choose>
  <xsl:when test="Mantenimiento/SESION_CADUCADA">
    <xsl:apply-templates select="Mantenimiento/SESION_CADUCADA"/>
  </xsl:when>
  <xsl:when test="Mantenimiento/PLANTILLA/EDICION">
    <xsl:call-template name="MantenimientoEdicion"/>
  </xsl:when>
  <xsl:otherwise>
    <xsl:call-template name="MantenimientoReadOnly"/>
  </xsl:otherwise>
  </xsl:choose>
</body>
</html>
</xsl:template>

<!--
 |  Templates
 +-->
<xsl:template name="MantenimientoEdicion">
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <form>
    <xsl:attribute name="name">form1</xsl:attribute>
    <xsl:attribute name="action">PLManten.xsql</xsl:attribute>
    <xsl:attribute name="method">post</xsl:attribute>
    <xsl:call-template name="PL_ID"/>
    <xsl:call-template name="IDEMPRESA"/>
    <xsl:call-template name="NUMERO"/>
    <xsl:call-template name="CONDICIONESGENERALES"/>
    <xsl:call-template name="STATUS"/>
    <xsl:call-template name="IDDIVISA"/>

	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" value=""/>
	<input type="hidden" name="NOMBRE" value="{/Mantenimiento/PLANTILLA/NOMBRE}"/>
	<input type="hidden" name="PLAZOENTREGA" value="{/Mantenimiento/PLANTILLA/PLAZOENTREGA}"/>
	<input type="hidden" name="DERECHOS"/>
    <input type="hidden" name="IDUSUARIO_ACTUAL" value="{/Mantenimiento/US_ID}"/>
    <input type="hidden" name="TIPO_MODIFICACION">
      <xsl:choose>
	    <xsl:when test="/Mantenimiento/PLANTILLA/EDICION">
	      <xsl:attribute name="value">EDICION</xsl:attribute>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:attribute name="value">READ_ONLY</xsl:attribute>
	    </xsl:otherwise>
      </xsl:choose>
    </input>

<!--
  |  Cuando generamos una plantilla no dejamos modificar el nombre ni la descripciï¿½n
  |  de la plantilla. Los copiamos en campos ocultos para que se copien en la lista
  |  de productos.
+-->
	<xsl:if test="Mantenimiento/BOTON[.='Generar']">
		<input type="hidden" name="PL_NOMBRE" value="{PL_NOMBRE}"/>
		<input type="hidden" name="PL_DESCRIPCION" value="{PL_DESCRIPCION}"/>
	</xsl:if>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/></span>
			<span class="CompletarTitulo">
				<xsl:if test="/Mantenimiento/PLANTILLA/ADMIN">
					<span class="amarillo">PL_ID:&nbsp;<xsl:value-of select="/Mantenimiento/PLANTILLA/ID"/></span>
				</xsl:if>
			</span>
		</p>
		<p class="TituloPagina">
			<!--<xsl:value-of select="/Mantenimiento/PLANTILLA/NOMBRE"/>-->
			<xsl:call-template name="desplegable">
			    <xsl:with-param name="path" select="/Mantenimiento/PLANTILLA/PLANTILLAS/field"/>
			    <xsl:with-param name="style">width:600px;height:30px;font-size:15px;</xsl:with-param>
			    <xsl:with-param name="onChange">javascript:cbPlantillaChange();</xsl:with-param>
			</xsl:call-template>

			<span class="CompletarTitulo">
				<!--	botones	-->
				<a class="btnDestacado" href="javascript:Actua(document.forms[0]);"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
				&nbsp;
				<!--<a class="btnNormal" href="../NuevaMultioferta/AreaTrabajo.html"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>
				&nbsp;-->
				<a class="btnNormal" href="javascript:ListaProductosPlantilla();"><xsl:value-of select="document($doc)/translation/texts/item[@name='productos_en_plantillas']/node()"/></a>
				&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
	
	<!--
    <h1 class="titlePage">
    	<xsl:choose>
      <xsl:when test="Mantenimiento/BOTON[.='Generar']">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/>
      </xsl:otherwise>
      </xsl:choose>

    <xsl:if test="/Mantenimiento/PLANTILLA/ADMIN">
      <span style="float:right; padding:5px;" class="amarillo">PL_ID:&nbsp;<xsl:value-of select="/Mantenimiento/PLANTILLA/ID"/></span>
    </xsl:if>
    </h1>
	-->

    <table class="buscador">
      <input type="checkbox" name="PUBLICA" style="display:none;">
        <xsl:choose>
        <xsl:when test="Mantenimiento/PLANTILLA/PUBLICA='S'">
          <xsl:attribute name="checked"></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="unchecked"></xsl:attribute>
        </xsl:otherwise>
        </xsl:choose>
      </input>
	<!--
      <tr class="sinLinea">
        <td class="labelRight cinquenta"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;</label></td>
        <td colspan="3" class="datosLeft"><xsl:call-template name="NOMBRE"/></td>
      </tr>
	  -->

      <tr class="sinLinea">
        <td class="labelRight cinquenta"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;</label></td>
        <td colspan="3" class="datosLeft"><strong><xsl:value-of select="/Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/TOTAL_PRODUCTOS"/></strong></td>
      </tr>
      <tr class="sinLinea">
        <td class="labelRight"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;</label></td>
        <td colspan="3" class="datosLeft"><xsl:call-template name="DESCRIPCION"/></td>
      </tr>

      <tr class="sinLinea">
        <td class="labelRight"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:&nbsp;</label></td>
        <td colspan="3" class="datosLeft">
          <xsl:choose>
          <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">
            <xsl:call-template name="desplegable">
              <xsl:with-param name="path" select="Mantenimiento/PLANTILLA/USUARIOS/field"/>
              <xsl:with-param name="onChange">CambioResponsable(this.value);</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="USUARIO"/>
            <xsl:call-template name="IDUSUARIO"/>
          </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>

    <xsl:choose>
    <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">
      <input type="hidden" name="{Mantenimiento/PLANTILLA/CENTROS/field/@name}" value="{Mantenimiento/PLANTILLA/CENTROS/field/@current}"/>
    </xsl:when>
    <xsl:otherwise>
      <input type="hidden" name="{Mantenimiento/PLANTILLA/CENTROS/field/@name}" value="{Mantenimiento/PLANTILLA/CENTROS/field/@current}"/>
    </xsl:otherwise>
    </xsl:choose>

    <tr style="display:none;"><!--	14dic16 ocultamos la carpeta	-->
        <td class="labelright"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='carpeta']/node()"/>:&nbsp;</label></td>
        <td colspan="3" class="datosLeft"><xsl:call-template name="CARPETAS"/></td>
    </tr>

    <xsl:choose>
    <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">
      <input type="hidden" name="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@current}"/>
    </xsl:when>
    <xsl:otherwise>
      <input type="hidden" name="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@current}"/>
    </xsl:otherwise>
    </xsl:choose>
<!--	19nov19
      <tr class="sinLinea">
        <td class="labelRight"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_entrega']/node()"/>:&nbsp;</label></td>
        <td colspan="3" class="datosLeft">
          <xsl:choose>
          <xsl:when test="/Mantenimiento/PLANTILLA/PLAZOENTREGA=''">
            <xsl:call-template name="field_funcion">
              <xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_ENTREGA']"/>
              <xsl:with-param name="IDAct">3</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="field_funcion">
              <xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_ENTREGA']"/>
              <xsl:with-param name="IDAct" select="/Mantenimiento/PLANTILLA/PLAZOENTREGA"/>
            </xsl:call-template>
          </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
	  -->
      <!--plantilla de reserva-->

	    <input type="checkbox" name="URGENCIA" style="display:none;">
        <xsl:choose>
	      <xsl:when test="Mantenimiento/PLANTILLA/URGENCIA='N'">
	        <xsl:attribute name="unchecked"></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
         	<xsl:attribute name="checked"></xsl:attribute>
        </xsl:otherwise>
        </xsl:choose>
	    </input>

      <!--<tr>
        <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla_de_reserva']/node()"/>:</td>
        <td colspan="3" class="datosLeft"><xsl:call-template name="URGENCIA"/></td>
      </tr>-->
    </table>
	<br/>

    <!--	Derechos de acceso a la plantilla para cada usuario		-->

    <!--<table class="mediaTabla" border="0">-->
    <table class="buscador">
	<!--
    <thead>
      <tr class="subTituloTabla">
        <th colspan="7"><xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_acceso_plantilla']/node()"/></th>
      </tr>
    </thead>
	-->
	<!--<tr class="tituloGris">-->
	<tr class="subTituloTabla">
        <td>&nbsp;</td>
        <td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
        <td class="cinco">
			<!--<xsl:if test="not(Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">-->
			<xsl:if test="Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla']/node()"/><br/>
			</xsl:if>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='lectura']/node()"/>
			<xsl:if test="not(Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">
				<br />
				&nbsp;<a href="javascript:selTodosEscrituraLectura('LECT_',document.forms[0]);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
			    </a>
			</xsl:if>
        </td>
        <td class="cinco">
			<!--<xsl:if test="not(Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">-->
			<xsl:if test="Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla']/node()"/><br/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='bloqueados']/node()"/>
			</xsl:if>
			<xsl:if test="not(Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='escritura']/node()"/>
				<br />
				&nbsp;<a href="javascript:selTodosEscrituraLectura('ESCR_',document.forms[0]);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
			    </a>
			</xsl:if>
        </td>
        <td class="cinco">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultos_mayu']/node()"/>
        </td>
        <td class="cinco">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='bloqueados']/node()"/>
        </td>
        <td style="width:150px">
			<xsl:if test="not(Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">
          		<a class="btnDestacado" href="javascript:MostrarTodos('EMPRESA',{Mantenimiento/PLANTILLA/IDEMPRESA});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mostrar_Todos']/node()"/></a>
			</xsl:if>
        </td>
        <td style="width:150px">
			<xsl:if test="not(Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">
           		<a class="btnDestacado" href="javascript:OcultarTodos('EMPRESA',{Mantenimiento/PLANTILLA/IDEMPRESA});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ocultar_Todos']/node()"/></a>
			</xsl:if>
        </td>
        <td style="width:150px">
			<xsl:if test="not(Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">
           		<a class="btnDestacado" href="javascript:BloquearTodos('EMPRESA',{Mantenimiento/PLANTILLA/IDEMPRESA});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Bloquear_Todos']/node()"/></a>
			</xsl:if>
        </td>
        <td>&nbsp;</td>
      </tr>

    <tbody>
	  <xsl:for-each select="Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/CENTRO">
		<input type="hidden">
			<xsl:attribute name="name">CENTRO_ID_<xsl:value-of select="ID"/></xsl:attribute>
    	<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
 		</input>

		<tr>
        	<td>&nbsp;</td>
			<td class="textLeft"><strong><xsl:value-of select="./NOMBRE"/></strong></td>
        	<td colspan="center">
				<xsl:if test="LECTURA">
    				<xsl:value-of select="LECTURA"/>
				</xsl:if>
				<input type="hidden">
					<xsl:attribute name="name">ESCR_TODOS_<xsl:value-of select="ID"/></xsl:attribute>
					<xsl:attribute name="value">false</xsl:attribute>
				</input>
        	</td>
			<td class="center">
				<xsl:if test="SIN_LECTURA">
    				<xsl:value-of select="SIN_LECTURA"/>
				</xsl:if>
				<input type="hidden">
					<xsl:attribute name="name">LECT_TODOS_<xsl:value-of select="ID"/></xsl:attribute>
					<xsl:attribute name="value">false</xsl:attribute>
				</input>
        	</td>
			<td class="center">
				<xsl:if test="PRODUCTOS_OCULTOS">
    				<xsl:value-of select="PRODUCTOS_OCULTOS"/>
				</xsl:if>
			</td>
			<td class="center">
				<xsl:if test="PRODUCTOS_BLOQUEADOS">
    				<xsl:value-of select="PRODUCTOS_BLOQUEADOS"/>
				</xsl:if>
			</td>
			<td class="center">
				<xsl:if test="BOTON_MOSTRARTODOS">
					<xsl:choose>
					<xsl:when test="not(/Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">
    					<a class="btnDestacado" href="javascript:MostrarTodos('CENTRO',{ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mostrar_Todos']/node()"/></a>
					</xsl:when>
					<xsl:otherwise>
    					<a class="btnDestacado" href="javascript:MostrarEnCentro({ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mostrar_Todos']/node()"/></a>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>
			<td class="center">
				<xsl:if test="BOTON_OCULTARTODOS">
					<xsl:choose>
					<xsl:when test="not(/Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">
    					<a class="btnDestacado" href="javascript:OcultarTodos('CENTRO',{ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ocultar_Todos']/node()"/></a>
					</xsl:when>
					<xsl:otherwise>
    					<a class="btnDestacado" href="javascript:OcultarEnCentro({ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ocultar_Todos']/node()"/></a>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>
			<td class="center">
				<xsl:if test="BOTON_BLOQUEARTODOS and not(/Mantenimiento/PLANTILLA/DERECHOSPORUSUARIO/DERECHOSPORCENTRO)">
   					<a class="btnDestacado" href="javascript:BloquearTodos('CENTRO',{ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Bloquear_Todos']/node()"/></a>
				</xsl:if>
			</td>
	        <td>&nbsp;</td>
		</tr>

	  	<xsl:for-each select="./USUARIO">
			<input type="hidden">
				<xsl:attribute name="name">USUARIO_ID_<xsl:value-of select="ID"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
			</input>

			<tr>
	        <td>&nbsp;</td>
			<td class="textLeft"><xsl:value-of select="./NOMBRE"/></td>
			<td class="center"><input type="checkbox">
				<xsl:attribute name="name">LECT_<xsl:value-of select="ID"/></xsl:attribute>
				<xsl:attribute name="onClick">validacionEscrituraLectura('LECT',<xsl:value-of select="ID"/>,'ESTE',document.forms[0]);</xsl:attribute>
	    	<xsl:choose>
	      		<xsl:when test="./LECTURA='S' or (/Mantenimiento/PLANTILLA/@ID='' and /Mantenimiento/PLANTILLA/IDUSUARIO=ID)">
							<xsl:attribute name="checked"></xsl:attribute>
	      		</xsl:when>
	      		<xsl:otherwise>
							<xsl:attribute name="unchecked"></xsl:attribute>
	      		</xsl:otherwise>
	    			</xsl:choose>
					</input></td>
					<td class="center"><input type="checkbox">
						<xsl:attribute name="name">ESCR_<xsl:value-of select="ID"/></xsl:attribute>
						<xsl:attribute name="onClick">validacionEscrituraLectura('ESCR',<xsl:value-of select="ID"/>,'ESTE',document.forms[0]);</xsl:attribute>
	    			<xsl:choose>
	      		<xsl:when test="./ESCRITURA='S' or (/Mantenimiento/PLANTILLA/@ID='' and /Mantenimiento/PLANTILLA/IDUSUARIO=ID)">
							<xsl:attribute name="checked"></xsl:attribute>
	      		</xsl:when>
	      		<xsl:otherwise>
							<xsl:attribute name="unchecked"></xsl:attribute>
	      		</xsl:otherwise>
	    			</xsl:choose>
					</input></td>
          <td class="center">
            <xsl:choose>
            <xsl:when test="PRODUCTOS_OCULTOS != 0">
              <span class="orange"><xsl:value-of select="PRODUCTOS_OCULTOS"/></span>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="PRODUCTOS_OCULTOS"/>
            </xsl:otherwise>
            </xsl:choose>
          </td>
          <td class="center">
            <xsl:choose>
            <xsl:when test="PRODUCTOS_BLOQUEADOS != 0">
              <span class="rojo"><xsl:value-of select="PRODUCTOS_BLOQUEADOS"/></span>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="PRODUCTOS_BLOQUEADOS"/>
            </xsl:otherwise>
            </xsl:choose>
          </td>
          <td class="center">
          	<xsl:if test="BOTON_MOSTRARTODOS">
              	<a class="btnDestacado" href="javascript:MostrarTodos('', {ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mostrar_Todos']/node()"/></a>
          	</xsl:if>
          </td>
          <td class="center">
          	<xsl:if test="BOTON_OCULTARTODOS">
              	<a class="btnDestacado" href="javascript:OcultarTodos('', {ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ocultar_Todos']/node()"/></a>
          	</xsl:if>
          </td>
          <td class="center">
          	<xsl:if test="BOTON_BLOQUEARTODOS">
              	<a class="btnDestacado" href="javascript:BloquearTodos('', {ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Bloquear_Todos']/node()"/></a>
          	</xsl:if>
          </td>
          <td>&nbsp;</td>
		</tr>
	  	</xsl:for-each>
	  </xsl:for-each>
    </tbody>
    </table><!--fin usuarios-->
	<!--
    <br /><br />

    <table class="mediaTabla">
      <tr>
        <xsl:choose>
	      <xsl:when test="Mantenimiento/BOTON[.='CABECERA']">
          <td class="trenta">&nbsp;</td>
	        <td class="veinte">
		        <xsl:call-template name="boton">
	            <xsl:with-param name="path" select="Mantenimiento/button[@label='Cancelar']"/>
	          </xsl:call-template>
		      </td>
		      <td class="quince">&nbsp;</td>
		      <td>
		        <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/button[@label='Aceptar']"/>
            </xsl:call-template>
		      </td>
	      </xsl:when>
	      <xsl:otherwise>
		      <td class="trenta">&nbsp;</td>
	        <td class="veinte">
		        <xsl:call-template name="boton">
	            <xsl:with-param name="path" select="Mantenimiento/button[@label='Cancelar']"/>
	          </xsl:call-template>
		      </td>
		      <td class="quince">&nbsp;</td>
		      <td>
		        <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/button[@label='Aceptar']"/>
            </xsl:call-template>
		      </td>
	      </xsl:otherwise>
        </xsl:choose>
      </tr>
    </table>
	-->
  </form>
</xsl:template>

<xsl:template name="MantenimientoReadOnly">
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <form>
    <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:attribute name="action">PLManten.xsql</xsl:attribute>
    <xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute>
    <xsl:call-template name="PL_ID"/>
    <xsl:call-template name="IDEMPRESA"/>
    <xsl:call-template name="NUMERO"/>
    <xsl:call-template name="CONDICIONESGENERALES"/>
    <xsl:call-template name="STATUS"/>
    <xsl:call-template name="IDDIVISA"/>
    <input type="hidden" name="IDUSUARIO_ACTUAL" value="{/Mantenimiento/US_ID}"/>
    <input type="hidden" name="TIPO_MODIFICACION">
  	  <xsl:choose>
  	  <xsl:when test="/Mantenimiento/PLANTILLA/EDICION">
  	    <xsl:attribute name="value">EDICION</xsl:attribute>
  	  </xsl:when>
  	  <xsl:otherwise>
  	    <xsl:attribute name="value">READ_ONLY</xsl:attribute>
  	  </xsl:otherwise>
  	  </xsl:choose>
    </input>
    <!--
     |  Cuando generamos una plantilla no dejamos modificar el nombre ni la descripciï¿½n
     |  de la plantilla. Los copiamos en campos ocultos para que se copien en la lista
     |  de productos.
     +-->
    <xsl:if test="Mantenimiento/BOTON[.='Generar']">
      <input type="hidden" name="PL_NOMBRE" value="{PL_NOMBRE}"/>
      <input type="hidden" name="PL_DESCRIPCION" value="{PL_DESCRIPCION}"/>
    </xsl:if>

    <h1 class="titlePage">
      <xsl:choose>
      <xsl:when test="Mantenimiento/BOTON[.='Generar']">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades_plantilla']/node()"/>
      </xsl:otherwise>
      </xsl:choose>
    </h1>

    <table class="infoTable" border="0">
      <tr>
        <td class="cinquenta labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:</td>
        <td class="datosLeft"><xsl:value-of select="Mantenimiento/PLANTILLA/NOMBRE"/></td>
      </tr>

    <xsl:if test="Mantenimiento/PLANTILLA/DESCRIPCION != ''">
      <tr>
        <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
        <td class="datosLeft"><xsl:value-of select="Mantenimiento/PLANTILLA/DESCRIPCION"/></td>
      </tr>
    </xsl:if>

      <tr>
        <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</td>
        <td class="datosLeft"><xsl:value-of select="Mantenimiento/PLANTILLA/USUARIO"/></td>
      </tr>

    <xsl:choose>
    <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">
      <input type="hidden" name="{Mantenimiento/PLANTILLA/CENTROS/field/@name}" value="{Mantenimiento/PLANTILLA/CENTROS/field/@current}"/>
    </xsl:when>
    <xsl:otherwise>
      <input type="hidden" name="{Mantenimiento/PLANTILLA/CENTROS/field/@name}" value="{Mantenimiento/PLANTILLA/CENTROS/field/@current}"/>
    </xsl:otherwise>
    </xsl:choose>

      <tr>
        <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='carpeta']/node()"/>:</td>
        <td class="datosLeft">
        <xsl:for-each select="Mantenimiento/PLANTILLA/CARPETAS/field/dropDownList/listElem">
          <xsl:if test="ID=../../@current">
	  	      <xsl:value-of select="listItem"/>
	  	    </xsl:if>
	  	  </xsl:for-each>
        </td>
      </tr>

    <xsl:choose>
    <xsl:when test="Mantenimiento/PLANTILLA/CENTRALCOMPRAS">
      <input type="hidden" name="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@current}"/>
    </xsl:when>
    <xsl:otherwise>
      <input type="hidden" name="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@name}" value="{Mantenimiento/PLANTILLA/DERECHOSACCESO/field/@current}"/>
    </xsl:otherwise>
    </xsl:choose>
    <!-- comentamos de momento
    <tr>
    <td class="labelRight">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0240' and @lang=$lang]" disable-output-escaping="yes"/>:
	</td>
    <td class="datosLeft">
                <xsl:call-template name="FORMASPAGO"/>
	  	<xsl:call-template name="PLAZOSPAGO"/>
  	    <input type="text" size="50" name="FORMAPAGO" maxlength="100">
    		<xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/FORMAPAGO"/></xsl:attribute>
  		</input>

      </td>
	</tr>
    <tr>
      <td class="labelRight">
        Plazo de Entrega:
      </td>
      <td class="datosLeft">
        <xsl:choose>
          <xsl:when test="/Mantenimiento/PLANTILLA/PLAZOENTREGA=''">
            <xsl:call-template name="field_funcion">
    	      <xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_ENTREGA']"/>
    	      <xsl:with-param name="IDAct">3</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="field_funcion">
    	      <xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_ENTREGA']"/>
    	      <xsl:with-param name="IDAct" select="/Mantenimiento/PLANTILLA/PLAZOENTREGA"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
    <tr>
      <td class="labelRight">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0287' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td class="datosLeft">
        <xsl:choose>
          <xsl:when test="Mantenimiento/PLANTILLA/URGENCIA='N'">
            No urgente
          </xsl:when>
          <xsl:otherwise>
            <font color="red">RESERVA</font>
          </xsl:otherwise>
          </xsl:choose>
      </td>
    </tr>   -->
    <tr>
      <td colspan="2">
      	<div class="botonCenter">
        	<a href="http://www.newco.dev.br/Compras/NuevaMultioferta/AreaTrabajo.html"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
		</div>
      </td>
    </tr>
  </table>
</form>
</xsl:template>



<!-- CAMPS OCULTS -->
<xsl:template name="PL_ID">
  <input type="hidden" name="PL_ID">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/ID"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template name="IDEMPRESA">
  <input type="hidden" name="IDEMPRESA">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/IDEMPRESA"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template name="NUMERO">
  <input type="hidden" name="NUMERO">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/NUMERO"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template name="CONDICIONESGENERALES">
  <input type="hidden" name="CONDICIONESGENERALES">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/CONDICIONESGENERALES"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template name="IDDIVISA">
  <input type="hidden" name="IDDIVISA">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/IDDIVISA"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template name="STATUS">
  <input type="hidden" name="STATUS">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/STATUS"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template name="BOTON">
  <input type="hidden" name="BOTON">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/BOTON"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template name="PUBLICA">
	<input type="checkbox" name="PUBLICA">
    <xsl:choose>
    <xsl:when test="Mantenimiento/PLANTILLA/PUBLICA='S'">
	    <xsl:attribute name="checked"></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="unchecked"></xsl:attribute>
		</xsl:otherwise>
    </xsl:choose>
	</input>
</xsl:template>

<xsl:template name="NOMBRE">
  <input type="text" size="50" name="NOMBRE" maxlength="100">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/NOMBRE"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template name="DESCRIPCION">
  <input type="text" size="50" name="DESCRIPCION" maxlength="300">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/DESCRIPCION"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template name="USUARIO">
  <xsl:value-of select="Mantenimiento/PLANTILLA/USUARIO"/>
</xsl:template>

<xsl:template name="URGENCIA">
	<xsl:choose>
	<xsl:when test="Mantenimiento/PLANTILLA/SOLOURGENCIAS">
	  <font color="RED">RESERVA</font>
	  <input type="hidden" value="on" name="URGENCIA"/>
	</xsl:when>
	<xsl:otherwise>
	  <input type="checkbox" name="URGENCIA">
      <xsl:choose>
	    <xsl:when test="Mantenimiento/PLANTILLA/URGENCIA='N'">
	      <xsl:attribute name="unchecked"></xsl:attribute>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:attribute name="checked"></xsl:attribute>
		  </xsl:otherwise>
      </xsl:choose>
	  </input>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="CENTROS">
	<xsl:call-template name="desplegable">
    <xsl:with-param name="path" select="Mantenimiento/PLANTILLA/CENTROS/field"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="CARPETAS">
	<xsl:call-template name="desplegable">
    <xsl:with-param name="path" select="Mantenimiento/PLANTILLA/CARPETAS/field"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="DERECHOSACCESO">
	<xsl:call-template name="desplegable">
    <xsl:with-param name="path" select="Mantenimiento/PLANTILLA/DERECHOSACCESO/field"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="FORMASPAGO">
	<xsl:call-template name="desplegable">
    <xsl:with-param name="path" select="Mantenimiento/PLANTILLA/FORMASPAGO/field"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="PLAZOSPAGO">
	<xsl:call-template name="desplegable">
    <xsl:with-param name="path" select="Mantenimiento/PLANTILLA/PLAZOSPAGO/field"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="PL_PROGRAMADA">
  <xsl:choose>
  <xsl:when test=". ='1' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[
      <input type="checkbox" name="PL_PROGRAMADA" checked>
	  ]]></xsl:text>
  </xsl:when>
  <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[
      <input type="checkbox" name="PL_PROGRAMADA">
	  ]]></xsl:text>
  </xsl:otherwise>
  </xsl:choose>

  <xsl:text disable-output-escaping="yes"> <![CDATA[
    </input>
  ]]></xsl:text>
</xsl:template>

<xsl:template name="FECHANO_ACTIVACION">
  <input type="text" name="FECHANO_ACTIVACION" size="10" maxlength="10">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
  <text>dd/mm/aaaa</text>
</xsl:template>

<xsl:template name="PL_PERIODOACTIVACION">
  <input type="text" size="3" name="PL_PERIODOACTIVACION">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>&nbsp;dias
</xsl:template>

<xsl:template name="PL_FORMAPAGO">
  <textarea name="PL_FORMAPAGO" cols="50" rows="5">
    <xsl:value-of select="."/>
  </textarea>
</xsl:template>

<xsl:template name="PL_CONDICIONESGENERALES">
  <textarea name="PL_CONDICIONESGENERALES" cols="50" rows="5">
    <xsl:value-of select="."/>
  </textarea>
</xsl:template>

<xsl:template name="IDUSUARIO">
  <input type="hidden" name="IDUSUARIO">
    <xsl:attribute name="value"><xsl:value-of select="Mantenimiento/PLANTILLA/IDUSUARIO"/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="EMPRESASAUTORIZADAS">
	<!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

	<table class="mediaTabla">
    <tr>
      <td class="dies">&nbsp;</td>
      <td>
        <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_autorizadas']/node()"/></strong><br />
        <xsl:value-of select="document($doc)/translation/texts/item[@name='puede_establecer_empresas_autorizadasa']/node()"/>
      </td>
      <td>
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="/Mantenimiento/button[@label='EmpresasAutorizadas']"/>
        </xsl:call-template>
      </td>
      <td class="dies">&nbsp;</td>
    </tr>
  </table>

	<xsl:if test="./EMPRESA">
		<table class="mediaTabla">
			<tr class="tituloTabla">
				<th colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
			</tr>

		<xsl:for-each select="./EMPRESA">
			<tr>
        <td class="trenta" colspan="2">&nbsp;</td>
				<td class="sesanta"><xsl:value-of select="NOMBRE"/></td>
        <td class="dies">&nbsp;</td>
			</tr>
		</xsl:for-each>
		</table>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
