<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Presentacion de datos de Concursos Sanitarios en forma matricial
 |
 |	(c) 26/11/2003 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  	<xsl:param name="lang" select="@lang"/>  
  	<xsl:template match="/">
    <html>
      <head>
     
	<title>Sistema de Informacion para la Direccion (E.I.S.) - Concursos Sanitarios</title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    
	<xsl:text disable-output-escaping="yes">
	<![CDATA[	
	
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript


   // nacho 10.9.2003
   // generamos codigo javascript dinamicamente
   // si el parametro XSQL  "MOSTRAR_ALERTA=S"
   // escribimos la llamada a la funcion MostrarAlerta
   // que será ejecutada al ser leida por el navegador durante la carga de la pagina (anterior al metodo onLoad del BODY)

  ]]></xsl:text>
    <xsl:if test="//MOSTRAR_ALERTA='S'">
    MostrarAlerta('Aviso','<xsl:value-of select="//CODIGO_MENSAJE"/>');
    </xsl:if>
  <xsl:text disable-output-escaping="yes"><![CDATA[	
  


	function MostrarPosiciones(){	//	Posiciones relativas de los conceptos
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Gestion/EIS/EISPosiciones.xsql?'
				+'SES_ID='+form.elements['OR_SES_ID'].value
				+'&'+'IDCUADROMANDO='+form.elements['OR_IDCUADRO'].value
				+'&'+'ANNO='+form.elements['OR_ANNO'].value
				+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
				+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
				+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
				+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
				+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
				+'&'+'IDFAMILIA='+form.elements['OR_IDFAMILIA'].value
				+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
				+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
				+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
				+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
				+'&'+'IDRESULTADOS='+form.elements['OR_IDRESULTADOS'].value
				+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
				+'&'+'IDRATIO='+form.elements['OR_IDRATIO'].value;
		
		//alert (Enlace);
				
	  MostrarPag(Enlace, 'Posiciones');
	}
	
	//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
	
	function MostrarListado(Indicador, Grupo, Anno, Mes)
	{
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Gestion/EIS/EISListado.xsql?'
				+'US_ID='+form.elements['OR_US_ID'].value
				+'&'+'IDINDICADOR='+Indicador
				+'&'+'ANNO='+Anno
				+'&'+'MES='+Mes
				+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
				+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
				+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
				+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
				+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
				+'&'+'IDFAMILIA='+form.elements['OR_IDFAMILIA'].value
				+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
				+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
				+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
				+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
				//+'&'+'IDNOMENCLATOR='+
				//+'&'+'URGENCIA='+
				+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
				+'&'+'IDGRUPO='+Grupo;
				
		//alert (Enlace);
		
		//alert('IDINDICADOR='+Indicador+' ANNO='+Anno+' MES='+Mes);
				
		//MostrarPag(Enlace, 'Listado');
	}
	
	
	function MostrarEISMatrizConcursos()
	{
	  MostrarPag('http://www.newco.dev.br/Gestion/EIS/EISMatrizConcursos.xsql', 'Consulta');
	}
	
	//	Solo para pruebas con XML -> Algunos parametros no se pueden modificar
	function MostrarXML()
	{
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Gestion/EIS/EISMatrizConcursosXML.xsql?'
				//+'SES_ID='+form.elements['SES_ID'].value
				//+'&'
				+'IDCUADROMANDO='+form.elements['IDCUADROMANDO'].value
				+'&'+'ANNO='+form.elements['ANNO'].value
				+'&'+'IDEMPRESA='+form.elements['IDEMPRESA'].value
				+'&'+'IDCENTRO='+form.elements['IDCENTRO'].value
				+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
				+'&'+'IDEMPRESA2='+form.elements['IDEMPRESA2'].value
				+'&'+'IDPRODUCTO='+form.elements['IDPRODUCTO'].value
				+'&'+'IDFAMILIA='+form.elements['IDFAMILIA'].value
				+'&'+'IDESTADO='+form.elements['IDESTADO'].value
				+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
				+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
				+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
				+'&'+'IDRESULTADOS='+form.elements['IDRESULTADOS'].value
				+'&'+'AGRUPARPOR='+form.elements['AGRUPARPOR'].value
				+'&'+'IDRATIO='+form.elements['IDRATIO'].value;
				
		MostrarPag(Enlace, 'Prueba');
	}
       
	//	Abre una pagina con la ficha del grupo seleccionado
	function MostrarFichaAgrupacion(ID)
	{
		var Enlace;
		var Presentar=true;
		var form=document.forms[0];
		
		switch (form.elements['OR_AGRUPARPOR'].value)
		{
			case 'EMP2': Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?VENTANA=NUEVA&EMP_ID=';
						break;
			case 'CEN': Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID=';
						break;
			case 'PRO': Enlace='http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=';
						break;
			case 'USU': Enlace='Usuario';
						Presentar=false;
						break;
			case 'REF': Enlace='Referencia';
						Presentar=false;
						break;
			case 'FAM': Enlace='Familia';
						Presentar=false;
						break;
			case 'EST': Enlace='Estado';
						Presentar=false;
						break;
			default:	Enlace=form.elements['OR_AGRUPARPOR'].value;
						Presentar=false;
						break;
						
		}

		//alert(Enlace+':'+form.elements['AGRUPARPOR'].value+':'+ID);
		

		if (Presentar==false)				
			alert('No hay una ficha definida agrupando por '+Enlace)
		else{
		      if(form.elements['OR_AGRUPARPOR'].value=='EMP2'){
		        MostrarPagPersonalizada(Enlace+ID,'Ficha',65,58,0,-50);
		      }
		      else{
			if(form.elements['OR_AGRUPARPOR'].value=='PRO'){
		          MostrarPagPersonalizada(Enlace+ID,'Ficha',70,50,0,-50);
		        }
		        else{
			  MostrarPag(Enlace+ID, 'Ficha');
			}
	              }
		    }
	}
	//-->
	</script>
	
	]]>
	</xsl:text>	
    </head>
    <body>
		<!--	Comprueba si la sesión ha caducado	-->
	<xsl:choose>
        <xsl:when test="//SESION_CADUCADA">
        	<xsl:apply-templates select="//SESION_CADUCADA"/> 
        </xsl:when>
		<xsl:otherwise>
	    <!-- Cabecera -->
	  	<form method="post" action="EISMatrizConcursos.xsql"><!--?xml-stylesheet=none-->
		<!--	Guardamos los valores originales en campos ocultos		- - >
       	<input type="hidden" name="Indicadores" value=""/>
       	<input type="hidden" name="OR_US_ID">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/US_ID"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_SES_ID">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/SES_ID"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDCUADRO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDCUADRO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_ANNO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/ANNO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDEMPRESA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDEMPRESA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDCENTRO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDCENTRO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDUSUARIOSEL">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDUSUARIOSEL"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDEMPRESA2">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDEMPRESA2"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDPRODUCTO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDPRODUCTO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDFAMILIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDFAMILIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDESTADO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDESTADO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDTIPOINCIDENCIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDTIPOINCIDENCIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDGRAVEDAD">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDGRAVEDAD"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDNOMENCLATOR">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDNOMENCLATOR"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_URGENCIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/URGENCIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_REFERENCIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/REFERENCIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDRESULTADOS">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDRESULTADOS"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_AGRUPARPOR">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/AGRUPARPOR"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDRATIO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDRATIO"/></xsl:attribute>
		</input>
		-->
       	<input type="hidden" name="OR_AGRUPARPOR">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/AGRUPARPOR"/></xsl:attribute>
		</input>
		<!--	Comprueba si no hay datos	-->
        <xsl:choose>
        <xsl:when test=" not (/EIS_XML/RESULTADOS/FILA/COLUMNA/TOTAL)">
		<br/>
		<center>La consulta no ha devuelto ningún dato. Pruebe a utilizar otras restricciones en la búsqueda.</center>
		<br/>
        <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" >
		<tr>
		<td align="center">
		<xsl:call-template name="botonPersonalizado">
			<xsl:with-param name="funcion">history.go(-1);</xsl:with-param>
			<xsl:with-param name="status">Volver a la página anterior</xsl:with-param>
			<xsl:with-param name="ancho">120px</xsl:with-param>
			<xsl:with-param name="label">Volver</xsl:with-param>
		</xsl:call-template>
		</td>
		<td>
		<xsl:call-template name="botonPersonalizado">
			<xsl:with-param name="funcion">window.close();</xsl:with-param>
			<xsl:with-param name="status">Cerrar la página</xsl:with-param>
			<xsl:with-param name="ancho">120px</xsl:with-param>
			<xsl:with-param name="label">Cerrar</xsl:with-param>
		</xsl:call-template>
		</td>
		<td>
		<xsl:call-template name="botonPersonalizado">
			<xsl:with-param name="funcion">MostrarEISMatrizConcursos();</xsl:with-param>
			<xsl:with-param name="status">Inicio</xsl:with-param>
			<xsl:with-param name="ancho">120px</xsl:with-param>
			<xsl:with-param name="label">Matriz EIS</xsl:with-param>
		</xsl:call-template>
		</td>
		</tr>
		</table>
        </xsl:when>
        <xsl:otherwise>
			<xsl:choose>
			<xsl:when test="/EIS_XML/RESULTADOS/EISSIMPLIFICADO">
				<p class="tituloPag" align="center"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/CUADRO"/></p>
        	</xsl:when>
        	<xsl:otherwise>
        		<table width="100%" class="muyoscuro" border="0" align="center" cellspacing="1" cellpadding="1" >
				<tr class="medio">
				<td align="center" colspan="7">
					<font color="#0"><b>......:::::: ConcursosSanitarios.com - Matriz de Datos ::::::......</b></font>
				</td></tr>
				<tr class="blanco"><td align="center" colspan="7">&nbsp;</td></tr>
	    		<tr align="center" class="blanco">
      				<xsl:for-each select="/EIS_XML/RESULTADOS/FILTROS/field">
						<xsl:choose> 
							<xsl:when test='(position() mod 2) and position()!=1'>
								<xsl:text disable-output-escaping="yes">
									<![CDATA[</tr><tr class="blanco">]]>
								</xsl:text>	
							</xsl:when> 
						</xsl:choose> 
						<xsl:choose>
						  <xsl:when test="count(/EIS_XML/RESULTADOS/FILTROS/field) mod 2!=0 and position()=last()">
				    		<td align="right" class="claro">
							<xsl:value-of select="./@label"/>:&nbsp;
				    		</td>
				    		<td align="left" class="blanco" colspan="3">
							<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select=".">
        						</xsl:with-param>
      				    		   </xsl:call-template>				
				    		</td>
						  </xsl:when>
						  <xsl:otherwise>
				    		<td align="right" class="claro" >
							<xsl:value-of select="./@label"/>:&nbsp;
				    		</td>
				    		<td align="left" class="blanco">
							<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select=".">
        						</xsl:with-param>
      				    		   </xsl:call-template>				
				    		</td>
						  </xsl:otherwise>
						</xsl:choose>

      				</xsl:for-each>
					<xsl:text disable-output-escaping="yes">
						<![CDATA[</tr>]]>
					</xsl:text>
					<tr class="blanco">
						<td width="10%" align="right" class="claro">
							<xsl:value-of select="/EIS_XML/RESULTADOS/AGRUPARPOR/field/@label"/>:&nbsp;
						</td>
						<td width="40%" align="left" class="blanco">
							<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/AGRUPARPOR/field">
        						</xsl:with-param>
      						</xsl:call-template>				
						</td>
						<td width="10%" align="right" class="claro">
							<xsl:value-of select="/EIS_XML/RESULTADOS/IDRESULTADOS/field/@label"/>:&nbsp;
						</td>
						<td width="40%" align="left" class="blanco">
							<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/IDRESULTADOS/field">
        						</xsl:with-param>
        						<xsl:with-param name="onChange">HabilitarRatios(document.forms[0],'RATIO','<xsl:value-of select="/EIS_XML/RESULTADOS/IDRESULTADOS/field/@name"/>','<xsl:value-of select="/EIS_XML/RESULTADOS/IDRATIO/field/@name"/>');</xsl:with-param>
      						</xsl:call-template>				
						</td>
					</tr>
					<tr class="blanco">
						<td align="center" width="10%" colspan="4">
							<br/>
        					<table width="*" bgColor="#015E4B" border="0" align="center" cellspacing="1" cellpadding="1" >
							<tr bgColor="#EEFFFF"><td>
							<a href="javascript:SubmitForm(document.forms[0])">Presentar el Cuadro de Mando</a>
							</td></tr>
							</table>
   						</td>
					</tr>


					<!--	Solo para pruebas!!!!!!!	- - >
					<tr class="blanco">
						<td align="center" width="10%" colspan="4">
							<br/>
        					<table width="*" bgColor="#015E4B" border="0" align="center" cellspacing="1" cellpadding="1" >
							<tr bgColor="#EEFFFF"><td>
							<a href="javascript:MostrarXML()">Presentar XML</a>
							</td></tr>
							</table>
   						</td>
					</tr>
					-->	
				</tr>
				</table>
    		</xsl:otherwise>
    		</xsl:choose>

			<br/>

        		<table width="100%" class="muyoscuro" border="0" align="center" cellspacing="1" cellpadding="1" >
	    		<tr align="center" class="medio">	 
					<td>&nbsp;</td>
      				<xsl:for-each select="/EIS_XML/RESULTADOS/CENTROS/CENTRO">
	      				<td width="2%"><p>
						<a>
							<xsl:attribute name="HREF">javascript:MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID=<xsl:value-of select="./ID"/>', 'Ficha');</xsl:attribute>
							<xsl:value-of select="./NOMBRE"/>&nbsp;
						</a>
						<!--	<xsl:value-of select="NOMBRE"/>-->
						</p></td>
      				</xsl:for-each>
				</tr>
      			<xsl:for-each select="/EIS_XML/RESULTADOS/FILA">
				<xsl:variable name="FILA">
					<xsl:value-of select="./ID"/>
				</xsl:variable>
	    		<tr align="left">	 
	      			<td class="medio"><p>
						<a>
							<xsl:attribute name="HREF">javascript:MostrarFichaAgrupacion('<xsl:value-of select="./ID"/>');</xsl:attribute>
							<xsl:value-of select="./NOMBRE"/>&nbsp;
						</a>
						<!--<xsl:value-of select="./NOMBRE"/>-->
					</p></td>
      				<xsl:for-each select="COLUMNA">
						<td align="right">
							<xsl:choose> 
							<xsl:when test='./FONDOBLANCO'>
								<xsl:attribute name="class">blanco</xsl:attribute>
							</xsl:when> 
							<xsl:when test='./FONDOCLARO'>
								<xsl:attribute name="class">claro</xsl:attribute>
							</xsl:when> 
							<xsl:when test='./FONDOMEDIO'>
								<xsl:attribute name="class">medio</xsl:attribute>
							</xsl:when> 
							<xsl:when test='./FONDOOSCURO'>
								<xsl:attribute name="class">oscuro</xsl:attribute>
							</xsl:when> 
							<xsl:otherwise>
								<xsl:attribute name="class">blanco</xsl:attribute>
							</xsl:otherwise>
							</xsl:choose> 
							<!-- El numero de mes ya no es necesario-->
							<!--[<xsl:value-of select="./MES"/>]-->
							<!-- todavia no funciona la pulsacion sobre una celda
							<a>
							<xsl:if test="./ROJO">
								<xsl:attribute name="style">color:#FF0000</xsl:attribute>
							</xsl:if>
					<xsl:choose> 
					<xsl:when test='./COLUMNA=13'>
							<xsl:attribute name="HREF">javascript:MostrarListado('<xsl:value-of select="$FILA"/>','<xsl:value-of select="./ANNO"/>','99');</xsl:attribute>
							<xsl:value-of select="./TOTAL"/>&nbsp;
					</xsl:when> 
					<xsl:otherwise>
							<xsl:attribute name="HREF">javascript:MostrarListado('<xsl:value-of select="$FILA"/>','<xsl:value-of select="./ANNO"/>','<xsl:value-of select="./MES"/>');</xsl:attribute>
							<xsl:value-of select="./TOTAL"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose> 
							</a>
							-->
							<a>
							<xsl:if test="./ROJO">
								<xsl:attribute name="style">color:#FF0000</xsl:attribute>
							</xsl:if>
							<xsl:attribute name="HREF">javascript:alert('Pendiente de implementar');</xsl:attribute>
							<xsl:value-of select="./TOTAL"/>&nbsp;
							</a>
						</td>
      				</xsl:for-each>
				</tr>
      			</xsl:for-each>
	    		<tr align="center" class="medio">	 
					<td>&nbsp;</td>
      				<xsl:for-each select="/EIS_XML/RESULTADOS/CENTROS/CENTRO">
	      				<td width="2%"><p>
							<xsl:value-of select="NOMBRE"/>
						</p></td>
      				</xsl:for-each>
				</tr>
				</table> 
				<br/><br/>
        </xsl:otherwise>
        </xsl:choose>
		</form>
      </xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
