<?xml version="1.0" encoding="iso-8859-1" ?>
<!-- 
	Nueva empresa. Nuevo disenno 2022.
	ultima revision	ET 21mar22 12:00 EMPNueva2022_210322.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  

	<!--	Todos los documentos HTML deben empezar con esto	-->
	<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

    <html>
      <head> 
      	<title>Nueva empresa</title>
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->  
		<!--	11ene22 nuevos estilos -->
		<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
		<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
		<!--	11ene22 nuevos estilos -->

		<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
		<!--script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPNueva2022_210322.js"></script>
     
      </head>

      <body>
      <xsl:choose>
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>    
        		<xsl:apply-templates select="BusquedaEmpresas"/> 
        </xsl:otherwise>
        </xsl:choose>	 
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="BusquedaEmpresas">

<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/BusquedaEmpresas/LANG"><xsl:value-of select="/BusquedaEmpresas/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->

	<form name="BuscaEmpresa"  method="post">
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_empresa']/node()"/>
       		&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<!--	Botones	-->
        		<a class="btnDestacado"  href="javascript:CrearEmpresa();">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
            	</a>
				&nbsp;
        		<a class="btnNormal" href="javascript:document.location='about:blank'">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
            	</a>
				&nbsp;
			</span>
		</p>
	</div>
	
	
    <!--
     <h1 class="titlePage">   
       <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_empresa']/node()"/>:&nbsp;
       <xsl:value-of select="document($doc)/translation/texts/item[@name='datos_empresa']/node()"/>	       
  	  </h1>
	 -->
    
 <div class="divLeft">
	<input type="hidden" name="EMP_IDPAIS" value="{/BusquedaEmpresas/EMP_IDPAIS}"/>               
	<table class="w90 tableCenter" cellspacing="6px" cellpadding="6px">
    <tr class="sinLinea">
      <td class="textCenter" colspan="5">
        <span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span>
      </td>
    </tr>
    
    <!-- DATOS DE EMPRESA -->
    <tr class="sinLinea">

      <td class="quince labelRight dies">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span  class="camposObligatorios" width="1%">*</span>&nbsp;
      </td>

      <td class="datosLeft trenta">  
        <input type="text" class="campopesquisa" size="50" maxlength="100" name="EMP_NOMBRE"/>
      </td>
      <td class="quince labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:<span  class="camposObligatorios" width="1%">*</span>&nbsp;
      </td>

