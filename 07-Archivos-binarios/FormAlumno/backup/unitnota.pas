unit UnitNota;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs;
  

  Type
   Nota=Record  //permite grabar en un solo registro
     INF110:Integer;
     LIN100:Integer;
     MAT101:Integer;
     FIS101:Integer;
     INF119:Integer;
  end;

   { FileTipo }

   { FileNota }

   FileNota=Class
     private
          f:file of Nota; //
    nom,ext:String;        //Nombre del archivo
       modo:integer; //Lectura o Escritura


   public
       Constructor Create();
       //enviar nombre del archivo
       Procedure setNom(s:String);
       //cargar extencion del archico"txt"
       Procedure setExt(s:String);
       //Crea un archivo nuevo, Activa modo escritura(0)
       procedure Crear();
       //Abre el archivo creado,Activamos modo lectura(1)
       procedure Abrir();
       //Escribe un registro o fila
       procedure EscribirTipo(r:nota);
       //devuelve El type de un registro o fila
       function LeerTipo:nota;
       //retorna nombre
       function getNom():String;
       //retorna extension
       function getExt():String;
       //verifica si llegaste al final de la fila
       Function EsFin():Boolean;
       //cierra un archivo
       procedure Cerrar();
       procedure Posicionar(pos:Integer);//fijar el puntero en registro
    end;
implementation


{ FileTipo }

constructor FileNota.Create();
begin
  nom:='FileNota';
  ext:='dat';
  modo:=-1;
end;

procedure FileNota.setNom(s: String);
begin
   nom:=s;
end;

procedure FileNota.setExt(s: String);
begin
    ext:=s;
end;

procedure FileNota.Crear();
begin
    Assign(f,nom+'.'+ext);//Asignando un nombre a f
   {$I-}
   Rewrite(f);//Crea o sobreEscribe un nuevo texto
   {$I+}
   if(IOResult<>0)then begin
     ShowMessage('FileTipo.Crear : Error en creacion de TIPO.');
   end else begin //ShowMessage('Texto.Crear : Archivo TXT creado');
     modo:=0;   //0 -> modo escritura
   end;
end;

procedure FileNota.Abrir();
begin
  Assign(f,nom+'.'+ext);//Asignando un nombre a f
  {$I-}
  Reset(f);//abre un texto con el nombre que se le asigno
  {$I+}
  if(IOResult<>0)then begin
    ShowMessage('FileTipo.Abrir : Error en apertura de TIPO.');
  end else begin //ShowMessage('Texto.Crear : Archivo TXT Abierto...');
    modo:=1;  //modo lectura
  end;
end;

procedure FileNota.EscribirTipo(r: nota);
begin
   write(f,r);
end;

function FileNota.LeerTipo: nota;
Var r:Tipo;
begin
  if(modo=1)then begin //modo lectura
    read(f,r)         // r = F.TEXTo[puntero];
  end else begin
    r.INF110:=-1;
    r.LIN100:=-1;
    r.MAT101:=-1;
    r.FIS101:=-1;
    r.INF119:=-1;
  end;
    result:=r;
end;

function FileNota.getNom(): String;
begin
    result:=nom;
end;

function FileNota.getExt(): String;
begin
     result:=ext;
end;

function FileNota.EsFin(): Boolean;
begin
    Result:=EOf(f);
end;

procedure FileNota.Cerrar();
begin
   Close(f);
  modo:=-1;
end;

procedure FileNota.Posicionar(pos: Integer);
begin
    if((pos>=1)and((pos-1)<=FileSize(f)))then begin
   Seek(f,pos-1); //texto empieza en el registro 0
 end else begin
   ShowMessage('FileTipo.posicionar: Fuera de rango...');
 end;
end;

end.

