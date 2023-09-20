<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:template match="/">
    <html>
      <head>
     
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript">
	  <!--
	  
	   var msgSinProductosParaQuitarAdjudicacion='No hay cambios en las adjudicaturas. Por favor, revise el listado antes de continuar.';
	    var msgAvisoCambio='Al quitar la adjudicación a un proveedor también se eliminara de sus plantillas.\n\n¿Continuar con el envío de los cambios?';
	  
	    function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion){
	    	var objFrame=new Object();
	      objFrame=obtenerFrame(top, nombreFrame);
				
				
				if(objFrame!=null){		
					var retorno=eval('objFrame.'+nombreFuncion);
					if(retorno!=undefined){
						return retorno;
					}
				}
	    }
	    
	    
	    function EjecutarExterno(nombreFrame,idProductoEstandar){
	    	
	    	EjecutarFuncionDelFrame(nombreFrame,nombreFuncion);
	    	EjecutarFuncionDelFrame('zonaProducto','location.href=\'about:blank\'');
	    }
	    
	   
	   function recargarPagina(tipo){
	   		
	   		EjecutarFuncionDelFrame('Cabecera','EjecutarEnviarBusqueda();');

	     /*if(tipo=='PROPAGAR'){
	       
	       var objFrameTop=new Object();         
               objFrameTop=window.top;
               var objFrame=new Object();
               objFrame=obtenerFrame(objFrameTop,'zonaCatalogo'); 
               objFrame.recargarPagina();
	     }*/
	   }
	   
	 function DesadjudicarProveedores(form){

           var cadenaCambios='';
          
           for(var n=0;n<document.forms.length;n++){
             var formActual=document.forms[n];
             if(formActual.name.substring(0,5)=='form_'){
               for(var i=0;i<formActual.length;i++){
                 if(formActual.elements[i].name.substring(0,14)=='CHKADJUDICADO_'){
                
                   var idProveedor=obtenerId(formActual.elements[i].name);
                   var adjudicado;
                   var aptoPorHistorico;
                
                   if(formActual.elements[i].checked==true){
                     adjudicado='N';
                     cadenaCambios+=idProveedor+'|'+adjudicado+'#';
                   }
                 }
               }
             }
           }
           document.forms['form1'].elements['CAMBIOSADJUDICATURAS'].value=cadenaCambios;
           if(cadenaCambios==''){
             alert(msgSinProductosParaQuitarAdjudicacion);
           }
           else{
             if(confirm(msgAvisoCambio)){
               SubmitForm(document.forms['form1']);	                
             }
           }
         }
	   
	   
	//	LLama al buscador filtrando por familia	   
	function Familia(IDFamilia)
	{
	    var objFrameTop=new Object();         
            objFrameTop=window.top;
        var objFrameInt=new Object();
            objFrameInt=obtenerFrame(objFrameTop,'zonaCatalogo');
        var objFrame=new Object();
            objFrame=obtenerFrame(objFrameInt,'areaTrabajo'); //zonaCatalogo
			
			
			alert (objFrame.id+' '+objFrame.name);
			
			PresentaForms(objFrame.document);
			
			PresentaCampos(objFrame.document.forms['form1']);
	/*
		objFrame.document.forms['Busqueda'].elements['IDFAMILIA'].value= IDFamilia;		//document.
	    objFrame.document.forms['Busqueda'].elements['PRODUCTO'].value='';
	    objFrame.document.forms['Busqueda'].elements['PROVEEDOR'].value='';
		*/
		EjecutarFuncionDelFrame('Cabecera','EjecutarEnviarBusqueda();');
	}

	//	LLama al buscador filtrando por subfamilia	   
	function Subfamilia(IDSubfamilia)
	{
		alert('No implementado - Filtrar por subfamilia:'+IDSubfamilia);
	}

	//	Marca todos los productos para ser desadjudicados (solo listado de adjudicados)
	function MarcarTodos()
	{
		var 	Valor='';

        for(var m=0;m<document.forms.length;m++)
		{
			form=document.forms[m];
			for(var n=0;n<form.length;n++)
			{
				if(form.elements[n].name.match('CHKADJUDICADO_'))
				{
					if (Valor=='') 
						if (form.elements[n].checked==true)
							Valor='N';
						else 
							Valor='S';

					if (Valor=='S')
						form.elements[n].checked=true;
					else
						form.elements[n].checked=false;
				}
			}
		}

	}
	
	
	  //-->
	</script>
        ]]></xsl:text>
      </head>
      <body>      
        <xsl:choose>
      	
        <xsl:when test="FamiliasYProductos/SESION_CADUCADA">
          <xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="FamiliasYProductos/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="FamiliasYProductos/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        
    <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	       <!--idioma fin-->
      
      
        <!--miramos si hay datos devueltos, esto lo hacemos en funcion del tipo de listado solicitado-->
        <xsl:choose>
        	<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='D' and not(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)">
        		<h1 class="titlePage">
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        		</h1>
        	</xsl:when>
        	<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P' and count(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)&lt;=1">
        		<h1 class="titlePage">
					 <xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        		</h1>
        	</xsl:when>
        	<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='PExc' and count(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)&lt;=1">
        		<h1 class="titlePage">
					  <xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        		</h1>
        	</xsl:when>
        	<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='PP' and not(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)">
        		<h1 class="titlePage">
					 <xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        			</h1>
        	</xsl:when>
        	<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='CP' and not(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)">
        		<h1 class="titlePage">
					 <xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        			</h1>
        	</xsl:when>
        	<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='M' and not(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)">
        		<h1 class="titlePage">
					 <xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        		</h1>
        	</xsl:when>
        	<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='ADJ' and not(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)">
        		<h1 class="titlePage">
					 <xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        		</h1>
        	</xsl:when>
            <xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='MULT' and not(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)">
        			<h1 class="titlePage">
					 <xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        			</h1>
        	</xsl:when>
        	<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones' and not(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)">
        		<h1 class="titlePage">
					 <xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        			</h1>
        	</xsl:when>    
        	<xsl:otherwise>

    
  <!-- si es el listado de adjudicaturas creamos  el form para poder enviar la lista de cambios,(proveedores a desadjudicar) -->
         
          <xsl:if test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='ADJ' or FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='MULT'">
          <form name="form1" method="post" action="DesadjudicarProveedoresSave.xsql">
            <input type="hidden" name="CAMBIOSADJUDICATURAS"/>
          </form>
		</xsl:if>
        
  <table class="grandeInicio">
   <tr class="tituloTabla">
        <th><a href="javascript:window.print();"><img src="http://www.newco.dev.br/images/imprimir.gif" alt="Imprimir" title="Imprimir" /></a><a href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
        
        </th>
		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado_listado']/node()"/>
      
        <br />
				              <xsl:if test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='ADJ'">
                              	 <xsl:value-of select="document($doc)/translation/texts/item[@name='prod_emplan_no_comprados']/node()"/>
							  </xsl:if>
				              <xsl:if test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='MULT'">
                              	 <xsl:value-of select="document($doc)/translation/texts/item[@name='prod_adjudicados_forma_mult']/node()"/>
							  </xsl:if>
        </th>
	    </tr>
	</table>
    <!--template de los casos-->
    	<xsl:choose>
			<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='D'">
            	<xsl:call-template name="modoD"/>
			</xsl:when>
			
			<!-- modos -->
			<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='ADJ'">
            	<xsl:call-template name="modoADJ"/>
			</xsl:when>
            <xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='MULT'">
            	<xsl:call-template name="modoMULT"/>
			</xsl:when>
			<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
            	<xsl:call-template name="modoP"/><!--precios y ahorros-->
			</xsl:when>
			<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'"><!--	26nov08	ET	nuevo listado	-->
            	<xsl:call-template name="modoComisiones"/>
			</xsl:when>
			<xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='PExc'"><!--	11oct05	ET nuevo listado	-->
               <xsl:call-template name="modoPExc"/>
			</xsl:when>
            <xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='PP'">
            	<xsl:call-template name="modoPP"/>
			</xsl:when>
            <xsl:when test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='CP'">
            	<xsl:call-template name="modoCP"/>
			</xsl:when>
            <xsl:otherwise><!--	Modo M	-->
            	<xsl:call-template name="modoM"/>
			</xsl:otherwise>
    </xsl:choose>

  </xsl:otherwise><!--otherwise del inicio-->
  </xsl:choose>
  </xsl:otherwise>
  </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
