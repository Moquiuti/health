<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

<html>
<head>
<title>Informe de no conformidad de producto</title>
  <xsl:text disable-output-escaping="yes"><![CDATA[
    <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
    <link rel="stylesheet" href="http://www.newco.dev.br/General/EstilosImprimir.css" type="text/css" media="print">
    <script language="javascript" src="http://www.newco.dev.br/General/general.js"></script>
    <script language="javascript">
      <!--
      
        var valorNulo='-1';
        
        var msgNingunaFamilia='Familias';
        var msgTituloFamilia='Todas las Familias';
        
        var msgNingunaSubfamilia='Subfamilias';
        var msgTituloSubfamilia='Todas las Subfamilias';
        
        var msgNingunProductoEstandar='Productos Estándar';
        var msgTituloProductoEstandar='Todos los Productos Estándar';
        
        var msgNingunProveedor='Proveedores';
        var msgTituloProveedor='Todos los Proveedores'; 
        
        var msgCargandoLista='Cargando Lista...';  
        
        ]]></xsl:text>
        
        
      
        //montamos los array con las familias, subfamilias, productosestandar y proveedores
        
 
        
          var arrayFamilias=new Array();
      
          <xsl:for-each select="Mantenimiento/CATALOGOPRIVADO/FAMILIAS/FAMILIA">
            arrayFamilias[arrayFamilias.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="REFERENCIA"/>','<xsl:value-of select="NOMBRE"/>');
                                                          
            var arraySubfamilias_<xsl:value-of select="ID"/>=new Array(); 
            <xsl:for-each select="SUBFAMILIAS/SUBFAMILIA">
              arraySubfamilias_<xsl:value-of select="../../ID"/>[arraySubfamilias_<xsl:value-of select="../../ID"/>.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="REFERENCIA"/>','<xsl:value-of select="NOMBRE"/>');
              
              var arrayProductosEstandar_<xsl:value-of select="ID"/>=new Array();
              <xsl:for-each select="PRODUCTOSESTANDAR/PRODUCTOESTANDAR">
                arrayProductosEstandar_<xsl:value-of select="../../ID"/>[arrayProductosEstandar_<xsl:value-of select="../../ID"/>.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="REFERENCIA"/>','<xsl:value-of select="NOMBRE"/>','<xsl:value-of select="IDPROVEEDORPRODUCTO"/>');
                
                var arrayProveedores_<xsl:value-of select="ID"/>=new Array(); 
                <xsl:for-each select="PROVEEDORES/PROVEEDOR">
                  arrayProveedores_<xsl:value-of select="../../ID"/>[arrayProveedores_<xsl:value-of select="../../ID"/>.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="NOMBRE"/>','<xsl:value-of select="IDPROVEEDORPRODUCTO"/>');
                  
                </xsl:for-each>          
              </xsl:for-each>                     
            </xsl:for-each>                       
          </xsl:for-each>
      
        <xsl:text disable-output-escaping="yes"><![CDATA[
        
        function habilitarDeshabilitarDesplegable(form,objName,accion){
          // habilitar
          if(accion=='H'){
            form.elements[objName].disabled=false;
          }
          else{
            // deshabilitar
            if(accion=='D'){
              var elementoPorDefecto=0;
              form.elements[objName].length=0;
              form.elements[objName].selectedIndex=0;
              form.elements[objName].disabled=true;
              var addOption=crearElemento(msgCargandoLista,valorNulo,elementoPorDefecto);
              asignarElemento(form,objName,addOption);
            }
            else{
              if(accion=='OPCION_CONTRARIA'){
                if(form.elements[objName].disabled==true){
                  habilitarDeshabilitarDesplegable(form,objName,'H');
                }
                else{
                  habilitarDeshabilitarDesplegable(form,objName,'D');
                }
              }
            }
          }
        }
        
        
        function inicializarDesplegable(form,objName,elementoPorDefecto){
          
         
          switch(objName){
            
            ////////////////////////////////
            //
            //    FAMILIAS 
            //
            ////////////////////////////////
            
            case 'FAMILIAS':
              
              form.elements[objName].options.length=0;
              
              // montamos el desplegable de familias
              
              if(arrayFamilias.length==0){
                var addOption=crearElemento(msgNingunaFamilia,valorNulo,elementoPorDefecto);
                asignarElemento(form,objName,addOption);
              }
              else{
                var addOption=crearElemento(msgTituloFamilia,valorNulo,elementoPorDefecto);
                asignarElemento(form,objName,addOption);
                
                for(var n=0;n<arrayFamilias.length;n++){
                  var addOption=crearElemento(arrayFamilias[n][2],arrayFamilias[n][0],elementoPorDefecto);
                  asignarElemento(form,objName,addOption);
                }
              }
              
              asignarElementoSeleccionado(form,objName,elementoPorDefecto);
              
              // volvemos a llamar a la funcion para montar el desplegable de subfamilias
              inicializarDesplegable(form,'SUBFAMILIAS',valorNulo);
              
            break;
            
            ////////////////////////////////
            //
            //    SUBFAMILIAS 
            //
            ////////////////////////////////
            
            case 'SUBFAMILIAS':
            
              var idFamilia=form.elements['FAMILIAS'].value;
              
              if(idFamilia>0){
                habilitarDeshabilitarDesplegable(form,'SUBFAMILIAS','H');
                habilitarDeshabilitarDesplegable(form,'PRODUCTOSESTANDAR','H');
                habilitarDeshabilitarDesplegable(form,'PROVEEDORES','H');
              }
            
              form.elements[objName].options.length=0;
              
              
              // montamos el desplegable de subfamilias
              
              // miramos si la familia selecionada es 'TODAS', si lo es recorremos todas las subfamilias
              
              var algunElemento=0;
              
              if(idFamilia==valorNulo){
                for(var n=0;n<arrayFamilias.length && !algunElemento;n++){
                  var arraySubfamilias=eval('arraySubfamilias_'+arrayFamilias[n][0]);
                  if(arraySubfamilias.length>0){
                    algunElemento=1;
                  }
                }
              }
              else{
                var arraySubfamilias=eval('arraySubfamilias_'+idFamilia);
                if(arraySubfamilias.length>0){
                    algunElemento=1;
                }
              }
              
              if(!algunElemento){
                var addOption=crearElemento(msgNingunaSubfamilia,valorNulo,elementoPorDefecto);
                asignarElemento(form,objName,addOption);
              }
              else{
                var addOption=crearElemento(msgTituloSubfamilia,valorNulo,elementoPorDefecto);
                asignarElemento(form,objName,addOption);
                
                if(idFamilia==valorNulo){
                  for(var n=0;n<arrayFamilias.length;n++){
                    var arraySubfamilias=eval('arraySubfamilias_'+arrayFamilias[n][0]);
                    for(var i=0;i<arraySubfamilias.length;i++){
                      var addOption=crearElemento(arraySubfamilias[i][2],arraySubfamilias[i][0],elementoPorDefecto);
                      asignarElemento(form,objName,addOption);
                    } 
                  }
                }
                else{
                  var arraySubfamilias=eval('arraySubfamilias_'+idFamilia);
                  for(var i=0;i<arraySubfamilias.length;i++){
                    var addOption=crearElemento(arraySubfamilias[i][2],arraySubfamilias[i][0],elementoPorDefecto);
                    asignarElemento(form,objName,addOption);
                  } 
                }
                
              }
              
              asignarElementoSeleccionado(form,objName,elementoPorDefecto);
              
              // volvemos a llamar a la funcion para montar el desplegable de productosestandar
              inicializarDesplegable(form,'PRODUCTOSESTANDAR',valorNulo);
            
            break;
            
            ////////////////////////////////
            //
            //   PRODUCTOSESTANDAR 
            //
            ////////////////////////////////
            
            case 'PRODUCTOSESTANDAR':
            
              var idFamilia=form.elements['FAMILIAS'].value;
              var idSubfamilia=form.elements['SUBFAMILIAS'].value
              
              form.elements[objName].options.length=0;
              
              // montamos el desplegable de productosestandar
              
              // miramos si la subfamilia selecionada es 'TODAS', si lo es miamos si la familia seleccionada es TODAS
              // si lo es recorremos todas las familias
              
              var algunElemento=0;
              
              if(idSubfamilia==valorNulo){
                if(idFamilia==valorNulo){
                  for(var n=0;n<arrayFamilias.length && !algunElemento;n++){
                    var arraySubfamilias=eval('arraySubfamilias_'+arrayFamilias[n][0]);
                    for(var i=0;i<arraySubfamilias.length && !algunElemento;i++){
                      var arrayProductosEstandar=eval('arrayProductosEstandar_'+arraySubfamilias[i][0]);
                      if(arrayProductosEstandar.length>0){
                        algunElemento=1;
                      }
                    }
                  }
                } 
                else{
                  var arraySubfamilias=eval('arraySubfamilias_'+idFamilia);
                  for(var i=0;i<arraySubfamilias.length && !algunElemento;i++){
                    var arrayProductosEstandar=eval('arrayProductosEstandar_'+arraySubfamilias[i][0]);
                    if(arrayProductosEstandar.length>0){
                      algunElemento=1;
                    }
                  }
                }
              }
              else{
                var arrayProductosEstandar=eval('arrayProductosEstandar_'+idSubfamilia);
                if(arrayProductosEstandar.length>0){
                  algunElemento=1;
                }
              }
              
              
              if(!algunElemento){
                var addOption=crearElemento(msgNingunProductoEstandar,valorNulo,elementoPorDefecto);
                asignarElemento(form,objName,addOption);
              }
              else{
                var addOption=crearElemento(msgTituloProductoEstandar,valorNulo,elementoPorDefecto);
                asignarElemento(form,objName,addOption);
                
                
                
                
                if(idSubfamilia==valorNulo){
                  if(idFamilia==valorNulo){
                    var algunElemento=0;
                    for(var n=0;n<arrayFamilias.length && !algunElemento;n++){
                      var arraySubfamilias=eval('arraySubfamilias_'+arrayFamilias[n][0]);
                      for(var i=0;i<arraySubfamilias.length;i++){
                        var arrayProductosEstandar=eval('arrayProductosEstandar_'+arraySubfamilias[i][0]);
                        for(var k=0;k<arrayProductosEstandar.length;k++){
                          var addOption=crearElemento(arrayProductosEstandar[k][2],arrayProductosEstandar[k][0],elementoPorDefecto);
                          asignarElemento(form,objName,addOption);
                        }
                      }
                    }
                  } 
                  else{
                    var arraySubfamilias=eval('arraySubfamilias_'+idFamilia);
                    for(var i=0;i<arraySubfamilias.length;i++){
                      var arrayProductosEstandar=eval('arrayProductosEstandar_'+arraySubfamilias[i][0]);
                      for(var k=0;k<arrayProductosEstandar.length;k++){
                        var addOption=crearElemento(arrayProductosEstandar[k][2],arrayProductosEstandar[k][0],elementoPorDefecto);
                        asignarElemento(form,objName,addOption);
                      }
                    }
                  }
                }
                else{
                  var arrayProductosEstandar=eval('arrayProductosEstandar_'+idSubfamilia);
                  for(var k=0;k<arrayProductosEstandar.length;k++){
                    var addOption=crearElemento(arrayProductosEstandar[k][2],arrayProductosEstandar[k][0],elementoPorDefecto);
                    asignarElemento(form,objName,addOption);
                  }
                } 
              }
              
              asignarElementoSeleccionado(form,objName,elementoPorDefecto);
              
              // volvemos a llamar a la funcion para montar el desplegable de proveedores
              inicializarDesplegable(form,'PROVEEDORES',valorNulo);
  
            break;
            
            ////////////////////////////////
            //
            //      PROVEEDORES
            //
            ////////////////////////////////
            
            case 'PROVEEDORES':
            
              var idFamilia=form.elements['FAMILIAS'].value;
              var idSubfamilia=form.elements['SUBFAMILIAS'].value;
              var idProductoEstandar=form.elements['PRODUCTOSESTANDAR'].value
              
              
              form.elements[objName].options.length=0;
              
              // montamos el desplegable de proveedores
              
              // miramos si la subfamilia selecionada es 'TODAS', si lo es miramos si la familia seleccionada es TODAS
              // si lo es miramos si los Productos estandar son 'TODOS' si lo es recorremos todas las familias
              
              var algunElemento=0;
              
              if(idProductoEstandar==valorNulo){
                if(idSubfamilia==valorNulo){
                  if(idFamilia==valorNulo){
                    for(var n=0;n<arrayFamilias.length && !algunElemento;n++){
                      var arraySubfamilias=eval('arraySubfamilias_'+arrayFamilias[n][0]);
                      for(var i=0;i<arraySubfamilias.length && !algunElemento;i++){
                        var arrayProductosEstandar=eval('arrayProductosEstandar_'+arraySubfamilias[i][0]);
                        for(var j=0;j<arrayProductosEstandar.length && !algunElemento;j++){
                          var arrayProveedores=eval('arrayProveedores_'+arrayProductosEstandar[j][0]);
                          if(arrayProveedores.length>0){
                            algunElemento=1;
                          }
                        }
                      }
                    }
                  } 
                  else{
                    var arraySubfamilias=eval('arraySubfamilias_'+idFamilia);
                    for(var i=0;i<arraySubfamilias.length && !algunElemento;i++){
                      var arrayProductosEstandar=eval('arrayProductosEstandar_'+arraySubfamilias[i][0]);
                      for(var j=0;j<arrayProductosEstandar.length && !algunElemento;j++){
                        var arrayProveedores=eval('arrayProveedores_'+arrayProductosEstandar[j][0]);
                        if(arrayProveedores.length>0){
                          algunElemento=1;
                        }
                      }
                    }
                  }
                }
                else{
                  var arrayProductosEstandar=eval('arrayProductosEstandar_'+idSubfamilia);
                  for(var j=0;j<arrayProductosEstandar.length && !algunElemento;j++){
                    var arrayProveedores=eval('arrayProveedores_'+arrayProductosEstandar[j][0]);
                    if(arrayProveedores.length>0){
                      algunElemento=1;
                    }
                  }
                }
              }
              else{
                var arrayProveedores=eval('arrayProveedores_'+idProductoEstandar);
                if(arrayProveedores.length>0){
                  algunElemento=1;
                }
              }
              
              
              
              if(!algunElemento){
                var addOption=crearElemento(msgNingunProveedor,valorNulo,elementoPorDefecto);
                asignarElemento(form,objName,addOption);
              }
              else{
                var addOption=crearElemento(msgTituloProveedor,valorNulo,elementoPorDefecto);
                asignarElemento(form,objName,addOption);
                
                
                
                
                if(idProductoEstandar==valorNulo){
                  if(idSubfamilia==valorNulo){
                    if(idFamilia==valorNulo){
                      var algunElemento=0;
                      for(var n=0;n<arrayFamilias.length && !algunElemento;n++){
                        var arraySubfamilias=eval('arraySubfamilias_'+arrayFamilias[n][0]);
                        for(var i=0;i<arraySubfamilias.length;i++){
                          var arrayProductosEstandar=eval('arrayProductosEstandar_'+arraySubfamilias[i][0]);
                          for(var k=0;k<arrayProductosEstandar.length;k++){
                            var arrayProveedores=eval('arrayProveedores_'+arrayProductosEstandar[k][0]);
                            for(var j=0;j<arrayProveedores.length;j++){
                              if(!elementoYaInsertado(form,objName,arrayProveedores[j][1])){
                                var addOption=crearElemento(arrayProveedores[j][1],arrayProveedores[j][0],elementoPorDefecto);
                                asignarElemento(form,objName,addOption);
                              }
                            }
                          }
                        }
                      }
                    } 
                    else{
                      var arraySubfamilias=eval('arraySubfamilias_'+idFamilia);
                      for(var i=0;i<arraySubfamilias.length;i++){
                        var arrayProductosEstandar=eval('arrayProductosEstandar_'+arraySubfamilias[i][0]);
                        for(var k=0;k<arrayProductosEstandar.length;k++){
                          var arrayProveedores=eval('arrayProveedores_'+arrayProductosEstandar[k][0]);
                          for(var j=0;j<arrayProveedores.length;j++){
                            if(!elementoYaInsertado(form,objName,arrayProveedores[j][1])){
                              var addOption=crearElemento(arrayProveedores[j][1],arrayProveedores[j][0],elementoPorDefecto);
                              asignarElemento(form,objName,addOption);
                            }
                          }
                        }
                      }
                    }
                  }
                  else{
                    var arrayProductosEstandar=eval('arrayProductosEstandar_'+idSubfamilia);
                    for(var k=0;k<arrayProductosEstandar.length;k++){
                      var arrayProveedores=eval('arrayProveedores_'+arrayProductosEstandar[k][0]);
                      for(var j=0;j<arrayProveedores.length;j++){
                        if(!elementoYaInsertado(form,objName,arrayProveedores[j][1])){
                          var addOption=crearElemento(arrayProveedores[j][1],arrayProveedores[j][0],elementoPorDefecto);
                          asignarElemento(form,objName,addOption);
                        }
                      }
                    }
                  } 
                }
                else{
                  var arrayProveedores=eval('arrayProveedores_'+idProductoEstandar);
                  for(var j=0;j<arrayProveedores.length;j++){
                    if(!elementoYaInsertado(form,objName,arrayProveedores[j][1])){
                      var addOption=crearElemento(arrayProveedores[j][1],arrayProveedores[j][0],elementoPorDefecto);
                      asignarElemento(form,objName,addOption);
                    }
                  }
                }
              }
              
              asignarElementoSeleccionado(form,objName,elementoPorDefecto);
              
              // volvemos a llamar a la funcion para montar el desplegable de productos
              inicializarDesplegable(form,'PRODUCTOS',valorNulo);
            
            break;
          }
        }
        
        
        
        
        
        function elementoYaInsertado(form,objName,valor){
          for(var n=0;n<form.elements[objName].options.length;n++){
            if(form.elements[objName].options[n].text==valor){
              return true;
            }
          }
          return false;
        }
        
        function crearElemento(texto,id,elementoPorDefecto){
          
          var textoTmp;
          
          if(id==elementoPorDefecto){
            textoTmp='['+texto+']';
          }
          else{
            textoTmp=texto;
          }
        
          var addOption=new Option(textoTmp,id);
          
          return addOption;
        }
        
        function asignarElemento(form,objName,opcion){
          form.elements[objName].options[form.elements[objName].options.length]=opcion;
        }
        
        function asignarElementoSeleccionado(form,objName,elementoPorDefecto){
          var encontrado=0;
          for(var n=0;n<form.elements[objName].options.length && !encontrado;n++){
            if(form.elements[objName].options[n].value==elementoPorDefecto){
              encontrado=1;
              form.elements[objName].selectedIndex=n;
            }
          }
          if(!encontrado){
            form.elements[objName].selectedIndex=0;
          }
        }
        
        function obtenerIdAmpliado(nombre,posicion){
          var nombreTmp=nombre+'_';

          var posicionPrimero=-1;
          var posicionSegundo=-1;

          var encontrados=0;

          var id;

          for(var n=0;n<nombreTmp.length-1;n++){
            if(nombreTmp.substring(n,n+1)=='_'){
              encontrados++;
              if(encontrados==posicion){
                posicionPrimero=n;
              }
              else{
                if(encontrados==posicion+1){
                  posicionSegundo=n;
                }
              }
            }
          }
          if(posicionPrimero!=-1 && posicionSegundo!=-1){
            id=nombreTmp.substring(posicionPrimero+1,posicionSegundo);
          }
          else{
            id=-1;
          }

          return id;
        }
        
        
        function iniciarProceso(accion){
        
          var accionTmp;
          
          var objFrame=new Object();
          objFrame=obtenerFrame(top,'NoConformidad');
          
          if(objFrame.document.forms['form1'].elements['STATUS'].value<=10){
          
            if(accion==''){
              accionTmp='FAMILIAS';
              habilitarDeshabilitarDesplegable(objFrame.document.forms['form1'],'SUBFAMILIAS','D');
              habilitarDeshabilitarDesplegable(objFrame.document.forms['form1'],'PRODUCTOSESTANDAR','D');
              habilitarDeshabilitarDesplegable(objFrame.document.forms['form1'],'PROVEEDORES','D');
            }
            else{
              accionTmp=accion;
            }
            var objFrame=new Object();
            objFrame=obtenerFrame(top,'NoConformidad');
            inicializarDesplegable(objFrame.document.forms['form1'],accionTmp,valorNulo);
          
            if(accion=='FAMILIA' || accion==''){
              inicializarDatosFamilia(objFrame);
            }
            else{
              inicializarDatosSubfamilia(objFrame);
            }
          }
        }
        
        function inicializarDatosFamilia(objFrame){
          if(objFrame.hayQueInicializar){
            asignarElementoSeleccionado(objFrame.document.forms['form1'],'FAMILIAS',objFrame.idFamiliaInicial);
            if(objFrame.idFamiliaInicial!='-1'){
              objFrame.inicializarDesplegable(objFrame.document.forms['form1'],'FAMILIAS',objFrame.idFamiliaInicial);
            }
          }
        }
        
        function inicializarDatosSubfamilia(objFrame){
          if(objFrame.hayQueInicializar){
            objFrame.inicializarDesplegable(objFrame.document.forms['form1'],'SUBFAMILIAS',objFrame.idSubfamiliaInicial);
            asignarElementoSeleccionado(objFrame.document.forms['form1'],'SUBFAMILIAS',objFrame.idSubfamiliaInicial);
            
            objFrame.inicializarDesplegable(objFrame.document.forms['form1'],'PRODUCTOSESTANDAR',objFrame.idProductoEstandarInicial);
            asignarElementoSeleccionado(objFrame.document.forms['form1'],'PRODUCTOSESTANDAR',objFrame.idProductoEstandarInicial);
            objFrame.inicializarDesplegable(objFrame.document.forms['form1'],'PROVEEDORES',objFrame.idProveedorInicial);
            asignarElementoSeleccionado(objFrame.document.forms['form1'],'PROVEEDORES',objFrame.idProveedorInicial);
            
            if(objFrame.idFamiliaInicial!='-1'){
              habilitarDeshabilitarDesplegable(objFrame.document.forms['form1'],'SUBFAMILIAS','H');
              habilitarDeshabilitarDesplegable(objFrame.document.forms['form1'],'PRODUCTOSESTANDAR','H');
              habilitarDeshabilitarDesplegable(objFrame.document.forms['form1'],'PROVEEDORES','H');
            }
            
            objFrame.hayQueInicializar=0; 
          }
        }
         
     //-->
    </script>
    ]]></xsl:text>
  </head>

<body bgcolor="#FFFFFF">
  <xsl:choose>
  <xsl:when test="//SESION_CADUCADA">
    <xsl:apply-templates select="//SESION_CADUCADA"/> 
  </xsl:when>
  <xsl:when test="//ROWSET/ROW/Sorry">
    <xsl:apply-templates select="//ROWSET/ROW/Sorry"/> 
  </xsl:when>
  <xsl:otherwise>
  <xsl:attribute name="onLoad">iniciarProceso('<xsl:value-of select="Mantenimiento/ACCION"/>');</xsl:attribute>
  


  </xsl:otherwise>
</xsl:choose>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>
