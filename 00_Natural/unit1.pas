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
    MainMenu2: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
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

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  Edit2.Text:= BoolToStr(obj.VerifPrimo(), true);
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
var x : real;
begin
  x := StrToFloat(edit1.Text);
  Edit2.Text:= BoolToStr(Natural.VerifPartFracc(x), true);
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
var x : real;
begin
  x := StrToFloat(edit1.Text);
  Natural.ToBinario(x);
  Edit2.Text:= floatToStr(x);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  obj := Natural.create;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  //codgio
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  //metodo2
end;

procedure TForm1.Button1Click(Sender: TObject);
var cadena : string;
begin
  cadena := Edit1.Text;   //'5' //strtoint('5')=> 5
  obj.SetValor(StrToInt(cadena));
end;

procedure TForm1.Button2Click(Sender: TObject);
var x : cardinal;
begin
  x := obj.GetValor();
  Edit2.Text := IntToStr(x);
end;

end.
