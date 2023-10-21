unit UCNatural;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, math;

type

  { Natural }

  Natural = class
    private
      valor: cardinal;
    public  //metodos     ctrl + shift + c
      {funciones}
      function  GetValor(): cardinal;
      function  SumarDigitos(): byte;
      function getCantDig(): byte;
      function  VerifPrimo():boolean;
      function  VerifPrimoV02():boolean;
      function  VerifPrimoV03():boolean;
      function  ToRomano(): String;  // 'XX'
      function  ToLiteral(): String;
      function  ToBaseN(b : cardinal) : String;
      {procesos}
      procedure  SetValor(x: cardinal);
      procedure Invertir();
      function EsCapicua(): boolean;
      procedure InvMitad();
      function getDigsDer(cantD : integer): integer;
      procedure DeleteDigsDer(cantD : integer);
      procedure AddNumero(x : integer);
      procedure UnirNumDer(x : integer);
      {procesos estaticos}
      class function Pot(b,e: Cardinal):Cardinal; static;
      class function VerifPartFracc(x:real):boolean; static;
      class procedure ToBinario(var x:real) static;
      class function  ToUnidad(n : byte) : String; static;
      class function  ToDecenas(n : byte) : String; static;
      class function  ToCentenas(n : word) : String; static;
      class function  ToLiteral(n : cardinal) : String; overload; static;
      //34,54 => 54,34

  end;

implementation



{ Natural }

procedure Natural.SetValor(x: cardinal);
begin
  self.valor := x; //valor = x
end;

procedure Natural.Invertir;
var aux : Cardinal;
begin
  aux := 0;
  while valor > 0 do
  begin
    aux := aux * 10 + (valor mod 10);
    valor := valor div 10;
  end;
  valor := aux;
end;

function Natural.EsCapicua: boolean;
var aux : Natural;
begin
  aux := Natural.Create;
  aux.valor:=valor;
  aux.Invertir();
  result := (aux.valor = valor);
end;

procedure Natural.InvMitad;
var cantDig, aux, mitad : integer;
begin
  cantDig := self.getCantDig();
  if valor mod 2 = 0 then
  begin

  end else begin
    mitad := self.getDigsDer(cantDig div 2);
    self.DeleteDigsDer(cantDig div 2);
    aux := self.valor;
    valor := 0;
    self.AddNumero(aux);
    UnirNumDer(mitad);
    self.AddNumero(mitad);
  end;
end;

function Natural.getDigsDer(cantD: integer): integer;
begin
  result := valor mod self.Pot(10, cantD);
end;

procedure Natural.DeleteDigsDer(cantD: integer);
begin
  valor := valor div Natural.Pot(10, cantD);
end;

procedure Natural.AddNumero(x: integer);
begin
  while x > 0 do
  begin
    valor := valor * 10 + (x mod 10);
    x := x div 10;
  end;
end;

procedure Natural.UnirNumDer(x: integer);
var aux: natural;
begin
  aux := Natural.Create;
  aux.valor := x;
  valor := valor * Natural.Pot(10, aux.getCantDig()) + x;
end;

function Natural.GetValor: cardinal;
begin
  result := self.valor;
end;

function Natural.SumarDigitos: byte;
var n : cardinal;
    d, sum : byte;
begin  //valor = 123
  n := self.valor;
  sum := 0;
  while n > 0 do
  begin
    d := n mod 10;
    n := n div 10;
    sum := sum + d;
  end;
  result := sum;
end;

function Natural.getCantDig: byte;
begin
  if valor = 0 then
    result := 0
  else
    result := trunc(Log10(valor)) + 1;
end;

function Natural.VerifPrimo: boolean;
var i : cardinal;
begin
  i := self.valor div 2;
  while (i >= 2) do begin
    if (self.valor mod i = 0)  then begin
      exit(false);
    end;
    dec(i);
  end;
  exit(true);
end;
//utilizando bandera
function Natural.VerifPrimoV02: boolean;
var i : cardinal;
   sw : boolean;
begin
  if (valor = 1) then
    result := false
  else begin
    i := self.valor div 2;
    sw := true;
    while (i >= 2)AND(sw) do begin
      if (valor mod i = 0)  then begin
        sw := false;
      end;
      dec(i); // i = i - 1
    end;
    result := sw;
  end;
end;

function Natural.VerifPrimoV03: boolean;
var i, c : cardinal;
begin
  c := 1;
  for i:= 1 to valor do begin
    if (valor mod i = 0)  then begin
        c := c + 1;
    end;
  end;
  result := (c = 2)
end;

function Natural.ToRomano: String;
const ROM : Array[1..30] of string =(
  'I','II','III','IV','V','VI','VII','VIII','IX','X',
  'XX','XXX','XL','L','LX','LXX','LXX','XC','C','CC',
  'CCC','CD','D','DC','DCC','DCCC','CM','M','MM','MMM'
);
  var d, c : byte;
         n : cardinal;
         r : String;
