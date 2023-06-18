unit fMatriz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, Buttons, UMatriz,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
   m1,m2,m3,m4:Matriz;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
     m1 := Matriz.crear();
     m2 := Matriz.crear();
     m3 := Matriz.crear();
     m4 := Matriz.crear();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  m1.CargarM();
  m1.descargarm(StringGrid1);

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  m1.transponerTriangulares();
  m1.descargarM(StringGrid2);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     m1.descargarm(StringGrid1);
     m1.descargarm(StringGrid1);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  m1.CargarMRnd(1,10);
end;

end.

