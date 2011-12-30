unit Scan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Gauges;

type
  TScanForm = class(TForm)
    Image1: TImage;
    Gauge2: TGauge;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScanForm: TScanForm;

implementation


var
 Gauge2Meter: Short;


{$R *.dfm}

procedure TScanForm.FormShow(Sender: TObject);
begin
Gauge2Meter:=0;
 Timer1.Enabled:=True;
end;

procedure TScanForm.Timer1Timer(Sender: TObject);
begin
 Gauge2Meter:=Gauge2Meter+1;
 Gauge2.Progress:=(Gauge2Meter*10);
 if Gauge2Meter>9 then
  begin
   ScanForm.Close;
   Timer1.Enabled:=False;
  end; 
end;

procedure TScanForm.FormCreate(Sender: TObject);
begin
   Gauge2Meter:=0;
end;

end.