<!-- PS 20170119 
    <tr>
      <td colspan="6">&nbsp;</td>
    </tr>	
    <tr> 
      <td class="quince labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span  class="camposObligatorios" width="1%">*</span>
      </td>
      <td class="datosLeft trenta">  
	<input type="text" class="campopesquisa" size="50" maxlength="100" name="EMP_NOMBRE"/>
      </td>
      <td class="quince labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:<span  class="camposObligatorios" width="1%">*</span>
      </td>-->
      <td class="veintecinco datosLeft">  
	<input type="text" class="campopesquisa" size="20" maxlength="20" name="EMP_NIF"/>&nbsp;

		<span class="fuentePeq">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_recomendado']/node()"/>
        </span>
      </td>
    </tr>		    		          	          	    
    <tr class="sinLinea">
       <td class="labelRight">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:<span  class="camposObligatorios">*</span>&nbsp;
      </td>
      <td class="datosLeft">
	<input type="text" class="campopesquisa" size="50" maxlength="100"  name="EMP_DIRECCION"/>               
      </td>
      <td class="labelRight">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/>:&nbsp;
      </td>
      <td class="datosLeft">
			<input type="text" class="campopesquisa" size="25" maxlength="15" name="EMP_CPOSTAL"/>
      </td>
    </tr>	
    <tr class="sinLinea">
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:<span  class="camposObligatorios">*</span>&nbsp;
      </td>
      <td class="datosLeft">
	<xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="/BusquedaEmpresas/NUEVAEMPRESA/field[@name='EMP_PROVINCIA']"/>
    	  <xsl:with-param name="IDAct"/>
    	</xsl:call-template>
      </td>
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>:<span  class="camposObligatorios">*</span>&nbsp;
      </td> 
      <td class="datosLeft">
	<input type="text" class="campopesquisa" size="25" maxlength="200" name="EMP_POBLACION"/> 	     
      </td>
    </tr>	
    <tr class="sinLinea">
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:<span  class="camposObligatorios">*</span>&nbsp;
      </td>
      <td class="datosLeft">
	<input type="text" class="campopesquisa" size="25" maxlength="50" name="EMP_TELEFONO"/> 	     
      </td>
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='fax']/node()"/>:&nbsp;
      </td>
      <td class="datosLeft">  
	 <input type="text" class="campopesquisa" size="25" maxlength="50" name="EMP_FAX"/>
      </td>
    </tr> 
    <tr class="sinLinea">
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_empresa']/node()"/>:<span  class="camposObligatorios">*</span>&nbsp;
      </td>
      <td class="datosLeft">
	  	<!--22oct21
          <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="/BusquedaEmpresas/NUEVAEMPRESA/field[@name='EMP_IDTIPO']"/>
    	  <xsl:with-param name="IDAct" select="TE_ID"/>
    	</xsl:call-template>
		-->
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/BusquedaEmpresas/NUEVAEMPRESA/EMP_IDTIPO/field"/>
				<xsl:with-param name="style">width:250px</xsl:with-param>
			</xsl:call-template>
      </td>
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='zona_comercial']/node()"/>:
      </td>
       <td class="datosLeft" >
		<input type="text" class="campopesquisa" size="25" maxlength="200" name="EMP_ZONACOMERCIAL" value="España"/>
      </td>
    </tr>
    <tr class="sinLinea">
       <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='comision_ahorro']/node()"/>:<span  class="camposObligatorios">*</span>&nbsp;
       </td>
        <td class="datosLeft">
        	<input type="text" class="campopesquisa" name="EMP_COMISION_AHORRO"  maxlength="5" size="5" value="{EMP_COMISION_AHORRO}"/>  
        </td>
       <td class="labelRight">
       	<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_transacciones']/node()"/>:<span  class="camposObligatorios">*</span>&nbsp;
       </td>
       <td class="datosLeft">
        	<input type="text" class="campopesquisa" name="EMP_COMISION_TRANSACCIONES"  maxlength="5" size="5" value="{EMP_COMISION_TRANSACCIONES}"/>  
        </td>
    </tr>
