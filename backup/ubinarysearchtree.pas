unit uBinarySearchTree;

interface

type
  tBinarySearchTree = ^tnode;
  tnode = record
    info: integer;
    hi, hd: tBinarySearchTree;
    multiplicidad: integer;
  end;

  // Basic methods
  procedure initialize(var a: tBinarySearchTree);
  function is_empty(a: tBinarySearchTree): boolean;
  procedure add(var a: tBinarySearchTree; clave: integer);
  function in_tree(a: tBinarySearchTree; clave: integer): boolean;
  procedure remove(var a: tBinarySearchTree; x: integer);

  // Traversal algorithms
  procedure preorder(a: tBinarySearchTree);
  procedure inorder(a: tBinarySearchTree);
  procedure postorder(a: tBinarySearchTree);

  // Other methods
  procedure get_hi(a: tBinarySearchTree; var b: tBinarySearchTree);
  procedure get_hd(a: tBinarySearchTree; var b: tBinarySearchTree);

  // Ejercicio 2.1
  function mismos_nodos_izq_y_der(a: tBinarySearchTree): boolean;
  // Ejercicio 2.2
  function niveles_completos(a: tBinarySearchTree): boolean;
  // Ejercicio 2.3
  procedure add_tree(var a: tBinarySearchTree; b: tBinarySearchTree);
  // Ejercicio 2.4
  function get_multiplicidad(a: tBinarySearchTree; clave: integer): integer;

implementation

uses
  Math;

function get_clave(a: tBinarySearchTree; clave: integer): tBinarySearchTree;
begin
    if a = NIL then
      get_clave := nil
    else if a^.info < clave then
      get_clave := get_clave(a^.hd, clave)
    else if a^.info > clave then
      get_clave := get_clave(a^.hi, clave)
    else
      get_clave := a;
end;

procedure initialize(var a: tBinarySearchTree);
begin
  a := NIL;
end;

function is_empty(a: tBinarySearchTree): boolean;
begin
  is_empty := a = NIL;
end;

function in_tree(a: tBinarySearchTree; clave: integer): boolean;
begin
  if a = NIL then
    in_tree := FALSE
  else if a^.info < clave then
    in_tree := in_tree(a^.hd, clave)
  else if a^.info > clave then
    in_tree := in_tree(a^.hi, clave)
  else
    in_tree := TRUE;
end;

procedure add(var a: tBinarySearchTree; clave: integer);

begin
  if in_tree(a,clave) then
    inc(get_clave(a,clave)^.multiplicidad)
  else if a = NIL then
  begin
    new(a);
    a^.info := clave;
    a^.multiplicidad:= 1;
    a^.hi := NIL;
    a^.hd := NIL;
  end
  else if a^.info < clave then
    add(a^.hd, clave)
  else if a^.info > clave then
    add(a^.hi, clave);
end;

procedure remove(var a: tBinarySearchTree; x: integer);
var
  aux, ant: tBinarySearchTree;
begin
  if (a <> NIL) and (get_clave(a,x)^.multiplicidad > 1) then
    dec(get_clave(a,x)^.multiplicidad)
  else if (a <> NIL) then
    if a^.info < x then
      remove(a^.hd, x)
    else if a^.info > x then
      remove(a^.hi, x)
    else
    begin
      aux := a;
      if a^.hi = NIL then
        a := a^.hd
      else if a^.hd = NIL then
        a := a^.hi
      else
      begin
        aux := a^.hi;
        while aux^.hd <> NIL do
        begin
          ant := aux;
          aux := aux^.hd;
        end;
        if a^.hi = aux then
          a^.hi := aux^.hi
        else
          ant^.hd := aux^.hi;
        a^.info := aux^.info;
      end;
      dispose(aux);
    end;
end;

// Traversal algorithms

procedure visit(x: integer);
begin
  writeln(x);
end;

procedure preorder(a: tBinarySearchTree);
begin
  if (a <> NIL) then
  begin
    visit(a^.info);
    preorder(a^.hi);
    preorder(a^.hd);
  end;
end;

procedure inorder(a: tBinarySearchTree);
begin
  if (a <> NIL) then
  begin
    inorder(a^.hi);
    visit(a^.info);
    inorder(a^.hd);
  end;
end;

procedure postorder(a: tBinarySearchTree);
begin
  if (a <> NIL) then
  begin
    postorder(a^.hi);
    postorder(a^.hd);
    visit(a^.info);
  end;
end;

// Other methods

function get_info(a: tBinarySearchTree): integer;
begin
  get_info := a^.info;
end;

procedure get_hi(a: tBinarySearchTree; var b: tBinarySearchTree);
var
  hi: tBinarySearchTree;
begin
  if a = nil then
    b := nil
  else
  begin
    hi := a^.hi;
    new(b);
    b^.info := hi^.info;
    b^.hi := hi^.hi;
    b^.hd := hi^.hd;
  end;
end;


procedure get_hd(a: tBinarySearchTree; var b: tBinarySearchTree);
var
  hd: tBinarySearchTree;
begin
  if a = nil then
    b := nil
  else
  begin
    hd := a^.hd;
    new(b);
    b^.info := hd^.info;
    b^.hi := hd^.hi;
    b^.hd := hd^.hd;
  end;
end;

  // Ejercicio 2.1
  function mismos_nodos_izq_y_der(a: tBinarySearchTree): boolean;
    function node_count(a:tBinarySearchTree): integer;
    begin
      node_count:= 0;
      if a <> nil then
        node_count:= node_count + 1 + node_count(a^.hi) + node_count(a^.hd);
    end;
  begin
    mismos_nodos_izq_y_der:= node_count(a^.hi) = node_count(a^.hd);
  end;
  // Ejercicio 2.2
  function niveles_completos(a: tBinarySearchTree): boolean;
  begin
    niveles_completos:= True;
    if (a^.hi <> nil) and (a^.hd <> nil) then
      niveles_completos:= niveles_completos(a^.hi) and niveles_completos(a^.hd)
    else if (a^.hi = nil) and (a^.hd = nil) then
      niveles_completos:= True
    else
      niveles_completos:= False
  end;
  // Ejercicio 2.3
  procedure add_tree(var a: tBinarySearchTree; b: tBinarySearchTree);
  begin
    if (b <> NIL) then
    begin
      add(a,b^.info);
      add_tree(a,b^.hi);
      add_tree(a,b^.hd);
    end;
  end;
  // Ejercicio 2.4
  function get_multiplicidad(a: tBinarySearchTree; clave: integer): integer;

  begin
    get_multiplicidad:= 0;
    if in_tree(a,clave) then
      get_multiplicidad:= get_clave(a,clave)^.multiplicidad;
  end;


end.
