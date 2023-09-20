<?xml version="1.0" encoding="iso-8859-1" ?>
<!--Mantenimiento de Usuarios-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:template match="/">
    <html>
      <head>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
      <script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USManten191115.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[

        <SCRIPT type="text/javascript">
        <!--
           var msgSinUsuarioParaCarpYPl='Antes de dar derechos sobre las carpetas y plantillas debe crear el nuevo usuario.\n\nDespues de guardar los cambios, haga click sobre el nombre del usuario,\nen el panel de la izquierda, para ver sus propiedades.\nGracias.';
           var msgSinUsuarioParaMenus='Antes de dar derechos sobre los menús debe crear el nuevo usuario.\n\nDespues de guardar los cambios, haga click sobre el nombre del usuario,\nen el panel de la izquierda, para ver sus propiedades.\n\nGracias.';

        function DerechosCARPyPL(propietario, usuario){

          var opciones='?ID_PROPIETARIO='          + propietario +
                       '&ID_USUARIO='              + usuario;

          if(usuario>0){
            MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CARPyPLManten.xsql'+opciones,'carpYpl');
          }
          else{
            alert(msgSinUsuarioParaCarpYPl);
          }
        }


        function DerechosMenus(usuario, empresa){
          var opciones='?EMP_ID='          + empresa +
                       '&ID_USUARIO='       + usuario;


          if(usuario>0){
            MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/MenusManten.xsql'+opciones,'MenusManten');
          }
          else{
            alert(msgSinUsuarioParaMenus);
          }
        }

        function ValidaySubmit(formu){
          var id;
          var cadenaCambios='';
          var visualizable;
          var pertenece;
          var cabecera;

          formu.action = 'USMantenSave.xsql';
          formu.type = 'post';
          formu.target = '';

          if(validarFormulario(formu)){
            for(var i=0;i<formu.length;i++){
              if(formu.elements[i].name.substring(0,5)=='MENU_'){
                id=obtenerId(formu.elements[i].name);
                if(formu.elements[i].checked==true)
                  visualizable=1;
                else
                  visualizable=0;

               if(formu.elements['CABECERA_'+id].checked==true)
                  cabecera='S';
                else
                  cabecera='N';

                cadenaCambios+=id+'|'+visualizable+'|'+cabecera+'#';
              }
            }
            formu.elements['CAMBIOS_MENUS'].value=cadenaCambios;


            //montamos la cadena de los departamentos
            cadenaCambios='';

            for(var i=0;i<formu.length;i++){
              if(formu.elements[i].name.substring(0,5)=='DEPT_'){
                id=obtenerId(formu.elements[i].name);

                if(formu.elements[i].checked==true)
                  pertenece=1;
                else
                  pertenece=0;

                cadenaCambios+=id+'|'+pertenece+'#';
              }
            }
            formu.elements['CAMBIOS_DEPTS'].value=cadenaCambios;


            //         montamos la cadena de los centros autorizados
            cadenaCambios='';

            for(var i=0;i<formu.length;i++){
              if(formu.elements[i].name.substring(0,17)=='CENTROAUTORIZADO_'){
                id=Piece(formu.elements[i].name,'_',1);
                if(formu.elements[i].checked==true)	cadenaCambios+=id+'|';
              }
            }

            formu.elements['US_CENTROSAUTORIZADOS'].value=cadenaCambios;

            if (formu.elements['US_NAVEGARPROVEEDORES'] && formu.elements['US_NAVEGARPROVEEDORES'].value =='on') {
            	formu.elements['US_NAVEGARPROVEEDORES'].value = 'S';
            }

            /*if (formu.elements['US_PLANTILLASNORMALES']){
                alert('pl-norm '+formu.elements['US_PLANTILLASNORMALES'].value);
                alert('pl urgen '+formu.elements['US_PLANTILLASURGENCIAS'].value);
            }*/

            if (formu.elements['TIENEPEDIDOS'].value == 'S' && ( (formu.elements['US_NOMBRE_OLD'].value != formu.elements['US_NOMBRE'].value) || (formu.elements['US_APELLIDO1_OLD'].value != formu.elements['US_APELLIDO1'].value) || (formu.elements['US_APELLIDO2_OLD'].value != formu.elements['US_APELLIDO2'].value) )){
                var formJS = document.forms['MensajeJS'];
                var AvisoTienePedidos = formJS.elements['TIENE_PEDIDOS_AVISO'].value;
                alert(formu.elements['US_NOMBRE'].value + formu.elements['US_APELLIDO1'].value + AvisoTienePedidos);
			}
                        jQuery(".boton").hide(); //cuando envio formulario que ok escondo botones
			SubmitForm(formu);
          }
        }


        function validarFormulario(form){
                  var regex_car_raros     = /([\#|\\|\'|\|])+/g; //caracteres raros que no queremos en los campos de texto (requisito MVM)
                  var regex_car_usuario   = new RegExp("^[0-9a-zA-Z]+$","g"); //caracteres raros que no queremos en los campos login y usuario (requisito MVM-brasil)
                  var regex_car_clave     = new RegExp("^[0-9a-zA-Z]+$","g");
                  var regex_car_clave_rep = new RegExp("^[0-9a-zA-Z]+$","g");
                  var regex_numeros       = new RegExp("^[0-9]+$","g");
        	  var errores=0;
                  var raros=0;

        	  if((!errores) && (document.forms[0].elements['US_TITULO'].value==-1)){
        	    errores=1;
        	    alert(document.forms['MensajeJS'].elements['OBLI_TITULO_USUARIO'].value);
        	    form.elements['US_TITULO'].focus();
        	    return false;
        	  }

        	  if((!errores) && (esNulo(document.forms[0].elements['US_NOMBRE'].value))){
        	    errores=1;
        	    alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_EMPRESA'].value);
        	    form.elements['US_NOMBRE'].focus();
        	    return false;
        	  }

                  if((!errores) && (esNulo(document.forms[0].elements['US_APELLIDO1'].value))){
        	    errores=1;
        	    alert(document.forms['MensajeJS'].elements['OBLI_PRIMER_APELLIDO'].value);
        	    form.elements['US_APELLIDO1'].focus();
        	    return false;
        	  }

                   //control que no pongan caracteres raros en los textos
                   if(document.forms[0].elements['US_CP_NOMBRE'] && document.forms[0].elements['US_CP_ID']){
                        var inputText = [document.forms[0].elements['US_NOMBRE'].value,document.forms[0].elements['US_APELLIDO1'].value, document.forms[0].elements['US_APELLIDO2'].value, document.forms[0].elements['US_CP_NOMBRE'].value,document.forms[0].elements['US_CP_ID'].value,document.forms[0].elements['US_EMAIL'].value,document.forms[0].elements['US_EMAIL2'].value];
                    }
                    else{
                        var inputText = [document.forms[0].elements['US_NOMBRE'].value,document.forms[0].elements['US_APELLIDO1'].value, document.forms[0].elements['US_APELLIDO2'].value,document.forms[0].elements['US_EMAIL'].value,document.forms[0].elements['US_EMAIL2'].value];
                    }

                    for (var i=0;i<inputText.length;i++){
                        if(checkRegEx(inputText[i], regex_car_raros)){
                            //si true implica que si ha encontrado caracteres raros
                            errores=1;
                            raros=1;
                        }
                        else { }
                    }//fin for caracteres raros

                    if (raros =='1') alert(document.forms['MensajeJS'].elements['CAR_RAROS'].value);


        	   //control caracteres raros en user y password
                    if((!errores) && (!checkRegEx(document.forms[0].elements['US_USUARIO'].value, regex_car_usuario))){
                        errores=1;
                        alert(document.forms['MensajeJS'].elements['CAR_RAROS_USUARIO'].value);
                        form.elements['US_USUARIO'].focus();
                        return false;
                    }
                    if((!errores) && (document.forms[0].elements['US_CLAVE'].value != '') && (!checkRegEx(document.forms[0].elements['US_CLAVE'].value, regex_car_clave))){
                        errores=1;
                        alert(document.forms['MensajeJS'].elements['CAR_RAROS_USUARIO'].value);
                        form.elements['US_CLAVE'].focus();
                        return false;
                    }
                    if((!errores) && (document.forms[0].elements['US_CLAVE_REP'].value != '') && (!checkRegEx(document.forms[0].elements['US_CLAVE_REP'].value, regex_car_clave_rep))){
                        errores=1;
                        alert(document.forms['MensajeJS'].elements['CAR_RAROS_USUARIO'].value);
                        form.elements['US_CLAVE_REP'].focus();
                        return false;
                    }
                   
        	  /*if((!errores) && (esNulo(document.forms[0].elements['US_APELLIDO2'].value))){
        	    errores=1;
        	    alert(document.forms['MensajeJS'].elements['OBLI_SEGUNDO_APELLIDO'].value);
        	    form.elements['US_APELLIDO2'].focus();
        	    return false;
        	  }*/

        	  /*quitado 16-12-14 para brasil, si no no se podian guardar num tel con -
                    if((!errores) && (!checkNumber(document.forms[0].elements['US_TF_FIJO'].value, document.forms[0].elements['US_TF_FIJO']))){
        	    errores=1;
        	    form.elements['US_TF_FIJO'].focus();
        	    return false;
        	  }
        	  else{}
        	    if((!errores) && (esNulo(document.forms[0].elements['US_TF_FIJO'].value))){
        	    errores=1;
        	    alert(document.forms['MensajeJS'].elements['OBLI_TELEFONO'].value);
        	    form.elements['US_TF_FIJO'].focus();
        	    return false;
        	  }*/


        	  ]]></xsl:text>
        	    <xsl:if test="Mantenimiento/form/Lista/USUARIO/ID_USUARIO='0'">
        	      if((!errores) <xsl:text disable-output-escaping="yes"><![CDATA[ &&  ]]></xsl:text> (esNulo(document.forms[0].elements['US_USUARIO'].value)|| esNulo(document.forms[0].elements['US_USUARIO'].value))){
        	        errores=1;
        	        alert(document.forms['MensajeJS'].elements['OBLI_LOGIN'].value);
        	        form.elements['US_USUARIO'].focus();
        	        return false;
        	      }
        	    </xsl:if>
        	  <xsl:text disable-output-escaping="yes"><![CDATA[

        	  if((!errores) && (document.forms[0].elements['US_CLAVE'].value!=document.forms[0].elements['US_CLAVE_REP'].value  ]]></xsl:text><xsl:if test="Mantenimiento/form/Lista/USUARIO/ID_USUARIO='0'"><xsl:text disable-output-escaping="yes"><![CDATA[ || document.forms[0].elements['US_CLAVE'].value=='' || document.forms[0].elements['US_CLAVE_REP'].value=='']]></xsl:text></xsl:if><xsl:text disable-output-escaping="yes"><![CDATA[)){
        	    errores=1;
        	    alert(document.forms['MensajeJS'].elements['OBLI_PASSWORD'].value);
        	    form.elements['US_CLAVE'].value='';
        	    form.elements['US_CLAVE_REP'].value='';
        	    form.elements['US_CLAVE'].focus();
        	    return false;
        	  }

        	  if((!errores)&& (!comprobarDepartamentosDelUsuario(document.forms[0]))){
        	    alert(document.forms['MensajeJS'].elements['OBLI_SEL_DEPARTAMENTOS'].value);
        	    document.location.href='#dept';
        	    return false;
        	  }
                   //control que sea númerico importe sin supervisor
                  
                    var importeSinSup = document.forms[0].elements['US_IMPORTESINSUPERVISION'].value;
                    if((!errores) && (!checkNumber( importeSinSup.replace('.','') ))){
                        errores=1;
                        alert(document.forms['MensajeJS'].elements['IMPORTESINSUPERVISION_ERROR'].value);
                        form.elements['US_IMPORTESINSUPERVISION'].focus();
                        return false;
                    }
                    document.forms[0].elements['US_IMPORTESINSUPERVISION'].value = importeSinSup.replace('.','');
                    //alert('replace . nada '+document.forms[0].elements['US_IMPORTESINSUPERVISION'].value);
                    if (document.forms[0].elements['US_IMPORTESINSUPERVISION'].value.match(',')){
                        var importeComa= document.forms[0].elements['US_IMPORTESINSUPERVISION'].value;
                        document.forms[0].elements['US_IMPORTESINSUPERVISION'].value = importeComa.replace(',','.');
                        //alert('replace 2 , . '+document.forms[0].elements['US_IMPORTESINSUPERVISION'].value);
                        }

                  if(!errores)
                    return true;
                  else
                    return false;

        	}

        	function comprobarDepartamentosDelUsuario(form){
        	  var algunoInformado=0;
        	  for(var n=0;n<form.length;n++){
        	    if(form.elements[n].name.substring(0,5)=='DEPT_'){
        	      if(form.elements[n].checked==true){
        	        algunoInformado++;
        	      }
        	    }
        	  }

        	  return algunoInformado;
        	}


        	function privilegiosCarpetas(obj){
        	  var esAdministrador;


              if(document.forms[0].elements['US_USUARIOGERENTE'].value=='on' || document.forms[0].elements['US_GERENTECENTRO'].value=='on')
        	    esAdministrador=1;

        	  if(esAdministrador){
        	    obj.checked=!obj.checked;
        	  }
        	}

        	function MostrarDatos(){
        	  MostrarPagPassord('USDatos.xsql?ID_USUARIO=]]></xsl:text><xsl:value-of select="/Mantenimiento/form/Lista/USUARIO/ID_USUARIO"/><xsl:text disable-output-escaping="yes"><![CDATA[','Password');
        	}


       function MostrarPagPassord(pag,titulo){


          if(titulo==null)
            var titulo='MedicalVM';


          if (is_nav){

              var ample = 300;
              var alcada = 100;

              var esquerra = (top.screen.availWidth-ample) / 2;
              var alt = (top.screen.availHeight-alcada) / 2;

            if (ventana && ventana.open){
              ventana.close();
            }
            titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
            titulo.focus();

          }else{
              var ample = 300;
              var alcada = 100;

              var esquerra = (top.screen.availWidth-ample) / 2;
              var alt = (top.screen.availHeight-alcada) / 2;

            if (ventana &&  ventana.open && !ventana.closed){
            	 ventana.close();
            }
	    titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
	    titulo.focus();
          }
        }

		//	Al seleccionar multicentros, activa o desactiva los checkboxes de centros
		function Multicentros()
		{
        	if (document.forms[0].elements['US_MULTICENTROS'].checked==true)
			{
            	for(var i=0;i<document.forms[0].length;i++)
				{
            	  if(document.forms[0].elements[i].name.substring(0,17)=='CENTROAUTORIZADO_')
				  {
                	document.forms[0].elements[i].disabled=false;
            	  }
            	}
			}
			else
			{
            	for(var i=0;i<document.forms[0].length;i++)
				{
            	  if(document.forms[0].elements[i].name.substring(0,17)=='CENTROAUTORIZADO_')
				  {
                	document.forms[0].elements[i].disabled=true;
            	  }
            	}
			}
		}

                function checkLicitaciones(){
                    if(jQuery("#US_VERLICITACIONES").is(':checked'))
                        jQuery("#US_CREARLICITACIONES").removeAttr("disabled");
                    else{
                        jQuery("#US_CREARLICITACIONES").attr("disabled", true);
                        jQuery("#US_CREARLICITACIONES").attr('checked', false);
                    }
                }

                //si eligo seleccionar en el perfil vuelvo a poner boton de personalizacion de derechos
                function VerPersonalizacion(){
                    var perfil = jQuery('#US_IDPERFIL').val();
                    if(perfil == ''){
                        jQuery("#botonPersonalizacion").show();
                    }
                }

        //-->
        </SCRIPT>
        ]]></xsl:text>
      </head>

      <body onLoad="javascript:privilegiosUsuarioOnload();Multicentros();checkLicitaciones();">
	<!-- Formulario de datos -->
     <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>    <!--idioma fin-->

	<xsl:choose>
	  <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="/Mantenimiento/SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="//SESION_CADUCADA"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="/Mantenimiento/form/DATAERROR">
          	<h1 class="titlePage">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='login_ya_existe']/node()"/>
                </h1>
		<br/>
		<br/>
            <div class="divLeft">
            <div class="divLeft40">&nbsp;</div>
            <div class="divLeft20">
                <div class="boton">
                    <a href="javascript:history.go(-1)"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>   </a>
                </div>
            </div>
            <div class="divLeft30">&nbsp;</div>
            </div><!--fin de divLeft-->
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="Mantenimiento/form"/>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->
<xsl:template match="form">

      <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->

  <form method="post">
    <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
    <xsl:apply-templates select="Lista/USUARIO"/>

    <input type="hidden" name="US_ID" value="{//US_ID}"/>

    <input type="hidden" name="TIENEPEDIDOS">
    <xsl:attribute name="value">
    	<xsl:choose><xsl:when test="/Mantenimiento/form/Lista/USUARIO/TIENEPEDIDOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
    </xsl:attribute>
    </input>
  </form>

   <!--form para mensajes js-->
    <form name="MensajeJS">
      <input type="hidden" name="OBLI_NOMBRE_EMPRESA" value="{document($doc)/translation/texts/item[@name='obli_nombre_empresa']/node()}"/>
      <input type="hidden" name="OBLI_TITULO_USUARIO" value="{document($doc)/translation/texts/item[@name='obli_titulo_usuario']/node()}"/>
      <input type="hidden" name="OBLI_PRIMER_APELLIDO" value="{document($doc)/translation/texts/item[@name='obli_primer_apellido']/node()}"/>
      <input type="hidden" name="OBLI_SEGUNDO_APELLIDO" value="{document($doc)/translation/texts/item[@name='obli_segundo_apellido']/node()}"/>
      <input type="hidden" name="OBLI_LOGIN" value="{document($doc)/translation/texts/item[@name='obli_login']/node()}"/>
      <input type="hidden" name="OBLI_PASSWORD" value="{document($doc)/translation/texts/item[@name='obli_password']/node()}"/>
      <input type="hidden" name="OBLI_TELEFONO" value="{document($doc)/translation/texts/item[@name='obli_telefono']/node()}"/>
      <input type="hidden" name="OBLI_SEL_DEPARTAMENTOS" value="{document($doc)/translation/texts/item[@name='obli_sel_departamentos']/node()}"/>
      <input type="hidden" name="DESTACADO_ENVIADO_EXITO" value="{document($doc)/translation/texts/item[@name='destacado_enviado_exito']/node()}"/>
      <input type="hidden" name="TIENE_PEDIDOS_AVISO" value="{document($doc)/translation/texts/item[@name='tiene_pedidos_aviso']/node()}"/>
      <input type="hidden" name="CAR_RAROS" value="{document($doc)/translation/texts/item[@name='caracteres_raros_sin_barra']/node()}"/>
      <input type="hidden" name="CAR_RAROS_USUARIO" value="{document($doc)/translation/texts/item[@name='caracteres_raros_usuario']/node()}"/>
      <input type="hidden" name="PERFIL_USUARIO_CAMBIADO" value="{document($doc)/translation/texts/item[@name='perfil_usuario_cambiado']/node()}"/>
      <input type="hidden" name="US_USUARIO_CAMBIADO" value="{document($doc)/translation/texts/item[@name='us_usuario_cambiado']/node()}"/>
      <input type="hidden" name="US_USUARIO_ERROR" value="{document($doc)/translation/texts/item[@name='us_usuario_error']/node()}"/>
      <input type="hidden" name="US_USUARIO_OBLI" value="{document($doc)/translation/texts/item[@name='us_usuario_obli']/node()}"/>
      <input type="hidden" name="IMPORTESINSUPERVISION_ERROR" value="{document($doc)/translation/texts/item[@name='importe_supervisor_error']/node()}"/>
      
     </form>
    <!--fin form para mensajes js-->
