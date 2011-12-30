unit Notshalter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TNotshalterForm = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Shape1: TShape;
    Shape2: TShape;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Timer1: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NotshalterForm: TNotshalterForm;

implementation

uses MAIN;

{$R *.dfm}

var TimerTime: Byte;
procedure TNotshalterForm.Label4Click(Sender: TObject);
begin
NotshalterForm.ModalResult:=mrAbort;
end;

procedure TNotshalterForm.Label5Click(Sender: TObject);
begin
 TimerTime:=0;
 //Timer1.Enabled:=true;
 for TimerTime:=0 to 20 do
 begin
  NotshalterForm.AlphaBlendValue:=255-TimerTime*10;
  sleep(10);
 end;
//  NotshalterForm.AlphaBlendValue:=255-TimerTime*20;

// Timer1.Enabled:=false;
 NotshalterForm.ModalResult:=mrRetry;


end;

procedure TNotshalterForm.Timer1Timer(Sender: TObject);
begin
TimerTime:=TimerTime+1;

end;

procedure TNotshalterForm.FormShow(Sender: TObject);
begin
 NotshalterForm.AlphaBlendValue:=255;
 NotshalterForm.AlphaBlend:=true;
end;


procedure TNotshalterForm.Panel1Click(Sender: TObject);
begin
CabineStatus[IndexSol]:=1;
//MainForm.Label59.Caption:='START';
NotshalterForm.ModalResult:=mrOk;
//NotshalterForm.Close;
end;

procedure TNotshalterForm.Panel2Click(Sender: TObject);
begin
  CabineStatus[IndexSol]:=2;
 NotshalterForm.ModalResult:=mrIgnore;

end;

end.
