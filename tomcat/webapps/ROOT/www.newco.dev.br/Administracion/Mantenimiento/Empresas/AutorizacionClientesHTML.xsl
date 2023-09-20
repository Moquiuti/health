<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html>
      <head> 
       <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/AutorizacionClientes/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      <title>   
         <xsl:value-of select="document($doc)/translation/texts/item[@name='autorizar_clientes_mant_empresas']/node()"/>
      </title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>    
     
	<xsl:text disable-output-escaping="yes"><![CDATA[

        <script type="text/javascript">
        <!--
        	function EnviarClientesAutorizados(){
            var lun = document.forms['form1'].length;
			var form = document.forms['form1'];
            var listaAutorizados= '';
            
            for(var i=0;i<lun;i++){
            	var k = form.elements[i].name;
            	if (k.substr(0,8)=='CLIENTE_'){
                 if (form.elements[i].checked == true){
                 	listaAutorizados += form.elements[i].value+'|S#';
                 }
                 else{
                 	listaAutorizados += form.elements[i].value+'|N#';
                 }
                }
            }
            //alert('lista '+listaAutorizados);
            //alert(form.elements['IDPROVEEDOR'].value);
            form.elements['AUTORIZACIONES'].value = listaAutorizados;
            SubmitForm(form);
		}//fin EnviarClientesAutorizados
        
        
         function selTodosClientes(){
            
                var form = document.forms['form1'];
                var Estado=null;
                
                for (var i=0;(i<form.length)&&(Estado==null);i++)
                {
                    var k=form.elements[i].name;
            
                    if (k.substr(0,8)=='CLIENTE_')
                    {
                        if (form.elements[i].checked == true )
                            Estado=false;
                        else
                            Estado=true;
                    }
                }		
                    
                for (var i=0;i<form.length;i++)
                {
                    var k=form.elements[i].name;
            
                    if (k.substr(0,8)=='CLIENTE_')
                    {
                        form.elements[i].checked = Estado;
                        //alert(form.elements[i].name+' vrvr '+form.elements[i].value);
                    }
                }
            }//fin seltodosClientes
        	
             function CambiarClientes()
			 {
                var form = document.forms['form1'];
                //alert(form.elements['IDPROVEEDOR'].value);
                SubmitForm(form);
         	 }//fin de cambiarclientes
        
        //-->        
        </script>
        ]]></xsl:text> 
    
      </head>
  
      <body class="gris">
     	 <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/AutorizacionClientes/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
        <h1 class="titlePage" id="OneProdManten">     
        	 <xsl:value-of select="document($doc)/translation/texts/item[@name='autorizar_clientes']/node()"/>
        </h1>	
        
        <div class="divLeft">         
            <form name="form1" method="post">
            <input type="hidden" name="AUTORIZACIONES"/>
    
  
    <xsl:if test="not(//AUTORIZACIONCLIENTES/MVM) and not(//AUTORIZACIONCLIENTES/NONAVEGAR)"> 
    
    <div class="divLeft" style="margin:15px 0px;">
            <div class="divLeft10">&nbsp;</div>
            <div class="divLeft80 importante">
            <xsl:copy-of select="document($doc)/translation/texts/item[@name='autorizar_clientes_text1']/node()"/>
        <br />
        	<xsl:copy-of select="document($doc)/translation/texts/item[@name='autorizar_clientes_text2']/node()"/>
            </div>
    </div><!--fin de divLeft-->
    </xsl:if>
    
    <div class="divLeft">
  	<table class="infoTable" border="0">
	
     	<xsl:choose>
        	<xsl:when test="//AUTORIZACIONCLIENTES/MVM">
            
            	  <xsl:if test="//AUTORIZACIONCLIENTES/NONAVEGAR"> 
                  <tr> 
                    <td colspan="2" align="center">
                    <br  /><br  />
                                    <strong>
                                    <p><xsl:value-of select="document($doc)/translation/texts/item[@name='este_proveedor_no_esta_autorizado']/node()"/>.</p>
                                    </strong>
                  	</td>
                    </tr>
                  </xsl:if>
                <tr>
				<td class="cuarenta labelRight">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>: <span class="camposObligatorios">*</span>
                </td>  
                <td class="datosLeft">
                    <xsl:call-template name="desplegable">
                        <xsl:with-param name="nombre">IDPROVEEDOR</xsl:with-param>
                        <xsl:with-param name="path" select="//AUTORIZACIONCLIENTES/PROVEEDORES/field"></xsl:with-param>
                        <xsl:with-param name="defecto" select="//AUTORIZACIONCLIENTES/PROVEEDORES/field/@current"></xsl:with-param>
                        <xsl:with-param name="id" select="//AUTORIZACIONCLIENTES/PROVEEDORES/field/@current"></xsl:with-param>
                        <xsl:with-param name="onChange">CambiarClientes();</xsl:with-param>
                    </xsl:call-template>
                    <!--<select name="IDPROVEEDOR" id="IDPROVEEDOR">
                        <xsl:attribute name="onchange">CambiarClientes();</xsl:attribute>

                        <xsl:for-each select="//AUTORIZACIONCLIENTES/PROVEEDORES/field/dropDownList/listElem">
                            <xsl:if test="ID != '' ">
                                 <option value="{ID}">
                                     <xsl:if test="ID = ../../@current"><xsl:attribute name="select">selected</xsl:attribute></xsl:if>
                                        <xsl:value-of select="listItem" />
                                  </option>
                            </xsl:if>
                        </xsl:for-each>
                    </select>-->
                </td>
                </tr>
            </xsl:when>
            <!--si es proveedor-->
            <xsl:otherwise>	
             <xsl:if test="//AUTORIZACIONCLIENTES/NONAVEGAR">
    			  <tr> 
                    <td colspan="2" align="center">
                   		<br  /><br  />
                        <strong>
                        <p><xsl:value-of select="document($doc)/translation/texts/item[@name='ningun_cliente_puede_consultar']/node()"/>.</p><br />
                        <p><xsl:value-of select="document($doc)/translation/texts/item[@name='por_favor_contacto_para_autorizar']/node()"/>
                        </p>
                        </strong>
                  
                	</td>
                  </tr>
    		</xsl:if>
            	<tr><td colspan="2"><input type="hidden" name="IDPROVEEDOR" value="{//AUTORIZACIONCLIENTES/IDPROVEEDOR}"/></td></tr>
            </xsl:otherwise>
            </xsl:choose>
           
      			
      <xsl:if test="//AUTORIZACIONCLIENTES/CLIENTES/CLIENTE">
          <tr>
              <td class="cuarenta labelRight" >&nbsp;</td>
              <td class="datosLeft"><strong><a href="javascript:selTodosClientes();"><xsl:value-of select="document($doc)/translation/texts/item[@name='sel_todos']/node()"/></a></strong></td>
      
          </tr>
           <tr>
              <td colspan="2">&nbsp;</td>
      
          </tr>
      </xsl:if>
     </table>
     
     </div>
     <br /><br />
     
     <div class="divLeft">
     <div class="divLeft20">&nbsp;</div>
     <div class="divLeft80">
     	
    <div class="autorizarClientes">
       <div class="autorizarClientesBox">
     		<xsl:for-each select="//AUTORIZACIONCLIENTES/CLIENTES/CLIENTE">
            	<xsl:if test="@NUMERO &gt; 0 and @NUMERO &lt;= 15">
                 
                    <p class="oneAutorizar"> 
                    <input type="checkbox" name="CLIENTE_{ID}" value="{ID}" >
                        <xsl:if test="AUTORIZADO = 'S'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                    </input>
                    &nbsp;
                    <xsl:choose>
                    <xsl:when test="ENLACE != '' and ENLACE != 'http://'">
                        <a>
                          <xsl:attribute name="href">javascript:MostrarPagPersonalizada('<xsl:value-of select="ENLACE"/>','DetalleEmpresa',65,58,0,-50)</xsl:attribute>  
                          <xsl:value-of select="NOMBRE"/></a>
                         
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="NOMBRE"/>
                    </xsl:otherwise>
                    </xsl:choose>
                    <!--numero de centros-->
                     	<xsl:if test="CENTROS &gt; 1">
                          	(<xsl:value-of select="CENTROS"/>)
                        </xsl:if>
                    </p>
                
                </xsl:if>
            </xsl:for-each> 
         </div><!--fin de autorizarClientesBox-->
          <div class="autorizarClientesBox">
     		<xsl:for-each select="//AUTORIZACIONCLIENTES/CLIENTES/CLIENTE">
            	<xsl:if test="@NUMERO &gt; 15 and @NUMERO &lt;= 30">
                 
                    <p class="oneAutorizar"> 
                    <input type="checkbox" name="CLIENTE_{ID}" value="{ID}" >
                        <xsl:if test="AUTORIZADO = 'S'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                    </input>
                    &nbsp;
                    <xsl:choose>
                    <xsl:when test="ENLACE != '' and ENLACE != 'http://'">
                        <a>
                          <xsl:attribute name="href">javascript:MostrarPagPersonalizada('<xsl:value-of select="ENLACE"/>','DetalleEmpresa',65,58,0,-50)</xsl:attribute>  
                          <xsl:value-of select="NOMBRE"/></a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="NOMBRE"/>
                    </xsl:otherwise>
                    </xsl:choose>
                     <!--numero de centros-->
                     	<xsl:if test="CENTROS &gt; 1">
                          	(<xsl:value-of select="CENTROS"/>)
                        </xsl:if>
                    </p>
                
                </xsl:if>
            </xsl:for-each> 
         </div><!--fin de autorizarClientesBox-->
          <div class="autorizarClientesBox">
     		<xsl:for-each select="//AUTORIZACIONCLIENTES/CLIENTES/CLIENTE">
            	<xsl:if test="@NUMERO &gt; 30 and @NUMERO &lt;= 45">
                 
                    <p class="oneAutorizar"> 
                    <input type="checkbox" name="CLIENTE_{ID}" value="{ID}" >
                        <xsl:if test="AUTORIZADO = 'S'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                    </input>
                    &nbsp;
                    <xsl:choose>
                    <xsl:when test="ENLACE != '' and ENLACE != 'http://'">
                        <a>
                          <xsl:attribute name="href">javascript:MostrarPagPersonalizada('<xsl:value-of select="ENLACE"/>','DetalleEmpresa',65,58,0,-50)</xsl:attribute>  
                          <xsl:value-of select="NOMBRE"/></a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="NOMBRE"/>
                    </xsl:otherwise>
                    </xsl:choose>
                     <!--numero de centros-->
                     	<xsl:if test="CENTROS &gt; 1">
                          	(<xsl:value-of select="CENTROS"/>)
                        </xsl:if>
                    </p>
                
                </xsl:if>
            </xsl:for-each> 
         </div><!--fin de autorizarClientesBox-->
           <div class="autorizarClientesBox">
     		<xsl:for-each select="//AUTORIZACIONCLIENTES/CLIENTES/CLIENTE">
            	<xsl:if test="@NUMERO &gt; 45">
                 
                    <p class="oneAutorizar"> 
                    <input type="checkbox" name="CLIENTE_{ID}" value="{ID}" >
                        <xsl:if test="AUTORIZADO = 'S'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                    </input>
                    &nbsp;
                    <xsl:choose>
                    <xsl:when test="ENLACE != '' and ENLACE != 'http://'">
                        <a>
                          <xsl:attribute name="href">javascript:MostrarPagPersonalizada('<xsl:value-of select="ENLACE"/>','DetalleEmpresa',65,58,0,-50)</xsl:attribute>  
                          <xsl:value-of select="NOMBRE"/></a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="NOMBRE"/>
                    </xsl:otherwise>
                    </xsl:choose>
                     <!--numero de centros-->
                     	<xsl:if test="CENTROS &gt; 1">
                          	(<xsl:value-of select="CENTROS"/>)
                        </xsl:if>
                    </p>
                
                </xsl:if>
            </xsl:for-each> 
         </div><!--fin de autorizarClientesBox-->
     </div><!--fin de autorizarClientes-->
     
     </div><!--fin de divLeft70-->
     </div><!--fin de divLeft-->
     
      <xsl:if test="not(//AUTORIZACIONCLIENTES/NONAVEGAR) and (//AUTORIZACIONCLIENTES/IDPROVEEDOR > 0)">
         <div class="divLeft">
         <br /><br />
         <div class="divLeft30">&nbsp;</div>
         <div class="boton">
         	<a href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
         </div>
         <div class="divLeft10">&nbsp;</div>
         <div class="boton">
            <a href="javascript:EnviarClientesAutorizados();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
         </div>
         <br /><br />
         </div><!--fin divLeft-->
     </xsl:if>
     
     <xsl:if test="//AUTORIZACIONCLIENTES/CLIENTES/CLIENTE">
     
     <div class="divLeft">
     <div class="divLeft20">&nbsp;</div>
  	 <div class="divLeft60nopa"><br /><br /><br /><br /><p class="font11"><xsl:copy-of select="document($doc)/translation/texts/item[@name='no_estan_incluidas_clinicas_asisa']/node()"/></p> <br /><br />
     </div>
     </div><!--fin de divLeft-->
     </xsl:if>
     
    </form>                
    </div>    
	
    
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>