<!--    <tr>
       <td class="labelRight">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0285' and @lang=$lang]" disable-output-escaping="yes"/>:<span  class="camposObligatorios">*</span>
      </td>
      <td class="datosLeft">
         <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="field[@name='EMP_ESPECIALIDAD']"/>
    	  <xsl:with-param name="IDAct">NULL</xsl:with-param>
    	</xsl:call-template>
      </td>
       <td class="labelRight">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0295' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
       <td colspan="3" class="datosLeft" >
		<input type="text" class="campopesquisa" size="25" maxlength="200" name="EMP_ZONACOMERCIAL" value="España"/>
      </td>
    </tr>-->
    <tr class="sinLinea">
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='central_de_compras']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft"> 
              <input type="checkbox" name="EMP_SERVICIOSCDC" class="muypeq"/>
           	  <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='central_de_compras_expli']/node()"/>
             
      </td>
    </tr>
    <tr class="sinLinea">
       <td class="labelRight">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_externa']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft"> 
              <input type="checkbox" name="EMP_EXTERNA" class="muypeq"/>
              <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_externa_expli']/node()"/>
      </td>
    </tr>
  
    <tr class="sinLinea"> 
       <td class="labelRight" valign="top">
       		 <xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_comercial']/node()"/>:&nbsp;
      </td>
      <td colspan="2" class="datosLeft"> 
	       <textarea name="EMP_REFERENCIAS" cols="60" rows="5"/>               
      </td>
    </tr>
    <tr><td colspan="6">&nbsp;</td></tr>
 
    <tr class="sinLinea">
       <td class="labelRight">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:
      </td>
      <td class="datosLeft">
         <table class="infoTable">
           <tr>
             <td class="labelRight trenta">
               <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>:
             </td>
             <td class="datosLeft">
               <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);" class="muypeq"/>
             </td>
              <td class="datosLeft">
               &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='activar_control_pedido_minimo']/node()"/>.
             </td>
           </tr>
           <tr>
             <td class="labelRight">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/>:
             </td>
            <td class="datosLeft">
   	       <input type="checkbox" disabled="disabled" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);" class="muypeq"/>
   	     </td>
   	     <td class="datosLeft">
               &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no_permitir_pedidos_debajo_pedido_minimo']/node()"/>.
             </td>
   	   </tr>
   	   <tr>
   	      <td class="labelRight">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='no_aceptar_ofertas']/node()"/>:
             </td>
          <td class="datosLeft">
   	       <input type="checkbox" name="EMP_INTEGRADO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);" class="muypeq"/>
   	     </td>
   	     <td class="datosLeft">
               &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='permitir_unicamente_envio_pedidos']/node()"/>.
             </td>
   	   </tr>
       </table>
       <input type="hidden" name="EMP_PEDMINIMOACTIVO" value=""/>
      </td>
      <td align="right" class="claro">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='importe_minimo_eur']/node()"/>:
      </td>
      <td>  
	<input type="text" class="campopesquisa" name="EMP_PEDIDOMINIMO" disabled="disabled" onBlur="checkNumber(this.value, this);"/>
      </td>
    </tr>
    <tr class="sinLinea">
      <td class="labelRight">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_pedido_minimo']/node()"/>: 
      </td>
      <td colspan="3" class="datosLeft">  
   	 <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="5" disabled="disabled"></textarea>
      </td>
    </tr>
    
  </table>
  
 <br/>
  
  <!-- DEPARTAMENTOS -->
  <!--<table class="infoTable">-->
  <table class="buscador">
     <tr class="tituloTabla">
        <th colspan="2">
        	 <xsl:value-of select="document($doc)/translation/texts/item[@name='departamento']/node()"/>
        </th>
    </tr>
    <tr class="sinLinea">
      <td colspan="2">&nbsp;</td></tr>
    <tr class="sinLinea">
      <td class="cuanrenta labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_departamento']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
      </td>
      <td class="datosLeft">
        <input type="text" class="campopesquisa" size="35" maxlength="200" name="DEP_NOMBRE"/>
      </td>
    </tr>
  </table>
  
  <br/>
   <!-- USUARIOS -->
   <!--<table class="infoTable">-->
   <table class="buscador">
     <tr class="tituloTabla">
        <th colspan="6">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>
      </th>
    </tr>
    <tr class="sinLinea"><td colspan="6">&nbsp;</td></tr>
    <tr class="sinLinea">
      <td class="veintecinco labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:<span class="camposObligatorios" width="1%">*</span>&nbsp;
      </td>
      <td class="veinte datosleft">
        <select name="US_TITULO" class="w200px">
          <option value="" selected="true">[<xsl:value-of select="document($doc)/translation/texts/item[@name='elija_una_opcion']/node()"/>]</option>
          <option value="DR|H">Dr.</option>
          <option value="DRA|M">Dra.</option>
          <option value="SR|H">Sr.</option>
          <option value="SRA|M">Sra.</option>
        </select>
      </td>
      <td class="veinte labelRight">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios" width="1%">*</span>&nbsp;
      </td>
      <td class="datosLeft">
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_NOMBRE</xsl:with-param>
          <xsl:with-param name="maxlength">100</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>    
    <tr class="sinLinea">
      <td class="labelRight">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='primer_apellido']/node()"/>:<span class="camposObligatorios" width="1%">*</span>&nbsp;
      </td>
       <td class="datosLeft">
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_APELLIDO_1</xsl:with-param>
          <xsl:with-param name="maxlength">100</xsl:with-param>
        </xsl:call-template>
      </td>
       <td class="labelRight">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='segundo_apellido']/node()"/>:
      </td>
       <td class="datosLeft">
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_APELLIDO_2</xsl:with-param>
          <xsl:with-param name="maxlength">100</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>		    		          	          	    
    <tr class="sinLinea">
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='e_mail']/node()"/>:<span class="camposObligatorios" width="1%">*</span>&nbsp;
      </td>
       <td class="datosLeft">
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_EMAIL</xsl:with-param>
          <xsl:with-param name="maxlength">70</xsl:with-param>
        </xsl:call-template>
        </td>
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='telefono_fijo']/node()"/>:<span class="camposObligatorios" width="1%">*</span>&nbsp;
      </td>
       <td class="datosLeft">
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_TF_FIJO</xsl:with-param>
          <xsl:with-param name="maxlength">30</xsl:with-param>
        </xsl:call-template>
      </td>        
    </tr>
    <tr class="sinLinea">
      <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='telefono_movil']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_TF_MOVIL</xsl:with-param>
          <xsl:with-param name="maxlength">30</xsl:with-param>
        </xsl:call-template>
      </td>     
     
      <input type="hidden" name="US_OPERADOR" value="-1"/>      
    </tr>
    <tr class="sinLinea"><td colspan="6">&nbsp;</td></tr>			
    <tr class="sinLinea">
       <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_usuario']/node()"/>:
      </td>
       <td class="datosLeft">
        <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="/BusquedaEmpresas/NUEVAEMPRESA/field[@name='US_IDTIPO']"/>
    	  <xsl:with-param name="IDAct" select="US_IDTIPO"/>
    	  <xsl:with-param name="claSel">w200px</xsl:with-param>
    	</xsl:call-template>
      </td>
       <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='administrador']/node()"/>:
      </td>
       <td class="datosLeft">
        <input type="checkbox" checked="checked" name="US_USUARIOGERENTE" onClick="siempreCheckeado(this);"/>
      </td>
    </tr>
      <input type="hidden" name="US_PEDIDO_MAXIMO"/>
          <input type="hidden" name="US_COMPRAMENSUALMAXIMA"/>
          <input type="hidden" name="US_COMPRAANUALMAXIMA"/>
  
    <tr>
    <td>&nbsp;</td>
    <td colspan="2">
 		<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>&nbsp;(<span class="camposObligatorios"> * </span>)&nbsp;
     <xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>
     </td>
     <td>&nbsp;</td>
   </tr>
 
  </table> 
  
 <br/><br/>
