// ParsleyConfig definition if not already set
// Validation errors messages for Parsley
//import Parsley from '../parsley';

Parsley.addMessages('es', {
  defaultMessage: "Este campo parece ser inv�lido.",
  type: {
    email:        "Este campo debe ser un correo v�lido.",
    url:          "Este campo debe ser una URL v�lida.",
    number:       "Este campo debe ser un n�mero v�lido.",
    integer:      "Este campo debe ser un n�mero v�lido.",
    digits:       "Este campo debe ser un d�gito v�lido.",
    alphanum:     "Este campo debe ser alfanum�rico."
  },
  notblank:       "Este campo no debe estar en blanco.",
  required:       "Este campo es obligatorio.",
  pattern:        "Este campo es incorrecto.",
  min:            "Este campo no debe ser menor que %s.",
  max:            "Este campo no debe ser mayor que %s.",
  range:          "Este campo debe estar entre %s y %s.",
  minlength:      "Este campo es muy corto. La longitud m�nima es de %s caracteres.",
  maxlength:      "Este campo es muy largo. La longitud m�xima es de %s caracteres.",
  length:         "La longitud de este campo debe estar entre %s y %s caracteres.",
  mincheck:       "Debe seleccionar al menos %s opciones.",
  maxcheck:       "Debe seleccionar %s opciones o menos.",
  check:          "Debe seleccionar entre %s y %s opciones.",
  equalto:        "Este campo debe ser id�ntico."
});

Parsley.setLocale('es');
