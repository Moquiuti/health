<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
  
  
<html>
  <head>
    <title>Mantenimiento del Catálogo Privado</title>
    <xsl:text disable-output-escaping="yes"><![CDATA[
    <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
    <script language="javascript" src="http://www.newco.dev.br/General/general.js"></script>
    <script language="javascript">
      <!--

        function AnyadirCentro(idCentro,accion){
          var idProductoEstandar=document.forms[0].elements['IDPRODUCTOESTANDAR'].value;
          MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantCentrosCatalogoFrame.xsql?IDNUEVOCENTRO='+idCentro+'&ACCION='+accion+'&IDPRODUCTOESTANDAR='+idProductoEstandar,'centrosCatalogo');
        }
        
        function ModificarCentro(idCentroProducto,idProductoEstandar,accion){           
          MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantCentrosCatalogoFrame.xsql?CENTROPRODUCTO_ID='+idCentroProducto+'&IDPRODUCTOESTANDAR='+idProductoEstandar+'&ACCION='+accion,'centrosCatalogo');
        }
        
        function AnyadirProveedor(idProveedor,idCentro,accion){
          var idProductoEstandar=document.forms[0].elements['IDPRODUCTOESTANDAR'].value;
          MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProveedoresCatalogoFrame.xsql?IDNUEVOPROVEEDOR='+idProveedor+'&IDCENTRO='+idCentro+'&IDPRODUCTOESTANDAR='+idProductoEstandar+'&ACCION='+accion,'proveedoresCatalogo');
        }
        
        function ModificarProveedor(idProveedorProducto,idProductoEstandar,accion){
          MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProveedoresCatalogoFrame.xsql?IDPROVEEDORPRODUCTO='+idProveedorProducto+'&IDPRODUCTOESTANDAR='+idProductoEstandar+'&ACCION='+accion,'proveedoresCatalogo');
        }
        
        function EstadoEvaluacion(idActa,idProveedorProducto,accion){
          MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActaEvaluacion.xsql?IDACTA='+idActa+'&IDPROVEEDORPRODUCTO='+idProveedorProducto+'&ACCION='+accion,'actaEvaluacion');
          Refresh(window.document);
        }
        
        function NoExisteProducto(nombreProveedor, referencia){
          alert('El proveedor: '+nombreProveedor+' no tiene ningún producto con la referencia: '+ referencia);
        }
        
        function CargarProductos(form, desdeDonde){
          if(confirm('¿Desea utilizar los datos del proveedor para informar los campos?\n\n * Aceptar: Cargará los campos con los datos del proveedor.\n * Cancelar: Mantiene los valores actuales.')){
            if(desdeDonde=='CENTROS'){
              parent.frameMantenimientoCentros.CargarNombre(form.elements['NOMBRE'].value);
              parent.frameMantenimientoCentros.CargarUnidadBasica(form.elements['UNIDADBASICA'].value);
              parent.frameMantenimientoCentros.CargarUnidadesPorLote(form.elements['UNIDADESPORLOTE'].value);
            }
            else{
              if(desdeDonde=='PROVEEDORES'){
                parent.frameMantenimientoProveedores.CargarNombre(form.elements['NOMBRE'].value);
                parent.frameMantenimientoProveedores.CargarUnidadBasica(form.elements['UNIDADBASICA'].value);
                parent.frameMantenimientoProveedores.CargarUnidadesPorLote(form.elements['UNIDADESPORLOTE'].value);
                parent.frameMantenimientoProveedores.CargarPrecioUnidadBasica(form.elements['IMPORTE'].value);
                parent.frameMantenimientoProveedores.CargarMarca(form.elements['MARCA'].value);
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
  <xsl:when test="//SESION_CADUCADA">
    <xsl:apply-templates select="//SESION_CADUCADA"/> 
  </xsl:when>
  <xsl:when test="//Sorry">
    <xsl:apply-templates select="//ROWSET/ROW/Sorry"/> 
  </xsl:when>
  <xsl:when test="//NO_EXISTE">
    <xsl:attribute name="onLoad">NoExisteProducto('<xsl:value-of select="/Mantenimiento/NO_EXISTE/NOMBREPROVEEDOR"/>','<xsl:value-of select="/Mantenimiento/NO_EXISTE/REFERENCIA"/>')</xsl:attribute>
  </xsl:when>
  <xsl:otherwise>
    <xsl:attribute name="onLoad">CargarProductos(document.forms[0],'<xsl:value-of select="/Mantenimiento/DESDE"/>');</xsl:attribute>
    <form name="form1" method="post">
      <input type="hidden" name="NOMBRE" value="{/Mantenimiento/PRODUCTO/NOMBRE}"/>
      <input type="hidden" name="REFERENCIA" value="{/Mantenimiento/PRODUCTO/REFERENCIA}"/>
      <input type="hidden" name="IDPROVEEDOR" value="{/Mantenimiento/PRODUCTO/IDPROVEEDOR}"/>
      <input type="hidden" name="UNIDADBASICA" value="{/Mantenimiento/PRODUCTO/UNIDADBASICA}"/>
      <input type="hidden" name="UNIDADESPORLOTE" value="{/Mantenimiento/PRODUCTO/UNIDADESPORLOTE}"/>
      <input type="hidden" name="MARCA" value="{/Mantenimiento/PRODUCTO/MARCA}"/>
      <input type="hidden" name="IMPORTE" value="{/Mantenimiento/PRODUCTO/IMPORTE}"/>
    </form>
  </xsl:otherwise>
</xsl:choose>
  </body>
  </html>
</xsl:template> 

</xsl:stylesheet>