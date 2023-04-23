unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, UCNatural;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
   obj : Natural;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Edit2.Text := IntToStr(obj.SumarDigitos());
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Edit2.Text := obj.ToRomano();
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  Edit2.Text := obj.ToLiteral();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  obj := Natural.create;
end;

procedure TForm1.Button1Click(Sender: TObject);
var cadena : string;
begin
  cadena := Edit1.Text;   //'5' //strtoint('5')=> 5
  obj.cargar(StrToInt(cadena));
end;

procedure TForm1.Button2Click(Sender: TObject);
var x : cardinal;
begin
  x := obj.descargar();
  Edit2.Text := IntToStr(x);
end;

end.