<!--modoD Centros/proveedores-->
<xsl:template name="modoD">
modo d
  <table class="grandeInicio">
   <thead>
  		<tr class="titulos">
        		<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.</td>
                <td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
                <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros']/node()"/><span class="camposObligatorios">*</span></td>
                <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/><span class="camposObligatorios">*</span></td>
                <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></td>
		</tr>
   </thead>
   	<xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA">
       <tr class="familia nochange">
                     <td>
                        <strong>&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/></strong>
                     </td>
                     <td colspan="5">
                        &nbsp;<xsl:value-of select="@nombre"/>
                      </td>
                   
		</tr>
   	<xsl:for-each select="./SUBFAMILIA">
    	<!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	       <!--idioma fin-->
      	<tr class="subFamilia noChange">
      		 <td>
      			&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/>
             </td>
             <td colspan="5">
      			<xsl:value-of select="@nombre"/>
                &nbsp;&nbsp;&nbsp;&nbsp;[<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>-->ultima ref usada: <xsl:value-of select="REFESTANDARMAX"/>]
      		 </td>
		</tr>
      	<xsl:for-each select="./PRODUCTOESTANDAR">
        	<tr>
              	<td class="textLeft">
              		<xsl:choose>
              			<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
              				&nbsp;&nbsp; <strong><xsl:value-of select="REFERENCIA"/></strong>
              			</xsl:when>
              			<xsl:otherwise>
              				&nbsp;&nbsp; <strong><xsl:value-of select="REFERENCIA"/></strong>
              			</xsl:otherwise>
              		</xsl:choose>	
              	</td>
              	<td class="textLeft">
                	<strong>
              		<xsl:choose>
              			<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
              				<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');"  onMouseOver="window.status='Activa el Producto Estándar';return true;" onMouseOut="window.status='';return true;" class="noDecor">
              				          	  	<xsl:value-of select="NOMBRE"/>
              				</a>
              			</xsl:when>
              			<xsl:otherwise>
              				 <xsl:value-of select="NOMBRE"/>
              			</xsl:otherwise>
              	 </xsl:choose>
                 </strong>
             </td>
             <td><xsl:value-of select="CENTROS"/></td>
             <td><xsl:value-of select="PROVEEDORES"/></td>
             <td><xsl:value-of select="PROVEEDORADJUDICADO"/></td>
		</tr>
      </xsl:for-each>
     </xsl:for-each>
    </xsl:for-each>
  </table>
  
</xsl:template><!--fin de modoD-->
<!--modoADJ Adjudicados-->
<xsl:template name="modoADJ">
  <table class="grandeInicio">
   <thead>
  		<tr class="titulos">
        	 <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.</td>
             <td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
             <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></td>
		</tr>
    </thead>
     <xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA">
       <tr class="familia noChange">
                     <td>
                        <strong>&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/></strong>
                     </td>
                     <td colspan="2">
                        <xsl:value-of select="@nombre"/>
                      </td>
                   
		</tr>
      	<xsl:for-each select="./SUBFAMILIA">
        	<!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	       <!--idioma fin-->
            <tr class="subFamilia noChange">
               	 <td>
                    &nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="@referencia"/></strong>
                 </td>
                 <td colspan="2">
                    <xsl:value-of select="@nombre"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;[<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>-->ultima ref usada: <xsl:value-of select="REFESTANDARMAX"/>]
                 </td>
            </tr>
      	<xsl:for-each select="./PRODUCTOESTANDAR">
        
           <tr>
              	<td class="textLeft">
              		<xsl:choose>
              			<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
              				&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="REFERENCIA"/></strong>
              			</xsl:when>
              			<xsl:otherwise>
              				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong><xsl:value-of select="REFERENCIA"/></strong>
              			</xsl:otherwise>
              		</xsl:choose>
              	 </td>
              	 <td class="textLeft">
                 	<strong>
              		<xsl:choose>
              			<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
              				<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');" class="noDecor">
              				<xsl:value-of select="NOMBRE"/>
              				</a>
              			</xsl:when>
              			<xsl:otherwise>
              				<xsl:value-of select="NOMBRE"/>
              			</xsl:otherwise>
              		</xsl:choose>
                    </strong>
              	</td>
        	<xsl:for-each select="PROVEEDOR">
              			<xsl:choose>
              			<xsl:when test="ADJUDICADO='SI'"> <!-- creamos un form por check  -->
                                     <td><xsl:value-of select="PROVEEDORADJUDICADO"/>
                                        <xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='MULT'">
              					        	&nbsp;&nbsp;&nbsp;<xsl:value-of select="TOTAL"/>
									 	</xsl:if>
                                     </td>
              			</xsl:when>
              			 <xsl:otherwise>
                         	<td colspan="2">
              				<span class="rojo">
              					  <xsl:value-of select="PROVEEDORADJUDICADO"/>&nbsp;
              				</span>
                            </td>
              			 </xsl:otherwise>
              			</xsl:choose>
                        
                  
             </xsl:for-each>
            </tr>
            
           </xsl:for-each>
       </xsl:for-each>
      </xsl:for-each>
      </table>  		
   
