unit Cadenas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Conjunto,Dialogs,Natural, Grids;

const MAX_ELE = 1200;
  type

  { cadena }

 cadena = class
    private
       elem :array [1..MAX_ELE] OF char;  //vector
       dim: integer;                      //dim=puntero
       May,Min,Dig,Sep:conjuntos;
     public


       procedure LeerPal(var pos:integer;var pal:String);
       procedure AddPal(pal :String);
       procedure Inserchar(pos:integer;ele:char);  //Inserta en una posicion un character (2,'X')
       procedure InserPal(pos:integer;pal:String);  //Inserta un nuevo String apartir de una posicion(3,"hola")
       procedure Eliminar(pal:String);        //Elimina la primera palabra(String) del objeto
       procedure EliminarAll(delPal:String);        //Elimina una palabra de todo el objeto
       procedure ReemPal(palO,PalN:String); //remplaza la primera palabra a buscar por la nueva palabra
       function CantPal():integer;         //retorna la cantidad de palabras
       function BuscPal(palB:String):integer;  //agarra palabra*palabra y verifica si EXISTE(palB), retorna el indice de la primera palabra

       procedure ejercicio1(cad2 :cadena;pal: String);         //división de una Cadena en dos Cadenas a partir de una palabra X, la palabra X formará parte de la Primer Cadena.
       procedure Invertir();
       procedure ejercicio6(cad1,cad2:String);
       procedure ejercicio6(cad1,cad2:cadena);        //división de una Cadena en dos Cadenas a partir de una palabra X, la palabra X formará parte de la Primer Cadena.
       function invertirPal():String;          //invierte las palabras del objeto
       procedure ConverMayus();
       function Verif_primo(pos:integer):String;
       procedure ejercicio10(pal:String);
       procedure delPalabrasRepetidas();  // elimina todas las palabras repetidas
       function cantCaracteres():Integer;  //cantidad de caracteres del objeto ignora espacios

       function LongMedia():real;
       function Ppal_UltCaracter():Char;
       FUNCTION cantpal_Fin(cha:char):integer;
       procedure leerNumReales(var pos:integer; var pal:String);
       procedure mostrarNum();


       Constructor crear();
       {setters y getters}
       procedure descargar(v:TStringGrid );
       procedure setDim(n :integer);
       function getDim():integer;
       function getChar(pos:integer):char;
       {procesos}
       procedure CargarPosPatron(a, b: integer; patron: string; var s: string);
       procedure Encriptar(k: byte);
       procedure Desencriptar(k: byte);

       procedure Intercambiar(a,b : integer);
       procedure DeletePos(posicion, cantidad : word);
       procedure DeleteAllPalabra(palabraBusc : String);
       procedure Invertir(a, b: byte);
       procedure InvertirCadaPalabra;
       procedure RotarIzq(cant : word);
       procedure RotarIzqV1(cant : word);
       procedure RotarDer(cant : word);

       {funciones}
       function LeerPal(var a: integer; b: integer): String; overload;
       function LeerPal(var pos: integer): String;overload;
       function Posicion(buscPalabra: String): word;
       function Posicion(a, b: word; buscPalabra: String): word;
       function verifRango(a, b: word): boolean;
       function BuscarCaracter(a, b :word; busq: char): word; overload;
       function EsSubCadena(a, b :word; cad: String) : boolean;
       function EsRepetido(a, b: word; x: char): boolean;
       function frecuenciaPal(pal:String):integer;        //frecuencia de una palabra(pal)
       function frecuenciaPal(a,b:integer; pal:String):integer;        //frecuencia de una palabra(pal)


       class function CifradoCesar(x : string; d : byte): String; static;
       class function DescifradoCesar(x : string; d : byte): String; static;
  end;
implementation

