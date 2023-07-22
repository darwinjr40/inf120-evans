unit Cadenas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Conjunto,Dialogs,Natural;
  const MAX_ELE = 1200;
  type

  { cadena }

 cadena = class
    private
       elem :array [1..MAX_ELE] OF char;  //vector
       dim: integer;                      //dim=puntero
       May,Min,Dig,Sep:conjuntos;
     public
       Constructor crear();
       function  descargar():String;
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
       procedure ejercicio1(cad2 :cadena;pal: String);
       procedure Invertir();
       procedure ejercicio6(cad1,cad2:String);
       function invertirPal():String;
       procedure ConverMayus();
       function Verif_primo(pos:integer):String;
       procedure ejercicio10(pal:String);
       function cantCaracteres():Integer;
       function LongMedia():real;
       function Ppal_UltCaracter():Char;
       FUNCTION cantpal_Fin(cha:char):integer;
       procedure setDim(cant:integer);
       procedure setchar(pos :integer;c:char);
       procedure selectReal();
       procedure leerNumReales(var pos: integer; var pal: String);
       procedure EliminarAll(delPal:String);

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
      May.agregar(char(65+i));//A..Z
    Min:=conjuntos.crear;
    for i:=0 to 25 do
      Min.agregar(char(97+i));//a..z
    Dig:=conjuntos.crear;
    for i:=0 to 9 do
      Dig.agregar(char(48+i));//0..9
      Sep:=conjuntos.crear;
     // Sep.agregar('.');
     // Sep.agregar(';');
      Sep.agregar(' ');
     // Sep.agregar(',');
     // Sep.agregar(':');
     // Sep.agregar('-');
     // Sep.agregar('_');

end;

function cadena.descargar(): String;
var c:String;
    i:Integer;
begin
  for i:=1  to dim do begin
     c:=c+elem[i];
  end;
  result:=c;
end;

//Adiciona una nueva palabra al objeto
procedure cadena.AddPal(pal: String);
var n,i:integer;
begin
   n:=Length(pal);//'jose'=4
   if(dim+n+1<=MAX_ELE)then begin//longitud actual <= longitudMax
      //if(dim<>0)then begin
       dim:=dim+1;
       elem[dim]:=' '; //[ |]
      //end;
        for i:=1 to n do begin
         dim:=dim+1;   //[ | |]
         elem[dim]:=pal[i];
        end;
   end;
end;
//Inserta una character en una posicion(2,'X')
//[a,b,c,d]->[a,X,b,c,d]
procedure cadena.Inserchar(pos: integer; ele: char);
var i:integer;
begin
 dim:=dim+1;
 for i:=dim downto (pos+1) do
     BEGIN
     elem[i]:=elem[i-1];
     end;
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
procedure cadena.LeerPal(var pos: integer; var pal: String);
begin
  pal:='';           //sep[ . | ; |  | , | : | - | _ ]
  while(pos<=dim)and(not sep.pertenece(elem[pos]))do
  begin  //encuentra[ . | ; |  | , | : | - | _ ]->finaliza
    pal:=pal+elem[pos];
    pos:=pos+1;
  end;
  while(pos<=dim)and(sep.pertenece(elem[pos]))do
  begin //pos queda como puntero de la siguiente palabra
    pos:=pos+1;
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
//frecuencia de una palabra(pal)
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
//invertir palabra por palabra
function cadena.invertirPal(): String;
  var pos:integer;
     pal,cadena:String;
  begin
  pos:=1;  cadena:=''; pal:='';
    while(pos<=dim)do
    begin
     LeerPal(pos,pal); //pal=como
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

procedure cadena.setDim(cant: integer);
begin
  dim:=cant;
end;

procedure cadena.setchar(pos: integer; c: char);
begin
  if(pos>=1)and(pos<=dim) then begin
     elem[pos]:=c;
  end;
end;

procedure cadena.selectReal();
var i:integer;
begin
  for i:=1 to dim do begin
      if not(elem[i]in ['0'..'9','.'])then begin
         elem[i]:=' ';
      end;
  end;
end;

procedure cadena.leerNumReales(var pos: integer; var pal: String);
begin
  pal:='';           //sep[ . | ; |  | , | : | - | _ ]
  while(pos<=dim)and(elem[pos] in ['0'..'9','.'])do begin
    pal:=pal+elem[pos];  //pal='ho'
    pos:=pos+1;          //pos=5
  end;
  while(pos<=dim)and(not (elem[pos] in ['0'..'9','.']))do begin
    pos:=pos+1;
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
     end;
  end;
end;





end.