</xsl:template>

<xsl:template match="USUARIO">
  <xsl:apply-templates select="ID_USUARIO"/>
  <input type="hidden" name="US_OPERADOR" value="-1"/>
  <!--<xsl:apply-templates select="US_AVISOS_MOVIL"/>-->
  <xsl:apply-templates select="US_PEDIDOMAXIMO"/>
  <xsl:apply-templates select="US_COMPRAMENSUALMAXIMA"/>
  <xsl:apply-templates select="US_COMPRAANUALMAXIMA"/>
  <xsl:apply-templates select="US_LIMITACIONFAMILIAS"/>
  <input type="hidden" name="EMP_ID" value="{EMP_ID}"/>
  <input type="hidden" name="CAMBIOS_MENUS"/>
  <input type="hidden" name="CAMBIOS_DEPTS"/>
  <input type="hidden" name="US_CENTROSAUTORIZADOS" value=""/>

  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->
    <xsl:choose>
        <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ID_USUARIO != '0'">
            <h1 class="titlePage" style="float:left;width:70%;padding-left:10%;">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:&nbsp;<xsl:value-of select="/Mantenimiento/form/Lista/USUARIO/US_NOMBRE" />&nbsp;<xsl:value-of select="/Mantenimiento/form/Lista/USUARIO/US_APELLIDO1" />
              <xsl:if test="/Mantenimiento/form/Lista/USUARIO/MVM or /Mantenimiento/form/Lista/USUARIO/MVMB or /Mantenimiento/form/Lista/USUARIO/ADMIN">
                            <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                                <a title="Ficha Empresa" style="text-decoration:none;">
                                        <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="/Mantenimiento/form/Lista/USUARIO/EMP_ID"/>&amp;VENTANA=NUEVA','DetalleEmpresa',100,58,0,-50)</xsl:attribute>
					<img src="http://www.newco.dev.br/images/verFichaIcon.gif" alt="Ficha empresa" />
                                        <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>-->
				</a>
                                <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<a href="javascript:window.print();" title="Imprimir" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif" alt="Imprimir"/>
					<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>-->
				</a>
                                <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Testimonios/Testimonios.xsql?IDUSUARIOTESTIMONIO={ID_USUARIO}','Testimonios',80,70,0,-50)">
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='testimonios']/node()"/>
				</a>
			</xsl:if>
            </h1>
            <h1 class="titlePage" style="float:left;width:20%">
                <span style="float:right; padding:5px; font-weight:bold;" class="amarillo">US_ID=<xsl:value-of select="ID_USUARIO"/></span>
            </h1>
        </xsl:when>
        <xsl:otherwise>
            <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_usuario']/node()"/></h1>
        </xsl:otherwise>
    </xsl:choose>

