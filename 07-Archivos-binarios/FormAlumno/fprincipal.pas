unit FPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,UTipo,UnitNota;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OD: TOpenDialog;
    SD: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    //Abre un archivo "Open Dialog"
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
  T:FileTipo; //Objeto
  nota:FileNota;
  //reg:TIPO;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  T.Crear();
  ShowMessage('Archivo de alumno Creado');
end;
//Creamos el objeto  cuando el formulario se inicializa
procedure TForm1.FormCreate(Sender: TObject);
begin
  T:=FileTipo.Create();
  nota := FileNota.Create();
end;



procedure TForm1.Button1Click(Sender: TObject);
var r:Tipo;
begin
  T.Posicionar(1);
  r:=T.LeerTipo;
  Edit1.Text:=IntToStr(r.Ci);
  Edit2.Text:=IntToStr(r.Reg);
  Edit3.Text:=r.Nom;
  Edit4.Text:=r.Dir;
end;

procedure TForm1.Button2Click(Sender: TObject);
var r:Tipo;
begin
  if (T.getpos()-2 >= 0) then begin
    T.Posicionar(T.getpos()-2);
    r:=T.LeerTipo;
    Edit1.Text:=IntToStr(r.Ci);
    Edit2.Text:=IntToStr(r.Reg);
    Edit3.Text:=r.Nom;
    Edit4.Text:=r.Dir;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var r:Tipo;
begin
if (T.getpos() <= T.tamano()) then begin
  T.Posicionar(T.getpos());
  r:=T.LeerTipo;
  Edit1.Text:=IntToStr(r.Ci);
  Edit2.Text:=IntToStr(r.Reg);
  Edit3.Text:=r.Nom;
  Edit4.Text:=r.Dir;
end;
end;
procedure TForm1.Button4Click(Sender: TObject);
var r:Tipo;
begin
  T.Posicionar(T.tamano()); //posicion mas uno
  r:=T.LeerTipo;
  Edit1.Text:=IntToStr(r.Ci);
  Edit2.Text:=IntToStr(r.Reg);
  Edit3.Text:=r.Nom;
  Edit4.Text:=r.Dir;
end;



procedure TForm1.MenuItem3Click(Sender: TObject);
VAR ext,nom:String;
          i:integer;
begin
  if(OD.Execute)then begin //Abrimos ventana OpenDialog 'para buscar el archivo'
    nom:='';
    i:=1; //puntero del Opendialog empiezan en 1
    while(OD.FileName[i]<>'.')do begin//
      nom:=nom+od.FileName[i];//concatenamos character * character hasta un '.'
      i:=i+1;
    end;
    T.setNom(nom);//Set 'nombre' del archivo
    i:=i+1;
    ext:='';
    while(OD.FileName[i]<>'.')do begin
      ext:=ext+od.FileName[i];
      i:=i+1;
    end;
    T.setExt(ext);//set 'nombre' de extencion'txt'
    //Un ves teniendo el "nombre"+"ext"
    T.abrir();    //Abrimos el objeto
    ShowMessage('Archivo de alumno Abierto...');
    t.Cerrar();
  end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  T.Cerrar();
  ShowMessage('Archivo de alumno Cerrado...');
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
var cad:String;
      r:Tipo;
begin
  if(t.existe(T.getNom(),t.getExt()))then begin
    t.Abrir();
    T.Posicionar(1);//el puntero lo iniciamos en la posicion 1
    cad:='Ci    Registro   Nombre         Direccion'+#10#13;
    WHILE(not T.EsFin())do begin //Incrementa el indice automaticamente Hasta llegar al ultimo registro
       r:= T.LeerTipo;
       cad:=cad+IntToStr(r.Ci)+'  '+IntToStr(r.Reg)+'  '+r.Nom+'  '+r.Dir+#10#13;
    end;
     ShowMessage(cad);
     t.Cerrar();
  end else begin
     ShowMessage('El archivo '+t.getNom()+'.'+t.getExt()+' no existe');
  end;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
