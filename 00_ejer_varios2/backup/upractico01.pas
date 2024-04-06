unit UPractico01;

{$mode ObjFPC}{$H+}


interface
    uses
      Classes, SysUtils, math;


    function CantDig(x: integer): integer;
    procedure Union(a,b: Cardinal; var c:Cardinal);
    procedure DosDigsMay(n:Cardinal; var m1,m2: Cardinal);

implementation
  function CantDig(x: integer): integer;
  begin
    if(x = 0)then begin
      result := 1;
    end else begin
      result := trunc(log10(x))+1;   //trunc(10.8) => 10
    end;
  end;

  procedure Union(a,b: Cardinal; var c:Cardinal);
  begin
    c := a * trunc(power(10, CantDig(b))) + b;
  end;

  procedure DosDigsMay(n:Cardinal; var m1,m2: Cardinal);
  var d : byte;
  begin
    m1:=0;
    m2:=0;
    while n > 0 do
    begin
       d := n mod 10;
       n := n div 10;
       if d>m1 then
       begin
         m2 := m1;
         m1 := d;
       end
       else if(d>m2)then begin
         m2 := d;
       end;
    end;
  end;

end.