<div class="divLeft">
<table class="infoTable" border="0">
	<tr>
		<td colspan="5">
			<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben']/node()"/></span>
		</td>
	</tr>
	<tr style="display:none;">
		<td class="labelRight doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</td>
		<td class="datosLeft">
			US_ID=<xsl:value-of select="ID_USUARIO"/>&nbsp;
		</td>
		<td class="labelRight" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='idioma']/node()"/>:</td>

		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="//field[@name='US_IDIDIOMA']"/>
				<xsl:with-param name="defecto" select="/Mantenimiento/form/Lista/USUARIO/US_IDIDIOMA"/>
			</xsl:call-template>
		</td>
	</tr>
	<tr>
                <td class="quince" rowspan="3">
			<img src="http://www.newco.dev.br/Documentos/{/Mantenimiento/form/Lista/USUARIO/URL_LOGOTIPO}" height="80px" width="160px"/>
		</td>
		<td class="labelRight doce">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:<span class="camposObligatorios" width="1%">*</span>
		</td>
		<td class="datosLeft doce">
			<xsl:call-template name="field_funcion">
				<xsl:with-param name="path" select="../../field[@name='US_TITULO']"/>
				<xsl:with-param name="IDAct"><xsl:value-of select="US_TITULO"/>|<xsl:value-of select="US_IDSEXO"/></xsl:with-param>
			</xsl:call-template>
		</td>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span>
		</td>
		<td class="datosLeft"><xsl:apply-templates select="US_NOMBRE"/></td>
	</tr>
	<tr>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='primer_apellido']/node()"/>:<span class="camposObligatorios">*</span>
		</td>
		<td class="datosLeft"><xsl:apply-templates select="US_APELLIDO1"/></td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='segundo_apellido']/node()"/>:</td>
		<td class="datosLeft">
			<xsl:apply-templates select="US_APELLIDO2"/>
			<input type="hidden" name="US_IDSEXO" value="{US_IDSEXO}"/>
		</td>
	</tr>
	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='e_mail']/node()"/>:</td>
		<td colspan="3" class="datosLeft"><xsl:apply-templates select="US_EMAIL"/></td>
	</tr>
	<tr>
		<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='segundo_e_mail']/node()"/>:</td>
		<td colspan="3" class="datosLeft">
			<xsl:apply-templates select="US_EMAIL2"/>&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='recibira_copia_mensajes']/node()"/>
		</td>
	</tr>
	<tr>
		<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono_movil']/node()"/>:</td>
		<td class="datosLeft"><xsl:apply-templates select="US_TF_MOVIL"/></td>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono_fijo']/node()"/>:<!--<span class="camposObligatorios">*</span>-->
		</td>
		<td class="datosLeft"><xsl:apply-templates select="US_TF_FIJO"/></td>
	</tr>
	<tr>
		<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</td>
		<td class="datosLeft">
			<xsl:variable name="v_IDCENTRO">
				<xsl:choose>
				<xsl:when test="../../../CEN_ID!=''">
					<xsl:value-of select="../../../CEN_ID"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//US_IDCENTRO"/>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/GERENTECENTRO=''">
				<xsl:call-template name="field_funcion">
					<xsl:with-param name="path" select="../../field[@name='US_IDCENTRO']"/>
					<xsl:with-param name="IDAct" select="$v_IDCENTRO"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="../../field[@name='US_IDCENTRO']/dropDownList/listElem">
					<xsl:if test="$v_IDCENTRO=ID">
						<input type="hidden" name="US_IDCENTRO" value="{ID}"/>
						<xsl:value-of select="listItem"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:otherwise>
			</xsl:choose>
		</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_usuario']/node()"/>:</td>
		<td class="datosLeft">
			<xsl:call-template name="field_funcion">
				<xsl:with-param name="path" select="../../field[@name='US_IDTIPO']"/>
				<xsl:with-param name="IDAct" select="US_IDTIPO"/>
			</xsl:call-template>
		</td>
	</tr>
	<tr>
		<!--avisos por email-->
		<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='avisos_por_mail']/node()"/>:</td>
		<td colspan="3" class="datosLeft">
			<xsl:apply-templates select="US_AVISOS_EMAIL"/>
			<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='marcar_avisos_por_mail']/node()"/>
		</td>
	</tr>
	<tr>
		<!--control accesos-->
		<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='control_accesos']/node()"/>:</td>
		<td colspan="3" class="datosLeft">
			<xsl:apply-templates select="US_CONTROLACCESOS"/>
			<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='marcar_control_accesos']/node()"/>
		</td>
	</tr>
        <tr>
            <xsl:attribute name="style">
                <xsl:if test="US_BLOQUEADO = 'S'">background:#FB6666;</xsl:if>
            </xsl:attribute>
		<!--bloquear usuario-->
		<td colspan="2" class="labelRight">
                    <span>
                        <xsl:attribute name="style">
                            <xsl:if test="US_BLOQUEADO = 'S'">color:#000;</xsl:if>
                        </xsl:attribute>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear']/node()"/>:
                    </span>
                </td>
		<td colspan="3" class="datosLeft">
			<xsl:apply-templates select="US_BLOQUEADO"/>
			<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear_expli']/node()"/>
		</td>
	</tr>
        <!--perfil usuario-->
        <xsl:choose>
        <xsl:when test="/Mantenimiento/form/Lista/USUARIO/PERFILES/field/dropDownList/listElem/ID[last()] != ''">
            <tr>
		<td colspan="2" class="labelRight">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='perfil']/node()"/>:
                </td>
		<td colspan="3" class="datosLeft">
                        <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="/Mantenimiento/form/Lista/USUARIO/PERFILES/field"></xsl:with-param>
                            <xsl:with-param name="onChange">javascript:VerPersonalizacion();</xsl:with-param>
                        </xsl:call-template>
                        <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='perfil_expli']/node()"/>
		</td>
            </tr>
        </xsl:when>
        <xsl:otherwise><input type="hidden" name="US_IDPERFIL" id="US_IDPERFIL" /></xsl:otherwise>
        </xsl:choose>
        <!--usuario INTEGRACION en clientes solo para empresas que reciben pdf; para provee siempre-->
        <xsl:choose>
        <xsl:when test="EMP_ENVIARPDF = 'S' and /Mantenimiento/form/Lista/USUARIO/ROL = 'COMPRADOR'">
          <tr style="background:#F3F781;">
           <td colspan="2" class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/>:
          </td>
          <td colspan="3" class="datosLeft">
                  <xsl:apply-templates select="US_INTEGRACION"/>
                  <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='integracion_expli_cliente']/node()"/>
          </td>
          </tr>
        </xsl:when>
        <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'VENDEDOR'">
            <tr style="background:#F3F781;">
           <td colspan="2" class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/>:
          </td>
          <td colspan="3" class="datosLeft">
                  <xsl:apply-templates select="US_INTEGRACION"/>
                  <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                  <xsl:choose>
                      <xsl:when test="EMP_ENVIARPDF = 'S'">
                          <xsl:value-of select="document($doc)/translation/texts/item[@name='integracion_expli_provee_si_pdf']/node()"/>
                      </xsl:when>
                      <xsl:otherwise>
                          <xsl:value-of select="document($doc)/translation/texts/item[@name='integracion_expli_provee_no_pdf']/node()"/>
                      </xsl:otherwise>
                  </xsl:choose>

          </td>
          </tr>
        </xsl:when>
        </xsl:choose>
	<tr id="botonPersonalizacion">
            <xsl:attribute name="style">
                <xsl:choose>
                    <xsl:when test="/Mantenimiento/form/Lista/USUARIO/PERFILES/field/@current != ''">display:none;</xsl:when>
                    <xsl:otherwise>display:;</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <td colspan="2">&nbsp;</td>
             <td class="trenta">
                <div class="botonLargoVerdadNara">
                    <a id="opcionesAvanzadas" style="cursor:pointer;">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='personalizacion_derechos']/node()"/>
                    </a>
                </div>
            </td>
            <td class="veinte">

            </td>
            <td>&nbsp;</td>
	</tr>
