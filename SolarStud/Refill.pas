unit Refill;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrls, AdvCombo, Lucombo, dblucomb,
    MaskEdEx, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
    LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDDBMaskEdit, LMDControl,
    LMDBaseControl, LMDBaseGraphicControl, LMDGraphicControl, LMDBaseImage,
    LMDCustomLImage, LMDLImage;

type
    TRefillForm = class(TForm)
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
        Edit1: TMaskEditEx;
        DBText1: TDBText;
        DBLUCombo2: TDBLUCombo;
        Label3: TLabel;
        Label4: TLabel;
        MaskEdit2: TMaskEditEx;
        LMDLImage91: TLMDLImage;
    DBEdit2: TDBEdit;
    Label6: TLabel;
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
uses main, DataMod, KlubniKartiFrame;
{$R *.dfm}
var
    NomerKlient: Integer;
    maxnomer: integer;
    nomer: integer;

procedure TRefillForm.Panel2Click(Sender: TObject);
begin
    DM.Qklienti.Cancel;
    RefillForm.ModalResult := mrCancel;
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
    Valid := true;
    if DM.KARTI.RecordCount = 0 then
    begin
        DM.Qklienti.Cancel;
        RefillForm.ModalResult := mrCancel;
        RefillForm.Close;
        exit; //-->
    end;
    Stoka := DM.KARTI.FieldValues['STOKAKOD'];
    Cena := DM.KARTI.FieldValues['STOKACENA'];
    Suma := DM.KARTI.FieldValues['SUMA'];
    Nomer := StrToIntDef(MaskEdit2.EditText, -1);
    if (16777214 < Nomer) and IsReader then
    begin
        Application.MessageBox(PChar('Прекалено голям номер на карта!!'),
            PChar('Warning'), MB_OK);
        exit; //-->
    end;
    V := DM.Qklienti.Lookup('NOMER', Nomer, 'Nomer');
    if not (VarType(V) in [varNull]) then
        Nomer := 0; // So, there is a record with that number
    DM.Qklienti.Edit;
    DM.Qklienti.FieldValues['BALANS'] :=
        DM.Qklienti.FieldValues['BALANS'] +
        DM.KARTI.FieldValues['STOKACENA'];
    // Clear new card flag

    if Nomer > 0 then
        DM.Qklienti.FieldValues['NOMER'] := Nomer;
    DM.Qklienti.post;
    MainForm.Sol1.FlushBuffers;

    if not IsChipCard then
    begin
        if DM.KARTIALL1.Locate('KARTANOMER',
            VarArrayOf([StrToInt(Edit1.Text)]), []) then
        begin
            Application.MessageBox(PChar('Дублиран номер на карта!!'),
                PChar('Warning'), MB_OK);
            exit;
        end;
        DM.KARTIALL1.Append;
        DM.KARTIALL1.FieldValues['STARTDATE'] := Date + 365;
        DM.KARTIALL1.FieldValues['KARTANOMER'] := StrToInt(Edit1.Text);
        DM.KARTIALL1.FieldValues['POSESHTENIA'] :=
            DM.KARTI.FieldValues['POSESHTENIA'];
        DM.KARTIALL1.FieldValues['KLIENTDETAIL'] :=
            MainForm.QKlienti.FieldValues['NOMER'];

        // DM.KARTIALL1.FieldValues['MINUTINA1']:=DM.KARTI.FieldValues['MINUTINA1'];
        DM.KARTIALL1.Post;
        KartaNomer := DM.KARTIALL1.FieldValues['KARTANOMER'];
    end;
    if IsChipCard then
    begin
        KartaNomer := MainForm.QKlienti.FieldValues['NOMER'];
        //  DM.CHIPKARTI.FieldValues['BALANS']:= DM.CHIPKARTI.FieldValues['BALANS']+ DM.KARTI.FieldValues['SUMA'];
        if Card.Balans >= Suma then
        begin

            if (mrCancel =
                Application.MessageBox(PChar('Внимание! Картата вече е заредена! Да продължа ли?'), PChar('Warning'), MB_OKCANCEL)) then
            begin
                DM.Qklienti.Cancel;
                Valid := False;
                RefillForm.ModalResult := mrCancel;
                RefillForm.Close;
                exit; //-->
            end;
        end;
        if True then // DEBUG
        begin
            if Card.NewCard then // New card - must pay a deposit
            begin
                Card.ClientNomer := MainForm.QKlienti.FieldValues['NOMER'];
                Card.CardNomer := Card.ClientNomer;
                Card.ClientName := DM.Qklienti.FieldValues['IME'];
                DM.Plashtania.Append;
                MainForm.plashtania.FieldValues['BROI'] := 1;
                MainForm.plashtania.FieldValues['DATA'] := Date;
                MainForm.plashtania.FieldValues['CHAS'] := TimeToStr(Time);
                MainForm.plashtania.FieldValues['OTCHIPKARTA'] :=
                    Card.ClientNomer;

                if DM.STOKI.Locate('STOKATIP', 'D', []) then
                    // Sell deposit
                begin
                    DM.STOKI.Edit;
                    DM.STOKI.FieldValues['STOKANASKLAD'] :=
                        DM.STOKI.FieldValues['STOKANASKLAD'] - 1;
                    DM.STOKI.post;
                    MainForm.plashtania.FieldValues['STOKA'] :=
                        DM.STOKI.FieldValues['STOKAKOD'];
                    MainForm.plashtania.FieldValues['SUMABROI'] :=
                        DM.STOKI.FieldValues['STOKACENA'];
                end
                else
                    ;
                DM.Plashtania.Post;
                Card.Balans := 0;
            end;
