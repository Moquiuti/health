/*
     
     MUY IMPORTANTE     MUY IMPORTANTE     MUY IMPORTANTE     MUY IMPORTANTE     MUY IMPORTANTE
////////////////////////////////////////////////////////////////////////////////////////////////     
     suponemos que las divisas vienen de la BD
            con el siguiente formato: (formato español)
                    10000,12...
                       ó
                   10.000,12... 
////////////////////////////////////////////////////////////////////////////////////////////////                   
     MUY IMPORTANTE     MUY IMPORTANTE     MUY IMPORTANTE     MUY IMPORTANTE     MUY IMPORTANTE      
*/

//
//
//
//
//
//

  Divisas=new Array(3);

  Divisas[0]=new Array(0,'Euro', 1, 4);		
  Divisas[1]=new Array(1,'Peseta', 166.386, 2);
  Divisas[2]=new Array(2,'Dolar', 0.9, 3);

//
//
//
//
//
//


function MVMListaCampos(form){

  Campos = new Array();
  	
  this.formulario = form;
	
  this.NuevoCampo=NuevoCampo;
  this.MostrarContenidoCampos=MostrarContenidoCampos;
  this.DarFormatoCampos=DarFormatoCampos;
  this.ValidarCampos=ValidarCampos;
  this.RecalculaDivisas=RecalculaDivisas;
  this.ValorOriginalDivisas=ValorOriginalDivisas;
  this.toEuros=toEuros;
  this.ActualizaValores=ActualizaValores;
  this.FormatoDivisas=FormatoDivisas;
  
  return this;
}


	
//
//
//
//
//
//


function NuevoCampo(nombre,nombrePresentacion, valor, tipo, requerido, divisa, minimo, maximo, opciones){
  Campos[Campos.length]=new MVMCampo(nombre, nombrePresentacion, valor, tipo, requerido, divisa, minimo, maximo, opciones);
  
  return this;
}

//
//
//
//
//
//
//

function MVMCampo(nombre, nombrePresentacion,valor, tipo, requerido, divisa, minimo, maximo, opciones){
  this.size = 9;	
  this.nombre = new String(nombre);
  this.nombrePresentacion = new String(nombrePresentacion);
  this.valor = new String(valor);
  this.tipo = new String(tipo);
  this.requerido = new String(requerido);
  this.divisa = new String(divisa);
  this.minimo = new String(minimo);
  this.maximo = new String(maximo);
  this.opciones = new String(opciones);
  
  this.valororiginal = new String('');
  
  return this;
}

//
//
//
//
//
//

