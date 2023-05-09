unit FRMT2VECAPP;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls, Menus, uvector, Natural;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    SG: TStringGrid;
    SG1: TStringGrid;
    SG2: TStringGrid;
    SG3: TStringGrid;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem34Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem36Click(Sender: TObject);
    procedure MenuItem37Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem40Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem42Click(Sender: TObject);
    procedure MenuItem43Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem45Click(Sender: TObject);
    procedure MenuItem46Click(Sender: TObject);
    procedure MenuItem47Click(Sender: TObject);
    procedure MenuItem48Click(Sender: TObject);
    procedure MenuItem49Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem50Click(Sender: TObject);
    procedure MenuItem51Click(Sender: TObject);
    procedure MenuItem54Click(Sender: TObject);
    procedure MenuItem55Click(Sender: TObject);
    procedure MenuItem56Click(Sender: TObject);
    procedure MenuItem57Click(Sender: TObject);
    procedure MenuItem58Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
   v,v2,v3,v4,v5:vector;
  public
     function prueba(i: integer):integer;
     procedure descargar(o : vector; vec :TStringGrid );
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
// v.CorteControlN1();
  ShowMessage(IntToStr(prueba(1)));
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  v:=vector.crear();
  v2:=vector.crear();
  v3:=vector.crear();
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
 v.descargar(SG1);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
  v2.descargar(SG2);
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
  v3.descargar(SG3);
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  v.invertir();    v.descargar(sg1);
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
var pos,ele:integer;
begin
ele:=StrToInt(InputBox('ingrese un numero a buscar','Elemento',''));
pos:=v.busq_sec(ele);
if(pos>0)then
ShowMessage('El numero ' +IntToStr(ele)+' se encuentra en la posicion '+inttostr(pos))
else
ShowMessage('No se encontro el numero');
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
var pos,ele:integer;
begin
ele:=StrToInt(InputBox('ingrese un numero','Elemento',''));
pos:=v.busq_bi(ele);//observar
if(pos>0)then
ShowMessage('El numero ' +IntToStr(ele)+' se encuentra en la posicion '+inttostr(pos))
else
ShowMessage('No se encontro el numero');
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
  v.ord_intercambio();
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
v.ord_seleccion();
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
v.ord_burbuja();
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
  v.ord_CantDiv();
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
begin
  v.SegPri_Nopri();
end;

procedure TForm1.MenuItem19Click(Sender: TObject);
var cant,ele:integer;
begin
ele:=StrToInt(InputBox('ingrese un numero','Elemento',''));
cant:=v.frec(ele);
if(cant>0)then
ShowMessage('El numero ' +IntToStr(ele)+' se repite '+inttostr(cant)+' veces')
else
ShowMessage('No se encontro el numero');
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin
  v.Seg_frecuencia();
end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin
  v.ElimAllRep2();
end;

procedure TForm1.MenuItem22Click(Sender: TObject);
begin
  v.ElimPri();
end;

procedure TForm1.MenuItem23Click(Sender: TObject);
begin
  v.ElimAll(StrToInt(InputBox('Ingrese numero que eliminara','elemento','')));
end;

procedure TForm1.MenuItem24Click(Sender: TObject);
begin
 v.ElimRep();
end;

procedure TForm1.MenuItem27Click(Sender: TObject);
begin
v2.CargarRnd();
v2.descargar(SG2);
end;

procedure TForm1.MenuItem28Click(Sender: TObject);
begin
v3.CargarRnd();
v3.descargar(SG3);
end;

procedure TForm1.MenuItem29Click(Sender: TObject);
begin
v2:=vector.crear();
v2.descargar(SG2);
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
v:=vector.crear();
v.descargar(SG);
end;

procedure TForm1.MenuItem30Click(Sender: TObject);
begin
v3:=vector.crear();
v3.descargar(SG3);
end;

procedure TForm1.MenuItem31Click(Sender: TObject);
begin
v2.addElem(StrToInt(InputBox('Ingrese un numero entero','V [ '+inttostr(v2.getDim()+1)+' ]','')));
v2.descargar(SG2);
end;

procedure TForm1.MenuItem32Click(Sender: TObject);
begin
v3.addElem(StrToInt(InputBox('Ingrese un numero entero','V [ '+inttostr(v3.getDim()+1)+' ]','')));
v3.descargar(SG3);
end;

procedure TForm1.MenuItem33Click(Sender: TObject);
begin
//v.Inter_ordenar(v2,v3);
  v.Mezcla_A_ordenar(v2,v3);
end;

procedure TForm1.MenuItem34Click(Sender: TObject);
begin
ShowMessage(IntToStr(v.Men(1,10)));
end;

procedure TForm1.MenuItem35Click(Sender: TObject);
begin
v.DivRepNoRep(v2,v3);
end;

