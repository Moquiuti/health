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
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->

    <title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_catalogo_privado']/node()"/></title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/detalleProdEstandar110711.js"></script>

    <xsl:text disable-output-escaping="yes"><![CDATA[
    <script language="javascript">
      <!--

   var msgSinCambiosAdjudicaturas='No hay ning�n producto para adjudicar.';
        var msgDesadjudicarProducto='�Quiere mantener el producto seleccionado como ADJUDICADO?';

        var msgSinProductoAnterior='Las subfamilias anteriores no contienen ning�n producto est�ndar';
        var msgSinProductoPosterior='Las restantes subfamilias no contienen ning�n producto est�ndar';

        var msgSinEvaluacion='El proveedor est� marcado como apto por hist�rico. No se puede iniciar la evaluaci�n.';

        var msgDesadjudicado='Al marcar este producto como NO ADJUDICADO se eliminar� de las plantillas que lo contegan';

        var msgSinProveedor='El proveedor para el que quiere iniciar la evaluaci�n no existe en la Base de Datos de MedicalVM. Por favor, contacte con MedicalVM.';

        //var algunCambio=0;

        var CambiosTmp='';


        function obtenerPosicionEnElArray(valor, array){
          for(var n=0;n<array.length;n++){
            if(valor==array[n][0]){
              return n;
            }
          }
          return -1;
        }

        function esFueraDeRango(posicionEnElArray,incremento,array){
          if(parseInt(posicionEnElArray+incremento)<0){
            return -1;
          }
          else{
            if(parseInt(posicionEnElArray+incremento)>array.length-1){
              return -2;
            }
            else{
              return parseInt(posicionEnElArray+incremento);
            }
          }
        }

        function cambiarProducto(incremento){

          //alert(incremento);

          var objFrame=new Object();
          objFrame=obtenerFrame(top,'zonaCatalogo');
          var idProductoSeleccionado=objFrame.obtenerIdProductoEstandar();
          var idSubFamiliaSeleccionada=objFrame.obtenerIdSubfamilia();

          var posicionProductoEstandarEnElArray=obtenerPosicionEnElArray(idProductoSeleccionado,arrayProductosEstandar);
          var posicionSubfamiliaEnElArray=obtenerPosicionEnElArray(idSubFamiliaSeleccionada,arraySubfamilias);
          var siguientePosicionProductoEstandar;
          var siguientePosicionSubfamilia;

          //alert(arrayProductosEstandar);
          //alert(arraySubfamilias);

          // es fuera de rango del producto
          if((siguientePosicionProductoEstandar=esFueraDeRango(posicionProductoEstandarEnElArray,incremento,arrayProductosEstandar))<0){
            // por el inicio
            if(siguientePosicionProductoEstandar==-1){
              // es fuera de rango de la subfamilia
              if((siguientePosicionSubfamilia=esFueraDeRango(posicionSubfamiliaEnElArray,incremento,arraySubfamilias))<0){
                // por el inicio
                if(siguientePosicionSubfamilia==-1){
                  // avisamos de que no se puede retroceder mas
                  alert(msgSinProductoAnterior);
                }
              }
              // podemos retroceder una familia
              else{
                //alert('incremento: '+incremento+'\nposicionProductoEstandarEnElArray'+posicionProductoEstandarEnElArray+'\nsiguientePosicionProductoEstandar'+siguientePosicionProductoEstandar+'\nposicionSubfamiliaEnElArray'+posicionSubfamiliaEnElArray+'\nsiguientePosicionSubfamilia'+siguientePosicionSubfamilia);

                // cargamos el ultimo producto de la subfamilia anterior
	              var nombreArray='arrayMaestroProductosEstandar_'+objFrame.document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].options[siguientePosicionSubfamilia].value;

	              if(objFrame.eval(nombreArray).length==0){

                  var familiaEncontrada=0;

                  while(!familiaEncontrada){
                    incremento--;
                    siguientePosicionSubfamilia=esFueraDeRango(posicionSubfamiliaEnElArray,incremento,arraySubfamilias);
                    if(siguientePosicionSubfamilia==-1){
                      alert(msgSinProductoAnterior);
                      familiaEncontrada=1;
                      return;
                    }
                    else{
                      var nombreArray='arrayMaestroProductosEstandar_'+objFrame.document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].options[siguientePosicionSubfamilia].value;
                      if(objFrame.eval(nombreArray).length==0){
                        familiaEncontrada=0;
                      }
                      else{
                        familiaEncontrada=1;
                      }
                    }
                  }
                }


	              var idUltimoProductoDeLaLista=objFrame.eval(nombreArray)[objFrame.eval(nombreArray).length-1][0];

                objFrame.document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].selectedIndex=siguientePosicionSubfamilia;
                objFrame.actualizarValorPorDefectoEnElArray(arraySubfamilias[siguientePosicionSubfamilia][0],'CAMBIOSUBFAMILIA',idUltimoProductoDeLaLista);

                ]]></xsl:text>
                  var idProductoEstandar=objFrame.obtenerIdProductoEstandar();
                  var idSubfamilia=objFrame.obtenerIdSubfamilia();
                  var idFamilia='<xsl:value-of select="//Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDFAMILIA"/>';
                <xsl:text disable-output-escaping="yes"><![CDATA[

                var objFrame=new Object();
                objFrame=obtenerFrame(top,'zonaProducto');

                objFrame.VerDetallesProductoEstandar(idProductoEstandar,idSubfamilia, idFamilia);

              }
            }
            // por el final
            else{
              // es fuera de rango de la subfamilia
              if((siguientePosicionSubfamilia=esFueraDeRango(posicionSubfamiliaEnElArray,incremento,arraySubfamilias))<0){
                // por el final
                if(siguientePosicionSubfamilia==-2){
                  // avisamos de que no se puede avanzar mas
                  alert(msgSinProductoPosterior);
                }
              }
              // podemos avanzar una familia
              else{

                //miramos que tenga productos, si no saltamos la siguiente subfamilia y asi sucesivamente
                var nombreArray='arrayMaestroProductosEstandar_'+objFrame.document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].options[siguientePosicionSubfamilia].value;

                if(objFrame.eval(nombreArray).length==0){

                  var familiaEncontrada=0;

                  while(!familiaEncontrada){
                    incremento++;
                    siguientePosicionSubfamilia=esFueraDeRango(posicionSubfamiliaEnElArray,incremento,arraySubfamilias);
                    if(siguientePosicionSubfamilia==-2){
                      alert(msgSinProductoPosterior);
                      familiaEncontrada=1;
                      return;
                    }
                    else{
                      var nombreArray='arrayMaestroProductosEstandar_'+objFrame.document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].options[siguientePosicionSubfamilia].value;
                      if(objFrame.eval(nombreArray).length==0){
                        familiaEncontrada=0;
                      }
                      else{
                        familiaEncontrada=1;
                      }
                    }
                  }
                }

                //alert('incremento: '+incremento+'\nposicionProductoEstandarEnElArray'+posicionProductoEstandarEnElArray+'\nsiguientePosicionProductoEstandar'+siguientePosicionProductoEstandar+'\nposicionSubfamiliaEnElArray'+posicionSubfamiliaEnElArray+'\nsiguientePosicionSubfamilia'+siguientePosicionSubfamilia);
                objFrame.document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].selectedIndex=siguientePosicionSubfamilia;
                objFrame.actualizarValorPorDefectoEnElArray(arraySubfamilias[siguientePosicionSubfamilia][0],'CAMBIOSUBFAMILIA');


                ]]></xsl:text>
                  var idProductoEstandar=objFrame.obtenerIdProductoEstandar();
                  var idSubfamilia=objFrame.obtenerIdSubfamilia();
                  var idFamilia='<xsl:value-of select="//Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDFAMILIA"/>';
                <xsl:text disable-output-escaping="yes"><![CDATA[

                var objFrame=new Object();
                objFrame=obtenerFrame(top,'zonaProducto');

                objFrame.VerDetallesProductoEstandar(idProductoEstandar,idSubfamilia, idFamilia);


              }
            }
          }
          else{
            //alert('incremento: '+incremento+'\nposicionProductoEstandarEnElArray'+posicionProductoEstandarEnElArray+'\nsiguientePosicionProductoEstandar'+siguientePosicionProductoEstandar+'\nposicionSubfamiliaEnElArray'+posicionSubfamiliaEnElArray+'\nsiguientePosicionSubfamilia'+siguientePosicionSubfamilia);
            // podemos avanzar / retroceder producto
            objFrame.document.forms['form1'].elements['CATPRIV_IDPRODUCTOESTANDAR'].selectedIndex=siguientePosicionProductoEstandar;
            objFrame.actualizarValorPorDefectoEnElArray(arrayProductosEstandar[siguientePosicionProductoEstandar][0],'CAMBIOPRODUCTOESTANDAR');
            objFrame.CargarProductoEstandar(arrayProductosEstandar[siguientePosicionProductoEstandar][0]);

            var objFrame=new Object();
            objFrame=obtenerFrame(top,'zonaProducto');

            ]]></xsl:text>
              var idSubfamilia='<xsl:value-of select="//Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDSUBFAMILIA"/>';
              var idFamilia='<xsl:value-of select="//Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDFAMILIA"/>';
            <xsl:text disable-output-escaping="yes"><![CDATA[

            objFrame.VerDetallesProductoEstandar(arrayProductosEstandar[siguientePosicionProductoEstandar][0],idSubfamilia, idFamilia);
          }
        }

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

        function EstadoEvaluacion(idActa,idProveedorProducto,accion,desde){

          if(document.forms['form1'].elements['APTOHISTORICO_'+idProveedorProducto].checked==false){
            AdjudicarProductos(document.forms['form1']);
            MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActaEvaluacion.xsql?IDACTA='+idActa+'&IDPROVEEDORPRODUCTO='+idProveedorProducto+'&ACCION='+accion+'&DESDE='+desde,'actaEvaluacion',75,70,0,0);
            recargarPagina('PROPAGAR');
          }
          else{
            mensajeSinEvaluacion();
          }
        }



        arrayProductosEstandar=new Array();
        arraySubfamilias=new Array();

        ]]></xsl:text>

          <xsl:for-each select="Mantenimiento/PRODUCTOSESTANDAR/field/dropDownList/listElem">
            arrayProductosEstandar[arrayProductosEstandar.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="../../@current"/>');
          </xsl:for-each>

          <xsl:for-each select="Mantenimiento/SUBFAMILIAS/field/dropDownList/listElem">
            arraySubfamilias[arraySubfamilias.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="../../@current"/>');
          </xsl:for-each>

        <xsl:text disable-output-escaping="yes"><![CDATA[

       function CerrarVentana(){

           var objFrameTop=new Object();
           objFrameTop=window.opener.top;

           var objFrame=new Object();
           objFrame=obtenerFrame(objFrameTop,'zonaProducto');
             if(objFrame!=null && objFrame.recargarPagina){
               objFrame.recargarPagina();
             }
             else{
               if(objFrame!=null){
                 Refresh(objFrame.document);
               }
             }
         window.close();
        }



        function recargarPagina(propagar){

          ]]></xsl:text>
            var idNuevoProductoEstandar='<xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDPRODUCTOESTANDAR"/>';
            var idNuevaSubfamilia='<xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDSUBFAMILIA"/>';
            var idNuevaFamilia='<xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDFAMILIA"/>';
            var idEmpresa='<xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDEMPRESA"/>';
            var productoActual='<xsl:value-of select="Mantenimiento/PRODUCTOACTUAL"/>';
            var subfamiliaActual='<xsl:value-of select="Mantenimiento/SUBFAMILIAACTUAL"/>';
            var ventana='<xsl:value-of select="Mantenimiento/VENTANA"/>';
          <xsl:text disable-output-escaping="yes"><![CDATA[

         if(ventana!='NUEVA'){
           var objFrameTop=new Object();
           if(window.opener){
             objFrameTop=window.opener.top;
           }
           else{
             objFrameTop=window.top;
           }
           var objFrame=new Object();

           objFrame=obtenerFrame(objFrameTop,'zonaCatalogo');

           if(propagar=='PROPAGAR'){
             if(objFrame!=null && objFrame.CargarProductoEstandar){
               objFrame.CargarProductoEstandar(objFrame.obtenerIdProductoEstandar(),'NOPROPAGAR');
             }
             else{
               if(objFrame!=null){
                 Refresh(objFrame.document);
               }
             }
           }
         }
         document.location.href='http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/DetalleProductoEstandar.xsql?IDNUEVOPRODUCTOESTANDAR='+idNuevoProductoEstandar+'&IDNUEVASUBFAMILIA='+idNuevaSubfamilia+'&IDEMPRESA='+idEmpresa+'&PRODUCTOACTUAL='+productoActual+'&SUBFAMILIAACTUAL='+subfamiliaActual+'&IDNUEVAFAMILIA='+idNuevaFamilia+'&VENTANA='+ventana;
        }


        function AdjudicarProductos(form){


          ]]></xsl:text>
            var idNuevoProductoEstandar='<xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDPRODUCTOESTANDAR"/>';
            var idNuevaSubfamilia='<xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDSUBFAMILIA"/>';
            var idNuevaFamilia='<xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDFAMILIA"/>';
            var idEmpresa='<xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDEMPRESA"/>';
            var productoActual='<xsl:value-of select="Mantenimiento/PRODUCTOACTUAL"/>';
            var subfamiliaActual='<xsl:value-of select="Mantenimiento/SUBFAMILIAACTUAL"/>';
            var ventana='<xsl:value-of select="Mantenimiento/VENTANA"/>';
          <xsl:text disable-output-escaping="yes"><![CDATA[

          var cadenaCambios='';

          for(var n=0;n<form.length;n++){
            if(form.elements[n].name.substring(0,14)=='CHKADJUDICADO_'){

              //if(form.elements[n].disabled==false){

                var idProveedor=obtenerId(form.elements[n].name);
                var adjudicado;
                var aptoPorHistorico;

                //if(algunCambio==0){
                //  algunCambio=1;
                //}

                if(form.elements[n].checked==true){
                  adjudicado='S';
                }
                else{
                  adjudicado='N';
                }

                if(form.elements['APTOHISTORICO_'+idProveedor].checked==true){
                  aptoPorHistorico='S';
                }
                else{
                  aptoPorHistorico='';
                }

                cadenaCambios+=idProveedor+'|'+adjudicado+'|'+aptoPorHistorico+'#';
                //cadenaCambios+=idProveedor+'|'+adjudicado+'#';
              //}
            }
          }

          //if(algunCambio){
            form.elements['CAMBIOSADJUDICATURAS'].value=cadenaCambios;
            form.elements['ACCION'].value='ADJUDICARPRODUCTOS';

            if(ventana!='NUEVA'){
              var objFrameTop=new Object();
              objFrameTop=window.top;

              var objFrame=new Object();
              objFrame=obtenerFrame(objFrameTop,'zonaProducto');
              objFrame.location.href='about:blank';
            }

            form.action+='?IDNUEVOPRODUCTOESTANDAR='+idNuevoProductoEstandar+'&IDNUEVASUBFAMILIA='+idNuevaSubfamilia+'&IDEMPRESA='+idEmpresa+'&PRODUCTOACTUAL='+productoActual+'&SUBFAMILIAACTUAL='+subfamiliaActual+'&IDNUEVAFAMILIA='+idNuevaFamilia+'&VENTANA='+ventana;
            SubmitForm(form);
          //}
          //else{
          //  alert(msgSinCambiosAdjudicaturas);
          //  form.elements['ACCION'].value='';
          //}

        }

        function RefrescarZonaCatalogo(){
          var objFrameTop=new Object();
          objFrameTop=window.top;

          var objFrame=new Object();
          objFrame=obtenerFrame(objFrameTop,'zonaCatalogo');

          if(objFrame!=null && objFrame.recargarPagina){
            objFrame.recargarPagina();
          }
          else{
            Refresh(objFrame.document);
          }
        }

        function RefrescarZonaProducto(){
          var objFrameTop=new Object();
          objFrameTop=window.top;

          var objFrame=new Object();
          objFrame=obtenerFrame(objFrameTop,'zonaCatalogo');

          if(arguments.length==1){
            var propagar='PROPAGAR';
          }
          else{
            var propagar='NOPROPAGAR';
          }

          objFrame.CargarProductoEstandar(objFrame.obtenerIdProductoEstandar(),'NOPROPAGAR');
        }

        function habilitarAptoPorHistorico(objCheck){

          var textoNoIniciado='No Iniciado';
          var textoAptoHistorico='APTO';

          //if(algunCambio==0){
          //  algunCambio=1;
          //}

          var id=obtenerId(objCheck.name);


          if(objCheck.checked==true){
             document.forms['form1'].elements['CHKADJUDICADO_'+id].disabled=false;

          }
          else{
            if(document.forms['form1'].elements['CHKADJUDICADO_'+id].checked==true){
              if(!confirm(msgDesadjudicarProducto+'\n\n'+msgDesadjudicado)){
                document.forms['form1'].elements['CHKADJUDICADO_'+id].checked=false;
                document.forms['form1'].elements['CHKADJUDICADO_'+id].disabled=true;
              }
            }
            //document.forms['form1'].elements['CHKADJUDICADO_'+id].disabled=true;

          }
        }

        function mensajeSinEvaluacion(){
          alert(msgSinEvaluacion);
          return false;
        }

        function avisoDesadjudicado(obj){
          if(obj.checked!=true){
            alert(msgDesadjudicado);
          }
          //var idProveedor=obtenerId(obj.name);
          //var adjudicacionProveedor=obtenerDatosAdjudicacion(idProveedor,CambiosTmp);

          //alert(adjudicacionProveedor);

          //CambiosTmp
          //MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ComentarioCambioAdjudicacion.htm','motivoCambio',50,30 ,0,0);
        }

        // idproveedor|valorInicial|ValorCambio|comentario|idusuario#

        function obtenerDatosAdjudicacion(idProveedor,cadenaCambios){
          var datosAdjudicacion='';
          if(cadenaCambios!=''){
            var arrProveedores=cadenaCambios.split('#');
            for(var n=0;n<arrProveedores.length;n++){
              arrDatosAdjudicacion=arrProveedores[n].split('|');
              if(arrDatosAdjudicacion[0]==idProveedor){
                datosAdjudicacion=arrProveedores[n];
                return datosAdjudicacion;
              }
            }
          }
          return datosAdjudicacion;
        }

        //cambiar fecha limite
        function cambiaFecha(){
            var form = document.forms['form1'];
            var fechaLimite = 'FECHA_LIMITE';
            var enviarFechaLimite = 'EnviarFecha';
            var modificarFechaLimite = 'ModificaFecha';

            form.elements[fechaLimite].setAttribute('class','');
            //form.elements[fechaLimite].setAttribute('enabled','enabled');
            jQuery("#"+modificarFechaLimite).hide();
            jQuery("#"+enviarFechaLimite).show();

        }


			//actualizarFechaLimite funcion de la pagina actualizarFechaLimite
			function actualizarFechaLimite(){
			var form = document.forms['form1'];
			var msg = '';
			var idProd = form.elements['IDPRODUCTO'].value;
			var idCliente = form.elements['CLIENTE_ID'].value;
			var valueFechaLimite = form.elements['FECHA_LIMITE'].value;
			var errorFechaLimite = document.forms['mensajeJS'].elements['ERROR_GUARDAR_FECHA'].value;
			var fechaLimite = 'FECHA_LIMITE';
			var enviarFechaLimite = 'EnviarFecha';
			var modificarFechaLimite = 'ModificaFecha';

			if (form.elements['FECHA_LIMITE'].value == ''){ msg += document.forms['mensajeJS'].elements['FECHA_LIMITE_OBLI'].value;}

			if (msg == ''){

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActualizarFechaLimiteCat.xsql',
					type:	"GET",
					data:	"PRO_ID="+idProd+"&CLIENTE_ID="+idCliente+"&FECHA_LIMITE="+valueFechaLimite,
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.ActualizarFechaLimite.estado == 'OK'){
							form.elements[fechaLimite].setAttribute('class','noinput');
							//form.elements[fechaLimite].setAttribute('disabled','disabled');
							jQuery("#"+modificarFechaLimite).show();
							jQuery("#"+enviarFechaLimite).hide();
						}
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});

				//form.action = "ActualizarFechaLimite.xsql?PRO_ID="+idProd+"&CLIENTE_ID="+idCliente+"&FECHA_LIMITE="+fechaLimite;
				//SubmitForm(form);

			}
			else { alert(msg);}

		}// fin de actualizarFechaLimite

          //-->
    </script>
    ]]></xsl:text>

  </head>
  <body class="gris">

  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->