var r:Tipo;
begin
 if(t.existe(t.getNom(),t.getExt()))then begin
     r.Ci:=StrToInt(InputBox('Adicionar ','Carnet','000'));
     r.Reg:=StrToInt(InputBox('Adicionar ','Registro','000000'));
     r.Nom:=InputBox('Adicionar ','Nombre_Completo','Juan Perez');
     r.Dir:=InputBox('Adicionar ','Diecion','Av.Bush');
     t.Abrir();
     T.Posicionar(T.tamano()+1); //seek(f,filesize(f)) Estamos en T[0]
     T.EscribirTipo(r); //write(f,r)
     t.Cerrar();
 end else begin
  ShowMessage('El archivo '+t.getNom()+'.'+t.getExt()+' no existe');
 end;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  T.grabar(StrToInt(InputBox('Adicionar ','Carnet','000')),StrToInt(InputBox('Adicionar ','Registro','000000')),
          InputBox('Adicionar ','Nombre_Completo','Juan Perez'),InputBox('Adicionar ','Diecion','Av.Bush'),
          StrToInt(InputBox('Adicionar ','Ingrese una posicion','000')));
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
   //t.setNom('alumnos');    t.setExt('dat');
  if(t.existe(t.getNom(),t.getExt()))then begin
      T.ejerF(StrToInt(InputBox('Eliminar','Registro','202001')));
  end else begin
      ShowMessage('El archivo '+t.getNom()+'.'+t.getExt()+' no existe');
  end;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
     t.setNom('alumnos');    t.setExt('dat');
  if(t.existe(t.getNom(),t.getExt()))then begin
     T.ejerI();
  end else begin
      ShowMessage('El archivo '+t.getNom()+'.'+t.getExt()+' no existe');
  end;

end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
     t.setNom('alumnos');    t.setExt('dat');
  if(t.existe(t.getNom(),t.getExt()))then begin
     T.ejerJ();
  end else begin
      ShowMessage('El archivo '+t.getNom()+'.'+t.getExt()+' no existe');
  end;

end;

procedure TForm1.MenuItem14Click(Sender: TObject);
var c,r:Integer;
    n,d:String;
begin
      c:=StrToInt(InputBox('','CI = ','444'));
      r:=StrToInt(InputBox('','Registro = ','202001'));
      n:=InputBox('','Nombre = ','');
      d:=InputBox('','Direccion = ','');
      T.ejerB(c,r,n,d);
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
     ShowMessage(t.ejerC(StrToInt(InputBox('Buscar','Registro','202001'))));

end;

procedure TForm1.MenuItem16Click(Sender: TObject);
var Ci:Integer;
    dom:String;
begin
  //t.setNom('alumnos');  t.setExt('dat');
 if(t.existe(t.getNom(),t.getExt()))then begin
       ci:=StrToInt(InputBox('Buscar','CI','111'));
       dom:=InputBox('Modificar','Domicilio','calle ichilo');
       t.ejerD(ci,dom);
 end else begin
     ShowMessage('El archivo '+t.getNom()+'.'+t.getExt()+' no existe');
 end;
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
var nombre,extension:String;
begin
  nombre:=InputBox('Cambiar Archivo','Nombre','');
  extension:=InputBox('Cambiar Archivo','Extensión','');
  ShowMessage(BoolToStr(t.existe(nombre,extension),true));
end;

procedure TForm1.MenuItem19Click(Sender: TObject);
var nombre,extension:String;
begin
  nombre:=InputBox('Cambiar Archivo','Nombre','');
  extension:=InputBox('Cambiar Archivo','Extensión','');
  t.setNom('alumnos');    t.setExt('dat');
  t.cambiar_nom(nombre,extension);
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
var c,r,i,cant:Integer;
    n,d,nombre,extension:String;
begin
   cant:=StrToInt(InputBox('cantidad de registros','',''));
   nombre:=InputBox('nombre del archivo','nom = ','nuevo');
   extension:=InputBox('nombre del archivo','ext = ','txt');
   t:=FileTipo.Create();
   t.setNom(nombre);  t.setExt(extension);
   t.Crear();
   for i:=1 to cant do begin
      ShowMessage('#'+IntToStr(i)+'  -----Registrando el registro---- ');
      c:=StrToInt(InputBox('','CI = ','444'));
      r:=StrToInt(InputBox('','Registro = ','202001'));
      n:=InputBox('','Nombre = ','');
      d:=InputBox('','Direccion = ','');
      T.grabar(c,r,n,d,i);
   end;
   t.Cerrar();
end;
//CREAR NOTAS
procedure TForm1.Button5Click(Sender: TObject);
var n :UnitNota.nota;
begin
 NOTA.Crear();
 n.INF110:=70;   n.LIN100:=80; n.MAT101:=50; n.FIS101:=20;  n.INF119:=80;
 nota.EscribirTipo(n);
 n.INF110:=80;   n.LIN100:=50; n.MAT101:=100; n.FIS101:=30;  n.INF119:=90;
 nota.EscribirTipo(n);
 n.INF110:=50;   n.LIN100:=90; n.MAT101:=80; n.FIS101:=90;  n.INF119:=70;
  nota.EscribirTipo(n);
 n.INF110:=90;   n.LIN100:=80; n.MAT101:=80; n.FIS101:=70;  n.INF119:=60;
 nota.EscribirTipo(n);
 NOTA.Cerrar();
end;

procedure TForm1.Button6Click(Sender: TObject);
begin

    ShowMessage(self.T.getNom() + ','+self.T.getExt());
end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin
  t.ejerG(nota);
end;



end.