</table>
</div><!--fin de divLeft-->

<div id="opcionesAvanzadasDiv" class="divLeft" style="display:none; border:2px solid #3B5998; background:url(http://www.newco.dev.br/images/fondoAma.gif);">

 <!--botones de perfiles de comprador y vendedor-->
      <table class="infoTable" border="0">
          <tr>
              <td colspan="6" class="datosLeft">&nbsp;</td>
          </tr>
          <tr>
              <td>&nbsp;</td>
              <td colspan="5" class="datosLeft">
                  <b>
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='asignar_derechos_avanzados']/node()"/>:
                  </b>
              </td>
          </tr>
           <tr>
              <td>&nbsp;</td>
              <td colspan="5" class="datosLeft">
                  <div id="confirmBoxUsuario" style="display:none;text-align:left;"></div>
                  <div id="waitBoxUsuario" style="display:none;">&nbsp;</div>
              </td>
          </tr>
          <xsl:choose>
                <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'COMPRADOR'">
                    <tr>
                        <td class="labelRight veinte" >
                          1)&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='valores_defecto']/node()"/>:
                        </td>
                        <td class="veinte">
                            <div class="boton">
                                <a href="javascript:AsignarPerfilUsuario('COMPR-ADMIN','{/Mantenimiento/form/Lista/USUARIO/ID_USUARIO}')"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador_admin']/node()"/></a>
                            </div>
                        </td>
                        <td class="veinte">
                            <div class="boton">
                                <a href="javascript:AsignarPerfilUsuario('COMPR-CDC','{/Mantenimiento/form/Lista/USUARIO/ID_USUARIO}')"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador_cdc']/node()"/></a>
                            </div>
                        </td>
                        <td class="veinte">
                            <div class="boton">
                                <a href="javascript:AsignarPerfilUsuario('COMPR-COMM','{/Mantenimiento/form/Lista/USUARIO/ID_USUARIO}')"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador_comercial']/node()"/></a>
                            </div>
                        </td>
                        <td class="veinte">
                            <div class="boton">
                                <a href="javascript:AsignarPerfilUsuario('COMPR-NORMAL','{/Mantenimiento/form/Lista/USUARIO/ID_USUARIO}')"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador_normal']/node()"/></a>
                            </div>
                        </td>
                        <td></td>
                    </tr>
                </xsl:when>
                <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'VENDEDOR'">
                     <tr>
                        <td class="labelRight veinte" >
                          1)&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='valores_defecto']/node()"/>:
                        </td>
                        <!--<td class="veinte">
                            <div class="boton">
                                <a href="javascript:AsignarPerfilUsuario('VEND-ADMIN','{/Mantenimiento/form/Lista/USUARIO/ID_USUARIO}')"><xsl:value-of select="document($doc)/translation/texts/item[@name='vendedor_admin']/node()"/></a>
                            </div>
                        </td>-->

                        <td class="veinte">
                            <div class="boton">
                                <a href="javascript:AsignarPerfilUsuario('VEND-NORMAL','{/Mantenimiento/form/Lista/USUARIO/ID_USUARIO}')"><xsl:value-of select="document($doc)/translation/texts/item[@name='vendedor_normal']/node()"/></a>
                            </div>
                        </td>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                </xsl:when>
          </xsl:choose>
      </table>
      <!--fin de botones de perfiles-->
      <!--select usuarios para copiar derechos-->

      <table class="infoTable" border="0">
          <input type="hidden" name="PARAMETROS" id="PARAMETROS" />
          <input type="hidden" name="ACCION" id="ACCION" />
          <input type="hidden" name="US_COPIA_DESTINO" id="US_COPIA_DESTINO" value="{/Mantenimiento/form/Lista/USUARIO/ID_USUARIO}" />
          <tr>
              <td>&nbsp;</td>
              <td colspan="7">
                  <div id="confirmBoxCopiarDer" style="display:none;text-align:left;"></div>
                  <div id="waitBoxCopiarDer" style="display:none;">&nbsp;</div>
              </td>
          </tr>
          <xsl:choose>
          <xsl:when test="./US_IDUSUARIOCONTROL/field/dropDownList/listElem/ID != ''">
            <tr>
                <td class="labelRight veinte" >
                         2)&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_derechos_otro_usuario']/node()"/>:
               </td>
               <td class="datosLeft quince">
                   <select name="US_COPIA_ORIGEN" id="US_COPIA_ORIGEN" style="width:150px;">
                       <option value="">
                           <xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/>
                       </option>
                       <xsl:for-each select="./US_IDUSUARIOCONTROL/field/dropDownList/listElem">
                           <xsl:if test="ID != ''">
                            <option value="{ID}"><xsl:value-of select="listItem"/></option>
                           </xsl:if>
                       </xsl:for-each>
                   </select>
               </td>
               <td class="veinte">
                   <div class="botonLargo">
                       <a href="javascript:CopiarDerechos('COPIARDERECHOS')"><xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_derechos_generales']/node()"/></a>
                   </div>
               </td>
               <td class="uno">&nbsp;</td>
               <td class="diecisiete">
                   <div class="botonLargo">
                       <a href="javascript:CopiarDerechos('COPIARMENUS')"><xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_derechos_menus']/node()"/></a>
                   </div>
               </td>
               <td class="uno">&nbsp;</td>
               <td class="trenta">
                   <div class="botonLargo">
                       <a href="javascript:CopiarDerechos('COPIARPLANTILLAS')"><xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_derechos_carpetas_plantillas']/node()"/></a>
                   </div>
               </td>
               <td></td>
           </tr>
           </xsl:when>
           <xsl:otherwise>
            <tr>
                <td class="labelRight veinte" >
                         2)&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_derechos_otro_usuario']/node()"/>:
               </td>
               <td class="datosLeft veinte">
                   <select name="US_COPIA_ORIGEN" id="US_COPIA_ORIGEN" disabled="disabled">
                       <option value="">
                           <xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/>
                       </option>
                       <xsl:for-each select="./US_IDUSUARIOCONTROL/field/dropDownList/listElem">
                           <xsl:if test="ID != ''">
                            <option value="{ID}"><xsl:value-of select="listItem"/></option>
                           </xsl:if>
                       </xsl:for-each>
                   </select>
               </td>
               <td class="veinte">
                   <div class="botonLargo">
                       <xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_derechos_generales']/node()"/>
                   </div>
               </td>
               <td class="uno">&nbsp;</td>
               <td class="veinte">
                   <div class="botonLargo">
                       <xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_derechos_menus']/node()"/>
                   </div>
               </td>
               <td class="uno">&nbsp;</td>
               <td class="veintecinco">
                   <div class="botonLargo">
                       <xsl:value-of select="document($doc)/translation/texts/item[@name='copiar_derechos_carpetas_plantillas']/node()"/>
                   </div>
               </td>
               <td></td>
           </tr>
           </xsl:otherwise>
          </xsl:choose>
      </table>

      <br /><br />
      <!--botones manuales-->
       <table class="infoTable" border="0">
          <tr>
                <td class="labelRight veinte" >
                 3)&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='edicion_manual']/node()"/>:
                </td>
                <td class="quince">
			<div class="botonLargo">
					<a>
                     <xsl:choose>
                        <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'COMPRADOR'">
                            <xsl:attribute name="href">javascript:DerechosMenus(<xsl:value-of select="//ID_USUARIO"/>,<xsl:value-of select="//EMP_ID"/>);</xsl:attribute>
                        </xsl:when>
                        <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'VENDEDOR'">
                            <xsl:attribute name="href">javascript:DerechosMenus(<xsl:value-of select="//ID_USUARIO"/>,<xsl:value-of select="//EMP_ID"/>);</xsl:attribute>
                        </xsl:when>
                     </xsl:choose>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_menus']/node()"/>
					</a>
			</div>
	        </td>
                <xsl:if test="/Mantenimiento/form/Lista/USUARIO/ROL = 'COMPRADOR'">
                <td class="dos">&nbsp;</td>
                <td class="veintecinco">
                    <div class="botonLargo">
                        <a>
                          <xsl:attribute name="href">javascript:DerechosCARPyPL(<xsl:value-of select="//US_ID"/>,<xsl:value-of select="//ID_USUARIO"/>);</xsl:attribute>
                          <xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_carpetas_plantillas']/node()"/>
                          </a>
                    </div>
                </td>
                </xsl:if>
                <td colspan="2">&nbsp;</td>
                <td></td>
          </tr>
     </table>
    <br /><br />
 </div><!--fin de opcionesAvanzadasdiv-->

    <br /><br />
    <table class="infoTable" border="0">
      <tr class="titulos">
      	<td colspan="6">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='login_y_password']/node()"/>
            </td>
      </tr>
      <tr><td colspan="6">&nbsp;</td></tr>
   <tr>
     <td class="labelRight veinte">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:<span class="camposObligatorios">*</span>
       &nbsp;
         <br/><br/>
         <xsl:if test="US_CLAVE != '' and /Mantenimiento/VER_USUARIO and /Mantenimiento/form/Lista/USUARIO/ADMIN" >
         <xsl:value-of select="document($doc)/translation/texts/item[@name='password']/node()"/>:&nbsp;
         </xsl:if>
     </td>
     <td class="datosLeft quince">
       <xsl:apply-templates select="US_USUARIO"/>
        <br/><br/>
          <xsl:if test="/Mantenimiento/VER_USUARIO and /Mantenimiento/form/Lista/USUARIO/ADMIN">
          	<xsl:value-of select="US_CLAVE" />
          </xsl:if>
     </td>
     <td class="quince labelRight">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='password']/node()"/>:<span class="camposObligatorios">**</span>
       <br/><br/>
       <xsl:value-of select="document($doc)/translation/texts/item[@name='repita_password']/node()"/>:
     </td>
      <td class="datosLeft quince">
        <input type="password" name="US_CLAVE" size="10" maxlength="30"/>
        <br/><br/>
        <input type="password" name="US_CLAVE_REP" size="10" maxlength="30"/>
      </td>
      <td class="labelRight quince">
         <xsl:if test="/Mantenimiento/VER_USUARIO and /Mantenimiento/form/Lista/USUARIO/ADMIN">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='password']/node()"/> md5:&nbsp;
         </xsl:if>
     </td>
     <td class="datosLeft">
        <xsl:choose>
        <xsl:when test="/Mantenimiento/form/Lista/USUARIO/US_CLAVE_MD5 != '' and /Mantenimiento/VER_USUARIO and /Mantenimiento/form/Lista/USUARIO/ADMIN">
            <span id="claveEncript"><xsl:value-of select="/Mantenimiento/form/Lista/USUARIO/US_CLAVE_MD5"/></span>
            <input type="password" name="US_CLAVE_MD5" id="US_CLAVE_MD5" size="10" maxlength="30" style="display:none;"/>&nbsp;
            <a href="javascript:CambioClaveEncript();" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Cambio Clave encriptada" /></a>

        </xsl:when>
         <xsl:when test="/Mantenimiento/VER_USUARIO and /Mantenimiento/form/Lista/USUARIO/ADMIN">
            <input type="password" name="US_CLAVE_MD5" size="10" maxlength="30"/>
        </xsl:when>
        </xsl:choose>
     </td>
    </tr>
    <tr>
        <td colspan="2">
        <span class="font11"><span class="camposObligatorios">*</span>&nbsp;&nbsp;&nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='campos_obligatorios']/node()"/></span>.
        </td>
        <td colspan="2">
        <span class="font11"><span class="camposObligatorios">**</span>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='campos_obligatorios_alta']/node()"/></span>.
        </td>
        <td>&nbsp;</td>
    </tr>
    </table>

   <!--<table class="infoTable">
   <tr class="titulos">
	<td colspan="4" align="center" class="medio">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_de_negociacion']/node()"/>
	</td>
   </tr>
   <tr>
      <td class="labelRight veinte">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='negociador']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
         <xsl:apply-templates select="US_NEGOCIADOR"/>
      	 <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
         <xsl:value-of select="document($doc)/translation/texts/item[@name='solo_negociador']/node()"/>
       </td>
    </tr>
    <tr>
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_responsable_negociaciones']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
            <xsl:apply-templates select="US_SOLONEGOCIADOR"/>
            <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_responsable_unicamente']/node()"/>.
      </td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>
 </table>-->
 <!--Derechos de administración del Usuario-->
  <xsl:choose>
   <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'VENDEDOR'"> <!--OCULTAMOS CAMPO ADMINISTRADOR PARA PROVEEDORES 29/05/14 MC y central de compras 26-6-14-->
       <input type="checkbox" name="US_USUARIOGERENTE" onClick="privilegiosUsuario();" style="display:none;"/>
       <input type="checkbox" name="US_CENTRALCOMPRAS" onClick="privilegiosUsuario();" style="display:none;"/>
   </xsl:when>
   <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'COMPRADOR'">
    <table class="infoTable">
      <tr class="titulos">
           <td colspan="5">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_administracion_usuario']/node()"/>
           </td>
      </tr>
      <!--OCULTAMOS CAMPO ADMINISTRADOR PARA PROVEEDORES 29/05/14 MC-->
      <tr style="height:40px;background:#F3F781;">
         <td class="labelRight veinte">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='administrador']/node()"/>:
         </td>
         <td class="cinco"><xsl:apply-templates select="US_USUARIOGERENTE"/></td>
         <td colspan="3" class="datosLeft">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='administrador_expli']/node()"/><br />
         </td>
       </tr>
       <!--quitado administrador de centro 14-4-14 mc por errores en usuarios-->
       <tr style="height:40px; display:none;">
         <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='administrador_de_centro']/node()"/>:
         </td>
         <td><xsl:apply-templates select="US_GERENTECENTRO"/></td>
         <td colspan="3" class="datosLeft">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='administrador_de_centro_expli']/node()"/>.<br />
         </td>
       </tr>
       <!-- DC - 11/11/13 - Movido de la zona soloCliente -->
       <tr style="height:40px;">
         <td class="labelRight veinte">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='central_de_compra']/node()"/>:
         </td>
         <td><xsl:apply-templates select="US_CENTRALCOMPRAS"/></td>
         <td colspan="3" class="datosLeft">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='central_de_compra_expli']/node()"/><br />
         </td>
       </tr>
       <!-- DC - 11/11/13 -->
       <tr height="5px"><td colspan="4">&nbsp;</td></tr>
     </table>
   </xsl:when>
  </xsl:choose>

  <table class="infoTable">
   <tr class="titulos">
	<td colspan="5">
    	 <xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_eis_usuario']/node()"/>
	</td>
   </tr>
   <tr>
      <td class="labelRight veinte">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:
      </td>
      <td class="cinco"> <xsl:apply-templates select="US_EIS_ACCESOGERENTE"/></td>
      <td colspan="3" class="datosLeft">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='consulta_todos_datos_empresa']/node()"/>
      </td>
    </tr>
    <tr>
      <td class="labelRight">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:
      </td>
      <td>  <xsl:apply-templates select="US_EIS_ACCESOCENTRO"/></td>
      <td colspan="3" class="datosLeft">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='consulta_todos_datos_centro']/node()"/>
      </td>
    </tr>
    <tr>
      <td class="labelRight">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='eis_semplificado']/node()"/>:
      </td>
      <td> <xsl:apply-templates select="US_EISSIMPLIFICADO"/></td>
      <td colspan="3" class="datosLeft">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='eis_semplificado_expli']/node()"/>
      </td>
    </tr>
    <!--filtro productos quitado 14-4-14 mc por errores derechos usuarios, ahora siempre a N-->
    <tr style="display:none;">
      <td class="labelRight">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='filtro_productos']/node()"/>:
      </td>
      <td> <xsl:apply-templates select="US_EIS_FILTROPRODUCTOS"/></td>
      <td colspan="3" class="datosLeft">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='filtro_productos_expli']/node()"/>
      </td>
    </tr>
    <tr><td colspan="5">&nbsp;</td></tr>
    </table>

    <table class="infoTable" border="0">
    <tr class="titulos">
      <td colspan="6">
              <a name="dept"/>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='departamento']/node()"/>
              <br/>
              <i><xsl:value-of select="document($doc)/translation/texts/item[@name='seleccione_los_departamentos']/node()"/></i>
      </td>
      </tr>
        <tr>
        <td class="cinco">&nbsp;</td>
          <xsl:for-each select="/Mantenimiento/form/Lista/USUARIO/DEPARTAMENTOS_DE_USUARIO/DEPARTAMENTO">

                    <td class="veinte">
                      <xsl:value-of select="NOMBRE"/>
                   &nbsp;&nbsp;
                      <xsl:choose>
                        <xsl:when test="PERTENECE">
                          <input type="checkbox" name="DEPT_{ID}" checked="checked"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <input type="checkbox" name="DEPT_{ID}" unchecked="unchecked"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>

        </xsl:for-each>
         </tr>
   <tr height="5px"><td colspan="6">&nbsp;</td></tr>
   </table>

    <!--<table class="infoTable">
    <tr class="titulos">
	<td colspan="5">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_acceso_remoto_usuario']/node()"/>:
	</td>
   </tr>
   <tr>
      <td class="labelRight veinte">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_enviados']/node()"/>:
      </td>
      <td class="cinco"><xsl:apply-templates select="US_AR_PEDIDOSENVIADOS"/></td>
      <td colspan="3" class="datosLeft">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_enviados_expli']/node()"/>
      </td>
    </tr>
    <tr>
      <td class="labelRight">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_recibidos']/node()"/>:
      </td>
      <td> <xsl:apply-templates select="US_AR_PEDIDOSRECIBIDOS"/></td>
      <td colspan="3" class="datosLeft">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_recibidos_expli']/node()"/>
      </td>
    </tr>
    <tr><td colspan="5">&nbsp;</td></tr>
   </table>-->


  <!--quitado 26-6-14 <table class="infoTable">
    	<tr style="border-bottom:2px solid #3b5998;">
            <td class="tres">&nbsp;</td>
            <td class="veinte" style="background:#becff4; font-weight:bold; border:2px solid #3b5998;color:#3B5998;">
                <xsl:choose>
                    <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'VENDEDOR'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_proveedor']/node()"/>
                    </xsl:when>
                    <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'COMPRADOR'">
                         <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_cliente']/node()"/>
                    </xsl:when>
                </xsl:choose>
            </td>
            <td colspan="2">&nbsp;</td>
       </tr>
    </table>-->
   <!--solo para el proveedor-->
   <div id="soloProveedor">
      <xsl:attribute name="style">
            <xsl:choose>
            <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'VENDEDOR'">display:block;</xsl:when>
            <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'COMPRADOR'">display:none;</xsl:when>
            </xsl:choose>
      </xsl:attribute>
   <table class="infoTable">
    <tr class="titulos">
	<td colspan="5">
   	<xsl:value-of select="document($doc)/translation/texts/item[@name='delegados']/node()"/>
	</td>
   </tr>
   <tr>
      <td class="labelRight veinte">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='delegado_urgencias']/node()"/>:
      </td>
      <td class="cinco"> <xsl:apply-templates select="US_DELEGADOURGENCIAS"/></td>
      <td colspan="3" class="datosLeft">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='delegado_urgencias_expli']/node()"/>
      </td>
    </tr>
    <tr>
      <td class="labelRight veinte">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='zona_cobertura']/node()"/>:
      </td>
      <td colspan="4" class="datosLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <xsl:apply-templates select="US_DELEGADOZONA"/>
      </td>

    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>
   </table>


   </div><!--fin de soloProveedor-->


    <!--solo para el cliente-->
    <div id="soloCliente">
     <xsl:attribute name="style">
            	<xsl:choose>
                <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'VENDEDOR'">display:none;</xsl:when>
                <xsl:when test="/Mantenimiento/form/Lista/USUARIO/ROL = 'COMPRADOR'">display:;</xsl:when>
                <xsl:otherwise>display:none;</xsl:otherwise>
                </xsl:choose>
      </xsl:attribute>



      <table class="infoTable" border="0">
    	<tr class="titulos">
	<td colspan="5">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='opciones_especificas_clientes']/node()"/>
	</td>
        </tr>
       <!--enviar destacados-->
       <tr>
       		<td>&nbsp;</td>
            <td colspan="3">
            	<div id="waitBox" style="display:none;">&nbsp;</div>
                <div id="confirmBox" style="display:none;">&nbsp;</div>
                <div class="boton" id="botonEnviaDesta">
                    <a>
                    <xsl:attribute name="href">javascript:enviarDestacados(<xsl:value-of select="ID_USUARIO"/>)</xsl:attribute>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_destacados']/node()"/>
                    </a>
                </div>
            </td>

       </tr>
 	  <tr>
       <td class="labelRight veinte" >
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_controlados_por']/node()"/>:
      </td>
      <td class="datosLeft veinte">
          <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="./US_IDUSUARIOCONTROL/field"/>
    	  <xsl:with-param name="IDAct" select="US_IDUSUARIOCONTROL"/>
    	</xsl:call-template>
        <td class="labelRight quince">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='limite_pedido_para_supervision']/node()"/>:
      </td>
      <td class="datosLeft">
          <input type="text" name="US_IMPORTESINSUPERVISION" id="US_IMPORTESINSUPERVISION" value="{US_IMPORTESINSUPERVISION}" title="Valor númerico" />
      </td>
        
      </td>
      </tr>
      
      <tr>
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas_controlados_por']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
        <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="./US_IDUSUARIOEMPLANTILLADOR/field"/>
    	  <xsl:with-param name="IDAct" select="US_IDUSUARIOEMPLANTILLADOR/field/@current"/>
    	</xsl:call-template>
      </td>
   </tr>

  <tr>
   <!--ver ofertas proveedor-->
       <td class="labelRight">
     	<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ofertas_proveedores']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
              <xsl:apply-templates select="US_VEROFERTAS"/>
              <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='marcar_ver_ofertas_proveedores']/node()"/>
      </td>
    </tr>
  <tr>
   <!--ver ofertas proveedor-->
       <td class="labelRight">
     	<xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear_ocultos']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
              <xsl:apply-templates select="US_BLOQUEAROCULTOS"/>
              <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='marcar_bloquear_ocultos']/node()"/>
      </td>
    </tr>
     <tr>
   <!--recibir avisos-->
       <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='recibir_avisos_comerciales']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
              <xsl:apply-templates select="US_AVISOSCAMBIOSCAT"/>
              <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
               <xsl:value-of select="document($doc)/translation/texts/item[@name='marcar_recibir_avisos_comerciales']/node()"/>
      </td>
      </tr>
   <!--recibir avisos pedidos -->
     <tr>
       <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='recibir_avisos_pedidos']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
              <xsl:apply-templates select="US_AVISOSRESUMENPEDIDOS"/>
              <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='recibir_avisos_pedidos_expli']/node()"/>
      </td>
      </tr>
      <tr>
   <!--usuario observador, no ve inicio-->
       <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='observador']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
      <xsl:apply-templates select="US_OBSERVADOR"/>
      <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
       <xsl:value-of select="document($doc)/translation/texts/item[@name='observador_expli']/node()"/>
      </td>
      </tr>
       <tr>
		<!--usuario comercial solo para mvm o mvmb-->
       <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='comercial_actividad']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
      <xsl:apply-templates select="US_COMERCIAL"/>
      <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
       <xsl:value-of select="document($doc)/translation/texts/item[@name='comercial_expli']/node()"/>
      </td>
      </tr>
        <!--usuario minimalista 21-5-15 proveedores.com-->
      <tr>
       <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='minimalista']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
              <xsl:apply-templates select="US_MINIMALISTA"/>
              <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
               <xsl:value-of select="document($doc)/translation/texts/item[@name='minimalista_expli']/node()"/>
      </td>
      </tr>
	<!--	Puede vender lotes (Solo para España)	-->
	<xsl:choose>
	<xsl:when test="/Mantenimiento/form/Lista/USUARIO/EMP_IDPAIS = '34'">

      <tr>
       <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='vender_lotes']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
		<xsl:apply-templates select="US_VENDERLOTES"/>
		<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='vender_lotes_expli']/node()"/>
      </td>
      </tr>
	</xsl:when>
	<xsl:otherwise>
		<input type="hidden" value="{US_VENDERLOTES}"/>
	</xsl:otherwise>
	</xsl:choose>

