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
       procedure Posicionar(pos:Integer);//fijar el puntero en registro
       procedure adicionar(nombre,se,car  :String; sue : Integer; mon :String);
       function  examen1():String;
       function  examen2():String;
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

procedure FileEmpleado.Posicionar(pos: Integer);
begin
   if((pos>=1)and((pos-1)<=FileSize(f)))then begin
   Seek(f,pos-1); //texto empieza en el registro 0
 end else begin
   ShowMessage('FileTipo.posicionar: Fuera de rango...');
 end;
end;

procedure FileEmpleado.adicionar(nombre, se, car: String; sue: Integer; mon: String
  );
var e : Empleado;
begin
  e.Nombre:=nombre;
  e.sexo:=se;
  e.cargo:=car;
  e.sueldo:=sue;
  e.moneda:=mon;
  EscribirTipo(e);
end;

function FileEmpleado.examen1(): String;
var e : Empleado;
    cad : String;
    sueldo1,sueldo2 :Integer;
begin
   Abrir();
   cad := '';
   sueldo1 := 0;   //1 > 0
   sueldo2 := 0;   //  < 2147483647
   while (not EsFin()) do begin
       e := LeerTipo;
       if (e.sexo = 'M') then begin
          cad := cad + e.Nombre+'  ' + e.sexo+'  '+ e.cargo +'  '+ Inttostr(e.sueldo) + e.moneda + #10#13;
           if (e.sueldo > sueldo1) then begin
               sueldo1 := e.sueldo;
           end;
       end;
   end;

   Posicionar(1);

   while (not EsFin()) do begin
       e := LeerTipo;
       if (e.sexo = 'M') then begin
           if (e.sueldo > sueldo2 )and (e.sueldo <> sueldo1) then begin
               sueldo2 := e.sueldo;
           end;
       end;
   end;

   Cerrar();
   cad := cad + #10#13 +
          'Primer sueldo mayor = ' + IntToStr(sueldo1) + #10#13 +
          'segundo sueldo mayor = ' + IntToStr(sueldo2);
   result := cad ;
end;

function FileEmpleado.examen2(): String;
var e : Empleado;
    cad, cad2 : String;
    prom : Real;
    cant, may :Integer;
begin //prom = (500 + 200 + 300 + 1000 + 800 ) / 5 ==> 560
   Abrir();
   cad := ''; cad2 :='';
   prom := 0;   //1 > 0
   //sueldo2 := 0;   //  < 2147483647
   cant := 0;
   while (not EsFin()) do begin
       e := LeerTipo;
       prom := prom + e.sueldo ;
       cant := cant + 1 ;
   end;
   prom := prom / cant ;//promedio
   //-----------------------------------
   Posicionar(1);
   while (not EsFin()) do begin
       e := LeerTipo;
       if (e.sueldo > prom ) then begin
         cad := cad + e.Nombre+'  ' + e.sexo+'  '+ e.cargo +'  '+ Inttostr(e.sueldo) + e.moneda + #10#13;
       end;
   end;
   //-----------------------------------
   Posicionar(1);
   may := 0;
   while (not EsFin()) do begin
       e := LeerTipo;
       if (e.sueldo > may ) then begin
         may := e.sueldo;
         cad2 := 'el empleado con Mayor sueldo es : ' + #10#13 + e.Nombre+'  ' + e.sexo+'  '+ e.cargo +'  '+ Inttostr(e.sueldo) + e.moneda ;
       end;
   end;
   Cerrar();
   //result:= 'el promedio es = ' + FloatToStr(prom);
   result:= cad +#10#13 + cad2;
end;

end.

