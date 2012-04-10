unit QReportDneven;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, QRPrntr, QR4Const, QRExport, ExtCtrls, StrUtils,
  Wwdbgrid;

type
  TForm3 = class(TForm)
    QuickRep3: TQuickRep;
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText6: TQRDBText;
    QRBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel9: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel11: TQRLabel;
    QRSysData3: TQRSysData;
    QRLabel12: TQRLabel;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRDBText10: TQRDBText;
    QRLabel18: TQRLabel;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRLabel19: TQRLabel;
    procedure QuickRep3AfterPreview(Sender: TObject);
    procedure QuickRep3StartPage(Sender: TCustomQuickRep);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
 uses main;
{$R *.dfm}

procedure TForm3.QuickRep3AfterPreview(Sender: TObject);

begin
//  QuickRep3.ExportToFilter(TQRXLSFilter.Create(OtchetFileName));
 MainForm.wwDBGrid2.ExportOptions.FileName := OtchetFileName;
 MainForm.wwDBGrid2.ExportOptions.TitleName := 'Отчет за ' + QRLabel16.Caption;
 MainForm.wwDBGrid2.ExportOptions.Save();
 if MainForm.Internet.FieldValues['dialog'] then
 begin
  MainForm.LMDMapiSendMail1.Reset;
  MainForm.LMDMapiSendMail1.LogOn;
  MainForm.LMDMapiSendMail1.ToRecipient.Clear;
  MainForm.LMDMapiSendMail1.ToRecipient.Append(MainForm.Internet.FieldValues['to']);
  MainForm.LMDMapiSendMail1.Subject:= 'Otchet za '+QRLabel16.Caption;
  MainForm.LMDMapiSendMail1.Attachment.Clear;
  MainForm.LMDMapiSendMail1.Attachment.Append(OtchetFileName);
  MainForm.LMDMapiSendMail1.SendMail;
 end;
end;

procedure TForm3.QuickRep3StartPage(Sender: TCustomQuickRep);
begin
QRLabel16.Caption:= MainForm.DBLUCombo1.EditText;
QRLabel16.Caption:= AnsiReplaceStr(QRLabel16.Caption,'/','-');
OtchetFileName:='Otchet '+QRLabel16.Caption+'.html'
end;

procedure TForm3.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
if MainForm.DayTotal.FieldValues['SOLARIUM']>0 then
 begin
  QRDBText9.Enabled:=false;
  QRDBText7.Enabled:=False;
  QRDBText9.Width:=0;
  QRDBText7.Width:=0;
  QRDBText1.Enabled:=True;
  QRDBText8.Enabled:=true;
  QRDBText1.Width:=41;
  QRDBText8.Width:=145;
 end
 else
  begin
  QRDBText1.Enabled:=false;
  QRDBText8.Enabled:=False;
  QRDBText1.Width:=0;
  QRDBText8.Width:=0;
  QRDBText9.Enabled:=True;
  QRDBText7.Enabled:=True;
  QRDBText9.Width:=145;
  QRDBText7.Width:=41;
  end;
end;

end.
