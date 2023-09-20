<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
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
		//	Cambia el estado de una encuesta
 		function EstadoEncuesta(IDEncuesta, IDProveedor, Accion)
		{	
			var form=document.forms[0];
		
			//	Copiamos los datos de la encuesta seleccionada en los campos de intercambio
			document.getElementById('IDENCUESTA').value = IDEncuesta;
			document.getElementById('LISTAPROVEEDORES').value = IDProveedor;
			
			//	Ejecutamos la accion
			if (Accion=='ACTIVAR')
				document.getElementById('ESTADO').value = '';
			else if (Accion=='OCULTAR')
				document.getElementById('ESTADO').value = 'O';
			else if (Accion=='BORRAR')
				document.getElementById('ESTADO').value = 'B'; 
			else if (Accion=='REALIZADA')
				document.getElementById('ESTADO').value = 'R'; 
			
			//	Realizar accion
			document.getElementById('ACCION').value = 'CAMBIOESTADO';
			//alert(document.getElementById('REFERENCIA').value+','+document.getElementById('PRODUCTO').value+','+document.getElementById('PRECIO').value); 
			SubmitForm(form);
		}
		
		//	Crea la lista concatenada de proveedores
		function ListaProveedores()
		{					
			var form=document.forms[0],
				Lista='', 
				ID;

			for(var n=0;n<form.length;n++)
			{
				if(form.elements[n].name.match('CHK_IDPROVEEDOR_'))
				{
					if (form.elements[n].checked==true)
					{
						ID=Piece(form.elements[n].name ,'_',2);
						if (Lista!='')
						{
							Lista=Lista+'|';
						}
						Lista=Lista+ID;
					}
				}
			}
			
			//alert('ListaProveedores'+Lista);		//solodebug
			return(Lista);
		}
		
		//	Envia la nueva encuesta
		function NuevaEncuesta()
		{
			var form=document.forms[0];
			var MsgError='';
			var Destinatarios='';
			var Lista=ListaProveedores();

		
			//	Validar datos introducidos		
			if (Lista=='')	
				MsgError=MsgError+'Es necesario seleccionar el centro que debe completar la encuesta.\n';
			if (document.getElementById('NUEVA_PREGUNTA').value =='')	
				MsgError=MsgError+'El campo PREGUNTA es obligatorio\n';
		
			if ( MsgError!='')
			{
				alert(MsgError);
			}
			else
			{
				
				//	Copiamos los datos de la encuesta nueva
				document.getElementById('IDENCUESTA').value = '';
				document.getElementById('FECHA').value = '';
				document.getElementById('IDUSUARIO').value = '';
				document.getElementById('LISTAPROVEEDORES').value = Lista;
				document.getElementById('PREGUNTA').value = document.getElementById('NUEVA_PREGUNTA').value;
				document.getElementById('ESTADO').value = 'O';
				document.getElementById('ACCION').value = 'ENCUESTAS';
				document.getElementById('PAGINA').value = parseInt(document.getElementById('PAGINA').value);

				//alert (document.getElementById('LISTAPROVEEDORES').value+':'+Lista+' Pregunta:'+document.getElementById('PREGUNTA').value);

				//	Realizar accion
				SubmitForm(form);
			}
		}

		function RealizarAccion(accion)
		{ 
			var form=document.forms[0],
				Lista=ListaProveedores();
			
			if (ListaProveedores=='VACIO')
			{
				alert('La lista de proveedores no puede estar vacía');
			}
			else
			{
				document.getElementById('ACCION').value = accion;
				document.getElementById('LISTAPROVEEDORES').value = Lista;
				document.getElementById('PAGINA').value = 0;
				SubmitForm(form);
			}
		}

		function MostrarProveedores()		
		{
			var form=document.forms[0];
			
			document.getElementById('ACCION').value = 'MOSTRARPROVEEDORES';
			document.getElementById('PAGINA').value = 0;
			SubmitForm(form);
		}
		
		//	Elimina un centro dentro de una encuesta
		function EliminarCentro(IDEncuesta, IDProveedor)
		{
			var form=document.forms[0];
			
			document.getElementById('IDENCUESTA').value = IDEncuesta;
			document.getElementById('LISTAPROVEEDORES').value = IDProveedor;
			document.getElementById('ACCION').value = 'ELIMINARPROVEEDOR';

			SubmitForm(form);
		}
		
		function Atras()
		{
			var form=document.forms[0];
			document.getElementById('PAGINA').value = parseInt(document.getElementById('PAGINA').value)-1;
			document.getElementById('ACCION').value = 'FILTRAR';
			SubmitForm(form);
		}
		
		function Adelante()
		{
			var form=document.forms[0];
			document.getElementById('PAGINA').value =  parseInt(document.getElementById('PAGINA').value)+1;
			document.getElementById('ACCION').value = 'FILTRAR';
			SubmitForm(form);
		}
		

		function CopiarPregunta(linea_producto) 
		{
            document.getElementById('NUEVA_PREGUNTA').value=document.getElementById('PREGUNTA_'+linea_producto).value;
		}
		
		
		function MarcarTodosLosProveedores()
		{
			var form=document.forms[0],
				Valor='';
				
			for(var n=0;n<form.length;n++)
			{
				if(form.elements[n].name.match('CHK_IDPROVEEDOR_'))
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

		function CopiarEncuestas()
		{
			var form		=document.forms[0],
				MsgError	='',
				Lista		=ListaProveedores();
		
			//	Validar datos introducidos		
			if (ListaProveedores=='')	
				MsgError=MsgError+'Es necesario seleccionar al menos un centro para copiarle las encuestas.\n';
			if ( MsgError!='')
			{
				alert(MsgError);
			}
			else
			{
				if (confirm('¿Estás seguro de copiar las encuestas en los proveedores seleccionados?')==true)
				{
					document.getElementById('LISTAPROVEEDORES').value = Lista;
					document.getElementById('ACCION').value = 'COPIAR';
					SubmitForm(form);
				}
			}
		}	
		        -->
        </script>
        
        
        ]]></xsl:text>
      </head>
      <body>      
		<form action="MantenimientoEncuestasProveedoresSave.xsql" method="POST" name="form1">
		
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo -->
          <xsl:when test="Encuestas/xsql-error">
            <xsl:apply-templates select="Encuestas/xsql-error"/>          
          </xsl:when>
	
        <xsl:when test="Encuestas/ROW/Sorry">
          <xsl:apply-templates select="Encuestas/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
		
		<h1 class="titlePage">Mantenimiento de encuestas de proveedores (Encuestas encontradas: <xsl:value-of select="/MantenimientoEncuestas/ENCUESTAS/TOTAL"/>)</h1>
		
        <div class="divLeft">
		<!-- Campos ocultos para transmision de datos	-->
		<input type="hidden" id="IDENCUESTA" name="IDENCUESTA" value="" />
		<input type="hidden" id="FECHA"  name="FECHA" value="" />
		<input type="hidden" id="IDUSUARIO" name="IDUSUARIO" value="" />
		<input type="hidden" id="LISTAPROVEEDORES" name="LISTAPROVEEDORES" value="" />
		<input type="hidden" id="PREGUNTA" name="PREGUNTA" value="" />
		<input type="hidden" id="ESTADO" name="ESTADO" value="O" />
		<input type="hidden" id="ACCION" name="ACCION" value="" />
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/MantenimientoEncuestas/ENCUESTAS/FILTROS/PAGINA}" />
		<table class="grandeInicio" >
			<tr class="titulos">
				    	<td width="5%">Fecha</td>
				    	<td width="10%">Usuario</td>
				    	<td width="*%">Pregunta</td>
				    	<td width="20%">Prov. Encuestado</td>
								<td width="5%">Si</td>
								<td width="5%">No</td>
								<td width="15%">Comentarios</td>
				    	<td width="5%">Estado</td>
				    	<td width="2%">Activar</td>
				    	<td width="2%">Ocultar</td>
				    	<td width="2%">Borrar</td>
				    	<td width="2%">Hecho</td>
			      	</tr>
                	<tr class="medio" align="center">
				    	<td></td>
				    	<td></td>
				    	<td><input type="text" id="FPREGUNTA" name="FPREGUNTA" maxlength="20" size="10" value="{/MantenimientoEncuestas/ENCUESTAS/FILTROS/PRODUCTO}" /></td>
						<td>
							<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="FIDPROVEEDOR"/>
							<xsl:with-param name="path" select="/MantenimientoEncuestas/ENCUESTAS/FILTROS_DESPLEGABLES/FIDPROVEEDOR/field" />
							</xsl:call-template>
						</td>
				    	<td colspan="2">
							<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="FIDRESPUESTA"/>
							<xsl:with-param name="path" select="/MantenimientoEncuestas/ENCUESTAS/FILTROS_DESPLEGABLES/FIDRESPUESTA/field" />
							</xsl:call-template>
						</td>
				    	<td ></td>
				    	<td>
							<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="FIDESTADO"/>
							<xsl:with-param name="path" select="/MantenimientoEncuestas/ENCUESTAS/FILTROS_DESPLEGABLES/FIDESTADO/field" />
							</xsl:call-template>
						</td>
				    	<td colspan="4">
							<xsl:call-template name="botonPersonalizado">
							    <xsl:with-param name="funcion">RealizarAccion('FILTRAR');</xsl:with-param>
								<xsl:with-param name="ancho">80</xsl:with-param>
							    <xsl:with-param name="label">&nbsp;Filtrar&nbsp;</xsl:with-param>
	                            <xsl:with-param name="status">Filtrar encuestas</xsl:with-param>
							</xsl:call-template>
						</td>
			      	</tr>
                	<tr class="claro">
						<xsl:for-each select="MantenimientoEncuestas/ENCUESTAS/ENCUESTA">
						<tr class="claro" align="center">
							<td class="blanco"><xsl:value-of select="ENCP_FECHA"/><input type="hidden" id="FECHA_{ENCP_ID}" value="{ENCP_FECHA}" /></td>
							<td class="blanco"><xsl:value-of select="USUARIO"/><input type="hidden" id="IDUSUARIO_{ENCP_ID}" value="{ENCP_IDUSUARIO}" /></td>
							<td class="blanco" align="left"><a href="javascript:CopiarPregunta('{ENCP_ID}');"><xsl:value-of select="ENCP_PREGUNTA"/></a><input type="hidden" id="PREGUNTA_{ENCP_ID}" value="{ENCP_PREGUNTA}" /></td>
							<td align="left">
								&nbsp;<xsl:value-of select="PROVEEDOR"/><input type="hidden" id="IDProveedor_{ENCP_ID}_{ID}" value="{ID}" />
							</td>
							<xsl:choose>
								<xsl:when test="IDUSUARIO>0">
									<td width="5%"><xsl:value-of select="SI"/></td>
									<td width="5%"><xsl:value-of select="NO"/></td>
									<td width="35%">
										<xsl:value-of select="COMENTARIOS"/>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td colspan="2">
										Pendiente
									</td>
									<td>
										<table class="muyoscuro" border="0" cellpadding="1" cellspacing="1" width="20">
                              			<tbody>
										<tr>
                                			<td class="blanco" align="center" valign="middle">
												<a href="javascript:EliminarCentro('{ENCP_ID}','{IDPROVEEDOR}');" onmouseover="window.status='Eliminar proveedor';return true;" onmouseout="window.status=''; return true;"><font color="red">X</font></a>
                                 			</td>
		                            	</tr>
										</tbody>
										</table>
									</td>
								</xsl:otherwise>
							</xsl:choose>
							<td class="blanco"><xsl:value-of select="ESTADO"/><input type="hidden" id="ESTADO_{ENCP_ID}" value="{ENCP_ESTADO}" /></td>
							<td class="blanco">                           
								<table class="muyoscuro" border="0" cellpadding="1" cellspacing="1" width="20">
                              	<tbody><tr class="letrasRojas">
                                	<td class="blanco" align="center" valign="middle"><a href="javascript:EstadoEncuesta('{ENCP_ID}','{IDPROVEEDOR}','ACTIVAR');" onmouseover="window.status='Activar encuesta';return true;" onmouseout="window.status=''; return true;"><font color="black">A</font>
                                    </a>
                                 	</td>
		                            </tr></tbody>
								</table>
							</td>
							<td class="blanco">                           
								<table class="muyoscuro" border="0" cellpadding="1" cellspacing="1" width="20">
                              	<tbody><tr class="letrasRojas">
                                	<td class="blanco" align="center" valign="middle"><a href="javascript:EstadoEncuesta('{ENCP_ID}','{IDPROVEEDOR}','OCULTAR');" onmouseover="window.status='Ocultar encuesta';return true;" onmouseout="window.status=''; return true;"><font color="blue">O</font>
                                    </a>
                                 	</td>
		                            </tr></tbody>
								</table>
							</td>
							<td class="blanco">                           
								<table class="muyoscuro" border="0" cellpadding="1" cellspacing="1" width="20">
                              	<tbody><tr class="letrasRojas">
                                	<td class="blanco" align="center" valign="middle"><a href="javascript:EstadoEncuesta('{ENCP_ID}','{IDPROVEEDOR}','BORRAR');" onmouseover="window.status='Borrar encuesta';return true;" onmouseout="window.status=''; return true;"><font color="red">B</font>
                                    </a>
                                 	</td>
		                            </tr></tbody>
								</table>
							</td>
							<td class="blanco">                           
								<table class="muyoscuro" border="0" cellpadding="1" cellspacing="1" width="20">
                              	<tbody><tr class="letrasRojas">
                                	<td class="blanco" align="center" valign="middle"><a href="javascript:EstadoEncuesta('{ENCP_ID}','{IDPROVEEDOR}','REALIZADA');" onmouseover="window.status='Acción Realizada';return true;" onmouseout="window.status=''; return true;"><font color="green">R</font>
                                    </a>
                                 	</td>
		                            </tr></tbody>
								</table>
							</td>
						</tr>	
						</xsl:for-each>
			      	</tr>
				<tr><!--	Estadísticas de resumen		-->
					<td colspan="17" >
        				<table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="grisclaro">
            			<tr>
							<td align="center">
								<br/>
       							<table width="90%" border="0" align="center" cellspacing="0" cellpadding="0" >
            					<tr>
									<td align="center" colspan="2" class="medio">Estadísticas por proveedores</td>
								</tr>
								<xsl:for-each select="MantenimientoEncuestas/ENCUESTAS/ESTADISTICAS/ESTADISTICAS_PROVEEDORES/PROVEEDOR">
								<xsl:if test="ID!='-1'">
            						<tr class="claro">
										<td align="center"><xsl:value-of select="NOMBRE"/></td>
										<td align="center"><xsl:value-of select="TOTAL"/></td>
									</tr>
								</xsl:if>
								</xsl:for-each>
								</table>
								<br/>
							</td>
							<td align="center">
								<br/>
       							<table width="90%" border="0" align="center" cellspacing="0" cellpadding="0" >
            					<tr>
									<td align="center" colspan="2" class="medio">Estadísticas por estado</td>
								</tr>
								<xsl:for-each select="MantenimientoEncuestas/ENCUESTAS/ESTADISTICAS/ESTADISTICAS_ESTADOS/ESTADO">
								<xsl:if test="ID!='-1'">
            						<tr class="claro">
										<td align="center"><xsl:value-of select="NOMBRE"/></td>
										<td align="center"><xsl:value-of select="TOTAL"/></td>
									</tr>
								</xsl:if>
								</xsl:for-each>
								</table>
								<br/>
							</td>
							<td align="center">
								<br/>
       							<table width="90%" border="0" align="center" cellspacing="0" cellpadding="0" >
            					<tr>
									<td align="center" colspan="2" class="medio">Estadísticas por respuestas</td>
								</tr>
								<xsl:for-each select="MantenimientoEncuestas/ENCUESTAS/ESTADISTICAS/ESTADISTICAS_RESPUESTAS/RESPUESTA">
								<xsl:if test="ID!='-1'">
            						<tr class="claro">
										<td align="center"><xsl:value-of select="NOMBRE"/></td>
										<td align="center"><xsl:value-of select="TOTAL"/></td>
									</tr>
								</xsl:if>
								</xsl:for-each>
								</table>
								<br/>
							</td>
						</tr>
						</table>
			    	</td>
				</tr>
				<tr><td colspan="17">
        				<table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" >
            				<tr><td align="left">
								<xsl:if test="/MantenimientoEncuestas/ENCUESTAS/PAGINAANTERIOR">
									<xsl:call-template name="boton">
									<xsl:with-param name="path" select="/MantenimientoEncuestas/botones/button[@label='NavegarAtras']"/>
									</xsl:call-template>
								</xsl:if>
								</td>
								<td align="right">
								<xsl:if test="/MantenimientoEncuestas/ENCUESTAS/PAGINASIGUIENTE">
									<xsl:call-template name="boton">
									<xsl:with-param name="path" select="/MantenimientoEncuestas/botones/button[@label='NavegarAdelante']"/>
									</xsl:call-template>
								</xsl:if>
							</td></tr>
						</table>
		   			</td></tr>
				</table>
		    </td></tr>
			</table>
			<br/><br/><br/>
			<table width="95%" border="1" align="center" cellspacing="1" cellpadding="2" >
			<tr class="oscuro"><td class="medio">
        		<table width="100%" border="0" align="center" cellspacing="1" cellpadding="2">
                	<tr class="medio" align="center"> 
				    	<td colspan="2">Nueva encuesta</td>
					</tr>
					<tr class="claro">
						<td width="20%" align="right">Seleccionar Proveedores:&nbsp;
							<xsl:call-template name="botonPersonalizado">
							    <xsl:with-param name="funcion">MarcarTodosLosProveedores();</xsl:with-param>
								<xsl:with-param name="ancho">80</xsl:with-param>
							    <xsl:with-param name="label">&nbsp;Todos&nbsp;</xsl:with-param>
	                            <xsl:with-param name="status">Marcar todos los proveedores</xsl:with-param>
							</xsl:call-template>
						</td>
						<td align="left">
							<table width="100%" border="0" align="center" cellspacing="1" cellpadding="2">
							<tr>
							<xsl:for-each select="MantenimientoEncuestas/ENCUESTAS/PROVEEDORES/PROVEEDOR">
								<td>
								&nbsp;
								<input type="checkbox" name="CHK_IDPROVEEDOR_{ID}">
								<xsl:choose>
									<xsl:when test="MOSTRAR='S'">
										<xsl:attribute name="checked" value="true"/>
									</xsl:when>         
									<xsl:otherwise>
										<xsl:attribute name="unchecked" value="unchecked"/>
									</xsl:otherwise>
								</xsl:choose>
								</input>
								&nbsp;<xsl:value-of select="NOMBRE"/><input type="hidden" id="NUEVO_IDPROVEEDOR_{ID}" value="{ID}" />
								<xsl:if test="SALTO">
									<xsl:text disable-output-escaping="yes"><![CDATA[</tr><tr>	 ]]></xsl:text>
								</xsl:if>
								</td>
							</xsl:for-each>
							</tr>
							
							<tr>
								<td colspan="3">
								<table width="100%" border="0" align="center" cellspacing="1" cellpadding="2">
									<tr align="center"><td>
									<xsl:call-template name="botonPersonalizado">
							    		<xsl:with-param name="funcion">RealizarAccion('PROVEEDORESVISIBLES');</xsl:with-param>
										<xsl:with-param name="ancho">250</xsl:with-param>
							    		<xsl:with-param name="label">&nbsp;Dejar solo los proveedores marcados&nbsp;</xsl:with-param>
	                            		<xsl:with-param name="status">Dejar solo los proveedores marcados</xsl:with-param>
									</xsl:call-template>
									</td>
									<td>
									<xsl:call-template name="botonPersonalizado">
							    		<xsl:with-param name="funcion">RealizarAccion('QUITARPROVEEDORES');</xsl:with-param>
										<xsl:with-param name="ancho">250</xsl:with-param>
							    		<xsl:with-param name="label">&nbsp;Quitar los proveedores marcados&nbsp;</xsl:with-param>
	                            		<xsl:with-param name="status">Quitar los proveedores marcados</xsl:with-param>
									</xsl:call-template>
									</td>
									<td>
									<xsl:call-template name="botonPersonalizado">
							    		<xsl:with-param name="funcion">MostrarProveedores();</xsl:with-param>
										<xsl:with-param name="ancho">250</xsl:with-param>
							    		<xsl:with-param name="label">&nbsp;Mostrar proveedores ocultos&nbsp;</xsl:with-param>
	                            		<xsl:with-param name="status">Mostrar proveedores ocultos</xsl:with-param>
									</xsl:call-template>
									</td></tr>
								</table>
								</td>
							</tr>

							
							</table>
						</td>
					</tr>
					<tr class="claro"><td width="20%" align="right">Pregunta:&nbsp;</td><td align="left">&nbsp;<input type="text" id="NUEVA_PREGUNTA" maxlength="100" size="80" value="" /></td></tr>
                	<tr class="medio" align="center">
				    	<td colspan="2">
							<table class="medio" border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr>
							<td align="right">
							<xsl:call-template name="botonPersonalizado">
							    <xsl:with-param name="funcion">NuevaEncuesta()</xsl:with-param>
								<xsl:with-param name="ancho">200</xsl:with-param>
							    <xsl:with-param name="label">&nbsp;Guardar nueva encuesta&nbsp;</xsl:with-param>
	                            <xsl:with-param name="status">Guardar la nueva encuesta en los proveedores seleccionados</xsl:with-param>
							</xsl:call-template>
							</td>
							<td width="20px">&nbsp;</td>
							<td align="left">
							<xsl:call-template name="botonPersonalizado">
							    <xsl:with-param name="funcion">CopiarEncuestas()</xsl:with-param>
								<xsl:with-param name="ancho">200</xsl:with-param>
							    <xsl:with-param name="label">&nbsp;Copiar TODAS las encuestas&nbsp;</xsl:with-param>
	                            <xsl:with-param name="status">Copiar todas las encuestas a los proveedores seleccionados</xsl:with-param>
							</xsl:call-template>
							</td>
							</tr>
						    </table>
						</td>
					</tr>
				</table>
		   
               <br/><br/>
             </xsl:otherwise>
        </xsl:choose>
        </div>
		</form>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