//inicializamos el constructor del objeto
constructor cadena.crear();
var i:integer;
begin
  dim:=0;
  for i:=1 to MAX_ELE do    //Inicializamos vector
    elem[i]:=char(0);       //elem->[0,0,0,0,0,0,0,.......0]...1200

  May:=conjuntos.crear;   //dim    1                ..1200
  for i:=0 to 25 do       //puntero
    May.agregar(char(65+i));//A..Z = may

  Min:=conjuntos.crear;
  for i:=0 to 25 do
    Min.agregar(char(97+i));//a..z = min

  Dig:=conjuntos.crear;
  for i:=0 to 9 do
    Dig.agregar(char(48+i));//0..9 = dig

  Sep:=conjuntos.crear;
  Sep.agregar('.');
  Sep.agregar(';');
  Sep.agregar(' ');
  Sep.agregar(',');
  Sep.agregar(':');
  Sep.agregar('-');
  Sep.agregar('_');       //sep=[ . | ; | | , | : | - | _ |]

end;

procedure cadena.descargar(v: TStringGrid);
var i:integer;
begin
  v.ColCount:=dim;
  v.RowCount:=2;
  for i:=1 to dim do begin
      v.Cells[i-1, 0]:=elem[i];
      v.Cells[i-1, 1]:= IntToStr(i);
  end;
end;
procedure cadena.setDim(n: integer);
begin
  dim:=n;
end;

//Adiciona una nueva palabra al objeto
procedure cadena.AddPal(pal: String);
var n,i:integer;
begin
  n:=Length(pal);//'jose'=4
  if not (dim+n+1<=MAX_ELE)then //longitud actual <= longitudMax
    raise Exception.Create('Posición fuera de rango');


  if(dim<>0)then begin
   dim:=dim+1;
   elem[dim]:=' '; //[ |]
  end;
  for i:=1 to n do begin //[j | o| s| e|  |d | a | r | w | i | n ]
      dim:=dim+1;   //[ | |]
      elem[dim]:=pal[i];
  end;
end;
//Inserta una character en una posicion(2,'X')
//[a,b,c,d]->[a,X,b,c,d]
procedure cadena.Inserchar(pos: integer; ele: char);
var i:integer;
begin
 dim := dim+1;
 for i:=dim downto(pos+1)do
     elem[i]:=elem[i-1];

 elem[pos]:=ele;
end;
//Inserta una nueva palabra apartir de una posicion(3,"hola")
//[a,b,c,d]->[a,b, ,h,o,l,a, ,c,d]
procedure cadena.InserPal(pos: integer; pal: String);
var i:integer;
begin
  Inserchar(pos,' '); //Insertamos el separador al inicio
  for i:=1 to length(pal)do
   begin
       pos:=pos+1;
       Inserchar(pos,pal[i]);
   end;
   Inserchar(pos+1,' '); //Insertamos el separador al final
end;

//pos(referencia)=contador que ira incrementando
//pal(referencia)=sacara la primera palabra desdes (pos)

//[ h | o |  |  | l | a | ]
//saca palabra por palabra de una cadena
//var pos==10           LeerPal(pos,'hola')
//var pos==20                   pos=20;
procedure cadena.LeerPal(var pos: integer; var pal: String);
begin
  while(pos<=dim)and(sep.pertenece(elem[pos]))do //pos queda como puntero de la siguiente palabra
    pos:=pos+1;

  pal:='';           //sep[ . | ; |  | , | : | - | _ ]
  while(pos<=dim)and(not sep.pertenece(elem[pos]))do begin   //encuentra[ . | ; |  | , | : | - | _ ]->finaliza
    pal:=pal+elem[pos];  //pal='ho'
    pos:=pos+1;          //pos=5
  end;
end;

//agarra palabra*palabra y verifica si EXISTE(palB)
//retorna el indice de la primera palabra
function cadena.BuscPal(palB: String): integer;
var pos,i:integer;
    pal:String;
    sw:Boolean;
begin
 sw:=false; pal:='';
 i:=1;                          //(existen caracteres) and not(falso)
 while((i<=dim )and(not sw))do  //(verdad)  and  (verdad) ==>verdadero
 begin
   pos:=i;
   LeerPal(i,pal);
   if(pal=palB)then
     sw:=true;
 end;
  if(sw)then
   result:=pos
  else
   result:=-1;
end;

//Elimina la primera palabra de la cadena(hola)
procedure cadena.Eliminar(pal: String);
var i,pos,n:integer;
begin
  pos:=BuscPal(pal);
  if(pos<>-1)then begin
     n:=Length(pal);
     for i:=pos to dim-n do
        elem[i]:=elem[i+n];
        dim:=dim-n;
  end;
end;

