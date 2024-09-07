unit UNatural;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, math;

  type

    { Natural }

    Natural = class
      {privado}
      private
        n: Cardinal;
      {publico}
      public
        constructor Crear();
        procedure SetN(x:Cardinal);
        function GetN(): Cardinal;
        function CantDig(): byte;
        function GetNaturales():string;
        function GetDivisionSucesiva7(m:cardinal):integer;
        procedure Union(a,b: Cardinal);
        class function Pot(a,b: Cardinal): Cardinal;

    end;

implementation

{ Natural }

constructor Natural.Crear;
begin
  self.n:=0;
end;

procedure Natural.SetN(x: Cardinal);
begin
  n := x;
end;

function Natural.GetN: Cardinal;
begin
  result := n;
end;


function Natural.CantDig: byte;
begin
  if(self.n = 0)then begin
    result := 0;
  end else begin
    result := trunc(log10(self.n))+1;   //trunc(10.8) => 10
  end;
end;

function Natural.GetNaturales: string;
var s: string;
    i: integer;
begin
  i := 1;
  s := '';
  while i<=n do
  begin
    s := s + IntToStr(i) + ', ';   //(i=5)=> '5'
    i:=i+1;
  end;
  result := s;
end;

function Natural.GetDivisionSucesiva7(m: cardinal): integer;
var c: integer;
begin
  c := 0;
  while n>=m do
  begin
    c:=c+1;
    n := n-m;
  end;
  result:=c;
end;

procedure Natural.Union(a, b: Cardinal);
var
    aux : Natural;
begin
  aux := Natural.Crear();
  aux.n := b;
  n := a * Pot(10, aux.CantDig())+ b;
end;

class function Natural.Pot(a, b: Cardinal): Cardinal;
begin
  result := trunc(power(a, b));
end;

end.

