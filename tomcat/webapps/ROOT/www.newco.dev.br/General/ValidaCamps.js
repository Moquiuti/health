/*
La definición de los campos se hace con el objeto Camp (nom,valor,tipus,opcions)
 
	Nom = Nombre del campo (descriptivo)
	Valor = referencia al valor en el objeto form
	tipus = Tipo de dato
	text
	number
	number_o_coma
	EMail
	date
	hour
	Opcions:
	required - Valor requerido
	not_required - Valor opcional
 

// Antes de hacer submit se llama a la función
 function Verificar()
 {
  var ok=Valida();
  if (ok==true)
  {
   document.accion.action="Productos.asp"
   document.accion.submit(); 
  } 
 
 }
 
// Dentro del mismo fichero hemos definido los campos, con la función Camps():
 function Camps()
 {
     i=1;
      this[i++] = new Camp("Nombre del Producto", document.accion.nombre.value, "text", "required");
  this[i++] = new Camp("Descripción del Producto", document.accion.descripcion.value, "text", "not_required");
  this[i++] = new Camp("Descripción de la Referencia", document.accion.descripRef.value, "text", "not_required");
  this[i++] = new Camp("Referéncia del Producto", document.accion.refProd.value, "text", "required");
  this[i++] = new Camp("Referéncia del Producto Basis", document.accion.refProdBasis.value, "number", "required");
  this.size=i-1;
     return this;
 } 


*/


//Include amb funcions per la validació de dades entrades al formulari.
//Variable global necessaria!

var paso='';

function teststr(cadena)     
{
 var i=0;
 var j=0;
 var forbiddenchars = '';
 for (i=0 ; i < cadena.length ; i ++ )
  for (j=0; j < forbiddenchars.length; j++)
   if (cadena.charAt(i) == forbiddenchars.charAt(j))
    {
			paso=forbiddenchars.charAt(j);
			return false;
    }
 return true;
}

function isnumber(cadena)     
{
 var i=0;
 var j=0;
 var digits = ' 1234567890';
 for (i=0; i < cadena.length ; i ++ ) {
  is_digit=0;
  for (j=0; j < digits.length; j++) 
   if (cadena.charAt(i) == digits.charAt(j))
    is_digit=1;     
  if (!is_digit)
   return false;
 }
 return true;
}

function isnumber_o_coma(cadena)     
{
 var i=0;
 var j=0;
 var digits = ' 1234567890.';

 i=cadena.indexOf('.');
 if (i > 0)
 {
	j =cadena.indexOf('.',i+1);
	if (j>0)
		return false;
 }
if (i==0) return false;

 for (i=0; i < cadena.length ; i ++ ) {
  is_digit=0;
  for (j=0; j < digits.length; j++)
   if (cadena.charAt(i) == digits.charAt(j))
    is_digit=1;     
    if (!is_digit)
     return false;
    }

 return true;
}


function valida_email(email) 
{ 
   	var error = false; 
// Longitud de email correcta 
        if (email.length < 7) 
                error = true; 
        
// Comprobacion de los caracteres 

        var lletra = ''; 
        var arrobas = 0; 
        var punto = email.indexOf('@'); 
        var puntos = 0; 
        
        for (var index=0; index<email.length; index++) 
        { 
                lletra = email.charAt(index); 
                if (lletra == '@') arrobas = arrobas +1; 
                if (lletra >= 32 && lletra <= 44) error = true; 
                if (lletra == 47 || lletra == 96 || lletra >= 123) error = true; 
                if (lletra >= 58 && lletra <= 63) error = true; 
                if (lletra >= 91 && lletra <= 93) error = true; 
                if (index > punto && lletra=='.') puntos = puntos +1; 
        } 
        if (arrobas != 1) 
                error = true; 

// Separacion del usuario y el dominio 
        var usuario = email.substr(1,punto); 

// Existe un usuario 
        if(usuario.length < 1) 
                error = true; 

// Comprobacion de las extensiones del dominio 
        if (puntos >5 || puntos<1) 
                error = true; 

// Control de errores 
        if (error) 
        { 
                return(false); 
        } 
        else 
                return (true); 
} 


