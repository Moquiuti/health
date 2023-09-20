// JavaScript Document

// ******************** JS DE PEDIDOSAPUNTODEENTREGARHTML.XSL ********************************

function Enviar(IDOferta)
			{
				var form=document.forms[0];
				var	msg='';
				var	res='';	//para validar fecha

				form.elements['IDOFERTA'].value=IDOferta;
				form.elements['NUEVAFECHAENTREGA'].value=form.elements['NUEVAFECHAENTREGA_'+IDOferta].value;
				form.elements['IDMOTIVO'].value=form.elements['IDMOTIVO_'+IDOferta].value; 
				form.elements['COMENTARIOS'].value=form.elements['COMENTARIOS_'+IDOferta].value;
				form.elements['ALBARAN'].value=form.elements['ALBARAN_'+IDOferta].value;
				
				//	Validacion antes del envio
				if (form.elements['IDMOTIVO'].value=='NO_INFORMADO')
					msg=msg+'- el motivo del problema en la entrega debe estar informado\n';
					
				if (((form.elements['IDMOTIVO'].value=='TRANSITO')||(form.elements['IDMOTIVO'].value=='ENTREGADO'))&&(form.elements['ALBARAN'].value==''))
					msg=msg+'- si el pedido está en tránsito o entregado debe informar el número de albarán\n';
					
				if ((form.elements['IDMOTIVO'].value!='SIN_STOCK')&&(form.elements['IDMOTIVO'].value!='PARCIAL')&&(form.elements['IDMOTIVO'].value!='NO_OPERATIVO')&&(form.elements['NUEVAFECHAENTREGA'].value==''))
					msg=msg+'- la nueva fecha prevista de salida debe estar informada\n';
				else
				{
					//	control del formato de la fecha
					if (form.elements['NUEVAFECHAENTREGA'].value!='')
					{
						res=CheckDate(form.elements['NUEVAFECHAENTREGA'].value);
						if (res!='') msg=msg+'- '+res;
					}
				}
				
				//if (form.elements['COMENTARIOS'].value=='')
				//	msg=msg+'- debe incluir los comentarios que expliquen el motivo del problema\n';
					
				if (msg=='')
				{
					//alert(form.elements['IDOFERTA'].value+' '+form.elements['NUEVAFECHAENTREGA'].value+' '+form.elements['IDMOTIVO'].value+' '+form.elements['COMENTARIOS'].value);
					SubmitForm(form);
				}
				else
				{
					alert ('No se pueden actualizar los datos, por favor, compruebe:\n\n'+msg);
				}
			}

			function AplicarFiltro()
			{
				var form=document.forms[0];
				form.action='PedidosAPuntoDeEntregar.xsql';
				
				//alert(form.elements['ORDEN'].value+' '+form.elements['SENTIDO'].value);
				
				SubmitForm(form);
			}

			function ControlPedidos(IDPedido)
			{
				var form=document.forms[0];
				form.action='ControlPedidos.xsql?IDPEDIDO='+IDPedido;
				SubmitForm(form);
			}
    	    
			function OrdenarPor(Orden)
			{
				var form=document.forms[0];
				
				if (form.elements['ORDEN'].value==Orden)
				{
					if (form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';
					else  form.elements['SENTIDO'].value='ASC';
				}
				else
				{
					form.elements['ORDEN'].value=Orden; 
					form.elements['SENTIDO'].value='ASC';
				}	
				AplicarFiltro();
			}
// ***********FIN DE JS DE PEDIDOSAPUNTODEENTREGARHTML.XSL *************