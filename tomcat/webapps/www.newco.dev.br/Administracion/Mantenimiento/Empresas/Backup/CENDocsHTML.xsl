<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    13set16	Mostrar documentos del centro (adaptado desde EMPDocsHTML.xsl)
 	Revisado 13set16 10:48
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Docs">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
    <xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<title><xsl:value-of select="/Docs/CENTRO/CEN_NOMBRE"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></title>

	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

<xsl:text disable-output-escaping="yes">
<![CDATA[
	<script type="text/javascript">

		//eliminar una oferta
		function EliminarDocumento(oferta,tipo,nombre){
			var form = document.forms['OfertaForm'];
			var idempresa = form.elements['CEN_ID'].value;
			var idoferta = oferta;
			var enctype = 'application/x-www-form-urlencoded';

			//si usuario confirma
			if(confirm(document.forms['MensajeJS'].elements['SEGURO_ELIMINAR_OFERTA'].value)){
				form.encoding = enctype;

				jQuery.ajax({
					url:"confirmEliminaOferta.xsql",
					data:"ID_DOCUMENTO="+idoferta,
					type: "GET",
					contentType: "application/xhtml+xml",
					beforeSend:function(){
						document.getElementById('waitBoxOferta_'+nombre).style.display = 'block';
						document.getElementById('waitBoxOferta_'+nombre).src = 'http://www.newco.dev.br/images/loading.gif';
					},
					error:function(objeto, quepaso, otroobj){
						alert("objeto:"+objeto);
						alert("otroobj:"+otroobj);
						alert("quepaso:"+quepaso);
					},
					success:function(data){
						var doc=eval("(" + data + ")");

						document.getElementById('waitBoxOferta_'+nombre).style.display = 'none';
						document.getElementById('confirmBoxEliminaOferta_'+nombre).style.display = 'block';

            var url = document.URL+'&ZONA=DOCS'; //aï¿½ado la zona asï¿½ seguirï¿½ estando en la parte de documentos.
            window.open(url,'_self');
					}
				});
			}//fin if
		}//fin EliminarDocumento

    //carga de un documento
    var uploadFilesDoc = new Array();
    var periodicTimerDoc = 0;
    var form_tmp;
    var MAX_WAIT_DOC = 1000;

    function cargaDoc(form){
      var tipo = form.elements['TIPO_DOC'].value;

      if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
        uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
      }

      if(hasFilesDoc(form,tipo)){
        var target = 'uploadFrameDoc';
        var action = 'http://' + location.hostname + '/cgi-bin/uploadDocsMVM.pl';
        var enctype = 'multipart/form-data';
        form.target = target;
        form.encoding = enctype;
        form.action = action;
        waitDoc("Please wait...");
        form_tmp = form;
        man_tmp = true;
        periodicTimerDoc = 0;
        periodicUpdateDoc();
        form.submit();
      }
    }//fin cargaDoc

    //Veo si hay un input file en el form
    function hasFilesDoc(form){
      for(var i = 1; i < form.length; i++){
        if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
          return true;
        }
      }
      return false;
    }

    //function que dice al usuario de esperar
    function waitDoc(text){
      jQuery('#waitBoxDoc').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
      jQuery('#waitBoxDoc').show();
      return false;
    }

    function periodicUpdateDoc(){
      if(periodicTimerDoc >= MAX_WAIT_DOC){
        alert(document.forms['mensajeJS'].elements['HEMOS_ESPERADO'].value + MAX_WAIT_DOC + document.forms['mensajeJS'].elements['LA_CARGA_NO_TERMINO'].value);
        return false;
      }
      periodicTimerDoc++;

      if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]){
        document.getElementById('waitBoxDoc').style.display = 'none';
        var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];

        if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
          alert(document.forms['mensajeJS'].elements['ERROR_SIN_DEFINIR'].value);
          return false;
        }else{
          var response = eval('(' + uFrame.innerHTML + ')');

          handleFileRequestDoc(response);
          return true;
        }
      }else{
        window.setTimeout(periodicUpdateDoc, 1000);
        return false;
      }
      return true;
    }

    //request json carga doc
    function handleFileRequestDoc(resp){
      //var lang = new String('');
      //if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
      //  lang = document.getElementById('myLanguage').innerHTML;
      //}

      var form = form_tmp;
      var msg = '';
      var target = '_top';
      var enctype = 'application/x-www-form-urlencoded';
      var documentChain = new String('');
      var action = 'http://' + location.hostname + '/confirmCargaDocumentoCentroAJAX.xsql';				// 20set16	'/'+lang+
      var docNombre = '';
      var docDescri = '';
      var nombre = '';

      if(resp.documentos){
        if(resp.documentos && resp.documentos.length > 0){
          for(var i = 0; i < resp.documentos.length; i++){
            if(resp.documentos[i].error && resp.documentos[i].error != ''){
              msg += resp.documentos[i].error;
            }else{
              if(resp.documentos[i].size){
                // En lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone guion bajo, entonces cuento cuantos guiones son, divido al penultimo y aï¿½ado la ultima palabra, si la ultima palabra esta vacï¿½a implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.
                var sinEspacioNombre = '';
                var lastWord = '';
                var sinEspacioNombre = resp.documentos[i].nombre.replace('__','_');
                var numSep = PieceCount(sinEspacioNombre,'_');
                var numSepOk = numSep -1;

                if(Piece(sinEspacioNombre,'_',numSepOk) == ''){
                  if(sinEspacioNombre.search('__')){
                    lastWord = 	sinEspacioNombre.split('__');
                    docNombre = lastWord[0];
                  }
                }else{
                  lastWord = Piece(sinEspacioNombre,'_',numSepOk);
                  nombre = sinEspacioNombre.split(lastWord);
                  docNombre = nombre[0].concat(lastWord);
                }

                documentChain += resp.documentos[i].nombre + '|'+ docNombre+'|'+ resp.documentos[i].size +'|'+ docDescri + '#';
              }
            }
          }

          if(msg == ''){
            document.getElementsByName('CADENA_DOCUMENTOS')[0].value = documentChain;
            cadenaDoc= document.getElementsByName('CADENA_DOCUMENTOS')[0].value;
          }
        }
      }

      var borrados = document.forms['SubirDocumentos'].elements['DOCUMENTOS_BORRADOS'].value;
      var borr_ante = document.forms['SubirDocumentos'].elements['BORRAR_ANTERIORES'].value;
      var tipoDoc = document.forms['SubirDocumentos'].elements['TIPO_DOC'].value;

      if(msg != ''){
        alert(msg);
        return false;
      }else{
        form.encoding = enctype;
        form.action = action;
        form.target = target;
		
		alert("CEN_ID="+form.elements['CEN_ID'].value+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc);

        jQuery.ajax({
          url:"confirmCargaDocumentoCentroAJAX.xsql",
          data: "CEN_ID="+form.elements['CEN_ID'].value+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
          type: "GET",
          async: false,
          contentType: "application/xhtml+xml",
          beforeSend:function(){
            document.getElementById('confirmBoxDocCentro').style.display = 'none';
            document.getElementById('waitBoxDoc').src = 'http://www.newco.dev.br/images/loading.gif';
          },
          error:function(objeto, quepaso, otroobj){
            alert("objeto:"+objeto);
            alert("otroobj:"+otroobj);
            alert("quepaso:"+quepaso);
          },
          success:function(data){
            var doc=eval("(" + data + ")");

            document.getElementById('confirmBoxDocCentro').style.display = 'block';
            //reinicializo los campos del form
            document.forms['SubirDocumentos'].elements['inputFileDoc'].value = '';

            //vaciamos la carga documentos
            document.forms['SubirDocumentos'].elements['inputFileDoc'] = '';

            uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
            uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

            document.location.reload(true);

            //resettamos los input file, mismo que removeDoc
            var clearedInput;
            var uploadElem = document.getElementById("inputFileDoc");

            uploadElem.value = '';
            clearedInput = uploadElem.cloneNode(false);

            uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
            uploadElem.parentNode.removeChild(uploadElem);
            document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));
            return undefined;
          }
        });
      }

      return true;
    }//fin handleFileRequestDoc

    function addDocFile(id){
      var remove = document.forms['SubirDocumentos'].elements['REMOVE'].value;
      var uploadElem = document.getElementById("inputFileDoc");

      if(uploadElem.value != ''){
        uploadFilesDoc[uploadFilesDoc.length] = uploadElem.value;

        if(!document.getElementById("inputDocLink")){
          var rmLink = document.createElement('div');
          rmLink.setAttribute("class","remove");

          jQuery('Element').append(rmLink);
          rmLink.setAttribute('id', 'inputDocLink');
          rmLink.innerHTML = '<a href="javascript:removeDoc(\'' + id + '\');">'+ remove +'</a>';
          document.getElementById("docLine").appendChild(rmLink);
        }
      }else{
        uploadFilesDoc.splice(id, 1);
        document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));
      }

      return true;
    }

    //funcion visualiza ofertas que quiero asociar con anexo
    function verOfertasAnexo(tipo,id){
      jQuery(".ofertasAnexo").hide();

      if(tipo == '-1'){
        alert('debes seleccionar un tipo de ofertas');
      }else{
        document.getElementById("OFERTAS_ANEXO_"+tipo+'_'+id).style.display = 'block';
      }
    }

    function asociarDocumentoPadre(id){
      var form = document.forms['Anexos'];
      var tipo = '';

      for(i=0;i<form.length;i++){
        if(form.elements[i].name.substring(0,14) == 'OFERTAS_ANEXO_'){
          var nombreSel= form.elements[i].name;
          if(document.getElementById(nombreSel).style.display == 'block'){
            var vectorTipo = nombreSel.split('_');
            var tipo = vectorTipo[2];
          }
        }
      }

      var doc_padre = form.elements['OFERTAS_ANEXO_'+tipo+'_'+id].value;
      var doc_anexo = id;

      jQuery.ajax({
        url:"confirmAsignarDocumentoPadre.xsql",
        data: "ID_DOCUMENTO="+doc_anexo+"&ID_DOCUMENTO_PADRE="+doc_padre,
        type: "GET",
        async: false,
        contentType: "application/xhtml+xml",
        beforeSend:function(){
          document.getElementById('confirmBoxDocPadre_'+id).style.display = 'none';
          document.getElementById('waitBoxDocPadre_'+id).src = 'http://www.newco.dev.br/images/loading.gif';
          document.getElementById('waitBoxDocPadre_'+id).style.display = 'block';
        },
        error:function(objeto, quepaso, otroobj){
          alert("objeto:"+objeto);
          alert("otroobj:"+otroobj);
          alert("quepaso:"+quepaso);
        },
        success:function(data){
          var doc=eval("(" + data + ")");

          document.getElementById('waitBoxDocPadre_'+id).style.display = 'none';
          document.getElementById('confirmBoxDocPadre_'+id).style.display = 'block';

          var url = document.URL+'&ZONA=DOCS'; //aï¿½ado la zona asï¿½ seguirï¿½ estando en la parte de documentos.
    			window.open(url,'_self');
        }
      });
    }//fin de asociarDocumentoPadre
	</script>
]]>
</xsl:text>
</head>