procedure TForm1.MenuItem36Click(Sender: TObject);
begin
  V.ord_inserc();
end;

procedure TForm1.MenuItem37Click(Sender: TObject);
var a:integer;
begin
//a:=StrToInt(InputBox('A','',''));
//b:=StrToInt(InputBox('B','',''));
//dim=15  (1,dim div 3 )(dim div 3,)
          //[1,2,3,       4,5,6,   7,8,9]
a:=v.getDim() div 3;//a=5
v.ord_seleccion(1  ,  a); //(1,3)
v.ord_burbuja(a+1,2*a); //(4,6)
v.ord_intercambio(2*a+1,V.getDim());//(7,9)
end;

procedure TForm1.MenuItem38Click(Sender: TObject);
begin
 v.ElimOne(StrToInt(InputBox('numero que eliminara','','')));
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
v.addElem(StrToInt(InputBox('Ingrese un numero entero','V [ '+inttostr(v.getDim()+1)+' ]','')));
v.descargar(SG);
end;

procedure TForm1.MenuItem40Click(Sender: TObject);
begin
  v2:=vector.crear();
  v3:=vector.crear();
  v.Dispersion1(v2,v3);
end;

procedure TForm1.MenuItem41Click(Sender: TObject);
begin
  v2:=vector.crear();
  V.ejercicio7(V2);
end;

procedure TForm1.MenuItem42Click(Sender: TObject);
begin
 v.ord_insercion();
end;

procedure TForm1.MenuItem43Click(Sender: TObject);
begin
  v.cargar();     v.descargar(SG);
end;

procedure TForm1.MenuItem44Click(Sender: TObject);
var posicion:integer;
begin
  posicion:=StrToInt(InputBox('Posicion a obtener','',''));
  ShowMessage(IntToStr(v.getElem(posicion)));
end;

procedure TForm1.MenuItem45Click(Sender: TObject);
begin
 ShowMessage(IntToStr(v.elementoModa()));
end;

procedure TForm1.MenuItem46Click(Sender: TObject);
begin
 v.Seg_frecuencia();
end;

procedure TForm1.MenuItem47Click(Sender: TObject);
begin
  v.descargar(SG);
end;

procedure TForm1.MenuItem48Click(Sender: TObject);
var veces:Integer;
begin
     veces:=StrToInt(InputBox('cantidad de veces a rotar','',''));
  v.rotar(veces);
end;

procedure TForm1.MenuItem49Click(Sender: TObject);
begin
  v2.cargar();     v2.descargar(sg2);
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
v.CargarRnd();   v.descargar(sg);
end;

procedure TForm1.MenuItem50Click(Sender: TObject);
begin
  v3.cargar();     v3.descargar(sg3);
end;

procedure TForm1.MenuItem51Click(Sender: TObject);
begin
  v.Mezcla_A_ordenar1(V2, V3, V4, V5);
end;

procedure TForm1.MenuItem54Click(Sender: TObject);
begin
   v4:=vector.crear();
   v4.cargar();
end;

procedure TForm1.MenuItem55Click(Sender: TObject);
begin
  v4.descargar(SG);
end;

procedure TForm1.MenuItem56Click(Sender: TObject);
begin
  v5:=vector.crear();
  v5.cargar();
end;

procedure TForm1.MenuItem57Click(Sender: TObject);
begin
   v5.descargar(SG);
end;

procedure TForm1.MenuItem58Click(Sender: TObject);
begin
  v.intercalar3Vectores(v2,v3,v4);
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  v.setDim(StrToInt(InputBox('cantidad de elementos','dim','')));
  v.descargar(SG);
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  ShowMessage('Cantidad de elementos :'+IntToStr(v.getDim()));
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
var pos,ele:integer;
begin
  pos:=StrToInt(InputBox('ingrese posicion','',''));
  ele:=StrToInt(InputBox('Ingrese elemento a insertar','',''));
  v.insElem(pos,ele);
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  v.RemElem(StrToInt(InputBox('Eliminar','posicion','')));
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
var pos1,pos2:integer;
begin
  pos1:=StrToInt(InputBox('posicion 1','',''));
  pos2:=StrToInt(InputBox('posicion 2','',''));
  v.InteElem(pos1,pos2);
end;

function TForm1.prueba(i: integer): integer;
begin
  while(i<=10)do begin
    result:=20;
    i:=i+1;
  end;
  result:=10;
end;

procedure TForm1.descargar(o: vector; vec: TStringGrid);
var i:integer;
begin
   vec.ColCount:= o.getDim();
   for i:=1 to o.getDim() do
     begin
      //[columna, fila]
       vec.Cells[i-1,0]:= IntToStr(o.getElem(i));
     end;
end;


end.

