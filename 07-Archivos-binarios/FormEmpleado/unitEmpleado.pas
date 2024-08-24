unit UnitEmpleado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, Grids;
  type
      Empleado = Record
        Nombre:String[60];
        sexo :char;
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
       procedure Descargar(v: TStringGrid);
       function Descargar():String;
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
       procedure adicionar(nombr:String;se:char; car: String; sue: Integer; mon: String);
       function  getSueldoMayorTipo(genero: char): cardinal;
       function  get2sueldosMayoresAndMostrarMujeres():String;
       function  getPromedioSueldo():real;
       function  getMayorAlPromAndMayorSueldo():String;
       function  EmpleadoToStr(e: Empleado): String;
       function  ListarMujeres(): String;
       function  ListarSueldosMayoreMujeres(): String;
  end;
implementation




{ FileEmpleado }

constructor FileEmpleado.Create();
begin
  nom:='FileTipo';
  ext:='dat';
  modo:=-1;
end;

procedure FileEmpleado.Descargar(v: TStringGrid);
var r: Empleado;
    c : byte;
begin
  self.Abrir();
  c := 0;
  v.ColCount:= 5;
  v.RowCount:= 50;
  v.Cells[0, c] := 'nombre';
  v.Cells[1, c] := 'Sexo';
  v.Cells[2, c] := 'Cargo';
  v.Cells[3, c] := 'Sueldo';
  v.Cells[4, c] := 'Moneda';
  WHILE(not self.EsFin())do begin //Incrementa el indice automaticamente Hasta llegar al ultimo registro
       r := LeerTipo();
       c := c + 1;
       v.Cells[0, c] := r.Nombre;
       v.Cells[1, c] := r.sexo;
       v.Cells[2, c] := r.cargo;
       v.Cells[3, c] := Inttostr(r.sueldo);
       v.Cells[4, c] := r.moneda;
  end;

  self.Cerrar();
end;

function FileEmpleado.Descargar: String;
var cad:String;
      r:Empleado;
begin
    Abrir();
    cad:='Nombre    sexo   cargo     sueldo    moneda'+#10#13;
    WHILE(not EsFin())do begin //Incrementa el indice automaticamente Hasta llegar al ultimo registro
       r:= LeerTipo;
       cad:=cad+ r.Nombre+'  ' + r.sexo+'  '+ r.cargo +'  '+ Inttostr(r.sueldo) + r.moneda + #10#13;
    end;
     Cerrar();
result := cad;
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
  if(modo<>1)then begin //modo lectura
    raise Exception.Create('Error!, Modo no Lectura');
  end;
  read(f,r);
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
  Result := EOf(f);
end;

procedure FileEmpleado.Cerrar();
begin
  Close(f);
  self.modo := -1;
end;

procedure FileEmpleado.Posicionar(pos: Integer);
begin
   if((pos>=1)and((pos-1)<=FileSize(f)))then begin
   Seek(f,pos-1); //texto empieza en el registro 0
 end else begin
   ShowMessage('FileTipo.posicionar: Fuera de rango...');
 end;
end;

procedure FileEmpleado.adicionar(nombr:String;se:char; car: String; sue: Integer; mon: String
  );
var e : Empleado;
begin
  e.Nombre:=nombr;
  e.sexo:=se;
  e.cargo:=car;
  e.sueldo:=sue;
  e.moneda:=mon;
  EscribirTipo(e);
end;
//asumir que el archivo esta abierto
function FileEmpleado.getSueldoMayorTipo(genero: char): cardinal;
var e : Empleado;
    s :Integer;
begin
  s := 0;
  Posicionar(1);
  while (not EsFin()) do begin
       e := LeerTipo;
       if ((e.sexo = genero)and(e.sueldo > s)) then begin
          s := e.sueldo;
       end;
   end;
  result := s;
end;


function FileEmpleado.get2sueldosMayoresAndMostrarMujeres(): String;
var e : Empleado;
    sueldo1,sueldo2 :Integer;
    lista : String;
