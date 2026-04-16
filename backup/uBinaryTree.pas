unit uBinaryTree;


interface
  type
    tbinaryTree = ^tnode;

    tnode = RECORD
      info: integer;
      hi, hd : tbinaryTree;
    end;

  

  // Basic methods
  procedure initialize(var a:tbinaryTree);
  function is_empty(a:tbinaryTree): boolean;
  procedure add(var a:tbinaryTree; elem: integer);
  function in_tree(a:tbinaryTree; elem: integer): boolean;

  // Traversal algorithms
  procedure preorder(a: tbinaryTree);
  procedure inorder(a: tbinaryTree);
  procedure postorder(a: tbinaryTree);

  // Ejercicios 

  {Ejercicio 1.1}
  procedure inorder_inverse(a: tbinaryTree);
  
  {Ejercicio 1.2}
  function profundidad_max(a:tbinaryTree): integer;

  {Ejercicio 1.3}
  function node_count(a:tbinaryTree): integer;

  {Ejercicio 1.4}
  function leafs_count(a:tbinaryTree): integer;

  {Ejercicio 1.5}
  function internal_nodes_count(a:tbinaryTree): integer;

  {Ejercicio 1.6}
  function is_full(a:tbinaryTree): boolean;

  {Ejercicio 1.7}
  function max_hoja(a:tbinaryTree): integer;

  {Ejercicio 1.8}
  function sum_hoja(a:tbinaryTree): integer;

  {Ejercicio 1.9}
  function num_pares(a:tbinaryTree): integer;

  {Ejercicio 1.10}
  function num_nodos_en_nivel(a:tbinaryTree; nivel:integer): integer;





implementation

uses Math, SysUtils;


procedure initialize(var a:tbinaryTree);
begin
  a:= nil;
end;

function is_empty(a:tbinaryTree): boolean;
begin
  is_empty:= a=nil;
end;

function in_tree(a: tbinaryTree; elem : integer) : boolean;
begin
  if a = NIL then in_tree := FALSE
  else if a^.info = elem then in_tree := TRUE
  else in_tree := (in_tree(a^.hd, elem)) or (in_tree(a^.hi, elem))
end;


{ Este procedimiento de añadir se basa en la propiedad de los árboles binarios de búsqueda:
  el hijo izquierdo es menor que el padre y el hijo derecho es mayor que el padre. }
procedure add(var a :tbinaryTree; elem : integer);
begin
  if a = NIL then begin
    new(a);
    a^.info := elem;
    a^.hi := NIL;
    a^.hd := NIL;
  end
  else if a^.info < elem then add(a^.hd, elem)
  else if a^.info > elem then add(a^.hi, elem)
end;

procedure visit(x:integer);
begin
  writeln(x)
end;

procedure preorder(a: tbinaryTree);
begin
  if (a <> NIL) then begin
    visit(a^.info);
    preorder(a^.hi);
    preorder(a^.hd)
  end
end;

procedure inorder(a: tbinaryTree);
begin
  if (a <> NIL) then begin
    inorder(a^.hi);
    visit(a^.info);
    inorder(a^.hd)
  end
end;

procedure postorder(a: tbinaryTree);
begin
  if (a <> NIL) then begin
    postorder(a^.hi);
    postorder(a^.hd);
    visit(a^.info);
  end
end;

{ ---------------Ejercicio 1.1------------------ }
procedure inorder_inverse(a: tbinaryTree);
begin
  if a <> nil then begin
    inorder_inverse(a^.hd);
    visit(a^.info);
    inorder_inverse(a^.hi);
  end;
end;

{ ---------------Ejercicio 1.2------------------ }
function profundidad_max(a:tbinaryTree): integer;
var
  prof_izq,prof_der: integer;
begin
  prof_izq:= 0;
  prof_der:= 0;
  if a <> nil then begin
    prof_izq:= prof_izq + 1 + profundidad_max(a^.hi);
    prof_der:= prof_der + 1 + profundidad_max(a^.hd);
  end
  else begin
    inc(prof_izq);
    inc(prof_der);
  end;
  if prof_izq > prof_der then
    profundidad_max:= prof_izq
  else profundidad_max:= prof_der;
end;

{ ---------------Ejercicio 1.3------------------ }
function node_count(a:tbinaryTree): integer;
begin
  node_count:= 0;
  if a <> nil then
    node_count:= node_count + 1 + node_count(a^.hi) + node_count(a^.hd);
end;

{ ---------------Ejercicio 1.4------------------ }
function leafs_count(a:tbinaryTree): integer;
begin
  leafs_count:= 0;
  if (a^.hi <> nil) and (a^.hd <> nil) and (a <> nil) then
    leafs_count:= leafs_count + leafs_count(a^.hi) + leafs_count(a^.hd)
  else
    leafs_count:= leafs_count + 1;
end;

{ ---------------Ejercicio 1.5------------------ }
function internal_nodes_count(a:tbinaryTree): integer;
begin
  internal_nodes_count:= 0;
  if (a <> nil) and (a^.hi <> nil) and (a^.hd <> nil) then
    internal_nodes_count:= internal_nodes_count + 1 + internal_nodes_count(a^.hi) + internal_nodes_count(a^.hd);
end;

{ ---------------Ejercicio 1.6------------------ }
function is_full(a: tbinaryTree): boolean;
begin
  is_full:= True;
  if (a^.hi <> nil) and (a^.hd <> nil) then
    is_full:= is_full(a^.hi) and is_full(a^.hd)
  else if (a^.hi = nil) and (a^.hd = nil) then
    is_full:= True
  else
    is_full:= False
end;

  
  { ---------------Ejercicio 1.7------------------ }
function max_hoja(a:tbinaryTree): integer;
begin
  writeln('NO IMPLEMENTADO');
end;

  
  { ---------------Ejercicio 1.8------------------ }
function sum_hoja(a:tbinaryTree): integer; 
begin
  writeln('NO IMPLEMENTADO');
end;


  { ---------------Ejercicio 1.9------------------ }
function num_pares(a:tbinaryTree): integer;
begin
  writeln('NO IMPLEMENTADO');
end;

  
    { ---------------Ejercicio 1.10------------------ }
function num_nodos_en_nivel(a:tbinaryTree; nivel:integer): integer;
begin
  writeln('NO IMPLEMENTADO');
end;


end.