function ValidarCampos(form, EstadoInicial){
	//MostrarContenidoCampos(form);//	!!!Solo para depuración
	
	var i;						//	Contador
	var MsgError=EstadoInicial;	//	Mensaje de error inicializado con el parámetro
	//var	Result=true;			//	Estado de la validación de un campo
	var ErrorCount=0;			//	Errores totales detectados en el form
	var Valor;					//	Valor contenido en el Control
	var NuevoMensaje;			//	Nuevo mensaje de error

					//alert('Validando campos');//Solo depuracion!!


 	for (i=1; i <= Campos.length; i++) 
	{
		Valor=form.elements[Campos[i-1].nombre].value;
		NuevoMensaje='';				//	Inicializamos sin error en el campo

//					//alert('Comprobando contenido del campo '+Campos[i-1].nombre+' de tipo ' +Campos[i-1].tipo);//Solo depuracion!!

		if (Valor!='')					//	Comprueba existencia
		{
			//	Si existe, realiza las validaciones en función del tipo de campo
			if (Campos[i-1].tipo=='NoChequear')	//	No requiere chequeo
			{
			}
			else if (Campos[i-1].tipo=='Decimal')	//	Número decimal
			{
				//	Comprueba contenido
				if (checkDecimal(Valor))
				{
					//	Comprueba condiciones límite. NO TIENE EN CUENTA LA DIVISA! Util solo para minimo=0 si hay divisa
					var Decimal=parseFloat(Valor);
					if ((Campos[i-1].minimo!='')&&(Decimal<Campos[i-1].minimo))
					{
						NuevoMensaje='El campo ' +Campos[i-1].nombrePresentacion+ ' debe contener como mínimo '+Campos[i-1].minimo+'.';
					}
					else
					{
						if ((Campos[i-1].maximo!='')&&(Decimal>Campos[i-1].maximo))
						{
							NuevoMensaje='El campo ' +Campos[i-1].nombrePresentacion+ ' debe contener como máximo '+Campos[i-1].maximo+'.';
						}
					}
				}
				else
				{
					NuevoMensaje='El campo ' +Campos[i-1].nombrePresentacion+ ' contiene un número incorrecto.';
				}
			}
			else if (Campos[i-1].tipo=='Texto')	//	Texto
			{
				//	Comprueba condiciones límite
				var Texto=new String(Valor);
				if ((Campos[i-1].minimo!='')&&(Texto.length<Campos[i-1].minimo))
				{
					NuevoMensaje='El campo ' +Campos[i-1].nombrePresentacion+ ' debe contener como mínimo '+Campos[i-1].minimo+' caracteres.';
				}
				else
				{
					if ((Campos[i-1].maximo!='')&&(Texto.length>Campos[i-1].maximo))
					{
						NuevoMensaje='El campo ' +Campos[i-1].nombrePresentacion+ ' debe contener como máximo '+Campos[i-1].maximo+' caracteres.';
					}
				}
			}
			else if (Campos[i-1].tipo=='Fecha')	//	Fecha
			{
				//	Comprueba contenido
				if (CheckDate(Valor)=='')
				{
					/*
					//	Comprueba condiciones límite. NO TIENE EN CUENTA LA DIVISA! Util solo para minimo=0 si hay divisa
					var Decimal=parseFloat(Valor);
					if ((Campos[i-1].minimo!='')&&(Decimal<Campos[i-1].minimo))
					{
						NuevoMensaje='El campo ' +Campos[i-1].nombre+ ' debe contener como mínimo '+Campos[i-1].minimo+'.';
					}
					else
					{
						if ((Campos[i-1].maximo!='')&&(Decimal>Campos[i-1].maximo))
						{
							NuevoMensaje='El campo ' +Campos[i-1].nombre+ ' debe contener como máximo '+Campos[i-1].maximo+'.';
						}
					}
					*/
				}
				else
				{
					NuevoMensaje='El campo ' +Campos[i-1].nombrePresentacion+ ' no contiene una fecha en formato dd/mm/yyyy.';
				}
			}
			else
			{		
				//alert('Comprobando contenido del campo '+Campos[i-1].nombre+' de tipo ' +Campos[i-1].tipo);
				//if (Campos[i-1].tipo=='Decimal') alert('DECIMAL!!!!!!!!!!!');//DEPURACION!!!!!!!!!!!!!!!!
			}
		}
		else	//	Error no informado si es un campo obligatorio
		{
			if (Campos[i-1].requerido=='S')
			{
				NuevoMensaje='El campo ' +Campos[i-1].nombrePresentacion+ ' está vacío y es obligatorio.';
			}
		}
		//	Si se ha producido algun error
		if (NuevoMensaje!='')
		{
			++ErrorCount;
			MsgError+= NuevoMensaje + '\n';
		}
  	}

/*	

				Text = Text + Campos[i-1].nombre + '=' + form.elements[Campos[i-1].valor].value + '\n';
				result=true;



var	Result=true;

 	for (i=1; i <= this.ListaCampos.size; i++) 
	{
		if (false) MsgError=MsgError + 'El campo ' + this.ListaCampos[i].nombre + 
			'debería ser ' + '\n'; // mayor o menor o mas largo o mas corto etc que ...
		
  	}
	*/
		
			
	return MsgError;
	
}

//
//
//
//
//
//

