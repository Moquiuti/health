<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 |
 |	
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Mantenimiento de Facturas</title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/divisas.js"></script>
	<script type="text/javascript">
        <!--

var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';

var ListaCampos;
var estado='fact';  //variable que se necesita para que no casqueel codigo ya que se comparte con la multioferta
//var MyForm;
//var DivisaActual;



function InicializarFormulario(form){
	
	
//
//
//	Todo el codigo de validacion esta en pruebas!
//
//
		
//    MyForm=form;
		
	ListaCampos = new MVMListaCampos(form);
	ListaCampos.NuevoCampo( 
							'FECHAFACTURA',
							'Fecha Factura',
							form.elements['FECHAFACTURA'].value,
							'Fecha', 
							'Requerido', -1,'','','deUsuario');
	ListaCampos.NuevoCampo( 
							'CODIGO',
							'Código Factura',
							form.elements['CODIGO'].value,
							'Texto', 
							'Requerido',-1,'','','deUsuario');
	ListaCampos.NuevoCampo(
							'IDESTADO',
							'Estado', 
							form.elements['IDESTADO'].value,
							'NoChequear', 
							'Requerido',-1,'','','deUsuario');
	ListaCampos.NuevoCampo( 
							'IDCLIENTE',
							'Cliente',
							form.elements['IDCLIENTE'].value,
							'NoChequear', 
							'Requerido',-1,'','','deUsuario');
	ListaCampos.NuevoCampo( 
							'DESCRIPCION',
							'Descripción', 
							form.elements['DESCRIPCION'].value,
							'Texto', 
							'Requerido',-1,'','','deUsuario');
    ListaCampos.NuevoCampo( 
							'OBSERVACIONES',
							'Observaciones',
							form.elements['OBSERVACIONES'].value, 
							'Texto', 
							'Requerido',-1,'','','deUsuario');
    ListaCampos.NuevoCampo(
							'SUBTOTAL',
							'Subtotal',  
							form.elements['SUBTOTAL'].value,
							'Decimal', 
							'Requerido',form.elements['IDDIVISA'].options[form.elements['IDDIVISA'].selectedIndex].value,'','','deUsuario');
    ListaCampos.NuevoCampo(
							'TIPOIVA',
							'Tipo de Iva', 
							obtenerIdDesplegable(form,'TIPOIVA'), 
							'NoChequear', 
							'Requerido',-1,'','','deUsuario,admiteCeros');
    ListaCampos.NuevoCampo( 
							'IVA',
							'Iva',
							form.elements['IVA'].value,
							'Decimal', 
							'Requerido',form.elements['IDDIVISA'].options[form.elements['IDDIVISA'].selectedIndex].value,'','','admiteCeros');
    ListaCampos.NuevoCampo( 
							'SUPLIDOS',
							'Suplidos',
							form.elements['SUPLIDOS'].value,
							'Decimal', 
							'Requerido',form.elements['IDDIVISA'].options[form.elements['IDDIVISA'].selectedIndex].value,'','','admiteCeros');
    ListaCampos.NuevoCampo(
							'TOTAL',
							'Total', 
							form.elements['TOTAL'].value,
							'Decimal', 
							'Requerido',form.elements['IDDIVISA'].options[form.elements['IDDIVISA'].selectedIndex].value,'','','');
	
	//DivisaActual=form.elements['IDDIVISA'].options[form.elements['IDDIVISA'].selectedIndex].value;	
	
	//	Coge los valores originales
	ListaCampos.ValorOriginalDivisas(form, obtenerIdDivisa(form,'IDDIVISA'));	

}


function inicializarCalculos(form){
   if(form.elements['SUBTOTAL'].value!=0)
     CalcularTotales(form);
}