<xsl:choose>
  <xsl:when test="CarpetasYPlantillas/SESION_CADUCADA">
    <xsl:apply-templates select="CarpetasYPlantillas/SESION_CADUCADA"/>
  </xsl:when>
  <xsl:when test="CarpetasYPlantillas/ROWSET/ROW/Sorry">
    <xsl:apply-templates select="CarpetasYPlantillas/ROWSET/ROW/Sorry"/>
  </xsl:when>
  <xsl:otherwise>

    <xsl:choose>
      <xsl:when test="Mantenimiento/DETALLEPRODUCTOESTANDAR/REFRESCARZONACATALOGO">
        <xsl:if test="Mantenimiento/VENTANA!='NUEVA'">
          <xsl:attribute name="onLoad">RefrescarZonaCatalogo();</xsl:attribute>
        </xsl:if>
      </xsl:when>
      <xsl:when test="Mantenimiento/DETALLEPRODUCTOESTANDAR/REFRESCARZONAPRODUCTO">
        <xsl:if test="Mantenimiento/VENTANA!='NUEVA'">
          <xsl:attribute name="onLoad">RefrescarZonaProducto();</xsl:attribute>
        </xsl:if>
      </xsl:when>
    </xsl:choose>
    <form name="form1" action="DetalleProductoEstandar.xsql" method="post">


    <table class="infoTable">
      <tr class="titleTabla">
	        <xsl:if test="Mantenimiento/VENTANA!='NUEVA'">
	        <th class="veinte">

	          <!--<xsl:choose>
	            <xsl:when test="not(Mantenimiento/SUBFAMILIAACTUAL=1 and Mantenimiento/PRODUCTOACTUAL=1)">
                  <img src="http://www.newco.dev.br/images/anterior.gif" alt="anterior" />&nbsp;
	              <xsl:call-template name="botonPersonalizado">
	                <xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></xsl:with-param>
	                <xsl:with-param name="status">Seleccionar el producto est�ndar anterior</xsl:with-param>
	                <xsl:with-param name="funcion">cambiarProducto(-1);</xsl:with-param>
	              </xsl:call-template>
	            </xsl:when>
	            <xsl:otherwise>
	              &nbsp;
	            </xsl:otherwise>
	          </xsl:choose>-->
	        </th>
	        </xsl:if>
	        <th class="sesanta">
	         <h1><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_estandar']/node()"/></h1>
	        </th>
	        <xsl:if test="Mantenimiento/VENTANA!='NUEVA'">
	        <th class="veinte">

	         <!-- <xsl:choose>
	            <xsl:when test="not(Mantenimiento/SUBFAMILIAACTUAL=count(Mantenimiento/SUBFAMILIAS/field/dropDownList/listElem) and Mantenimiento/PRODUCTOACTUAL=count(Mantenimiento/PRODUCTOSESTANDAR/field/dropDownList/listElem))">

	              <xsl:call-template name="botonPersonalizado">
	                <xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></xsl:with-param>
	                <xsl:with-param name="status">Seleccionar el siguiente producto est�ndar</xsl:with-param>
	                <xsl:with-param name="funcion">cambiarProducto(1);</xsl:with-param>
	              </xsl:call-template>
                  &nbsp;<img src="http://www.newco.dev.br/images/siguiente.gif" alt="anterior" />
	            </xsl:when>
	            <xsl:otherwise>
	              &nbsp;
	            </xsl:otherwise>
	          </xsl:choose>-->
	        </th>
	        </xsl:if>
	      </tr>
	</table><!--fin de title-->

 <!--contenido, datos prod +tables-->
 <div class="divleft gris">

 <!--datos producto-->
 <div class="divLeft">
   <table class="infoTable" border="0">
        <input type="hidden" name="PRO_IDUSUARIO"/>
        <input type="hidden" name="ACCION"/>
        <input type="hidden" name="CAMBIOSADJUDICATURAS"/>
        <input type="hidden" name="IDNUEVOPRODUCTOESTANDAR" value="{Mantenimiento/IDNUEVOPRODUCTOESTANDAR}"/>
        <input type="hidden" name="ACTION" value=""/>
        <input type="hidden" name="ID_EMPRESA" value=""/>
        <input type="hidden" name="ID_PRODUCTO" value=""/>
        	<tr><td colspan="8">&nbsp;</td></tr>
            <tr>
              <td class="labelRight veintecinco">
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:
              </td>
              <td class="datosLeft" colspan="7" style="font-size:13px;">
               <strong><xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/NOMBREPRODUCTOESTANDAR"/></strong>
              </td>
            </tr>

            <tr>
             <td class="labelRight">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:
              </td>
              <td class="datosleft cinco">
                <strong><xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/REFERENCIAPRODUCTOESTANDAR"/></strong>
                <input type="hidden" name="IDPRODUCTOESTANDAR" value="{Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDPRODUCTOESTANDAR}" size="10" maxlength="6"/>
                <input type="hidden" name="IDPRODUCTO" value="{Mantenimiento/DETALLEPRODUCTOESTANDAR/PROVEEDORESADSCRITOS/PROVEEDOR/IDPRODUCTO}"/>
              </td>

               <td class="labelRight dies">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>:
              </td>
              <td class="datosLeft dies">
                <xsl:choose>
                  <xsl:when test="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/PRECIOREFERENCIA=''">
                    --
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/PRECIOREFERENCIA"/>
                  </xsl:otherwise>
                </xsl:choose>
                &nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>
              </td>
              <td class="labelRight dies">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/>:
              </td>
              <td class="datosleft cinco">
                <xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/FECHAALTA"/>
              </td>
               <td class="labelRight dies">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/>:
              </td>
              <td class="datosleft">
              	<!--modificar fecha limite oferta MVM, precio
                 <xsl:if test="/Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/FECHALIMITEOFERTA">-->
                    <input type="text" name="FECHA_LIMITE" id="FECHA_LIMITE" value="{/Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/FECHALIMITEOFERTA}" class="noinput" size="10"/>
                    <input type="hidden" name="CLIENTE_ID" id="CLIENTE_ID" value="{/Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/IDEMPRESA}" />

                    <a style="text-decoration:none;" href="javascript:cambiaFecha();" id="ModificaFecha">
                        <img src="http://www.newco.dev.br/images/modificar.gif" alt="Modificar Fecha" />
                    </a>
                    <a style="text-decoration:none;display:none;" href="javascript:actualizarFechaLimite();" id="EnviarFecha">
                        <img src="http://www.newco.dev.br/images/botonEnviar.gif" alt="Enviar Fecha L�mite" />
                    </a>

              </td>


            </tr>

            <xsl:if test="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/DESCRIPCIONPRODUCTOESTANDAR != '' or Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/UDBASE != ''">
            <tr>
            	<xsl:choose>
                <xsl:when test="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/DESCRIPCIONPRODUCTOESTANDAR != ''">
                  <td class="labelRight">
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:
                  </td>
                  <td class="datosLeft">
                   <xsl:copy-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/DESCRIPCIONPRODUCTOESTANDAR"/>
                  </td>
            	 </xsl:when>
                 <xsl:otherwise>
                 	<td colspan="2">&nbsp;</td>
                 </xsl:otherwise>
                 </xsl:choose>

                <xsl:choose>
                <xsl:when test="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/UDBASE != ''">
                   <td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>:
                  </td>
                  <td class="datosLeft">
                    <xsl:value-of select="Mantenimiento/DETALLEPRODUCTOESTANDAR/CABECERA/UDBASE"/>
                  </td>
                 </xsl:when>
                 <xsl:otherwise>
                 	<td colspan="2">&nbsp;</td>
                 </xsl:otherwise>
                 </xsl:choose>
            </tr>
            </xsl:if>
     </table><!--fin de datos Producto-->
     <br /><br />
    </div><!--fin datos producto divleft40nopa-->

    <div class="divLeft">
		<!--	Hist�rico de precios por Proveedor		-->
        <xsl:if test="Mantenimiento/DETALLEPRODUCTOESTANDAR/EDICION">

        <!--clientes-->
           <table class="grandeInicio">
           <xsl:choose>
           <xsl:when test="Mantenimiento/DETALLEPRODUCTOESTANDAR/EMPRESASEMPLANTILLADO/EMPRESA">
            <thead>
            <tr class="subTituloTabla">
              <th colspan="6"><xsl:value-of select="document($doc)/translation/texts/item[@name='Clientes']/node()"/> - <xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_que_tienen_emplantillado_producto']/node()"/></th>
            </tr>
            <tr class="familia">
                    <td><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></td>
                    <td><xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla']/node()"/></td>
                    <td><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
                    <td><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_producto']/node()"/></td>
                    <td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_producto']/node()"/></td>
                    <td><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='euros']/node()"/>)</td>
             </tr>
             </thead>
             <tbody>
                <xsl:for-each select="Mantenimiento/DETALLEPRODUCTOESTANDAR/EMPRESASEMPLANTILLADO/EMPRESA">
                	<tr>
                    		<td class="textLeft"><xsl:value-of select="NOMBRECLIENTE"/></td>
                    		<td class="textLeft"><xsl:value-of select="NOMBREPLANTILLA"/></td>
                    		<td class="textLeft"><xsl:value-of select="NOMBREPROVEEDOR"/></td>
                    		<td class="textLeft"><xsl:value-of select="REFERENCIAPROVEEDOR"/></td>
                    		<td class="textLeft"><xsl:value-of select="NOMBREPRODUCTO"/></td>
                    		<td class="textLeft" style="padding-left:20px;"><xsl:value-of select="PRECIOPRODUCTO"/></td>
                	</tr>
                </xsl:for-each>
              </tbody>

                </xsl:when>
            		  <xsl:otherwise>
                		   <thead>
            				<tr class="subTituloTabla">
                    		<td colspan="6">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_empresa_tiene_emplantillado']/node()"/>
                    		</td>
                		  </tr>
                          </thead>
            		  </xsl:otherwise>
            		</xsl:choose>
            </table><!--fin de table clientes-->
			<br /><br />

          <!--table proveedores-->
		   <table class="grandeInicio">
            <xsl:choose>
            <xsl:when test="Mantenimiento/DETALLEPRODUCTOESTANDAR/PROVEEDORESADSCRITOS/PROVEEDOR">
            <thead>
            <tr class="subTituloTabla">
              <th colspan="7"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/> - <xsl:value-of select="document($doc)/translation/texts/item[@name='productos_en_plantillas']/node()"/></th>
              </tr>
              <tr class="familia">
                    <td class="veinte" style="padding:3px 0px;">&nbsp;</td>
                    <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
                    <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>.</td>
                    <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></td>
                    <td class="dies">&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
             </thead>
             <tbody>
                <xsl:for-each select="Mantenimiento/DETALLEPRODUCTOESTANDAR/PROVEEDORESADSCRITOS/PROVEEDOR">
                  <tr>
                    <td>&nbsp;</td>
                    <td class="textLeft">
                       <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={PROV_ID}&amp;VENTANA=NUEVA','empresa',65,58,0,-50)" onMouseOver="window.status='Informaci�n sobre la empresa.';return true;" class="suave" onMouseOut="window.status='';return true;">
                        <xsl:value-of select="PROV_NOMBRE"/>
                      </a>
                    </td>
                    <td class="textLeft">
                        <a class="suave" onmouseover="window.status='Ver detalle del producto';return true;" onmouseup="window.status=' ';return true;" onmousedown="window.status=' ';return true;" onmouseout="window.status=' ';return true;" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={IDPRODUCTO}','producto',70,50,0,-50);">
                      <xsl:value-of select="REFERENCIAPRODUCTO"/>
                      </a>
                    </td>
                    <td class="textLeft">
                      <xsl:value-of select="PRECIOUNIDADBASICA"/>
                    </td>
                    <td>
                    	<div class="boton">
                        <a>
                        <xsl:attribute name="href">javascript:quitarDePLantilla('<xsl:value-of select="//IDEMPRESA"/>','<xsl:value-of select="IDPRODUCTO"/>');</xsl:attribute>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='quitar_de_plantilla']/node()"/></a></div>
                    </td>
                    <td><div id="waitBox">&nbsp;</div><div id="confirmBox">&nbsp;</div></td>
                  </tr>
                </xsl:for-each>
        </tbody>
         </xsl:when>
              <xsl:otherwise>
                 <thead>
            		<tr class="subTituloTabla">
                    <th>&nbsp;</th>
                    <th colspan="4" align="center">
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='ningun_proveedor']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_en_plantillas']/node()"/>
                    </th>
                    <th>&nbsp;</th>
                  </tr>
                </thead>
              </xsl:otherwise>
            </xsl:choose>
     </table><!--fin tabla proveedores-->
     <br /><br />
    </xsl:if>

          </div><!--fin de divLeft45nopa-->
       </div><!--fin de divleft de todos-->



    <xsl:if test="Mantenimiento/VENTANA='NUEVA'">

          <xsl:call-template name="boton">
            <xsl:with-param name="path" select="/Mantenimiento/botones/button[@label='Cancelar']"/>
          </xsl:call-template>

    </xsl:if>

  </form>
   <!--form de mensaje de error de js-->
   <form name="mensajeJS">
     <input type="hidden" name="FECHA_LIMITE_OBLI" id="FECHA_LIMITE_OBLI" value="{document($doc)/translation/texts/item[@name='fecha_limite_obli']/node()}" />
     <input type="hidden" name="ERROR_GUARDAR_FECHA" id="ERROR_GUARDAR_FECHA" value="{document($doc)/translation/texts/item[@name='error_guardar_fecha']/node()}" />
    </form>
 <!--fin de form de mensaje de error de js-->
  </xsl:otherwise>
  </xsl:choose>


  </body>
  </html>