</table>

  <table class="infoTable" border="0" id="derechosCompraOtrosCentros">
    <tr class="titulos">
	<td colspan="4">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_compra_otros_centros']/node()"/>
	</td>
   </tr>
   <tr>
      <td class="labelRight veinte">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_multicentros']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft"><xsl:apply-templates select="US_MULTICENTROS"/><xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_multicentros_expli']/node()"/>
      </td>
    </tr>
    <tr>
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_autorizados']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
			<xsl:apply-templates select="./CENTROSAUTORIZADOS"/>
      </td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>
  </table>

<!-- DC - 15/05/14 - Se oculta las dos siguientes tablas para Brasil -->
  <input type="hidden" name="NUEVO_MODELO_NEG" id="NUEVO_MODELO_NEG">
      <xsl:attribute name="value"><xsl:if test="/Mantenimiento/form/Lista/USUARIO/NUEVO_MODELO">S</xsl:if></xsl:attribute>
  </input>
<xsl:if test="/Mantenimiento/form/Lista/USUARIO/EMP_IDPAIS = '34' and /Mantenimiento/form/Lista/USUARIO/NUEVO_MODELO">
   <table class="infoTable" id="nuevoModeloNeg">
    <tr class="titulos">
	<td colspan="5">
    	 	<xsl:value-of select="document($doc)/translation/texts/item[@name='campos_nuevo_modelo']/node()"/>
	</td>
   </tr>
   <tr>
      <td class="labelRight veinte">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='navegar_proveedores']/node()"/>:

      </td>
      <td colspan="3" class="datosLeft"><xsl:apply-templates select="US_NAVEGARPROVEEDORES"/><xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='navegar_proveedores_expli']/node()"/>
      </td>
    </tr>
    <tr>
      <td class="labelRight veinte">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_antiguo']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
              <xsl:apply-templates select="US_PEDIDOANTIGUO"/><xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_antiguo_expli']/node()"/>
      </td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>
   </table>

    <table class="infoTable" border="0">
    <tr class="titulos">
        <td colspan="4" >
            <xsl:value-of select="document($doc)/translation/texts/item[@name='carpetas_y_plantillas']/node()"/>
        </td>
    </tr>
   <tr>
      <td class="labelRight veinte">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_carpetas']/node()"/>:
      </td>
       <td colspan="3" class="datosLeft"><xsl:apply-templates select="US_VERCARPETAS"/>
       <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_carpetas_expli']/node()"/>
      </td>
    </tr>
    <tr style="display:none;">
      <td class="labelRight veinte">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas_normales']/node()"/>:
      </td>
       <td colspan="3" class="datosLeft"><xsl:apply-templates select="US_PLANTILLASNORMALES"/>
        <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
        <xsl:value-of select="document($doc)/translation/texts/item[@name='puede_crear_plantillas_normales']/node()"/>
       </td>
    </tr>
    <tr style="display:none;">
      <td class="labelRight veinte">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas_reserva']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft"><xsl:apply-templates select="US_PLANTILLASURGENCIAS"/>
       <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      <xsl:value-of select="document($doc)/translation/texts/item[@name='puede_crear_plantillas_reserva']/node()"/>
      </td>
    </tr>
    </table>

	</xsl:if>


   <table class="infoTable">
    <tr class="titulos">
	<td colspan="5">
    	 	<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>
	</td>
   </tr>
    <tr>
      <td class="labelRight veinte">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_licitaciones']/node()"/>:
      </td>
      <td colspan="3" class="datosLeft">
              <xsl:apply-templates select="US_VERLICITACIONES"/><xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_licitaciones_expli']/node()"/>
      </td>
    </tr>
   <tr>
      <td class="labelRight veinte">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_licitaciones']/node()"/>:

      </td>
      <td colspan="3" class="datosLeft"> <xsl:apply-templates select="US_CREARLICITACIONES"/><xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_licitaciones_expli']/node()"/>
      </td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>
   </table>

    </div><!--fin de div solo cliente-->

    <!--eligo si un usuario es usuario de control de pedidos-->
   <!-- DC - 25/03/14 - Anyadida marca <MOSTRAR_OPCIONES_MVM> solo para usuarios MVM o MVMB -->
     <!--	26may16	<xsl:if test="/Mantenimiento/form/Lista/USUARIO/MOSTRAR_OPCIONES_MVM">: control de pedidos para algunos clientes y proveedores-->
     <xsl:if test="/Mantenimiento/form/Lista/USUARIO/PERMITIR_CONTROL_PEDIDOS">
      <table class="infoTable">
        <tr class="titulos">
        <td colspan="5"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_control']/node()"/></td>
        </tr>
        <tr>
          <td class="labelRight veinte">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_usuario_control']/node()"/>:
          </td>
          <td class="datosLeft quince">
            <input type="text" name="US_CP_NOMBRE" id="US_CP_NOMBRE" value="{US_CP_NOMBRE}" />
          </td>
          <td class="labelRight veinte">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='id_usuario_control']/node()"/>:
          </td>
          <td class="datosLeft">
            <input type="text" name="US_CP_ID" id="US_CP_ID" value="{US_CP_ID}"/>&nbsp;
            (<xsl:value-of select="document($doc)/translation/texts/item[@name='id_usuario_control_expli']/node()"/>&nbsp;<xsl:value-of select="US_USUARIO"/>)
          </td>

        </tr>
        <tr><td colspan="4">&nbsp;</td></tr>
       </table>
    </xsl:if>


	<div class="divLeft" style="border-top:2px solid #3b5998;">
    <br/><br/>
    <div class="divLeft30">&nbsp;</div>
    <div class="divLeft20">
    	<div class="boton">
        	<a href="javascript:history.go(-1)">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
            </a>
        </div>

     </div>
     <div class="divLeft10">&nbsp;</div>
     <div class="divLeft20">
     	<div class="boton">
        	<a href="javascript:ValidaySubmit(document.forms[0]);">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
            </a>
        </div>
     <!--   <xsl:call-template name="boton">
          <xsl:with-param name="path" select="../../button[@label='Aceptar']"/>
        </xsl:call-template>-->
      </div>
      <br/><br/>
   </div>
   <br /><br />