function CalcularTotales(form){

       
               
	//	IMPORTANTE! Primero hay que redondear los campos
	
	//ListaCampos.FormatoDivisas(form, obtenerIdDesplegable(form,'IDDIVISA'));
	//	Luego realizar las operaciones correspondientes
	
	var subtotal=desformateaDivisa(form.elements['SUBTOTAL'].value);
	var tipoiva=obtenerIdDesplegable(form,'TIPOIVA');
	var iva=parseFloat(subtotal)* parseFloat(tipoiva)/100;
	var iva=Round(iva,2);
	var suplidos=desformateaDivisa(form.elements['SUPLIDOS'].value);
	var total=parseFloat(subtotal)+parseFloat(iva)+parseFloat(suplidos);
	
	//	Y finalmente actualizar los valores

	
	//anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_SUBTOTAL'].value),2)),2);
	
	
	form.elements['SUBTOTAL'].value=anyadirCerosDecimales(reemplazaPuntoPorComa(subtotal),2);
	total=Round(total,2);
	form.elements['SUPLIDOS'].value=anyadirCerosDecimales(formateaDivisa(suplidos),2);
	form.elements['IVA'].value=anyadirCerosDecimales(formateaDivisa(iva),2);
	form.elements['TOTAL'].value=anyadirCerosDecimales(formateaDivisa(total),2);
	

	
	ListaCampos.ActualizaValores('SUBTOTAL',form);
	ListaCampos.ActualizaValores('IVA',form);
	ListaCampos.ActualizaValores('SUPLIDOS',form);
	ListaCampos.ActualizaValores('TOTAL',form);

	
}


//	Ejecuta el cambio de divisas en el formulario
function CambioDivisa(formu){
        alert('en cambio divisa '+formu.name);
	var NuevaDivisa=obtenerIdDivisa(formu, 'IDDIVISA');
	ListaCampos.RecalculaDivisas(formu, NuevaDivisa);
	return true;
}

//	Prepara el envio del formulario despues de comprobar los campos
function ValidarFormulario(formu)
{
	var msgError='';
	msgError=ListaCampos.ValidarCampos(formu,msgError);
		
	//
	
	if	(msgError=='')
	{       
	
	        /*
	          formateamos correctamente las divisas formato ingles para guardarlas en la base de datos
	        */
	        
	        for(var n=0;n<Campos.length;n++)
	          if(Campos[n].divisa!='-1'){
	            formu.elements[Campos[n].nombre].value=desformateaDivisa(formu.elements[Campos[n].nombre].value);         
	          }
	          
  		SubmitForm(formu);
		return true;
	}
   	else
	{
		PresentaError(msgError);
		return false;
	}
	
}