function RecalculaDivisas(formu, divisafinal){
  //alert('en recalculaDivisas()');
  var Res=0;
  for (i=1;i<=Campos.length;i++){
    if(enEsteForm(formu, Campos[i-1].nombre) && Campos[i-1].tipo=='Decimal'){//me situo en el campo adecuado
      if(Campos[i-1].divisa!='-1'){//Si es divisa
        var valorDivisa=Campos[i-1].valororiginal;
        //alert(Campos[i-1].valororiginal);
        if(divisafinal!='0')//Si el seleccionado no es Euro convierto a la divisa		             				
          valorDivisa=parseFloat(valorDivisa)*parseFloat(Divisas[divisafinal][2]);
        Campos[i-1].valor=valorDivisa;
        
        if(Campos[i-1].opciones.match('deUsuario')){// formato presentacion 1000,12
          if(Campos[i-1].valor!=0){
            //alert('empiezo');
            //alert(Campos[i-1].valor);
            //alert('acabo');
            formu.elements[Campos[i-1].nombre].value=reemplazaPuntoPorComa(Round(Campos[i-1].valor,Divisas[divisafinal][3]));
          }
          else{
            if(!Campos[i-1].opciones.match('admiteCeros'))
              formu.elements[Campos[i-1].nombre].value='';
          }
        }
        else{// formato presentacion 10.000,12
          if(Campos[i-1].valor!=0)
            formu.elements[Campos[i-1].nombre].value=formateaDivisa(Round(Campos[i-1].valor,Divisas[divisafinal][3]));
          else{
            if(!Campos[i-1].opciones.match('admiteCeros'))
              formu.elements[Campos[i-1].nombre].value='';
          }
        }
        ++Res;
      }
    }
  }
  return Res;
  
}

//
//
//
//
//
//

/*
   dados un nombre y un form se comprueba que el objeto se encuentra en el form
*/

function enEsteForm(form, nombre){
  for(var n=0;n<form.length;n++){
    if(form.elements[n].name==nombre)
      return true; // si esta	
  }
  return false;  //no esta	
}

//
//
//
//
//
//

function ValorOriginalDivisas(formu, divisa){
/*los datos se guardan con formato ingles   el punto decimal es '.'
         se guardan      100000.12
         se presentan:          
                  si no son editables    100.000,12
                  si son editables "Campos[X].opciones='deUsuario'"      100000,12
*/
  var Res=0;
  this.toEuros(formu, divisa);//convierto a euros
  for (i=1; i <= Campos.length; i++){	
    if(enEsteForm(formu, Campos[i-1].nombre) && Campos[i-1].tipo=='Decimal'){//me situo en el campo adecuado
      if (Campos[i-1].divisa!='-1'){//si es una divisa la recalculo en funcion de su valor en euros   
        Campos[i-1].valor=parseFloat(Campos[i-1].valororiginal)*parseFloat(Divisas[divisa][2]);
        //alert('??'+Campos[i-1].valor);
        ++Res; 
      }
      else{//si no es divisa la guardo tal cual
        Campos[i-1].valororiginal=Campos[i-1].valor; 
      }
          // presento la divisa original debidamente formateada
      if(Campos[i-1].opciones.match('deUsuario')){// formato presentacion 10000,12
        if(Campos[i-1].valor!=0){
          formu.elements[Campos[i-1].nombre].value=reemplazaPuntoPorComa(Round(Campos[i-1].valor,Divisas[divisa][3]));
        }
        else{
          if(!Campos[i-1].opciones.match('admiteCeros'))
            formu.elements[Campos[i-1].nombre].value='';
        }
      }
      else{  //formato presentacion 10.000.12
        if(Campos[i-1].valor!=0){
          formu.elements[Campos[i-1].nombre].value=formateaDivisa(Round(Campos[i-1].valor,Divisas[divisa][3]));
        }
        else{
          if(!Campos[i-1].opciones.match('admiteCeros'))
            formu.elements[Campos[i-1].nombre].value='';
        }
      }
    }
  }
  return Res;
}

//
//
//
//
//
//