</xsl:template>

<xsl:template match="US_PLANTILLASNORMALES">
  <input type="checkbox" name="US_PLANTILLASNORMALES">
      <xsl:choose>
        <xsl:when test=".='S'">
          <xsl:attribute name="checked"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="unchecked"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:attribute name="onClick">
        privilegiosCarpetas(this);
      </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_PLANTILLASURGENCIAS">
  <input type="checkbox" name="US_PLANTILLASURGENCIAS">
      <xsl:choose>
        <xsl:when test=".='S'">
          <xsl:attribute name="checked"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="unchecked"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:attribute name="onClick">
        privilegiosCarpetas(this);
      </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="ID_USUARIO">
  <input type="hidden" name="ID_USUARIO">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_NOMBRE">
  <input type="hidden" name="US_NOMBRE_OLD" maxlength="70" value="{.}" />
  <input type="text" name="US_NOMBRE" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>


<xsl:template match="US_APELLIDO1">
  <input type="hidden" name="US_APELLIDO1_OLD" maxlength="70" value="{.}" />
  <input type="text" name="US_APELLIDO1" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_APELLIDO2">
  <input type="hidden" name="US_APELLIDO2_OLD" maxlength="70" value="{.}" />
  <input type="text" name="US_APELLIDO2" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_EMAIL">
  <input type="text" name="US_EMAIL" maxlength="70" size="50">
    <xsl:attribute name="value"><xsl:value-of select="."/> </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_EMAIL2">
  <input type="text" name="US_EMAIL2" maxlength="70" size="50">
    <xsl:attribute name="value"><xsl:value-of select="."/> </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_TF_FIJO">

  <input type="text" name="US_TF_FIJO" maxlength="70">
    <xsl:choose>
      <xsl:when test=".!=''">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
      </xsl:when>
      <!--<xsl:otherwise>
        <xsl:choose>
          <xsl:when test="../CEN_TELEFONO!=''">
            <xsl:attribute name="value"><xsl:value-of select="../CEN_TELEFONO"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="../EMP_TELEFONO"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>-->
    </xsl:choose>
  </input>