</xsl:template><!--fin modoADJ-->
<!--modoMULT Multiples-->
<xsl:template name="modoMULT">
  <table class="grandeInicio">
   <thead>
  		<tr class="titulos">
        	 <td class="dies textLeft">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.</td>
             <td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
             <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></td>
             <td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></td>
		</tr>
    </thead>
     <xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA">
       <tr class="familia noChange">
                      <td>
                        <strong>&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/></strong>
                      </td>
                      <td colspan="3">
                       <xsl:value-of select="@nombre"/>
                      </td>
                   
		</tr>
      	<xsl:for-each select="./SUBFAMILIA">
        	<!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	       <!--idioma fin-->
      
            <tr class="subFamilia noChange">
                <td>
                    &nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/>
                </td>
                <td colspan="3">
                    <xsl:value-of select="@nombre"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;[<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>-->ultima ref usada: <xsl:value-of select="REFESTANDARMAX"/>]
                </td>
		</tr>
      	<xsl:for-each select="./PRODUCTOESTANDAR">
           <tr>
              	<td class="textLeft">
              		<xsl:choose>
              			<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
              				&nbsp;&nbsp;<b><xsl:value-of select="REFERENCIA"/></b>
              			</xsl:when>
              			<xsl:otherwise>
              				&nbsp;&nbsp;<b><xsl:value-of select="REFERENCIA"/></b>
              			</xsl:otherwise>
              		</xsl:choose>
              	 </td>
              	 <td class="textLeft">
                 <strong>
              		<xsl:choose>
              			<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
              				<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');"  onMouseOver="window.status='Activa el Producto Estándar';return true;" onMouseOut="window.status='';return true;" class="noDecor">
              				<xsl:value-of select="NOMBRE"/>
              				</a>
              			</xsl:when>
              			<xsl:otherwise>
              				<xsl:value-of select="NOMBRE"/>
              			</xsl:otherwise>
              		</xsl:choose>
                </strong>
              	</td>
        	<xsl:for-each select="PROVEEDOR">
              			<xsl:choose>
              			<xsl:when test="ADJUDICADO='SI'"> <!-- creamos un form por check  -->
                            <td><xsl:value-of select="PROVEEDORADJUDICADO"/></td>
                            <td><xsl:value-of select="TOTAL"/></td>
              			</xsl:when>
              			 <xsl:otherwise>
                         	<td colspan="2">
              				<span class="rojo">
              					  <xsl:value-of select="PROVEEDORADJUDICADO"/>&nbsp;
              				</span>
                            </td>
              			 </xsl:otherwise>
              			</xsl:choose>
             </xsl:for-each>
             </tr>
           </xsl:for-each>
       </xsl:for-each>
      </xsl:for-each>
      </table>  		
   
</xsl:template><!--fin modoMULT-->