</div><!--fin de divLeft-->
  </form>
  
   <!--form para mensajes js-->
    <form name="MensajeJS">
	<input type="hidden" name="PEDIDO_MINIMO_ACTIVO" value="{document($doc)/translation/texts/item[@name='pedido_minimo_activo']/node()}"/>
	<input type="hidden" name="NO_ACEPTAR_OFERTAS" value="{document($doc)/translation/texts/item[@name='no_aceptar_ofertas']/node()}"/>
	<input type="hidden" name="OBLI_NOMBRE_EMPRESA" value="{document($doc)/translation/texts/item[@name='obli_nombre_empresa']/node()}"/>
	<input type="hidden" name="OBLI_NIF" value="{document($doc)/translation/texts/item[@name='obli_nif']/node()}"/>
	<input type="hidden" name="OBLI_DIRECCION" value="{document($doc)/translation/texts/item[@name='obli_direccion']/node()}"/>
	<input type="hidden" name="OBLI_COD_POSTAL" value="{document($doc)/translation/texts/item[@name='obli_cod_poostal']/node()}"/>
	<input type="hidden" name="OBLI_POBLACION" value="{document($doc)/translation/texts/item[@name='obli_poblacion']/node()}"/>
	<input type="hidden" name="OBLI_TELEFONO" value="{document($doc)/translation/texts/item[@name='obli_telefono']/node()}"/>
	<input type="hidden" name="OBLI_TIPO_EMPRESA" value="{document($doc)/translation/texts/item[@name='obli_tipo_empresa']/node()}"/>
	<input type="hidden" name="OBLI_DEPARTAMENTO" value="{document($doc)/translation/texts/item[@name='obli_departamento']/node()}"/>
	<input type="hidden" name="OBLI_TITULO_USUARIO" value="{document($doc)/translation/texts/item[@name='obli_titulo_usuario']/node()}"/>
	<input type="hidden" name="OBLI_PRIMER_APELLIDO" value="{document($doc)/translation/texts/item[@name='obli_primer_apellido']/node()}"/>
	<input type="hidden" name="OBLI_EMAIL_USUARIO" value="{document($doc)/translation/texts/item[@name='obli_email_usuario']/node()}"/>
	<input type="hidden" name="OBLI_TEL_USUARIO" value="{document($doc)/translation/texts/item[@name='obli_tel_usuario']/node()}"/>
	<input type="hidden" name="OBLI_COMISION_AHORRO" value="{document($doc)/translation/texts/item[@name='obli_comision_ahorro']/node()}"/>
	<input type="hidden" name="OBLI_COMISION_TRANSAC" value="{document($doc)/translation/texts/item[@name='obli_comision_transac']/node()}"/>
	<input type="hidden" name="OBLI_CAMPOS_OBLI" value="{document($doc)/translation/texts/item[@name='obli_campos_obli']/node()}"/>
	<input type="hidden" name="OBLI_NOMBRE_USUARIO" value="{document($doc)/translation/texts/item[@name='obli_nombre_usuario']/node()}"/>
	<input type="hidden" name="FORMATO_NUM_GUION_PARENT" value="{document($doc)/translation/texts/item[@name='formato_num_guion_parent']/node()}"/>
        <input type="hidden" name="SOLO_NUM_GUIONES_PAR" value="{document($doc)/translation/texts/item[@name='solo_numeros_guiones_parentesis']/node()}"/>
        
        <input type="hidden" name="FORMATO_COD_POSTAL" value="{document($doc)/translation/texts/item[@name='codigo_postal']/node()}"/>
        <input type="hidden" name="FORMATO_TELEFONO" value="{document($doc)/translation/texts/item[@name='telefono']/node()}"/>
        <input type="hidden" name="FORMATO_TELEFONO_FIJO" value="{document($doc)/translation/texts/item[@name='telefono_fijo']/node()}"/>
        <input type="hidden" name="FORMATO_FAX" value="{document($doc)/translation/texts/item[@name='fax']/node()}"/>
        <input type="hidden" name="EL_CAMPO" value="{document($doc)/translation/texts/item[@name='el_campo']/node()}"/>
     </form>
    <!--fin form para mensajes js-->
</xsl:template>

<!--
 +
 |
 | 	    TEMPLATES
 |
 + -->

<xsl:template name="GENERAL_TEXTBOX">
  <xsl:param name="nom"/>
  <xsl:param name="size">25</xsl:param>
  <xsl:param name="maxlength">100</xsl:param>
  <input type="text" class="campopesquisa" name="{$nom}" size="{$size}" maxlength="{$maxlength}"/>     
</xsl:template>


<xsl:template name="GENERAL_TEXTBOX_COMPRAS">
  <xsl:param name="nom"/>
  <xsl:param name="size">25</xsl:param>
  <xsl:param name="maxlength">100</xsl:param>
  <input type="text" class="campopesquisa" name="{$nom}" size="{$size}" maxlength="{$maxlength}" onChange="this.value=toInteger(this.value)">     
  </input>
</xsl:template>

</xsl:stylesheet>
