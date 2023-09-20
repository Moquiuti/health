<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |   Mantenimiento de Usuarios  
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html> 
      <head> 
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">       
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        <SCRIPT type="text/javascript">
        <!-- 
        function updateOpener() { 
        //  parent.opener.location.href = parent.opener.location.href; 
        }
        function ValidaySubmit(formu){
          //if (Integer(formu.elements['US_PEDIDOMAXIMO'])==true && Integer(formu.elements['US_COMPRAMENSUALMAXIMA'])==true && Integer(formu.elements['US_COMPRAANUALMAXIMA'])==true){
          if(validarFormulario(formu)){
            SubmitForm(formu);
          }
        }
        
        
        function validarFormulario(form){
        	  var errores=0;
        	  
        	  if((!errores) && (document.forms[0].elements['US_TITULO'].value==-1)){
        	    errores=1;
        	    alert('Por favor, rogamos seleccione el campo \"Título\" antes de enviar el formulario.');
        	    form.elements['US_TITULO'].focus();
        	    return false;
        	  }
        	  
        	  if((!errores) && (esNulo(document.forms[0].elements['US_NOMBRE'].value))){
        	    errores=1;
        	    alert('Por favor, rogamos rellene el campo \"Nombre\" antes de enviar el formulario.');
        	    form.elements['US_NOMBRE'].focus();
        	    return false;
        	  }
        	  
                  if((!errores) && (esNulo(document.forms[0].elements['US_APELLIDO1'].value))){
        	    errores=1;
        	    alert('Por favor, rogamos rellene el campo \"1º Apellido\" antes de enviar el formulario.');
        	    form.elements['US_APELLIDO1'].focus();
        	    return false;
        	  }
        	  
        	  /*if((!errores) && (esNulo(document.forms[0].elements['US_APELLIDO2'].value))){
        	    errores=1;
        	    alert('Por favor, rogamos rellene el campo \"2º Apellido\" antes de enviar el formulario.');
        	    form.elements['US_APELLIDO2'].focus();
        	    return false;
        	  }*/
        	  
        	  if((!errores) && (!checkNumber(document.forms[0].elements['US_TF_FIJO'].value, document.forms[0].elements['US_TF_FIJO']))){
        	    errores=1;
        	    form.elements['US_TF_FIJO'].focus();
        	    return false;
        	  }
        	  else{
        	    if((!errores) && (esNulo(document.forms[0].elements['US_TF_FIJO'].value))){
        	    errores=1;
        	    alert('Por favor, rogamos rellene el campo \"Teléfono\" antes de enviar el formulario.');
        	    form.elements['US_TF_FIJO'].focus();
        	    return false;
        	  }
        	  }
        	  
        	  ]]></xsl:text>
        	    <xsl:if test="Mantenimiento/form/Lista/Registro/ID_USUARIO='0'">
        	      if((!errores) <xsl:text disable-output-escaping="yes"><![CDATA[ &&  ]]></xsl:text> (esNulo(document.forms[0].elements['US_USUARIO'].value)|| esNulo(document.forms[0].elements['US_USUARIO'].value))){
        	        errores=1;
        	        alert('Por favor, rogamos rellene el campo \"Login\" antes de enviar el formulario.');
        	        form.elements['US_USUARIO'].focus();
        	        return false;
        	      }
        	    </xsl:if>
        	  <xsl:text disable-output-escaping="yes"><![CDATA[	
        	  
        	  if((!errores) && (document.forms[0].elements['US_CLAVE'].value!=document.forms[0].elements['US_CLAVE_REP'].value  ]]></xsl:text><xsl:if test="Mantenimiento/form/Lista/Registro/ID_USUARIO='0'"><xsl:text disable-output-escaping="yes"><![CDATA[ || document.forms[0].elements['US_CLAVE'].value=='' || document.forms[0].elements['US_CLAVE_REP'].value=='']]></xsl:text></xsl:if><xsl:text disable-output-escaping="yes"><![CDATA[)){
        	    errores=1;
        	    alert('Por favor, rogamos rellene los campos \"Password\" con el mismo valor antes de enviar el formulario.');
        	    form.elements['US_CLAVE'].value='';
        	    form.elements['US_CLAVE_REP'].value='';
        	    form.elements['US_CLAVE'].focus();
        	    return false;
        	  }
        	  
        	  if((!errores) && (!checkNumber(document.forms[0].elements['US_PEDIDOMAXIMO'].value, document.forms[0].elements['US_PEDIDOMAXIMO']))){
        	    errores=1;
        	    //alert('Por favor, rogamos rellene el campo \"Pedido máximo\" con un valor númerico antes de enviar el formulario.');
        	    form.elements['US_PEDIDOMAXIMO'].focus();
        	    return false;
        	  }
        	  
        	  if((!errores) && (!checkNumber(document.forms[0].elements['US_COMPRAMENSUALMAXIMA'].value, document.forms[0].elements['US_COMPRAMENSUALMAXIMA']))){
        	    errores=1;
        	    //alert('Por favor, rogamos rellene el campo \"Compra mensual máxima\" con un valor númerico antes de enviar el formulario.');
        	    form.elements['US_COMPRAMENSUALMAXIMA'].focus();
        	    return false;
        	  }
        	  
        	  if((!errores) && (!checkNumber(document.forms[0].elements['US_COMPRAANUALMAXIMA'].value, document.forms[0].elements['US_COMPRAANUALMAXIMA']))){
        	    errores=1;
        	    //alert('Por favor, rogamos rellene el campo \"Compra anual máxima\" con un valor númerico antes de enviar el formulario.');
        	    form.elements['US_COMPRAANUALMAXIMA'].focus();
        	    return false;
        	  }     

                  if(!errores)
                    return true;
                  else  
                    return false;
        	  
        	}
        	
        	
        	function privilegiosUsuario(){
        	  var esAdministrador;
        	  if(document.forms[0].elements['US_USUARIOGERENTE'].checked==true || document.forms[0].elements['US_GERENTECENTRO'].checked==true)
        	    esAdministrador=1;
        	    
        	  if(esAdministrador){
        	    document.forms[0].elements['US_PLANTILLASNORMALES'].checked=true;
        	    document.forms[0].elements['US_PLANTILLASURGENCIAS'].checked=true;
        	  }
        	}
        	
        	function privilegiosCarpetas(obj){
        	  var esAdministrador;
        	  if(document.forms[0].elements['US_USUARIOGERENTE'].checked==true || document.forms[0].elements['US_GERENTECENTRO'].checked==true)
        	    esAdministrador=1;
        	    
        	  if(esAdministrador){
        	    obj.checked=!obj.checked;       	    
        	  }
        	}
        	
        	function MostrarDatos(){
        	  MostrarPagPassord('USDatos.xsql?ID_USUARIO=]]></xsl:text><xsl:value-of select="/Mantenimiento/form/Lista/Registro/ID_USUARIO"/><xsl:text disable-output-escaping="yes"><![CDATA[','Password');
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
        	
        	
        	
        
        
        
        //-->
        </SCRIPT>        
        ]]></xsl:text>	
      </head>

      <body bgcolor="#FFFFFF" onLoad="privilegiosUsuario();">
	<!-- Formulario de datos -->	                           
        <xsl:apply-templates select="Mantenimiento/form"/>
      </body>
    </html>
  </xsl:template>
 