<!--modoP precios y ahorro-->
<xsl:template name="modoP">
  <table class="grandeInicio" border="0">
   <thead>
  		<tr class="titulos">
                <td class="dies textLeft">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.</td>
                <td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
                <td class="veintecinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
                <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
                <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico']/node()"/><span class="camposObligatorios">*</span></td>
                <td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_actual']/node()"/><span class="camposObligatorios">**</span></td>
                <td class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></td>
		</tr>
   </thead>
    <xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA">
       <tr class="familia noChange">
                     	<td>
                        <strong>&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/></strong> 
                        </td>
                        <td colspan="6">
                        &nbsp;<xsl:value-of select="@nombre"/>
                      </td>
                   
		</tr>
      	<xsl:for-each select="./SUBFAMILIA">
        	<!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	       <!--idioma fin-->
                <tr class="subFamilia noChange">
                        <td>&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/></td>
                        <td colspan="6">
                        <xsl:value-of select="@nombre"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;[<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>-->ultima ref usada: <xsl:value-of select="REFESTANDARMAX"/>]
                     </td>
                </tr>
      	<xsl:for-each select="./PRODUCTOESTANDAR">
        <!--enseño productos no adjudic solo si es mvm si no enseño solo los adjudicados-->
        <xsl:choose>
			<xsl:when test="(count(PROVEEDOR) &gt; 0) and ../../../IDEMPRESA != '1'">
        <!--si hay proveedor enseño linea, si no no-->
        <xsl:if test="PROVEEDOR">
          <tr>
              <td class="textLeft">
               	<strong>&nbsp;&nbsp;
                   <xsl:choose>
                    	<xsl:when test="ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
                        	<xsl:value-of select="REFERENCIA"/>
                        </xsl:when>
                        <xsl:otherwise>
                        	<xsl:value-of select="REFERENCIA"/>
                        </xsl:otherwise>
                   </xsl:choose>
                  </strong>
               </td>
                <td class="textLeft">
                    	<strong>
                        <xsl:choose>
                    	  	<xsl:when test="ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
                        		<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');"  onMouseOver="window.status='Activa el Producto Estándar';return true;" onMouseOut="window.status='';return true;" class="noDecor">
                        				<xsl:value-of select="NOMBRE"/>
                        		</a>
                        	</xsl:when>
                        	<xsl:otherwise>
                        			<xsl:value-of select="NOMBRE"/>
                        	</xsl:otherwise>
                        </xsl:choose>
                        </strong>
                   </td>
                	<td>
                		
				<!--	12mar08	ET	añadimos las plantillas en las que está incluido el producto	-->
                	<div class="divLeft">
                	<xsl:for-each select="PROVEEDOR">
                			<!-- el proveedor -->
                			<div class="divLeft45nopa"><xsl:value-of select="NOMBRE"/></div>
                			<!-- la referencia -->
                			<div class="divLeft50nopa">
                			<xsl:if test="REFERENCIA!=''">
                				(<xsl:value-of select="REFERENCIA"/>)
                			</xsl:if>
                    		<xsl:if test="PROV_ANTERIOR!=''">
                            	&nbsp;
                    			[<xsl:value-of select="PROV_ANTERIOR"/>]
                    		</xsl:if>	
                			</div>
                	</xsl:for-each>
                    </div>
                	</td>
                	<td>
                	
                	<xsl:for-each select="PROVEEDOR">
                			<div class="divLeft">
                					<xsl:value-of select="UNIDADBASICA"/>
                			</div>
                		</xsl:for-each>
                	</td>
                	<td>
                	<div class="divLeft">
                					<xsl:for-each select="PROVEEDOR">
                						
 											<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
											<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                								<div class="divLeft50nopa">
                									T:<xsl:value-of select="TIPOIVA"/>&nbsp;
												</div>
											</xsl:if>
                							<!-- precio historico -->
                							<div>
                                            <xsl:attribute name="class">
                                            <xsl:choose>
                                            <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">divLeft50nopa</xsl:when>
                                            <xsl:otherwise>divLeft</xsl:otherwise>
                                            </xsl:choose>
                                            </xsl:attribute>
                							<!-- calculos de ahorro por empresa -->
                	  								<xsl:choose>
                    									<xsl:when test="PRECIOHISTORICO!=''">
                    									  <xsl:choose>
                    								    	<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC and ../ID!=''">
                                                            	<xsl:if test="ARBITRARIO='S'">
                    											   		<span class="camposObligatorios"><b>!</b></span>&nbsp;
                    											</xsl:if>
                    								    	  <a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({../ID},\'CAMBIOPRODUCTOESTANDAR\');');MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR={../ID}&amp;ACCION=MODIFICARPRODUCTOESTANDAR&amp;VENTANA=NUEVA','productoestandar');">
                    								    	  
																<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																<xsl:choose>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        			<xsl:value-of select="PRECIOHISTORICO"/>
																	</xsl:when>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        			<xsl:value-of select="PRECIOHISTORICO_IVA"/>
																	</xsl:when>
 																</xsl:choose>
                    								    	  </a>
                    								    	</xsl:when>
                    								    	<xsl:otherwise>
																<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																<xsl:choose>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        			<xsl:value-of select="PRECIOHISTORICO"/>
																	</xsl:when>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        			<xsl:value-of select="PRECIOHISTORICO_IVA"/>
																	</xsl:when>
 																</xsl:choose>
                    								    	</xsl:otherwise>
                    									  </xsl:choose>   
                    									</xsl:when>
                    									<xsl:otherwise>
                    									  <xsl:choose>
                    								    	<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC and ../ID!=''">
                    								    	  <a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({../ID},\'CAMBIOPRODUCTOESTANDAR\');');MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR={../ID}&amp;ACCION=MODIFICARPRODUCTOESTANDAR&amp;VENTANA=NUEVA','productoestandar');">
                    								        	<font color="red">
                    								        	  <xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
                    								        	 </font>
                    								    	  </a>
                    								    	</xsl:when>
                    								    	<xsl:otherwise>
                    								    	  <font color="red">
                    								        	 <xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
                    								        </font>
                    								    	</xsl:otherwise>
                    									  </xsl:choose>   
                    									</xsl:otherwise>
                	  								</xsl:choose>

                							</div>
                					</xsl:for-each>
                	</div>
                	</td>
                	<td>
                		<xsl:for-each select="PROVEEDOR">
                			<div class="divLeft">
 							<!--Distinguimos entre el listado normal de precios y el de comisiones-->
							<xsl:choose>
								<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    				<xsl:value-of select="PRECIOACTUAL"/>
								</xsl:when>
								<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    				<xsl:value-of select="PRECIOACTUAL_IVA"/>&nbsp;
								</xsl:when>
 							</xsl:choose>
                			</div>	
                		</xsl:for-each>
                	</td>
                	<td>
                		<xsl:for-each select="PROVEEDOR">
                			<div class="divLeft">
                				<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
								<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                					CT:<xsl:value-of select="COMISION_IVA"/>&nbsp;
								</xsl:if>
 								<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
								<xsl:choose>
									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                						<xsl:value-of select="AHORRO"/>&nbsp;
									</xsl:when>
									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                						AN:<xsl:value-of select="AHORRO_NETO"/>&nbsp;
									</xsl:when>
 								</xsl:choose>
                            </div>
                		</xsl:for-each>
                	</td>
				</tr>
		</xsl:if><!--fin is si hay proveedor, si no hay no enseño lineas-->
        </xsl:when>
        <!--si empresa mvm-->
        <xsl:when test="../../../IDEMPRESA = '1'">
      		  <xsl:choose>
          <xsl:when test="PROVEEDOR">
          	
          <tr>
              <td class="textLeft">
               	<strong>&nbsp;&nbsp;
                   <xsl:choose>
                    	<xsl:when test="ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
                        	<xsl:value-of select="REFERENCIA"/>
                        </xsl:when>
                        <xsl:otherwise>
                        	<xsl:value-of select="REFERENCIA"/>
                        </xsl:otherwise>
                   </xsl:choose>
					<xsl:if test="SIN_PLANTILLAS">
 						<font color="red">!!</font>
					</xsl:if>
                  </strong>
               </td>
                <td class="textLeft">
                    	<strong>
                        <xsl:choose>
                    	  	<xsl:when test="ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
                        		<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');"  onMouseOver="window.status='Activa el Producto Estándar';return true;" onMouseOut="window.status='';return true;" class="noDecor">
                        				<xsl:value-of select="NOMBRE"/>
                        		</a>
                        	</xsl:when>
                        	<xsl:otherwise>
                        			<xsl:value-of select="NOMBRE"/>
                        	</xsl:otherwise>
                        </xsl:choose>
                        </strong>
                   </td>
                	<td>
                		
				<!--	12mar08	ET	añadimos las plantillas en las que está incluido el producto	-->
                	<div class="divLeft">
                	<xsl:for-each select="PROVEEDOR">
                			<!-- el proveedor -->
                			<div class="divLeft45nopa"><xsl:value-of select="NOMBRE"/></div>
                			<!-- la referencia -->
                			<div class="divLeft50nopa">
                			<xsl:if test="REFERENCIA!=''">
                				(<xsl:value-of select="REFERENCIA"/>)
                			</xsl:if>
                    		<xsl:if test="PROV_ANTERIOR!=''">
                            	&nbsp;
                    			[<xsl:value-of select="PROV_ANTERIOR"/>]
                    		</xsl:if>	
                			</div>
                	</xsl:for-each>
                    </div>
                	</td>
                	<td>
                	
                	<xsl:for-each select="PROVEEDOR">
                			<div class="divLeft">
                					<xsl:value-of select="UNIDADBASICA"/>
                			</div>
                		</xsl:for-each>
                	</td>
                	<td>
                	<div class="divLeft">
                					<xsl:for-each select="PROVEEDOR">
                						
 											<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
											<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                								<div class="divLeft50nopa">
                									T:<xsl:value-of select="TIPOIVA"/>&nbsp;
												</div>
											</xsl:if>
                							<!-- precio historico -->
                							<div>
                                            <xsl:attribute name="class">
                                            <xsl:choose>
                                            <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">divLeft50nopa</xsl:when>
                                            <xsl:otherwise>divLeft</xsl:otherwise>
                                            </xsl:choose>
                                            </xsl:attribute>
                							<!-- calculos de ahorro por empresa -->
                	  								<xsl:choose>
                    									<xsl:when test="PRECIOHISTORICO!=''">
                    									  <xsl:choose>
                    								    	<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC and ../ID!=''">
                                                            	<xsl:if test="ARBITRARIO='S'">
                    											   		<span class="camposObligatorios"><b>!</b></span>&nbsp;
                    											</xsl:if>
                    								    	  <a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({../ID},\'CAMBIOPRODUCTOESTANDAR\');');MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR={../ID}&amp;ACCION=MODIFICARPRODUCTOESTANDAR&amp;VENTANA=NUEVA','productoestandar');">
                    								    	  
																<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																<xsl:choose>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        			<xsl:value-of select="PRECIOHISTORICO"/>
																	</xsl:when>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        			<xsl:value-of select="PRECIOHISTORICO_IVA"/>
																	</xsl:when>
 																</xsl:choose>
                    								    	  </a>
                    								    	</xsl:when>
                    								    	<xsl:otherwise>
																<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																<xsl:choose>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        			<xsl:value-of select="PRECIOHISTORICO"/>
																	</xsl:when>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        			<xsl:value-of select="PRECIOHISTORICO_IVA"/>
																	</xsl:when>
 																</xsl:choose>
                    								    	</xsl:otherwise>
                    									  </xsl:choose>   
                    									</xsl:when>
                    									<xsl:otherwise>
                    									  <xsl:choose>
                    								    	<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC and ../ID!=''">
                    								    	  <a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({../ID},\'CAMBIOPRODUCTOESTANDAR\');');MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR={../ID}&amp;ACCION=MODIFICARPRODUCTOESTANDAR&amp;VENTANA=NUEVA','productoestandar');">
                    								        	<font color="red">
                    								        	    <xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
                    								        	 </font>
                    								    	  </a>
                    								    	</xsl:when>
                    								    	<xsl:otherwise>
                    								    	  <font color="red">
                    								        	 <xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
                    								        </font>
                    								    	</xsl:otherwise>
                    									  </xsl:choose>   
                    									</xsl:otherwise>
                	  								</xsl:choose>

                							</div>
                					</xsl:for-each>
                	</div>
                	</td>
                	<td>
                		<xsl:for-each select="PROVEEDOR">
                			<div class="divLeft">
 							<!--Distinguimos entre el listado normal de precios y el de comisiones-->
							<xsl:choose>
								<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    				<xsl:value-of select="PRECIOACTUAL"/>
								</xsl:when>
								<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    				<xsl:value-of select="PRECIOACTUAL_IVA"/>&nbsp;
								</xsl:when>
 							</xsl:choose>
                			</div>	
                		</xsl:for-each>
                	</td>
                	<td>
                		<xsl:for-each select="PROVEEDOR">
                			<div class="divLeft">
                				<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
								<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                					CT:<xsl:value-of select="COMISION_IVA"/>&nbsp;
								</xsl:if>
 								<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
								<xsl:choose>
									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                						<xsl:value-of select="AHORRO"/>&nbsp;
									</xsl:when>
									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                						AN:<xsl:value-of select="AHORRO_NETO"/>&nbsp;
									</xsl:when>
 								</xsl:choose>
                            </div>
                		</xsl:for-each>
                	</td>
				</tr>
		</xsl:when><!--fin is si hay proveedor, si no hay no enseño lineas-->
        <xsl:otherwise>
        <tr>
               <td class="textLeft">
               	<strong>&nbsp;&nbsp;
                   <xsl:choose>
                    	<xsl:when test="ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
                        	<xsl:value-of select="REFERENCIA"/>
                        </xsl:when>
                        <xsl:otherwise>
                        	<xsl:value-of select="REFERENCIA"/>
                        </xsl:otherwise>
                   </xsl:choose>
					<xsl:if test="SIN_PLANTILLAS">
 						<font color="red">!!</font>
					</xsl:if>
                </strong>
               </td>
                <td class="textLeft">
                    	<strong>
                        		<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');"  onMouseOver="window.status='Activa el Producto Estándar';return true;" onMouseOut="window.status='';return true;" class="noDecor">
                        				<xsl:value-of select="NOMBRE"/>
                        		</a>
                        </strong>
                        	
                   </td>
                   <td colspan="5">&nbsp;</td>
        </tr>
        </xsl:otherwise>
        </xsl:choose>
        </xsl:when><!--fin when si es mvm idempresa=1-->
        </xsl:choose>
       
        </xsl:for-each>
        
      </xsl:for-each>
    </xsl:for-each>
       
  </table>
