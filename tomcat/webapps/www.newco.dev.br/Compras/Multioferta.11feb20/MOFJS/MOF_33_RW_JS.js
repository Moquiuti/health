// JavaScript Document
//js de MOF_33_RW


  function Actua(formu,accion){
	      AsignarAccion(formu,accion);
	       //quito los botones asi no doble click
			document.getElementById('ocultarBotones').style.display = 'none';
	      SubmitForm(formu,document);
          }