<!--
 |  Templates
 +-->
<xsl:template match="form">
  <form method="post">
    <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
    <xsl:apply-templates select="Lista/Registro"/>
  </form>
</xsl:template>

<xsl:template match="Registro">
  <xsl:apply-templates select="ID_USUARIO"/>   
  <input type="hidden" name="US_OPERADOR" value="-1"/>
  <xsl:apply-templates select="US_AVISOS_EMAIL"/>
  <xsl:apply-templates select="US_AVISOS_MOVIL"/>
  <input type="hidden" name="US_IDIDIOMA" value="0"/>
  <xsl:apply-templates select="US_PEDIDOMAXIMO"/>
  <xsl:apply-templates select="US_COMPRAMENSUALMAXIMA"/>
  <xsl:apply-templates select="US_COMPRAANUALMAXIMA"/>
  <xsl:apply-templates select="US_LIMITACIONFAMILIAS"/>
  
  
  
  
    <br/>
      <p class="tituloPag" align="center">	        	           
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0210' and @lang=$lang]" disable-output-escaping="yes"/> 
      </p>	        
    <br/>
    
  <table width="100%" border="0" cellspacing="1" cellpadding="3"  align="center" class="muyoscuro">	
    <tr class="oscuro"> 
      <td colspan="4">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0110' and @lang=$lang]" disable-output-escaping="yes"/>
      </td>
    </tr>
    <tr class="blanco"><td colspan="4">&nbsp;</td></tr>    	
    <tr class="blanco"> 
      <td width="20%" class="claro"  align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0920' and @lang=$lang]" disable-output-escaping="yes"/>:<span class="camposObligatorios" width="1%">*</span>
      </td>
      <td> 
        <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="../../field[@name='US_TITULO']"/>
    	  <xsl:with-param name="IDAct"><xsl:value-of select="US_TITULO"/>|<xsl:value-of select="US_IDSEXO"/></xsl:with-param>
    	</xsl:call-template>
      </td>
      <td class="claro"  align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0440' and @lang=$lang]" disable-output-escaping="yes"/>:<span class="camposObligatorios">*</span>
      </td>
      <td>
        <xsl:apply-templates select="US_NOMBRE"/>
      </td>
    </tr>		    		          	          	    
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0230' and @lang=$lang]" disable-output-escaping="yes"/>:<span class="camposObligatorios">*</span>
      </td>
      <td>
        <xsl:apply-templates select="US_APELLIDO1"/>
      </td> 
      <td class="claro" align="right">
        <!--<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0285' and @lang=$lang]" disable-output-escaping="yes"/>:-->
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0240' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
       <!--<xsl:variable name="IDAct" select="US_IDSEXO"/>
        <xsl:apply-templates select="../../field[@name='US_IDSEXO']"/>-->
        
        <!--<xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="../../field[@name='US_IDSEXO']"/>
    	  <xsl:with-param name="IDAct" select="US_IDSEXO"/>
    	</xsl:call-template>-->
    	<xsl:apply-templates select="US_APELLIDO2"/>
    	<input type="hidden" name="US_IDSEXO" value="{US_IDSEXO}"/>
        </td>
    </tr>
    <tr class="blanco">
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0290' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
        <xsl:apply-templates select="US_EMAIL"/>
        </td>
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0510' and @lang=$lang]" disable-output-escaping="yes"/>:<span class="camposObligatorios">*</span>
      </td>
      <td>
        <xsl:apply-templates select="US_TF_FIJO"/>
        </td>        
    </tr>
    <tr class="blanco">
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0520' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td colspan="3">
        <xsl:apply-templates select="US_TF_MOVIL"/>
        </td>     
      <!--<td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0530' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>-->
        <!--<xsl:variable name="IDAct" select="US_OPERADOR"/>
        <xsl:apply-templates select="../../field[@name='US_OPERADOR']"/>-->
        
        <!--<xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="../../field[@name='US_OPERADOR']"/>
    	  <xsl:with-param name="IDAct" select="US_OPERADOR"/>
    	</xsl:call-template>-->
    	<!--<input type="hidden" name="US_OPERADOR" value="-1"/>-->
        <!--</td> -->      
    </tr>
    <!--<tr class="blanco">
      <td colspan="4">
        &nbsp;
      </td>      
    </tr>-->
    <!--<tr class="blanco">
      <td colspan="2" class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0540' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>                
      <td align="center">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0290' and @lang=$lang]" disable-output-escaping="yes"/>:
        <xsl:apply-templates select="US_AVISOS_EMAIL"/>
      </td>     
      <td align="center">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0520' and @lang=$lang]" disable-output-escaping="yes"/>:
        <xsl:apply-templates select="US_AVISOS_MOVIL"/>
      </td>             
    </tr>-->
    <tr class="blanco"><td colspan="4">&nbsp;</td></tr>
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0250' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td colspan="3">
        <!--<xsl:variable name="IDAct" select="US_IDCENTRO"/>
        <xsl:apply-templates select="../../field[@name='US_IDCENTRO']"/>-->
        
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
      <!--<td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0270' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>-->
        <!--<xsl:variable name="IDAct" select="US_IDIDIOMA"/>
        <xsl:apply-templates select="../../field[@name='US_IDIDIOMA']"/>-->
        
        <!--<xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="../../field[@name='US_IDIDIOMA']"/>
    	  <xsl:with-param name="IDAct" select="US_IDIDIOMA"/>
    	</xsl:call-template>-->
    	<!--<input type="hidden" name="US_IDIDIOMA" value="1"/>
        </td>   -->    
    </tr>			
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0280' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
        <!--<xsl:variable name="IDAct" select="US_IDDEPARTAMENTO"/>
        <xsl:apply-templates select="../../field[@name='US_IDDEPARTAMENTO']"/>-->
        
        <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="../../field[@name='US_IDDEPARTAMENTO']"/>
    	  <xsl:with-param name="IDAct" select="US_IDDEPARTAMENTO"/>
    	</xsl:call-template>
        </td>
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0260' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
        <!--<xsl:variable name="IDAct" select="US_IDTIPO"/>
        <xsl:apply-templates select="../../field[@name='US_IDTIPO']"/>-->
        
        <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="../../field[@name='US_IDTIPO']"/>
    	  <xsl:with-param name="IDAct" select="US_IDTIPO"/>
    	</xsl:call-template>
        </td>
    </tr>    
    <!--<tr class="blanco"> 
      <td class="claro" align="right">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0330' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
        <xsl:apply-templates select="US_PEDIDOMAXIMO"/>
        </td>
      <td class="claro" align="right">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0340' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
        <xsl:apply-templates select="US_COMPRAMENSUALMAXIMA"/>
        </td>
    </tr> 
   <tr class="blanco"> 
      <td class="claro" align="right">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0345' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td colspan="3">
        <xsl:apply-templates select="US_COMPRAANUALMAXIMA"/>
        </td>
    </tr>  -->  
   <tr class="blanco"> 
      <!--<td class="claro" align="right">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0350' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td>
        <xsl:apply-templates select="US_LIMITACIONFAMILIAS"/>
        </td>-->
      <td class="claro" align="right">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0360' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td colspan="3">
        <table width="100%" align="center">
          <tr>
            <td align="center" valign="middle">
              <xsl:apply-templates select="US_USUARIOGERENTE"/>
            </td>
            <td width="95%" align="left" valign="middle">
              Usuario responsable del funcionamiento general del sistema. Puede configurar su empresa (crear centros y usuarios)