</xsl:template><!--fin modoP-->

<!--modoComisiones -->
<xsl:template name="modoComisiones">
  <table class="grandeInicio">
   <thead>
  		<tr class="titulos">
                <td> <xsl:value-of select="document($doc)/translation/texts/item[@name='producto_proveedor']/node()"/></td>
                <td class="dies"> <xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica_2line']/node()"/></td>
                
                <td class="dies"> <xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva_2line']/node()"/></td>
                
                <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_iva_incl_2line']/node()"/></td>
                
                <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_actual_iva_incl_2line']/node()"/></td>
                
                <td class="dies"> <xsl:value-of select="document($doc)/translation/texts/item[@name='comision_mvm_16iva_2line']/node()"/></td>
                
                <td class="dies"> <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_total']/node()"/></td>
                
                <td class="dies"> <xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_neto']/node()"/></td>
		</tr>
    </thead>
        <xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA">
       <tr class="familia noChange">
                      <td>
                        <strong>&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/></strong> 
                      </td>
                      <td colspan="5">
                        <xsl:value-of select="@nombre"/>
                      </td>
                   
		</tr>
      	<xsl:for-each select="./SUBFAMILIA">
       <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	       <!--idioma fin-->
      	<tr class="subFamilia noChange">
      		 <td>
      			&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/>
             </td>
             <td colspan="5">
      			<xsl:value-of select="@nombre"/>
                &nbsp;&nbsp;&nbsp;&nbsp;[<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>-->ultima ref usada: <xsl:value-of select="REFESTANDARMAX"/>]
      		 </td>
		</tr>
      	<xsl:for-each select="./PRODUCTOESTANDAR">
       <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	       <!--idioma fin-->
          <tr>
                    	    <td class="dies">
                    	  		<xsl:choose>
                    	  			<xsl:when test="ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
                        				<!--<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');"  onMouseOver="window.status='Activa el Producto Estándar';return true;" onMouseOut="window.status='';return true;">-->
                        				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><xsl:value-of select="REFERENCIA"/></b>
                        				<!--</a>-->
                        			</xsl:when>
                        			<xsl:otherwise>
                        				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><xsl:value-of select="REFERENCIA"/></b>
                        			</xsl:otherwise>
                        		</xsl:choose>
								<xsl:if test="SIN_PLANTILLAS">
 									<font color="red">!!</font>
								</xsl:if>
                    	  	</td>
                    	  	<td colspan="2" align="left">
                    	  		<xsl:choose>
                    	  			<xsl:when test="ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
                        				<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');"  onMouseOver="window.status='Activa el Producto Estándar';return true;" onMouseOut="window.status='';return true;" class="noDecor">
                        				&nbsp;<xsl:value-of select="NOMBRE"/>
                        				</a>
                        			</xsl:when>
                        			<xsl:otherwise>
                        				<xsl:value-of select="NOMBRE"/>
                        			</xsl:otherwise>
                        		</xsl:choose>
                    	  	</td>
                            <td colspan="3">&nbsp;</td>
                </tr>
             <!--fin de una riga--> 	  
            	<tr>
                	<td align="center" colspan="2">
                		<!-- nacho mostramos todos los proveedores -->
                		<xsl:choose>
                			<xsl:when test="PROVEEDOR">
								<!--	12mar08	ET	añadimos las plantillas en las que está incluido el producto	-->
                				<table width="100%" cellpadding="1" cellspacing="1" align="center">
                					<xsl:for-each select="PROVEEDOR">
                						<xsl:choose>
                							<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ORIGEN_PRECIOREF='C'">
                								
                											<xsl:for-each select="CENTROS/CENTRO">
                												<tr>
                													<!-- el proveedor -->
                													<td width="110px" align="right">
                														<xsl:value-of select="../../NOMBRE"/>
                													</td>
                													<!-- la referencia -->
                													<td width="*">
                														(<xsl:value-of select="../../REFERENCIA"/>)
                														&nbsp;
                    												<xsl:if test="PROV_ANTERIOR!=''">
                    													[<xsl:value-of select="PROV_ANTERIOR"/>]
                    												</xsl:if>	
                													</td>
                													<!-- centro -->
                													<td width="110px" align="right">
                														<xsl:choose>
                															<xsl:when test="NOMBRECORTO!=NOMBRE and NOMBRECORTO!=''">
                																<xsl:value-of select="NOMBRECORTO"/>
                															</xsl:when>
                															<xsl:otherwise>
                																<xsl:value-of select="NOMBRE"/>
                															</xsl:otherwise>
                														</xsl:choose>
                													</td>
                												</tr>
                											</xsl:for-each>
                									
                							</xsl:when>
                							<xsl:otherwise>
                									<tr>
                									<!-- el proveedor -->
                										<td width="110px" align="right">
                											<xsl:value-of select="NOMBRE"/>
                										</td>
                									<!-- la referencia -->
                										<td width="*">
                											<xsl:if test="REFERENCIA!=''">
                												(<xsl:value-of select="REFERENCIA"/>)
                											</xsl:if>
                											&nbsp;
                    									<xsl:if test="PROV_ANTERIOR!=''">
                    										[<xsl:value-of select="PROV_ANTERIOR"/>]
                    									</xsl:if>	
                										</td>
                									</tr>
                								</xsl:otherwise>
                							</xsl:choose>
                					</xsl:for-each>
                				</table>
                			</xsl:when>
                			<xsl:otherwise>
                				<font color="red">
                                no adjudicado
                                	<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='no_adjudicado']/node()"/>-->
                				</font>
                			</xsl:otherwise>
                		</xsl:choose>
                		</td>
                		<td>
                			<xsl:choose>
                				<xsl:when test="PROVEEDOR">
                					<table width="100%" cellpadding="1" cellspacing="1" align="center">
                						<xsl:for-each select="PROVEEDOR">
                							<xsl:choose>
                								<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ORIGEN_PRECIOREF='C'">
                									<tr>
                										<td>
                											<table width="100%" cellpadding="0" cellspacing="0" border="0">
                												<xsl:for-each select="CENTROS/CENTRO">
                													<tr>
                														<td align="center" width="*">
                															<xsl:value-of select="../../UNIDADBASICA"/>&nbsp;
                														</td>
                													</tr>
                												</xsl:for-each>
                											</table>
                										</td>
                									</tr>
                								</xsl:when>
                								<xsl:otherwise>
                										<tr>
                											<td align="center" width="*">
                												<xsl:value-of select="UNIDADBASICA"/>
                											</td>
                										</tr>
                									</xsl:otherwise>
                								</xsl:choose>
                						</xsl:for-each>
                					</table>
                				</xsl:when>
                				<xsl:otherwise>
                					-
                				</xsl:otherwise>
                			</xsl:choose>
                		</td>
                	<td>
                		<xsl:choose>
                			<xsl:when test="PROVEEDOR">
                				<table>
                					<xsl:for-each select="PROVEEDOR">
                						<tr>
 											<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
											<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                								<td class="doce">
                									T:<xsl:value-of select="TIPOIVA"/>&nbsp;
												</td>
											</xsl:if>
                							<!-- precio historico -->
                							<td>
											<xsl:choose>
                								<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ORIGEN_PRECIOREF='C'">
                									<table>
                									<xsl:for-each select="CENTROS/CENTRO">
                										<tr>
                											<td>
                												<!--<xsl:value-of select="PRECIOHISTORICO"/>&nbsp;-->

                												<xsl:choose>
                    											<xsl:when test="PRECIOHISTORICO!=''">
                    											    <!--	22mar07	ET	-->
																	<xsl:if test="ARBITRARIO='S'">
                    											    	(!)
                    											    </xsl:if>
                    											  <xsl:choose>
                    											    <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC">
                    											      <a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({../../../ID},\'CAMBIOPRODUCTOESTANDAR\');');MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantCentrosCatalogoFrame.xsql?CENTROPRODUCTO_ID={ID}&amp;ACCION=MODIFICARCENTRO&amp;IDPRODUCTOESTANDAR={../../../ID}','centrosCatalogo');">
                    											    
																			<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																			<xsl:choose>
																				<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        						<xsl:value-of select="PRECIOHISTORICO"/>
																				</xsl:when>
																				<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        						<xsl:value-of select="PRECIOHISTORICO_IVA"/>
																				</xsl:when>
 																			</xsl:choose>
                    											    	</a>
                    											    </xsl:when>
                    											    <xsl:otherwise>
																		<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																		<xsl:choose>
																			<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        					<xsl:value-of select="PRECIOHISTORICO"/>
																			</xsl:when>
																			<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        					<xsl:value-of select="PRECIOHISTORICO_IVA"/>
																			</xsl:when>
 																		</xsl:choose>
                    											    </xsl:otherwise>
                    											  </xsl:choose>   
                    											</xsl:when>
                    											<xsl:otherwise>
                    											  <xsl:choose>
                    											    <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC">
                    											      <a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({../../../ID},\'CAMBIOPRODUCTOESTANDAR\');');MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantCentrosCatalogoFrame.xsql?IDNUEVOCENTRO=0&amp;ACCION=NUEVOCENTRO&amp;IDPRODUCTOESTANDAR={../../../ID}','centrosCatalogo');">
                    											        <font color="red">
                															<xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
                    											         </font>
                    											      </a>
                    											    </xsl:when>
                    											    <xsl:otherwise>
                    											      <font color="red">
                														<xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
                    											    </font>
                    											    </xsl:otherwise>
                    											  </xsl:choose>   
                    											</xsl:otherwise>
                	  										</xsl:choose>
                											</td>
                										</tr>
                									</xsl:for-each>
                									</table>
                								</xsl:when>
                								<xsl:otherwise>
                									<!-- calculos de ahorro por empresa -->
                	  								<xsl:choose>
                    									<xsl:when test="PRECIOHISTORICO!=''">
                    									  <xsl:choose>
                    								    	<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC and ../ID!=''">
                    								    	  <a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({../ID},\'CAMBIOPRODUCTOESTANDAR\');');MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR={../ID}&amp;ACCION=MODIFICARPRODUCTOESTANDAR&amp;VENTANA=NUEVA','productoestandar');">
                    								    	  	<xsl:if test="ARBITRARIO='S'">
                    											   		(<span class="camposObligatorios">!</span>)
                    											</xsl:if>
																<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																<xsl:choose>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        			<xsl:value-of select="PRECIOHISTORICO"/>
																	</xsl:when>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        			<xsl:value-of select="PRECIOHISTORICO_IVA"/>
																	</xsl:when>
 																</xsl:choose>
                    								    	  </a>
                    								    	</xsl:when>
                    								    	<xsl:otherwise>
																<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																<xsl:choose>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        			<xsl:value-of select="PRECIOHISTORICO"/>
																	</xsl:when>
																	<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        			<xsl:value-of select="PRECIOHISTORICO_IVA"/>
																	</xsl:when>
 																</xsl:choose>
                    								    	</xsl:otherwise>
                    									  </xsl:choose>   
                    									</xsl:when>
                    									<xsl:otherwise>
                    									  <xsl:choose>
                    								    	<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC and ../ID!=''">
                    								    	  <a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({../ID},\'CAMBIOPRODUCTOESTANDAR\');');MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR={../ID}&amp;ACCION=MODIFICARPRODUCTOESTANDAR&amp;VENTANA=NUEVA','productoestandar');">
                    								        	<font color="red">
                    								        	  <xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
                    								        	 </font>
                    								    	  </a>
                    								    	</xsl:when>
                    								    	<xsl:otherwise>
                    								    	  <font color="red">
                    								        	  <xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
                    								        </font>
                    								    	</xsl:otherwise>
                    									  </xsl:choose>   
                    									</xsl:otherwise>
                	  								</xsl:choose>

                								</xsl:otherwise>
              								</xsl:choose>
                							</td>
                						</tr>
                					</xsl:for-each>
                				</table>
                			</xsl:when>
                			<xsl:otherwise>
                				-
                			</xsl:otherwise>
                		</xsl:choose>
                	</td>
                	<td>
                	  <xsl:choose>
                			<xsl:when test="PROVEEDOR">
                				<table>
                					<xsl:for-each select="PROVEEDOR">
                						<tr>
                							<td>
                								<xsl:choose>
                									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ORIGEN_PRECIOREF='C'">
                										<xsl:for-each select="CENTROS/CENTRO">
 												<!--Distinguimos entre el listado normal de precios y el de comisiones-->
																	<xsl:choose>
																		<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        				<xsl:value-of select="PRECIOACTUAL"/>
																		</xsl:when>
																		<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        				<xsl:value-of select="PRECIOACTUAL_IVA"/>
																		</xsl:when>
 																	</xsl:choose>
               												
                										</xsl:for-each>
                									</xsl:when>
                									<xsl:otherwise>
 												<!--Distinguimos entre el listado normal de precios y el de comisiones-->
														<xsl:choose>
															<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                    								        	<xsl:value-of select="PRECIOACTUAL"/>
															</xsl:when>
															<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                    								        	<xsl:value-of select="PRECIOACTUAL_IVA"/>&nbsp;
															</xsl:when>
 														</xsl:choose>
                									</xsl:otherwise>
                								</xsl:choose>
                								
                							</td>
                						</tr>
                					</xsl:for-each>
                				</table>
                			</xsl:when>
                			<xsl:otherwise>
                				-
                			</xsl:otherwise>
                		</xsl:choose>
                	</td>
                	<td align="center" width="12%">
                	  <xsl:choose>
                			<xsl:when test="PROVEEDOR">
                				<table width="100%" cellpadding="1" cellspacing="1" align="center">
                					<xsl:for-each select="PROVEEDOR">
                						<tr>
                							<!-- ahorro -->
                							<td align="center" width="*">
                							
                							
                								<xsl:choose>
                									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ORIGEN_PRECIOREF='C'">
                										<table width="100%" cellpadding="0" cellspacing="0" border="0">
                										<xsl:for-each select="CENTROS/CENTRO">
                											<tr>
 																<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                													<td align="center" width="12%">
                														CT:<xsl:value-of select="COMISION_IVA"/>&nbsp;
																	</td>
																</xsl:if>
                												<td>
 																	<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
																	<xsl:choose>
																		<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                															<xsl:value-of select="AHORRO"/>&nbsp;
																		</xsl:when>
																		<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                															AN:<xsl:value-of select="AHORRO_NETO"/>&nbsp;
																		</xsl:when>
 																	</xsl:choose>
                												</td>
                											</tr>
                										</xsl:for-each>
                										</table>
                									</xsl:when>
                									<xsl:otherwise>
														<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
														<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                											<td align="center" width="12%">
                												CT:<xsl:value-of select="COMISION_IVA"/>&nbsp;
															</td>
														</xsl:if>
 														<!--	Distinguimos entre el listado normal de precios y el de comisiones-->
														<xsl:choose>
															<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='P'">
                												<xsl:value-of select="AHORRO"/>&nbsp;
															</xsl:when>
															<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODO='Comisiones'">
                												AN:<xsl:value-of select="AHORRO_NETO"/>&nbsp;
															</xsl:when>
 														</xsl:choose>
                									</xsl:otherwise>
                								</xsl:choose>
                							</td>
                						</tr>
                					</xsl:for-each>
                				</table>
                			</xsl:when>
                			<xsl:otherwise>
                				-
                			</xsl:otherwise>
                		</xsl:choose>
                	</td>
				</tr>
				
        </xsl:for-each>
        
      </xsl:for-each>
    </xsl:for-each>
  </table>
