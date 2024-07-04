unit Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  Buttons, UnitEmpleado;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
//var e : Empleado;
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
begin
    showMessage(t.Descargar());
end;

procedure TForm1.Button3Click(Sender: TObject);
var salida: string;
begin
  //ShowMessage(t.get2sueldosMayoresAndMostrarMujeres());
  //ShowMessage(t.getMayorAlPromAndMayorSueldo());
  salida := t.ListarMujeres();
  ShowMessage(salida);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  t.Descargar(StringGrid1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  T := FileEmpleado.Create();
end;

end.