</xsl:template>


<xsl:template match="ACTA_EVALUACION">

  <table width="100%" border="0">
    <tr>
      <td align="center" width="*">
        <!-- si existe el estado -->
        <xsl:choose>
          <xsl:when test="IDESTADO">
            <xsl:choose>
              <xsl:when test="IDESTADO>=50">
                <xsl:choose>
                  <xsl:when test="APTO='S'">
                    <input type="hidden" name="TEXTO_ESTADO_{../PROVEEDORPRODUCTO_ID}"  value="APTO"/>
                    <div width="100%" align="center" class="inputTranspVerde" style="color:navy;text-align:center;">APTO</div>
                    <!--<input type="text" name="TEXTO_ESTADO_{../PROVEEDORPRODUCTO_ID}" class="inputTranspVerde" style="color:navy;text-align:center;"   onFocus="this.blur();" size="20" value="APTO"/>-->
                    <!--<font color="NAVY" size="1">
    	              <b>APTO</b>
    	            </font>-->
                  </xsl:when>
                   <xsl:when test="APTO='N'">
                    <input type="hidden" name="TEXTO_ESTADO_{../PROVEEDORPRODUCTO_ID}" value="NO APTO"/>
                    <span width="100%" class="inputTranspVerde" style="color:red;text-align:center;">NO APTO</span>
                    <!--<input type="text" name="TEXTO_ESTADO_{../PROVEEDORPRODUCTO_ID}" class="inputTranspVerde" style="color:red;text-align:center;"  onFocus="this.blur();" size="20" value="NO APTO"/>-->
                    <!--<font color="RED" size="1">
    	              <b>NO APTO</b>
    	            </font>-->
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <input type="hidden" name="TEXTO_ESTADO_{../PROVEEDORPRODUCTO_ID}" value="{ESTADO}"/>
                <span width="100%" align="center" class="inputTranspVerde" style="font-weight:normal;text-align:center;"><xsl:value-of select="ESTADO"/></span>
    	        <!--<input type="text" name="TEXTO_ESTADO_{../PROVEEDORPRODUCTO_ID}" class="inputTranspVerde" style="color:normal; font-weight:normal; font-family:Verdana, Arial, Helvetica, sans-serif;text-align:center;"   onFocus="this.blur();" size="20" value="{ESTADO}"/>-->
                <!--<xsl:value-of select="ESTADO"/>-->
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
          <!-- no existe el estado -->
            <xsl:choose>
              <xsl:when test="../APTOHISTORICO='S'">
                <!--<font color="NAVY" size="1">
    	          <b>APTO</b>
    	        </font>-->
    	        <input type="text" name="TEXTO_ESTADO_{../PROVEEDORPRODUCTO_ID}" class="inputTranspVerde" style="color:navy;text-align:center;"   onFocus="this.blur();" size="20" value="APTO"/>
    	      </xsl:when>
    	      <xsl:otherwise>
    	        <input type="text" name="TEXTO_ESTADO_{../PROVEEDORPRODUCTO_ID}" class="inputTranspVerde" style="color:normal; font-weight:normal; font-family:Verdana, Arial, Helvetica, sans-serif;text-align:center;"   onFocus="this.blur();" size="20" value="{ESTADO}"/>
                <!--<xsl:value-of select="ESTADO"/>-->
              </xsl:otherwise>
            </xsl:choose>

          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td align="right" width="1px">
        <xsl:choose>
          <xsl:when test="../PROV_ID=''">
            <xsl:call-template name="botonPersonalizado">
              <xsl:with-param name="funcion">alert(msgSinProveedor)</xsl:with-param>
              <xsl:with-param name="estiloEnlace">cursor:default;color:#CCCCCC;</xsl:with-param>

              <xsl:with-param name="label"><xsl:value-of select="LABEL"/></xsl:with-param>
              <xsl:with-param name="status">Evaluaci�n del producto</xsl:with-param>
              <xsl:with-param name="ancho">50px</xsl:with-param>
              <xsl:with-param name="identificador"><xsl:value-of select="IDPROVEEDORPRODUCTO"/></xsl:with-param>
            </xsl:call-template>

          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="../APTOHISTORICO='S'">
                <xsl:call-template name="botonPersonalizado">
                <xsl:with-param name="funcion">EstadoEvaluacion('<xsl:value-of select="ID"/>','<xsl:value-of select="IDPROVEEDORPRODUCTO"/>','<xsl:value-of select="ACCION"/>','ACTA');</xsl:with-param>
                <xsl:with-param name="estiloEnlace">cursor:default;color:#CCCCCC;</xsl:with-param>
                <xsl:with-param name="label"><xsl:value-of select="LABEL"/></xsl:with-param>
                <xsl:with-param name="status">Evaluaci�n del producto</xsl:with-param>
                <xsl:with-param name="ancho">50px</xsl:with-param>
                <xsl:with-param name="identificador"><xsl:value-of select="IDPROVEEDORPRODUCTO"/></xsl:with-param>
              </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="botonPersonalizado">
                <xsl:with-param name="funcion">EstadoEvaluacion('<xsl:value-of select="ID"/>','<xsl:value-of select="IDPROVEEDORPRODUCTO"/>','<xsl:value-of select="ACCION"/>','ACTA');</xsl:with-param>
                <xsl:with-param name="label"><xsl:value-of select="LABEL"/></xsl:with-param>
                <xsl:with-param name="status">Evaluaci�n del producto</xsl:with-param>
                <xsl:with-param name="ancho">50px</xsl:with-param>
                <xsl:with-param name="identificador"><xsl:value-of select="IDPROVEEDORPRODUCTO"/></xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
      </td>
    </tr>
  </table>

</xsl:template>


</xsl:stylesheet>