</xsl:template><!--fin modoComisiones-->

<!--modoPExc -->
<xsl:template name="modoPExc">
  <table class="grandeInicio">
   <thead>
  		<tr class="titulos">
                <td align="left" colspan="2" width="*">  <xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></td>
                <td align="center" width="*">  <xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
                <td align="center" width="*">  <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
                <td align="center" width="15%">  <xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
                <td align="center" width="12%">  <xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico']/node()"/><span class="camposObligatorios">*</span></td>
                <td align="center" width="12%">  <xsl:value-of select="document($doc)/translation/texts/item[@name='precio_actual']/node()"/><span class="camposObligatorios">**</span></td>
                <td align="center" width="12%">  <xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></td>
		</tr>
    </thead>
  </table>
</xsl:template><!--fin modoPExc-->
<!--modoPP Proveedores-->
<xsl:template name="modoPP">
  <table class="grandeInicio">
  <thead>
  		<tr class="titulos">
                 <td colspan="3">&nbsp;</td>
                
          		<xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/COLUMNAS/COLUMNA">
                	<td align="center" colspan="3" class="borderLeft borderRight">
                	  <xsl:value-of select="TITULO1"/>&nbsp;</td>
				</xsl:for-each>
                <td>&nbsp;</td>
				</tr>
            <tr class="subTituloTabla">
            	<td class="dies textleft">&nbsp;&nbsp;Ref.</td>
                <td class="textLeft">  <xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
                <td>&nbsp;  <xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>&nbsp;</td>
          		<xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/COLUMNAS/COLUMNA">
                	<td class="borderLeft ocho"><xsl:value-of select="TITULO2"/>&nbsp;</td>
                	<td class="ocho">
                	  <xsl:value-of select="TITULO3"/>&nbsp;</td>
                	<td class="borderRight ocho">
                	  <xsl:value-of select="TITULO4"/>&nbsp;</td>
				</xsl:for-each>
                <td>&nbsp;Ahorro&nbsp;</td>
                
		</tr>
    </thead>
      <xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA">
       <tr class="familia noChange">
                     <td>
                        <strong>&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/></strong> 
                     </td>
                      <td>
                      	<xsl:attribute name="colspan">
                        	<xsl:variable name="numCol" select="../COLUMNAS/NUMERO"/>
                            <xsl:variable name="numOK" select="$numCol * 3 + 3"/>
                    		<xsl:value-of select="$numOK"/>
                        </xsl:attribute>
                        &nbsp;<xsl:value-of select="@nombre"/>
                      </td>
                   
		</tr>
      	<xsl:for-each select="./SUBFAMILIA">
      	<tr class="subFamilia noChange">
        	<td class="textLeft">
            	&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/>
            </td>
      		<td>
              	<xsl:attribute name="colspan">
                        	<xsl:variable name="numCol" select="../../COLUMNAS/NUMERO"/>
                            <xsl:variable name="numOK" select="$numCol * 3 + 3"/>
                    		<xsl:value-of select="$numOK"/>
                        </xsl:attribute>
      			
      			<xsl:value-of select="@nombre"/>
                &nbsp;&nbsp;&nbsp;&nbsp;[<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>
: <xsl:value-of select="REFESTANDARMAX"/>]
      		 </td>
		</tr>
      	<xsl:for-each select="./PRODUCTOESTANDAR">
    		<tr>
                	<td class="textLeft">
                    	  	&nbsp;&nbsp;
                            <xsl:choose>
                    	  		<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
                        	  		<b><xsl:value-of select="REFERENCIA"/></b>
                        		</xsl:when>
                        		<xsl:otherwise>
                        			<b><xsl:value-of select="REFERENCIA"/></b>
                        		</xsl:otherwise>
                        	</xsl:choose>
                    </td>
                    <td class="textLeft">	
                    	<strong>
                        	<xsl:choose>
                    	  		<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
                        			<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');"  onMouseOver="window.status='Activa el Producto Estándar';return true;" onMouseOut="window.status='';return true;" class="noDecor">
                        	  		<xsl:value-of select="NOMBRE"/>
                        			</a>
                        		</xsl:when>
                        		<xsl:otherwise>
                        			<xsl:value-of select="NOMBRE"/>
                        		</xsl:otherwise>
                        	</xsl:choose>
                    	</strong>
                	</td>
                	<td>
                	  <xsl:value-of select="CONSUMO"/>
                	</td>
          			<xsl:for-each select="./PROVEEDOR">
                		<td class="borderLeft">
                		  <xsl:value-of select="NOMBRECORTO"/></td>
                		<td>
                		  <xsl:value-of select="REFERENCIA"/></td>
                		<td class="borderRight">
                		  <xsl:value-of select="PRECIO"/></td>
					</xsl:for-each>
                    <td>&nbsp;</td>
				</tr>
    	</xsl:for-each>
       </xsl:for-each>
      </xsl:for-each>
  </table>
