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
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand1: TQRBand;
    QRDBText7: TQRDBText;
    QRSysData3: TQRSysData;
    QRLabel12: TQRLabel;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRDBText11: TQRDBText;
    QRDBText13: TQRDBText;
    QRLabel16: TQRLabel;
    QRDBText15: TQRDBText;
    QRLabel21: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    Sum_label1: TQRLabel;
    Sum_label2: TQRLabel;
    Sum_label3: TQRLabel;
    Sum_label4: TQRLabel;
    Sum_label5: TQRLabel;
    Sum_label6: TQRLabel;
    QRLabel25: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel1: TQRLabel;
    Sum_label10: TQRLabel;
    Sum_label11: TQRLabel;
    Sum_label12: TQRLabel;
    Sum_label13: TQRLabel;
    Sum_label14: TQRLabel;
    Sum_label15: TQRLabel;
    Sum_label16: TQRLabel;
    Sum_label17: TQRLabel;
    Sum_label18: TQRLabel;
    Sum_label19: TQRLabel;
    Sum_label20: TQRLabel;
    Sum_label21: TQRLabel;
    Sum_label22: TQRLabel;
    Sum_label23: TQRLabel;
    Sum_label24: TQRLabel;
    Sum_label25: TQRLabel;
    Sum_label26: TQRLabel;
    Sum_label27: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    procedure QuickRep3AfterPreview(Sender: TObject);
    procedure QuickRep3StartPage(Sender: TCustomQuickRep);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr1Print(sender: TObject; var Value: string);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  Sum1: Integer;
  Sum2: Integer;
  Sum3: Integer;
  Sum4: Integer;
  Sum5: Integer;
  Sum6: Integer;
  Sum10: Integer;
  Sum11: Integer;
  Sum12: Integer;
  Sum13: Integer;
  Sum14: Integer;
  Sum15: Integer;
  Sum16: Integer;
  Sum17: Integer;
  Sum18: Integer;
  Sum19: Integer;
  Sum20: Integer;
  Sum21: Integer;
  Sum22: Integer;
  Sum23: Integer;
  Sum24: Integer;
  Sum25: Integer;
  Sum26: Integer;
  Sum27: Integer;

implementation
 uses main;
 var
  sum_total: string;
{$R *.dfm}

procedure TForm3.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin

  QRLabel20.Caption :=  MainForm.ProtokolFilterEdit.Text;
  if(MainForm.ProtokolFilterEdit.Text = '') then
  begin
    QRLabel21.Font.Color := clWhite;
  end
  else
  if(MainForm.ProtokolFilterEdit.Text = ' ') then
  begin
    QRLabel21.Font.Color := clBlack;
    QRLabel20.Caption := ' само солариуми';
  end
  else
  begin
    QRLabel21.Font.Color := clBlack;
  end;
  Sum_label1.Caption := IntToStr(Sum1);
  Sum_label2.Caption := IntToStr(Sum2);
  Sum_label3.Caption := IntToStr(Sum3);
  Sum_label4.Caption := IntToStr(Sum4);
  Sum_label5.Caption := IntToStr(Sum5);
  Sum_label6.Caption := IntToStr(Sum6);

  Sum_label10.Caption := IntToStr(Sum10);
  Sum_label11.Caption := IntToStr(Sum11);
  Sum_label12.Caption := IntToStr(Sum12);
  Sum_label13.Caption := IntToStr(Sum13);
  Sum_label14.Caption := IntToStr(Sum14);
  Sum_label15.Caption := IntToStr(Sum15);
  Sum_label16.Caption := IntToStr(Sum16);
  Sum_label17.Caption := IntToStr(Sum17);
  Sum_label18.Caption := IntToStr(Sum18);
  Sum_label19.Caption := IntToStr(Sum19);
  Sum_label20.Caption := IntToStr(Sum20);
  Sum_label21.Caption := IntToStr(Sum21);
  Sum_label22.Caption := IntToStr(Sum22);
  Sum_label23.Caption := IntToStr(Sum23);
  Sum_label24.Caption := IntToStr(Sum24);
  Sum_label25.Caption := IntToStr(Sum25);
  Sum_label26.Caption := IntToStr(Sum26);
  Sum_label27.Caption := IntToStr(Sum27);

end;

procedure TForm3.QRExpr1Print(sender: TObject; var Value: string);
begin
  sum_total := Value;
end;

procedure TForm3.QuickRep3AfterPreview(Sender: TObject);
  var body: TStringList;
