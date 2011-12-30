unit Refill;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrls, AdvCombo, Lucombo, dblucomb,
  MaskEdEx, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDDBMaskEdit;

type
  TRefillForm = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    Shape1: TShape;
    Shape2: TShape;
    Panel1: TPanel;
    Panel2: TPanel;
    Timer1: TTimer;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    Label5: TLabel;
    DBText2: TDBText;
    Label6: TLabel;
    Label7: TLabel;
    Edit1: TMaskEditEx;
    DBText1: TDBText;
    DBLUCombo2: TDBLUCombo;
    Label3: TLabel;
    Label4: TLabel;
    LMDDBLabeledMaskEdit1: TLMDDBLabeledMaskEdit;
    MaskEdit2: TMaskEditEx;
    procedure Panel2Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefillForm: TRefillForm;
  IsChipCard: Boolean;

implementation
uses main;
{$R *.dfm}
var
  NomerKlient: Integer;
  maxnomer: integer;
  nomer: integer;
procedure TRefillForm.Panel2Click(Sender: TObject);
begin
 MainForm.Qklienti.Cancel;
 RefillForm.ModalResult:=mrCancel;
  RefillForm.Close;
end;

procedure TRefillForm.Panel1Click(Sender: TObject);
var
  Stoka: integer;
  Cena: Real;
  Suma: Real;
  Broi: Integer;
  Cena1: Real;
  KartaNomer: Integer;
  Valid: Boolean;
  Nomer: Integer;
  V: Variant;
begin
 Valid:= true;
 Stoka:=MainForm.KARTI.FieldValues['STOKAKOD'];
 Cena:=MainForm.KARTI.FieldValues['STOKACENA'];
 Suma:=MainForm.KARTI.FieldValues['SUMA'];
 Nomer:=StrToIntDef(MaskEdit2.EditText,-1);
 V:= MainForm.Qklienti.Lookup('NOMER',Nomer,'Nomer') ;
 if not (VarType(V) in [varNull]) then Nomer:=0;   // So, there is a record with that number
 MainForm.Qklienti.Edit;
  MainForm.Qklienti.FieldValues['BALANS']:=  MainForm.Qklienti.FieldValues['BALANS']+MainForm.KARTI.FieldValues['STOKACENA'];
  if Nomer>0 then MainForm.Qklienti.FieldValues['NOMER']:=Nomer;
 MainForm.Qklienti.post;
 if not IsChipCard then
  begin
   MainForm.KARTIALL1.Append;
   MainForm.KARTIALL1.FieldValues['STARTDATE']:=Date;
   MainForm.KARTIALL1.FieldValues['KARTANOMER']:=StrToInt(Edit1.Text);
   MainForm.KARTIALL1.FieldValues['POSESHTENIA']:=MainForm.KARTI.FieldValues['POSESHTENIA'];
   MainForm.KARTIALL1.FieldValues['KLIENTDETAIL']:=MainForm.QKlienti.FieldValues['NOMER'];