</xsl:template>

<xsl:template match="US_TF_MOVIL">
  <input type="text" name="US_TF_MOVIL" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_AVISOS_EMAIL">
	<input type="checkbox" name="US_AVISOS_EMAIL">
		<xsl:choose>
			<xsl:when test=". ='S' ">
				<xsl:attribute name="checked">checked</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="unchecked">unchecked</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="US_CONTROLACCESOS">
  <input type="checkbox" name="US_CONTROLACCESOS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:attribute name="checked">checked</xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
			<xsl:attribute name="unchecked">unchecked</xsl:attribute>
		</xsl:otherwise>
    </xsl:choose>
  </input>
</xsl:template>

<xsl:template match="US_BLOQUEADO">
  <input type="checkbox" name="US_BLOQUEADO">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:attribute name="checked">checked</xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
			<xsl:attribute name="unchecked">unchecked</xsl:attribute>
		</xsl:otherwise>
    </xsl:choose>
  </input>
</xsl:template>

<xsl:template match="US_VEROFERTAS">
  <input type="checkbox" name="US_VEROFERTAS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:attribute name="checked">checked</xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
			<xsl:attribute name="unchecked">unchecked</xsl:attribute>
		</xsl:otherwise>
    </xsl:choose>
  </input>
</xsl:template>

<xsl:template match="US_BLOQUEAROCULTOS">
  <input type="checkbox" name="US_BLOQUEAROCULTOS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:attribute name="checked">checked</xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
			<xsl:attribute name="unchecked">unchecked</xsl:attribute>
		</xsl:otherwise>
    </xsl:choose>
  </input>
</xsl:template>

<xsl:template match="US_AVISOSCAMBIOSCAT">
  <input type="checkbox" name="US_AVISOSCAMBIOSCAT">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:attribute name="checked">checked</xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
			<xsl:attribute name="unchecked">unchecked</xsl:attribute>
		</xsl:otherwise>
    </xsl:choose>
  </input>
</xsl:template>