//            Card.Balans := Card.Balans + DM.KARTI.FieldValues['SUMA'];
            Card.Balans := Card.Balans + Suma; // Add new card refill sum
            if (DM.KARTICHIP.FieldValues['COUNTER'] = -1) then
            begin
                DM.KARTICHIP.Edit();
                DM.KARTICHIP.FieldValues['COUNTER'] := 0;
                DM.KARTICHIP.Post();
            end;
        end;
    end;
    if Valid then
    begin
        DM.Qklienti.Edit;
        if not (DM.Qklienti.FieldValues['BALANS'] > 0) then
            DM.Qklienti.FieldValues['BALANS'] := 0;
//        DM.Qklienti.FieldValues['BALANS'] :=
//            DM.Qklienti.FieldValues['BALANS'] + Cena;
        DM.Plashtania.Append;
        MainForm.plashtania.FieldValues['STOKA'] := Stoka;
        MainForm.plashtania.FieldValues['SUMABROI'] := Cena;
        MainForm.plashtania.FieldValues['BROI'] := 1;
        MainForm.plashtania.FieldValues['DATA'] := Date;
        MainForm.plashtania.FieldValues['CHAS'] := TimeToStr(Time);

        if MainForm.ActivePageIndex = 18 then
            MainForm.plashtania.FieldValues['OTCHIPKARTA'] := Card.ClientNomer;
        if MainForm.ActivePageIndex = 17 then
            MainForm.plashtania.FieldValues['OTKARTA'] := KartaNomer;
        DM.Plashtania.Post;
        DM.Qklienti.Post;
        MainForm.Sol1.FlushBuffers;
        RefillForm.ModalResult := mrOK;
    end;
    //RefillForm.Close;
end;

procedure TRefillForm.FormShow(Sender: TObject);
var
    SQLText: string;
begin
    IsChipCard := (MainForm.ActivePageIndex <> 17);
    if not IsChipCard then
    begin
        Label4.Caption := 'посещения';
        DM.KARTIALL1.Refresh;
        DM.KARTIALL.Refresh;
        nomer := 0;
        maxnomer := 0;
        DM.MinMax.Active := False;
        DM.MinMax.SQL.SetText(PChar('SELECT * FROM kartiall ORDER BY KARTANOMER DESC'));
        DM.MinMax.Active := True;
        DM.MinMax.First;
        nomer := DM.MinMax.FieldByName('KARTANOMER').AsInteger;
        nomer := nomer + 1;
        Edit1.Text := IntToStr(nomer);
        MaskEdit2.Text := IntToStr2(DM.Qklienti.FieldValues['nomer']);
    end;
    if IsChipCard then
    begin
        Label4.Caption := 'минути';
        nomer := 0;
        maxnomer := 0;
        if (card.StudioNomer > 0) or (DM.Internet.FieldValues['StudioNomer'] = 0) then
        begin
            if card.StudioNomer = DM.Internet.FieldValues['StudioNomer']
                then
            begin
                MainForm.QKlienti.Active := False;
                if not MainForm.GetKlubniKartiFrame.ShowAllKlientsCb.Checked then
                    SQLText := ' WHERE NOMER >-1 ';
                MainForm.QKlienti.SQL.SetText(PChar('SELECT * FROM klienti ' +
                    SQLText + ' ORDER BY IME'));
                MainForm.QKlienti.Active := True;
                if DM.Qklienti.Locate('NOMER', Card.ClientNomer, []) then
                begin
                    MainForm.QKlienti.Edit;
                end
                else
                begin
                    MainForm.QKlienti.Append;
                    MainForm.QKlienti.FieldValues['IME'] := Card.ClientName;
                    MainForm.QKlienti.Post;
                    MainForm.QKlienti.Edit;
                end;
            end;
            Edit1.Text := IntToStr(Card.CardNomer);
            MaskEdit2.Text := IntToStr2(DM.Qklienti.FieldValues['nomer']);
        end
        else
        begin
            //DM.CHIPKARTI.Append;
            //DM.CHIPKARTI.FieldValues['STARTDATE']:=Date;
            //DM.CHIPKARTI.FieldValues['KLIENTNOMER']:= MainForm.QKlienti.FieldValues['NOMER'];
           // DM.CHIPKARTI.Post;
            //Card.CardNomer:= DM.CHIPKARTI.FieldValues['KARTANOMER'];
            //Edit1.Text:='Нова';
            MaskEdit2.Text := IntToStr(Card.CardNomer); //IntToStr2(DM.Qklienti.FieldValues['nomer']);
            Edit1.Text := MaskEdit2.Text;
        end;
    end;
end;
end.

