program arboles_ej3;

uses
  uPilaChar, uBinaryCharSearchTree;

var
  pila: tPilaChars;
  elemento: char;

{ Ejercicio 3 }
procedure mostrar_pila_en_orden(var pila: tPilaChars);
var
  a: tBinarySearchTree;
  p: tPilaChars;
begin
  // Inicializar
  initialize(a);
  uPilaChar.initialize(p);
  // Añadir al arbol
  while not isEmpty(pila) do begin
    push(p, peek(pila));
    add(a, peek(pila));
    pop(pila);
  end;
  // Para mantener la misma pila que la inicial
  while not isEmpty(p) do begin
    push(pila,peek(p));
    pop(p);
  end;
  // Como es binario de búsqueda, está ordenado de manera ascendete con inOrden
  inorder(a);
end;


begin
  // Inicializar la pila
  uPilaChar.initialize(pila);

  // Agregar elementos desordenados a la pila
  push(pila, 'd');
  push(pila, 'a');
  push(pila, 'c');
  push(pila, 'b');

  // Mostrar pila antes de ordenar
  writeln('Pila antes de ordenar: ', toString(pila));

  mostrar_pila_en_orden(pila);

  // Mostrar pila después de ordenar
  writeln('Pila después de ordenar: ', toString(pila));
  readln;
end.