procedure cadena.EliminarAll(delPal: String);
var pos,p,j:integer;
         pal:String;
begin
  pal:=''; pos:=1;
  while(pos<=dim) do begin
     LeerPal(pos,pal);
     if (pal = delPal) then begin
         p:= BuscPal(pal);//posicion donde se encontro
         for j:=p to (dim-(pos-p)) do
             elem[j]:=elem[j+(pos-p)];
         dim:=dim-(pos-p);
         pos := 1;
     end;
  end;
end;


//   PalO=palabra  original;
//Lo Remplaza por PalN=palabra nueva
procedure cadena.ReemPal(palO, PalN: String);
var pos:integer;
begin
   pos:=BuscPal(palO);
   if(pos<>-1)then begin
       Eliminar(palO);
       InserPal(pos,PalN);
   end;
end;


//retorna la Cantidad de palabras
function cadena.CantPal(): integer;
var cp,pos:integer;
     pal:String;
begin
  cp:=0;  pos:=1; pal:='';
  while(pos<=dim)do
  begin
   LeerPal(pos,pal);
   if(pal<>'')then
   cp:=cp+1;
  end;
  result:=cp;
end;

//retorna Dim del objeto cadena
function cadena.getDim(): integer;
begin
  result:=dim;
end;
//Retorna el character del objeto en una (posicion)
function cadena.getChar(pos:integer): char;
begin
   if(pos>=1)and(pos<=dim)then
      result:=elem[pos]
   else
      result:=char(0);
end;

procedure cadena.CargarPosPatron(a, b: integer; patron: string; var s: string);
var p : word;
begin
  s := '';
  while a <= b do begin
    p := self.Posicion(a, b, patron);
    if p = 0 then
    begin
      a := b + 1;
    end else begin
      s := s + inttostr(p) + ', ';
      a := p + 1;
    end;
  end;
end;

//frecuencia de una palabra(pal)
function cadena.frecuenciaPal(pal:String): integer;
begin
 result:= (self.frecuenciaPal(pal));
end;

function cadena.frecuenciaPal(a, b: integer; pal: String): integer;
var c:integer;
    palabra:String;
begin
  c:=0;
  while(a<=b)do begin
    palabra:= LeerPal(a, b);
    if(palabra = pal)then
     c:=c+1;
  end;
  result:=c;
end;

class function cadena.CifradoCesar(x: string; d: byte): String;
const abc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var n,i : Cardinal;
      p : byte;
      r : string;
begin
 x := UpperCase(x);
 n := Length(x);
 r := '';
 for i := 1 to n do begin
   p :=  Pos(x[i], abc);
    if p > 0 then begin          //0  22
      r := r + ABC[(((p-1)+d) mod 26)+1];
    end else begin
      r := r + ' ';
    end;
 end;
 result := r;
end;

class function cadena.DescifradoCesar(x: string; d: byte): String;
const abc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var n,i : Cardinal;
      p : byte;
      r : string;
begin
 x := UpperCase(x);
 n := Length(x);
 r := '';
 for i := 1 to n do begin
   p :=  Pos(x[i], abc);
    if p > 0 then begin          //0  22
      r := r + ABC[(((p-1)+26 - d) mod 26)+1];
    end else begin
      r := r + ' ';
    end;
 end;
 result := r;
end;


//pal='como'
procedure cadena.ejercicio1(cad2 :cadena;pal: String);
var n,i,pos:integer;
begin//[h,o,l,a, ,c,o,m,o, ,e,s,t,a,s]-> [h,o,l,a, ,c,o,m,o] [,e,s,t,a,s]
   n:=Length(pal);//'c'o'm'o'=4
   pos:=BuscPal(pal);//->retorna posicion donde encontro=>6
   if(pos>0) then begin //existe la palabra
     for i:=(pos+n+1) to dim do begin
       cad2.dim:=cad2.dim+1;   //
       cad2.elem[cad2.dim]:=elem[i];
      end;
      dim:=n+pos-1;
   end else begin
     ShowMessage('No existe la palabra');
   end;
end;
//invertir la cadena
procedure cadena.Invertir();
begin
  self.Invertir(1, self.dim);
end;

procedure cadena.ejercicio6(cad1, cad2: String);
var n1,n2,p:integer;
       bo:Boolean;
       pal:String;