function toEuros(form, divisa){
  for(var i=1;i<=Campos.length;i++){
    if(enEsteForm(form, Campos[i-1].nombre) && Campos[i-1].tipo=='Decimal'){
    var valorSinFormato=desformateaDivisa(Campos[i-1].valor);
      if(Campos[i-1].divisa!='-1'){// si es una divisa la convierto a euros y la guardo (internamente)
        var valorEnEuros=parseFloat(valorSinFormato)/parseFloat(Divisas[divisa][2]); 
        //valorEnEuros=Round(valorEnEuros,Divisas[0][3]);
        Campos[i-1].valor=valorEnEuros;
        //alert('original'+Campos[i-1].valor);
        Campos[i-1].valororiginal=valorEnEuros;
      }
      else{// no es divisa le quitamos el formato
        Campos[i-1].valor=valorSinFormato;
        Campos[i-1].valororiginal=valorSinFormato;
      }
    }
  }
}

//
//
//
//
//
//
//

function ActualizaValores(nombre, form){
  for(var i=1;i<=Campos.length;i++){
    if(Campos[i-1].nombre==nombre)//me situo en el campo que estoy editando
      if(Campos[i-1].divisa=='-1'){//si no es divisa guardo sin transformaciones
        Campos[i-1].valor=desformateaDivisa(form.elements[nombre].value);
        Campos[i-1].valororiginal=desformateaDivisa(form.elements[nombre].value);
      }
      else{//si es divisa
        var valorEuros;
        if(obtenerIdDivisa(form,'IDDIVISA')==0){//si estoy trabajando en Euros
          valorEuros=desformateaDivisa(form.elements[nombre].value);
        }
        else{//si no trabajo en euros
          //convierto a euros
          valorEuros=parseFloat(desformateaDivisa(form.elements[nombre].value)) / parseFloat(Divisas[obtenerIdDivisa(form,'IDDIVISA')][2]);
          //alert('actualizo'+valorEuros);
        }
        //guardo el valor con formato 10000.12
        
        //alert('el valor antes'+Campos[i-1].valor);
        if(Round(Campos[i-1].valor,Divisas[obtenerIdDivisa(form,'IDDIVISA')][3])!=valorEuros){ 
          Campos[i-1].valor=valorEuros;
          Campos[i-1].valororiginal=valorEuros;
        }
      } 	
  } 	
}

//
//
//
//
//
//
//

function FormatoDivisas(formu, divisa){
  var Res=0;
  for (i=1; i <= Campos.length; i++){
    if(Campos[i-1].divisa!='-1' && Campos[i-1].tipo=='Decimal'){
      if(Campos[i-1].opciones.match('deUsuario')){
        formu.elements[Campos[i-1].nombre].value=reemplazaPuntoPorComa(Round(formu.elements[Campos[i-1].nombre].value,Divisas[divisa][3]));
      }
      else{
        formu.elements[Campos[i-1].nombre].value=formateaDivisa(Round(formu.elements[Campos[i-1].nombre].value,Divisas[divisa][3]));
      }
      ++Res;
    }
    else{
      formu.elements[Campos[i-1].nombre].value=reemplazaPuntoPorComa(Round(formu.elements[Campos[i-1].nombre].value,Divisas[divisa][3]));
    }
  }
  return Res;
}

//
//
//
//
//
//
//

function MostrarContenidoCampos(formu){
  var i;
  var Text='Mostrando contenido de los campos\n';
  for (i=1; i <= Campos.length; i++){
    Text = Text + Campos[i-1].nombre 
    +'|orig:'+ Campos[i-1].valororiginal 
    +'|valor:'+ formu.elements[Campos[i-1].valor].value + '\n';
  }
  alert (Text);
  return Campos.length;
}


function PresentaError(msgError){
  var Text;
  Text='Se han producido los siguientes problemas:\n\n'+msgError;
  Text=Text+'\n\nPor favor, corríjalos antes de actualizar la página.';
  alert(Text);
}

//
//
//
//
//
//

//	Da formato a todos los campos de la lista de campos
function DarFormatoCampos()
{
	MostrarContenidoCampos();
	var i;
	//var ListaCampos = new MVMCampos();
	var MsgError='';//	!!!Para depuración
	var	Result=true;

 	for (i=1; i <= Campos.size; i++) 
	{
  	}
	
 	return MsgError;
}