y consultar las tareas de otros usuarios de su empresa. Puede crear plantillas para cualquier centro. En el E.I.S. consulta
todos los datos de todos los centros de su empresa.

            </td>
          </tr>
        </table> 
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0364' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td colspan="3">
        <table width="100%" align="center">
          <tr>
            <td>
              <xsl:apply-templates select="US_GERENTECENTRO"/>
            </td>
            <td width="95%" align="left" valign="middle">
              Puede configurar su centro (y crear usuarios) y consultar las tareas de otros usuarios de su centro. En el E.I.S. consulta
todos los datos de su centro, pero no puede acceder a los demás centros.


            </td>
          </tr>
        </table> 
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro" align="right">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0362' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td colspan="3">
        <table width="100%" align="center">
          <tr>
            <td>
              <xsl:apply-templates select="US_CENTRALCOMPRAS"/>
            </td>
            <td width="95%" align="left" valign="middle">
              Para empresas que quieran estructurar una central de compras. Permite crear un catálogo privado con referencias
y nombres de productos propios. También puede crear plantillas para otros centros y usuarios.
            </td>
          </tr>
        </table> 
      </td>
    </tr>
    <tr class="blanco"><td colspan="4">&nbsp;</td></tr>      
    <tr class="blanco">
      <td colspan="2" align="right" class="claro">Puede crear plantillas normales:&nbsp;<xsl:apply-templates select="US_PLANTILLASNORMALES"/></td>
      <td colspan="2" align="left" class="claro">Puede crear plantillas de reserva:&nbsp;<xsl:apply-templates select="US_PLANTILLASURGENCIAS"/></td>
    </tr> 
    <tr class="blanco"><td colspan="4">&nbsp;</td></tr>  
   <tr class="blanco">
     <td align="right" class="claro">
       <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0300' and @lang=$lang]" disable-output-escaping="yes"/>:<span class="camposObligatorios">*</span>
       &nbsp;
     </td>
     <td width="25%" align="left">
       <xsl:apply-templates select="US_USUARIO"/>
     </td>
     <td width="25%" align="right" class="claro">
       <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0310' and @lang=$lang]" disable-output-escaping="yes"/>:<span class="camposObligatorios">**</span>
       &nbsp;
       <br/><br/>
       <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0320' and @lang=$lang]" disable-output-escaping="yes"/>:      
       &nbsp;
     </td>
     <td valign="top" width="25%" align="left">      
       <xsl:apply-templates select="US_CLAVE"/>
     </td>     
   </tr> 
    <tr bgcolor="#FFFFFF"><td colspan="4">&nbsp;</td></tr>
    <tr bgcolor="#FFFFFF" class="claro"><td colspan="4">
      <span class="camposObligatorios">*</span>&nbsp;&nbsp;&nbsp;Campos obligatorios.
      <br/>         
      <span class="camposObligatorios">**</span> Campo obligatorios en la alta del usuario.
    </td></tr>
    <tr bgcolor="#FFFFFF"><td colspan="4">&nbsp;</td></tr>         
    <tr align="center" class="blanco"><td colspan="4">
     <table width="100%" cellspacing="0" cellpadding="0"><tr align="center" height="30px">
      <td valign="bottom" align="center">
        <!--<xsl:apply-templates select="../../../jumpTo"/>-->
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="../../../boton[@label='Cancelar']"/>
        </xsl:call-template>
     </td>      
      <td valign="bottom" align="center">  
        <!--<xsl:apply-templates select="../../button"/>-->
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="../../button[@label='Aceptar']"/>
        </xsl:call-template>
      </td>
      <!--<xsl:if test="ID_USUARIO!='0'">
        <xsl:apply-templates select="../../../ExtraButtons"/>  
      </xsl:if>    -->
    </tr></table></td></tr>	             	
  </table>		      	          	          	          	          	          	          	          	        	      	          	          
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
  <input type="text" name="US_NOMBRE" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>