begin
  r := '';
  c := 0;
  n := self.valor;
  while n > 0 do begin
    d := n mod 10;  //0,1..9
    if d <> 0 then
      r := ROM[d+(c*10-c)] + r;
    c := c + 1;
    n := n div 10;
  end;
  result := r;
end;

function Natural.ToLiteral: String;
const
  NUM:Array[1..27] of string =(
   'uno','dos','tres','cuatro','cinco','seis','siete','ocho','nueve',
   'diez','veinte', 'treinta','cuarenta','cincuenta','sesenta','setenta','ochenta','noventa',
   'ciento','doscientos','trescientos','cuatrocientos','quinientos', 'seiscientos', 'setecientos', 'ochocientos', 'novecientos'
  );
  ESPECIALES: array[1..9] of string =
  ('once', 'doce', 'trece', 'catorce', 'quince', 'dieciseis', 'diecisiete', 'dieciocho', 'diecinueve');

var r, cad : string;
    c, d, d2  : byte;
         n : cardinal;
begin
  r := '';
  c := 0;
  n := self.valor;
  while (n > 0) do begin
    d := n mod 10;
    n := n div 10;
    if d > 0 then begin
      d2 := n mod 10;
      if ((d2 = 1)and(c mod 3 = 0)) then  begin  // procesar 2 dig
        cad := ESPECIALES[d];
        n := n div 10;
        inc(c);  //c := c + 1
      end else begin    //1 dig
        cad :=  NUM[d + ((c mod 3)*10-(c mod 3))] + ' ';
        if (c mod 3 = 1) then  cad := cad + 'y '
      end;
      if c = 3 then cad := cad + 'mil ';
      r := cad + r;
    end;
    inc(c); //c := c + 1
  end;
  result := r;
end;

function Natural.ToBaseN(b: cardinal): String;
const VECTOR: Array[0..15] of string =
('0','1','2','3','4','5','6','7','8','9','A','B', 'C','D','E', 'F');
var n, d : cardinal;
    r : String;
begin
  n := self.valor;  //copia
  r := '';
  while n > 0 do begin
    d := n mod b;
    n := n div b;
    R := VECTOR[d] + r;
  end;
  result := r
end;

class function Natural.Pot(b, e: Cardinal): Cardinal;
begin
  pot := trunc(power(b, e));
end;

class function Natural.VerifPartFracc(x: real): boolean;
begin
  result := (not (x = trunc(x)));
end;

class procedure Natural.ToBinario(var x: real);
var n : Natural;
    fr : real;
    d, c : byte;
    res:string;
begin
  n := Natural.create;
  n.SetValor(trunc(x)); //n = parte entera
  fr := x - trunc(x);  //fr = parte fraccion
  c := 0;
  res := n.ToBaseN(2);  //x = 11     StrToInt('')
  if res='' then x:=0 else x:=StrToInt(res);
  repeat
    fr := fr * 2;
    d := trunc(fr);   //entera
    fr := fr - d;     //
    x := x * 10 + d;
    c := c + 1;
  until (not Natural.VerifPartFracc(fr)) or (c = 8);
  x := x / Natural.Pot(10, c);
end;

class function Natural.ToUnidad(n: byte): String;
const UNI:Array[0..9] of string =
  ('','uno','dos','tres','cuatro','cinco','seis','siete','ocho','nueve');
begin
  result := UNI[n];
end;

class function Natural.ToDecenas(n: byte): String;
const
  DEC: array[1..2, 0..9] of string = (
     ('','diez', 'veinte', 'treinta', 'cuarenta', 'cincuenta', 'sesenta', 'setenta', 'ochenta', 'noventa'),
     ('','once', 'doce', 'trece', 'catorce', 'quince', 'dieciseis', 'diecisiete', 'dieciocho', 'diecinueve')
  );
var r : String;
begin
  if(n>10)and(n<20)then //11..19
    Result := (DEC[2, n mod 10])
  else begin  //n={10,20....90} or (n<=30) r='';
    if (n mod 10 = 0)or(n <= 30) then r:='' else r:=' y ';
    Result := (DEC[1, n div 10] + r + Natural.ToUnidad(n mod 10));
  end;
end;

class function Natural.ToCentenas(n: word): String;//300 => 3
const  CEN: array[0..9] of string = ('','cien','doscientos','trescientos','cuatrocientos','quinientos', 'seiscientos', 'setecientos', 'ochocientos', 'novecientos');
var r : String;
begin
  r := ' ';
  if n<100 then
    r := ''
  else if (n<200) then //ciento cinco
    r := 'to';
  Result := (CEN[n div 100] + r + Natural.ToDecenas(n mod 100));
end;

class function Natural.ToLiteral(n: cardinal): String;
const VEC:Array[0..3] of string = ('', ' mil ',' millon ',' billon ');
var r, cad : string;//uno mil veintitres
    p, d  : word;   //dos mil
begin
  r := '';
  p := 0;
  while n > 0 do  begin //123123456
    d := n mod 1000;
    n := n div 1000;
    r := Natural.ToCentenas(d) + VEC[p] + r;
    p := p + 1;
  end;
  result := r;
end;

end.