function isdate(fecha)
{		
 paso='';
 var validchar='1234567890'
 var aux='';
 var dia='';
 var mes='';
 var any='';
 if(fecha.length==0)
  return true;
  if(fecha.length<5)
   {return(false);}
   for(nHowMany=0,i=0; i < fecha.length;i++) {
    for(found=0,j=0;j < validchar.length;j++)
     if(fecha.charAt(i)==validchar.charAt(j))
      {found=1; break;}
      if(found==0)
       nHowMany=nHowMany+1;}
   if(nHowMany==2)
    for(i=0,camp=0;i < fecha.length;i++) {
     for(found=0,j=0;j< validchar.length;j++)
      if(fecha.charAt(i)==validchar.charAt(j))
       {found=1; break;}
      if(found==0) {
       aux=aux+'-';
       camp=camp+1;}
      else {
       aux=aux+fecha.charAt(i);
       if(camp==0) dia=dia+fecha.charAt(i); 
       if(camp==1) mes=mes+fecha.charAt(i);
       if(camp==2) any=any+fecha.charAt(i);}}
   if((nHowMany==1)&&(fecha.length<7))
    {return(false);}
    if((nHowMany==1)&&(fecha.length>=7)&&(fecha.length<=9)){
     for(i=0;i < fecha.length;i++) {
      for(found=0,j=0;j< validchar.length;j++)
       if(fecha.charAt(i)==validchar.charAt(j))
        {found=1; break;}
       if(found==0)
        ara=i;}
      if(ara!=4) return(false);
      dia=fecha.charAt(0)+fecha.charAt(1);
      mes=fecha.charAt(2)+fecha.charAt(3);
      for(any='',i=5;i< fecha.length;i++)
       any=any+fecha.charAt(i);}
    if((nHowMany==0)&&((fecha.length==6)||(fecha.length==8))) {
     if(fecha.length==6) {
      dia=fecha.charAt(0)+fecha.charAt(1);
      mes=fecha.charAt(2)+fecha.charAt(3);
      any=fecha.charAt(4)+fecha.charAt(5);}
     if(fecha.length==8) {
      dia=fecha.charAt(0)+fecha.charAt(1);
      mes=fecha.charAt(2)+fecha.charAt(3);
      any=fecha.charAt(4)+fecha.charAt(5)+fecha.charAt(6)+fecha.charAt(7);}}
      if((dia=='')||(mes=='')||(any=='')) {return(false);}
      if(dia.length==1) dia='0'+dia;
      if(mes.length==1) mes='0'+mes;
      if(any.length==1) any='199'+any;
      if((any.length==2)&&(any>'70')) any='19'+any;
      if((any.length==2)&&(any<='70')) any='20'+any;
      if((any.length==3)&&(any<'970')) any='2'+any;
      if((any.length==3)&&(any>='970')) any='1'+any;
      if((dia=='00')||(mes=='00')) {return(false);}
      if(mes>'12') {return(false);}
      if((mes=='01')&&(dia>'31')) return(false);
      if((mes=='02')&&(dia>'29')) return(false);
      if((mes=='03')&&(dia>'31')) return(false);
      if((mes=='04')&&(dia>'30')) return(false);
      if((mes=='05')&&(dia>'31')) return(false);
      if((mes=='06')&&(dia>'30')) return(false);
      if((mes=='07')&&(dia>'31')) return(false);
      if((mes=='08')&&(dia>'31')) return(false);
      if((mes=='09')&&(dia>'30')) return(false);
      if((mes=='10')&&(dia>'31')) return(false);
      if((mes=='11')&&(dia>'30')) return(false);
      if((mes=='12')&&(dia>'31')) return(false);
      paso=dia+'/'+mes+'/'+any;
      return(true);
}

function ishour(fecha)
{
 paso='';
 var validchar='1234567890'
 var aux='';
 var hora='';
 var min='';
 if(fecha.length==0)
  return true;
 if(fecha.length<3)
  {return(false);}
 for(nHowMany=0,i=0; i < fecha.length;i++) {
  for(found=0,j=0;j < validchar.length;j++)
   if(fecha.charAt(i)==validchar.charAt(j))
    {found=1; break;}
   if(found==0)
    nHowMany=nHowMany+1;}
  if(nHowMany==1)
   for(i=0,camp=0;i < fecha.length;i++) {
    for(found=0,j=0;j< validchar.length;j++)
     if(fecha.charAt(i)==validchar.charAt(j))
      {found=1; break;}
     if(found==0) {
      aux=aux+'-';
      camp=camp+1;}
     else {
      aux=aux+fecha.charAt(i);
      if(camp==0) hora=hora+fecha.charAt(i); 
      if(camp==1) min=min+fecha.charAt(i);}}
   if (nHowMany!=1)
    {return(false);}
   if (hora.length==1)
    {hora= '0' + hora;}
   if (min.length==1)
    {min= '0' + min;}
   if (hora>23)
    {return(false);}
   if (min>59)
    {return(false);}
   paso=hora + ':' + min;
   return(true);
}


function Valida()
{

 var i;
 var validacio=true;
 var camps = new Camps();
  for (i=1; i <= camps.size; i++) {

  result=true;
  if(camps[i].options=='required' && camps[i].value=='') {
   result = false;
   alert('El campo '+camps[i].name+' es necesario');
   validacio=false;
   break;
   }
  if (result==true){       
   if(camps[i].type=='text') 
   {
    result = teststr(camps[i].value); 
    if (!result) 
    {
		alert(camps[i].name+'\n caracter incorrecto en cadena:'+paso);
		validacio=false;
	    break;

    }
   }
   else { 
    if(camps[i].type=='number') {
     result = isnumber(camps[i].value); 
     if (!result) 
	{
		alert(camps[i].name+'\n el numero es incorrecto');
		validacio=false;
	    break;
	}
     }
    if(camps[i].type=='number_o_coma'){
      result = isnumber_o_coma(camps[i].value); 
      if (!result) 
		{
		alert(camps[i].name+'\n el valor es incorrecto, ha de ser un número real (con punto para los decimales, si los hay)');
		validacio=false;
	    break;
		}
      }
	
    if (camps[i].type=='EMail')
    {
	result=valida_email(camps[i].value);
	if (!result)
	{
		alert(camps[i].name+'\n la dirección de mail es incorrecta');
		validacio=false;
		break;
	}			
    }
	if (camps[i].type=='hour')
    {
	result=ishour(camps[i].value);
	if (!result)
	{
		alert(camps[i].name+'\n la hora es incorrecta');
		validacio=false;
		break;
	}			
    }
    else {
      if(camps[i].type=='date') {
       result = isdate(camps[i].value);
       

       if (!result) 
		{
			alert(camps[i].name+'\n la fecha es incorrecta');
			validacio=false;
		    break;
		}
       }
   }
  }
}
  if (result==false)
   validacio=false;}
  return validacio

}

 



function Campo(nombre, valor, tipo, opciones, requerido)
{
 this.size = 5;
 this.nombre = new String(nombre);
 this.valor = new String(valor);
 this.tipo = new String(tipo);
 this.opciones = new String(opciones);
 this.requerido = new String(requerido);
 return this;
}