<xsl:template match="US_APELLIDO1">
  <input type="text" name="US_APELLIDO1" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="US_APELLIDO2">
  <input type="text" name="US_APELLIDO2" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="US_EMAIL">
  <input type="text" name="US_EMAIL" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/> </xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="US_TF_FIJO">
  <input type="text" name="US_TF_FIJO" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="US_TF_MOVIL">
  <input type="text" name="US_TF_MOVIL" maxlength="70">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="US_AVISOS_EMAIL">
  <input type="hidden" name="US_AVISOS_EMAIL">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:attribute name="checked">checked</xsl:attribute>	  
       </xsl:when>
       <xsl:when test=". ='' ">
	  <xsl:attribute name="checked">checked</xsl:attribute>	  
       </xsl:when>
    </xsl:choose>
  </input>
</xsl:template>

<xsl:template match="US_AVISOS_MOVIL">
  <input type="hidden" name="US_AVISOS_MOVIL">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:attribute name="checked">checked</xsl:attribute>	  
       </xsl:when>
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

<xsl:template match="US_USUARIOGERENTE">
    <xsl:choose>
       <xsl:when test=". ='1' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_USUARIOGERENTE" checked onClick="privilegiosUsuario();">]]></xsl:text>
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
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_CENTRALCOMPRAS" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_CENTRALCOMPRAS">]]></xsl:text>       
       </xsl:otherwise>
    </xsl:choose>     
  <xsl:text disable-output-escaping="yes"><![CDATA[</input>]]></xsl:text>
</xsl:template>

<xsl:template match="US_GERENTECENTRO">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_GERENTECENTRO" checked onClick="privilegiosUsuario();">]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="US_GERENTECENTRO" onClick="privilegiosUsuario();">]]></xsl:text>       
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
     <input type="hidden" name="US_USUARIO" size="10" maxlength="30">
       <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
     </input>
     <xsl:value-of select="."/> 
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="US_CLAVE">
  <table align="left" valign="middle" width="100%">
    <tr>
      <td>
        <input type="password" name="US_CLAVE" size="10" maxlength="30"/>
        <br/><br/>
      </td>
      <td>&nbsp;
        
      </td>
    </tr>
    <tr>
      <td>
        <input type="password" name="US_CLAVE_REP" size="10" maxlength="30"/>
      </td>
      <td align="right">
        <xsl:if test="//VER_USUARIO and //ID_USUARIO!=0">
          <xsl:call-template name="boton">
            <xsl:with-param name="path" select="//boton[@label='VerPasswd']"/>
            <xsl:with-param name="ancho" select="50"/>
          </xsl:call-template>
        </xsl:if>
      </td>
    </tr>
  </table>
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