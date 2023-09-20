<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: CYPEditaHTML.xsl
 | Autor.........: Montse
 | Fecha.........:
 | Descripcion...: Gestion de CLientes/Proveedores
 | Funcionamiento: 
 |
 |Modificaciones:
 |   Fecha:22/06/2001      Autor:Olivier Jean         Modificacion: CYP.js
 |
 |
 | OBSERVACIONES:
 |	Los cambios en este fichero deben copiarse en CYPEditaSave, que es la pagina encargada de guardar los
 |	cambios en la base de datos y mostrar el resto de paginas.
 |
 | Situacion: __Normal__
 |
 |(c) 2001 MedicalVM
 |///////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
         <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/Administracion/ClientesYProveedores/CYP.js"></script>
     
	<xsl:text disable-output-escaping="yes"><![CDATA[

         <script type="text/javascript">
        <!--
          
          //Guardamos la ultima pagina en el campo oculto ULTIMAPAG.
	  //Llamamos a la funcion ValidaCampos.
          function Navega(formu,pagina){
            formu.elements['ULTIMAPAGINA'].value=pagina;
	    ConstruirLlista(formu);
	    AsignarAccion(formu,'CYPEditaSave.xsql?NAVEGA=YES');
	    if (ValidaTodosUnSoloNumero()==true) SubmitForm(formu);
	  }
         
          //
          // No queremos seguir navegando, queremos guardar la ultima pagina
          // Contruimos la lista con 
          //
	  function Actua(formu){
	    AsignarAccion(formu,'CYPEditaSave.xsql?NAVEGA=NO');
	    ConstruirLlista(formu);	    	    
	    if (ValidaTodosUnSoloNumero()==true) SubmitForm(formu);
	  }
	  
         //-->
         </script>
        ]]></xsl:text>	
      </head>
      <body>
          <xsl:choose> 
           <xsl:when test="//xsql-error">
           </xsl:when>
           <xsl:when test="//Status">
             <xsl:if test="not(//Status/OK)">
               <xsl:apply-templates select="//Status"/>
             </xsl:if>   
           </xsl:when>                              
           <xsl:when test="Lista/form/ROWSET/ROW/NoDataFound">
             <xsl:apply-templates select="Lista/form/ROWSET/ROW/NoDataFound"/>             
           </xsl:when>
           <xsl:otherwise>
             <xsl:attribute name="onLoad">PrimerTurno();</xsl:attribute>         
            <form>
            <xsl:attribute name="action">
            <xsl:value-of select="Lista/form/@action"/>
            </xsl:attribute>
            <xsl:attribute name="name">
            <xsl:value-of select="Lista/form/@name"/>
            </xsl:attribute>
            <xsl:attribute name="method">
            <xsl:value-of select="Lista/form/@method"/>
            </xsl:attribute>
              <!-- 
               |  Almacenamos los Campos hidden de la consulta .
               |
               +-->              
               <xsl:apply-templates select="Lista/form/EMP_NIF"/>
               <xsl:apply-templates select="Lista/form/EMP_NOMBRE"/>
               <xsl:apply-templates select="Lista/form/EMP_DIRECCION"/>
               <xsl:apply-templates select="Lista/form/EMP_PROVINCIA"/>  
               <xsl:apply-templates select="Lista/form/EMP_CPOSTAL"/>    
               <xsl:apply-templates select="Lista/form/EMP_POBLACION"/>  
               <xsl:apply-templates select="Lista/form/EMP_IDTIPO"/>     
               <xsl:apply-templates select="Lista/form/EMP_TELEFONO"/>   
               <xsl:apply-templates select="Lista/form/EMP_FAX"/>        
               <xsl:apply-templates select="Lista/form/EMP_REFERENCIAS"/>
               <xsl:apply-templates select="Lista/form/ORDERBY"/>        
               <xsl:apply-templates select="Lista/form/CONSULTAPREDEFINIDA"/>                       
               <xsl:apply-templates select="Lista/form/ROWSET/LISTAINICIAL"/>                       
               <xsl:apply-templates select="Lista/form/REGISTROSPORPAGINA"/>        
               
               <input type="hidden" name="ULTIMAPAGINA"/>
               <input type="hidden" name="LISTAFINAL"/>

         <!--botones-->
          <div class="divLeft">
          	<div class="divLeft10">&nbsp;</div>
            <div class="divLeft15nopa">&nbsp;
                  <xsl:if test="Lista/form/ROWSET/BUTTONS/ATRAS">
                   <img src="/images/anterior.gif" />&nbsp;
                    <xsl:call-template name="botonPersonalizado">
                      <xsl:with-param name="funcion">Navega(document.forms[0],'<xsl:value-of select="//Lista/form/ROWSET/BUTTONS/ATRAS/@PAG"/>');</xsl:with-param>
                      <xsl:with-param name="label"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0050']" disable-output-escaping="yes"/></xsl:with-param>
                      <xsl:with-param name="status"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0050']" disable-output-escaping="yes"/></xsl:with-param>
                    </xsl:call-template>
                  </xsl:if>
              </div>
            <div class="divLeft10">&nbsp;</div>
        	<div class="divLeft15nopa">
                  <xsl:call-template name="boton">
                <xsl:with-param name="path" select="Lista/form/button[@label='VolverBusqueda']"/>
              </xsl:call-template>
            </div>
             <div class="divLeft10">&nbsp;</div>
            <div class="divLeft15nopa">
              <xsl:call-template name="boton">
                <xsl:with-param name="path" select="Lista/form/button[@label='Aceptar']"/>
              </xsl:call-template>
            </div>
            <div class="divLeft10">&nbsp;</div>
            <div class="divLeft15nopa">
                      <xsl:if test="Lista/form/ROWSET/BUTTONS/ADELANTE">
                      
                        <xsl:call-template name="botonPersonalizado">
                          <xsl:with-param name="funcion">Navega(document.forms[0],'<xsl:value-of select="//Lista/form/ROWSET/BUTTONS/ADELANTE/@PAG"/>');</xsl:with-param>
                          <xsl:with-param name="label"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0040']" disable-output-escaping="yes"/></xsl:with-param>
                          <xsl:with-param name="status"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0040']" disable-output-escaping="yes"/></xsl:with-param>
                </xsl:call-template> 
                &nbsp;<img src="/images/siguiente.gif" />
              </xsl:if>
           </div>
       </div><!--fin divleft botones-->
  		
       <div class="divleft" style="margin:15px 0px">
       <table class="grandeInicio">
            <thead>
            <tr class="tituloTabla">
              <td>&nbsp;</td>
                <td>
                  <!-- Ficha Empresa  -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0010' and @lang=$lang]" disable-output-escaping = "yes" />
                </td>
                <td class="cinco">
                  <!-- Es cliente -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0015' and @lang=$lang]" disable-output-escaping = "yes" />
                </td>
                 <td class="cinco">
                  <!-- Es proveedor -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0020' and @lang=$lang]" disable-output-escaping = "yes" />
                </td>
                 <td class="cinco">
                  <!-- Es proveedor habitual -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0025' and @lang=$lang]" disable-output-escaping = "yes" />
                </td>
                <td class="cinco">
                  <!-- Nota calidad -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0030' and @lang=$lang]" disable-output-escaping = "yes" />
                </td>
              </tr>
              <tr class="titulos">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><a href="javascript:TodosClientes(document.forms[0])">
     		  <xsl:attribute name="onMouseOver">window.status='Seleccionar todos';return true</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true</xsl:attribute>
	          Todos</a></td>		
                <td><a href="javascript:TodosProveedores(document.forms[0])">
     		  <xsl:attribute name="onMouseOver">window.status='Seleccionar todos';return true</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true</xsl:attribute>	
	           Todos</a></td>	
                <td><a href="javascript:TodosProveedoresHabituales(document.forms[0])">
     		  <xsl:attribute name="onMouseOver">window.status='Seleccionar todos';return true</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true</xsl:attribute>
	           Todos</a></td>	                
                <td>&nbsp;</td>
              </tr>
              </thead>
              <tbody>
              <xsl:for-each select="Lista/form/ROWSET/ROW">
                <tr>
                <td width="50px"><xsl:apply-templates select="TE_DESCRIPCION_NORM"/></td>
                  <td class="textLeft"><xsl:apply-templates select="EMP_ID"/></td>
                  <td><xsl:apply-templates select="CYP_ESCLIENTE"/></td>
                  <td><xsl:apply-templates select="CYP_ESPROVEEDOR"/></td>
                  <td><xsl:apply-templates select="CYP_ESPROVEEDORHABITUAL"/></td>
                  <td>
               
                     <input size="1" maxlength="1" onChange="ValidaUnSoloNumero(this)">
                      <xsl:attribute name="name">NOTAC_<xsl:value-of select="EMP_ID"/></xsl:attribute>
                      <xsl:attribute name="value">
                        <xsl:choose>
                          <xsl:when test="CYP_NOTACALIDAD[.=-1]">
                          </xsl:when>                      	
                          <xsl:otherwise>
                      	    <xsl:value-of select="CYP_NOTACALIDAD"/>
                          </xsl:otherwise>                          
                        </xsl:choose>                      	
                      </xsl:attribute>
                    </input>   
    
                  </td>                                    
                </tr>
              </xsl:for-each>
              </tbody>
              <thead>
              <tr class="titulos">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><a href="javascript:TodosClientes(document.forms[0])">
     		  <xsl:attribute name="onMouseOver">window.status='Seleccionar todos';return true</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true</xsl:attribute>
	          Todos</a></td>		
                <td><a href="javascript:TodosProveedores(document.forms[0])">
     		  <xsl:attribute name="onMouseOver">window.status='Seleccionar todos';return true</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true</xsl:attribute>	
	          Todos</a></td>	
                <td><a href="javascript:TodosProveedoresHabituales(document.forms[0])">
     		  <xsl:attribute name="onMouseOver">window.status='Seleccionar todos';return true</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true</xsl:attribute>
	          Todos</a></td>	                
                <td>&nbsp;</td>
              </tr>              
              <tr class="tituloTabla">
              <td>&nbsp;</td>
                <td>
                  <!-- Ficha Empresa  -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0010' and @lang=$lang]" disable-output-escaping = "yes" />
                </td>
                <td>
                  <!-- Es cliente -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0015' and @lang=$lang]" disable-output-escaping = "yes" />
                </td>
                <td>
                  <!-- Es proveedor -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0020' and @lang=$lang]" disable-output-escaping = "yes" />
                </td>
                <td>
                  <!-- Es proveedor habitual -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0025' and @lang=$lang]" disable-output-escaping = "yes" />
                </td>
                <td>
                  <!-- Nota calidad -->
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CYP-0030' and @lang=$lang]" disable-output-escaping = "yes" />
               </td>
              </tr>
            </thead>
                        
            </table>
         </div><!--fin de divleft tabla-->          
            
          
        <!--botones-->
          <div class="divLeft">
          	<div class="divLeft10">&nbsp;</div>
            <div class="divLeft15nopa">&nbsp;
                  <xsl:if test="Lista/form/ROWSET/BUTTONS/ATRAS">
                   <img src="/images/anterior.gif" />&nbsp;
                    <xsl:call-template name="botonPersonalizado">
                      <xsl:with-param name="funcion">Navega(document.forms[0],'<xsl:value-of select="//Lista/form/ROWSET/BUTTONS/ATRAS/@PAG"/>');</xsl:with-param>
                      <xsl:with-param name="label"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0050']" disable-output-escaping="yes"/></xsl:with-param>
                      <xsl:with-param name="status"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0050']" disable-output-escaping="yes"/></xsl:with-param>
                    </xsl:call-template>
                  </xsl:if>
              </div>
            <div class="divLeft10">&nbsp;</div>
        	<div class="divLeft15nopa">
                  <xsl:call-template name="boton">
                <xsl:with-param name="path" select="Lista/form/button[@label='VolverBusqueda']"/>
              </xsl:call-template>
            </div>
             <div class="divLeft10">&nbsp;</div>
            <div class="divLeft15nopa">
              <xsl:call-template name="boton">
                <xsl:with-param name="path" select="Lista/form/button[@label='Aceptar']"/>
              </xsl:call-template>
            </div>
            <div class="divLeft10">&nbsp;</div>
            <div class="divLeft15nopa">
                      <xsl:if test="Lista/form/ROWSET/BUTTONS/ADELANTE">
                      
                        <xsl:call-template name="botonPersonalizado">
                          <xsl:with-param name="funcion">Navega(document.forms[0],'<xsl:value-of select="//Lista/form/ROWSET/BUTTONS/ADELANTE/@PAG"/>');</xsl:with-param>
                          <xsl:with-param name="label"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0040']" disable-output-escaping="yes"/></xsl:with-param>
                          <xsl:with-param name="status"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0040']" disable-output-escaping="yes"/></xsl:with-param>
                </xsl:call-template> 
                &nbsp;<img src="/images/siguiente.gif" />
              </xsl:if>
           </div>
       </div><!--fin divleft botones-->
          
            </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
    
  </xsl:template>
  
  <xsl:template match="TE_DESCRIPCION_NORM">
    <xsl:choose>
      <xsl:when test="substring-before(.,' ')">
        <xsl:element name="img">
          <xsl:attribute name="src">http://www.newco.dev.br/images/tiposEmpresas/<xsl:value-of select="substring-before(.,' ')"/>.gif</xsl:attribute>
        </xsl:element>   
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="img">
          <xsl:attribute name="src">http://www.newco.dev.br/images/tiposEmpresas/<xsl:value-of select="."/>.gif</xsl:attribute>
        </xsl:element> 
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>
  
  <xsl:template match="EMP_ID">
  <input type="hidden">
    <xsl:attribute name="name">EMPR_<xsl:value-of select="."/></xsl:attribute>
  </input>
     <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
     <a onMouseOver="window.status='Mostrar detalle empresa';return true;" onMouseOut="window.status='';return false;"><xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="."/>&amp;VENTANA=NUEVA','empresa',65,58,0,-50);</xsl:attribute><xsl:value-of select="../EMP_NOMBRE" disable-output-escaping="yes"/></a>
   	
      <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;</xsl:text>
    
      <xsl:if test="../EMP_REFERENCIAS[.='']">
        <xsl:value-of select="../TE_DESCRIPCION" disable-output-escaping="yes"/>
      </xsl:if>
      <xsl:value-of select="../EMP_REFERENCIAS" disable-output-escaping="yes"/>
      
     <xsl:text>&nbsp;]&nbsp;</xsl:text>
  </xsl:template>

  <xsl:template match="CYP_ESCLIENTE">
    <input type="checkbox" >
    <xsl:attribute name="name">ESCLI_<xsl:value-of select="../EMP_ID"/></xsl:attribute>
        <xsl:choose>
          <xsl:when test="../CYP_ESCLIENTE[.='S']">
            <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:when>
        </xsl:choose>
    </input>
  </xsl:template>

  <xsl:template match="CYP_ESPROVEEDOR">
    <input type="checkbox" >
    <xsl:attribute name="name">ESPRV_<xsl:value-of select="../EMP_ID"/></xsl:attribute>
        <xsl:choose>
          <xsl:when test="../CYP_ESPROVEEDOR[.='S']">
            <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:when>            
        </xsl:choose>
    </input>
  </xsl:template>

  <xsl:template match="CYP_ESPROVEEDORHABITUAL">
    <input type="checkbox" name="CYP_ESPROVEEDORHABITUAL" onClick="SelHabituales(this)">
      <xsl:attribute name="name">ESPRH_<xsl:value-of select="../EMP_ID"/></xsl:attribute>
        <xsl:choose>
          <xsl:when test="../CYP_ESPROVEEDORHABITUAL[.='S']">
            <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:when>            
        </xsl:choose>
    </input>
  </xsl:template>

  <xsl:template match="NOTACALIDAD">
    <select>
      <xsl:attribute name="name">NOTAC_<xsl:value-of select="$empid"/></xsl:attribute>
      <xsl:for-each select="listElem">
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  
  <xsl:template match="EMP_NIF">
        <input type="hidden" name="EMP_NIF">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>        
        </input>
  </xsl:template>

  <xsl:template match="EMP_NOMBRE">
        <input type="hidden" name="EMP_NOMBRE">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>
  <xsl:template match="EMP_DIRECCION">
        <input type="hidden" name="EMP_DIRECCION">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>        
        </input>
  </xsl:template>
  <xsl:template match="EMP_PROVINCIA">
        <input type="hidden" name="EMP_PROVINCIA"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>        
        </input>
  </xsl:template>
  <xsl:template match="EMP_CPOSTAL">
        <input type="hidden" name="EMP_CPOSTAL">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>
  <xsl:template match="EMP_POBLACION">
        <input type="hidden" name="EMP_POBLACION">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>
  <xsl:template match="EMP_IDTIPO">
        <input type="hidden" name="EMP_IDTIPO">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>
  <xsl:template match="EMP_TELEFONO">
        <input type="hidden" name="EMP_TELEFONO">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>
  <xsl:template match="EMP_FAX">
        <input type="hidden" name="EMP_FAX">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>
  <xsl:template match="EMP_REFERENCIAS">
        <input type="hidden" name="EMP_REFERENCIAS">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>
  <xsl:template match="EMP_ORDERBY">
        <input type="hidden" name="EMP_ORDERBY">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>
  <xsl:template match="CONSULTAPREDEFINIDA">
        <input type="hidden" name="CONSULTAPREDEFINIDA">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>

  <xsl:template match="LISTAINICIAL">
        <input type="hidden" name="LISTAINICIAL">
        <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
        </input>
  </xsl:template>
<!--
  <xsl:template match="field">
    <xsl:apply-templates select="dropDownList"/>
  </xsl:template>
  
  <xsl:template match="dropDownList">
    <select>
      <xsl:attribute name="name"><xsl:value-of select="$NombreCampoField"/></xsl:attribute>
      <xsl:for-each select="listElem">
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
-->
</xsl:stylesheet>