<body>
	<xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="//xsql-error">
			<xsl:apply-templates select="//xsql-error"/>
		</xsl:when>
		<xsl:when test="//Status">
			<xsl:apply-templates select="//Status"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="CENTRO"/>
		</xsl:otherwise>
	</xsl:choose>

  <div id="uploadFrameBox" style="display:none;"><iframe id="uploadFrame" name="uploadFrame" style="width:100%;"></iframe></div>
  <div id="uploadFrameBoxDoc" style="display:none;"><iframe id="uploadFrameDoc" name="uploadFrameDoc" style="width:100%;"></iframe></div>
</body>
</html>
</xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="CENTRO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Docs/LANG"><xsl:value-of select="/Docs/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--	9set16	Pestaña: ficha y documentos, visible para cualqueira con permiso para abrir esta ficha	-->
	<div style="background:#fff;float:left;">
	<!--	Pestaña FICHA para todos -->
	<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?CEN_ID={/Docs/CENTRO/CEN_ID}&amp;ESTADO=CABECERA" style="text-decoration:none;">
	  <xsl:choose>
	  <xsl:when test="/Empresas/LANG = 'spanish'">
    	<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA" id="FICHA"/>
	  </xsl:when>
	  <xsl:otherwise>
    	<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA" id="FICHA"/>
	  </xsl:otherwise>
	  </xsl:choose>
	</a>&nbsp;
	<a href="javascript:verPestana('DOCS');" style="text-decoration:none;">
		<img src="http://www.newco.dev.br/images/botonDocumentos1.gif" alt="DOCUMENTOS" id="DOCUMENTOS"/>
	</a>&nbsp;
	</div>
	<br/>
	<!--	FIN PESTAÑAS		-->

	<div class="divLeft">
		<h1 class="titlePage documentos" style="float:left;width:60%;padding-left:20%;">
      <xsl:choose>
      <xsl:when test="CEN_NOMBRE_CORTO != ''"><xsl:value-of select="CEN_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="CEN_NOMBRE" disable-output-escaping="yes"/></xsl:otherwise>
      </xsl:choose>:&nbsp;
      <xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/><!--&nbsp;<xsl:value-of select="CEN_TIPO"/>-->
			<xsl:if test="/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB">
				<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<a href="javascript:window.print();" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>
			</xsl:if>
		</h1>
    <h1 class="titlePage documentos" style="float:left;width:20%;">
      <xsl:if test="/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN"><span style="float:right; padding:5px;" class="amarillo">CEN_ID: <xsl:value-of select="CEN_ID"/></span></xsl:if>
    </h1>

    <!--si usuario observador no puede añadir nuevos documentos-->
    <xsl:if test="(/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/USUARIO_CDC) and not(/Docs/CENTRO/OBSERVADOR)">
		<!--tabla imagenes y documentos-->
      <table class="infoTableAma documentos" border="0">
      <form name="SubirDocumentos" method="post">
        <input type="hidden" name="CEN_ID" id="CEN_ID" value="{/Docs/CENTRO/CEN_ID}"/>
        <input type="hidden" name="CADENA_DOCUMENTOS" />
        <input type="hidden" name="DOCUMENTOS_BORRADOS" />
        <input type="hidden" name="BORRAR_ANTERIORES" />
        <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>

        <tr>
          <!--documentos-->
          <td class="quince"><!--<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='se_permite_cargar_documentos']/node()"/>.</strong>-->&nbsp;</td>
          <td class="labelRight dies">
            <span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/></span>
          </td>
          <td class="datosLeft veintecinco">
            <div class="altaDocumento">
              <span class="anadirDoc">
                <xsl:call-template name="documentos"><xsl:with-param name="num" select="number(1)"/></xsl:call-template>
              </span>
            </div>
          </td>
          <td class="datosLeft dies">
            <select name="TIPO_DOC" id="TIPO_DOC">
            <xsl:for-each select="/Docs/CENTRO/TIPOS_DOCUMENTOS/field/dropDownList/listElem">
              <option value="{ID}"><xsl:value-of select="listItem"/></option>
            </xsl:for-each>
            </select>
          </td>
          <td class="quince">
            <div class="boton">
              <a href="javascript:cargaDoc(document.forms['SubirDocumentos']);">
                <span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/></span>
              </a>
            </div>
            <div id="waitBoxDoc" align="center">&nbsp;</div>
          </td>
          <td>
  		  		<div id="confirmBoxDocCentro" align="center" style="display:none;"><span class="cargado">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span></div>
          </td>
        </tr>
      </form>
      </table><!--fin de tabla doc-->
    </xsl:if><!--fin if si es mvm-->


	<!--	24ago16	NUEVO BLOQUE CON LOS DOCUMENTOS LEGALES DE LA EMPRESA. POR AHORA SOLO PROVEEDORES DE BRASIL		-->
		<!--ofertas new-->
		<xsl:if test="DOCUMENTOSLEGALES">
			<table class="mediaTabla documentos">
			<form name="DocumentosLegales">
				<tr><td colspan="9">&nbsp;</td></tr>
				  <!--nombres columnas-->
				  <tr class="bold">
					<td class="uno">&nbsp;</td>
					<td class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
					<xsl:if test="/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN">
						<td><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
						<td><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
					</xsl:if>
					<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='descarga']/node()"/></td>
					<xsl:choose>
					<xsl:when test="//BORRAROFERTAS and not(/Docs/CENTRO/OBSERVADOR)">
						<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
					</xsl:when>
					<xsl:otherwise>
						<td class="dos">&nbsp;</td>
					</xsl:otherwise>
        			</xsl:choose>
          		</tr>

        		<xsl:for-each select="DOCUMENTOSLEGALES/DOCUMENTO">
        		  <tr>
					<td>&nbsp;</td>
					<td><xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="NOMBRE"/></td>
					<xsl:if test="/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN">
						<td><xsl:value-of select="USUARIO"/></td>
						<td>
							<xsl:choose>
							<xsl:when test="((/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN) and not(/Docs/CENTRO/OBSERVADOR)) and ../NOMBRE_CORTO != 'ANEXOS' and ../NOMBRE_CORTO != 'FICHAS_TECNICAS' and ../NOMBRE_CORTO != 'LOGOS' and ../NOMBRE_CORTO != 'DOCUMENTOS_COMERCIALES_PROV'">
								<input type="text" name="fecha_{ID}" value="{FECHA}" maxlength="10" size="10" id="fecha_{ID}"/>
								<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{../TIPO}','{../NOMBRE_CORTO}');"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="FECHA"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
					</xsl:if>
					<td>
						<a>
							<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
							<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
						</a>
					</td>
            		<td>
				</td>
				<xsl:choose>
				<xsl:when test="//BORRAROFERTAS and not(/Docs/CENTRO/OBSERVADOR)">
					<td class="ocho">
					<a>
						<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
					</a>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td class="dos">&nbsp;</td>
				</xsl:otherwise>
        		</xsl:choose>
			</tr>
      	</xsl:for-each>
      </form>
      </table>
    </xsl:if>


		<!--ofertas new
		<xsl:if test="OFERTAS and VEROFERTAS">
			<table class="mediaTabla documentos">
			<form name="OfertaForm">
				<tr><td colspan="9">&nbsp;</td></tr>

        		<xsl:for-each select="OFERTAS">
        		<xsl:if test="DOCUMENTO and NOMBRE_CORTO != 'ANEXOS'">
        		  <tr class="tituloGrisScuro">
            		<td>&nbsp;</td>
            		<td colspan="8" align="left">
            		  <strong>
                		<xsl:if test="NOMBRE_CORTO != 'FICHAS_TECNICAS' and NOMBRE_CORTO != 'LOGOS' and NOMBRE_CORTO != 'DOCUMENTOS_COMERCIALES_PROV'">DOCUMENTOS</xsl:if>
                		&nbsp;<xsl:value-of select="NOMBRE_CORTO"/>
            		  </strong>
            		  <div id="waitBoxOferta_{NOMBRE_CORTO}" class="gris" style="display:none; margin-top:5px;">
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
            		  </div>
            		  <div id="confirmBoxAsociaOferta_{NOMBRE_CORTO}" class="gris" style="display:none; margin-top:5px;">
                		<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_asociada_a_todos']/node()"/></span>
            		  </div>
            		  <div id="confirmBoxEliminaOferta_{NOMBRE_CORTO}" class="gris" style="display:none; margin-top:5px;">
                		<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_eliminada']/node()"/>.</span>
            		  </div>
            		  <div id="confirmBoxModificaFecha_{NOMBRE_CORTO}" class="gris" style="display:none; margin-top:5px;">
                		<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta_actualizada']/node()"/>.</span>
            		  </div>
            		</td>
        		  </tr>

				  < ! - -nombres columnas- - >
				  <tr class="bold">
					<td class="uno">&nbsp;</td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_oferta']/node()"/></td>
					<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='descarga']/node()"/></td>

					<xsl:choose>
					<xsl:when test="//BORRAROFERTAS and NOMBRE_CORTO != 'FICHAS_TECNICAS' and NOMBRE_CORTO != 'LOGOS'">
					<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='asociar_a_todos']/node()"/></td>
					</xsl:when>
					<xsl:otherwise>
					<td class="quince">&nbsp;</td>
					</xsl:otherwise>
					</xsl:choose>

            		<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
            		<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
            		<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/></td>

					<xsl:choose>
					<xsl:when test="//BORRAROFERTAS">
						<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
					</xsl:when>
					<xsl:otherwise>
						<td class="dos">&nbsp;</td>
					</xsl:otherwise>
        			</xsl:choose>
          		</tr>

        <xsl:for-each select="DOCUMENTO">
          <tr>
						<td>&nbsp;</td>
						<td><xsl:if test="DOCUMENTOHIJO"><span class="rojo amarillo">|&nbsp;</span></xsl:if><xsl:value-of select="NOMBRE"/>&nbsp;( .<xsl:value-of select="substring-after(URL,'.')"/> )</td>
						<td>
							<a>
								<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
								<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
							</a>
						</td>
						<td>
              <xsl:choose>
              <xsl:when test="//BORRAROFERTAS and not(/Docs/CENTRO/OBSERVADOR) and ../NOMBRE_CORTO = 'DOCUMENTOS_COMERCIALES_PROV'">
								<a>
									<xsl:attribute name="href">javascript:AsociarDocComeTodos('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
									<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a todos los productos"/>
								</a>
							</xsl:when>
							<xsl:when test="//BORRAROFERTAS and not(/Docs/CENTRO/OBSERVADOR) and ../NOMBRE_CORTO != 'FICHAS_TECNICAS' and ../NOMBRE_CORTO != 'ANEXOS' and ../NOMBRE_CORTO != 'LOGOS'">
								<a>
									<xsl:attribute name="href">javascript:AsociarOfertaTodos('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
									<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a todos los productos"/>
								</a>
							</xsl:when>
              </xsl:choose>
						</td>
						<td><xsl:value-of select="USUARIO"/></td>
						<td>
							<xsl:choose>
							<xsl:when test="((/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN) and not(/Docs/CENTRO/OBSERVADOR)) and ../NOMBRE_CORTO != 'ANEXOS' and ../NOMBRE_CORTO != 'FICHAS_TECNICAS' and ../NOMBRE_CORTO != 'LOGOS' and ../NOMBRE_CORTO != 'DOCUMENTOS_COMERCIALES_PROV'">
								<input type="text" name="fecha_{ID}" value="{FECHA}" maxlength="10" size="10" id="fecha_{ID}"/>
								<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{../TIPO}','{../NOMBRE_CORTO}');"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="FECHA"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
            <td>
							<xsl:choose>
							<xsl:when test="((/Docs/CENTRO/MVM or /Docs/CENTRO/MVMB or /Docs/CENTRO/ADMIN) and not(/Docs/CENTRO/OBSERVADOR)) and ../NOMBRE_CORTO != 'ANEXOS' and ../NOMBRE_CORTO != 'FICHAS_TECNICAS' and ../NOMBRE_CORTO != 'LOGOS' and ../NOMBRE_CORTO != 'DOCUMENTOS_COMERCIALES_PROV'">
								<input type="text" name="fechaFinal_{ID}" value="{FECHACADUCIDAD}" maxlength="10" size="10" id="fechaFinal_{ID}"/>
								<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha final" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{../TIPO}','{../NOMBRE_CORTO}');"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="FECHA"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>
							<xsl:if test="//BORRAROFERTAS and not(/Docs/CENTRO/OBSERVADOR)">
								<a>
									<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
									<img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
								</a>
							</xsl:if>
						</td>
					</tr>

          <xsl:if test="DOCUMENTOHIJO">
            <tr>
              <td></td>
              <td><span class="rojo amarillo">|&nbsp;<xsl:value-of select="DOCUMENTOHIJO/TIPO"/></span>&nbsp;<xsl:value-of select="DOCUMENTOHIJO/NOMBRE"/></td>
              <td>
                <a>
					<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="DOCUMENTOHIJO/URL"/></xsl:attribute>
					<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
                </a>
              </td>
              <td>&nbsp;</td>
              <td><xsl:value-of select="DOCUMENTOHIJO/FECHA"/></td>
            </tr>
          </xsl:if>
        </xsl:for-each>

        </xsl:if>
      	</xsl:for-each>
      </form>
      </table>
    </xsl:if>

    < ! - -docuemntos anexos- - >
    <xsl:for-each select="OFERTAS[NOMBRE_CORTO = 'ANEXOS']">
		<xsl:if test="//VEROFERTAS and DOCUMENTO">
			<table class="infoTableAma documentos">
				<tr class="tituloGrisScuro">
					<td>&nbsp;</td>
					<td colspan="8" align="left" >
						<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos_anexos']/node()"/></strong>
						<div id="waitBoxOfertaANE" class="gris" style="display:none; margin-top:5px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
						</div>
						<div id="confirmBoxAsociaOfertaANE" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='anexo_asociado_a_todos']/node()"/></span>
						</div>
						<div id="confirmBoxEliminaOfertaANE" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='anexo_eliminado']/node()"/>.</span>
						</div>
						<div id="confirmBoxModificaFechaANE" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_anexo_actualizada']/node()"/>.</span>
						</div>
					</td>
				</tr>

				< ! - -nombres columnas- - >
				<tr class="bold">
					<td class="uno">&nbsp;</td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_anexo']/node()"/></td>
					<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='descarga']/node()"/></td>

				<xsl:choose>
				<xsl:when test="BORRAROFERTAS">
					<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='asociar_anexo']/node()"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="quince">&nbsp;</td>
				</xsl:otherwise>
				</xsl:choose>

					<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
					<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>

				<xsl:choose>
				<xsl:when test="BORRAROFERTAS">
					<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="dos">&nbsp;</td>
				</xsl:otherwise>
				</xsl:choose>
				</tr>

				<form name="Anexos" method="post">
					<tbody>
						<xsl:for-each select="DOCUMENTO">
							<tr>
								<td>&nbsp;</td>
								<td><xsl:value-of select="NOMBRE"/>&nbsp;( .<xsl:value-of select="substring-after(URL,'.')"/> )</td>
								<td>
									<a>
										<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
										<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
									</a>
								</td>
								<td>
									<xsl:if test="../../BORRAROFERTAS and not(/Docs/CENTRO/OBSERVADOR)">
                  						<select name="SELECT_OFERTAS_{ID}" id="SELECT_OFERTAS_{ID}" onchange="verOfertasAnexo(this.value,'{ID}');">
                    						<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/></option>
                    					  <xsl:for-each select="//OFERTAS">
                        					<xsl:if test="DOCUMENTO">
                        					  <option value="{TIPO}"><xsl:value-of select="NOMBRE_CORTO"/></option>
                        					</xsl:if>
                    					  </xsl:for-each>
                    					</select>

                    					<xsl:variable name="idanexo" select="ID"/>
                    					<xsl:for-each select="//OFERTAS">
                    					  <xsl:if test="DOCUMENTO">
                        					<select name="OFERTAS_ANEXO_{TIPO}_{$idanexo}" id="OFERTAS_ANEXO_{TIPO}_{$idanexo}" class="ofertasAnexo" style="display:none;">
                        					  <xsl:for-each select="DOCUMENTO">
                            					<option value="{ID}"><xsl:value-of select="NOMBRE"/></option>
                        					  </xsl:for-each>
                        					</select>
                    					  </xsl:if>
                    					</xsl:for-each>

										<a>
											<xsl:attribute name="href">javascript:asociarDocumentoPadre('<xsl:value-of select="ID"/>');</xsl:attribute>
											<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a la oferta"/>
										</a>

                    					<div id="confirmBoxDocPadre_{ID}" style="display:none;">
                    					  <span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_anexo_asociado']/node()"/>.</span>
                    					</div>
                    					<div id="waitBoxDocPadre_{ID}" style="display:none;">&nbsp;</div>
									</xsl:if>
								</td>
								<td><xsl:value-of select="USUARIO"/></td>
								<td><xsl:value-of select="FECHA"/>
								</td>
								<td>
									<xsl:if test="../../BORRAROFERTAS and not(/Docs/CENTRO/OBSERVADOR)">
										<a>
											<xsl:attribute name="href">javascript:EliminarDocumento('Anexos','<xsl:value-of select="ID"/>','ANE');</xsl:attribute>
											<img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
										</a>
									</xsl:if>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</form>
			</table><! - -fin de tabla anexos- -  >
		</xsl:if><! - - fin de if si hay doc anexos- - >
    </xsl:for-each>

		<xsl:if test="/Docs/CENTRO/LOGOS/DOCUMENTO and /Docs/CENTRO/MVM">
			<table class="mediaTabla documentos" style="display:none;">
				<tr class="tituloGrisScuro documentos">
					<td>&nbsp;</td>
					<td colspan="8" align="left" >
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='logos']/node()"/>
						</strong>
						<div id="waitBoxOfertaLOGO" class="gris" style="display:none; margin-top:5px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
						</div>
						<div id="confirmBoxAsociaOfertaLOGO" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_asociado_a_todos']/node()"/></span>
						</div>
						<div id="confirmBoxEliminaOfertaLOGO" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_eliminado']/node()"/>.</span>
						</div>
					</td>
				</tr>

				< ! - -nombres columnas- - >
				<tr class="bold">
					<td class="uno">&nbsp;</td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_logo']/node()"/></td>
					<td class="dies"></td>
					<td class="quince">&nbsp;</td>
					<td class="quince"></td>
					<td class="quince"></td>
					<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
				</tr>

				<form name="LOGO">
					<tbody>
						<xsl:for-each select="/Docs/CENTRO/LOGOS/DOCUMENTO">
							<tr>
								<td>&nbsp;</td>
								<td><xsl:value-of select="NOMBRE"/>&nbsp;( .<xsl:value-of select="substring-after(URL,'.')"/> )</td>
								<td>
								</td>
								<td>&nbsp;</td>
								<td><xsl:value-of select="USUARIO"/></td>
								<td><xsl:value-of select="FECHA"/></td>
								<td>
                  <xsl:if test="not(/Docs/CENTRO/OBSERVADOR)">
										<a>
											<xsl:attribute name="href">javascript:EliminarDocumento('LOGO','<xsl:value-of select="ID"/>','LOGO');</xsl:attribute>
											<img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
										</a>
                  </xsl:if>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</form>
			</table>< ! - - fin de tabla logos- - >
		</xsl:if>< ! - -fin de if si hay logos solo mvm - - >
		-->

		<!--mensajes js -->
		<form name="MensajeJS">
		<input type="hidden" name="SEGURO_ELIMINAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_oferta']/node()}"/>
		<input type="hidden" name="SEGURO_ELIMINAR_OFERTA_ANE" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_anexo']/node()}"/>
		<input type="hidden" name="SEGURO_ELIMINAR_FICHA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_ficha']/node()}"/>
		<input type="hidden" name="SEGURO_ASOCIAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_asociar_oferta']/node()}"/>
		<input type="hidden" name="SEGURO_MODIFICAR_FECHA" value="{document($doc)/translation/texts/item[@name='seguro_modificar_fecha']/node()}"/>
		<!--carga documentos-->
		<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
		<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
		<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
		<input type="hidden" name="CARGANDO_IMAGEN" value="{document($doc)/translation/texts/item[@name='cargando_imagen']/node()}"/>
		<input type="hidden" name="FICHA_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='ficha_obligatoria']/node()}"/>
		</form>
		<!--fin de mensajes js -->
	</div><!--fin de divCenter50-->
</xsl:template>

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num"/>
	<xsl:choose>
	<!--imagenes de la tienda-->
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine">
			<!--<xsl:if test="number($num) &gt; number(1)">
				<xsl:attribute name="style">display: none;</xsl:attribute>
			</xsl:if>-->
			<div class="docLongEspec" id="docLongEspec">
				<input id="inputFileDoc" name="inputFileDoc" type="file" onChange="addDocFile();" />
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template>
<!--fin de documentos-->
</xsl:stylesheet>
