// JavaScript Document

 function verVacacionesComercial(idComercial){
              var fFecha=new Date();
              
              var fecha=convertirFechaATexto(fFecha);
              
              MostrarPagPersonalizada('http://www.newco.dev.br/Agenda/CalendarioAnual.xsql?ACCION=&TITULO=D%EDas%20H%E1biles%20del%20Comercial&FECHAACTIVA='+fecha+'&IDUSUARIOAGENDA='+idComercial+'&VENTANA=NUEVA','vacacionesProveedor',80,90,0,-50);
        
            }
          
            //asociar una oferta a todos los productos de una empresa
            
            function AsociarOfertaTodos(ficha){
            	var form = document.forms['Ficha'];
                var idempresa = document.forms['Ficha'].elements['ID_EMPRESA'].value;
                var idficha = ficha;
                
                var enctype = 'application/x-www-form-urlencoded';
             
                
                //si usuario confirma
                if (confirm('Esta seguro que desea asociar esta ficha tecnica a todos los productos?')){
                
				form.encoding = enctype;
                
            	jQuery.ajax({
						url:"confirmAsociaOferta.xsql",
						data:"ID_EMPRESA="+idempresa+"&ID_DOCUMENTO="+idficha,
			  			type: "GET",
						contentType: "application/xhtml+xml",
                       
                        
						beforeSend:function(){
                        	//alert('mi');
                            document.getElementById('waitBoxFicha').style.display = 'block';
							document.getElementById('waitBoxFicha').src = 'http://www.newco.dev.br/images/loading.gif';
							
						},
						error:function(objeto, quepaso, otroobj){
							alert("objeto:"+objeto);
							alert("otroobj:"+otroobj);
							alert("quepaso:"+quepaso);
						},
						success:function(data){
							
							var doc=eval("(" + data + ")");
                             document.getElementById('waitBoxFicha').style.display = 'none';
							document.getElementById('confirmBoxAsociaFicha').style.display = 'block';
						}
				}); 
                }//fin if
            }//fin AsociarOfertaTodos
            
            
            //eliminar una oferta
            function EliminarOferta(oferta){
            	var form = document.forms['Oferta'];
                var idempresa = document.forms['Oferta'].elements['ID_EMPRESA'].value;
                var idoferta = oferta;
                
                 var enctype = 'application/x-www-form-urlencoded';
             
                
                //si usuario confirma
                if (confirm('Esta seguro que desea eliminar esta oferta?')){
                
				form.encoding = enctype;
                
            	jQuery.ajax({
						url:"confirmEliminaOferta.xsql",
						data:"ID_DOCUMENTO="+idoferta,
			  			type: "GET",
						contentType: "application/xhtml+xml",
                       
                        
						beforeSend:function(){
                        	//alert('mi');
                            document.getElementById('waitBoxOferta').style.display = 'block';
							document.getElementById('waitBoxOferta').src = 'http://www.newco.dev.br/images/loading.gif';
							
						},
						error:function(objeto, quepaso, otroobj){
							alert("objeto:"+objeto);
							alert("otroobj:"+otroobj);
							alert("quepaso:"+quepaso);
						},
						success:function(data){
							
							var doc=eval("(" + data + ")");
                             document.getElementById('waitBoxOferta').style.display = 'none';
							document.getElementById('confirmBoxEliminaOferta').style.display = 'block';
                            document.location.reload();
														
						}
				}); 
                
                }//fin if
            }//fin eliminar oferta
            
            //eliminar una oferta asisa
            function EliminarOfertaAsisa(ofertaAsisa){
            	var form = document.forms['OfertaAsisa'];
                var idempresa = document.forms['OfertaAsisa'].elements['ID_EMPRESA'].value;
                var idoferta = oferta;
                
                 var enctype = 'application/x-www-form-urlencoded';
             
                
                //si usuario confirma
                if (confirm('Esta seguro que desea eliminar esta oferta de asisa?')){
                
				form.encoding = enctype;
                
            	jQuery.ajax({
						url:"confirmEliminaOferta.xsql",
						data:"ID_DOCUMENTO="+idoferta,
			  			type: "GET",
						contentType: "application/xhtml+xml",
                       
                        
						beforeSend:function(){
                        	//alert('mi');
                            document.getElementById('waitBoxOfertaAsisa').style.display = 'block';
							document.getElementById('waitBoxOfertaAsisa').src = 'http://www.newco.dev.br/images/loading.gif';
							
						},
						error:function(objeto, quepaso, otroobj){
							alert("objeto:"+objeto);
							alert("otroobj:"+otroobj);
							alert("quepaso:"+quepaso);
						},
						success:function(data){
							
							var doc=eval("(" + data + ")");
                             document.getElementById('waitBoxOfertaAsisa').style.display = 'none';
							document.getElementById('confirmBoxEliminaOfertaAsisa').style.display = 'block';
                            document.location.reload();
														
						}
				}); 
                
                }//fin if
            }//fin eliminar oferta asisa
            
            
             //eliminar una ficha
            function EliminarFicha(ficha){
            	var form = document.forms['Ficha'];
                var idempresa = document.forms['Ficha'].elements['ID_EMPRESA'].value;
                var idficha = ficha;
                
                 var enctype = 'application/x-www-form-urlencoded';
             
                
                //si usuario confirma
                if (confirm('Esta seguro que desea eliminar esta Ficha tecnica?')){
                
				form.encoding = enctype;
                
            	jQuery.ajax({
						url:"confirmEliminaOferta.xsql",
						data:"ID_DOCUMENTO="+idficha,
			  			type: "GET",
						contentType: "application/xhtml+xml",
                       
                        
						beforeSend:function(){
                        	//alert('mi');
                            document.getElementById('waitBoxFicha').style.display = 'block';
							document.getElementById('waitBoxFicha').src = 'http://www.newco.dev.br/images/loading.gif';
							
						},
						error:function(objeto, quepaso, otroobj){
							alert("objeto:"+objeto);
							alert("otroobj:"+otroobj);
							alert("quepaso:"+quepaso);
						},
						success:function(data){
							
							var doc=eval("(" + data + ")");
                             document.getElementById('waitBoxFicha').style.display = 'none';
							document.getElementById('confirmBoxEliminaFicha').style.display = 'block';
                            document.location.reload();
														
						}
				}); 
                
                }//fin if
            }