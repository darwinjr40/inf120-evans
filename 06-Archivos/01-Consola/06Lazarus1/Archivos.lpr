program Archivos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
{caracter a caracter
"Texto.txt"
 1124123
 Juan Perez
 Informatica
}
 var f:text;
     nom:String;
begin
  nom:='texto.txt';
  assign(f,nom);     //Asignamos un nombre
  {$I-}
  rewrite(f);        //creamos o remplazamos el archivo "Text"
  {$I+}
  IF(IOResult<>0)THEN begin
    WriteLn('error en creacion....');
    Exit;
  end;//caracter a caracter
  write(f,'1');
  write(f,'1');
  write(f,'2');
  write(f,'4');
  write(f,'1');
  write(f,'2');
  write(f,'3');
  write(f,#10);
  write(f,#13);
  write(f,'J');
  write(f,'u');
  write(f,'a');
  write(f,'n');
  write(f,' ');
  write(f,'P');
  write(f,'e');
  write(f,'r');
  write(f,'e');
  write(f,'z');
  write(f,#10);
  write(f,#13);
  write(f,'i');
  write(f,'n');
  write(f,'f');
  write(f,'o');
  write(f,'r');
  write(f,'m');
  write(f,'a');
  write(f,'t');
  write(f,'i');
  write(f,'c');
  write(f,'a');
  close(F);
  writeln('se creo el txt....');
  READLN();
end.