begin
  bo:=true;
  n1:=Length(cad1); n2:=Length(cad2);
  while(n1>0)OR(n2>0)do
    begin
       if(bo) then
       begin
           p:=pos(' ',cad1);//0
           if(p>0)then begin
            pal:=copy(cad1,1,p-1);//'hola'
            Delete(cad1,1,p);    //como estas
           end else begin
            pal:=copy(cad1,1,n1);//'estas'
            Delete(cad1,1,n1);    //''
           end;
            n1:=Length(cad1);

        end else begin
           p:=pos(' ',cad2);//0
           if(p>0)then begin
            pal:=copy(cad2,1,p-1);//'hola'
            Delete(cad2,1,p);    //como estas
           end else begin
            pal:=copy(cad2,1,n2);//'estas'
            Delete(cad2,1,n2);    //''
           end;
            n2:=Length(cad2);

       end;
         AddPal(pal);
         bo:=not(bo);
    end;
end;

procedure cadena.ejercicio6(cad1, cad2: cadena);
var pos1,pos2:integer;
    pal1,pal2:String;
begin
 pos1:=1; pal1:='';
 pos2:=1; pal2:='';
 while(pos1<=cad1.dim)and(pos2<=cad2.dim)do begin
     cad1.LeerPal(pos1,pal1);
     AddPal(pal1);
     cad2.LeerPal(pos2,pal2);
     AddPal(pal2);
 end;

 while(pos1<=cad1.dim)do begin
      cad1.LeerPal(pos1,pal1);
      AddPal(pal1);
 end;

 while(pos1<=cad1.dim)do begin
      cad2.LeerPal(pos2,pal2);
      AddPal(pal2);
 end;
end;

//invertir palabra por palabra
//h o   l a  c o m o  e s t a s
function cadena.invertirPal(): String;
  var pos:integer;
     pal,cadena:String;
  begin
  pos:=1;  cadena:=''; pal:='';
    while(pos<=dim)do
    begin
     LeerPal(pos,pal); //pal=la
     if(pal<>'')then
       cadena:=pal+' '+cadena;  //cadena=estas como hola
    end;
    dim:=0;
    AddPal(cadena);
    result:=cadena;
end;

procedure cadena.ConverMayus();
var i:integer;
    cadena:String;
begin
  {cadena:=elem[2];
   cadena:=UpperCase(cadena);}
  for i:=1 to dim do
  BEGIN
  cadena:=elem[i];
  elem[i]:=(UpperCase(cadena))[1];
  end;
end;

function cadena.Verif_primo(pos: integer): String;
var n:UNatural;//objeto de la clase Unatural
begin
  if(pos>0)and(pos<=dim)then begin
     n:=UNatural.Crear();        //crear objeto
    //if(elem[pos] in ['0','1','2','3','4','5','6','7','8','9'] )then begin
      if(dig.pertenece(elem[pos]))then begin
       n.setValor(ord(elem[pos])- Ord ('0')); //cargar objeto
       if(n.IsPrimo()) then       //es primo ?
         Result:=('el numero '+elem[pos]+' es primo ')
       else
         Result:=('el numero '+elem[pos]+' No es primo ')
    end else begin
     Result:='El caracter no es un numero';
    end;
  end else begin
  Result:=('posicion fuera de rango');
  end;
end;

procedure cadena.ejercicio10(pal: String);
var palabra,new:string;
        pos:Integer;
begin //[ ,j,u,a,n, ,b,r,o, ,b,r,o] dim=13
   pos:=1;  palabra:='';  new:='';
   while (pos<=dim) do begin
      LeerPal(pos,palabra);//saca palabra por palabra
                           //pos=14   palabra='bro'   pal=bro
       if (palabra<>pal)then begin    //[ ,b,r,o, ,b,r,o]  dim=7-3=4
        new:=new+' '+palabra;  //[ , ,j,u,a,n]
       end;
   end;
   dim:=0;  AddPal(new); //[ , , ,j,u,a,n]
end;

procedure cadena.delPalabrasRepetidas();
var pal:string;
      i:Integer;
