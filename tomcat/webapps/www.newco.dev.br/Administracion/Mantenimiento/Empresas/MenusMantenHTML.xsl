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
      	  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

        <title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_menus']/node()"/></title>
         <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
        
	<xsl:text disable-output-escaping="yes"><![CDATA[

        <SCRIPT type="text/javascript">
        <!-- 
        
        var msgMaximoBotones='Ha seleccionado un número de botones superior al permitido para mostrar en su menú principal. El máximo es 8';
        var msgMinimoBotones='No ha seleccionado ningún botón para el menú principal. Debe seleccionar al menos uno.';
        
        
        
        var arrayPerfiles=new Array();
        
       
       function deshabilitaCabecera(obj){
         var id;
         if(obj.checked==false){
           id=obtenerId(obj.name);
           document.forms[0].elements['CABECERA_'+id].checked=false;
         }
       }
       
       
       function comprobarMaximoBotonesCabecera(min,max,obj){
          
          var cuantos=0;
          form=document.forms[0];

          var id;
          
          
          
          if(arguments.length>2){
            id=obtenerId(obj.name);
            if(form.elements['MENU_'+id].checked==false)
              obj.checked=false;
          }
          
          for(var n=0;n<form.length;n++){
            if(form.elements[n].name.substring(0,9)=='CABECERA_' && form.elements[n].checked==true){
              cuantos++;
            }
          }
          if(cuantos<=min){
            if(arguments.length<3){
              alert(msgMinimoBotones);
              return false;
            }
          }
          else{
            if(cuantos>max){
              alert(msgMaximoBotones);
              if(arguments.length>2)
                obj.checked=false;
              return false;
            }
            else{
              return true;
            }
          }    
        }
       
       
       
        ]]></xsl:text>
          <xsl:for-each select="/Mantenimiento/MENUS/PERFILES_MENUS/PERFIL">
            var cadenaMenus='';
            <xsl:for-each select="MENU">
              cadenaMenus+='<xsl:value-of select="ID"/>'+'|'+'<xsl:value-of select="ACCESIBLE"/>'+'|'+'<xsl:value-of select="CABECERA"/>'+'#';
            </xsl:for-each>
            arrayPerfiles[arrayPerfiles.length]=new Array('<xsl:value-of select="./@id"/>',cadenaMenus);
          </xsl:for-each>
        <xsl:text disable-output-escaping="yes"><![CDATA[
        
        
        
    function CargarPerfilMenus(idPerfil)
	{

      var cadenaMenus;

      //  recorrer el arrayPerfiles : array(identificador,array(idPerfil,cadenaMenus{idmenu|accesibilidad|cabecera#...}))
      for(var n=0;n<arrayPerfiles.length;n++)
        if(arrayPerfiles[n][0]==parseInt(idPerfil))
          cadenaMenus=arrayPerfiles[n][1];
      cadenaMenus=cadenaMenus.substring(0,cadenaMenus.length-1);   

      //  transformar la cadena en un array('idmenu|accesibilidad'....)
      //  y para cada elemento lo extraigo y lo convierto es un array(idmenu,accesibilidad)
      //  que es con el que voy a trabajar
      var arrayMenus=cadenaMenus.split('#');

      for(var n=0;n<arrayMenus.length;n++){
        var cadenaMenu=arrayMenus[n];
        var arrayMenu=cadenaMenu.split('|');
        if(document.forms[0].elements['MENU_'+arrayMenu[0]])
          if(arrayMenu[1]=='S')
            document.forms[0].elements['MENU_'+arrayMenu[0]].checked=true;
          else
            document.forms[0].elements['MENU_'+arrayMenu[0]].checked=false;

        if(document.forms[0].elements['CABECERA_'+arrayMenu[0]])
          if(arrayMenu[2]=='S')
            document.forms[0].elements['CABECERA_'+arrayMenu[0]].checked=true;
          else
            document.forms[0].elements['CABECERA_'+arrayMenu[0]].checked=false;    

      }
    }
        

        
    function ValidaySubmit(formu, accion)
	{
      var id;
      var cadenaCambios='';
      var visualizable;
      var pertenece;
      var cabecera;
		
		formu.elements['ACCION'].value=accion;
		
      if(validarFormulario(formu))
	  {

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

        SubmitForm(formu);
      }
    }
        
        
	function validarFormulario(form)
	{
      var errores=0;

      if((!errores)&& (!comprobarMenusPorUsuario(document.forms[0]))){
        alert('Por favor, rogamos seleccione los menús a los que tendrá acceso este usuario antes de enviar el formulario.'); 
        document.location.href='#menus';
        return false;
      }

      if((!errores)&& (!comprobarMaximoBotonesCabecera(0,8))){
        document.location.href='#menus';
        return false;
      }


          if(!errores)
            return true;
          else  
            return false;

    }

    function comprobarMenusPorUsuario(form){
      var algunoInformado=0;
      for(var n=0;n<form.length;n++){
        if(form.elements[n].name.substring(0,5)=='MENU_'){
          if(form.elements[n].checked==true){
        	algunoInformado++;
          }
        }
      }
      return algunoInformado;
    }


        //-->
        </SCRIPT>        
        ]]></xsl:text>	
      </head>

      <body>
	<!-- Formulario de datos -->	        
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
        <xsl:otherwise> 
            <xsl:apply-templates select="/Mantenimiento/MENUS"/>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
 
