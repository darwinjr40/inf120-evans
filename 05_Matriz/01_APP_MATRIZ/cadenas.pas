unit Cadenas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Conjunto;
  const MAX_ELE = 1200;
  type

  { cadena }

 cadena = class
    private
       elem :array [1..MAX_ELE] OF char;
       dim: integer;
       May,Min,Dig,Sep:conjuntos;
     public
       Constructor crear();
       procedure LeerPal(var pos:integer;var pal:String);
       procedure AddPal(pal :String);
       procedure Inserchar(pos:integer;ele:char);
       procedure InserPal(pos:integer;pal:String);
       procedure Eliminar(pal:String);
       procedure ReemPal(palO,PalN:String);
       function CantPal():integer;
       function BuscPal(palB:String):integer;
       function getDim():integer;
       function getChar(pos:integer):char;
       function frecuenciaPal(pal:String):integer;
       procedure ejercicio1(var pal:String);
       procedure ejercicio8();
       procedure ejercicio6(cad1,cad2:String);
       function invertirPal():String;
       procedure ConverMayus();
       procedure exa2(pal,palnueva:String );

  end;
implementation
//inicializamos el constructor del objeto
constructor cadena.crear();
var i:integer;
begin
  dim:=0;
  for i:=1 to MAX_ELE do
    elem[i]:=char(0);
    May:=conjuntos.crear;
    for i:=0 to 25 do
      May.agregar(char(65+i));//A..Z
    Min:=conjuntos.crear;
    for i:=0 to 25 do
      Min.agregar(char(97+i));//a..z
    Dig:=conjuntos.crear;
    for i:=0 to 9 do
      Dig.agregar(char(48+i));//0..9
    Sep:=conjuntos.crear;
      Sep.agregar('.');
      Sep.agregar(';');
      Sep.agregar(' ');
      Sep.agregar(',');
      Sep.agregar(':');
      Sep.agregar('-');
      Sep.agregar('_');

end;
//Adiciona una nueva palabra al objeto
procedure cadena.AddPal(pal: String);
var n,i:integer;
begin
   n:=Length(pal);//'jose'=4
   if(dim+n+1<=MAX_ELE)then
   begin
     dim:=dim+1;
     elem[dim]:=' ';
     for i:=1 to n do
     begin
       dim:=dim+1;
       elem[dim]:=pal[i];
     end;
   end;
end;
//Inserta una character en una posicion
procedure cadena.Inserchar(pos: integer; ele: char);
var i:integer;
begin
 dim:=dim+1;
 for i:=dim downto (pos+1) do
     BEGIN
     elem[i]:=elem[(i-1)];
     end;
 elem[pos]:=ele;
end;
//Inserta una nueva palabra apartir de  una posicion
procedure cadena.InserPal(pos: integer; pal: String);
var i:integer;
begin
  Inserchar(pos,' ');
  for i:=1 to length(pal)do
   begin
       pos:=pos+1;
       Inserchar(pos,pal[i]);
   end;
   Inserchar(pos+1,' ');
end;
//Elimina una palabra de la cadena
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

//pos=contador que ira incrementando
//pal=sacara la primera palabra desdes (pos)
procedure cadena.LeerPal(var pos: integer; var pal: String);
begin
  pal:='';
  while(pos<=dim)and(not sep.pertenece(elem[pos]))do
  begin
    pal:=pal+elem[pos];
    pos:=pos+1;
  end;
  while(pos<=dim)and(sep.pertenece(elem[pos]))do
  begin
    pos:=pos+1;
  end;
end;
//retorna la Cantidad de palabras
function cadena.CantPal(): integer;
var cp,pos:integer;
     pal:String;
begin
  cp:=0;  pos:=1;
  while(pos<=dim)do
  begin
   LeerPal(pos,pal);
   if(pal<>'')then
   cp:=cp+1;
  end;
  result:=cp;
end;
//agarra palabra*palabra y verifica si EXISTE(palB)
//y retorna donde se encuentra el indice
function cadena.BuscPal(palB: String): integer;
var pos,i:integer;
    pal:String;
    sw:Boolean;
begin
 sw:=false; pal:='';
 i:=1;
 while(i<=dim )and(not sw)do
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

function cadena.frecuenciaPal(pal:String): integer;
var c,i:integer;
    palabra:String;
begin
 i:=1; palabra:=''; c:=0;
 while(i<=dim)do begin
   LeerPal(i,palabra);
   if(palabra=pal)then
      c:=c+1;
 end;
 result:=c;
end;

procedure cadena.ejercicio1(var pal: String);
var n,i,pos:integer;
begin
   n:=Length(pal);//'c'o'm'o'=4
   pos:=BuscPal(pal);//6
   pal:='';
   for i:=(pos+n+1) to dim do
   begin
      pal:=pal+elem[i];
   end;
   dim:=n+pos-1;
end;

procedure cadena.ejercicio8();
var a,b:integer;
     aux:char;
begin
   a:=1;   b:=dim;
   while(a<b)do
   begin
   aux:=elem[a];
   elem[a]:=elem[b];
   elem[b]:=aux;
   a:=a+1;
   b:=b-1;
   end;
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

function cadena.invertirPal(): String;
  var cp,pos:integer;
     pal,cadena:String;
  begin
    cp:=0;  pos:=1;
    while(pos<=dim)do
    begin
     LeerPal(pos,pal); //pal=como
     if(pal<>'')then
       cadena:=pal+' '+cadena;  //cadena=estas como hola
    end;
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
  elem[i]:=(LowerCase(cadena))[1];
  end;
end;

procedure cadena.exa2(pal, palnueva: String);
begin

end;





end.