begin
   Abrir();
   sueldo1 := self.getSueldoMayorTipo('M');
   sueldo2 := 0;
   lista := '--Lista Mujeres--' + #10#13;
   Posicionar(1);
   while (not EsFin()) do begin
       e := LeerTipo;
       if (e.sexo = 'M') then begin
          lista := lista + EmpleadoToStr(e);
           if (e.sueldo > sueldo2 )and (e.sueldo <> sueldo1) then begin
               sueldo2 := e.sueldo;
           end;
       end;
   end;
   Cerrar();
   result :=  lista +
             'Primer sueldo mayor = ' + IntToStr(sueldo1) + #10#13 +
             'segundo sueldo mayor = ' + IntToStr(sueldo2);
end;
//asumir que el archivo esa abierto
function FileEmpleado.getPromedioSueldo: real;
var prom : Real;
    cp, sp :Integer;
    e : Empleado;
begin
   self.Posicionar(1);
   cp := 0;
   sp := 0;
   while (not EsFin()) do begin
       e := LeerTipo;
       sp := sp + e.sueldo ;
       cp := cp + 1 ;
   end;
   if(cp > 0)then prom:= sp/cp ;
   result := prom;
end;

function FileEmpleado.getMayorAlPromAndMayorSueldo(): String;
var e : Empleado;
    cad, cad2 : String;
    prom : Real;
    may :Integer;
begin //prom = (500 + 200 + 300 + 1000 + 800 ) / 5 ==> 560
   Abrir();
   cad := ''; cad2 :='';
   may := 0;
   prom := self.getPromedioSueldo();
   //Sacar el (Mayor sueldo) y (empleados con sueldo mayor al promedio)
   self.Posicionar(1);
   while (not EsFin()) do begin
       e := LeerTipo;
       if (e.sueldo > prom ) then begin
         cad := cad + EmpleadoToStr(e);
       end;
       if (e.sueldo > may ) then begin
         may := e.sueldo;
         cad2 := 'EL EMPLEADO CON MAYOR SUELDO ES : ' + #10#13 +
                 EmpleadoToStr(e);
       end;
   end;
   Cerrar();
   //result:= 'el promedio es = ' + FloatToStr(prom);
   result:= 'LISTA DE EMPLEADOS CON SUELDO MAYOR AL PROMEDIO : ' +cad +#10#13 + cad2;
end;

function FileEmpleado.EmpleadoToStr(e: Empleado): String;
begin
  result := e.Nombre+'  ' + e.sexo+'  '+ e.cargo +'  '+ Inttostr(e.sueldo) + e.moneda + #10#13;
end;

function FileEmpleado.ListarMujeres: String;
var r: empleado;
    s: string;
begin
  s := '';
  self.Abrir();
  while (not self.EsFin()) do begin
    r := self.LeerTipo();
    if (r.sexo = 'M') then
    begin
      s := s + EmpleadoToStr(r);
    end;
  end;
  self.Cerrar();
  result := s;
end;

function FileEmpleado.ListarSueldosMayoreMujeres: String;
var s1, s2: integer;
    r: empleado;
    sw: boolean;
begin
  Abrir();
  sw := false;
  while (not self.EsFin())and(not sw) do begin
    r := self.LeerTipo();
    if (r.sexo = 'M') then begin
      s1 := r.sueldo;
      s2 := 0;
      sw := true;
    end;
  end;
  while (not self.EsFin()) do begin
    r := self.LeerTipo();
    if (r.sexo = 'M') then
    begin
      if r.sueldo > s1 then begin
        s2 := s1;
        s1 := r.sueldo;
      end else if(r.sueldo > s2) then begin
        s2 := r.sueldo;
      end;
    end;
  end;
  Cerrar();
  result := 'sueldo1: ' + IntToStr(s1) + #10+#13 + 'sueldo2: ' + IntToStr(s2);
end;

end.