<xsl:template match="US_PEDIDOMAXIMO">
  <input type="hidden" name="US_PEDIDOMAXIMO" size="9" maxlength="9" onChange="this.value=toInteger(this.value)">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_COMPRAMENSUALMAXIMA">
  <input type="hidden" name="US_COMPRAMENSUALMAXIMA" size="9" maxlength="9" onChange="this.value=toInteger(this.value)">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_COMPRAANUALMAXIMA">
  <input type="hidden" name="US_COMPRAANUALMAXIMA" size="9" maxlength="9" onChange="this.value=toInteger(this.value)">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="US_LIMITACIONFAMILIAS">
    <xsl:choose>
       <xsl:when test=". ='1' ">
	  <xsl:text disable-output-escaping="yes"> <![CDATA[<input type="hidden" name="US_LIMITACIONFAMILIAS" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="hidden" name="US_LIMITACIONFAMILIAS">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<!--	Derechos de administración	-->
<xsl:template match="US_USUARIOGERENTE">
    <xsl:choose>
       <xsl:when test=". ='1' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_USUARIOGERENTE" checked="checked" onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_USUARIOGERENTE" onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_CENTRALCOMPRAS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_CENTRALCOMPRAS" checked="checked" onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_CENTRALCOMPRAS" onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_GERENTECENTRO">
    <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_GERENTECENTRO" onClick="privilegiosUsuario();">]]></xsl:text>
    <!--siempre a N este campo > checkbox no selecionado 14-4-14 mc problemas usuarios
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_GERENTECENTRO" checked onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_GERENTECENTRO" onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>-->
</xsl:template>

<!--	Derechos de acceso al EIS	-->
<xsl:template match="US_EIS_ACCESOGERENTE">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_EIS_ACCESOGERENTE" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_EIS_ACCESOGERENTE">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_EIS_ACCESOCENTRO">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_EIS_ACCESOCENTRO" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_EIS_ACCESOCENTRO">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_EISSIMPLIFICADO">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_EISSIMPLIFICADO" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_EISSIMPLIFICADO">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_EIS_FILTROPRODUCTOS">
    <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_EIS_FILTROPRODUCTOS">]]></xsl:text>
    <!--siempre a N este campo > checkbox no selecionado 14-4-14 mc problemas usuarios
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_EIS_FILTROPRODUCTOS" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_EIS_FILTROPRODUCTOS">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>-->
</xsl:template>

<!--	Derechos de acceso remoto	-->
<xsl:template match="US_AR_PEDIDOSENVIADOS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_AR_PEDIDOSENVIADOS" checked >]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_AR_PEDIDOSENVIADOS">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_AR_PEDIDOSRECIBIDOS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_AR_PEDIDOSRECIBIDOS" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_AR_PEDIDOSRECIBIDOS">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>


<xsl:template match="US_NEGOCIADOR">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_NEGOCIADOR" checked onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_NEGOCIADOR" onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_SOLONEGOCIADOR">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_SOLONEGOCIADOR" checked onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_SOLONEGOCIADOR" onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>


<xsl:template match="US_AVISOSRESUMENPEDIDOS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_AVISOSRESUMENPEDIDOS" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_AVISOSRESUMENPEDIDOS">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_OBSERVADOR">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_OBSERVADOR" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_OBSERVADOR">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_MINIMALISTA">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_MINIMALISTA" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_MINIMALISTA">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_VENDERLOTES">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_VENDERLOTES" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_VENDERLOTES">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_COMERCIAL">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_COMERCIAL" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_COMERCIAL">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_INTEGRACION">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_INTEGRACION" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_INTEGRACION">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>


<!--
  Ponemos el campo oculto en caso de modificacion para no permitir cambiar
  este campo
+-->
<xsl:template match="US_USUARIO">
 <xsl:choose>
   <xsl:when test="../ID_USUARIO=0">
    <input type="text" name="US_USUARIO" size="10" maxlength="30">
      <xsl:attribute name="value"> <xsl:value-of select="."/> </xsl:attribute>
    </input>
   </xsl:when>
   <xsl:otherwise>
     <input type="hidden" name="US_USUARIO_OLD" size="15" maxlength="30">
       <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
     </input>
     <input type="text" name="US_USUARIO" size="15" maxlength="30">
       <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
     </input>&nbsp;<a href="javascript:CambioLogin();" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Cambio Login" /></a>
     <!--<xsl:value-of select="."/> -->
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--	26may09	ET	Centros autorizados		-->

<xsl:template match="US_MULTICENTROS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_MULTICENTROS" checked="S" onclick="javascript:Multicentros();">]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_MULTICENTROS" onclick="javascript:Multicentros();">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>


<xsl:template match="CENTROSAUTORIZADOS">
<table class="infoTable">
	<xsl:for-each select="CENTRO">
	<tr>
    	<td class="datosLeft">
			<!--<xsl:value-of select="ID"/>-->
    		<xsl:choose>
    		   <xsl:when test="AUTORIZADO ='S' ">
		  			<input type="checkbox" name="CENTROAUTORIZADO_{ID}" checked="S" />
    		   </xsl:when>
    		   <xsl:otherwise>
		  			<input type="checkbox" name="CENTROAUTORIZADO_{ID}" />
    		   </xsl:otherwise>
    		</xsl:choose>
                <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text><xsl:value-of select="NOMBRE"/>
		</td>
	  </tr>
    </xsl:for-each>
</table>
</xsl:template>


<xsl:template match="US_PEDIDOANTIGUO">
	<xsl:choose>
		<xsl:when test="/Mantenimiento/form/Lista/USUARIO/NUEVOMODELO='S' ">
    		<xsl:choose>
    		   <xsl:when test=". ='S' ">
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_PEDIDOANTIGUO" checked="S" >]]></xsl:text>
    		   </xsl:when>
    		   <xsl:otherwise>
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_PEDIDOANTIGUO">]]></xsl:text>
    		   </xsl:otherwise>
    		</xsl:choose>
		</xsl:when>
    	<xsl:otherwise>
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" disabled="true" name="US_PEDIDOANTIGUO">]]></xsl:text>
    	</xsl:otherwise>
	</xsl:choose>
	<xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>
<!--	6jul09	ET	Navegar proveedores		-->

<xsl:template match="US_NAVEGARPROVEEDORES">
	<xsl:choose>
		<xsl:when test="/Mantenimiento/form/Lista/USUARIO/NUEVOMODELO='S' ">
    		<xsl:choose>
    		   <xsl:when test=". ='S' ">
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_NAVEGARPROVEEDORES" checked="checked" >]]></xsl:text>
    		   </xsl:when>
    		   <xsl:otherwise>
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_NAVEGARPROVEEDORES">]]></xsl:text>
    		   </xsl:otherwise>
    		</xsl:choose>
		</xsl:when>
    	<xsl:otherwise>
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" disabled="true" name="US_NAVEGARPROVEEDORES">]]></xsl:text>
    	</xsl:otherwise>
	</xsl:choose>
	<xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<!--	20jul09	ET	Navegar proveedores		-->
<xsl:template match="US_VERCARPETAS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_VERCARPETAS" checked="S" >]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_VERCARPETAS">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_CREARLICITACIONES">
    		<xsl:choose>
    		   <xsl:when test=". ='S' ">
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_CREARLICITACIONES" id="US_CREARLICITACIONES" checked="checked" >]]></xsl:text>
    		   </xsl:when>
    		   <xsl:otherwise>
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_CREARLICITACIONES" id="US_CREARLICITACIONES">]]></xsl:text>
    		   </xsl:otherwise>
    		</xsl:choose>
	<xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_VERLICITACIONES">
    		<xsl:choose>
    		   <xsl:when test=". ='S' ">
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_VERLICITACIONES" id="US_VERLICITACIONES" checked="checked" onClick="checkLicitaciones();">]]></xsl:text>
    		   </xsl:when>
    		   <xsl:otherwise>
			  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_VERLICITACIONES" id="US_VERLICITACIONES" onClick="checkLicitaciones();">]]></xsl:text>
    		   </xsl:otherwise>
    		</xsl:choose>
	<xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>



<xsl:template match="US_DELEGADOURGENCIAS">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_DELEGADOURGENCIAS" checked="S" >]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_DELEGADOURGENCIAS">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_DELEGADOZONA">
  <input type="text" name="US_DELEGADOZONA" maxlength="100" size="50">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="ExtraButtons">
    <!-- Cada button corresponde a un form con campos ocultos /field y un submit /button -->
    <xsl:for-each select="formu">
    <xsl:choose>
    <xsl:when test="@name='dummy'">

      <!-- Colocamos form chorra porque el javascript tiene problemas con el primer formulario
           anidado -->
      <form method="post">
        <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
        <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
      </form>

    </xsl:when>
    <xsl:otherwise>
    <td valign="bottom" align="center">
      <form method="post">
      <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
      <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
      <xsl:call-template name="boton">
          <xsl:with-param name="path" select="button[@label='Eliminar']"/>
      </xsl:call-template>
      <!-- Ponemos los campos input ocultos -->
      <xsl:for-each select="field">
        <input>
        <!-- Anyade las opciones comunes al campo input -->
          <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
          <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
         <!-- Ponemos como nombre del field el identificador ID -->
         <xsl:choose>
           <xsl:when test="EMP_ID">
             <xsl:attribute name="value"><xsl:value-of select="EMP_ID"/></xsl:attribute>
           </xsl:when>
           <xsl:when test="ID_USUARIO">
             <xsl:attribute name="value"><xsl:value-of select="ID_USUARIO"/></xsl:attribute>
           </xsl:when>
         </xsl:choose>
         </input>
      </xsl:for-each>
      <!-- Anyadimos el boton de submit -->
      <!--<xsl:apply-templates select="button"/>-->
    </form>
    </td>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
