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
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
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
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
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
  Edit2.Text := Natural.ToLiteral(obj.GetValor());
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
  Natural.ToBinario(x); //x=3.25
  Edit2.Text:= floatToStr(x);//11,01

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  obj := Natural.create;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  obj.Invertir();
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
var r: boolean;
    resp: string;
begin
  r := obj.EsCapicua();
  resp := BoolToStr(r, true);
  ShowMessage(resp);
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
var aux : Natural;
      n, i: cardinal;//0 ..num de 10 dig
begin
  aux:= Natural.create;
  n := obj.GetValor();
  ListBox1.Clear;
  for i:=1 to n do begin
     aux.SetValor(i);
     if (aux.EsCapicua()
         and aux.VerifPrimoV02()) then
     begin
        ListBox1.Items.Add(IntToStr(i));//5->'5'
     end;
  end;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  obj.InvMitad();
  //ShowMessage(inttostr(obj.getDigsDer(3)));
  //ShowMessage(inttostr(obj.get()));
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
  edit2.Text:= BoolToStr(obj.EsPar(), true);
end;

procedure TForm1.Button1Click(Sender: TObject);
var cadena : string;
    nro: cardinal;
begin
  cadena := Edit1.Text;   //'5' //strtoint('5')=> 5
  nro := StrToInt(cadena);
  obj.SetValor(nro);
end;

procedure TForm1.Button2Click(Sender: TObject);
var x : cardinal;
begin
  x := obj.GetValor();
  Edit2.Text := IntToStr(x);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Edit3.Text :=obj.ToPlaca();
end;

end.