// MainForm.KARTIALL1.FieldValues['MINUTINA1']:=MainForm.KARTI.FieldValues['MINUTINA1'];
   MainForm.KARTIALL1.Post;
   KartaNomer:=   MainForm.KARTIALL1.FieldValues['KARTANOMER'];
  end;
 if IsChipCard then
  begin
   KartaNomer:=MainForm.QKlienti.FieldValues['NOMER'];
 //  MainForm.CHIPKARTI.FieldValues['BALANS']:= MainForm.CHIPKARTI.FieldValues['BALANS']+ MainForm.KARTI.FieldValues['SUMA'];
  if Card.Balans>Suma then
    begin
      Valid:=False;
      Application.MessageBox(PChar('Картата няма да бъде заредена! Вече е била заредена!'),PChar('Warning'),MB_OK);
        MainForm.Qklienti.Cancel;
        RefillForm.ModalResult:=mrCancel;
        RefillForm.Close;
    end
  else
   begin
   if Card.CardNomer<0 then // New card - must pay a deposit
    begin
     Card.ClientNomer:=   MainForm.QKlienti.FieldValues['NOMER'];
     Card.CardNomer:=Card.ClientNomer;
     Card.ClientName:=  MainForm.Qklienti.FieldValues['IME'] ;
     MainForm.Plashtania.Append;
     MainForm.plashtania.FieldValues['BROI']:=1;
     MainForm.plashtania.FieldValues['DATA']:=Date;
     MainForm.plashtania.FieldValues['CHAS']:=TimeToStr(Time);
     MainForm.plashtania.FieldValues['OTCHIPKARTA']:=Card.ClientNomer;
     if MainForm.STOKI.Locate('POSESHTENIA',-1,[]) then
      begin
       MainForm.STOKI.Edit;
       MainForm.STOKI.FieldValues['STOKANASKLAD']:= MainForm.STOKI.FieldValues['STOKANASKLAD'] -1;
       MainForm.STOKI.post;
       MainForm.plashtania.FieldValues['STOKA']:=MainForm.STOKI.FieldValues['STOKAKOD'];
       MainForm.plashtania.FieldValues['SUMABROI']:=MainForm.STOKI.FieldValues['STOKACENA'];
      end
      else;
     MainForm.Plashtania.Post;
     Card.Balans:=0;
    end;
   Card.Balans:=Card.Balans + MainForm.KARTI.FieldValues['SUMA'];
   end;
 end;
 if Valid then
  Begin
   MainForm.Qklienti.Edit;
   if   not (MainForm.Qklienti.FieldValues['BALANS']>0) then  MainForm.Qklienti.FieldValues['BALANS']:=0;
   MainForm.Qklienti.FieldValues['BALANS']:= MainForm.Qklienti.FieldValues['BALANS']+Cena;
   MainForm.Plashtania.Append;
   MainForm.plashtania.FieldValues['STOKA']:=Stoka;
   MainForm.plashtania.FieldValues['SUMABROI']:=Cena;
   MainForm.plashtania.FieldValues['BROI']:=1;
   MainForm.plashtania.FieldValues['DATA']:=Date;
   MainForm.plashtania.FieldValues['CHAS']:=TimeToStr(Time);
   if  MainForm.AdvPageControl1.ActivePageIndex=18 then
      MainForm.plashtania.FieldValues['OTCHIPKARTA']:=Card.ClientNomer;
   if MainForm.AdvPageControl1.ActivePageIndex=17 then
    MainForm.plashtania.FieldValues['OTKARTA']:=KartaNomer;
   MainForm.Plashtania.Post;
   MainForm.Qklienti.Post;
   RefillForm.ModalResult:=mrOK;
  end;
 //RefillForm.Close;
end;

procedure TRefillForm.FormShow(Sender: TObject);
begin
IsChipCard:= (MainForm.AdvPageControl1.ActivePageIndex<>17);
if not IsChipCard then
 begin
  Label4.Caption:='посещения';
  MainForm.KARTIALL1.Refresh;
  MainForm.KARTIALL.Refresh;
  nomer:=0;
  maxnomer:=0;
  MainForm.MinMax.Active:=False;
  MainForm.MinMax.SQL.SetText(PChar('SELECT * FROM kartiall ORDER BY KARTANOMER DESC'));
  MainForm.MinMax.Active:=True;
  MainForm.MinMax.First;
  nomer:=MainForm.MinMax.FieldByName('KARTANOMER').AsInteger;
  nomer:=nomer+1;
  Edit1.Text:=IntToStr(nomer);
  MaskEdit2.Text:=IntToStr(MainForm.Qklienti.FieldValues['nomer']);
 end;
if IsChipCard then
 begin
   Label4.Caption:='минути';
   nomer:=0;
  maxnomer:=0;
  if card.StudioNomer>0 then
   begin
    if card.StudioNomer= MainForm.Internet.FieldValues['StudioNomer'] then
     begin
      MainForm.QKlienti.Active:=False;
      MainForm.QKlienti.SQL.SetText(PChar('SELECT * FROM klienti ORDER BY IME'));
      MainForm.QKlienti.Active:=True;
      if MainForm.Qklienti.Locate('NOMER',Card.ClientNomer,[]) then
       begin
        MainForm.QKlienti.Edit;

       end
      else
       Begin
        MainForm.QKlienti.Append;
        MainForm.QKlienti.FieldValues['IME']:=Card.ClientName;
        MainForm.QKlienti.Post;
        MainForm.QKlienti.Edit;
       end;
     end;
     Edit1.Text:=IntToStr(Card.CardNomer);
     MaskEdit2.Text:=IntToStr(MainForm.Qklienti.FieldValues['nomer']);
   end
  else
   begin
    //MainForm.CHIPKARTI.Append;
    //MainForm.CHIPKARTI.FieldValues['STARTDATE']:=Date;
    //MainForm.CHIPKARTI.FieldValues['KLIENTNOMER']:= MainForm.QKlienti.FieldValues['NOMER'];
   // MainForm.CHIPKARTI.Post;
    //Card.CardNomer:= MainForm.CHIPKARTI.FieldValues['KARTANOMER'];
    Edit1.Text:='Нова';
   end;
 end;
end;



end.