//-->
	</script>
        ]]></xsl:text>
        
        <STYLE>.tituloPagForm {
	COLOR: #015e4b; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; FONT-SIZE: 14pt; FONT-WEIGHT: bold
}
.tituloForm {
	COLOR: #015e4b; FONT-SIZE: 10pt; FONT-WEIGHT: bold
}
.subTituloForm {
	COLOR: #018167; FONT-SIZE: 9pt; FONT-WEIGHT: bold
}
.textoForm {
	COLOR: #000000; FONT-SIZE: 10pt; FONT-WEIGHT: bold
}
.textoLegal {
	COLOR: #000000; FONT-SIZE: 8pt
}
.camposObligatorios { COLOR: #FF0000; FONT-SIZE: 10pt; FONT-WEIGHT: bold }
</STYLE>
      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>
          
           
          
<body leftMargin="0" topMargin="0" marginheight="0" marginwidth="0"
	onLoad="javascript:InicializarFormulario(document.forms[0]);inicializarCalculos(document.forms[0]);">
<form action="FacturaSave.xsql" method="POST" name="form1">
  	<input type="hidden" name="IDFACTURA">
		<xsl:attribute name="value">
		<xsl:value-of  select="Factura/LEERFACTURA/FACTURA/ID"/>
		</xsl:attribute>				
	</input>

  <p class="tituloPag" align="center"><br/>Mantenimiento de Facturas</p><br/>

  <table border="0" width="90%" class="gris" cellpadding="0" cellspacing="1" align="center">
    <tr class="grisClaro"> 
      <td colspan="2"> 
        <table width="100%" align="center">
          <tr> 
            <td class="textoLegal">
              <b>Mantenimiento de Facturas.</b>
	    </td>
          </tr>
          <tr> 
            <td class="textoLegal">
		Página para el uso exclusivo por parte de administradores de MedicalVM<br/>
		Si usted dispone de acceso a esta página sin ser administrador, por favor, informe
		a su comercial de MedicalVM.<br/>
	     </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr class="textoform"> 
      <td class="textoform" height="219" colspan="2"> 
        <table border="0" width="100%" class="medio" cellpadding="1" cellspacing="1">
        <tr> 
            <td class="oscuro" colspan="6">
              Factura
	    </td>
          </tr>
        <tr class="claro"> 
            <td width="20%"> 
              <div align="right" class="textoform">Fecha Factura:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td width="*"> 
              <div align="left"> 
                <input name="FECHAFACTURA" size="25" maxlength="10" obligatorio="si" tipo="fecha">
				<xsl:attribute name="value">
					<xsl:value-of  select="Factura/LEERFACTURA/FACTURA/FECHA"/>
				</xsl:attribute>				
				</input>
                <div class="textoLegal">(dd/mm/aaaa) </div>
              </div>
            </td>
		</tr>
		<tr class="claro">
            <td> 
              <div align="right" class="textoform">Código Factura:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td> 
              <div align="left"> 
                <input name="CODIGO" size="25" maxlength="10" obligatorio="si" tipo="fecha">
				<xsl:attribute name="value">
					<xsl:value-of  select="Factura/LEERFACTURA/FACTURA/CODIGO"/>
				</xsl:attribute>				
				</input>
              </div>
            </td>
          </tr>
          <tr class="claro"> 
            <td class="textoform" > 
              <div align="right">Estado:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td> 
   	                <xsl:call-template name="field_funcion">
    	                  <xsl:with-param name="path" select="Factura/LEERFACTURA/ESTADOS/field"/>
    	                  <xsl:with-param name="IDAct" select="Factura/LEERFACTURA/FACTURA/IDESTADO"/>
    	                </xsl:call-template>
   		    	
   		
            </td>
          </tr>
          <tr class="claro"> 
            <td class="textoform" > 
              <div align="right">Cliente:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td > 
   		    	<xsl:call-template name="field_funcion">
    	                  <xsl:with-param name="path" select="Factura/LEERFACTURA/EMPRESA/field"/>
    	                  <xsl:with-param name="IDAct" select="Factura/LEERFACTURA/FACTURA/IDCLIENTE"/>
    	                </xsl:call-template>
            </td>
          </tr>
         <tr class="claro"> 
            <td class="textoform" > 
              <div align="right">Descripción:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td  align="left"> 
				<textarea  maxlength="2000" rows="10" cols="75" name="DESCRIPCION">
				  <xsl:value-of  select="Factura/LEERFACTURA/FACTURA/DESCRIPCION"/>
				</textarea>
            </td>
          </tr>    
          <tr class="claro"> 
            <td class="textoform" > 
              <div align="right">Observaciones:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td  align="left"> 
                <textarea name="OBSERVACIONES" cols="50" rows="2">
		  <xsl:value-of  select="Factura/LEERFACTURA/FACTURA/OBSERVACIONES"/>				
		</textarea>
            </td>
          </tr>
          <tr class="claro"> 
            <td class="textoform" > 
              <div align="right">Divisa:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td > 
            	<xsl:variable name="IDAct" select="Factura/LEERFACTURA/FACTURA/IDDIVISA"/>
   		    	<xsl:apply-templates select="Factura/LEERFACTURA/FACTURA/DIVISAS/field_plus[@name='IDDIVISA']"/>
            </td>
          </tr>
          <tr class="claro"> 
            <td class="textoform" > 
              <div align="right">Subtotal:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td  align="left"> 
                <input name="SUBTOTAL" size="25" maxlength="15"
					onChange="javascript:checkNumber(this.value,this);CalcularTotales(document.forms[0]) ">
				<xsl:attribute name="value">
					<xsl:value-of  select="Factura/LEERFACTURA/FACTURA/SUBTOTAL"/>
				</xsl:attribute>				
				</input>
            </td>
          </tr>
          <tr class="claro"> 
            <td class="textoform" > 
              <div align="right">I.V.A.<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td  align="left"> 
   		    	<xsl:call-template name="field_plus_funcion">
    	                  <xsl:with-param name="path" select="Factura/LEERFACTURA/TIPOSIVA/field_plus"/>
    	                  <xsl:with-param name="IDAct" select="Factura/LEERFACTURA/FACTURA/TIPOIVA"/>
    	                </xsl:call-template>
   		    	
				<input name="IVA" size="17" maxlength="15" onFocus="this.blur();">
				<xsl:attribute name="value">
					<xsl:value-of  select="Factura/LEERFACTURA/FACTURA/IVA"/>
				</xsl:attribute>
				</input>
            </td>
          </tr>
          <tr class="claro"> 
            <td class="textoform" > 
              <div align="right">Gastos Suplidos:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td  align="left"> 
				<input name="SUPLIDOS" size="17" maxlength="15" 
					onChange="javascript:checkNumber(this.value,this);CalcularTotales(document.forms[0]) ">
				<xsl:attribute name="value">
					<xsl:value-of  select="Factura/LEERFACTURA/FACTURA/SUPLIDOS"/>
				</xsl:attribute>
				</input>
            </td>
          </tr>
          <tr class="claro"> 
            <td class="textoform" > 
              <div align="right">Total:<span  class="camposObligatorios">*</span>&nbsp;</div>
            </td>
            <td  align="left"> 
                <input name="TOTAL" size="25" maxlength="15" onFocus="this.blur();">
				<xsl:attribute name="value">
					<xsl:value-of  select="Factura/LEERFACTURA/FACTURA/TOTAL"/>
				</xsl:attribute>				
				</input>
            </td>
          </tr>
          <tr class="claro"> 
		  	<td align="center" colspan="2">&nbsp;</td>
          </tr>
          <tr class="claro"> 
		  	<td align="center" colspan="2">La opción de envío automático de e-mails todavía
			no está activa
			</td>
          </tr>
          <tr class="claro"> 
            <td > 
              <div align="right"> 
                <input type="checkbox" name="ENVIARADMINISTRACION"/>
              </div>
            </td>
            <td > 
              <div align="left" class="textoform">Enviar a Administración de MedicalVM</div>
            </td>
          </tr>
          <tr class="claro"> 
            <td > 
              <div align="right"> 
                <input type="checkbox" name="ENVIARCLIENTE"/>
              </div>
            </td>
            <td > 
              <div align="left" class="textoform">Enviar al Cliente</div>
            </td>
          </tr>
		</table>
	  </td>
	</tr>
	<tr class="grisClaro">  
      <td align="center" height="25px" valign="bottom">
        <table width="100%">
          <tr>
          <td align="center">
        <xsl:call-template name="botonPersonalizado">
          <xsl:with-param name="funcion">window.close();</xsl:with-param>
          <xsl:with-param name="label">Cancelar</xsl:with-param>
          <xsl:with-param name="status">Cancelar</xsl:with-param>
          <xsl:with-param name="ancho">120px</xsl:with-param>
        </xsl:call-template>
      </td>
      <td align="center">
        <xsl:call-template name="botonPersonalizado">
          <xsl:with-param name="funcion">ValidarFormulario(document.forms[0]);</xsl:with-param>
          <xsl:with-param name="label">Aceptar</xsl:with-param>
          <xsl:with-param name="status">Aceptar</xsl:with-param>
          <xsl:with-param name="ancho">120px</xsl:with-param>
        </xsl:call-template>
      </td>
      </tr>
      </table>
      </td>
    </tr>
  </table>
  </form>
  <xsl:copy-of select="//nacho"/>
 </body>
  

 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 <xsl:template name="fieldTipoIVA_funcion">
    <xsl:param name="path"/>
    <xsl:param name="IDAct"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="$path/../@name"/><xsl:value-of select="$path/../LMO_IDPRODUCTO"/></xsl:attribute>
      <xsl:attribute name="onChange">actualizaIVA('<xsl:value-of select="$path/../LMO_IDPRODUCTO"/>',this.options[this.selectedIndex].value)</xsl:attribute>
      <xsl:for-each select="$path/listElem">
      <xsl:value-of select="$IDAct"/>
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
 
 
 </xsl:stylesheet>