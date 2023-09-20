<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
       
	<title>Mantenimiento de encuestas (Encuestas encontradas: <xsl:value-of select="/MantenimientoEncuestas/ENCUESTAS/TOTAL"/>)&nbsp;<xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
        
       <script type="text/javascript">
	
	<!-- 
		//	Cambia el estado de una encuesta
 		function EstadoEncuesta(IDEncuesta, IDCentro, Accion)
		{	
			var form=document.forms[0];
		
			//	Copiamos los datos de la encuesta seleccionada en los campos de intercambio
			document.getElementById('IDENCUESTA').value = IDEncuesta;
			document.getElementById('LISTACENTROS').value = IDCentro;
			
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
		
		//	Crea la lista concatenada de centros
		function ListaCentros()
		{					
			var form=document.forms[0],
				Lista='', 
				ID;

			for(var n=0;n<form.length;n++)
			{
				if(form.elements[n].name.match('CHK_IDCENTRO_'))
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
			
			//alert('listaCentros:'+Lista);		//solodebug
			return(Lista);
		}
		
		//	Envia la nueva encuesta
		function NuevaEncuesta()
		{
			var form=document.forms[0];
			var MsgError='';
			var Destinatarios='';
			var listaCentros=ListaCentros();

		
			//	Validar datos introducidos		
			if (listaCentros=='')	
				MsgError=MsgError+'Es necesario seleccionar el centro que debe completar la encuesta.\n';
			if (document.getElementById('NUEVA_REFERENCIA').value =='')	
				MsgError=MsgError+'El campo REFERENCIA es obligatorio\n';
			if (document.getElementById('NUEVO_PRODUCTO').value =='')	
				MsgError=MsgError+'El campo PRODUCTO es obligatorio\n';
			if (document.getElementById('NUEVO_PROVEEDOR').value =='')	
				MsgError=MsgError+'El campo PROVEEDOR es obligatorio\n';
			if (document.getElementById('NUEVO_PRECIO').value =='')	
				MsgError=MsgError+'El campo PRECIO es obligatorio\n';
			if (document.getElementById('NUEVA_UNIDADBASICA').value =='')	
				MsgError=MsgError+'El campo UNIDAD BASICA es obligatorio\n';
		
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
				document.getElementById('LISTACENTROS').value = listaCentros;
				document.getElementById('REFERENCIA').value = document.getElementById('NUEVA_REFERENCIA').value;
				document.getElementById('PRODUCTO').value = document.getElementById('NUEVO_PRODUCTO').value;
				document.getElementById('PROVEEDOR').value = document.getElementById('NUEVO_PROVEEDOR').value;
				document.getElementById('PRECIO').value = document.getElementById('NUEVO_PRECIO').value;
				document.getElementById('UNIDADBASICA').value = document.getElementById('NUEVA_UNIDADBASICA').value;
				document.getElementById('ESTADO').value = 'O';
				document.getElementById('ACCION').value = 'ENCUESTAS';
				document.getElementById('PAGINA').value = parseInt(document.getElementById('PAGINA').value);

				//alert (document.getElementById('LISTACENTROS').value+':'+listaCentros);

				//	Realizar accion
				SubmitForm(form);
			}
		}
		
		/*
		//	Si el destinatario son empresas individuales mostramos la tabla
		function CambioDeDestinatario()
		{
			if (document.getElementById('NUEVA_PUBLICA').value == 'NULL')
				document.getElementById('ListaEmpresas').style.display='';
			else
				document.getElementById('ListaEmpresas').style.display='none';
		}
		*/

		function RealizarAccion(accion)
		{ 
			var form=document.forms[0],
				listaCentros=ListaCentros();
			
			if (listaCentros=='VACIO')
			{
				alert('La lista de centros no puede estar vacía');
			}
			else
			{
				document.getElementById('ACCION').value = accion;
				document.getElementById('LISTACENTROS').value = ListaCentros();
				document.getElementById('PAGINA').value = 0;
				SubmitForm(form);
			}
		}

		function MostrarCentros()		
		{
			var form=document.forms[0];
			
			document.getElementById('ACCION').value = 'MOSTRARCENTROS';
			document.getElementById('PAGINA').value = 0;
			SubmitForm(form);
		}
		
		//	Elimina un centro dentro de una encuesta
		function EliminarCentro(IDEncuesta, IDCentro)
		{
			var form=document.forms[0];
			
			document.getElementById('IDENCUESTA').value = IDEncuesta;
			document.getElementById('LISTACENTROS').value = IDCentro;
			document.getElementById('ACCION').value = 'ELIMINARCENTRO';

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
		
		//	Copiar campos de la tabla al input
		function CopiarReferencia(linea_producto)
		{
			document.getElementById('NUEVA_REFERENCIA').value=document.getElementById('REFERENCIA_'+linea_producto).value;
		}

		function CopiarProducto(linea_producto) 
		{
            document.getElementById('NUEVO_PRODUCTO').value=document.getElementById('PRODUCTO_'+linea_producto).value;
		}
		
		function CopiarProveedor(linea_producto)
		{
			document.getElementById('NUEVO_PROVEEDOR').value=document.getElementById('PROVEEDOR_'+linea_producto).value;
		}
		
		function CopiarPrecio(linea_producto)
		{
			document.getElementById('NUEVO_PRECIO').value=document.getElementById('PRECIO_'+linea_producto).value;
		}

		function CopiarUnidadBasica(linea_producto)
		{
			document.getElementById('NUEVA_UNIDADBASICA').value=document.getElementById('UNIDADBASICA_'+linea_producto).value;
		}
		
		function MarcarTodosLosCentros()
		{
			var form=document.forms[0],
				Valor='';
				
			for(var n=0;n<form.length;n++)
			{
				if(form.elements[n].name.match('CHK_IDCENTRO_'))
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
				listaCentros=ListaCentros();
		
			//	Validar datos introducidos		
			if (listaCentros=='')	
				MsgError=MsgError+'Es necesario seleccionar al menos un centro para copiarle las encuestas.\n';
			if ( MsgError!='')
			{
				alert(MsgError);
			}
			else
			{
				if (confirm('¿Estás seguro de copiar las encuestas en los centros seleccionados?')==true)
				{
					document.getElementById('LISTACENTROS').value = listaCentros;
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
		<form action="MantenimientoEncuestasSave.xsql" method="POST" name="form1">
		
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo -->
          <xsl:when test="Encuestas/xsql-error">
            <xsl:apply-templates select="Encuestas/xsql-error"/>          
          </xsl:when>
	
        <xsl:when test="Encuestas/ROW/Sorry">
          <xsl:apply-templates select="Encuestas/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
		
		<h1 class="titlePage">Mantenimiento de encuestas (Encuestas encontradas: <xsl:value-of select="/MantenimientoEncuestas/ENCUESTAS/TOTAL"/>)</h1>
		
		<!-- Campos ocultos para transmision de datos	-->
		<input type="hidden" id="IDENCUESTA" name="IDENCUESTA" value="" />
		<input type="hidden" id="FECHA"  name="FECHA" value="" />
		<input type="hidden" id="IDUSUARIO" name="IDUSUARIO" value="" />
		<input type="hidden" id="LISTACENTROS" name="LISTACENTROS" value="" />
		<input type="hidden" id="REFERENCIA" name="REFERENCIA" value="" />
		<input type="hidden" id="PRODUCTO" name="PRODUCTO" value="" />
		<input type="hidden" id="PROVEEDOR" name="PROVEEDOR" value="" />
		<input type="hidden" id="PRECIO" name="PRECIO" value="" />
		<input type="hidden" id="UNIDADBASICA" name="UNIDADBASICA" value="" />
		<input type="hidden" id="ESTADO" name="ESTADO" value="O" />
		<input type="hidden" id="ACCION" name="ACCION" value="" />
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/MantenimientoEncuestas/ENCUESTAS/FILTROS/PAGINA}" />
        <div class="divLeft">
		<table class="grandeInicio">
        	<thead>
			<tr class="titulos">
				    	<td class="cinco">Fecha</td>
				    	<td class="dies">Usuario</td>
				    	<td class="cinco">Referencia</td>
				    	<td class="dies">Producto</td>
				    	<td class="dies">Proveedor</td>
				    	<td class="veinte">Centro Encuestado</td>
								<td class="cinco">Pl.</td>
								<td class="cinco">Mu.</td>
								<td class="cinco">No Int.</td>
								<td class="quince">Comentarios</td>
				    	<td class="cinco">Precio</td>
				    	<td class="cinco">Ud.Básica</td>
				    	<td class="cinco">Estado</td>
				    	<td class="dos">Activar</td>
				    	<td class="dos">Ocultar</td>
				    	<td class="dos">Borrar</td>
				    	<td class="dos">Hecho</td>
			</tr>
            <tr class="select">
				    	<td></td>
				    	<td></td>
				    	<td><input type="text" id="FREFERENCIA" name="FREFERENCIA" maxlength="20" size="10" value="{/MantenimientoEncuestas/ENCUESTAS/FILTROS/REFERENCIA}" /></td>
				    	<td><input type="text" id="FPRODUCTO" name="FPRODUCTO" maxlength="20" size="10" value="{/MantenimientoEncuestas/ENCUESTAS/FILTROS/PRODUCTO}" /></td>
				    	<td><input type="text" id="FPROVEEDOR" name="FPROVEEDOR" maxlength="20" size="10" value="{/MantenimientoEncuestas/ENCUESTAS/FILTROS/PROVEEDOR}" /></td>
						<td>
							<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="FIDCENTRO"/>
							<xsl:with-param name="path" select="/MantenimientoEncuestas/ENCUESTAS/FILTROS_DESPLEGABLES/FIDCENTRO/field" />
							</xsl:call-template>
						</td>
				    	<td colspan="3">
							<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="FIDRESPUESTA"/>
							<xsl:with-param name="path" select="/MantenimientoEncuestas/ENCUESTAS/FILTROS_DESPLEGABLES/FIDRESPUESTA/field" />
							</xsl:call-template>
						</td>
				    	<td colspan="3"></td>
				    	<td>
							<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="FIDESTADO"/>
							<xsl:with-param name="path" select="/MantenimientoEncuestas/ENCUESTAS/FILTROS_DESPLEGABLES/FIDESTADO/field" />
							</xsl:call-template>
						</td>
				    	<td colspan="4">
                        	<div class="botonLargo">
							<xsl:call-template name="botonPersonalizado">
							    <xsl:with-param name="funcion">RealizarAccion('FILTRAR');</xsl:with-param>
							    <xsl:with-param name="label">Filtrar</xsl:with-param>
	                            <xsl:with-param name="status">Filtrar encuestas</xsl:with-param>
							</xsl:call-template>
                            </div>
						</td>
			      	</tr>
                    </thead>
                    <tbody>
                    <xsl:for-each select="MantenimientoEncuestas/ENCUESTAS/ENCUESTA">
						<tr>
							<td><xsl:value-of select="ENC_FECHA"/><input type="hidden" id="FECHA_{ENC_ID}" value="{ENC_FECHA}" /></td>
							<td><xsl:value-of select="USUARIO"/><input type="hidden" id="IDUSUARIO_{ENC_ID}" value="{ENC_IDUSUARIO}" /></td>
							<td><a href="javascript:CopiarReferencia('{ENC_ID}');"><xsl:value-of select="ENC_REFERENCIA"/></a><input type="hidden" id="REFERENCIA_{ENC_ID}" value="{ENC_REFERENCIA}" /></td>
							<td class="textLeft"><a href="javascript:CopiarProducto('{ENC_ID}');"><xsl:value-of select="ENC_PRODUCTO"/></a><input type="hidden" id="PRODUCTO_{ENC_ID}" value="{ENC_PRODUCTO}" /></td>
							<td><a href="javascript:CopiarProveedor('{ENC_ID}');"><xsl:value-of select="ENC_PROVEEDOR"/></a><input type="hidden" id="PROVEEDOR_{ENC_ID}" value="{ENC_PROVEEDOR}" /></td>
							<td>
								<xsl:value-of select="CENTRO"/><input type="hidden" id="IDCENTRO_{ENC_ID}_{ID}" value="{ID}" />
							</td>
							<xsl:choose>
								<xsl:when test="IDUSUARIO>0">
									<td class="cinco"><xsl:value-of select="PLANTILLA"/></td>
									<td class="cinco"><xsl:value-of select="MUESTRAS"/></td>
									<td class="cinco"><xsl:value-of select="NOINTERESA"/></td>
									<td class="trentacinco">
										<xsl:value-of select="COMENTARIOS"/>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td colspan="3">
										Pendiente
									</td>
									<td>
										<a href="javascript:EliminarCentro('{ENC_ID}','{IDCENTRO}');" onmouseover="window.status='Eliminar centro';return true;" onmouseout="window.status=''; return true;">
                                        <img src="/images/2017/trash.png"/></a>
									</td>
								</xsl:otherwise>
							</xsl:choose>
							<td>
                            <a href="javascript:CopiarPrecio('{ENC_ID}');"><xsl:value-of select="ENC_PRECIO"/></a>&nbsp;&nbsp;<input type="hidden" id="PRECIO_{ENC_ID}" value="{ENC_PRECIO}" />
                            </td>
							<td>
                            <a href="javascript:CopiarUnidadBasica('{ENC_ID}');"><xsl:value-of select="ENC_UNIDADBASICA"/></a><input type="hidden" id="UNIDADBASICA_{ENC_ID}" value="{ENC_UNIDADBASICA}" />
                            </td>
							<td><xsl:value-of select="ESTADO"/><input type="hidden" id="ESTADO_{ENC_ID}" value="{ENC_ESTADO}" /></td>
							<td>                           
								<a href="javascript:EstadoEncuesta('{ENC_ID}','{IDCENTRO}','ACTIVAR');" onmouseover="window.status='Activar encuesta';return true;" onmouseout="window.status=''; return true;"> <img src="/images/activar.gif"/>
                                    </a>
							</td>
							<td>                           
								<a href="javascript:EstadoEncuesta('{ENC_ID}','{IDCENTRO}','OCULTAR');" onmouseover="window.status='Ocultar encuesta';return true;" onmouseout="window.status=''; return true;">
                                <img src="/images/ocultarAzul.gif"/>
                                    </a>
							</td>
							<td>
                            	<a href="javascript:EstadoEncuesta('{ENC_ID}','{IDCENTRO}','BORRAR');" onmouseover="window.status='Borrar encuesta';return true;" onmouseout="window.status=''; return true;"> <img src="/images/borrarB.gif"/>
                                    </a>
							</td>
							<td>
                            	<a href="javascript:EstadoEncuesta('{ENC_ID}','{IDCENTRO}','REALIZADA');" onmouseover="window.status='Acción Realizada';return true;" onmouseout="window.status=''; return true;"> <img src="/images/realizada.gif"/>
                                </a>
							</td>
						</tr>	
					</xsl:for-each>
                   
                 </tbody>
                 
        </table>
        <br/><br/>
        </div><!--fin de divLeft-->
        
          <!--botones-->
          <div class="divLeft">
          	<div class="divLeft10">&nbsp;</div>
            <div class="divLeft20">&nbsp;
                 <xsl:if test="/MantenimientoEncuestas/ENCUESTAS/PAGINAANTERIOR">
                 	<img src="/images/anterior.gif" />&nbsp;
					<xsl:call-template name="botonNostyle">
						<xsl:with-param name="path" select="/MantenimientoEncuestas/botones/button[@label='NavegarAtras']"/>
						</xsl:call-template>
					</xsl:if>
            </div>
            <div class="divLeft40">&nbsp;</div>
            <div class="divLeft20">
             	<xsl:if test="/MantenimientoEncuestas/ENCUESTAS/PAGINASIGUIENTE">
					<xsl:call-template name="botonNostyle">
						<xsl:with-param name="path" select="/MantenimientoEncuestas/botones/button[@label='NavegarAdelante']"/>
					</xsl:call-template>
                &nbsp;<img src="/images/siguiente.gif" />
              </xsl:if>
           </div>
            <br/><br/>
       </div><!--fin divleft botones-->
         
         <div class="divLeft40">
         	  <table class="grandeInicio" style="border:1px solid #e4e4e5;">
                <thead>
            	<tr class="titulos">
					<td colspan="2">Estadísticas por estado</td>
				</tr>
                </thead>
					<xsl:for-each select="MantenimientoEncuestas/ENCUESTAS/ESTADISTICAS/ESTADISTICAS_ESTADOS/ESTADO">
					<xsl:if test="ID!='-1'">
            			<tr>
							<td><xsl:value-of select="NOMBRE"/></td>
							<td><xsl:value-of select="TOTAL"/></td>
						</tr>
					</xsl:if>
					</xsl:for-each>
			</table>
         </div><!--fin divLeft40-->
         <div class="divLeft10">&nbsp;</div>
         <div class="divLeft40">
         <table class="grandeInicio" style="border:1px solid #e4e4e5;">
                <thead>
            	<tr class="titulos">
					<td colspan="2">Estadísticas por respuestas</td>
				</tr>
                </thead>
				<xsl:for-each select="MantenimientoEncuestas/ENCUESTAS/ESTADISTICAS/ESTADISTICAS_RESPUESTAS/RESPUESTA">
				<xsl:if test="ID!='-1'">
            		<tr class="claro">
						<td align="center"><xsl:value-of select="NOMBRE"/></td>
						<td align="center"><xsl:value-of select="TOTAL"/></td>
					</tr>
				</xsl:if>
				</xsl:for-each>
			</table>
            <br /><br />
         </div><!--fin divLeft40-->
         
         <div class="divLeft">
         <table class="infoTable">
                	<tr class="titulos"> 
				    	<td colspan="2">Nueva encuesta</td>
					</tr>
                    <tr>
					<td class="veinte labelRight">Seleccionar Centros:<br /><br />
							<xsl:call-template name="botonPersonalizado">
							    <xsl:with-param name="funcion">MarcarTodosLosCentros();</xsl:with-param>
							    <xsl:with-param name="label">Todos</xsl:with-param>
	                            <xsl:with-param name="status">Marcar todos los centros</xsl:with-param>
							</xsl:call-template>
						</td>
						<td>
							<table class="infoTable">
							<tr>
							<xsl:for-each select="MantenimientoEncuestas/ENCUESTAS/CENTROS/CENTRO">
								<td class="datosLeft">
								&nbsp;&nbsp;&nbsp;
								<input type="checkbox" name="CHK_IDCENTRO_{ID}">
								<xsl:choose>
									<xsl:when test="MOSTRAR='S'">
										<xsl:attribute name="checked" value="true"/>
									</xsl:when>         
									<xsl:otherwise>
										<xsl:attribute name="unchecked" value="unchecked"/>
									</xsl:otherwise>
								</xsl:choose>
								</input>
								&nbsp;<xsl:value-of select="NOMBRE"/><input type="hidden" id="NUEVO_IDCENTRO_{ID}" value="{ID}" />
								<xsl:if test="SALTO">
									<xsl:text disable-output-escaping="yes"><![CDATA[</tr><tr>	 ]]></xsl:text>
								</xsl:if>
								</td>
							</xsl:for-each>
							</tr>
							
							<tr>
								<td colspan="3">
								<table class="infoTable">
									<tr>
                                    <td>
                                    <div class="botonLargo">
									<xsl:call-template name="botonPersonalizado">
							    		<xsl:with-param name="funcion">RealizarAccion('CENTROSVISIBLES');</xsl:with-param>
							    		<xsl:with-param name="label">Dejar solo los centros marcados</xsl:with-param>
	                            		<xsl:with-param name="status">Dejar solo los centros marcados</xsl:with-param>
									</xsl:call-template>
                                    </div>
									</td>
                                    <td class="cinco">&nbsp;</td>
									<td>
                                    <div class="botonLargo">
									<xsl:call-template name="botonPersonalizado">
							    		<xsl:with-param name="funcion">RealizarAccion('QUITARCENTROS');</xsl:with-param>
							    		<xsl:with-param name="label">Quitar los centros marcados</xsl:with-param>
	                            		<xsl:with-param name="status">Quitar los centros marcados</xsl:with-param>
									</xsl:call-template>
                                    </div>
									</td>
                                    <td class="cinco">&nbsp;</td>
									<td>
                                    <div class="botonLargo">
									<xsl:call-template name="botonPersonalizado">
							    		<xsl:with-param name="funcion">MostrarCentros();</xsl:with-param>
							    		<xsl:with-param name="label">Mostrar centros ocultos</xsl:with-param>
	                            		<xsl:with-param name="status">Mostrar centros ocultos</xsl:with-param>
									</xsl:call-template>
                                    </div>
									</td></tr>
								</table>
								</td>
							</tr>
							</table>
						</td>
					</tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr>
                        <td class="veinte labelRight">Referencia:</td>
                        <td class="datosLeft"><input type="text" id="NUEVA_REFERENCIA" maxlength="100" size="80" value="" /></td>
                    </tr>
					<tr>
                        <td class="veinte labelRight">Producto:</td>
                        <td class="datosLeft"><input type="text" id="NUEVO_PRODUCTO" maxlength="100" size="80" value="" /></td>
                    </tr>
					<tr>
                        <td class="veinte labelRight">Proveedor:</td>
                        <td class="datosLeft"><input type="text"  id="NUEVO_PROVEEDOR" maxlength="100" size="80" value=""/></td>
                    </tr>
					<tr>
                        <td class="veinte labelRight">Precio:</td>
                        <td class="datosLeft"><input type="text"  id="NUEVO_PRECIO" maxlength="10" size="10" value=""/></td>
                    </tr>
					<tr>
                        <td class="veinte labelRight">Unidad Básica:</td>
                        <td class="datosLeft"><input type="text"  id="NUEVA_UNIDADBASICA" maxlength="20" size="20" value=""/></td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                	<tr>
				    	<td colspan="2">
                        	<div class="divLeft20">&nbsp;</div>
							<div class="divLeft20">
                            <div class="botonLargo">
							<xsl:call-template name="botonPersonalizado">
							    <xsl:with-param name="funcion">NuevaEncuesta()</xsl:with-param>
							    <xsl:with-param name="label">Guardar nueva encuesta</xsl:with-param>
	                            <xsl:with-param name="status">Guardar la nueva encuesta en los centros seleccionados</xsl:with-param>
							</xsl:call-template>
                            </div>
                            </div>
							<div class="divLeft10">&nbsp;</div>
                            <div class="divLeft20">
                            <div class="botonlargo">
							<xsl:call-template name="botonPersonalizado">
							    <xsl:with-param name="funcion">CopiarEncuestas()</xsl:with-param>
							    <xsl:with-param name="label">Copiar TODAS las encuestas</xsl:with-param>
	                            <xsl:with-param name="status">Copiar todas las encuestas a los centros seleccionados</xsl:with-param>
							</xsl:call-template>
							</div>
                            </div>

						</td>
					</tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
         </table>
         </div>
       
        
						

        </xsl:otherwise>
        </xsl:choose>
		</form>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