begin
//  QuickRep3.ExportToFilter(TQRXLSFilter.Create(OtchetFileName));
 OtchetFileName:='Otchet '+QRLabel16.Caption+'.html' ;
 MainForm.wwDBGrid2.ExportOptions.FileName := OtchetFileName;
 MainForm.wwDBGrid2.ExportOptions.TitleName := 'Дневен отчет за ' +
 QRLabel16.Caption + ' (Оборот: ' + sum_total + ' лв.)';
 MainForm.wwDBGrid2.ExportOptions.Save();
 if MainForm.Internet.FieldValues['dialog'] then
 begin
  body := TStringList.Create();
  MainForm.LMDMapiSendMail1.Reset;
  MainForm.LMDMapiSendMail1.LogOn;
  MainForm.LMDMapiSendMail1.ToRecipient.Clear;
  MainForm.LMDMapiSendMail1.ToRecipient.Append(MainForm.Internet.FieldValues['to']);
  MainForm.LMDMapiSendMail1.Subject:= 'Otchet za '+QRLabel16.Caption;
  body.Add('Day total: '+ sum_total + ' leva');
  body.Add('**************************************');
  MainForm.LMDMapiSendMail1.MessageBody := body;
  MainForm.LMDMapiSendMail1.Attachment.Clear;
  MainForm.LMDMapiSendMail1.Attachment.Append(OtchetFileName);
  MainForm.LMDMapiSendMail1.SendMail;
  MainForm.LMDMapiSendMail1.LogOff;
  MainForm.LMDMapiSendMail1.Reset;
  body.Destroy();
 end;
end;

procedure TForm3.QuickRep3StartPage(Sender: TCustomQuickRep);
begin
QRLabel16.Caption:= MainForm.DBLUCombo1.EditText;
QRLabel16.Caption:= AnsiReplaceStr(QRLabel16.Caption,'/','-');
end;

procedure TForm3.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if((QRDBText11.DataSet.FieldByName(QRDBText11.Caption).AsString = '')) then
  begin
    if(QRDBText1.DataSet.FieldByName(QRDBText1.Caption).AsString  = '1') then
      Sum1 :=   Sum1 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText1.DataSet.FieldByName(QRDBText1.Caption).AsString  = '2') then
      Sum2 :=   Sum2 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText1.DataSet.FieldByName(QRDBText1.Caption).AsString  = '3') then
      Sum3 :=   Sum3 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText1.DataSet.FieldByName(QRDBText1.Caption).AsString  = '4') then
      Sum4 :=   Sum4 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText1.DataSet.FieldByName(QRDBText1.Caption).AsString  = '5') then
      Sum5 :=   Sum5 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText1.DataSet.FieldByName(QRDBText1.Caption).AsString  = '6') then
      Sum6 :=   Sum6 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
  end
  else
  begin
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-1') then
      Sum10 :=   Sum10 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-2') then
      Sum11 :=   Sum11 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-3') then
      Sum12 :=   Sum12 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-4') then
      Sum13 :=   Sum13 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-5') then
      Sum14 :=   Sum14 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-6') then
      Sum15 :=   Sum15 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-7') then
      Sum16 :=   Sum16 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-8') then
      Sum17 :=   Sum17 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-9') then
      Sum18 :=   Sum18 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-10') then
      Sum19 :=   Sum19 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-11') then
      Sum20 :=   Sum20 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-12') then
      Sum21 :=   Sum21 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-13') then
      Sum22 :=   Sum22 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-14') then
      Sum23 :=   Sum23 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-15') then
      Sum24 :=   Sum24 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-16') then
      Sum25 :=   Sum25 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-17') then
      Sum26 :=   Sum26 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
    if(QRDBText7.DataSet.FieldByName(QRDBText7.Caption).AsString  = '-18') then
      Sum27 :=   Sum27 + StrToInt(QRDBText2.DataSet.FieldByName(QRDBText2.Caption).AsString);
  end;
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

procedure TForm3.FormCreate(Sender: TObject);
begin
  Sum1:=0;
  Sum2:=0;
  Sum3:=0;
  Sum4:=0;
  Sum5:=0;
  Sum6:=0;
  Sum10:=0;
  Sum11:=0;
  Sum12:=0;
  Sum13:=0;
  Sum14:=0;
  Sum15:=0;
  Sum16:=0;
  Sum17:=0;
  Sum18:=0;
  Sum19:=0;
  Sum20:=0;
  Sum21:=0;
end;

end.
