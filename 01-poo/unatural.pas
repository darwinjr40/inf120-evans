unit UNatural;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

  type

    { Natural }

    Natural = class
      {privado}
      private
        n: Cardinal;
      {publico}
      public
        constructor Crear();
        procedure setN(x:Cardinal);
        function GetN(): Cardinal;
        function GetNaturales():string;
        function GetDivisionSucesiva7(m:cardinal):integer;
    end;

implementation

{ Natural }

constructor Natural.Crear;
begin
  self.n:=0;
end;

procedure Natural.setN(x: Cardinal);
begin
  n := x;
end;

function Natural.GetN: Cardinal;
begin
  result := n;
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

end.

