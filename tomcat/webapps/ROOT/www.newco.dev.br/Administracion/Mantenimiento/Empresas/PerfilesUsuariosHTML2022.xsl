<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Mantenimiento de perfiles de usuarios. Nuevo disenno 2022.
	Ultima revision: ET 17may22 09:20
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
    	<xsl:when test="/PerfilesUsuarios/LANG"><xsl:value-of select="/PerfilesUsuarios/LANG" /></xsl:when>
    	<xsl:otherwise>spanish</xsl:otherwise>
    	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='perfiles_usuarios']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->  

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
     
        
	<script type="text/javascript">

	var sincroErrorPerfil = '<xsl:value-of select="document($doc)/translation/texts/item[@name='sincronizacion_error_perfil']/node()"/>';
	var sincroOkPerfil = '<xsl:value-of select="document($doc)/translation/texts/item[@name='sincronizacion_ok_perfil']/node()"/>';

	function CreaPerfil(){
		document.forms[0].elements['NOMBRE_PERFIL'].value=document.forms[0].elements['NOMBRE_PERFIL_NUEVO'].value;
		document.forms[0].elements['IDUSUARIO'].value=document.forms[0].elements['IDUSUARIO_NUEVO'].value;
		document.forms[0].elements['ACCION'].value='CREAR';
		SubmitForm(document.forms[0]);
	}

	function ModificarPerfil(idPerfil){
    	document.forms[0].elements['IDPERFIL'].value=idPerfil;
    	document.forms[0].elements['NOMBRE_PERFIL'].value=document.forms[0].elements['NOMBRE_PERFIL_MODIFICA'].value;
    	document.forms[0].elements['IDUSUARIO'].value=document.forms[0].elements['IDUSUARIO_MODIFICA'].value;
		document.forms[0].elements['ACCION'].value='MODIFICA';
    	SubmitForm(document.forms[0]);
	}

	function BorrarPerfil(idPerfil){
		document.forms[0].elements['ACCION'].value='BORRAR';
    	document.forms[0].elements['IDPERFIL'].value=idPerfil;
    	SubmitForm(document.forms[0]);
	}

	function SincronizarPerfil(idPerfil){
		jQuery.ajax({
		url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/SincronizarPerfilAJAX.xsql",
		data: "IDPERFIL="+idPerfil,
		type: "GET",
		contentType: "application/xhtml+xml",

		beforeSend:function(){ },

		error:function(objeto, quepaso, otroobj){
                	alert("objeto:"+objeto);
                	alert("otroobj:"+otroobj);
                	alert("quepaso:"+quepaso);
		},

        	success:function(data){
            	var doc=eval("(" + data + ")");
            	//alert('mi '+doc.SincronizarPerfil.estado);
            	if (data.match('ERROR')){
                	alert(sincroErrorPerfil);
		}
            	if (data.match('OK')){
		 alert(sincroOkPerfil);
                	}
	}
	}); //fin ajax

	}

	</script>
        
</head>
<body>   
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/PerfilesUsuarios/LANG"><xsl:value-of select="/PerfilesUsuarios/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
      
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
    	  <xsl:apply-templates select="//SESION_CADUCADA"/>    
	</xsl:when>
	<xsl:when test="//xsql-error">
    	 <xsl:apply-templates select="//xsql-error"/>
	   </xsl:when>
	<xsl:otherwise>
	<!-- Titulo -->
	<form action="PerfilesUsuarios.xsql" name="Perfiles" method="POST">
	<input type="hidden" name="ACCION"/>
    <input type="hidden" name="IDPERFIL"/>
    <input type="hidden" name="IDUSUARIO"/>
    <input type="hidden" name="NOMBRE_PERFIL"/>
	<input type="hidden" name="IDEMPRESA" value="{/PerfilesUsuarios/IDEMPRESA}"/>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='perfiles_usuarios']/node()"/>&nbsp;<xsl:value-of select="/PerfilesUsuarios/PERFILES/EMPRESA" />
			<span class="CompletarTitulo">
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
        
	<xsl:if test="/PerfilesUsuarios/PERFILES/PERFIL">
		<div class="tabela tabela_redonda">
		<table class="tableCenter w1000px" cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1x"></th>
                <th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_perfil']/node()"/></th>
                <th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_relacionado']/node()"/></th>
                <th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='sincronizar']/node()"/></th>
                <th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
            </tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
       		<xsl:for-each select="/PerfilesUsuarios/PERFILES/PERFIL">
            <tr>
                <td class="color_status">&nbsp;</td>
				<td class="textLeft">
					<xsl:value-of select="NOMBRE"/>
                    <input type="hidden" name="NOMBRE_PERFIL_MODIFICA" id="NOMBRE_PERFIL_MODIFICA" value="{NOMBRE}" />
				</td>
                <td class="textLeft">
					<xsl:value-of select="USUARIO"/>
				</td>
            	<td>
                	<a href="javascript:SincronizarPerfil({ID})">
                    	<!--<img src="http://www.newco.dev.br/images/actualizarFlecha.gif"/>-->
                    	<img src="http://www.newco.dev.br/images/2022/refresh-button.png"/>
                	</a>
            	</td>
				<td>
                	<a href="javascript:BorrarPerfil({ID})">
                    	<img src="http://www.newco.dev.br/images/2022/icones/del.svg"/>
                	</a>
				</td>
            </tr>
		</xsl:for-each> 
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
		</table><!--fin de infoTableAma-->
 		</div>
 		<br/>  
 		<br/>  
    	<br />
    	<br />
    </xsl:if>

    <table class="tableCenter w1000px" cellspacing="6px" cellpadding="6px">
        <tr>
            <td class="labelRight w150px">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:&nbsp;
            </td>
            <td class="textLeft w300px">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/PerfilesUsuarios/PERFILES/IDUSUARIO/field"></xsl:with-param>
					<xsl:with-param name="nombre">IDUSUARIO_NUEVO</xsl:with-param>
					<xsl:with-param name="id">IDUSUARIO_NUEVO</xsl:with-param> 
					<xsl:with-param name="claSel">w300px</xsl:with-param> 
				</xsl:call-template>
            </td>
            <td class="labelRight w3150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_perfil']/node()"/>:&nbsp;</td>
            <td class="textLeft w200px">
                <input type="text" class="campopesquisa w200px" name="NOMBRE_PERFIL_NUEVO" id="NOMBRE_PERFIL_NUEVO" size="40" />
            </td>			
            <td class="textLeft">
            	<a class="btnDestacado" href="javascript:CreaPerfil();"><xsl:value-of select="document($doc)/translation/texts/item[@name='crea_perfil']/node()"/></a>
            </td>
			<td>&nbsp;</td>
        </tr>
	</table>
		
		</form>
        <form name="MensajeJS">
			<input type="hidden" name="SEGURO_BORRAR" value="{document($doc)/translation/texts/item[@name='seguro_de_borrar_relacion']/node()}"/>
        </form>
		</xsl:otherwise>
      </xsl:choose> 
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
