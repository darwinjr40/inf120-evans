unit Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,UnitEmpleado;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    T : FileEmpleado;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var e : Empleado;
begin
  T.Crear();
  {
  e.Nombre:=InputBox('Nombre','','');
  e.sexo:=InputBox('sexo','','');
  e.cargo:=InputBox('cargo','','');
  e.sueldo:=StrToInt(InputBox('sueldo ','',''));
  e.moneda:=InputBox('','','');
  t.EscribirTipo(e);
  }
  T.adicionar('Juan Perez', 'H', 'Tecnico', 500, '$u$');
  T.adicionar('Josefina Mojica', 'M', 'Secretaria', 200, '$u$');
  T.adicionar('Maria Nuñez', 'M', 'Experto', 300, '$u$');
  T.adicionar('Marco Condori', 'H', 'Jefe', 1000, '$u$');
  T.adicionar('Ana Maria', 'M', 'Profesional', 800, '$u$');
  T.Cerrar();
end;

procedure TForm1.Button2Click(Sender: TObject);
var cad:String;
      r:Empleado;
begin
  //if(t.existe(T.getNom(),t.getExt()))then begin
    t.Abrir();
    T.Posicionar(1);//el puntero lo iniciamos en la posicion 1
    cad:='Nombre    sexo   cargo     sueldo    moneda'+#10#13;
    WHILE(not T.EsFin())do begin //Incrementa el indice automaticamente Hasta llegar al ultimo registro
       r:= T.LeerTipo;
       cad:=cad+ r.Nombre+'  ' + r.sexo+'  '+ r.cargo +'  '+ Inttostr(r.sueldo) + r.moneda + #10#13;
    end;
     ShowMessage(cad);
     t.Cerrar();
  {
  end else begin
     ShowMessage('El archivo '+t.getNom()+'.'+t.getExt()+' no existe');
  end;
  }
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  //ShowMessage(t.examen1());
  ShowMessage(t.examen2());
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  T := FileEmpleado.Create();
end;

end.