<!--
 |  Templates
 +-->
<xsl:template match="MENUS">
   <form method="post" action="MenusMantenSave.xsql">
    <!--<xsl:apply-templates select="/Mantenimiento/MENUS/ID_USUARIO"/>-->
    <!--<xsl:apply-templates select="/Mantenimiento/MENUS/EMP_ID"/>-->
	<input type="hidden" name="LANG" value="{/Mantenimiento/LANG}"/>
	<input type="hidden" name="ID_USUARIO" value="{/Mantenimiento/MENUS/ID_USUARIO}"/>
	<input type="hidden" name="EMP_ID" value="{/Mantenimiento/MENUS/EMP_ID}"/>
	<input type="hidden" name="CAMBIOS_MENUS"/>
 	<input type="hidden" name="ACCION" value=""/>
    
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
    	<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
    	<xsl:otherwise>spanish</xsl:otherwise>
    	</xsl:choose>  
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_menus']/node()"/></span>
		<span class="CompletarTitulo" style="width:300px;">
			<xsl:if test="/Mantenimiento/MENUS/RESULTADO">
				<xsl:value-of select="/Mantenimiento/MENUS/RESULTADO" /> 
			</xsl:if>  	           
		</span>
		</p>
		<p class="TituloPagina">
    		<xsl:value-of select="/Mantenimiento/MENUS/USUARIO"/>
			<!--&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_menus']/node()"/>
			<xsl:if test="/Mantenimiento/MENUS/RESULTADO">
			&nbsp;:&nbsp; <xsl:value-of select="/Mantenimiento/MENUS/RESULTADO" />  
			</xsl:if>  	-->           
			<span class="CompletarTitulo" style="width:300px;">
        		<a class="btnNormal" href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>&nbsp;
        		<a class="btnDestacado" href="javascript:ValidaySubmit(document.forms[0], 'MENUSUSUARIO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>


	<!--
	<h1 class="titlePage">
	<xsl:value-of select="/Mantenimiento/MENUS/USUARIO"/>&nbsp;-&nbsp;
	<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_menus']/node()"/>
	<xsl:if test="/Mantenimiento/MENUS/RESULTADO">
		&nbsp;:&nbsp; <xsl:value-of select="/Mantenimiento/MENUS/RESULTADO" />  
	</xsl:if>  	           
	</h1>	
	-->        

	<!--<table class="infoTable">				-->
	<table class="buscador">				
    <tr class="sinLinea">
    	<td colspan="6" style="text-align:center;">
    		<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='perfiles_predefinidos_puede']/node()"/>.</strong>
          </td>
        </tr> 
              <tr class="sinLinea">
              <td class="veinte">&nbsp;</td>
                <xsl:for-each select="PERFILES_MENUS/PERFIL">
                    <xsl:if test="@nombre != 'Administrador Vendedor'"><!--provee no puede ser admin quitado 26-8-14-->
                        <td class="diez">
						<!--
                        <div class="boton">
                          <xsl:call-template name="botonPersonalizado">
                          <xsl:with-param name="path" select="."/>
                          <xsl:with-param name="label"><xsl:choose><xsl:when test="contains(./@nombre,'Administrador')">Administrador</xsl:when><xsl:otherwise><xsl:value-of select="./@nombre"/></xsl:otherwise></xsl:choose></xsl:with-param>
                          <xsl:with-param name="funcion">CargarPerfilMenus(<xsl:value-of select="./@id"/>);</xsl:with-param>
                          <xsl:with-param name="status">Asignar perfil</xsl:with-param>
                        </xsl:call-template>
                        </div> 
						-->
						<a class="btnNormal" href="javascript:CargarPerfilMenus({./@id});">
							<xsl:choose><xsl:when test="contains(./@nombre,'Administrador')">Administrador</xsl:when><xsl:otherwise><xsl:value-of select="./@nombre"/></xsl:otherwise></xsl:choose>
						</a>
                      </td>   
                    </xsl:if>  
              </xsl:for-each>
              <td class="veinte">&nbsp;</td>
           </tr>
        
     </table>
     <br/>
     
    <!--<table class="grandeInicio">-->
    <table class="buscador">
      <xsl:for-each select="TIPO">
        <xsl:if test="./MENU">
        <tr class="subTituloTabla">
        <th colspan="4">
          <xsl:value-of select="@nombre"/>
        </th>
        </tr>
            <tr>
              <td class="trenta">
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>
              </td>
              <td>
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>
              </td>
              <td class="dies">
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='autorizado']/node()"/>
              </td>
              <td class="dies">
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='menu_principal']/node()"/>
              </td>
            </tr>
          <xsl:for-each select="./MENU">
            <tr class="sinLinea">
              <td class="textLeft">
                &nbsp;&nbsp;<xsl:value-of select="NOMBRE"/>
              </td>
              <td class="textLeft">
                &nbsp;&nbsp;<xsl:value-of select="DESCRIPCION"/>
              </td>
              <td>
                <xsl:choose>
                  <xsl:when test="AUTORIZADO='S'">  
                    <input type="checkbox" name="MENU_{ID}" checked="checked" onClick="deshabilitaCabecera(this);"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <input type="checkbox" name="MENU_{ID}" unchecked="unchecked" onClick="deshabilitaCabecera(this);"/> 
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td>
                <xsl:choose>
                  <xsl:when test="CABECERA='S'">  
                    <input type="checkbox" name="CABECERA_{ID}" checked="checked" onclick="comprobarMaximoBotonesCabecera(0,8,this);"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <input type="checkbox" name="CABECERA_{ID}" unchecked="unchecked" onclick="comprobarMaximoBotonesCabecera(0,8,this);"/> 
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              </tr>
          </xsl:for-each>
        </xsl:if>
      </xsl:for-each>
    </table>
   <!--  
   <br /><br />
   
   <div class="divLeft">
    <div class="divLeft30">&nbsp;</div>
    <div class="divLeft20">
        <div class="boton">
        	<a href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>
        </div>
     </div>
     <div class="divLeft10">&nbsp;</div>
     <div class="divLeft20">
     	 <div class="boton">
        	<a href="javascript:ValidaySubmit(document.forms[0], 'MENUSUSUARIO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
        </div>
     </div>
     </div>
   <br /><br />
    <br /><br />
	-->
    <br /><br />
   <div class="divLeft">
   <!--<table class="mediaTabla">-->
   <table class="buscador">
   <tr class="sinLinea">
	<td class="quince">
    	&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfiles_por_defecto']/node()"/>:</strong>
    </td>
    <xsl:choose>
        <xsl:when test="PERFILES_MENUS/PERFIL[1]/@nombre = 'Administrador Comprador'">
            
            <td class="veinte">
				<!--<div class="botonLargo">-->
    			<a class="btnNormal" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|1');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_administrador']/node()"/></a>
				<!--</div>-->
            </td> 
            <td class="uno">&nbsp;</td>
            <td class="veinte">
                <!--<div class="botonLargo">-->
                <a class="btnNormal" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|4');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_comprador']/node()"/></a>
                <!--</div>-->
            </td>
            <td class="uno">&nbsp;</td>
            <td class="veinte">
                <!--<div class="botonLargo">-->
                <a class="btnNormal" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|5');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_usuario_cdc']/node()"/></a>
                <!--</div>-->
            </td>
            <td class="uno">&nbsp;</td>
            <td class="veinte">
                <!--<div class="botonLargo">-->
                <a class="btnNormal" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|6');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_comercial']/node()"/></a>
               <!-- </div>-->
            </td>
           
        </xsl:when>
        <xsl:when test="PERFILES_MENUS/PERFIL[1]/@nombre = 'Administrador Vendedor'">
            <!--<td class="veinte">
			<div class="botonLargo">
    			<a href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|2');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_administrador']/node()"/></a>
			</div>
            </td>-->
            <td class="uno">&nbsp;</td>
            <td class="veinte">
                <!--<div class="botonLargo">-->
                <a class="btnNormal" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|3');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_comercial']/node()"/></a>
                <!--</div>-->
            </td>
            
        </xsl:when>
    </xsl:choose>
    <td>&nbsp;</td>
	
   </tr>
 </table><!--fin de mediaTabla-->
 <br /><br />
</div><!--fin de divLeft-->
</form>	      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>
  
<!--
<xsl:template match="ID_USUARIO">
  <input type="hidden" name="ID_USUARIO">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template> 


<xsl:template match="EMP_ID">
  <input type="hidden" name="EMP_ID">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>
-->

</xsl:stylesheet>
