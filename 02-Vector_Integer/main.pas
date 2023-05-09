unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, Menus,uvector;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
        v1:vector;
        v2:vector;
        v3:vector;
        v4:vector;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
     v1 := vector.crear();
     v2 := vector.crear();
     v3 := vector.crear();
     v4 := vector.crear();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  case(ComboBox1.ItemIndex) of
     0: ShowMessage('seleccione un Vector');
     1: begin
             v1.CargarRnd(1,10);
             v1.descargar(StringGrid1);
        end;
     2: begin
             v2.CargarRnd(1,10);
             v2.descargar(StringGrid1);
        end;
     3: begin
             v3.CargarRnd(1,10);
             v3.descargar(StringGrid1);
        end;
     4: begin
             v4.CargarRnd(1,10);
             v4.descargar(StringGrid1);
        end;
     else ShowMessage('ERROR');
    end;
  ComboBox1.ItemIndex:=0;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  //v1.intercalar3Vectores(v2,v3,v4);
 // v1.Dim:=5;
  Edit1.Text := v1.descargar();
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  v1.ord_seleccion();
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  case(ComboBox1.ItemIndex) of
     0: ShowMessage('seleccione un Vector');
     1: begin
             v1.Cargar();
             v1.descargar(StringGrid1);
        end;
     2: begin
             v2.Cargar();
             v2.descargar(StringGrid1);
        end;
     3: begin
             v3.Cargar();
             v3.descargar(StringGrid1);
        end;
     4: begin
             v4.Cargar();
             v4.descargar(StringGrid1);
        end;
     else ShowMessage('ERROR');
    end;
    ComboBox1.ItemIndex:=0;
end;



procedure TForm1.ComboBox1Change(Sender: TObject);
begin
    case(ComboBox1.ItemIndex) of //
     0: {nada};//mostrar vector
     1: v1.descargar(StringGrid1);
     2: v2.descargar(StringGrid1);
     3: v3.descargar(StringGrid1);
     4: v4.descargar(StringGrid1);
     else ShowMessage('ERROR');
    end;
end;




end.