begin //[ ,j,u,a,n, ,b,r,o, ,b,r,o] dim=13
   i:=1;  pal:='';
   while ( i <= dim) do begin
      LeerPal(i,pal);//saca palabra por palabra
      if(frecuenciaPal(pal) > 1)then begin //la palabra se repite
         EliminarAll(pal);
      end;
   end;
end;

function cadena.cantCaracteres(): Integer;
var cp,pos:integer;
     pal:String;
begin
  cp:=0;  pos:=1; pal:='';
  while(pos<=dim)do
  begin
   LeerPal(pos,pal);
   if(pal<>'')then
   cp:=cp+Length(pal);
  end;
  result:=cp;
end;

function cadena.LongMedia(): real;
begin
  result:= (cantCaracteres()/CantPal());
end;

function cadena.Ppal_UltCaracter(): Char;
var pos:integer;
     pal:String;
begin
  pos:=1; pal:='';
  while(pos<=dim)do
  begin
   LeerPal(pos,pal);
   if(pal<>'')then begin
     pos:=dim+1;
   end;
  end;
  result:=pal[Length(pal)];
end;

function cadena.cantpal_Fin(cha: char): integer;
var cp,pos:integer;
     pal:String;
begin
  cp:=0;  pos:=1; pal:='';
  while(pos<=dim)do
  begin
   LeerPal(pos,pal);
   if(pal<>'')then begin
        if(pal[Length(pal)]=cha)then
           cp:=cp+1;
   end;

  end;
  result:=cp;
end;

procedure cadena.leerNumReales(var pos: integer; var pal: String);
begin
  pal:='';           //sep[ . | ; |  | , | : | - | _ ]
  while(pos<=dim)and(elem[pos] in ['0'..'9','.'])do
  begin  //encuentra[ . | ; |  | , | : | - | _ ]->finaliza
    pal:=pal+elem[pos];  //pal='ho'
    pos:=pos+1;          //pos=5
  end;
  while(pos<=dim)and(not (elem[pos] in ['0'..'9','.']))do
  begin //pos queda como puntero de la siguiente palabra
    pos:=pos+1;
  end;
end;

procedure cadena.mostrarNum();
var i:Integer;
    pal:String;
begin
i:=1; pal:='';
while (i <= dim) do begin
      leerNumReales(i,pal);
      if(pal <> '') then
             ShowMessage(pal);
end;
end;

procedure cadena.Intercambiar(a, b: integer);
var aux: char;
begin
  aux:=elem[a];
  elem[a]:=elem[b];
  elem[b]:=aux;
end;

procedure cadena.Encriptar(k: byte);
var i, pos, p :integer;
begin
  p := 97;
  for i:=1 to dim do begin
       if (elem[i]<>' ') then begin
        //ShowMessage(IntToStr(ord(elem[i])));
          pos := (ord(elem[i])+k);
          elem[i]:= char((pos-p) mod (26) + p) ;
       end;
  end;
end;

procedure cadena.Desencriptar(k: byte);
var i,p,pos :integer;
begin
  p := 97;
  for i:=1 to dim do begin
    if (elem[i]<>' ') then begin
      pos := (ord(elem[i]))+26-k;//219
      elem[i]:=char((pos-p) mod 26 + p);
    end;
  end;
end;

procedure cadena.InvertirCadaPalabra;
var  posIni, posfin  :byte;
    i: integer;
    pal : string;
begin
  i := 1;
  while i <= self.dim do begin
    pal := self.LeerPal(i);
    posIni := i - Length(pal);
    posfin := i - 1;
    self.Invertir(posIni, posfin);
  end;
 end;

procedure cadena.RotarIzq(cant: word);
 var e: char;
    j, i: word;
begin
   for j:=1 to cant do begin
     e := self.elem[1];
     for i:=1 to dim-1 do begin
       elem[i] := elem[i+1];
     end;
     elem[dim] := e;
   end;
end;

procedure cadena.RotarIzqV1(cant: word);
var i : word;
begin
  for i:=1 to cant do
    elem[dim+i] := elem[i];
  for i:=1 to dim do
    elem[i] := elem[i+cant];
end;

procedure cadena.RotarDer(cant: word);
 var e: char;
    j, i: word;
begin
   for j:=1 to cant do begin
     e := self.elem[dim];
     for i:=dim downto 2 do begin
       elem[i] := elem[i-1];
     end;
     elem[1] := e;
   end;