</xsl:template><!--fin modoPP-->
<!--modoCP centros centrosporproducto.xsql-->
<xsl:template name="modoCP">
 <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	       <!--idioma fin-->
 <table class="grandeInicio">
  <thead>
        <tr class="titulos">
        		<td class="dies textLeft">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>
.</td>
                <td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
</td>
                <td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>
</td>
                <td colspan="3" class="borderLeft borderRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
                <td colspan="3"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
          		<!--<xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/COLUMNAS/COLUMNA">
                	<td class="seis"><xsl:value-of select="TITULO2"/></td>
                	<td class="seis"><xsl:value-of select="TITULO3"/></td>
                	<td class="seis"><xsl:value-of select="TITULO4"/></td>
				</xsl:for-each>-->
		</tr>
   </thead>
      <xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA">
       <tr class="familia noChange">
                      
                      <!--	<xsl:attribute name="colspan">
                        	<xsl:variable name="numCol" select="../COLUMNAS/NUMERO"/>
                            <xsl:variable name="numOK" select="$numCol * 3 + 4"/>
                    		<xsl:value-of select="$numOK"/>
                        </xsl:attribute>-->
                      <td class="textLeft">
                        <strong>&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/></strong>
                      </td>
                      <td colspan="8">
                        <xsl:value-of select="@nombre"/>
                      </td>
                   
		</tr>
      	<xsl:for-each select="./SUBFAMILIA">
      	<tr class="subFamilia noChange">
                      <!--	<xsl:attribute name="colspan">
                        	<xsl:variable name="numCol" select="../COLUMNAS/NUMERO"/>
                            <xsl:variable name="numOK" select="$numCol * 3 + 4"/>
                    		<xsl:value-of select="$numOK"/>
                        </xsl:attribute>-->
      			 <td class="textLeft">
                        <strong>&nbsp;&nbsp;&nbsp;<xsl:value-of select="@referencia"/></strong>
                      </td>
                 <td colspan="8">
      			<xsl:value-of select="@nombre"/>
                &nbsp;&nbsp;&nbsp;&nbsp;[<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>: <xsl:value-of select="REFESTANDARMAX"/>]
      		 </td>
		</tr>
      	<xsl:for-each select="./PRODUCTOESTANDAR">
   			<tr>
                	<td class="textLeft">
                    	  	<xsl:choose>
                    	  		<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
                        	  		&nbsp;&nbsp;&nbsp;<b><xsl:value-of select="REFERENCIA"/></b>
                        		</xsl:when>
                        		<xsl:otherwise>
                        			&nbsp;&nbsp;&nbsp;<b><xsl:value-of select="REFERENCIA"/></b>
                        		</xsl:otherwise>
                        	</xsl:choose>
                        	
                    	  </td>
                    	  <td class="textLeft">
                          	<strong>
                    	  	<xsl:choose>
                    	  		<xsl:when test="/FamiliasYProductos/VENTANA!='NUEVA'">
                        			<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual({ID},\'CAMBIOPRODUCTOESTANDAR\');');"  onMouseOver="window.status='Activa el Producto Estándar';return true;" onMouseOut="window.status='';return true;" class="noDecor">
                        	  		&nbsp;<xsl:value-of select="NOMBRE"/>
                        			</a>
                        		</xsl:when>
                        		<xsl:otherwise>
                        			&nbsp;<xsl:value-of select="NOMBRE"/>
                        		</xsl:otherwise>
                        	</xsl:choose>
                    		</strong>
                	</td>
                	<td>
                	  <xsl:value-of select="CONSUMO"/>&nbsp;
                	</td>
                    <xsl:choose>
                    <xsl:when test="count(./CENTRO) = 2">
                        <xsl:for-each select="./CENTRO">
                            <td class="borderLeft">
                              <xsl:value-of select="NOMBRECORTO"/>&nbsp;</td>
                            <td>
                              <xsl:value-of select="REFERENCIA"/>&nbsp;</td>
                            <td>
                              <xsl:value-of select="PRECIO"/>&nbsp;</td>
                        </xsl:for-each>
                   </xsl:when>
                   <xsl:when test="count(./CENTRO) = 1">
                        <xsl:for-each select="./CENTRO">
                            <td class="borderLeft">
                              <xsl:value-of select="NOMBRECORTO"/>&nbsp;</td>
                            <td>
                              <xsl:value-of select="REFERENCIA"/>&nbsp;</td>
                            <td class="borderRight">
                              <xsl:value-of select="PRECIO"/>&nbsp;</td>
                        </xsl:for-each>
                        <td colspan="3">&nbsp;</td>
                   </xsl:when>
                   <xsl:otherwise><td colspan="6">&nbsp;</td></xsl:otherwise>
                   </xsl:choose>
				</tr>
         </xsl:for-each>
         </xsl:for-each>
         </xsl:for-each>
   </table>
</xsl:template><!--fin de modoCP-->
<!--modoM - modelo pedidos buscador-->
<xsl:template name="modoM">
 <table class="grandeInicio">
  <thead>
  		<tr class="titulos">
                 <td class="sesanta"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
                 <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
                 <td class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='unidad_basica_2line']/node()"/></td>
                 <td class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote_2line']/node()"/></td>
                 <td class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_euros_2line']/node()"/></td>
		</tr>
   </thead>
   </table>
</xsl:template><!--fin de modoM-->
	
  
</xsl:stylesheet>
