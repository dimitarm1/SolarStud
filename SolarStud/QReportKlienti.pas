unit QReportKlienti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, grimgctrl, QuickRpt, QRCtrls, ExtCtrls, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit, LMDCustomMemo, LMDMemo;

type
  TForm1 = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRSubDetail1: TQRSubDetail;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses MAIN;

{$R *.dfm}

procedure TForm1.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  var i,kod_depozit: integer;
begin
QRLabel11.caption:='';
with MainForm do

  begin
  QKarti.Active:=False;
    QKarti.SQL.SetText(PChar('SELECT * FROM kartiall WHERE klientdetail = '+
     IntToStr(QKlienti.FieldValues['NOMER'])+ ' ORDER BY KARTANOMER'));
    QKarti.Active:=True;
    QKarti.First;
  end;
  if MainForm.QKlienti.FieldValues['NOMER']>=0 then
   begin
     MainForm.QkartiPaid.Active:=False;
    MainForm.QkartiPaid.sql.SetText(PChar('SELECT * FROM Plashtania WHERE OTCHIPKARTA = '+
     IntToStr(MainForm.QKlienti.FieldValues['NOMER'])+ ' ORDER BY RECORDID'));
    MainForm.QkartiPaid.Active:=True;
    MainForm.QkartiPaid.First;
    i:=0;
  if MainForm.STOKI.Locate('POSESHTENIA',-1,[]) then   kod_depozit:=MainForm.STOKI.FieldValues['STOKAKOD']
    else    kod_depozit:= -10000;
  while i < MainForm.QKartiPaid.RecordCount do
  begin
  if  MainForm.QKartiPaid.FieldValues['KARTASUMA']>0 then
     QRLabel11.Caption:= QRLabel11.Caption + '  '+ DateToStr(MainForm.QKartiPaid.FieldValues['DATA'])+
    ' - '+ ConvertCurr1(MainForm.QKartiPaid.FieldValues['KARTASUMA'])+'лв. '
   else
    begin
     if   MainForm.QKartiPaid.FieldValues['STOKA']=   kod_depozit then
          QRLabel11.Caption:= QRLabel11.Caption + '  '+ DateToStr(MainForm.QKartiPaid.FieldValues['DATA'])+
        ' - *+'+ ConvertCurr1(MainForm.QKartiPaid.FieldValues['SUMABROI'])+'лв.* '
      else
        QRLabel11.Caption:= QRLabel11.Caption + '  '+ DateToStr(MainForm.QKartiPaid.FieldValues['DATA'])+
        ' - <+'+ ConvertCurr1(MainForm.QKartiPaid.FieldValues['SUMABROI'])+'лв.> '
    end;
   i:=i+1;
   MainForm.QKartiPaid.Next;
  end;

  end;
end;

procedure TForm1.QRSubDetail1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
//MoreData:=not MainForm.QKarti.Eof;
//  QRLabel10.Caption:=IntToStr(MainForm.Qklienti.FieldValues['KARTANOMER']);
 // MainForm.QKarti.Next;
end;

procedure TForm1.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
//MainForm.Qklienti.Next;
end;

procedure TForm1.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  var i: Integer;
begin
  QRLabel10.Caption:='';
 if MainForm.QKarti.RecordCount>0 then
 begin

  MainForm.QkartiPaid.Active:=False;
    MainForm.QkartiPaid.sql.SetText(PChar('SELECT * FROM Plashtania WHERE OTKARTA = '+
     IntToStr(MainForm.QKarti.FieldValues['KARTANOMER'])+ ' ORDER BY RECORDID'));
    MainForm.QkartiPaid.Active:=True;
    MainForm.QkartiPaid.First;
    i:=0;
  while i < MainForm.QKartiPaid.RecordCount do
  begin
   QRLabel10.Caption:= QRLabel10.Caption + '  '+ DateToStr(MainForm.QKartiPaid.FieldValues['DATA'])+
   ' - '+IntToStr(MainForm.QKartiPaid.FieldValues['POSESHTENIA']);
   i:=i+1;
   MainForm.QKartiPaid.Next;
  end;
  end;

  if   QRLabel10.Caption=''then QRLabel10.Caption:='няма';
end;

end.