end;

procedure cadena.Invertir(a, b: byte);
begin
  while a < b  do  begin
    self.Intercambiar(a,b);
    inc(a);
    dec(b);
  end;
end;

{Elimina desde una posicion la cantidad de elementos
 "hola como estas": DeletePos(posicion=6, cantidad=3)
 "hola o estas" }
procedure cadena.DeletePos(posicion, cantidad: word);
var i: word;
begin
  if not ((posicion >= 1)and(posicion <= self.dim)) then
     raise Exception.Create('Posicion Fuera de rango, DeletePos()');

    if (posicion+cantidad) > self.dim then
      self.dim := posicion - 1
    else begin
      for i := posicion+cantidad to self.dim do
        self.elem[i-cantidad] := self.elem[i];
      self.dim := self.dim - cantidad;
    end;
end;

{Elimina una palabra de todo el vector
"hola como hola": DeleteAllPalabra(palabraBusc='hola')
 "hola o estas"}
procedure cadena.DeleteAllPalabra(palabraBusc: String);
var pos : word;
begin
  pos := 1;
  repeat
    pos := Posicion(pos, self.dim, palabraBusc);
  until (pos = 0);
end;

function cadena.Posicion(buscPalabra: String): word;
begin
  result := self.Posicion(1, self.dim, buscPalabra);
end;



{Retorna la posicion donde encontro la sub cadena
 "hola como estas": Posicion(buscPalabra='como') ==> 6
 "hola como estas": Posicion(buscPalabra='ta') ==> 13
 "hola como estas": Posicion(buscPalabra='xo') ==> 0
 }
function cadena.Posicion(a, b: word; buscPalabra: String): word;
var p : word;
begin
  if not self.verifRango(a,b) then
    raise Exception.Create('Posicion(a,b): Fuera del rango');
  p := a -1;
  repeat
    p := BuscarCaracter(p + 1, b, buscPalabra[1]);
  until(p = 0)or ((self.EsSubCadena(p, b, buscPalabra)));
  result := p;
end;

function cadena.verifRango(a, b: word): boolean;
begin
  result := ((b-a+1 > 0) and (a >= 1) and (b <= self.dim)) ;
end;


function cadena.BuscarCaracter(a, b: word; busq: char): word;
var pos : word;
begin
  if not verifRango(a, b) then
    raise Exception.Create('BuscarCaracter(a,b,busq): Fuera del rango');

  while (a <= b) and (self.elem[a] <> busq) do
    inc(a);
  if (a <= b) then pos := a  else pos := 0;
  Result := pos;
end;

function cadena.EsSubCadena(a, b: word; cad: String): boolean;
var
    k, n : word;
    sw : boolean;
begin
  if not verifRango(a, b) then
    raise Exception.Create('EsSubCadena(a,b,x): Fuera del rango');

  k := 1;
  n := Length(cad);
  a := a - 1;
  while(a+k <= b) and (k <= n)and(self.elem[a+k] = cad[k]) do
    inc(k);
  if (k <= n) then  sw := false else sw := true;
  result := sw;
end;

function cadena.EsRepetido(a, b: word; x: char): boolean;
var c :word;
begin
  if not verifRango(a, b) then
    raise Exception.Create('EsRepetido(a,b,x): Fuera del rango');
  c := 0;
  while ( a <= b)and(c <=1) do begin
    if (self.elem[a] = x) then
      inc(c);
    inc(a);
  end;
  result := (c >= 2);
end;


function cadena.LeerPal(var a: integer; b: integer): String;
var pal:string;
begin
  pal:='';
  while(a<=b)and(sep.pertenece(elem[a]))do //pos queda como puntero de la siguiente palabra
    a:=a+1;            //sep[ . | ; |  | , | : | - | _ ]
  while(a<=b)and(not sep.pertenece(elem[a]))do begin   //encuentra[ . | ; |  | , | : | - | _ ]->finaliza
    pal:=pal+elem[a];  //pal='ho'
    a:=a+1;          //pos=5
  end;
  result := pal;
end;

function cadena.LeerPal(var pos: integer): String;
begin
  result := self.LeerPal(pos, self.dim);
end;



end.

