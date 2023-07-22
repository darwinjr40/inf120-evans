unit UnitEmpleado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;
  type
      Empleado = Record
        Nombre:String[60];
        sexo :String[60];
        cargo :String[60];
        sueldo : integer;
        moneda :String[60];
      end;


  { FileTipo }

  { FileEmpleado }

  FileEmpleado=Class
     private
          f:file of Empleado; //
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
       procedure EscribirTipo(r:Empleado);
       //devuelve El type de un registro o fila
       function LeerTipo:Empleado;
       //retorna nombre
       function getNom():String;
       //retorna extension
       function getExt():String;
       //verifica si llegaste al final de la fila
       Function EsFin():Boolean;
       //cierra un archivo
       procedure Cerrar();
   end;
implementation




{ FileEmpleado }

constructor FileEmpleado.Create();
begin
   nom:='FileTipo';
  ext:='dat';
  modo:=-1;
end;

procedure FileEmpleado.setNom(s: String);
begin
  nom:=s;
end;

procedure FileEmpleado.setExt(s: String);
begin
  ext:=s;
end;

procedure FileEmpleado.Crear();
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

procedure FileEmpleado.Abrir();
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

procedure FileEmpleado.EscribirTipo(r: Empleado);
begin
   write(f,r);
end;

function FileEmpleado.LeerTipo: Empleado;
var r : Empleado;
begin
   if(modo=1)then begin //modo lectura
    read(f,r)         // r = F.TEXTo[puntero];
  end else begin
    r.Nombre:='';
    r.sexo:='';
    r.cargo:='';
    r.sueldo:=-1;
    r.moneda:='';
  end;
    result:=r;
end;

function FileEmpleado.getNom(): String;
begin
  result:=nom;
end;

function FileEmpleado.getExt(): String;
begin
  result:=ext;
end;

function FileEmpleado.EsFin(): Boolean;
begin
     Result:=EOf(f);
end;

procedure FileEmpleado.Cerrar();
begin
   Close(f);
  modo:=-1;
end;

end.

