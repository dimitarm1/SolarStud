unit MAIN;

interface

uses Windows, SysUtils, DateUtils, Classes, Graphics, Forms, Controls, Menus,
    StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
    ActnList, ToolWin, ImgList, jpeg, Gauges, DB, DBTables, DBCtrls, Grids,
    DBGrids, ValEdit, Mask, DBClient, ImageWin, MXDB, Mxstore,
    Series, setformdata, Variants, Math,
    QuickRpt, QRCtrls, TeeProcs, TeEngine, Chart, StrUtils,
    StatChar, DBChart, RzBorder, {wwDBNavigator, } wwclearpanel,
    Wwdbgrid, LMDControl, LMDBaseControl, LMDBaseGraphicControl,
    LMDGraphicControl, LMDLEDCustomLabel, LMDLEDLabel, ABSMain,
    AdvPageControl, LMDCustomPanel, LMDButtonControl,
    LMDCustomCheckBox, LMDDBCheckBox, LMDWebBase, LMDMapi, wwdbedit,
    wwdblook, Wwdbdlg,
    AdvCombo, Lucombo, dblucomb, LMDCustomBevelPanel,
    LMDCustomParentPanel, LMDCustomPanelFill, LMDPanelShape, LMDCustomButton,
    LMDButton, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel,
    LMDBackPanel, LMDBaseGraphicButton, LMDCustomShapeButton, LMDShapeButton,
    wwclearbuttongroup, wwradiogroup, datelbl, AdvDBLookupComboBox, AdvEdit,
    AdvMEdBtn, PlannerMaskDatePicker, wwdbdatetimepicker, RzDTP, RzDBDTP,
    LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtCombo,
    LMDCalendarComboBox, LMDDBCalendarComboBox, wwcheckbox, LMDCheckBox,
    RzButton, RzRadChk, TeeSurfa, RzDBCmbo, LMDCustomMemo, LMDMemo,
    LMDCustomComponent, LMDBaseController, LMDCustomContainer,
    LMDCustomImageList, LMDImageList, LMDCustomMMButton, LMDMMButton,
    AdvToolBtn, RzBmpBtn, LMDCustom3DButton, LMD3DEffectButton, DBAdvEd,
    LMDWndProcComponent, LMDFormStyler, TeeDBEdit, TeeDBCrossTab, RzStatus,
    RzLabel, LMDStorBase, LMDStorINIVault, MainForm2, LMDStorFormHook,
    LMDStorPropertiesStorage, OleCtrls, inifiles,
    LMDCustomNImage, LMDNImage, LMDBaseImage, LMDCustomLImage,
    LMDLImage, ABSTypes, LMDDBMaskEdit, LMDDBEdit, Wwdotdot,
    Wwdbcomb, Planner, PlanSimpleEdit, PlanItemEdit, DBPlanner, AdvEdBtn,
    PlannerDatePicker, LMDCustomListComboBox, LMDListComboBox,
    LMDDBListComboBox,
    RzCmboBx, Wwdbigrd, RzEdit, RzDBEdit, LMDCustomControl;

type
    TSLE4442Card = packed record
        StudioName: string;
        ClientName: string;
        ClientNomer: Integer;
        Balans: Real;
        StudioNomer: Byte;
        PIN: string;
        CardNomer: Integer;
        ErrCounter: Integer;
        ConStatus: Integer;
        NewCard: Boolean;
    end;
function ConvertCurr1(Money_var: variant): AnsiString;
function IntToStr2(value: variant): string;
procedure FillValues1();
type
    TMainForm = class(TForm)
        OpenDialog: TOpenDialog;
        Image2: TImage;
        Timer1: TTimer;
        Image4: TImage;
        Image5: TImage;
        Label4: TLabel;
        Label5: TLabel;
        Label7: TLabel;
        Label10: TLabel;
        Label11: TLabel;
        Image10: TImage;
        Image11: TImage;
        Label12: TLabel;
        Label13: TLabel;
        Label14: TLabel;
        Label15: TLabel;
        Label16: TLabel;
        Label17: TLabel;
        Label18: TLabel;
        Label19: TLabel;
        Label20: TLabel;
        Label21: TLabel;
        Label22: TLabel;
        Label23: TLabel;
        Label24: TLabel;
        Label25: TLabel;
        Label26: TLabel;
        Label27: TLabel;
        PaymentOKLabel: TLabel;
        Label29: TLabel;
        DataSource1: TDataSource;
        Image16: TImage;
        DBEdit1: TDBEdit;
        Label31: TLabel;
        Image15: TImage;
        Label34: TLabel;
        Label35: TLabel;
        Label36: TLabel;
        Label37: TLabel;
        Label38: TLabel;
        Label39: TLabel;
        Label41: TLabel;
        Label43: TLabel;
        Label44: TLabel;
        Label45: TLabel;
        DBComboBox1: TDBComboBox;
        DBComboBox3: TDBComboBox;
        DBComboBox4: TDBComboBox;
        DBComboBox5: TDBComboBox;
        Image17: TImage;
        Label46: TLabel;
        Label48: TLabel;
        Label49: TLabel;
        Label50: TLabel;
        DBEdit9: TDBEdit;
        DBEdit10: TDBEdit;
        DBEdit11: TDBEdit;
        DBEdit12: TDBEdit;
        Image18: TImage;
        Label53: TLabel;
        Image19: TImage;
        Image20: TImage;
        Imagesol1: TImage;
        Imagesol3: TImage;
        Imagesol2: TImage;
        Label51: TLabel;
        Image26: TImage;
        Image27: TImage;
        Image28: TImage;
        Image29: TImage;
        Image30: TImage;
        Image31: TImage;
        Image32: TImage;
        Kabina11: TLabel;
        Kabina21: TLabel;
        Kabina31: TLabel;
        Gauge1: TGauge;
        DBText1: TDBText;
        Label61: TLabel;
        DBComboBox8: TDBComboBox;
        DBEdit3: TDBEdit;
        DBText2: TDBText;
        DBText3: TDBText;
        DBText5: TDBText;
        DBText6: TDBText;
        Label66: TLabel;
        Label67: TLabel;
        Label68: TLabel;
        Kabina1minuti: TLabel;
        Kabina1cena: TLabel;
        Kabina2minuti: TLabel;
        Kabina2cena: TLabel;
        Kabina3minuti: TLabel;
        Kabina3cena: TLabel;
        Image34: TImage;
        Image35: TImage;
        Image36: TImage;
        Image37: TImage;
        Image38: TImage;
        Image39: TImage;
        Label75: TLabel;
        Label76: TLabel;
        Label77: TLabel;
        Label78: TLabel;
        Label79: TLabel;
        Label80: TLabel;
        Label91: TLabel;
        Label92: TLabel;
        Image50: TImage;
        Image51: TImage;
        Label95: TLabel;
        DataSource2: TDataSource;
        Label8: TLMDLEDLabel;
        Label9: TLMDLEDLabel;
        sol1: TABSDatabase;
        SOLARIUMI: TABSTable;
        Table3: TABSTable;
        AdvPageControl1: TAdvPageControl;
    LogoEkran1: TAdvTabSheet;
    OsnovenEkran2: TAdvTabSheet;
    FirmiISluziteli3: TAdvTabSheet;
    IzborNaPlashtane4: TAdvTabSheet;
    IzborNaVreme5: TAdvTabSheet;
    Menu6: TAdvTabSheet;
    SolariumiNastroiki7: TAdvTabSheet;
    SolariumiInfo8: TAdvTabSheet;
    SolariumiCeni9: TAdvTabSheet;
    NachalnoUstanoviavane10: TAdvTabSheet;
    Arhivirane11: TAdvTabSheet;
    Statistika12: TAdvTabSheet;
    Protokol13: TAdvTabSheet;
    OsnovniNastroiki14: TAdvTabSheet;
    DrugiNastroiki15: TAdvTabSheet;
    MenuKasa16: TAdvTabSheet;
    ManuStoki17: TAdvTabSheet;
        Label96: TLabel;
        LMDDBCheckBox1: TLMDDBCheckBox;
        Label30: TLabel;
        Label56: TLabel;
        Label97: TLabel;
        Image52: TImage;
        Label98: TLabel;
        LMDMapiSendMail1: TLMDMapiSendMail;
        Internet: TABSTable;
        Label52: TLabel;
        wwDBEdit1: TwwDBEdit;
        DataSource3: TDataSource;
        Label99: TLabel;
        Label100: TLabel;
        wwDBEdit2: TwwDBEdit;
        wwDBEdit3: TwwDBEdit;
        Label101: TLabel;
        Label102: TLabel;
        DBCheckBox1: TDBCheckBox;
        DayTotal: TABSQuery;
        Label62: TLMDLEDLabel;
        Label103: TLabel;
        Label104: TLabel;
        Label105: TLabel;
        DataSource5: TDataSource;
        wwDBGrid2: TwwDBGrid;
        Label107: TLabel;
        Label108: TLabel;
        Label109: TLabel;
        Spravka1: TABSQuery;
        Label110: TLabel;
        STOKI: TABSTable;
        KARTI: TABSQuery;
        DataSource6: TDataSource;
        Image56: TImage;
        Label123: TLabel;
        DataSource7: TDataSource;
        STOKITE: TABSQuery;
        LMDSimpleLabel2: TLMDSimpleLabel;
        DataSource8: TDataSource;
        Label122: TLabel;
        KARTIALL1: TABSTable;
        DataSource10: TDataSource;
    KlubniKarti18: TAdvTabSheet;
        Image58: TImage;
        wwDBGrid6: TwwDBGrid;
        wwDBGrid7: TwwDBGrid;
        Label125: TLabel;
        Label126: TLabel;
        KlientLabel_p18: TLabel;
        Label129: TLabel;
        Label130: TLabel;
        AdvComboBox1: TAdvComboBox;
        Image55: TImage;
        Label6: TLabel;
        KasaGrid: TwwDBGrid;
        Sdelka: TABSQuery;
        PlashtaniaTable: TABSTable;
        DataSource9: TDataSource;
        wwDBGrid9: TwwDBGrid;
        MinMax: TABSQuery;
        DataSource11: TDataSource;
        LMDSimpleLabel3: TLMDSimpleLabel;
        Label111: TLabel;
        DataSource12: TDataSource;
        Label113: TLabel;
        Edit1: TEdit;
        KARTIALL: TABSTable;
        Label114: TLabel;
        Label115: TLabel;
        Label116: TLabel;
        Label117: TLabel;
        Label119: TLabel;
        Label127: TLabel;
        Bevel3: TBevel;
        Bevel1: TBevel;
        LMDButton5: TLMDButton;
        LMDButton6: TLMDButton;
        LMDButton7: TLMDButton;
        LMDButton8: TLMDButton;
        Label94: TLabel;
        solariumspr: TABSTable;
        stokispr: TABSTable;
        DataSource13: TDataSource;
        Label133: TLabel;
        Imagesol4: TImage;
        Kabina41: TLabel;
        Kabina51: TLabel;
        Imagesol5: TImage;
        Kabina5minuti: TLabel;
        Kabina5cena: TLabel;
        Kabina4minuti: TLabel;
        Kabina4cena: TLabel;
        Kabina6cena: TLabel;
        Kabina6minuti: TLabel;
        Imagesol6: TImage;
        Kabina61: TLabel;
        Qklienti: TABSQuery;
        Qkarti: TABSQuery;
        Edit6: TEdit;
        Label143: TLabel;
        Label144: TLabel;
        DBLUCombo1: TPlannerMaskDatePicker;
        Edit5: TEdit;
        Kabina42: TLabel;
        Kabina52: TLabel;
        Kabina62: TLabel;
        Kabina12: TLabel;
        Kabina22: TLabel;
        Kabina32: TLabel;
        Image33: TImage;
        PlannerMaskDatePicker1: TPlannerMaskDatePicker;
        PlannerMaskDatePicker2: TPlannerMaskDatePicker;
        Label147: TLabel;
        Label148: TLabel;
        Label149: TLabel;
        Label58: TLabel;
        Label59: TLabel;
        Label60: TLabel;
        DataSource14: TDataSource;
        AdvComboBox2: TAdvComboBox;
        Label69: TLabel;
        Label70: TLabel;
        Bevel2: TBevel;
        Label71: TLabel;
        Label72: TLabel;
        Label73: TLabel;
        DBEdit4: TDBEdit;
        Label93: TLabel;
        Label118: TLabel;
        DBEdit7: TDBEdit;
        DBEdit6: TDBEdit;
        DBText4: TDBText;
        Label131: TLabel;
        DBComboBox6: TDBComboBox;
        Label132: TLabel;
        QKartiPaid: TABSQuery;
        DBText8: TDBText;
        DBText9: TDBText;
        wwDBEdit6: TwwDBEdit;
        Label74: TLabel;
        Label134: TLabel;
        Label135: TLabel;
    ChipKarti19: TAdvTabSheet;
        wwDBGrid5: TwwDBGrid;
        NovKlientButton: TLMDButton;
        Label136: TLabel;
        Label137: TLabel;
        Label138: TLabel;
        Label139: TLabel;
        Label140: TLabel;
        Label141: TLabel;
        Image12: TImage;
        Edit10: TEdit;
        QChipKarti: TABSQuery;
        DataSource4: TDataSource;
        wwDBEdit5: TwwDBEdit;
        wwDBEdit7: TwwDBEdit;
        KartaSearchBox: TEdit;
        LMDMemo1: TMemo;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        mMsg: TRichEdit;
        LMDButton10: TLMDButton;
        LMDButton12: TLMDButton;
        LMDButton13: TLMDButton;
        LMDButton14: TLMDButton;
        CHIPKARTI: TABSTable;
        KartiAsStokiMenu: TPopupMenu;
        N3: TMenuItem;
        N4: TMenuItem;
        N5: TMenuItem;
        PopupMenu3: TPopupMenu;
        AddressComboBox: TDBComboBox;
        Bclose: TButton;
        Chart1: TChart;
        QStatistika: TABSQuery;
        LMDButton15: TLMDButton;
        RzURLLabel1: TRzURLLabel;
        Label64: TLabel;
        Timer2: TTimer;
        NulImage: TImage;
        Label81: TLabel;
        Label82: TLabel;
        Label83: TLabel;
        Label84: TLabel;
        Label85: TLabel;
        Label86: TLabel;
        Label87: TLabel;
    No5: TLabel;
    No6: TLabel;
    No7: TLabel;
        No1: TLabel;
        No2: TLabel;
        No3: TLabel;
        BHelp: TButton;
        DBCrossTabSource1: TDBCrossTabSource;
        Label146: TLabel;
        DBText10: TDBText;
        ComboBox1: TComboBox;
        Series1: TBarSeries;
        DBCrossTabSource2: TDBCrossTabSource;
        Label150: TLabel;
        Gauge2: TGauge;
        personal1: TABSTable;
        personalset: TDataSource;
        wwDBGrid1: TwwDBGrid;
        Label42: TLabel;
        DBNavigator1: TDBNavigator;
        wwDBGrid10: TwwDBGrid;
        DataSource15: TDataSource;
        StatistikaBox1: TRzCheckBox;
        Label1000: TLabel;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        Label2: TLabel;
        Label3: TLabel;
        Label1: TLabel;
        IniFile: TLMDStorINIVault;
        LMDImageList1: TLMDImageList;
        ImagePress1: TLMDLImage;
        Imagepress2: TLMDLImage;
        Imagepress3: TLMDLImage;
        Imagepress4: TLMDLImage;
        Imagepress5: TLMDLImage;
        Imagepress6: TLMDLImage;
        LMDImageList2: TLMDImageList;
        Image68: TLMDLImage;
        Image67: TLMDLImage;
        Image64: TLMDLImage;
        Image69: TLMDLImage;
        Image21: TLMDLImage;
        Image128: TImage;
        LMDImageList3: TLMDImageList;
        LMDImageList4: TLMDImageList;
        LMDLImage5: TLMDLImage;
        LMDLImage6: TLMDLImage;
        LMDLImage7: TLMDLImage;
        LMDLImage8: TLMDLImage;
        LMDLImage9: TLMDLImage;
        LMDImageList5: TLMDImageList;
        LMDLImage11: TLMDLImage;
        LMDLImage12: TLMDLImage;
        LMDLImage14: TLMDLImage;
        LMDLImage15: TLMDLImage;
        LMDLImage16: TLMDLImage;
        LMDLImage17: TLMDLImage;
        LMDLImage18: TLMDLImage;
        LMDLImage19: TLMDLImage;
        LMDLImage20: TLMDLImage;
        LMDLImage21: TLMDLImage;
        Image61: TImage;
        Image63: TImage;
        LMDLImage28: TLMDLImage;
        LMDSimpleLabel4: TLMDSimpleLabel;
        LMDLImage31: TLMDLImage;
        LMDLImage32: TLMDLImage;
        LMDLImage33: TLMDLImage;
        LMDLImage36: TLMDLImage;
        LMDImageList6: TLMDImageList;
        LMDLImage39: TLMDLImage;
        LMDLImage40: TLMDLImage;
        LMDLImage41: TLMDLImage;
        LMDLImage42: TLMDLImage;
        LMDLImage43: TLMDLImage;
        LMDLImage44: TLMDLImage;
        LMDLImage45: TLMDLImage;
        LMDLImage47: TLMDLImage;
        LMDLImage48: TLMDLImage;
        LMDLImage49: TLMDLImage;
        LMDLImage50: TLMDLImage;
        LMDLImage51: TLMDLImage;
        LMDLImage52: TLMDLImage;
        LMDLImage53: TLMDLImage;
        LMDLImage54: TLMDLImage;
        LMDLImage55: TLMDLImage;
        LMDLImage56: TLMDLImage;
        LMDLImage57: TLMDLImage;
        LMDLImage58: TLMDLImage;
        LMDLImage59: TLMDLImage;
        LMDLImage60: TLMDLImage;
        LMDLImage61: TLMDLImage;
        LMDLImage62: TLMDLImage;
        LMDLImage63: TLMDLImage;
        LMDLImage64: TLMDLImage;
        LMDLImage65: TLMDLImage;
        LMDLImage66: TLMDLImage;
        LMDLImage67: TLMDLImage;
        LMDLImage68: TLMDLImage;
        LMDLImage69: TLMDLImage;
        LMDLImage71: TLMDLImage;
        LMDLImage72: TLMDLImage;
        LMDLImage73: TLMDLImage;
        LMDLImage74: TLMDLImage;
        LMDLImage75: TLMDLImage;
        LMDLImage76: TLMDLImage;
        LMDLImage77: TLMDLImage;
        LMDLImage84: TLMDLImage;
        LMDLImage85: TLMDLImage;
        LMDLImage86: TLMDLImage;
        LMDLImage87: TLMDLImage;
        LMDLImage88: TLMDLImage;
        LMDLImage89: TLMDLImage;
        LMDLImage90: TLMDLImage;
        LMDLImage91: TLMDLImage;
        LMDButton16: TLMDButton;
        LMDButton17: TLMDButton;
        LMDLImage92: TLMDLImage;
        LMDLImage93: TLMDLImage;
        Label54: TLabel;
        Label55: TLabel;
        LMDLImage29: TLMDLImage;
        LMDLImage94: TLMDLImage;
        LMDLImage95: TLMDLImage;
        LMDLImage96: TLMDLImage;
        LMDLImage97: TLMDLImage;
        LMDLImage80: TLMDLImage;
        LMDLImage81: TLMDLImage;
        LMDLImage82: TLMDLImage;
        LMDLImage83: TLMDLImage;
        LMDLImage102: TLMDLImage;
        LMDLImage2: TLMDLImage;
        LMDLImage103: TLMDLImage;
        LMDLImage104: TLMDLImage;
        LMDLImage105: TLMDLImage;
        LMDLImage108: TLMDLImage;
        LMDLImage109: TLMDLImage;
        LMDLImage110: TLMDLImage;
        LMDLImage3: TLMDLImage;
        Label57: TLabel;
        Label63: TLabel;
        LMDLImage4: TLMDLImage;
        Label65: TLabel;
        LMDLImage98: TLMDLImage;
        LMDLImage99: TLMDLImage;
        Label151: TLabel;
        Label152: TLabel;
        LMDLImage100: TLMDLImage;
        Label153: TLabel;
        LMDLImage101: TLMDLImage;
        LMDLImage111: TLMDLImage;
        LMDLImage112: TLMDLImage;
        LMDLImage113: TLMDLImage;
        Label32: TLabel;
        LMDLImage46: TLMDLImage;
        LMDLImage114: TLMDLImage;
        LMDLImage30: TLMDLImage;
        LMDLImage13: TLMDLImage;
        LMDLImage10: TLMDLImage;
        LMDLImage70: TLMDLImage;
        LMDLImage115: TLMDLImage;
        LMDLImage116: TLMDLImage;
        LMDLImage117: TLMDLImage;
        LMDLImage118: TLMDLImage;
        LMDLImage119: TLMDLImage;
        Label33: TLabel;
        Label40: TLabel;
        Label47: TLabel;
        Label154: TLabel;
        LMDLImage35: TLMDLImage;
        LMDLImage120: TLMDLImage;
        LMDLImage121: TLMDLImage;
        LMDNImage1: TLMDNImage;
        LMDNImage2: TLMDNImage;
        LMDNImage3: TLMDNImage;
        LMDLImage122: TLMDLImage;
        LMDLImage123: TLMDLImage;
        LMDLImage124: TLMDLImage;
        LMDLImage125: TLMDLImage;
        LMDLImage129: TLMDLImage;
        LMDLImage130: TLMDLImage;
        LMDLImage133: TLMDLImage;
        LMDLImage134: TLMDLImage;
        LMDLImage135: TLMDLImage;
        LMDLImage136: TLMDLImage;
        LMDLImage137: TLMDLImage;
        LMDLImage138: TLMDLImage;
        LMDLImage126: TLMDLImage;
        LMDLImage1: TLMDLImage;
        LMDLImage37: TLMDLImage;
        LMDLImage38: TLMDLImage;
        LMDLImage127: TLMDLImage;
        LMDLImage128: TLMDLImage;
        LMDLImage131: TLMDLImage;
        LMDLImage34: TLMDLImage;
        LMDLImage78: TLMDLImage;
        LMDLImage79: TLMDLImage;
        LMDLImage106: TLMDLImage;
        LMDLImage107: TLMDLImage;
        Label88: TLabel;
        LMDLImage25: TLMDLImage;
        LMDLImage26: TLMDLImage;
        LMDLImage140: TLMDLImage;
        LMDLImage139: TLMDLImage;
        Label90: TLabel;
        DBText11: TDBText;
        Label106: TLabel;
        DBText12: TDBText;
        KARTICHIP: TABSTable;
        DataSource16: TDataSource;
        Label121: TLabel;
        wwDBEdit4: TwwDBEdit;
        Label142: TLabel;
        wwDBEdit8: TwwDBEdit;
        Image3: TImage;
        LMDNImage5: TLMDNImage;
        LMDSimpleLabel7: TLMDSimpleLabel;
        Label155: TLabel;
        DBText13: TDBText;
        Bevel4: TBevel;
        Label156: TLabel;
        VipLabel: TDBText;
        bonusLabel: TLabel;
        Label158: TLabel;
        Memo1: TMemo;
        LMDLImage27: TLMDLImage;
        DBText15: TDBText;
        LMDSimpleLabel8: TLMDSimpleLabel;
        DBText16: TDBText;
        DBText17: TDBText;
        Timer3: TTimer;
        maxday: TABSQuery;
        Plashtania: TABSQuery;
        Label89: TLabel;
        Label145: TLabel;
        Label159: TLabel;
        PosEdit: TLMDDBEdit;
        SumaEdit: TLMDDBEdit;
        PercentEdit: TLMDDBEdit;
        Image6: TImage;
        Label160: TLabel;
        LMDLImage141: TLMDLImage;
        LMDLImage142: TLMDLImage;
        LMDLImage143: TLMDLImage;
        LMDLImage144: TLMDLImage;
        LMDLImage145: TLMDLImage;
        Label161: TLabel;
        CENITABLE: TABSTable;
        LMDLImage146: TLMDLImage;
        LMDLImage147: TLMDLImage;
        NuliraneChipCartaButton: TLMDButton;
        Timer4: TTimer;
        DataSource17: TDataSource;
        QCeni: TABSQuery;
        Label28: TLabel;
        StokiteTab: TAdvPageControl;
        AdvTabSheet20: TAdvTabSheet;
        AdvTabSheet21: TAdvTabSheet;
        AdvTabSheet22: TAdvTabSheet;
        wwDBGrid4: TwwDBGrid;
        wwDBGrid3: TwwDBGrid;
        Label124: TLabel;
        DobaviStokaBtn: TLabel;
        USLUGITE: TABSQuery;
        DataSource18: TDataSource;
        wwDBGrid11: TwwDBGrid;
        Firmite: TABSQuery;
        DataSource19: TDataSource;
        wwDBGrid12: TwwDBGrid;
        DBNavigator2: TDBNavigator;
        Label112: TLabel;
        RangCombo: TwwDBComboBox;
        wwDBGrid13: TwwDBGrid;
        LMDLImage22: TLMDLImage;
        Label163: TLabel;
        FirmaCombo: TRzDBLookupComboBox;
    Grafik23: TAdvTabSheet;
        Image7: TImage;
        LMDLImage23: TLMDLImage;
        Label164: TLabel;
        LMDLImage150: TLMDLImage;
        SimpleItemEditor1: TSimpleItemEditor;
        DefaultItemEditor1: TDefaultItemEditor;
        Planner: TABSTable;
        DataSource20: TDataSource;
        DBDaySource1: TDBDaySource;
        Planner1: TDBPlanner;
        Page23PrintBtn: TLabel;
        Label165: TLabel;
        Label166: TLabel;
        PlannerDatePicker1: TPlannerDatePicker;
        Planner2: TDBPlanner;
        Planner3: TDBPlanner;
        DBDaySource2: TDBDaySource;
        DBDaySource3: TDBDaySource;
        PLANNER02: TABSTable;
        DataSource21: TDataSource;
        PLANNER03: TABSTable;
        DataSource22: TDataSource;
        LMDButton1: TLMDButton;
        LMDButton2: TLMDButton;
        DBText14: TDBText;
        DBText7: TComboBox;
        ComboBox2: TComboBox;
        Label167: TLabel;
        wwDBEdit9: TwwDBEdit;
        DBText18: TDBText;
        LMDSimpleLabel1: TLMDSimpleLabel;
        LMDSimpleLabel5: TLMDSimpleLabel;
        Label162: TLabel;
        CeniGrid: TwwDBGrid;
        LMDLImage24: TLMDLImage;
        Label9A: TLMDLEDLabel;
        Label168: TLabel;
        PriceCardLabel4: TLMDLEDLabel;
        PriceCardLabel3: TLabel;
        StatusShape1: TShape;
        StatusShape2: TShape;
        StatusShape3: TShape;
        StatusShape4: TShape;
        StatusShape5: TShape;
        StatusShape6: TShape;
        TrackBar1: TTrackBar;
        LMDButton3: TLMDButton;
        PopalniCeniTableButton: TRzButton;
        Label128: TLabel;
        ValidnostDate: TRzDBDateTimeEdit;
        OncePerDayBox: TLMDDBCheckBox;
        Button111: TRzButton;
        ShowAllKlientsCb: TCheckBox;
        Label169: TLabel;
        Timer6: TTimer;
        ValidnostTime: TRzDBDateTimeEdit;
        Label157: TLabel;
        Image1: TImage;
        Image8: TImage;
        STOKITE_SKLAD: TABSQuery;
        DataSource23: TDataSource;
        StokaEditBtn: TLabel;
        wwDBGrid8: TwwDBGrid;
        PopalniCeniTableButton2: TRzButton;
        DataSource24: TDataSource;
        Label120: TLabel;
        Label170: TLabel;
        ProtokolFilterEdit: TEdit;
        Label171: TLabel;
        TipNaRabotaCombo: TComboBox;
        LMDLImage132: TLMDLImage;
        Image9: TImage;
        Label172: TLabel;
        No4: TLabel;
        LMDLImage148: TLMDLImage;
        Label173: TLabel;
        LMDLImage149: TLMDLImage;
        Image13: TImage;
        Label174: TLabel;
        No8: TLabel;
        LMDLImage151: TLMDLImage;
        Label176: TLabel;
    Imagepress7: TLMDLImage;
    Kabina71: TLabel;
    Kabina72: TLabel;
    StatusShape7: TShape;
    Imagesol7: TImage;
    Kabina7minuti: TLabel;
    Kabina7cena: TLabel;
    Imagepress8: TLMDLImage;
    Kabina81: TLabel;
    Kabina82: TLabel;
    Imagesol8: TImage;
    StatusShape8: TShape;
    Kabina8minuti: TLabel;
    Kabina8cena: TLabel;
        procedure Label1Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure Timer1Timer(Sender: TObject);
        procedure BitBtn4Click(Sender: TObject);
        procedure BitBtn1Click(Sender: TObject);
        procedure BitBtn2Click(Sender: TObject);
        procedure BitBtn5Click(Sender: TObject);
        procedure BitBtn3Click(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure Image6Click(Sender: TObject);
        procedure Image7Click(Sender: TObject);
        procedure Image8Click(Sender: TObject);
        procedure Image9Click(Sender: TObject);
        procedure SpeedButton1Click(Sender: TObject);
        procedure Label13Click(Sender: TObject);
        procedure Label31Click(Sender: TObject);
        procedure Label33Click(Sender: TObject);
        procedure Label40Click(Sender: TObject);
        procedure Label47Click(Sender: TObject);
        procedure Label48Click(Sender: TObject);
        procedure Label49Click(Sender: TObject);
        procedure Label22Click(Sender: TObject);
        procedure Label10Click(Sender: TObject);
        procedure BitBtn6Click(Sender: TObject);
        procedure Imagepress1_MouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure Label54Click(Sender: TObject);
        procedure Label55Click(Sender: TObject);
        procedure Image27Click(Sender: TObject);
        procedure Image26Click(Sender: TObject);
        procedure RTFLabel1Click(Sender: TObject);
        procedure Edit4Change(Sender: TObject);
        procedure PaymentOKLabelClick(Sender: TObject);
        procedure FormKeyPress(Sender: TObject; var Key: Char);
        procedure Label14Click(Sender: TObject);
        procedure Label68Click(Sender: TObject);
        procedure Label91Click(Sender: TObject);
        procedure Label92Click(Sender: TObject);
        procedure Label94Click(Sender: TObject);
        procedure AdvPageControl1Change(Sender: TObject);
        procedure Label30Click(Sender: TObject);
        procedure Label23Click(Sender: TObject);
        procedure DBLUCombo11Change(Sender: TObject);
        procedure Label110Click(Sender: TObject);
        procedure b2Click(Sender: TObject);
        procedure Label120Click(Sender: TObject);
        procedure wwDBGrid3FieldChanged(Sender: TObject; Field: TField);
        procedure Label123Click(Sender: TObject);
        procedure LMDButton6Click(Sender: TObject);
        procedure LMDShapeButton1Click(Sender: TObject);
        procedure Label112Click(Sender: TObject);
        procedure Label111Click(Sender: TObject);
        procedure Label16Click(Sender: TObject);
        procedure LMDButton7Click(Sender: TObject);
        procedure OsnovenEkran2Show(Sender: TObject);
        procedure SolariumiNastroiki7Show(Sender: TObject);
        procedure LMDButton5Click(Sender: TObject);
        procedure KlubniKarti18Show(Sender: TObject);
        procedure wwDBGrid6Exit(Sender: TObject);
        procedure MenuKasa16Show(Sender: TObject);
        procedure wwDBGrid6TitleButtonClick(Sender: TObject;
            AFieldName: string);
        procedure Edit6Change(Sender: TObject);
        procedure wwDBGrid6RowChanged(Sender: TObject);
        procedure Edit7Change(Sender: TObject);
        procedure wwDBGrid7TitleButtonClick(Sender: TObject;
            AFieldName: string);
        procedure wwDBGrid7RowChanged(Sender: TObject);
        procedure Edit5Change(Sender: TObject);
        procedure IzborNaPlashtane4Show(Sender: TObject);
        procedure PlannerMaskDatePicker2Change(Sender: TObject);
        procedure Label17Click(Sender: TObject);
        procedure AdvComboBox2Change(Sender: TObject);
        procedure KlientLabel_p18DblClick(Sender: TObject);
        procedure RzBmpButton1MouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure RzBmpButton1MouseUpton1MouseUp(Sender: TObject; Button:
            TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure RzBmpButton2MouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure RzBmpButton2MouseUp(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure RzBmpButton3MouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure RzBmpButton3MouseUp(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure RzBmpButton4MouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure RzBmpButton4MouseUp(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure AdvTabSheet5Show(Sender: TObject);
        procedure wwDBEdit7KeyPress(Sender: TObject; var Key: Char);
        procedure Label139Click(Sender: TObject);
        procedure KartaSearchBoxKeyPress(Sender: TObject; var Key: Char);
        procedure AdvComboBox2KeyPress(Sender: TObject; var Key: Char);
        procedure KartaSearchBoxKeyUp(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure N2Click(Sender: TObject);
        procedure N1Click(Sender: TObject);
        procedure Label92MouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure DBCheckBox1Exit(Sender: TObject);
        procedure LMDButton10Click(Sender: TObject);
        procedure LMDButton12Click(Sender: TObject);
        procedure LMDButton13Click(Sender: TObject);
        procedure LMDButton14Click(Sender: TObject);
        procedure NuliraneChipCartaButtonClick(Sender: TObject);
        procedure ZarezdaneButtonClick(Sender: TObject);
        procedure ManuStoki17Show(Sender: TObject);
        procedure N3Click(Sender: TObject);
        procedure LMDButton1MouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure N4Click(Sender: TObject);
        procedure N5Click(Sender: TObject);
        procedure ChipKarti19Show(Sender: TObject);
        procedure NovKlientButtonClick(Sender: TObject);
        procedure Label144Click(Sender: TObject);
        procedure AddressComboBoxDropDown(Sender: TObject);
        procedure BcloseClick(Sender: TObject);
        procedure RzCheckBox1Click(Sender: TObject);
        procedure SolariumiInfo8Show(Sender: TObject);
        procedure LMDButton15Click(Sender: TObject);
        procedure Timer2Timer(Sender: TObject);
        procedure BHelpClick(Sender: TObject);
        procedure SolariumiCeni9Show(Sender: TObject);
        procedure ComboBox1Change(Sender: TObject);
        procedure Protokol13Show(Sender: TObject);
        procedure PaymentOKLabelMouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure PaymentOKLabelMouseUp(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure StatistikaBox1Click(Sender: TObject);
        procedure Label21Click(Sender: TObject);
        procedure Label2Click(Sender: TObject);
        procedure Label3Click(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
            Y: Integer);
        procedure PlannerMaskDatePicker1DaySelect(Sender: TObject;
            SelDate: TDateTime);
        procedure PlannerMaskDatePicker2DaySelect(Sender: TObject;
            SelDate: TDateTime);
        procedure Statistika12Show(Sender: TObject);
        procedure DBComboBox4Change(Sender: TObject);
        procedure DBComboBox5Change(Sender: TObject);
        procedure Edit6KeyPress(Sender: TObject; var Key: Char);
        procedure Timer3Timer(Sender: TObject);
        procedure PosEditEnter(Sender: TObject);
        procedure Button111Click(Sender: TObject);
        procedure LMDLImage115Click(Sender: TObject);
        procedure Label143Click(Sender: TObject);
        procedure PayCashButtonClick(Sender: TObject);
        procedure PreCalcPaiment(Sender: TObject);
        procedure PayChipCardClick(Sender: TObject);
        procedure PayClubCardClick(Sender: TObject);
        procedure CancelButtonClick(Sender: TObject);
        procedure PrintDayReportClick(Sender: TObject);
        procedure SettingsEndButtonClick(Sender: TObject);
        procedure EndButtonCardClick(Sender: TObject);
        procedure LMDButton9Click(Sender: TObject);
        procedure Timer4Timer(Sender: TObject);
        procedure PopalniCeniTableButtonClick(Sender: TObject);
        procedure AddStokaButtonClick(TipStoka: Integer);
        procedure DobaviStokaBtnClick(Sender: TObject);
        procedure IztriiStokaBtnClick(Sender: TObject);
        procedure Label124Click(Sender: TObject);
        procedure wwDBGrid12RowChanged(Sender: TObject);
        procedure Label162Click(Sender: TObject);
        procedure Page23PrintBtnClick(Sender: TObject);
        procedure Label165Click(Sender: TObject);
        procedure Label166Click(Sender: TObject);
        procedure PlannerDatePicker1Change(Sender: TObject);
        procedure Grafik23Show(Sender: TObject);
        procedure Planner2HeaderDblClick(Sender: TObject; SectionIndex:
            Integer);
        procedure Planner1HeaderDblClick(Sender: TObject; SectionIndex:
            Integer);
        procedure LMDButton1Click(Sender: TObject);
        procedure LMDButton2Click(Sender: TObject);
        procedure QklientiAfterRefresh;
        procedure DBText7Change(Sender: TObject);
        procedure DBText7DropDown(Sender: TObject);
        procedure ComboBox2Change(Sender: TObject);
        procedure FirmaComboCloseUp(Sender: TObject);
        procedure Timer6Timer(Sender: TObject);
        procedure TrackBar1Change(Sender: TObject);
        function DateToStrBg(_Date: TDateTime): string;
        procedure wwDBGrid2TitleButtonClick(Sender: TObject; AFieldName:
            string);
        procedure wwDBGrid3TitleButtonClick(Sender: TObject; AFieldName:
            string);
        procedure StokiGridTitleButtonClick(Sender: TObject; AFieldName:
            string);
        procedure wwDBGrid11TitleButtonClick(Sender: TObject; AFieldName:
            string);
        procedure KasaGridTitleButtonClick(Sender: TObject; AFieldName: string);
        procedure ChipKarti19Hide(Sender: TObject);
        procedure MenuKasa16Hide(Sender: TObject);
        procedure IzborNaPlashtane4Hide(Sender: TObject);
        procedure StokaEditBtnClick(Sender: TObject);
        procedure AdvTabSheet21Show(Sender: TObject);
        procedure StokiteTabChange(Sender: TObject);
        procedure PopalniCeniTableButton2Click(Sender: TObject);
        function FormHelp(Command: Word; Data: Integer;
            var CallHelp: Boolean): Boolean;
        procedure ProtokolFilterEditChange(Sender: TObject);
    procedure Label171Click(Sender: TObject);
    procedure TipNaRabotaComboChange(Sender: TObject);

    private

        { Private declarations }
    public
        procedure calcKasaPaid;
        procedure ReorderSQLDataSet(Query: TABSQuery; AFieldName: string);
        function GetStudioWorkType(): Integer;
        { Public declarations }

      //   procedure ChangeImageName();
    end;
procedure SendCmd(CmdNum: byte);
procedure LoadChart(index: integer);
procedure CalcPaid;
procedure initFlash();
procedure HideKlInfo;
procedure ShowKlInfo;

type
    _RS232DCB = packed record // dcb
        DCBlength: DWORD; // sizeof(DCB)
        BaudRate: DWORD; // current baud rate
        fBinary: DWORD; // binary mode, no EOF check
        fParity: DWORD; // enable parity checking
        fOutxCtsFlow: DWORD; // CTS output flow control
        fOutxDsrFlow: DWORD; // DSR output flow control
        fDtrControl: DWORD; // DTR flow control type
        fDsrSensitivity: DWORD; // DSR sensitivity

        fTXContinueOnXoff: DWORD; // XOFF continues Tx
        fOutX: DWORD; // XON/XOFF out flow control
        fInX: DWORD; // XON/XOFF in flow control
        fErrorChar: DWORD; // enable error replacement
        fNull: DWORD; // enable null stripping
        fRtsControl: DWORD; // RTS flow control
        fAbortOnError: DWORD; // abort reads/writes on error
        fDummy2: DWORD; // reserved
        wReserved: WORD; // not currently used

        XonLim: WORD; // transmit XON threshold
        XoffLim: WORD; // transmit XOFF threshold
        ByteSize: BYTE; // number of bits/byte, 4-8
        Parity: BYTE; // 0-4=no,odd,even,mark,space
        StopBits: BYTE; // 0,1,2 = 1, 1.5, 2
        XonChar: char; // Tx and Rx XON character
        XoffChar: char; // Tx and Rx XOFF character
        ErrorChar: char; // error replacement character

        EofChar: char; // end of input character
        EvtChar: char; // received event character
        wReserved1: WORD; // reserved; do not use
    end;
type
    TSolariumTime = packed record // dcb
        Pretime: Integer;
        MainTime: Integer;
        CoolTime: Integer;
    end;

const

    UART_BASEADDR = $3E8; //  the base address of the UART
    UART_BAUDRATE = 9600; //   the divisor value (e.g. 12 for 9600 baud)
    UART_LCRVAL = $1B; // the value to be written to the LCR (e.g. 0x1b for 8N1)
    UART_FCRVAL = $07; // the value to be written to the FCR. Bit 0, 1 and 2 set,
    // bits 6 & 7 according to wished trigger level (see above)

var
    TipNaRabotaIndex : integer;
    Q1: TabsQuery;
    tempCounter: Integer; //********* for debug
    SolariumTime: array[0..8] of TSolariumTime;
    StatusChar: array[0..1] of string;
    IndexSol: Byte;
    Card: TSLE4442Card;
    CabineStatus: array[0..16] of Byte;
    CabineOldStatus: array[0..16] of Byte;
    CabineTime: array[0..16] of Byte;
    CabineStartTime: array[0..16] of TDatetime;
    CabinePreTime: array[0..16] of Byte;
    LastTime: array[0..16] of Byte;
    CabineSetTime: array[0..16] of Byte;
    CabineErrCounter: array[0..16] of Byte;
    CabineChanel: array[0..16] of Byte;
    CabineRecord: array[0..16] of Longint;
    CabineStatusCounter: array[0..16] of Longint;
    DBText7Values: array of Integer;
    IOResult: Boolean;
    IOCount: DWORD;
    IOByte: BYTE;
    Retry: Integer;
    PreTime: Byte;
    CoolTime: Byte;
    CheckSum: Byte;
    MainTime: Byte;
    ImageName: string;
    IsChipCard: Boolean;
    TimeSet: Byte;
    LocalFormat: TFormatSettings;
    MainForm: TMainForm;
    OtchetFileName: string;
    ComFlags: byte;
    ComList: LPSTR;
    CB_RS232: _DCB;
    CB_RS232_NEW: _RS232DCB;
    RS_232_Timeouts: _COMMTIMEOUTS;
    PriceCash: Real;
    PriceCard: Real;
    PaidCash: Real;
    ToBePaidCash: Real;
    VipDiscount: Real;
    DiscountPrize: Real;
    CardNomer: Integer;
    PaidCard: Real;
    PaidChipCard: Real;
    Pos1: Byte;
    ComPortName: string;
    BaudRate: Integer;
    Backuped: Boolean;
    IsReader: Boolean;
    LastKey: string;
    Solariums: Byte;
    ViewByKlient: Boolean;
    StatistikaSQL: string;
    PoseshteniaPaid: array[0..20] of Byte;
    PosPaid: Byte;
    BroiKartiPaid: Byte;
    FormMoveStarted: Boolean;
    FormMoveStartY: Integer;
    FormMoveStartX: Integer;
    IsDemoMode: Boolean;
    IsDemo2: Boolean;
    MainIniFile: TIniFile;
    UseNativeStart: Boolean;
    //  WOverlaped: POverlaped;

implementation

uses Password, Notshalter, QReportKlienti, SetLang, CheckDatabase,
    QReportSolariumiNastroiki, QReportDneven, Refill, Stoki, ShellAPI, SLE4442;

{$R *.dfm}
var

    TimerTime1: DWORD;
    Timer2Time: DWORD;
    Mess1: string;
    Mess2: pointer;
    Suma: Real;
    SumaCard: Real;
    TimeKeyPress: TDateTime;

var
    StatusColors: array[0..8] of TColor;
    hDevice: HWND;
    KeyBuff: ShortString = '';
    BarCodReaderBuff: ShortString = '';
    KeyCount: Byte;
    DATA_COMBO_SELECTED: ShortString;
    SDELKANOMER: Integer;

procedure TMainForm.Label1Click(Sender: TObject);
begin
    //Label1.Caption:='TEST';
end;

function TMainForm.DateToStrBg(_date: TDateTime): string;
begin
    result := DateToStr(Date);
    result := AnsiReplaceText(result, ' г.', '');
end;

function IntToStr2(value: variant): string;
begin
    if varType(Value) <> varNull then
        result := IntToStr(value)
    else
        result := '0';
end;

procedure OpenTables;
var
    _Q: TABSQuery;
    Cena1: real;
    i1, i2: integer;
begin
    _Q := nil;
    _Q := TABSQuery.Create(nil);
    _Q.DatabaseName := 'sol1';

    with MainForm do
    begin
        Timer1.Enabled := false;
        if not FileExists(MainForm.sol1.DatabaseFileName) then
            MainForm.sol1.CreateDatabase;
        try
            MainForm.sol1.Open;
        except Application.MessageBox(PChar(GetMessage('M1')),
                PChar(GetMessage('M2')), MB_OK);
            // except  Application.MessageBox('Грешка в базата данни - Възстановете от архивно копие!', 'ГРЕШКА', MB_OK);
        end;
        _Q.SQL.SetText(PChar('UPDATE KLIENTI SET FIRMA=0' +
            ' WHERE (firma IS NULL) and NOT(NOMER is NULL)'));
        _Q.ExecSQL;
        _Q.Close;

        MinMax.Active := FALSE;
        QStatistika.Active := FALSE;
        MaxDay.Active := FALSE;
        Stoki.Close;
        Stokite.Close;
        stokispr.Close;
        daytotal.Close;
        karti.Close;
        USLUGITE.Close;
        Stoki.readonly := False;
        if stoki.FieldDefs.IndexOf('STOKATIP') < 0 then
        begin
            Stoki.RestructureFieldDefs.Add('STOKATIP', aftString, 1, FALSE);
            Stoki.RestructureTable;
            Stoki.AddIndex('STOKATIP', 'STOKATIP', []);
            Stoki.RestructureTable;
            Stoki.Close;
        end;
        if stoki.FieldDefs.IndexOf('STOKACENACARD') < 0 then
        begin
            Stoki.RestructureFieldDefs.Add('STOKACENACARD', aftCurrency, 1,
                FALSE);
            Stoki.RestructureTable;
            Stoki.Close;
        end;
        Stoki.Open; //STOKAORDER
        stokispr.Open;
        daytotal.Open;
        karti.Open;
        USLUGITE.Open;
        Stokite.SQL.SetText(PChar('select * from STOKI where STOKATIP = "S"'));
        Stokite.Active := TRUE;
        Stoki.First;
        while not Stoki.Eof do
        begin
            if (Stoki.FieldValues['STOKAKOD'] > 0) and
                ((Stoki.FieldValues['STOKATIP'] = '')
                or (Stoki.FieldValues['STOKATIP'] = null)) then
            begin
                Stoki.edit;
                Stoki.FieldValues['STOKATIP'] := 'S';
                Stoki.post;
            end;
            if (Stoki.FieldValues['STOKAKOD'] < 0) and
                (Stoki.FieldValues['POSESHTENIA'] = -1) and
                (Stoki.FieldValues['STOKATIP'] <> 'D') then
            begin
                Stoki.edit;
                Stoki.FieldValues['STOKATIP'] := 'D';
                Stoki.post;
            end;
            if (Stoki.FieldValues['STOKAKOD'] < 0) and (not
                (Stoki.FieldValues['POSESHTENIA'] = -1)) and
                (Stoki.FieldValues['STOKATIP'] <> 'K') then
            begin
                Stoki.edit;
                Stoki.FieldValues['STOKATIP'] := 'K';
                Stoki.post;
            end;
            Stoki.Next;
        end;
        SOLARIUMI.Active := True;
        if not sol1.TableExists('tablica_ceni') then
        begin
            _Q.SQL.Text :=
                'create table TABLICA_CENI ( SOLARIUM integer default 0, ' +
                'MINUTA integer default 4, CENA currency default 0, INDEX a1 (SOLARIUM))';
            _Q.ExecSQL; // .Active:=true;
            _Q.Active := False;
        end;
        _Q.SQL.Text := 'select * from TABLICA_CENI';
        _Q.readonly := False;
        _Q.InMemory := false;
        _Q.Active := true;
        _Q.readonly := False;
        if _Q.RecordCount < 600 then
        begin
            CENA1 := 0;
            for i1 := 0 to 16 do
            begin
                if i1 < Solariumi.RecordCount - 1 then
                    Solariumi.RecNo := i1 + 1;
                cena1 := Solariumi.FieldValues['CENA'];
                for i2 := 0 to 30 do
                begin
                    _Q.Append;
                    _Q.FieldValues['SOLARIUM'] := i1;
                    _Q.FieldValues['MINUTA'] := i2;
                    _Q.FieldValues['CENA'] := cena1 * i2;
                    _Q.Post;
                    if (i2 < 10) then
                    begin
                        _Q.Append;
                        _Q.FieldValues['SOLARIUM'] := i1 + 100;
                        _Q.FieldValues['MINUTA'] := i2;
                        _Q.FieldValues['CENA'] := cena1;
                        _Q.Post;
                    end;
                end;
            end;
        end;
        if (Internet.Active = FALSE) then
            Internet.Active := TRUE;

        if (Internet.FieldByName('DISCOUNT_PERCENT').DataType = ftInteger) then
        begin
            Internet.Close;
            _Q.SQL.Text := 'alter table internet modify ' +
                ' (DISCOUNT_PERCENT  FLOAT, DISCOUNT_PERCENT_FIRMI FLOAT)';
            _Q.ExecSQL; // .Active:=true;
            _Q.Active := FALSE;
            Internet.Open;
        end;
        if (KARTICHIP.Active = FALSE) then
            KARTICHIP.Active := TRUE;
        if (KARTICHIP.FieldByName('DISCOUNT').DataType = ftInteger) then
        begin
            KARTICHIP.Close;
            QCHIPKARTI.Active := FALSE;
            _Q.SQL.Text := 'alter table KARTICHIP modify (DISCOUNT  FLOAT)';
            _Q.ExecSQL; // .Active:=true;
            _Q.Active := FALSE;
            MainForm.KARTICHIP.Open;
        end;
        if (PLASHTANIA.Active = FALSE) then
            PLASHTANIA.Active := TRUE;
        if (PLASHTANIA.FieldByName('DISCOUNT').DataType in [ftSmallint,
            ftInteger]) then
        begin
            PLASHTANIA.Active := FALSE;
            DayTotal.Active := FALSE;
            QKartiPaid.Active := FALSE;

            Qstatistika.Active := FALSE;
            PlashtaniaTable.Active := FALSE;
            SDELKA.Active := FALSE;

            _Q.SQL.Text :=
                'alter table PLASHTANIA modify (DISCOUNT  FLOAT, SUMABROI CURRENCY)';
            _Q.ExecSQL; // .Active:=true;
            _Q.Active := FALSE;
            PLASHTANIA.Active := TRUE;
            PlashtaniaTable.Active := TRUE;
            DayTotal.Active := TRUE;
            QKartiPaid.Active := TRUE;
            PlashtaniaTable.Active := TRUE;
            SDELKA.Active := TRUE;

        end;
        CeniTable.TableName := 'TABLICA_CENI';
        CeniTable.MasterFields := 'SOLARIUM';
        CeniTable.IndexFieldNames := 'SOLARIUM';
        CeniTable.Active := True;
        KARTIALL.Active := True;
        plashtania.active := true;
        STOKI.Active := True;
        internet.Active := True;
        Table3.Active := False;
        KARTIALL1.Active := False;
        Table3.IndexName := '';
        Table3.MasterFields := '';
        Table3.MasterSource := nil;
        // KARTIALL1.IndexName   :='KlientDet';
        // KARTIALL1.MasterFields:='NOMER';
        // KARTIALL1.MasterSource:=DataSource2;
        Table3.Active := True;
        KARTIALL1.Active := True;
        STOKITE.Active := True;
        SDELKA.Active := True;
        KARTI.Active := True;
        stokispr.Active := True;
        solariumspr.Active := True;
        QKlienti.Active := True;
        personal1.Active := True;

        Planner.Active := True;
        Planner02.Active := true;
        Planner03.Active := True;
        KARTICHIP.Active := true;
        Firmite.Active := True;
        USLUGITE.Active := TRUE;
        if sol1.TableExists('tablica_ceni') then
        begin
            CeniTable.Active := false;
            CeniTable.TableName := 'TABLICA_CENI';
            CeniTable.IndexFieldNames := 'SOLARIUM';
            CeniTable.MasterFields := 'SOLARIUM';
            CeniTable.Active := True;
        end;
        maxday.Active := true;
        maxday.Refresh;
        MinMax.Active := true;
        MinMax.Refresh;
        //     QStatistika.Active    :=true;
        Timer1.Enabled := true;
    end;
end;

procedure config_uart(const n1: short);
var
    Message1: string;
begin
    SetCommState(hDevice, CB_RS232);
    EscapeCommFunction(hDevice, CLRDTR);
    EscapeCommFunction(hDevice, SETRTS);
    GetCommState(hDevice, CB_RS232);
    Message1 := IntToStr(CB_RS232.BaudRate);
    //Application.MessageBox(PChar(Message1), 'Messager', MB_OK);
end;

procedure mode_set();
var
    Macro: string;
    Cmd: array[0..255] of Char;
    PlannerStep: string;
    DemoString: string;
    UseNativeStartStr: string;
begin
    MainIniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
    ComPortName := MainIniFile.ReadString('System', 'ComPort', 'COM20');
    if ComPortName = 'COM20' then
        //this is because KeyExists function is not working
    begin
        MainIniFile.DeleteKey('System', 'ComPort');
        MainIniFile.WriteString('System', 'ComPort', 'COM2');
        MainIniFile.UpdateFile;
    end;
    BaudRate:= StrToInt(MainIniFile.ReadString('System', 'BaudRate', '4200'));
    if BaudRate = 4200 then
        //this is because KeyExists function is not working
    begin
        MainIniFile.DeleteKey('System', 'BaudRate');
        MainIniFile.WriteString('System', 'BaudRate', '1200');
        MainIniFile.UpdateFile;
        BaudRate:= 1200;
    end;
    ComPortName := MainIniFile.ReadString('System', 'ComPort', 'COM2');
    Macro := 'mode ' + ComPortName + ' 1200,n,8,,';
    Macro := 'set_com2.bat ' + ComPortName;
    StrPCopy(Cmd, Macro);
    WinExec(Cmd, SW_SHOW);
    WinExec(PChar('Delotc.bat'), SW_SHOWMINIMIZED);

    PlannerStep := MainIniFile.ReadString('System', 'PlannerStep', 'NoValue');
    if PlannerStep = 'NoValue' then
        //this is because KeyExists function is not working
    begin
        MainIniFile.DeleteKey('System', 'PlannerStep');
        MainIniFile.WriteString('System', 'PlannerStep',
            IntToStr(MainForm.Planner1.Display.DisplayUnit));
        MainIniFile.UpdateFile;
    end;
    MainForm.Planner1.Display.DisplayUnit :=
        StrToInt(MainIniFile.ReadString('System', 'PlannerStep',
        IntToStr(MainForm.Planner1.Display.DisplayUnit)));
    MainForm.Planner2.Display.DisplayUnit :=
        MainForm.Planner1.Display.DisplayUnit;
    MainForm.Planner3.Display.DisplayUnit :=
        MainForm.Planner1.Display.DisplayUnit;

    DemoString := MainIniFile.ReadString('System', 'Demo', 'NoValue');
    if DemoString = 'NoValue' then
        //this is because KeyExists function is not working
    begin
        MainIniFile.DeleteKey('System', 'Demo');
        MainIniFile.WriteString('System', 'Demo', 'False');
        MainIniFile.UpdateFile;
        IsDemo2 := false;
    end
    else if (DemoString = 'True') or (DemoString = 'true') then
        IsDemo2 := true;

    UseNativeStartStr := MainIniFile.ReadString('System', 'UseNativeStart',
        'NoValue');
    if UseNativeStartStr = 'NoValue' then
        //this is because KeyExists function is not working
    begin
        MainIniFile.DeleteKey('System', 'UseNativeStart');
        MainIniFile.WriteString('System', 'UseNativeStart', 'False');
        MainIniFile.UpdateFile;
        UseNativeStart := false;
    end
    else if (UseNativeStartStr = 'True') or (UseNativeStartStr = 'true') then
        UseNativeStart := true;
    TipNaRabotaIndex := MainIniFile.ReadInteger('System', 'TipNaRabotaIndex', 20);
    if TipNaRabotaIndex = 20 then
        //this is because KeyExists function is not working
    begin
      MainIniFile.DeleteKey('System', 'TipNaRabotaIndex');
      MainIniFile.WriteString('System', 'TipNaRabotaIndex', '1');
      MainIniFile.UpdateFile;
      TipNaRabotaIndex := 1;
    end;
end;

procedure initFlash();
var
    AppPath: string;
    FlashName: string;
begin
    AppPath := ExtractFilePath(application.ExeName);
    SetLangText();
end;

procedure HideKlInfo;
begin
    MainForm.Label130.Visible := False;
    MainForm.DBText7.Visible := False;
    MainForm.DBText4.Visible := False;
    MainForm.Label71.visible := False;
    MainForm.Label72.visible := False;
    MainForm.Label156.Visible := False;
    MainForm.VipLabel.Visible := False;
    MainForm.Label158.Visible := False;
    MainForm.BonusLabel.Visible := False;
    MainForm.DBText14.Visible := False;
    MainForm.ADVComboBox1.Visible := False;
    MainForm.ADVComboBox2.Visible := False;
    MainForm.Label72.Visible := False;
    MainForm.Label130.Visible := False;
    MainForm.Label119.Visible := False;
    MainForm.Label127.Visible := False;
    MainForm.Label149.Visible := False;
    MainForm.Label155.Visible := False;
    MainForm.DBText13.Visible := False;
end;

procedure ShowKlInfo;
begin
    MainForm.QklientiAfterRefresh;
    MainForm.Label130.Visible := True;
    MainForm.DBText7.Visible := True;
    MainForm.DBText4.Visible := True;
    MainForm.Label71.visible := True;
    MainForm.Label72.visible := True;
    MainForm.Label156.Visible := True;
    MainForm.Label155.Visible := True;
    MainForm.DBText13.Visible := True;
    MainForm.VipLabel.Visible := True;
    MainForm.Label158.Visible := True;
    MainForm.BonusLabel.Visible := True;
    MainForm.DBText14.Visible := True;
    FillValues1();
end;

procedure init_uart(const n1: short);
var
    counter: integer;
begin
    counter := 0;
    while Counter < 5 do
    begin
        hDevice := CreateFile(
            PChar(ComPortName), // pointer to name of the file
            GENERIC_READ or GENERIC_WRITE, // access (read-write) mode
            FILE_SHARE_READ or FILE_SHARE_WRITE, // share mode
            nil, // pointer to security attributes
            OPEN_EXISTING, // how to create
            0, // file attributes
            0); // handle to file with attributes to copy
        if (hDevice = INVALID_HANDLE_VALUE) then
            Counter := Counter + 1
        else
            Counter := 6; // did we succeed?
    end;
    if (hDevice = INVALID_HANDLE_VALUE) then // did we succeed?
        if not (IsDemoMode) then
        begin
            if (n1 = 0) then
                Exit;
            ComPortName := GetMessage('M3') + ' (' + ComPortName + ')';
            //ComPortName:='Програмата няма достъп до серийния порт ('+ComPortName+ ')';
            Application.MessageBox(PChar(ComPortName), 'error', MB_OK);
            Application.Terminate;
            // possibly call GetLastError() to get a hint what failed
            // and terminate (it is useless to continue if we can’t connect to Direct I/O)

          // For demo mode Section is removed
        end;

    // some more processing...

    CB_RS232.DCBlength := SizeOf(CB_RS232); // sizeof(DCB)
    CB_RS232.BaudRate := BaudRate; //1200; // current baud rate
    CB_RS232.Flags := $31; //$31;
    CB_RS232.wReserved := 0; // not currently used
    CB_RS232.XonLim := 1; // transmit XON threshold
    CB_RS232.XoffLim := 1; // transmit XOFF threshold
    CB_RS232.ByteSize := 8; // number of bits/byte, 4-8
    CB_RS232.Parity := 0; // 0-4=no,odd,even,mark,space
    CB_RS232.StopBits := 1; // 0,1,2 = 1, 1.5, 2
    CB_RS232.XonChar := 'x'; // Tx and Rx XON character
    CB_RS232.XoffChar := 'X'; // Tx and Rx XOFF character
    CB_RS232.ErrorChar := 'E'; // error replacement character

    CB_RS232.EofChar := 'T'; // end of input character
    CB_RS232.EvtChar := 'R'; // received event character
    CB_RS232.wReserved1 := 0; // reserved; do not use

    RS_232_Timeouts.ReadIntervalTimeout := 100;
    RS_232_Timeouts.ReadIntervalTimeout := 100;
    RS_232_Timeouts.ReadTotalTimeoutMultiplier := 100;
    config_uart(1);
    SetCommTimeouts(hDevice, RS_232_Timeouts);

end;

procedure UpdatePageControl(i: byte);
var
    FormatSettings: TFormatSettings;
    buff: string;
begin
    with MainForm do
    begin
        if (AdvPageControl1.ActivePageIndex = 6) then
        begin
            ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
            if FileExists(ImageName) then
                Image18.Picture.LoadFromFile(ImageName)
                    // else Image18.Picture:=Imagepress1.Picture;
        end;
        if (AdvPageControl1.ActivePageIndex = 12) then
        begin
            //   DATA_COMBO_SELECTED:=Date;
                //buff := DateToStr(Date, LocalFormat );
            DBLUCombo1.Text := DateToStrBg(Date);
            DayTotal.Active := False;
            DayTotal.SQL.Text :=
                ' SELECT * FROM Plashtania p LEFT OUTER join STOKI s ON Plashtania.STOKA=STOKI.STOKAKOD' +
                ' WHERE DATA = :DATA_COMBO_SELECTED ';
            if (ProtokolFilterEdit.Text = ' ') then
            begin
                DayTotal.SQL.Text := DayTotal.SQL.Text +
                    ' and SOLARIUM >= 0 ORDER BY :ORDERPARAM DESC';
            end
            else if (ProtokolFilterEdit.Text = '') then
            begin
                DayTotal.SQL.Text := DayTotal.SQL.Text +
                    ' ORDER BY :ORDERPARAM DESC';
            end
            else
            begin
                DayTotal.SQL.Text := DayTotal.SQL.Text +
                    ' and LOWER(STOKAIME) LIKE "%' +
                    AnsiLowerCase(ProtokolFilterEdit.Text) +
                    '%" ORDER BY :ORDERPARAM DESC';
            end;
            DayTotal.ParamByName('DATA_COMBO_SELECTED').AsDate := Date;
            DayTotal.ParamByName('ORDERPARAM').AsString := 'RECORDID';
            DayTotal.Active := True;
            // ReorderSQLDataSet( DayTotal, 'STOKA');
        end;

        if (AdvPageControl1.ActivePageIndex = 1) then
        begin
            SOLARIUMI.RecNo := 1;
            ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
            if i = 0 then
            begin
                if FileExists(ImageName) then
                    Imagesol1.Picture.LoadFromFile(ImageName)
                else
                    Imagesol1.Picture := NulImage.Picture;
                // Image21.Picture.LoadFromFile(ImageName);
                Kabina11.Caption := SOLARIUMI.FieldByName('OPISANIE1').AsString;
                Kabina12.Caption := SOLARIUMI.FieldByName('OPISANIE2').AsString;
            end;
            if not (CabineStatus[0] in [1..3]) then
            begin
                Kabina1minuti.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE3').AsString;
                Kabina1cena.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE4').AsString;
                //Kabina1minuti.Caption:=SOLARIUMI.FieldByName('MIVREME').AsString +' '+GetMessage('M28');// ' минути';
                //Kabina1cena.Caption  :=CurrToStr(SOLARIUMI.FieldByName('CENA').AsVariant * SOLARIUMI.FieldByName('MIVREME').AsVariant)+' '+GetMessage('M29');//' лева';
                CabineChanel[0] := SOLARIUMI.FieldByName('ADDRESS').AsInteger;
            end;
            SOLARIUMI.RecNo := 2;
            if i = 0 then
            begin
                ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
                if FileExists(ImageName) then
                    Imagesol2.Picture.LoadFromFile(ImageName);
                //  else Imagesol2.Picture:=Imagepress1.Picture;
                Kabina21.Caption := SOLARIUMI.FieldByName('OPISANIE1').AsString;
                Kabina22.Caption := SOLARIUMI.FieldByName('OPISANIE2').AsString;
            end;
            if not (CabineStatus[1] in [1..3]) then
            begin
                Kabina2minuti.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE3').AsString;
                Kabina2cena.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE4').AsString;
                //Kabina2minuti.Caption  :=SOLARIUMI.FieldByName('MIVREME').AsString + ' '+GetMessage('M28');//' минути';
                //Kabina2cena.Caption    :=CurrToStr(SOLARIUMI.FieldByName('CENA').AsVariant * SOLARIUMI.FieldByName('MIVREME').AsVariant)+' '+GetMessage('M29');//' лева';
                CabineChanel[1] := SOLARIUMI.FieldByName('ADDRESS').AsInteger;
            end;
            SOLARIUMI.RecNo := 3;
            if i = 0 then
            begin
                ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
                if FileExists(ImageName) then
                    Imagesol3.Picture.LoadFromFile(ImageName);
                // else Imagesol3.Picture:=Imagepress1.Picture;
                Kabina31.Caption := SOLARIUMI.FieldByName('OPISANIE1').AsString;
                Kabina32.Caption := SOLARIUMI.FieldByName('OPISANIE2').AsString;
            end;
            if not (CabineStatus[2] in [1..3]) then
            begin
                Kabina3minuti.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE3').AsString;
                Kabina3cena.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE4').AsString;
                //Kabina3minuti.Caption   :=SOLARIUMI.FieldByName('MIVREME').AsString +' '+GetMessage('M28');// ' минути';
                //Kabina3cena.Caption     :=CurrToStr(SOLARIUMI.FieldByName('CENA').AsVariant * SOLARIUMI.FieldByName('MIVREME').AsVariant)+' '+GetMessage('M29');//' лева';
                CabineChanel[2] := SOLARIUMI.FieldByName('ADDRESS').AsInteger;
            end;

            SOLARIUMI.RecNo := 4;
            if i = 0 then
            begin
                ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
                if FileExists(ImageName) then
                    Imagesol4.Picture.LoadFromFile(ImageName);
                //  else Imagesol4.Picture:=Imagepress1.Picture;
                Kabina41.Caption := SOLARIUMI.FieldByName('OPISANIE1').AsString;
                Kabina42.Caption := SOLARIUMI.FieldByName('OPISANIE2').AsString;
            end;
            if not (CabineStatus[3] in [1..3]) then
            begin
                Kabina4minuti.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE3').AsString;
                Kabina4cena.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE4').AsString;
                //Kabina4minuti.Caption:=SOLARIUMI.FieldByName('MIVREME').AsString + ' '+GetMessage('M28');//' минути';
                //Kabina4cena.Caption  :=CurrToStr(SOLARIUMI.FieldByName('CENA').AsVariant * SOLARIUMI.FieldByName('MIVREME').AsVariant)+' '+GetMessage('M29');//' лева';
                CabineChanel[3] := SOLARIUMI.FieldByName('ADDRESS').AsInteger;
            end;
            SOLARIUMI.RecNo := 5;
            if i = 0 then
            begin
                ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
                if FileExists(ImageName) then
                    Imagesol5.Picture.LoadFromFile(ImageName);
                //  else Imagesol5.Picture:=Imagepress1.Picture;
                Kabina51.Caption := SOLARIUMI.FieldByName('OPISANIE1').AsString;
                Kabina52.Caption := SOLARIUMI.FieldByName('OPISANIE2').AsString;
            end;
            if not (CabineStatus[4] in [1..3]) then
            begin
                Kabina5minuti.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE3').AsString;
                Kabina5cena.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE4').AsString;
                //Kabina5minuti.Caption:=SOLARIUMI.FieldByName('MIVREME').AsString +' '+GetMessage('M28'); //' минути';
                //Kabina5cena.Caption  :=CurrToStr(SOLARIUMI.FieldByName('CENA').AsVariant * SOLARIUMI.FieldByName('MIVREME').AsVariant)+' '+GetMessage('M29');//' лева';
                CabineChanel[4] := SOLARIUMI.FieldByName('ADDRESS').AsInteger;
            end;
            SOLARIUMI.RecNo := 6;
            if i = 0 then
            begin
                ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
                if FileExists(ImageName) then
                    Imagesol6.Picture.LoadFromFile(ImageName);
                //   else Imagesol6.Picture:=Imagepress1.Picture;
                Kabina61.Caption := SOLARIUMI.FieldByName('OPISANIE1').AsString;
                Kabina62.Caption := SOLARIUMI.FieldByName('OPISANIE2').AsString;
            end;
            if not (CabineStatus[5] in [1..3]) then
            begin
                Kabina6minuti.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE3').AsString;
                Kabina6cena.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE4').AsString;
                //Kabina6minuti.Caption:=SOLARIUMI.FieldByName('MIVREME').AsString + ' '+GetMessage('M28');//' минути';
                //Kabina6cena.Caption  :=CurrToStr(SOLARIUMI.FieldByName('CENA').AsVariant * SOLARIUMI.FieldByName('MIVREME').AsVariant)+' '+GetMessage('M29');//' лева';
                CabineChanel[5] := SOLARIUMI.FieldByName('ADDRESS').AsInteger;
            end;
            SOLARIUMI.RecNo := 7;
            if i = 0 then
            begin
                ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
                if FileExists(ImageName) then
                    Imagesol7.Picture.LoadFromFile(ImageName);
                //   else Imagesol6.Picture:=Imagepress1.Picture;
                Kabina71.Caption := SOLARIUMI.FieldByName('OPISANIE1').AsString;
                Kabina72.Caption := SOLARIUMI.FieldByName('OPISANIE2').AsString;
            end;
            if not (CabineStatus[6] in [1..3]) then
            begin
                Kabina7minuti.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE3').AsString;
                Kabina7cena.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE4').AsString;
                //Kabina6minuti.Caption:=SOLARIUMI.FieldByName('MIVREME').AsString + ' '+GetMessage('M28');//' минути';
                //Kabina6cena.Caption  :=CurrToStr(SOLARIUMI.FieldByName('CENA').AsVariant * SOLARIUMI.FieldByName('MIVREME').AsVariant)+' '+GetMessage('M29');//' лева';
                CabineChanel[6] := SOLARIUMI.FieldByName('ADDRESS').AsInteger;
            end;
            SOLARIUMI.RecNo := 8;
            if i = 0 then
            begin
                ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
                if FileExists(ImageName) then
                    Imagesol8.Picture.LoadFromFile(ImageName);
                //   else Imagesol6.Picture:=Imagepress1.Picture;
                Kabina81.Caption := SOLARIUMI.FieldByName('OPISANIE1').AsString;
                Kabina82.Caption := SOLARIUMI.FieldByName('OPISANIE2').AsString;
            end;
            if not (CabineStatus[7] in [1..3]) then
            begin
                Kabina8minuti.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE3').AsString;
                Kabina8cena.Caption :=
                    SOLARIUMI.FieldByName('OPISANIE4').AsString;
                //Kabina6minuti.Caption:=SOLARIUMI.FieldByName('MIVREME').AsString + ' '+GetMessage('M28');//' минути';
                //Kabina6cena.Caption  :=CurrToStr(SOLARIUMI.FieldByName('CENA').AsVariant * SOLARIUMI.FieldByName('MIVREME').AsVariant)+' '+GetMessage('M29');//' лева';
                CabineChanel[7] := SOLARIUMI.FieldByName('ADDRESS').AsInteger;
            end;



        end;
    end;
    Main2.Kabina1minuti.Caption := MainForm.Kabina1minuti.Caption;
    Main2.Kabina1cena.Caption := MainForm.Kabina1cena.Caption;
    Main2.Kabina11.Caption := MainForm.Kabina11.Caption;
    Main2.Kabina12.Caption := MainForm.Kabina12.Caption;

    Main2.Kabina2minuti.Caption := MainForm.Kabina2minuti.Caption;
    Main2.Kabina2cena.Caption := MainForm.Kabina2cena.Caption;
    Main2.Kabina21.Caption := MainForm.Kabina21.Caption;
    Main2.Kabina22.Caption := MainForm.Kabina22.Caption;

    Main2.Kabina3minuti.Caption := MainForm.Kabina3minuti.Caption;
    Main2.Kabina3cena.Caption := MainForm.Kabina3cena.Caption;
    Main2.Kabina31.Caption := MainForm.Kabina31.Caption;
    Main2.Kabina32.Caption := MainForm.Kabina32.Caption;

    Main2.Kabina4minuti.Caption := MainForm.Kabina4minuti.Caption;
    Main2.Kabina4cena.Caption := MainForm.Kabina4cena.Caption;
    Main2.Kabina41.Caption := MainForm.Kabina41.Caption;
    Main2.Kabina42.Caption := MainForm.Kabina42.Caption;

    Main2.Kabina5minuti.Caption := MainForm.Kabina5minuti.Caption;
    Main2.Kabina5cena.Caption := MainForm.Kabina5cena.Caption;
    Main2.Kabina51.Caption := MainForm.Kabina51.Caption;
    Main2.Kabina52.Caption := MainForm.Kabina52.Caption;

    Main2.Kabina6minuti.Caption := MainForm.Kabina6minuti.Caption;
    Main2.Kabina6cena.Caption := MainForm.Kabina6cena.Caption;
    Main2.Kabina61.Caption := MainForm.Kabina61.Caption;
    Main2.Kabina62.Caption := MainForm.Kabina62.Caption;

    Main2.StatusShape1.Brush.Color := MainForm.StatusShape1.Brush.Color;
    Main2.StatusShape1.Visible := MainForm.StatusShape1.Visible;
    Main2.StatusShape2.Brush.Color := MainForm.StatusShape2.Brush.Color;
    Main2.StatusShape2.Visible := MainForm.StatusShape2.Visible;
    Main2.StatusShape3.Brush.Color := MainForm.StatusShape3.Brush.Color;
    Main2.StatusShape3.Visible := MainForm.StatusShape3.Visible;
    Main2.StatusShape4.Brush.Color := MainForm.StatusShape4.Brush.Color;
    Main2.StatusShape4.Visible := MainForm.StatusShape4.Visible;
    Main2.StatusShape5.Brush.Color := MainForm.StatusShape5.Brush.Color;
    Main2.StatusShape5.Visible := MainForm.StatusShape5.Visible;
    Main2.StatusShape6.Brush.Color := MainForm.StatusShape6.Brush.Color;
    Main2.StatusShape6.Visible := MainForm.StatusShape6.Visible;
    // equalscreens();
end;

procedure SendData(DataSent: Byte; Index: Integer; FromTable: Boolean);
var
    IOResult: LongBool;
    Data1: Byte;
    Chanel: Byte;
    i: integer;
    DataSent2: Integer;
begin
    retry := 1;
    MainForm.Timer1.Enabled := False;
    DataSent2 := DataSent;
    DataSent := StrToInt('0x' + IntToStr(DataSent));
    if FromTable then
    begin
        MainForm.SOLARIUMI.RecNo := Index;
        Chanel := MainForm.SOLARIUMI.FieldByName('ADDRESS').AsInteger;
        PreTime := MainForm.SOLARIUMI.FieldByName('PREDVVREME').AsInteger;
        CoolTime := MainForm.SOLARIUMI.FieldByName('OHLAZDANE').AsInteger;
    end
    else
    begin
        Chanel := CabineChanel[Index - 1];
    end;
    if Chanel > 15 then
        IsDemoMode := True
    else
        IsDemoMode := False;
    if IsDemoMode then
    begin
        // For demo moide added following:
        retry := 22;
        SolariumTime[Index - 1].CoolTime := CoolTime;
        SolariumTime[Index - 1].MainTime := DataSent2;
        SolariumTime[Index - 1].Pretime := PreTime;
        //End of demo code added
    end
    else
    begin
        MainForm.Gauge2.Visible := true;
        CheckSum := PreTime + CoolTime - DataSent - 5;
        CheckSum := CheckSum mod 128;
        PurgeComm(hDevice, (PURGE_TXCLEAR or PURGE_RXCLEAR));
        while retry < 20 do
        begin
            for i := 1 to 10 do
                IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
            Data1 := 128 + Chanel * 8 + 2;
            IOResult := WriteFile(hDevice, Data1, 1, IOCount, nil);
            sleep(2); // Set PRE-Time
            IOResult := WriteFile(hDevice, PreTime, 1, IOCount, nil);
            Data1 := 128 + Chanel * 8 + 5;
            sleep(2); // Set main time
            IOResult := WriteFile(hDevice, Data1, 1, IOCount, nil);
            sleep(2);
            IOResult := WriteFile(hDevice, DataSent, 1, IOCount, nil);
            if(BaudRate = 1200) then sleep(2)
            else  sleep(200);//DEBUG 2
            IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
            // get old main time
            Data1 := 128 + Chanel * 8 + 3; //  Set cool time
            IOResult := WriteFile(hDevice, Data1, 1, IOCount, nil);
            sleep(2);
            IOResult := WriteFile(hDevice, CoolTime, 1, IOCount, nil);
            if(BaudRate = 1200) then sleep(4)
            else  sleep(200);//DEBUG 4
            IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
            // Get checksum?
            if IOResult and (IOByte = CheckSum) then
                IOResult := WriteFile(hDevice, CheckSum, 1, IOCount, nil);
            sleep(100);
            Data1 := 128 + Chanel * 8; // Get status command for selected chanel
            IOResult := WriteFile(hDevice, Data1, 1, IOCount, nil);
            if(BaudRate = 1200) then sleep(5)
            else  sleep(200);//DEBUG 5
            IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
            IOByte := IOByte div 64;
            if IOResult and (IOByte <> 0) and
                ((DataSent = 0) or (PreTime > 0) or ((IOByte = 1) and (DataSent
                > 0))) then
            begin
                retry := 22;
            end
            else
                retry := retry + 1;
            sleep(1);
            MainForm.Gauge2.Progress := retry;
        end;
        IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
        IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
        //For Demo mode section is removed
    end;
    MainForm.Timer1.Enabled := True;
end;

procedure ReadStatus();
var
    Data1: Byte;
    NewStatus: Byte;
    Chanel1: Byte;
    SolariumNo: Byte;
    Update: Boolean;
    StrBuff: AnsiString;
    Temp: Integer;
    Temp3: Integer;
begin
    if (MainForm.AdvPageControl1.ActivePageIndex = 1) then
    begin
        SolariumNo := TimerTime1 mod Solariums;
        update := false;
        Chanel1 := CabineChanel[SolariumNo];
        IOByte := 0;
        IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
        // MainForm.Label92.Caption:=IntToHex(IOByte,2);
         //MainForm.Label91.Caption:=IntToStr(SolariumNo)+' '+IntToHex(IOByte,2)+ ' Ch='+ IntToStr(Chanel1);
        if CabineChanel[SolariumNo] > 15 then
            IsDemoMode := True
        else
            IsDemoMode := False;
        if IsDemoMode then
        begin
            // For demo moide added following:

            IOResult := True;
            temp3 := 240 div MainForm.SOLARIUMI.RecordCount;
            if (SolariumTime[SolariumNo].Pretime > 0) then
            begin
                IOByte := 64 + 128 + SolariumTime[SolariumNo].Pretime;
                if (((TimerTime1 - SolariumNo) mod temp3) = 0) then
                    SolariumTime[SolariumNo].Pretime :=
                        SolariumTime[SolariumNo].Pretime - 1;
            end
            else if (SolariumTime[SolariumNo].MainTime > 0) then
            begin
                IOByte := 64 + SolariumTime[SolariumNo].MainTime;
                if (((TimerTime1 - SolariumNo) mod temp3) = 0) then
                    SolariumTime[SolariumNo].MainTime :=
                        SolariumTime[SolariumNo].MainTime - 1;
            end
            else if (SolariumTime[SolariumNo].CoolTime > 0) then
            begin
                IOByte := 128 + SolariumTime[SolariumNo].CoolTime;
                if (((TimerTime1 - SolariumNo) mod temp3) = 0) then
                    SolariumTime[SolariumNo].CoolTime :=
                        SolariumTime[SolariumNo].CoolTime - 1;
            end;
            IOCount := 1;
            //End of demo code added
        end;

        if IOResult then
        begin
            if IOCount = 0 then
                NewStatus := 4 //disconected
            else
                NewStatus := IOByte div 64;

            //   if (NewStatus=0)and (CabineTime[SolariumNo]=0) then SolariumNo:=6;
            if (NewStatus = CabineStatus[SolariumNo]) and (NewStatus <>
                CabineOldStatus[SolariumNo]) then
            begin
                Update := true;
                CabineStatusCounter[solariumNo] := 0;
            end
            else
            begin
                Update := false;
                CabineStatusCounter[solariumNo] :=
                    CabineStatusCounter[solariumNo] + 1;
            end;
            if NewStatus = CabineStatus[SolariumNo] then
                CabineOldStatus[SolariumNo] := CabineStatus[SolariumNo];
            CabineStatus[SolariumNo] := NewStatus;
            CabineTime[SolariumNo] := IOByte - CabineStatus[SolariumNo] * 64;
            StrBuff := IntToHex(CabineTime[SolariumNo], 2);
            if TimerTime1 > 30 then
                if not TryStrToInt(StrBuff, Temp) then
                    CabineTime[SolariumNo] := 0
                else
                    CabineTime[SolariumNo] := Temp;
            if (TimerTime1 > 30) and (TimerTime1 < 50) then
                update := True;
            case CabineOldStatus[SolariumNo] of
                1..3:
                    begin
                        case SolariumNo of //'Остават'       'мин.'
                            0: MainForm.Kabina1minuti.Caption :=
                                GetMessage('M80') + ' ' + IntToStr(CabineTime[0])
                                    +
                                    ' ' + GetMessage('M81');
                            1: MainForm.Kabina2minuti.Caption :=
                                GetMessage('M80') + ' ' + IntToStr(CabineTime[1])
                                    +
                                    ' ' + GetMessage('M81');
                            2: MainForm.Kabina3minuti.Caption :=
                                GetMessage('M80') + ' ' + IntToStr(CabineTime[2])
                                    +
                                    ' ' + GetMessage('M81');
                            3: MainForm.Kabina4minuti.Caption :=
                                GetMessage('M80') + ' ' + IntToStr(CabineTime[3])
                                    +
                                    ' ' + GetMessage('M81');
                            4: MainForm.Kabina5minuti.Caption :=
                                GetMessage('M80') + ' ' + IntToStr(CabineTime[4])
                                    +
                                    ' ' + GetMessage('M81');
                            5: MainForm.Kabina6minuti.Caption :=
                                GetMessage('M80') + ' ' + IntToStr(CabineTime[5])
                                    +
                                    ' ' + GetMessage('M81');
                            6: MainForm.Kabina7minuti.Caption :=
                                GetMessage('M80') + ' ' + IntToStr(CabineTime[6])
                                    +
                                    ' ' + GetMessage('M81');
                            7: MainForm.Kabina8minuti.Caption :=
                                GetMessage('M80') + ' ' + IntToStr(CabineTime[7])
                                    +
                                    ' ' + GetMessage('M81');
                        end;
                        //added for second form
                        case SolariumNo of
                            0: Main2.Kabina1minuti.Caption := GetMessage('M80')
                                +
                                ' ' + IntToStr(CabineTime[0]) + ' ' +
                                    GetMessage('M81');
                            1: Main2.Kabina2minuti.Caption := GetMessage('M80')
                                +
                                ' ' + IntToStr(CabineTime[1]) + ' ' +
                                    GetMessage('M81');
                            2: Main2.Kabina3minuti.Caption := GetMessage('M80')
                                +
                                ' ' + IntToStr(CabineTime[2]) + ' ' +
                                    GetMessage('M81');
                            3: Main2.Kabina4minuti.Caption := GetMessage('M80')
                                +
                                ' ' + IntToStr(CabineTime[3]) + ' ' +
                                    GetMessage('M81');
                            4: Main2.Kabina5minuti.Caption := GetMessage('M80')
                                +
                                ' ' + IntToStr(CabineTime[4]) + ' ' +
                                    GetMessage('M81');
                            5: Main2.Kabina6minuti.Caption := GetMessage('M80')
                                +
                                ' ' + IntToStr(CabineTime[5]) + ' ' +
                                    GetMessage('M81');
                        end;
                        // end added
                        case SolariumNo of
                            0: MainForm.Kabina1Cena.Caption := '';
                            1: MainForm.Kabina2Cena.Caption := '';
                            2: MainForm.Kabina3Cena.Caption := '';
                            3: MainForm.Kabina4Cena.Caption := '';
                            4: MainForm.Kabina5Cena.Caption := '';
                            5: MainForm.Kabina6Cena.Caption := '';
                            6: MainForm.Kabina7Cena.Caption := '';
                            7: MainForm.Kabina8Cena.Caption := '';
                        end;
                    end;
            end;
            case CabineOldStatus[SolariumNo] of
                1:
                    begin
                        if CabineStartTime[SolariumNo] = 0 then
                            CabineStartTime[SolariumNo] := now;
                    end;
                0:
                    begin
                        if CabineStatusCounter[SolariumNo] > 10 then
                            CabineStartTime[SolariumNo] := 0;
                        if (CabineStatusCounter[SolariumNo] > 1000) then
                            CabineSetTime[SolariumNo] := 0;
                    end
            end;
        end
        else
        begin
            MainForm.Label91.Caption := 'ERROR';
            if (hDevice <> INVALID_HANDLE_VALUE) then
            begin
                CloseHandle(hDevice);
            end;
            init_uart(0);
            if (hDevice <> INVALID_HANDLE_VALUE) then
            begin
                MainForm.Label91.Caption := 'протокол';
            end;
        end;
        //Update:=True;

        if (CabineOldStatus[SolariumNo] = 1) and (CabineStatusCounter[SolariumNo]
            > 4) then
            LastTime[SolariumNo] := CabineSetTime[SolariumNo] -
                MinutesBetween(Now, CabineStartTime[SolariumNo]); //working
        {else LastTime[SolariumNo]:=0};
        //  if (CabineStatusCounter[SolariumNo]>10 )and (CabineOldStatus[SolariumNo]=2) then
        //  begin
        //   LastTime[SolariumNo]:=0;
        //  end;
        //  if  (SolariumNo=0) then MainForm.Kabina1Cena.Caption:=IntToStr(LastTime[SolariumNo])+' err:'+IntToStr(CabineErrCounter[SolariumNo]);
        if ((CabineOldStatus[SolariumNo] = 0) or (CabineOldStatus[SolariumNo] =
            2)) and (LastTime[SolariumNo] > 2) then
            CabineErrCounter[SolariumNo] := CabineErrCounter[SolariumNo] + 1
        else
            CabineErrCounter[SolariumNo] := 0;
        if CabineErrCounter[SolariumNo] > 4 then
        begin
            CabineErrCounter[SolariumNo] := 0;
            MainForm.Timer1.Enabled := False;
            StrBuff := '';
            //('Солариум '+IntToStr(SolariumNo+1)+' ненадейно се нулрира по време на работа! Да го заредя ли отново?');
        { if Application.MessageBox(PChar(StrBuff),PChar('Неочакван рестарт'),MB_OKCANCEL)=IDOK then
          begin
           IndexSol:=SolariumNo+1;
           SendCmd(5);
           CabineStartTime[SolariumNo]:=now;
          end
          else
            begin  LastTime[SolariumNo]:=0;
              CabineStartTime[SolariumNo]:=0;
            end;    }
            MainForm.Timer1.Enabled := True;
        end;
        if Update then
        begin
            if CabineOldStatus[SolariumNo] <> 0 then
            begin
                case SolariumNo of
                    0: MainForm.StatusShape1.Brush.Color :=
                        StatusColors[CabineStatus[SolariumNo]];
                    1: MainForm.StatusShape2.Brush.Color :=
                        StatusColors[CabineStatus[SolariumNo]];
                    2: MainForm.StatusShape3.Brush.Color :=
                        StatusColors[CabineStatus[SolariumNo]];
                    3: MainForm.StatusShape4.Brush.Color :=
                        StatusColors[CabineStatus[SolariumNo]];
                    4: MainForm.StatusShape5.Brush.Color :=
                        StatusColors[CabineStatus[SolariumNo]];
                    5: MainForm.StatusShape6.Brush.Color :=
                        StatusColors[CabineStatus[SolariumNo]];
                    6: MainForm.StatusShape7.Brush.Color :=
                        StatusColors[CabineStatus[SolariumNo]];
                    7: MainForm.StatusShape8.Brush.Color :=
                        StatusColors[CabineStatus[SolariumNo]];
                end;
                case SolariumNo of
                    0: MainForm.StatusShape1.Visible := True;
                    1: MainForm.StatusShape2.Visible := True;
                    2: MainForm.StatusShape3.Visible := True;
                    3: MainForm.StatusShape4.Visible := True;
                    4: MainForm.StatusShape5.Visible := True;
                    5: MainForm.StatusShape6.Visible := True;
                    6: MainForm.StatusShape7.Visible := True;
                    7: MainForm.StatusShape8.Visible := True;
                end;
            end
            else
                case SolariumNo of
                    0: MainForm.StatusShape1.Visible := False;
                    1: MainForm.StatusShape2.Visible := False;
                    2: MainForm.StatusShape3.Visible := False;
                    3: MainForm.StatusShape4.Visible := False;
                    4: MainForm.StatusShape5.Visible := False;
                    5: MainForm.StatusShape6.Visible := False;
                    6: MainForm.StatusShape7.Visible := False;
                    7: MainForm.StatusShape8.Visible := False;
                end;
            //     MainForm.StatusShape1.refresh; MainForm.StatusShape2.refresh; MainForm.StatusShape3.refresh;
             //    MainForm.StatusShape4.refresh; MainForm.StatusShape5.refresh; MainForm.StatusShape6.refresh;
            UpdatePageControl(1);
        end;
        //   IOResult:=CancelIO(hDevice);
        SolariumNo := (SolariumNo + 1) mod Solariums;
        if CabineChanel[SolariumNo] > 15 then
            IsDemoMode := True
        else
            IsDemoMode := False;
        if not (IsDemoMode) then
        begin
            IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
            IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
            IOResult := ReadFile(hDevice, IOByte, 1, IOCount, nil);
            SolariumNo := (TimerTime1 + 1) mod Solariums;
            Chanel1 := CabineChanel[SolariumNo];
            Data1 := 128 + Chanel1 * 8; // Get status command for selected chanel
            IOResult := WriteFile(hDevice, Data1, 1, IOCount, nil);
            // Section  Removed for demo!!!!!!

        end;
    end;
end;

procedure SendCmd(CmdNum: byte);
var
    Chanel1: Byte;
    Data1: Byte;
    IOResult: LongBool;
    Chanel: Byte;
begin
    MainForm.Timer1.Enabled := False;
    Chanel1 := CabineChanel[IndexSol - 1];
    MainTime := CabineSetTime[IndexSol - 1];
    if (CmdNum = 1) and (UseNativeStart = true) then // start
    begin
        Chanel := CabineChanel[IndexSol - 1];
        Data1 := 128 + Chanel * 8 + 1; //Start command
        IOResult := WriteFile(hDevice, Data1, 1, IOCount, nil);
        sleep(2); // Validate start
        Data1 := 85;
        IOResult := WriteFile(hDevice, Data1, 1, IOCount, nil);
        // 0x55 to validate start
    end
    else
    begin
        CoolTime := 2;
        case CmdNum of
            1: //start
                begin
                    PreTime := 0;
                end;
            2: //stop
                begin
                    MainTime := 0;
                    PreTime := 0;
                end;
            3:
                begin //test
                    PreTime := 1;
                    MainTime := 1;
                    CabineSetTime[IndexSol - 1] := 1;
                end;
            4:
                begin //pause
                    PreTime := 7;
                end;
            5:
                begin //restore
                    PreTime := 0;
                    MainTime := LastTime[IndexSol - 1];
                end;
        end;
        SendData(MainTime, IndexSol, false);

    end;
    MainForm.Timer1.Enabled := True;
    UpdatePageControl(1);
end;

procedure Backup(show_message: boolean);
var
    CopyStatus: Boolean;
    FileName1: string;
    FileName2: string;
    f1, f2: Tfield;
begin
    try
        MainForm.sol1.FlushBuffers;
    except
    end;
    try
        MainForm.sol1.Close;
    except
    end;
    // if (f1=nil) or (f2=nil) then show_message:=False;
    FileName1 := LeftStr(Application.ExeName, 2) + '\SolarStudio1\data\solarbas.abs';
    FileName2 := LeftStr(Application.ExeName, 2) + '\SolarStudio1\data\solarbas_' + IntToStr(YearOf(Date)) + '_' +
        IntToStr(MonthOf(Date)) + '_' + IntToStr(DayOf(Date)) + '.abs';
    CopyStatus := CopyFIle(PChar(FileName1), PChar(FileName2), False);
    if show_message then
    begin
        Backuped := True;
        if CopyStatus then
            Application.MessageBox(PChar(GetMessage('M4')),
                PChar(GetMessage('M6')), MB_OK)
                // if CopyStatus then Application.MessageBox(PChar('Архивиране на данните... успешно!'),PChar('Архивиране'),MB_OK)
        else
            Application.MessageBox(PChar(GetMessage('M5')),
                PChar(GetMessage('M6')), MB_OK);
        //else  Application.MessageBox(PChar('Архивиране на данните... Грешка!'),PChar('Архивиране'),MB_OK);
    end;

end;

function CheckField1(fieldName: string): TFieldDef;
begin

    try
        result := MainForm.SOLARIUMI.FieldDefs.find(fieldName);
    except
        result := nil;
    end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);

var
    Data1: Byte;
    IOCheck: DWORD;
    dateofd: Extended;
begin

    TimerTime1 := TimerTime1 + 1;
    // Label1.Caption:=IntToStr(TimerTime1);
    if (AdvPageControl1.ActivePageIndex in [3, 15, 18]) then
        SLE4442Timer3();
    if (AdvPageControl1.ActivePageIndex = 1) and (not Backuped) then
    begin
        if (Time > StrToTime('22:15:00')) then
        begin
            Timer1.Enabled := false;
            Backup(true);
            //    Timer1.Enabled:=True;
            OpenTables;
        end;
    end;
    MainForm.dbtext11.DataField := 'LAMPILASTDATE';
    MainForm.dbtext12.DataField := 'LICEVILASTDATE';
    if TimerTime1 = 15 then
    begin
        dateofd := dateof(now);
        Plashtania.First;
        AdvPageControl1.ActivePageIndex := 1;
        UpdatePageControl(0);
        initFlash();
        Main2.Visible := True;
        Main2.Show;
        MainForm.Visible := true;
        MainForm.Show;
        MainForm.SetFocus;
    end;
    if TimerTime1 mod 20 = 18 then
    begin
        dateofd := dateof(now);
        if (dateofd < maxday.FieldValues['maxdata']) or ((dateofd > 40330 + 100)
            and FileExists(Application.ExeName + '.ini')) then
        begin
            Timer1.Enabled := false;
            Application.MessageBox(PChar('Грешка 1024'), PChar('Грешка 1024'));
            Application.Terminate;
        end;
    end;
    if TimerTime < 3 then
    begin

    end;
    if TimerTime1 = 2 then
    begin
        initFlash();
        opentables;
        TimerTime1 := 3;
        // config_uart(1);

        AdvPageControl1.ActivePageIndex := 9;
        SOLARIUMI.First;
        while (not SOLARIUMI.Eof) do
        begin
            if SOLARIUMI.FieldValues['SOLARIUM'] <> SOLARIUMI.RecNo then
            begin
                SOLARIUMI.edit;
                SOLARIUMI.FieldValues['SOLARIUM'] := SOLARIUMI.RecNo;
                SOLARIUMI.Post;
            end;
            SOLARIUMI.Next;
        end;
        SOLARIUMI.First;
        StatusChar[0] := GetMessage('M7');
        // StatusChar[0]:='Изключен';
        StatusChar[1] := GetMessage('M8');
        //StatusChar[1]:='Включен';
    end;
    if (TimerTime1 = 3) then
    begin
        init_uart(1);
    end;
    if (TimerTime1 < 15) and (TimerTime1 > 3) then
    begin
        if TimerTime < 12 then
        begin
            SolariumTime[TimerTime - 3].Pretime := 0;
            SolariumTime[TimerTime - 3].MainTime := 0;
            SolariumTime[TimerTime - 3].CoolTime := 0;
        end;
        ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
        IndexSol := SOLARIUMI.FieldByName('ADDRESS').AsInteger;
        IOResult := ReadFile(hDevice, IOByte, 1, IOCheck, 0);
        Data1 := 128 + IndexSol * 8; // Get status command for selected chanel
        IOResult := WriteFile(hDevice, Data1, 1, IOCount, 0);
        sleep(10);
        IOByte := 0;
        IOResult := ReadFile(hDevice, IOByte, 1, IOCheck, 0);
        if (IOByte div 64) = 0 then
        begin
            Data1 := 131 + IndexSol * 8; // set cooling time for selected chanel
            IOResult := WriteFile(hDevice, Data1, 1, IOCount, 0);
            Data1 := 0; //cooling time =0 just to clerar sub-status
            IOResult := WriteFile(hDevice, Data1, 1, IOCount, 0);
        end;
        if IOCheck > 0 then
            IOCount := 1
        else
            IOCount := 0;

        if ((not SOLARIUMI.Eof)) then
        begin
            case (TimerTime1 - 3) of
                1:
                    begin
                        if FileExists(ImageName) then
                            Image34.Picture.LoadFromFile(ImageName);
                        Label75.Caption := StatusChar[IOCount];
                        No1.Caption :=
                            SOLARIUMI.FieldByName('OPISANIE2').AsString;
                    end;
                2:
                    begin
                        if FileExists(ImageName) then
                            Image35.Picture.LoadFromFile(ImageName);
                        Label76.Caption := StatusChar[IOCount];
                        No2.Caption :=
                            SOLARIUMI.FieldByName('OPISANIE2').AsString;
                    end;
                3:
                    begin
                        if FileExists(ImageName) then
                            Image36.Picture.LoadFromFile(ImageName);
                        Label77.Caption := StatusChar[IOCount];
                        No3.Caption :=
                            SOLARIUMI.FieldByName('OPISANIE2').AsString;
                    end;
                4:
                    begin
                        if FileExists(ImageName) then
                            Image9.Picture.LoadFromFile(ImageName);
                        Label173.Caption := StatusChar[IOCount];
                        No4.Caption :=
                            SOLARIUMI.FieldByName('OPISANIE2').AsString;
                    end;
                5:
                    begin
                        if FileExists(ImageName) then
                            Image37.Picture.LoadFromFile(ImageName);
                        Label78.Caption := StatusChar[IOCount];
                        No5.Caption :=
                            SOLARIUMI.FieldByName('OPISANIE2').AsString;
                    end;
                6:
                    begin
                        if FileExists(ImageName) then
                            Image38.Picture.LoadFromFile(ImageName);
                        Label79.Caption := StatusChar[IOCount];
                        No6.Caption :=
                            SOLARIUMI.FieldByName('OPISANIE2').AsString;
                    end;
                7:
                    begin
                        if FileExists(ImageName) then
                            Image39.Picture.LoadFromFile(ImageName);
                        Label80.Caption := StatusChar[IOCount];
                        No7.Caption :=
                            SOLARIUMI.FieldByName('OPISANIE2').AsString;
                    end;
                8:
                    begin
                        if FileExists(ImageName) then
                            Image13.Picture.LoadFromFile(ImageName);
                        Label176.Caption := StatusChar[IOCount];
                        No8.Caption :=
                            SOLARIUMI.FieldByName('OPISANIE2').AsString;
                    end;
            end;
        end
        else
            ; //Image42.Picture:=Imagepress1.Picture;
        SOLARIUMI.Next;
        Gauge1.Progress := (TimerTime1 - 3) * 14;
        if TimerTime1 = 11 then
            TimerTime1 := 13
    end;

    //case CabineStatus[0] of
    //0:
    //end;
    if (AdvPageControl1.ActivePageIndex = 1) and ((TimerTime1 mod 10) = 9) then
    begin
        KeyBuff := '';
        Edit5.Text := '';
        Edit5.Visible := true;
        Edit5.SetFocus;
        Label91.Visible := (PasswordForm.ModalResult = MROK) or IsDemo2;
        Kabina11.Caption := Main2.Kabina11.Caption;
            //SOLARIUMI.FieldByName('OPISANIE1').AsString;
    end;
    if TimerTime1 = 15 then
    begin
        equalscreens();
        if(BaudRate = 1200) then   Timer1.Interval := 50
        else Timer1.Interval := 350; //DEBUG 50;
    end;
    if (AdvPageControl1.ActivePageIndex = 1) and (TimerTime1 > 15) then
    begin
        ReadStatus;
        //    Label143.Caption:=DateToStr(Date);
        Label144.Caption := TimeToStr(Time);
    end;
    if TimerTime1 > 1000 then
    begin
        TimerTime1 := 501;
    end;
end;

procedure TMainForm.BitBtn4Click(Sender: TObject);
begin
    //  IOByte:=TimerTime1;
    IOByte := 55;
    IOResult := WriteFile(hDevice, IOByte, 1, IOCount, 0);
    Label2.Caption := IntToStr(IOCount) + '=' + BoolToStr(IOResult, True);
    //Label57.Caption:='Baud-'+ IntToStr(CB_RS232.BaudRate)
    //   +'-Flags-'+IntToStr(CB_RS232.Flags)+'-Size-'+IntToStr(CB_RS232.ByteSize)
     //  +'-Parity-'+ IntToStr(CB_RS232.Parity)+'-Stop-'+IntToStr(CB_RS232.StopBits);
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
begin
    while (1 = 1) do
    begin
        IOByte := TimerTime1;
        Mess2 := @Mess1;
        //   POverlaped:=0;
        IOResult := WriteFile(hDevice, IOByte, 1, IOCount, 0);
        Application.ProcessMessages;
    end;
    Label2.Caption := IntToStr(IOCount) + '=' + BoolToStr(IOResult, True);

end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
begin
    Mess1 := 'In=';
    Mess2 := @Mess1;
    IOByte := 0;
    IOResult := ReadFile(hDevice, IOByte, 1, IOCount, 0);
    Label2.Caption := Mess1 + IntToHex(IOByte, 4);
    if IOCount = 0 then
        Label3.Caption := 'No input'
    else
        Label3.Caption := 'Received';
end;

procedure TMainForm.BitBtn5Click(Sender: TObject);
begin
    //Mess1:='COM2: baud=2400 parity=N data=8 stop=1';
    //Mess2:=@Mess1;
    //BuildCommDCB(Mess2,CB_RS232);
     //  Label57.Caption:='Baud-'+ IntToStr(CB_RS232.BaudRate)
     //     +'-Flags-'+IntToStr(CB_RS232.Flags)+'-Size-'+IntToStr(CB_RS232.ByteSize)
     //     +'-Parity-'+ IntToStr(CB_RS232.Parity)+'-Stop-'+IntToStr(CB_RS232.StopBits);
    //Label3.Caption:=ComList;
end;

procedure TMainForm.BitBtn3Click(Sender: TObject);
begin
    //CB_RS232.Flags:= StrToInt( Edit2.Text);
   // config_uart(1);
end;

function ConvertCurr1(Money_var: variant): AnsiString;
var
    Kstring: AnsiString;
    IntPart: Integer;
    DecPart: Integer;
    Money: Real;
begin
    Money := 0;
    if varType(Money_var) <> varNull then
        Money := Money_var;

    Kstring := CurrToStr(Money, LocalFormat);
    { IntPart:=Trunc(Money);
     DecPart:=Trunc(Money*100)-IntPart*100;
     Kstring:=IntToStr(IntPart)+'.'+IntToStr(DecPart) ;}
    if Money < 1000 then
    begin
        if Money < 10 then
            Kstring := '0' + Kstring;
        if AnsiPos('.', Kstring) = 0 then
            Kstring := Kstring + '.00';
        if Length(Kstring) = 4 then
            Kstring := Kstring + '0';
    end
    else if Money > 99999 then
        Kstring := 'OVERFL';
    Kstring := LeftStr(Kstring, 5);
    result := Kstring;
end;

procedure FillValues1();
var
    IsOK: Boolean;
    Temp: Integer;
    _Q4: TABSQuery;
    stoka: Integer;
begin
    //SDELKANOMER:=0;
    with MainForm do
    begin
        PriceCard := -1;
        if(IndexSol > 0) then  SOLARIUMI.RecNo := IndexSol;
        if TimeSet > 99 then
            TimeSet := 99;
        if TimeSet > 9 then
            Label8.Caption := IntToStr(TimeSet) + '.00'
        else
            Label8.Caption := '0' + IntToStr(TimeSet) + '.00';

        if not Q1.Active then
            Q1.Open;

        IsOK := Q1.Locate('SOLARIUM;MINUTA', VarArrayOf([IndexSol, TimeSet]),
            []);
        try
          PriceCash := Q1.FieldValues['CENA'];
        except
          PriceCash := 0;
        end;
        Temp := Q1.RecNo;
        if IsOK then
            PriceCash := PriceCash + 0.0000001;
        if (Qklienti.FieldValues['nomer'] > 0) then
        begin
            _Q4 := TABSQuery.Create(nil);
            _Q4.DatabaseName := 'sol1';
            _Q4.SQL.Text :=
                'SELECT * FROM KLIENTI k join PLASHTANIA p on k.NOMER = p.OTCHIPKARTA where p.STOKA in (select STOKAKOD from stoki where STOKATIP = "K") and p.OTCHIPKARTA = ' +
                IntToStr(MainForm.Qklienti.FieldValues['nomer']) +
                ' order by p.RECORDID desc';
            _Q4.Active := true;
            if (_Q4.RecordCount > 0) then
            begin
                stoka := -_Q4.FieldByName('STOKA').AsInteger;
                _Q4.Active := False;
                _Q4.SQL.Text := 'SELECT * from TABLICA_CENI where SOLARIUM = ' +
                    IntToStr(MainForm.SOLARIUMI.RecNo + 100) + ' and MINUTA = '
                        +
                    IntToStr(stoka);
                _Q4.Active := true;
                if (_Q4.RecordCount > 0) then
                begin
                    try
                      PriceCard := TimeSet * _Q4.FieldByName('CENA').AsVariant;
                    except
                      PriceCard := -1;
                    end;
                end;
            end;
            _Q4.Close;
            _Q4.Free;
        end;
        if (PriceCard = -1) then
        begin
          try
            PriceCard := TimeSet * SOLARIUMI.FieldByName('CENA').AsVariant;
          except
            PriceCard := 0;
          end;
        end;

        { if  (Qklienti.FieldValues['nomer']>0) and
             (Internet.FieldValues['DISCOUNT_PERCENT']>0) and
              ((KARTICHIP.FieldValues['COUNTER']div
               Internet.FieldValues['DISCOUNT_COUNT'])=0) then
               price:=Price - (Price *  Internet.FieldValues['DISCOUNT_PERCENT']/100);
         Price:=Price - (Price *  KARTICHIP.FieldValues['DISCOUNT']/100);
         Discount:= KARTICHIP.FieldValues['DISCOUNT']; }
        Label9.Caption := ConvertCurr1(PriceCash);
        Label9A.Caption := ConvertCurr1(PriceCard);
        Label62.Caption := Label9.Caption;
        PriceCardLabel4.Caption := Label9A.Caption;
        // Label63.Caption:=Label9.Caption;
        // Label64.Caption:='00.00';
    end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
    FillValues1();
end;

procedure TMainForm.Image6Click(Sender: TObject);
var
    T: Integer;
begin
    TimeSet := TimeSet - SOLARIUMI.FieldValues['STAPKA'] *
        SOLARIUMI.FieldValues['KOEFICIENT'];
    if TimeSet < SOLARIUMI.FieldByName('MIVREME').AsInteger then
        TimeSet := SOLARIUMI.FieldByName('MIVREME').AsInteger;
    FillValues1();
end;

procedure TMainForm.Image7Click(Sender: TObject);
var
    T: Integer;
begin
    TimeSet := TimeSet - SOLARIUMI.FieldValues['STAPKA'];
    if TimeSet < SOLARIUMI.FieldByName('MIVREME').AsInteger then
        TimeSet := SOLARIUMI.FieldByName('MIVREME').AsInteger;
    FillValues1();
end;

procedure TMainForm.Image8Click(Sender: TObject);
var
    T: Integer;
begin
    T := TimeSet + SOLARIUMI.FieldValues['STAPKA'];
    if T > SOLARIUMI.FieldValues['VREME'] then
    else
        TimeSet := T;
    FillValues1();
end;

procedure TMainForm.Image9Click(Sender: TObject);
var
    T: Integer;
begin
    T := TimeSet + SOLARIUMI.FieldValues['STAPKA'] *
        SOLARIUMI.FieldValues['KOEFICIENT'];
    if T <= SOLARIUMI.FieldValues['VREME'] then
        TimeSet := T;
    FillValues1();
end;

procedure LocateSolarium;

begin
    with MainForm do
    begin
        AdvPageControl1.ActivePageIndex := 4;
        case IndexSol of
            1: Image20.Picture := Imagesol1.Picture;
            2: Image20.Picture := Imagesol2.Picture;
            3: Image20.Picture := Imagesol3.Picture;
            4: Image20.Picture := Imagesol4.Picture;
            5: Image20.Picture := Imagesol5.Picture;
            6: Image20.Picture := Imagesol6.Picture;
            7: Image20.Picture := Imagesol7.Picture;
            8: Image20.Picture := Imagesol8.Picture;
        end;
        SOLARIUMI.RecNo := IndexSol;
        TimeSet := SOLARIUMI.FieldByName('MIVREME').AsInteger;
        FillValues1();
        if SOLARIUMI.FieldValues['SAOBSHTAVA'] and
            ((SOLARIUMI.FieldValues['LICEVICHAS'] < 0) or
            (SOLARIUMI.FieldValues['LAMPICHAS'] < 0)) then
            Application.MessageBox('Лампите са за смяна!!', 'ПРЕДУПРЕЖДЕНИЕ',
                MB_OK);
        AdvTabSheet5Show(MainForm);
    end;
end;
//-------------------------------------------

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
    ImageForm.ShowModal();
    if ImageForm.ModalResult = mrOK then
    begin
        Image18.Picture.LoadFromFile(ImageName);
        SOLARIUMI.Edit;
        SOLARIUMI.FieldByName('PICTURE').AsString := ImageName;
        SOLARIUMI.Post;
    end;
end;

procedure TMainForm.Label13Click(Sender: TObject);
begin
    // if MainForm.Label21.color=clblack then
    if(PasswordForm.IsMaster = true) then
    begin
        SOLARIUMI.First;
        AdvPageControl1.ActivePageIndex := 8;
    end;
end;

procedure TMainForm.Label31Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 7;
end;

procedure TMainForm.Label33Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 8;
end;

procedure TMainForm.Label40Click(Sender: TObject);
begin
    if(PasswordForm.IsMaster = true) then
    begin
        AdvPageControl1.ActivePageIndex := 6;
    end
end;

procedure TMainForm.Label47Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 8;
end;

procedure TMainForm.Label48Click(Sender: TObject);
begin
    if(PasswordForm.IsMaster = true) then
    begin
        AdvPageControl1.ActivePageIndex := 6;
    end
end;

procedure TMainForm.Label49Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 1;
    UpdatePageControl(0);
end;

procedure TMainForm.Label22Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 1;
    SOLARIUMI.Edit;
    SOLARIUMI.Post;
    SOLARIUMI.Refresh;
    UpdatePageControl(0);
end;

procedure TMainForm.Label10Click(Sender: TObject);
var
    i: Integer;
begin
    AdvPageControl1.ActivePageIndex := 3;
    PaymentOKLabel.Visible := false;
    MainForm.Gauge2.Visible := false;
    PaidCash := 0;
    PaidCard := 0;
    PaidChipCard := 0;
    DiscountPrize := 0;
    VipDiscount := 0;
    CardNomer := 0;
    BonusLabel.Caption := '0';
    ToBePaidCash := 0;
    for i := 0 to SizeOf(PoseshteniaPaid) do
        PoseshteniaPaid[i] := 0;
    PosPaid := 0;
    BroiKartiPaid := 0;
    HideKlInfo;
    UpdatePageControl(1);
end;

procedure TMainForm.CancelButtonClick(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 1;
    MainForm.Timer1.Enabled := true;
    UpdatePageControl(0);
end;

procedure TMainForm.BitBtn6Click(Sender: TObject);
begin
    PasswordForm.ShowModal;
end;

procedure TMainForm.Imagepress1_MouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin

    if (Sender = Imagepress1) or (Sender = ImageSol1) or (Sender = StatusShape1)
        then
        IndexSol := 1;
    if (Sender = Imagepress2) or (Sender = ImageSol2) or (Sender = StatusShape2)
        then
        IndexSol := 2;
    if (Sender = Imagepress3) or (Sender = ImageSol3) or (Sender = StatusShape3)
        then
        IndexSol := 3;
    if (Sender = Imagepress4) or (Sender = ImageSol4) or (Sender = StatusShape4)
        then
        IndexSol := 4;
    if (Sender = Imagepress5) or (Sender = ImageSol5) or (Sender = StatusShape5)
        then
        IndexSol := 5;
    if (Sender = Imagepress6) or (Sender = ImageSol6) or (Sender = StatusShape6)
        then
        IndexSol := 6;
    if (Sender = Imagepress6) or (Sender = ImageSol7) or (Sender = StatusShape7)
        then
        IndexSol := 7;
    if (Sender = Imagepress6) or (Sender = ImageSol8) or (Sender = StatusShape8)
        then
        IndexSol := 8;
    if Button = mbRight then
    begin
        MainForm.Timer1.Enabled := False;
        NotshalterForm.Label1.Caption := 'КАБИНА ' + IntToStr(IndexSol);
        NotshalterForm.ShowModal;
        if (NotshalterForm.ModalResult = mrOk) and (CabineStatus[IndexSol - 1] =
            3) then
            SendCmd(1);
        if NotshalterForm.ModalResult = mrIgnore then
            SendCmd(2);
        if (NotshalterForm.ModalResult = mrAbort) and (CabineStatus[IndexSol - 1]
            = 0) then
            SendCmd(3);
        if (NotshalterForm.ModalResult = mrRetry) and (CabineStatus[IndexSol - 1]
            = 3) then
            SendCmd(4);
    end;
    if Button = mbLeft then
        if CabineStatus[IndexSol - 1] = 0 then
            LocateSolarium;
    MainForm.Timer1.Enabled := true;
end;

procedure TMainForm.Label54Click(Sender: TObject);
begin
    ///ScanForm.ShowModal;
    SOLARIUMI.Edit;
    SOLARIUMI.Append;
    SOLARIUMI.FieldValues['CENA'] := 0.6;
    SOLARIUMI.FieldValues['VREME'] := 5;
    SOLARIUMI.FieldValues['OHLAZDANE'] := 2;
    SOLARIUMI.FieldValues['PREDVVREME'] := 7;
    SOLARIUMI.FieldValues['OPISANIE1'] := 'New Solarium ' +
        IntToStr(SOLARIUMI.RecordCount + 1);
    SOLARIUMI.FieldValues['MIVREME'] := 5;
    SOLARIUMI.FieldValues['SAOBSHTAVA'] := True;
    SOLARIUMI.FieldValues['ADDRESS'] := 0;
    SOLARIUMI.FieldValues['MIVREME'] := 5;
    SOLARIUMI.FieldValues['LICEVICHAS'] := 500;
    SOLARIUMI.FieldValues['LAMPICHAS'] := 500;
    SOLARIUMI.Post;
    Label115.Caption := IntToStr(SOLARIUMI.RecNo);
    Label116.Caption := IntToStr(SOLARIUMI.RecNo);
    Label117.Caption := IntToStr(SOLARIUMI.RecNo);
end;

procedure TMainForm.Label55Click(Sender: TObject);
begin
    if Application.MessageBox(PChar(GetMessage('M9')), '', MB_YESNO) = 6 then
        //if Application. MessageBox('Наистина ли ще изтриете този солариум?', '',MB_YESNO)=6 then
    begin
        SOLARIUMI.Delete;
        SolariumiNastroiki7Show(Sender);
    end;
end;

procedure TMainForm.Image27Click(Sender: TObject);
var i2: integer;
    cena1: currency;
begin
    SOLARIUMI.Next;
    ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
    if FileExists(ImageName) then
        Image16.Picture.LoadFromFile(ImageName);
    Image18.Picture := Image16.Picture;
    Label115.Caption := IntToStr(SOLARIUMI.RecNo);
    Label116.Caption := IntToStr(SOLARIUMI.RecNo);
    Label117.Caption := IntToStr(SOLARIUMI.RecNo);
    if SOLARIUMI.Eof and (SOLARIUMI.RecNo > 2) then
        LMDButton16.Visible := true
    else
        LMDButton16.Visible := false;
    QCeni.Active := False;
    QCeni.SQL.Text := ('select * from TABLICA_CENI where SOLARIUM = ' +
        IntToStr(SOLARIUMI.RecNo + 100));
    QCeni.Active := True;
    if(QCeni.RecordCount < 10)  then
    begin
        cena1 := Solariumi.FieldValues['CENA'];
        for i2 := 0 to 10 do
        begin
           QCeni.Append;
           QCeni.FieldValues['SOLARIUM'] := SOLARIUMI.RecNo + 100;
           QCeni.FieldValues['MINUTA'] := i2;
           QCeni.FieldValues['CENA'] := cena1;
           QCeni.Post;
        end;
    end;
end;

procedure TMainForm.Image26Click(Sender: TObject);
begin
    SOLARIUMI.Prior;
    ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
    if FileExists(ImageName) then
        Image16.Picture.LoadFromFile(ImageName);
    Image18.Picture := Image16.Picture;
    Label115.Caption := IntToStr(SOLARIUMI.RecNo);
    Label116.Caption := IntToStr(SOLARIUMI.RecNo);
    Label117.Caption := IntToStr(SOLARIUMI.RecNo);
    if SOLARIUMI.EOF then
        LMDButton16.Visible := true
    else
        LMDButton16.Visible := false;
    QCeni.Active := False;
    QCeni.SQL.Text := ('select * from TABLICA_CENI where SOLARIUM = ' +
        IntToStr(SOLARIUMI.RecNo + 100));
    QCeni.Active := True;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
    i1, i2: Integer;
    cena1: Real;
begin
    // Do_checkdatabase;

    sol1.DatabaseFileName := LeftStr(Application.ExeName, 2) +
        '\SolarStudio1\data\solarbas.abs';
    OpenTables;
    tempCounter := 0; //********** for debig
    GetLocaleFormatSettings(Languages.LocaleID[0], LocalFormat);
    LocalFormat.DecimalSeparator := '.';
    LocalFormat.ShortDateFormat := 'dd/mm/yyyy';
    LocalFormat.DateSeparator := '/';
    TimerTime1 := 0;
    Timer2Time := 0;
    StatistikaSQL := 'SELECT * FROM PLASHTANIA ';
    QStatistika.SQL.Text := StatistikaSQL;
    Solariums := SOLARIUMI.RecordCount;
    if Solariums > 8 then
        Solariums := 8;
    if Solariums < 2 then
        Solariums := 2;
    ViewByKlient := True;
    //Label1.Caption:='0';
    for i1 := 0 to 16 do
    begin
        CabineStatus[i1] := 0;
        CabineTime[i1] := 0;
        CabinePreTime[i1] := 0;

    end;
    // sol1.DatabaseFileName:='\SolarStudio1\data\solarbas.abs';
    // sol1.Open;
    // OpenTables;
    Backuped := False;
    AdvPageControl1.ActivePageIndex := 0;
    if FileExists('c:\Master.txt') then
    else
    begin
        AdvPageControl1.TabHeight := 1;
        //  AdvPageControl1.Visible:=false;
    end;
    mode_set();
    KeyCount := 0;

    Q1 := TABSQuery.Create(self);
    Q1.DatabaseName := 'sol1';
    Q1.RequestLive := true;

    if not sol1.TableExists('tablica_ceni') then
    begin
        Q1.SQL.Text := 'create table TABLICA_CENI ( SOLARIUM integer default 0, '
            +
            'MINUTA integer default 4, CENA currency default 0, INDEX a1 (SOLARIUM))';
        Q1.ExecSQL; // .Active:=true;
        Q1.Active := False;
    end;
    Q1.SQL.Text := 'select * from TABLICA_CENI';
    Q1.readonly := False;
    Q1.InMemory := false;
    Q1.Active := true;
    Q1.readonly := False;
    if q1.RecordCount < 60 then
    begin
        CENA1 := 0;
        for i1 := 0 to 16 do
        begin
            if i1 < SOLARIUMI.RecordCount - 1 then
                SOLARIUMI.RecNo := i1 + 1;
            cena1 := SOLARIUMI.FieldValues['CENA'];
            begin
                for i2 := 0 to 30 do
                begin
                    Q1.Append;
                    Q1.FieldValues['SOLARIUM'] := i1;
                    Q1.FieldValues['MINUTA'] := i2;
                    Q1.FieldValues['CENA'] := cena1 * i2;
                    Q1.Post;
                    if (i2 < 10) then
                    begin
                        Q1.Append;
                        Q1.FieldValues['SOLARIUM'] := i1 + 100;
                        Q1.FieldValues['MINUTA'] := i2;
                        Q1.FieldValues['CENA'] := cena1;
                        Q1.Post;
                    end;
                end;
            end;
        end;
    end;
    CeniTable.TableName := 'TABLICA_CENI';
    CeniTable.MasterFields := 'SOLARIUM';
    CeniTable.IndexFieldNames := 'SOLARIUM';
    CeniTable.Active := True;

    case Solariums of
        2: set2main;
        3: set3main;
        4: set4main;
        5: set5main;
        6: set6main;
        7: set7main;
        8: set8main;
    end;

    StatusColors[0] := clGray;
    StatusColors[1] := clRed;
    StatusColors[2] := clBlue;
    StatusColors[3] := clYellow;
    StatusColors[4] := clBlack;
    if FileExists((ExtractFilePath(Application.ExeName) + 'language.ini')) then
        InitLang(); // SetLangText();

end;

function TMainForm.FormHelp(Command: Word; Data: Integer;
    var CallHelp: Boolean): Boolean;
var
    S1: string;
    S2: string;
begin
    S1 := AnsiReplaceStr(Application.ExeName, 'exe', 'htm');
    S2 := ExtractFilePath(Application.ExeName);

    //ShellExecute( testform.ParentWindow, PChar('open'),PChar('f:\SolarStudio1\SolarStudio1.htm'),PChar(''),'F:\SolarStudio1', sw_ShowNormal );
    ShellExecute(MainForm.ParentWindow, PChar('open'), PChar(S1), PChar(''),
        PChar(S2), sw_ShowNormal);

end;

procedure TMainForm.RTFLabel1Click(Sender: TObject);
begin
    //Label58.Caption:=RTFLabel1.RichText;
end;

procedure TMainForm.Edit4Change(Sender: TObject);
begin
    //CB_RS232.BaudRate:=StrToInt( Edit4.Text);
end;

procedure TMainForm.AdvPageControl1Change(Sender: TObject);
begin
    UpdatePageControl(0);
end;

procedure TMainForm.PaymentOKLabelClick(Sender: TObject);

var
    TempBalans: Real;
    PosSelected: Byte;
    PosOld: Byte;
    PosNew: Byte;
    KartiBroi: Byte;
    L: Boolean;
    KartaNomer: integer;
    ParvaKartaPlatena: Integer;
    ParvaKartaPlateno: Byte;
    i: Byte;
    _Q: TABSQuery;
    sender1: TObject;
begin
    sender1 := sender;
    if sender1 = sender then
        ;
    if(sol1.InTransaction) then sol1.Commit(true);    
    sol1.StartTransaction;
    _Q := nil;
    _Q := TABSQuery.Create(nil);
    _Q.DatabaseName := 'sol1';
    _Q.ReadOnly := False;
    _Q.RequestLive := True;
    _Q.SQL.SetText(PChar('SELECT * FROM kartichip WHERE KLIENTNOMER = ' +
        IntToStr(CardNomer)));
    _Q.Active := true;
    SetRoundMode(rmNearest);
    PaidCard := Roundto(PaidCard, -2);
    PaidChipCard := Roundto(PaidChipCard, -2);
    PaidCash := Roundto(PaidCash, -2);
    if PriceCash - (PaidCard * (PriceCash / PriceCard) + ToBePaidCash +
        PaidChipCard * (PriceCash / PriceCard)) < 0.03 then
        if PaidChipCard > 0 then
        begin
            SLE4442ReadCardInfo();
            Card.Balans := Card.Balans - (PaidChipCard);
            TempBalans := Card.Balans;
            if (Card.ErrCounter > 2) then
            begin
                Data := card.PIN;
                SLE4442Submit();
                //SLE4442ReadCardInfo();
                //Card.Balans:=TempBalans;
                SLE4442WriteCardInfo();
                SLE4442ReadCardInfo();
                if abs(Card.Balans - TempBalans) > 0.5 then
                begin
                    PaidChipCard := 0;
                    Application.MessageBox(PChar(GetMessage('M10')),
                        PChar('Warning'), MB_OK);
                    //Application.MessageBox(PChar('Картата не може да бъде записана!'),PChar('Warning'),MB_OK);
                    sol1.Rollback;
                    exit;
                end;
            end
            else if CardNomer = 0 then
            begin
                Application.MessageBox(PChar(GetMessage('M11')),
                    PChar('Warning'), MB_OK);
                //Application.MessageBox(PChar('Картата е блокирана!'),PChar('Warning'),MB_OK);
                PaidChipCard := 0;
                sol1.Rollback;
                exit;
            end
            else
        end;
    if(PriceCard = 0) then PriceCard := 0.0001;
    if PriceCash - (PaidCard * (PriceCash / PriceCard) + ToBePaidCash +
        PaidChipCard * (PriceCash / PriceCard)) < 0.02 then
    begin
//        LastTime[(IndexSol - 1)] := TimeSet;
        CabineSetTime[(IndexSol - 1)] := TimeSet;
        SendData(TimeSet, IndexSol, true);
        if Retry > 21 then
        begin
            if not ((Plashtania.Locate('RecordID', CabineRecord[IndexSol], []))
                and (Plashtania.FieldValues['DATA'] = Date)
                and (Plashtania.FieldValues['BROI'] = CabineSetTime[(IndexSol -
                    1)]) and
                (MinutesBetween(StrToTime(Plashtania.FieldValues['CHAS']),
                (Time)) < 5)) then
            begin
                PosSelected := 0;
                ParvaKartaPlatena := 0;
                ParvaKartaPlateno := 0;
                if PaidCard > 0 then
                begin
                    QKarti.First;
                    //    PosSelected:=PoseshteniaPaid[0];
                    i := 0;
                    while (i < SizeOf(PoseshteniaPaid)) and (i <
                        QKarti.RecordCount) do
                    begin
                        if (PoseshteniaPaid[i] > 0) then
                        begin
                            KartaNomer := QKarti.FieldValues['KARTANOMER'];
                            PosOld := QKarti.FieldValues['POSESHTENIA'];
                            QKarti.Edit;
                            QKarti.FieldValues['POSESHTENIA'] := PosOld -
                                PoseshteniaPaid[i];
                            QKarti.Post;
                            if ParvaKartaPlatena = 0 then
                            begin
                                ParvaKartaPlatena := KartaNomer;
                                ParvaKartaPlateno := PoseshteniaPaid[i];
                                PoseshteniaPaid[i] := 0;
                            end;
                        end;
                        QKarti.Next;
                        i := i + 1;
                    end;
                end;
                KartiBroi := QKarti.RecordCount;
                Label149.Caption := IntToStr(KartiBroi);
                Plashtania.ReadOnly := False;
                Plashtania.Edit;
                Plashtania.Append;
                Plashtania.FieldValues['SOLARIUM'] := IndexSol;
                //     if PaidCash >0 then
                Plashtania.FieldValues['SUMABROI'] := PaidCash;
                Plashtania.FieldValues['BROI'] := TimeSet;
                Plashtania.FieldValues['CHAS'] := TimeToStr(Time);
                Plashtania.FieldValues['DATA'] := Date;
                //     if (PaidCash>0) and (VipDiscount+DiscountPrize>0) then
                Plashtania.FieldValues['DISCOUNT'] := VipDiscount +
                    DiscountPrize;
                Plashtania.FieldValues['CENA'] := PriceCash;
                if (_Q.RecordCount > 0) and (not (IsChipCard)) and (CardNomer >
                    0) then
                begin
                    _Q.Edit;
                    _Q.FieldValues['SUMA'] := _Q.FieldValues['SUMA'] -
                        (PaidChipCard); //-(PaidChipCard*DiscountPrize/100));
                    _Q.Post;
                end
                else if (PaidChipCard > 0) and not IsChipCard then
                begin
                    Application.MessageBox(PChar('Неуспешно плащане с карта. Поставете отново картата!'), PChar('Warning'), MB_OK);
                    //Application.MessageBox(PChar('Картата е блокирана!'),PChar('Warning'),MB_OK);
                    PaidChipCard := 0;
                    sol1.Rollback;
                    exit;
                end;
                if (PaidCard > 0) and AdvComboBox2.Visible then
                begin
                    Plashtania.FieldValues['OTKARTA'] := ParvaKartaPlatena;
                    Plashtania.FieldValues['POSESHTENIA'] := ParvaKartaPlateno;
                end;
                if (PaidChipCard > 0) then
                begin
                    Plashtania.FieldValues['OTCHIPKARTA'] := Card.ClientNomer;
                    // Temporary Value
                    Plashtania.FieldValues['KARTASUMA'] := PaidChipCard;
                    Plashtania.FieldValues['STUDIOCODE'] := Card.StudioNomer;
                    Plashtania.FieldValues['KLIENTNOMER'] :=
                        QKlienti.FieldValues['nomer2'];
                end
                else if (CardNomer > 0) then
                begin
                    Plashtania.FieldValues['OTCHIPKARTA'] := CardNomer;
                    Plashtania.FieldValues['KLIENTNOMER'] :=
                        QKlienti.FieldValues['nomer2'];
                end;
                Plashtania.Post;
                if not _Q.IsEmpty and (PaidCash > 0) then
                begin
                    _Q.Edit;
                    _Q.FieldValues['COUNTER'] := KARTICHIP.FieldValues['COUNTER']
                        + 1;
                    _Q.Post;
                end
                else
                begin
                    //  Application.MessageBox(PChar('Неуспешно увеличаване на брояча на картата!'),PChar('Warning'),MB_OK);
                end;
                CabineRecord[IndexSol] :=
                    Plashtania.FieldByName('RECORDID').AsInteger;
                if (BroiKartiPaid > 1) and AdvComboBox2.Visible then
                begin
                    i := 0;
                    QKarti.First;
                    while (i < KartiBroi) and (i < SizeOf(PoseshteniaPaid)) do
                    begin
                        if PoseshteniaPaid[i] > 0 then
                        begin
                            Plashtania.Append;
                            Plashtania.FieldValues['SOLARIUM'] := IndexSol;
                            Plashtania.FieldValues['CHAS'] := TimeToStr(Time);
                            Plashtania.FieldValues['DATA'] := Date;
                            Plashtania.FieldValues['OTKARTA'] :=
                                QKarti.FieldValues['KARTANOMER'];
                            Plashtania.FieldValues['POSESHTENIA'] :=
                                PoseshteniaPaid[i];
                            Plashtania.Post;
                        end;
                        i := i + 1;
                        QKarti.Next;
                    end;
                end;
                SOLARIUMI.Edit;
                SOLARIUMI.FieldValues['LAMPICHAS'] :=
                    SOLARIUMI.FieldValues['LAMPICHAS'] - (TimeSet / 60);
                SOLARIUMI.FieldValues['LICEVICHAS'] :=
                    SOLARIUMI.FieldValues['LICEVICHAS'] - (TimeSet / 60);
                SOLARIUMI.Post;
            end;
            AdvPageControl1.ActivePageIndex := 1;
            UpdatePageControl(1);
        end
        else
        begin
            LastTime[(IndexSol - 1)] := 0;
            CabineSetTime[(IndexSol - 1)] := 0;
            if PaidChipCard > 0 then
            begin
                Card.Balans := Card.Balans + PaidChipCard;
                SLE4442WriteCardInfo();
                SLE4442ReadCardInfo();
            end;
            SendCmd(2); //Stop
            Application.MessageBox(PChar(GetMessage('M12')),
                PChar(GetMessage('M13')), MB_OK);
            //Application.MessageBox('Солариума не се стартира!', 'ГРЕШКА', MB_OK);
            sol1.Rollback;
            exit;
        end;
    end;
    sol1.Commit(TRUE);
    maxday.Active := false;
    maxday.Active := true;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
var
    len: integer;
begin
    if (AdvPageControl1.ActivePageIndex in [18, 15, 3, 1]) then
    begin
        if (Key = #10) or (Key = #13) then
        begin
            LMDMemo1.Lines.Add(KeyBuff);
            Key := #0;
            if (rightstr(KeyBuff, 1) = '?') then //This is card number entry
            begin
                try
                    len := Length(KeyBuff);
                    CardNomer := StrToInt(rightstr(leftstr(KeyBuff, len - 1), len
                        - 1));
                    Timer3.Enabled := true;
                except;
                end;
            end
            else if (Length(BarCodReaderBuff) > 5) then
            begin
                try
                    CardNomer := StrToInt(Rightstr(BarCodReaderBuff, 9));
                    if (AdvPageControl1.ActivePageIndex = 1) then
                    begin
                        AdvPageControl1.ActivePageIndex := 18;
                        AddStokaButtonClick(2);
                    end;
                    //  label25.Caption:=IntToStr(CardNomer);
                    Timer3.Enabled := true;
                except;
                end;
            end
            else
                keyBuff := '';
            //SLE4442ShowCardInPaiment();
        end

        else
        begin
            KeyBuff := KeyBuff + Key;
            if Timer6.Enabled then
            begin
                BarCodReaderBuff := BarCodReaderBuff + Key;
                Timer6.Enabled := false;
                Timer6.Enabled := true;
            end
            else
            begin
                BarCodReaderBuff := '';
                Timer6.Enabled := true;
            end;
        end;
        if (leftstr(KeyBuff, 1) = '%') or (leftstr(KeyBuff, 1) = '+') or
            (leftstr(KeyBuff, 1) = ';') then
            key := #0;
    end;
    if (AdvPageControl1.ActivePageIndex = 1) then
    begin
        if Key = #13 then
        begin
            Key := #0;
            { move focus to next control in tab order. }
            Perform(wm_NextDlgCtl, 0, 0);
        end;
        TimerTime1 := TimerTime1 - (TimerTime1 mod 10);
        //KeyBuff:=KeyBuff+Key;
        Kabina11.Caption := KeyBuff;
        if KeyBuff = '1234' then
        begin
            if PasswordForm.visible = true then
                PasswordForm.visible := false;
            PasswordForm.ShowModal;
            if PasswordForm.ModalResult = mrOK then
            begin
                AdvPageControl1.ActivePageIndex := 5;
                if( PasswordForm.IsMaster = true) then
                begin
                    Label21.color := clBlack;
                    Label17.color := clBlack;
                    Label23.color := clBlack;
//                    Label14.color := clBlack;
                    Label13.color := clBlack;
                    Label16.color := clBlack;
                end
                else
                begin
                    Label21.color := clGray;
                    Label17.color := clGray;
                    Label23.color := clGray;
                    Label13.color := clGray;
//                    Label14.color := clGray;
                    Label16.color := clGray;
                end;
            end
            else
                UpdatePageControl(1);
            KeyBuff := '';
        end;
    end;

end;

procedure TMainForm.Label14Click(Sender: TObject);
begin
    // if MainForm.Label21.color=clblack then
    begin

        Plashtania.First;
        PlannerMaskDatePicker1.Date := Plashtania.FieldValues['data'];
        Plashtania.Last;
        PlannerMaskDatePicker2.Date := Plashtania.FieldValues['data'];
        AdvPageControl1.ActivePageIndex := 11;
    end;
end;

procedure TMainForm.Label68Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 1;
    UpdatePageControl(0);
end;

procedure TMainForm.Label91Click(Sender: TObject);
begin
    Table3.Active := True;

    AdvPageControl1.ActivePageIndex := 12;
    DayTotal.Active := false;
    DayTotal.Active := true;
    UpdatePageControl(1);
    Timer4.Enabled := True;
    ReorderSQLDataSet(DayTotal, 'CHAS');
    ReorderSQLDataSet(DayTotal, 'CHAS');
end;

procedure TMainForm.Label92Click(Sender: TObject);
begin
    Table3.Active := False;
    KARTIALL1.Active := False;
    Table3.IndexName := '';
    Table3.MasterFields := '';
    Table3.MasterSource := nil;
    KARTIALL1.IndexName := 'KlientDet';
    KARTIALL1.MasterFields := 'NOMER';
    KARTIALL1.MasterSource := DataSource2;
    Table3.Active := True;
    KARTIALL1.Active := True;
    AdvPageControl1.ActivePageIndex := 17;
end;

procedure TMainForm.Label94Click(Sender: TObject);
begin

    Form1.QuickRep1.Preview;
    //  QKartiPaid.Active:=False;
end;

procedure TMainForm.SettingsEndButtonClick(Sender: TObject);

begin
    AdvPageControl1.ActivePageIndex := 5;
    if STOKITE.State in [dsEdit, dsInsert] then
        STOKITE.Post;
    if Internet.State in [dsEdit, dsInsert] then
        Internet.Post;
    if Solariumi.State in [dsEdit, dsInsert] then
        Solariumi.Post;
    if STOKITE_SKLAD.State in [dsEdit, dsInsert] then
        STOKITE_SKLAD.Post;
    if TipNaRabotaCombo.Tag = 1 then // Changed
    begin
      TipNaRabotaCombo.Tag := 0;
      MainIniFile.DeleteKey('System', 'TipNaRabotaIndex');
      MainIniFile.WriteInteger('System', 'TipNaRabotaIndex', TipNaRabotaCombo.ItemIndex);
      MainIniFile.UpdateFile;
      TipNaRabotaIndex := TipNaRabotaCombo.ItemIndex;
    end;
    
end;

procedure TMainForm.Label30Click(Sender: TObject);
begin
    Form2.QuickRep2.Preview;
end;

procedure TMainForm.Label23Click(Sender: TObject);
begin
    //if MainForm.Label21.color = clblack then
    if(PasswordForm.IsMaster = true) then
        AdvPageControl1.ActivePageIndex := 14;
end;

procedure TMainForm.DBLUCombo11Change(Sender: TObject);
begin
    DayTotal.ParamByName('DATA_COMBO_SELECTED').AsDate :=
        StrToDate(AnsiReplaceText(DBLUCombo1.Text, ' г.', ''));
    DayTotal.Active := False;
    DayTotal.Active := True;
end;

procedure TMainForm.DBText7Change(Sender: TObject);
begin
    Qklienti.RecNo := DBText7.ItemIndex + 1;
end;

procedure TMainForm.DBText7DropDown(Sender: TObject);
begin
    Qklienti.ReadOnly := False;
end;

procedure TMainForm.DobaviStokaBtnClick(Sender: TObject);
begin
    case StokiteTab.ActivePageIndex of
        0: KartiAsStokiMenu.Popup(DobaviStokaBtn.Left +
                Round(DobaviStokaBtn.Width / 2),
                DobaviStokaBtn.Top + Round(DobaviStokaBtn.Height / 2));
        1: AddStokaButtonClick(3);

        2: AddStokaButtonClick(4);
    end;

end;

procedure TMainForm.PrintDayReportClick(Sender: TObject);
begin

    Form3.QuickRep3.Preview;
end;

procedure TMainForm.ProtokolFilterEditChange(Sender: TObject);
begin
    DayTotal.Active := False;
    DayTotal.SQL.Text :=
        ' SELECT * FROM Plashtania p LEFT OUTER join STOKI s ON Plashtania.STOKA=STOKI.STOKAKOD' +
        ' WHERE DATA = :DATA_COMBO_SELECTED ';
    if (ProtokolFilterEdit.Text = ' ') then
    begin
        DayTotal.SQL.Text := DayTotal.SQL.Text +
            ' and SOLARIUM >= 0 ORDER BY :ORDERPARAM DESC';
    end
    else if (ProtokolFilterEdit.Text <> '') then
    begin
        DayTotal.SQL.Text := DayTotal.SQL.Text + ' and LOWER(STOKAIME) LIKE "%'
            + AnsiLowerCase(ProtokolFilterEdit.Text) +
            '%" ORDER BY :ORDERPARAM DESC';
    end
    else
    begin
        DayTotal.SQL.Text := DayTotal.SQL.Text + ' ORDER BY :ORDERPARAM DESC';
    end;

    DayTotal.ParamByName('DATA_COMBO_SELECTED').AsString := DBLUCombo1.Text;

    DayTotal.ParamByName('ORDERPARAM').AsString := 'RECORDID';
    DayTotal.Active := True;
end;

procedure TMainForm.QklientiAfterRefresh;
var
    i, j: Integer;
begin

    if (TimerTime1 > 10) and ((AdvPageControl1.ActivePageIndex = 3) or
        (AdvPageControl1.ActivePageIndex = 15)) then
    begin
        DBText7.Clear;
        i := Qklienti.RecNo;
        Qklienti.First;
        while not Qklienti.Eof and (not QKlienti.IsEmpty) do
        begin
            try
                DBText7.Items.Add(Qklienti.FieldValues['IME']);
            except
                DBText7.Items.Add('?');
            end;
            QKlienti.Next;
        end;
        //     QKlienti.RecNo:=i;
        QKlienti.first;
        ComboBox2.Items.Assign(DBText7.Items);
        ComboBox2.ItemIndex := QKlienti.RecNo - 1;
        DBText7.ItemIndex := QKlienti.RecNo - 1;

    end;

end;

procedure TMainForm.Label110Click(Sender: TObject);
begin
    Plashtania.Last();
    // MinMax.active:=false;
    // MinMax.SQL.Text:='Select max(RECORDID) from plashtania';
    // MinMax.active:=true;
    // if MinMax.Fields.Count>0 then
    // SDELKANOMER:=MinMax.Fields.Fields[0].AsInteger;
    if (Plashtania.RecNo > 0) then
        SDELKANOMER := Plashtania.FieldValues['RECORDID']
    else
        SDELKANOMER := 0;
    sol1.FlushBuffers;
    PaidCash := 0;
    PaidCard := 0;
    PaidChipCard := 0;
    DiscountPrize := 0;
    VipDiscount := 0;
    CardNomer := 0;
    Card.Balans := 0;
    Card.ClientNomer := 0;
    Card.CardNomer := 0;
    QKlienti.Active := False;
    QKlienti.SQL.SetText(PChar('SELECT * FROM klienti where nomer = 999990 ORDER BY IME DESC'));
    CardNomer := 0;
    QKlienti.Active := True;
    if(sol1.InTransaction) then sol1.Commit(true);
    sol1.StartTransaction;
    AdvPageControl1.ActivePageIndex := 15;
    USLUGITE.Active := False;
    USLUGITE.Active := TRUE;
    STOKITE.Active := false;
    STOKITE.Active := True;
    SDELKA.active := false;
    SDELKA.ParamByName('SDELKANOMER').AsInteger := SDELKANOMER;
    SDELKA.active := true;
    KasaGrid.DataSource := DataSource7;
    Suma := 0;
    SumaCard := 0;
    FIRMITE.First;
end;

procedure TMainForm.Page23PrintBtnClick(Sender: TObject);
begin
    Planner1.Print;
end;

procedure TMainForm.PayCashButtonClick(Sender: TObject);
var
    DecPart: integer;
begin
    ToBePaidCash := PriceCash - (PaidCard * (PriceCash / PriceCard) +
        PaidChipCard * (PriceCash / PriceCard));
    if VipDiscount + DiscountPrize < 100 then
        PaidCash := ToBePaidCash - (ToBePaidCash * VipDiscount / 100) -
            (ToBePaidCash * DiscountPrize / 100)
    else
        PaidCash := 0;

    Edit1.Text := ConvertCurr1(PaidCash);
    DecPart := Trunc(PaidCash * 100);
    PreCalcPaiment(nil);

end;

procedure TMainForm.b2Click(Sender: TObject);
begin
    IOResult := CancelIO(hDevice);
end;

procedure TMainForm.Label120Click(Sender: TObject);
begin
    Karti.Active := False;
    Karti.SQL.SetText(PChar('SELECT * FROM STOKI WHERE STOKAKOD < 0 AND POSESHTENIA > 0 AND SUMA = 0'));
    Karti.Active := True;
    RefillForm.ShowModal;
    QKarti.Active := False;
    QKarti.SQL.SetText(PChar('SELECT * FROM kartiall WHERE klientdetail = ' +
        IntToStr2(QKlienti.FieldValues['NOMER']) +
        ' ORDER BY KARTANOMER DESC'));
    QKarti.Active := True;
    //RefillForm.DBEdit2.ReadOnly:=true;
end;

procedure TMainForm.AddStokaButtonClick(TipStoka: Integer);
var
    maxcode: integer;
    mincode: integer;
    code: integer;
    L: Boolean;
    _Q: TABSQuery;
begin

    _Q := TABSQuery.Create(nil);
    _Q.DatabaseName := 'sol1';
    case tipstoka of

        0: //Депозит
            begin
                _Q.SQL.SetText(PChar('select * from STOKI Where STOKATIP = "D"'));
                _Q.Open;
                if _Q.IsEmpty then
                begin
                    if not STOKI.Locate('STOKAKOD', -1, []) then
                        STOKI.Append;
                    //   STOKI.FieldValues['STOKAIME']:='Депозит за карта от '+ IntToStr(Round(Suma))+' лв. ';
          //            STOKI.FieldValues['STOKAIME']:=GetMessage('M68')+' '+ IntToStr(Round(Suma))+' '+GetMessage('M20');
                    STOKI.FieldValues['STOKACENA'] := 0;
                    STOKI.FieldValues['STOKANASKLAD'] := 0;
                    STOKI.FieldValues['POSESHTENIA'] := -1;
                    STOKI.FieldValues['SUMA'] := Suma;
                    STOKI.FieldValues['STOKAKOD'] := -1;
                    STOKI.FieldValues['STOKAIME'] := 'Депозит за карта';
                    STOKI.FieldValues['STOKACENA'] := 0;
                    STOKI.FieldValues['STOKANASKLAD'] := 0;
                    STOKI.FieldValues['STOKATIP'] := 'D';
                    STOKI.Post;
                    KARTI.Refresh;
                    KARTI.Locate('STOKAKOD', maxcode, []);
                end
                else
                    Application.MessageBox(PChar('Вече има създаден депозит'),
                        PChar(''));
            end;
        1: //Клубни Карти
            begin
                _Q.SQL.SetText(PChar('select Min(STOKAKOD) as min1 from STOKI'));
                _Q.Open;
                try
                    mincode := _Q.FieldValues['min1']
                except
                    mincode := -1;
                end;
                if mincode > -1 then
                    mincode := -1;
                STOKI.Append;
                STOKI.FieldValues['STOKAKOD'] := mincode - 1;
                STOKI.FieldValues['STOKAIME'] := 'Нова Клубна карта' +
                    IntTostr(mincode - 1);
                STOKI.FieldValues['STOKACENA'] := 0;
                STOKI.FieldValues['STOKANASKLAD'] := 0;
                STOKI.FieldValues['STOKATIP'] := 'K';
                STOKI.Post;
                KARTI.Refresh;
                KARTI.Locate('STOKAKOD', maxcode, []);
            end;
        2: //Чип Карти
            begin
                _Q.SQL.SetText(PChar('select Min(STOKAKOD) as min1 from STOKI'));
                _Q.Open;
                try
                    mincode := _Q.FieldValues['min1']
                except
                    mincode := -1;
                end;
                if mincode > -1 then
                    mincode := -1;
                STOKI.Append;
                STOKI.FieldValues['STOKAKOD'] := mincode - 1;
                STOKI.FieldValues['STOKAIME'] := 'Нова Чип Карта' +
                    IntTostr(mincode - 1);
                STOKI.FieldValues['STOKACENA'] := 0;
                STOKI.FieldValues['STOKANASKLAD'] := 0;
                STOKI.FieldValues['STOKATIP'] := 'C';
                STOKI.Post;
                KARTI.Refresh;
                KARTI.Locate('STOKAKOD', maxcode, []);
            end;
        3: //Козметика
            begin
                _Q.SQL.SetText(PChar('select Max(STOKAKOD) as max1 from STOKI'));
                _Q.Open;
                try
                    maxcode := _Q.FieldValues['max1']
                except
                    maxcode := 0;
                end;
                if maxcode < 0 then
                    maxcode := 0;
                STOKI.Append;
                STOKI.FieldValues['STOKAKOD'] := maxcode + 1;
                STOKI.FieldValues['STOKAIME'] := 'Нова Козметика №' +
                    IntTostr(maxcode + 1);
                STOKI.FieldValues['STOKACENA'] := 0;
                STOKI.FieldValues['STOKANASKLAD'] := 0;
                STOKI.FieldValues['STOKATIP'] := 'S';
                STOKI.Post;
                STOKITE.Active := False;
                STOKITE.Active := True;
                STOKITE.Locate('STOKAKOD', maxcode, []);
                STOKITE_SKLAD.Active := False;
                STOKITE_SKLAD.Active := True;
                STOKITE_SKLAD.Locate('STOKAKOD', maxcode, []);
            end;
        4: //Услуги
            begin
                _Q.SQL.SetText(PChar('select Max(STOKAKOD) as  max1 from STOKI'));
                _Q.Open;
                try
                    maxcode := _Q.FieldValues['max1']
                except
                    maxcode := 0;
                end;
                if maxcode < 0 then
                    maxcode := 0;
                STOKI.Append;
                STOKI.FieldValues['STOKAKOD'] := maxcode + 1;
                STOKI.FieldValues['STOKAIME'] := 'Нова Услуга №' +
                    IntTostr(maxcode + 1);
                STOKI.FieldValues['STOKACENA'] := 0;
                STOKI.FieldValues['STOKANASKLAD'] := 0;
                STOKI.FieldValues['STOKATIP'] := 'U';
                STOKI.Post;
                USLUGITE.Refresh;
                USLUGITE.Locate('STOKAKOD', maxcode, []);
            end;
        5: //Операция изтриване на клиент
            begin
                STOKI.Append;
                STOKI.FieldValues['STOKAKOD'] := 0;
                STOKI.FieldValues['STOKAIME'] := 'Изтриване на клиент';
                STOKI.FieldValues['STOKACENA'] := 0;
                STOKI.FieldValues['STOKANASKLAD'] := 0;
                STOKI.FieldValues['STOKATIP'] := 'S';
                STOKI.Post;
            end;
    end;
    _Q.Free;
end;

procedure TMainForm.IztriiStokaBtnClick(Sender: TObject);
var
    Message1: string;
    StokaKod: Integer;

begin
    case StokiteTab.ActivePageIndex of
        0: StokaKod := KARTI.FieldValues['STOKAKOD'];
        1: StokaKod := STOKITE_SKLAD.FieldValues['STOKAKOD'];
        2: StokaKod := USLUGITE.FieldValues['STOKAKOD'];
    end;
    if STOKI.Modified then
    begin
        Application.MessageBox(PChar('Внимание!'),
            PChar('Записът се редактира и не може да бъде изтрит!'), MB_OK);
        exit; //-->
    end;

    STOKI.Locate('STOKAKOD', StokaKod, []);
    try
        Message1 := (GetMessage('M16') + STOKI.FieldValues['STOKAIME']);
    except
        Message1 := (GetMessage('M16'));
    end;
    //Message1:=('Наистина ли искате да изтриете '+KARTI.FieldValues['STOKAIME']);
    if Application.MessageBox(PChar(Message1), PChar(GetMessage('M17')),
        MB_YESNO) = 6 then
        //if Application.MessageBox(PChar(Message1),'ПОТВЪРДЕТЕ ИЗТРИВАНЕТО!',MB_YESNO)=6 then
    begin
        STOKI.Delete;
        STOKI.Refresh;
        STOKITE.refresh;
        STOKITE_SKLAD.Active := False;
        STOKITE_SKLAD.Active := True;
        KARTI.Refresh;
        USLUGITE.Refresh;
    end;
end;

procedure TMainForm.KasaGridTitleButtonClick(Sender: TObject;
    AFieldName: string);
begin
    ReorderSQLDataSet(STOKITE, AFieldName);
    ReorderSQLDataSet(USLUGITE, AFieldName);
end;

procedure TMainForm.wwDBGrid11TitleButtonClick(Sender: TObject;
    AFieldName: string);
begin
    ReorderSQLDataSet(USLUGITE, AFieldName);
end;

procedure TMainForm.wwDBGrid12RowChanged(Sender: TObject);
var
    a1: Integer; //for debug only
    a2: string;
begin
    if (Sender = nil) or (AdvPageControl1.ActivePageIndex = 2) then
    begin
        if Firmite.State in [dsInsert] then
        begin
            QKLIENTI.Active := False;
            QKLIENTI.SQL.SetText(PChar('select * from KLIENTI where FIRMA = "999999' +
                '" order by IME'));
            QKLIENTI.ACTIVE := TRUE;
        end
        else if AnsiPos('"' + IntToStr(FIRMITE.FieldValues['NOMER']) + '"',
            QKLIENTI.SQL.Text) < 1 then
        begin
            QKLIENTI.Active := False;
            QKLIENTI.SQL.SetText(PChar('select * from KLIENTI where FIRMA = "' +
                IntToStr(FIRMITE.FieldValues['NOMER']) + '" order by IME'));
            QKLIENTI.ACTIVE := TRUE;
        end;
        a1 := wwDBGrid12.GetActiveRow;
        A2 := IntToStr(a1);
    end;
end;

procedure TMainForm.wwDBGrid2TitleButtonClick(Sender: TObject;
    AFieldName: string);
begin
    ReorderSQLDataSet(DayTotal, AFieldName);
end;

procedure TMainForm.wwDBGrid3FieldChanged(Sender: TObject; Field: TField);
var
    Poseshtenia: Variant;
    cod: Integer;
begin

    try
        // Poseshtenia:=STOKITE.FieldValues['POSESHTENIA'];
        cod := STOKITE.FieldValues['STOKAKOD'];
        //  STOKI.Locate('STOKAKOD',cod,[]);
        //  STOKI.FieldValues['STOKAIME']:='Карта за '+IntTostr(Poseshtenia)+' посещения';
        //  STOKITE.Post;
    except
    end;
end;

procedure TMainForm.wwDBGrid3TitleButtonClick(Sender: TObject;
    AFieldName: string);
begin
    ReorderSQLDataSet(KARTI, AFieldName);
end;

procedure TMainForm.StokaEditBtnClick(Sender: TObject);
begin
    if StokaEditBtn.Tag = 0 then
    begin
        STOKITE_SKLAD.Active := False;
        StokaEditBtn.Tag := 1;
        STOKITE_SKLAD.SQL.SetText('SELECT *  FROM STOKI WHERE STOKATIP = "S" ORDER BY STOKAKOD');
        StokaEditBtn.Font.Color := clGreen;
        STOKITE_SKLAD.Active := True;
    end
    else
    begin
        if STOKITE_SKLAD.State in [dsEdit, dsInsert] then
            STOKITE_SKLAD.Post;
        STOKITE_SKLAD.Active := False;
        StokaEditBtn.Tag := 0;
        STOKITE_SKLAD.SQL.SetText('SELECT STOKAIME, STOKAKOD, STOKANASKLAD, SUMA, SUMA * STOKANASKLAD as STOKATOTAL_IN,  STOKACENA,  STOKACENA * STOKANASKLAD as STOKATOTAL_SELL,  POSESHTENIA,  STOKATIP,  STOKACENACARD  FROM STOKI WHERE STOKATIP = "S" ORDER BY STOKAKOD');
        StokaEditBtn.Font.Color := clBlack;
        STOKITE_SKLAD.ReadOnly := True;
        STOKITE_SKLAD.Active := True;
    end;
end;

procedure TMainForm.StokiGridTitleButtonClick(Sender: TObject;
    AFieldName: string);
begin
    ReorderSQLDataSet(STOKITE, AFieldName);
end;

procedure TMainForm.StokiteTabChange(Sender: TObject);
begin
    if (StokiteTab.ActivePageIndex = 1) then
    begin
        StokaEditBtn.Visible := true;
        STOKITE_SKLAD.Active := False;
        STOKITE_SKLAD.Active := True;
    end
    else
    begin
        StokaEditBtn.Visible := false;
        if STOKITE_SKLAD.State in [dsEdit, dsInsert] then
            STOKITE_SKLAD.Post;
    end;
end;

procedure TMainForm.ReorderSQLDataSet(Query: TABSQuery; AFieldName: string);
    procedure SetOrderParam(Field: string);
    begin
        Query.Active := False;
        if not AnsiContainsText(Query.SQL.Text, 'ORDERPARAM') then
            Query.SQL.Text := Query.SQL.Text + 'ORDER BY :ORDERPARAM ASC';
        Query.ParamByName('ORDERPARAM').AsString := Field;
    end;
begin
    SetOrderParam(AFieldName);
    if AnsiContainsText(Query.SQL.Text, 'DESC') then
        Query.SQL.Text := (AnsiReplaceText(Query.SQL.Text, 'DESC', 'ASC'))
    else if AnsiContainsText(Query.SQL.Text, 'ASC') then
        Query.SQL.Text := (AnsiReplaceText(Query.SQL.Text, 'ASC', 'DESC'))
    else
        Query.SQL.Text := Query.SQL.Text + ' ASC';
    if not Query.Active then
        Query.Active := True;
end;

procedure TMainForm.Label123Click(Sender: TObject);
begin
    Form4.QuickRep1.Preview;
end;

procedure TMainForm.Label124Click(Sender: TObject);
begin
    IztriiStokaBtnClick(Sender);
end;

procedure TMainForm.LMDButton6Click(Sender: TObject);

var
    maxnomer: integer;
    nomer: integer;
    L: Boolean;
begin
    maxnomer := 0;
    nomer := 0;
    Table3.First;
    L := False;
    while (not L) do
    begin
        nomer := Table3.FieldByName('NOMER').AsInteger;
        if (nomer > 0) and (nomer > maxnomer) then
            maxnomer := nomer;
        L := Table3.Eof;
        Table3.Next;
    end;
    Table3.Append;
    Table3.FieldValues['NOMER'] := maxnomer + 1;
    Table3.FieldValues['IME'] := GetMessage('M18') + IntTostr(maxnomer + 1);
    //Table3.FieldValues['IME']:='New client №'+IntTostr(maxnomer+1);
    Table3.Post;
    Table3.Last;
    QKlienti.Active := False;
    QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER WHERE k.NOMER >-1 ORDER BY k.nomer DESC'));
    QKlienti.Active := True;
    // RefillForm.DBEdit2.ReadOnly:=false;
    RefillForm.ShowModal;
    if not RefillForm.ModalResult = mrOK then
        QKlienti.Delete;
    QKarti.Active := False;
    QKarti.SQL.SetText(PChar('SELECT * FROM kartiall WHERE klientdetail = ' +
        IntToStr2(QKlienti.FieldValues['NOMER']) +
        ' ORDER BY KARTANOMER DESC'));
    QKarti.Active := True;
end;

procedure TMainForm.PayClubCardClick(Sender: TObject);
var
    i: Integer;
begin
    PaidCash := 0;
    PaidCard := 0;
    PaidChipCard := 0;
    for i := 0 to SizeOf(PoseshteniaPaid) do
        PoseshteniaPaid[i] := 0;
    PosPaid := 0;
    BroiKartiPaid := 0;
    AdvPageControl1.ActivePageIndex := 17;
end;

procedure TMainForm.LMDShapeButton1Click(Sender: TObject);
//Плащане с чип карта на стоки
var
    Stoka: integer;
    Cena: Real;
    CenaCard: Real;
    Broi: Integer;
    Cena1: Real;
begin
    Stoka := Kasagrid.DataSource.DataSet.FieldValues['STOKAKOD'];
    if (KARTICHIP.RecordCount > 0) and
        (varType(Kasagrid.DataSource.DataSet.FieldValues['STOKACENACARD']) <>
        varNull) and
        (Card.Balans > 0) then
        CenaCard := Kasagrid.DataSource.DataSet.FieldValues['STOKACENACARD']
    else
        CenaCard := Kasagrid.DataSource.DataSet.FieldValues['STOKACENA'];
    Cena := Kasagrid.DataSource.DataSet.FieldValues['STOKACENA'];
    Broi := Kasagrid.DataSource.DataSet.FieldValues['STOKANASKLAD'];
    if Stoka > 10000 then
        Cena := Cena - (cena * 0 / 100); //Added for VIP discount
    //End Add for VIP Price
    if Broi > 0 then
    begin
        Suma := Suma + Cena;
        SumaCard := SumaCard + CenaCard;
        Kasagrid.DataSource.DataSet.Edit;
        Kasagrid.DataSource.DataSet.FieldValues['STOKANASKLAD'] := Broi - 1;
        Kasagrid.DataSource.DataSet.Post;
        if SDELKA.Locate('STOKA', Stoka, []) then
        begin
            SDELKA.Edit;
            Broi := SDELKA.FieldValues['BROI'];
            SDELKA.FieldValues['BROI'] := Broi + 1;
            if (KARTICHIP.RecordCount > 0) then
                SDELKA.FieldValues['SUMABROI'] := SDELKA.FieldValues['SUMABROI']
                    + CenaCard
            else
                SDELKA.FieldValues['SUMABROI'] := SDELKA.FieldValues['SUMABROI']
                    + Cena;
            SDELKA.FieldValues['KARTASUMA'] := SDELKA.FieldValues['KARTASUMA'] +
                CenaCard;
            SDELKA.Post;
        end
        else
        begin
            plashtania.Append;
            plashtania.FieldValues['STOKA'] := Stoka;
            if (KARTICHIP.RecordCount > 0) then
                plashtania.FieldValues['SUMABROI'] := CenaCard
            else
                plashtania.FieldValues['SUMABROI'] := Cena;
            plashtania.FieldValues['KARTASUMA'] := CenaCard;
            plashtania.FieldValues['BROI'] := 1;
            plashtania.FieldValues['DATA'] := Date;
            plashtania.FieldValues['CHAS'] := TimeToStr(Time);
            Plashtania.Post;
        end;
        SDELKA.Active := False;
        SDELKA.ParamByName('SDELKANOMER').AsInteger := SDELKANOMER;
        SDELKA.Active := True;
        calcKasaPaid;
    end;
end;

procedure TMainForm.calcKasaPaid;
var
    DiscountFirmi: integer;
begin
    Memo1.Clear;
    PaidCash := 0;
    PaidChipCard := 0;
    DiscountFirmi := Integer((QKLIENTI.RecordCount = 1) and
        (QKLIENTI.FieldValues['FIRMA'] > 0)) *
        Internet.FieldValues['DISCOUNT_PERCENT_FIRMI'];
    if (Card.Balans >= SumaCard) and IsChipCard then
    begin
        PaidChipCard := SumaCard
    end
    else if (KARTICHIP.RecordCount > 0) and (KARTICHIP.FieldValues['SUMA'] >
        SumaCard) and false then //never go here
    begin
        PaidChipCard := SumaCard
    end
    else
    begin
        PaidChipCard := 0;
        PaidCash := Suma - (DiscountFirmi * Suma / 100);
    end;
    if (KARTICHIP.RecordCount < 1) then
    begin
        Memo1.Lines.Add('Сума: ' + ConvertCurr1(Suma));
        if (DiscountFirmi > 0) and (PaidCash > 0) then
            Memo1.Lines.Add('Отстъпка в брой: ' + ConvertCurr1(DiscountFirmi));
        Memo1.Lines.Add('В брой: ' + ConvertCurr1(PaidCash));
    end;
    if PaidChipCard > 0 then
        Memo1.Lines.Add('От карта: ' + ConvertCurr1(PaidChipCard))
    else if (KARTICHIP.RecordCount > 0) then
        Memo1.Lines.Add('Сума с карта: ' + ConvertCurr1(SumaCard))
end;

procedure TMainForm.Label112Click(Sender: TObject);
// Финализиране на плащането
var
    TempBalans, Cena1: real;
begin
    SDELKA.First;
    while not Sdelka.Eof do
    begin
        SDELKA.Edit;
        Cena1 := SDELKA.FieldValues['SUMABROI'];
        SDELKA.FieldValues['CENA'] := Cena1;
        if PaidCash > 0 then
        begin
            SDELKA.FieldValues['KARTASUMA'] := 0;
            SDELKA.FieldValues['SUMABROI'] := Cena1 -
                cena1 * Internet.FieldValues['DISCOUNT_PERCENT_FIRMI'] / 100;
            SDELKA.FieldValues['DISCOUNT'] :=
                Internet.FieldValues['DISCOUNT_PERCENT_FIRMI'];
            if not QKLIENTI.IsEmpty then
            begin
                SDELKA.FieldValues['KLIENTNOMER'] :=
                    QKLIENTI.FieldValues['NOMER2'];
                SDELKA.FieldValues['OTCHIPKARTA'] :=
                    QKLIENTI.FieldValues['NOMER'];
            end;
        end
        else if PaidChipCard > 0 then
        begin
            SDELKA.FieldValues['SUMABROI'] := 0;
            //Cena1:=SDELKA.FieldValues['SUMABROI'];
            //SDELKA.FieldValues['KARTASUMA']:=Cena1;
            SDELKA.FieldValues['OTCHIPKARTA'] := QKLIENTI.FieldValues['NOMER'];
            SDELKA.FieldValues['KLIENTNOMER'] := QKLIENTI.FieldValues['NOMER2'];
        end;
        SDELKA.Post;
        SDELKA.Next;
    end;
    if (PaidChipCard > 0) and (PaidCash = 0) then
    begin
        SLE4442ReadCardInfo();
        if card.ConStatus > 0 then
        begin
            Card.Balans := Card.Balans - PaidChipCard;
            TempBalans := Card.Balans;
            SLE4442WriteCardInfo();
            SLE4442ReadCardInfo();
            if abs(Card.Balans - TempBalans) > 0.5 then
            begin
                PaidChipCard := 0;
                Application.MessageBox(PChar(GetMessage('M10')),
                    PChar('Warning'), MB_OK);
                //Application.MessageBox(PChar('Картата не може да бъде записана!'),PChar('Warning'),MB_OK);
                exit;
            end;
        end
        else if KARTICHIP.RecordCount > 0 then
        begin
            KARTICHIP.Edit;
            KARTICHIP.FieldValues['SUMA'] := KARTICHIP.FieldValues['SUMA'] -
                PaidChipCard;
            kartichip.Post;
        end
        else
        begin
            Application.MessageBox(PChar(GetMessage('M10')), PChar('Warning'),
                MB_OK);
            //Application.MessageBox(PChar('Картата не може да бъде записана!'),PChar('Warning'),MB_OK);
            exit;
        end;
    end;
    sol1.Commit(True);
    STOKITE.Active := false;
    AdvPageControl1.ActivePageIndex := 1;
end;

procedure TMainForm.Label111Click(Sender: TObject);
begin
    Sol1.Rollback;
    Sol1.FlushBuffers;
    STOKITE.Active := false;
    AdvPageControl1.ActivePageIndex := 1;
end;

procedure TMainForm.EndButtonCardClick(Sender: TObject);
var
    i: Integer;
    L: Boolean;
    KartiBroi: Integer;
    KlientNomer: Integer;
    KartaSelected: Integer;
begin
    if (PriceCash > 0) or (PriceCard > 0) then
    begin
        AdvPageControl1.ActivePageIndex := 3;
        // if Length(KartaSearchBox.Text)=0 then exit;
        if (QKarti.RecordCount > 0) then
        begin
            KartaSelected := QKarti.FieldValues['KARTANOMER'];
        end
        else
        begin
            KartaSelected := 0;
        end;
        KlientNomer := QKLienti.FieldValues['NOMER'];
        QKarti.Active := False;
        QKarti.SQL.SetText(PChar('SELECT * FROM kartiall WHERE klientdetail = '
            +
            IntToStr2(QKlienti.FieldValues['NOMER']) +
            ' AND (POSESHTENIA > 0) AND (STARTDATE >= CURRENT_DATE) ORDER BY KARTANOMER'));
        QKarti.Active := True;
        if (QKarti.RecordCount > 0) then
        begin
            DBtext4.Visible := True;
            DBtext7.Visible := True;
            ADVComboBox1.Visible := True;
            ADVComboBox2.Visible := True;
            Label72.Visible := True;
            Label130.Visible := True;
            Label71.visible := True;
            Label119.Visible := True;
            Label127.Visible := True;
            AdvComboBox1.ItemIndex := 30;
            AdvComboBox2.Items.Clear;
            QKarti.First;
            L := False;
            i := 0;
            while not (L) and (i < SizeOf(PoseshteniaPaid)) do
            begin
                AdvComboBox2.Items.Append(IntToStr2(QKarti.FieldValues['KARTANOMER']));
                QKarti.Next;
                L := QKarti.Eof;
                PoseshteniaPaid[i] := 0;
                i := i + 1;
            end;
            QKarti.Locate('KARTANOMER', KartaSelected, []);
            AdvComboBox2.ItemIndex := QKarti.RecNo - 1;
        end;
        Label149.Caption := '';
        KartiBroi := QKarti.RecordCount;
        if KartiBroi > 0 then
        begin
            Label149.Caption := 'Брой карти = ' + IntToStr(KartiBroi);
            Label149.Visible := True;
            PreCalcPaiment(Sender);
        end
        else
            Label149.Visible := False;
    end
    else
        AdvPageControl1.ActivePageIndex := 1;
end;

procedure TMainForm.PreCalcPaiment(Sender: TObject);
var
    MainTime: integer;
    KartaSuma: Integer;
    PosSelected: Integer;
    Cena: Real;
    Minutina1: Integer;
    Klient: Integer;
    I: Integer;
    L: Boolean;
    KartiBroi: Integer;
begin
    PosPaid := 0;
    i := 0;
    if AdvComboBox1.Visible then
    begin
        KartiBroi := QKarti.RecordCount;
        while (i < KartiBroi) and (i < SizeOf(PoseshteniaPaid)) do
        begin
            if not (i = ADVComboBox2.ItemIndex) then
                PosPaid := PoseshteniaPaid[i] + PosPaid;
            i := i + 1;
        end;
        L := False;
        Cena := SOLARIUMI.FieldValues['CENA'];
        MainTime := SOLARIUMI.FieldValues['VREME'];
        Klient := QKlienti.FieldValues['NOMER'];
        Minutina1 := SOLARIUMI.FieldValues['MINUTINA1'];
        KartaSuma := 0;
        if (QKarti.Locate('KARTANOMER', StrToInt(AdvComboBox2.Text), [])) then
            KartaSuma := QKarti.FieldValues['POSESHTENIA']
        else
            KartaSuma := 0;
        if ADVComboBox1.ItemIndex > KartaSuma then
            ADVComboBox1.ItemIndex := KartaSuma;
        if (ADVComboBox1.ItemIndex + PosPaid) * Minutina1 > TimeSet then
            ADVComboBox1.ItemIndex := (TimeSet div Minutina1) - PosPaid;
        PoseshteniaPaid[ADVComboBox2.ItemIndex] := ADVComboBox1.ItemIndex;
        PaidCard := (ADVComboBox1.ItemIndex + PosPaid) * Minutina1 * Cena;
        PosPaid := ADVComboBox1.ItemIndex + PosPaid;
    end;
    CalcPaid;
end;

procedure TMainForm.Label162Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 18;
end;

procedure TMainForm.Label165Click(Sender: TObject);
begin
    KasaGrid.DataSource := DataSource7;
end;

procedure TMainForm.Label166Click(Sender: TObject);
begin
    KasaGrid.DataSource := DataSource18;
end;

procedure TMainForm.Label16Click(Sender: TObject);
begin
    if(PasswordForm.IsMaster = true) then
      AdvPageControl1.ActivePageIndex := 16;
end;

procedure TMainForm.LMDButton7Click(Sender: TObject);
begin
    if not (PasswordForm.ModalResult = MROK) then
        if PasswordForm.ShowModal = MROK then
        begin
            wwDBGrid7.ReadOnly := False;
        end;
    if PasswordForm.ModalResult = MROK then
    begin
        {KARTIALL.Active:=False;
        KARTIALL1.Active:=False;}
        QKarti.ReadOnly := False;
        if not (QKarti.Eof and QKarti.Bof) then
            QKarti.Delete;
        QKarti.Active := False;
        QKarti.Active := True;
    end;
end;

procedure TMainForm.LMDButton9Click(Sender: TObject);
begin
    LMDButton5Click(Sender);
end;

procedure TMainForm.AdvTabSheet21Show(Sender: TObject);
begin
    StokaEditBtn.Visible := true;
end;

procedure TMainForm.Grafik23Show(Sender: TObject);
var
    I: Integer;
begin

    USLUGITE.Active := false;
    USLUGITE.Active := true;
    Planner1.Sidebar.Font.Size := 4;
    Planner1.Sidebar.HourFontRatio := 1.2;
    Planner1.sidebar.Width := 30;
    planner1.Display.DisplayScale := 20;
    Planner2.Sidebar.Font.Size := 3;
    Planner2.Sidebar.HourFontRatio := 1.2;
    Planner2.sidebar.Width := 20;
    planner2.Display.DisplayScale := 12;
    Planner3.Sidebar.Font.Size := 3;
    Planner3.Sidebar.HourFontRatio := 1.2;
    Planner3.sidebar.Width := 20;
    planner3.Display.DisplayScale := 12;
    Planner1.Positions := USLUGITE.RecordCount + 1;
    Planner2.Positions := USLUGITE.RecordCount + 1;
    Planner3.Positions := USLUGITE.RecordCount + 1;
    Planner1.PositionGroup := 1;
    with Planner1.Header do
    begin
        Autosize := true;
        CustomGroups.Clear;
        Captions.Clear;
        GroupCaptions.Clear;
        Captions.Add('');
        Captions.Add('Солариум');
    end;
    Planner2.PositionGroup := 1;
    with Planner2.Header do
    begin
        Captions.Clear;
        GroupCaptions.Clear;
        Captions.Add('');
        Captions.Add('Солариум');
    end;
    Planner3.PositionGroup := 1;
    with Planner3.Header do
    begin
        Captions.Clear;
        GroupCaptions.Clear;
        Captions.Add('');
        Captions.Add('Солариум');
    end;
    DBDaySource1.NumberOfResources := USLUGITE.RecordCount + 1;
    DBDaySource2.NumberOfResources := USLUGITE.RecordCount + 1;
    DBDaySource3.NumberOfResources := USLUGITE.RecordCount + 1;
    DBDaySource1.NumberOfDays := 1;
    DBDaySource2.NumberOfDays := 1;
    DBDaySource3.NumberOfDays := 1;
    DBDaySource1.ResourceMap.Clear;
    DBDaySource1.ResourceMap.Add;
    DBDaySource1.ResourceMap.Items[0].DisplayName := 'Солариум';
    USLUGITE.First;
    while not USLUGITE.Eof do
    begin
        DBDaySource1.ResourceMap.Add;
        DBDaySource1.ResourceMap.Items[USLUGITE.RecNo].DisplayName :=
            (USLUGITE.FieldValues['STOKAIME']);
        Planner3.Header.Captions.Add((USLUGITE.FieldValues['STOKAIME']));
        Planner2.Header.Captions.Add((USLUGITE.FieldValues['STOKAIME']));
        Planner1.Header.Captions.Add((USLUGITE.FieldValues['STOKAIME']));
        USLUGITE.Next;
    end;
    DBDaySource2.ResourceMap.Clear;
    DBDaySource2.ResourceMap.Add;
    DBDaySource2.ResourceMap.Items[0].DisplayName := 'Солариум';
    USLUGITE.First;
    while not USLUGITE.Eof do
    begin
        DBDaySource2.ResourceMap.Add;
        DBDaySource2.ResourceMap.Items[USLUGITE.RecNo].DisplayName :=
            (USLUGITE.FieldValues['STOKAIME']);
        USLUGITE.Next;
    end;
    DBDaySource3.ResourceMap.Clear;
    DBDaySource3.ResourceMap.Add;
    DBDaySource3.ResourceMap.Items[0].DisplayName := 'Солариум';
    USLUGITE.First;
    while not USLUGITE.Eof do
    begin
        DBDaySource3.ResourceMap.Add;
        DBDaySource3.ResourceMap.Items[USLUGITE.RecNo].DisplayName :=
            (USLUGITE.FieldValues['STOKAIME']);
        USLUGITE.Next;
    end;
    PlannerDatePicker1.Date := dateof(now);
    PlannerDatePicker1Change(Sender);
end;

procedure TMainForm.OsnovenEkran2Show(Sender: TObject);
begin
    KeyBuff := '';
    UpdatePageControl(0);
    PriceCard := 0;
    PriceCash := 0;
    Edit5.SetFocus;
    PriceCard := 0;
end;

procedure CalcPaid;
var
    i: integer;
    KartiBroi: Integer;
    Result1: string;
    Ostatak: Real;
begin
try
    with MainForm do
    begin
        LMDMemo1.Text := '';
        i := 0;
        KartiBroi := QKarti.RecordCount;
        BroiKartiPaid := 0;
        while (i < KartiBroi) and (i < SizeOf(PoseshteniaPaid)) do
        begin
            if PoseshteniaPaid[i] > 0 then
            begin
                BroiKartiPaid := BroiKartiPaid + 1; //'Карта '
                LMDMemo1.Lines.Add(GetMessage('M42') + ' ' +
                    ADVComboBox2.Items[i] + ' - ' +
                    ConvertCurr1(PoseshteniaPaid[i] *
                    SOLARIUMI.FieldValues['MINUTINA1'] *
                    SOLARIUMI.FieldValues['CENA']) + GetMessage('M20')); //'лв.'
            end;
            i := i + 1;
        end;
        //LMDMemo1.Lines.Add('Общо карти - '+ConvertCurr1(PosPaid*SOLARIUMI.FieldValues['MINUTINA1']*
        LMDMemo1.Lines.Add(GetMessage('M19') + ' ' + ConvertCurr1(PosPaid *
            SOLARIUMI.FieldValues['MINUTINA1'] *
            SOLARIUMI.FieldValues['CENA']) + GetMessage('M20'));
        //SOLARIUMI.FieldValues['CENA'])+'лв.');
        if PaidChipCard > 0 then
            LMDMemo1.Lines.Add(GetMessage('M21') + ' ' +
                ConvertCurr1(PaidCHipCard));
        //if PaidChipCard>0 then     LMDMemo1.Lines.Add('От чип-карта - '+ConvertCurr1(PaidCHipCard));
        if PaidCash > 0 then
            LMDMemo1.Lines.Add(GetMessage('M86') + ' ' +
                ConvertCurr1(ToBePaidCash));
        // LMDMemo1.Lines.Add('Сума за плащане в брой -'+ConvertCurr1(ToBePaidCash));
        if PaidCash > 0 then
            LMDMemo1.Lines.Add(GetMessage('M87') + ' ' + ConvertCurr1(VipDiscount
                + DiscountPrize));
        // LMDMemo1.Lines.Add('Отстъпка, % -'+ConvertCurr1(ToBePaidCash));
        LMDMemo1.Lines.Add(GetMessage('M22') + ' ' + ConvertCurr1(PaidCash));
        // LMDMemo1.Lines.Add('В брой - '+ConvertCurr1(PaidCash));
        LMDMemo1.Lines.Add('-----------');
        if PriceCard = PriceCash then
            LMDMemo1.Lines.Add(GetMessage('M23') + ' ' + ConvertCurr1(PriceCash
                -
                (PaidCard * (PriceCash / PriceCard) +
                ToBePaidCash + PaidChipCard * (PriceCash / PriceCard))));
        //LMDMemo1.Lines.Add(GetMessage('M23')+' '+ConvertCurr1(Price-(PaidCard+ToBePaidCash+PaidChipCard)));
        //LMDMemo1.Lines.Add('Остава - '+ConvertCurr1(Price-(PaidCard+PaidCash+PaidChipCard)));
        if (PriceCash - (PaidCard * (PriceCash / PriceCard) + ToBePaidCash +
            PaidChipCard * (PriceCash / PriceCard)) < 0.02) then
            PaymentOKLabel.Visible := true;
        FmtStr(Result1, '%4.2f', [(PaidChipCard)]);
        Ostatak := (Card.Balans - (PaidChipCard)) /   (PriceCard/TimeSet);
//            SOLARIUMI.FieldValues['CENA'];
        FmtStr(Result1, '%4.2f', [Ostatak]);
        Label72.Caption := '' + Result1 + GetMessage('M28') + ' / ';
        //Label72.Caption:=''+ Result1+'минути / ';
        Ostatak := (Card.Balans - (PaidChipCard));
        FmtStr(Result1, '%4.2f', [Ostatak]);
        Label72.Caption := Label72.Caption + '' + Result1 + GetMessage('M29');
        //Label72.Caption:=Label72.Caption + ''+ Result1+'лв.';
    end;
  except
      // DEBUG!!! Za da niama garmezi
  end;
end;

procedure TMainForm.SolariumiNastroiki7Show(Sender: TObject);
var
    f1, f2: TField;
begin
    f1 := SOLARIUMI.FindField('LICEVILASTDATE');
    f2 := SOLARIUMI.FindField('LAMPILASTDATE');
    if f1 = nil then
    begin
        SOLARIUMI.RestructureFieldDefs.Add('LICEVILASTDATE', aftDate);
        SOLARIUMI.Close;
        SOLARIUMI.RestructureTable;
        SOLARIUMI.Open;
        SOLARIUMI.FieldValues['LICEVILASTDATE'] := '01/01/1998';
    end;
    dbtext11.DataField := 'LICEVILASTDATE';
    if f2 = nil then
    begin
        SOLARIUMI.RestructureFieldDefs.Add('LAMPILASTDATE', aftDate);
        SOLARIUMI.close;
        SOLARIUMI.RestructureTable;
        SOLARIUMI.open;
        SOLARIUMI.FieldValues['LAMPILASTDATE'] := '01/01/1998';
    end;
    dbtext12.DataField := 'LAMPILASTDATE';
    ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
    if FileExists(ImageName) then
        Image16.Picture.LoadFromFile(ImageName);
    // else Image16.Picture:=Imagepress1.Picture;
    Label115.Caption := IntToStr(SOLARIUMI.RecNo);
    if SOLARIUMI.EOF then
        LMDButton16.Visible := true
    else
        LMDButton16.Visible := false;
end;

procedure TMainForm.LMDButton5Click(Sender: TObject);
var
    R: boolean;
    Klient: Integer;
    Message1: string;
    Result2: integer;
    _Q: TABSQUery;
begin // Delete klient
    if KARTICHIP.FieldValues['SUMA'] <> 0 then
    begin
        NuliraneChipCartaButtonClick(Sender);
        exit;
    end;
    _Q := TABSQuery.Create(nil);
    _Q.Databasename := 'sol1';
    _Q.ReadOnly := False;
    _Q.RequestLive := True;
    if IsChipCard and not (PasswordForm.ModalResult = MROK) then
    begin
        PasswordForm.ShowModal();
    end;
    begin
        if not IsChipCard or (PasswordForm.ModalResult = MROK) then
        begin
            wwDBGrid7.ReadOnly := False;
            Message1 := GetMessage('M24');
            //Message1:='Наистина ли искате да изтриете ';
            if not (VarType(QKlienti.FieldValues['IME']) in [varNull]) then
                Message1 := Message1 + QKlienti.FieldValues['IME'];
            Result2 := Application.MessageBox(PChar(Message1),
                PChar(GetMessage('M25')), MB_YESNO);
            //Result2:=Application.MessageBox(PChar(Message1),'ПОТВЪРДЕТЕ ИЗТРИВАНЕТО!',MB_YESNO);
            if Result2 = 6 then
            begin
                Klient := QKlienti.FieldValues['NOMER'];
                QKarti.Active := False;
                QKarti.SQL.SetText(PChar('SELECT * FROM kartiall WHERE klientdetail = ' +
                    IntToStr2(QKlienti.FieldValues['NOMER']) +
                    ' ORDER BY KARTANOMER DESC'));
                QKarti.Active := True;
                QKarti.First;
                while not QKarti.Eof do
                begin
                    QKarti.Delete;
                end;
                _Q.SQL.SetText(PChar('select * from KARTICHIP where KLIENTNOMER = ' + IntToStr(QKLIENTI.FieldValues['NOMER'])));
                _Q.Open;
                if _Q.RecordCount > 0 then _Q.Delete;
                QKlienti.Active := False;
                _Q.Close;
                _Q.SQL.SetText(PChar('select * from KLIENTI where NOMER = ' + IntToStr(Klient)));
                _Q.Open;

                _Q.Edit;
                _Q.FieldValues['NOMER'] := -((YearOf(now) - 2000) * 10000
                    + MonthOf(now) * 100 + DayOf(now));
                // To preserve data for klients
                _Q.Post;
                _Q.Close;
                QKlienti.Active := True;
                Plashtania.ReadOnly := False;
                Plashtania.Edit;
                Plashtania.Append;
                Plashtania.FieldValues['STOKA'] := 0;
                Plashtania.FieldValues['DATA'] := Date;
                Plashtania.FieldValues['OTCHIPKARTA'] := Klient;
                Plashtania.FieldValues['CHAS'] := TimeToStr(Time);
                Plashtania.Post;
                // Create empty record to register "Deletion" operation
                R := STOKI.Locate('STOKAKOD', 0, []);
                if not R then
                begin
                    AddStokaButtonClick(5);
                    //Добавяне на код за изтриване на клиент
                end;
            end
        end
        else
            Application.MessageBox(PChar(GetMessage('M26')),
                PChar(GetMessage('M27')), MB_OK);
    end;
    //else Application.MessageBox(PChar('Изтриване на клиент ползува само администратора!'),'Изтроването невъзможно!',MB_OK);
    _Q.Free;
end;

procedure TMainForm.KlubniKarti18Show(Sender: TObject);
begin
    QKarti.Active := True;
    QKlienti.Active := True;
    wwDBGrid6.Columns[1].ReadOnly := not (PasswordForm.ModalResult = mrOK);
    wwDBGrid7.ReadOnly := not (PasswordForm.ModalResult = mrOK);
end;

procedure TMainForm.wwDBGrid6Exit(Sender: TObject);
begin
    if QKlienti.State = dsEdit then
        QKlienti.Post;
end;

procedure TMainForm.MenuKasa16Hide(Sender: TObject);
begin
    SLE4442Deinit();
end;

procedure TMainForm.MenuKasa16Show(Sender: TObject);
begin
    Memo1.Clear;
    Memo1.Lines.Add('Сума:');
    Memo1.Lines.Add('В брой:');
    Memo1.Lines.Add('От карта:');
    QKlienti.Active := False;
    QKlienti.SQL.SetText(PChar('SELECT * FROM klienti where nomer = 999990 ORDER BY IME DESC'));
    CardNomer := 0;
    QKlienti.Active := True;
    ComboBox2.Clear;
    STOKITE.Active := true;
    SLE4442Init();
end;

procedure TMainForm.wwDBGrid6TitleButtonClick(Sender: TObject;
    AFieldName: string);
var
    SQLText: string;
begin
    if not ShowAllKlientsCb.Checked then
        SQLText := ' WHERE NOMER > -1 ';
    ViewByKlient := True;
    if (AFieldName = 'IME') and (not (AnsiContainsText(QKlienti.SQL.Text,
        'IME'))) then
    begin
        QKlienti.Active := False;
        QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER  ' + SQLText +
            ' ORDER BY IME DESC'));
    end;
    if (AFieldName = 'NOMER') then
    begin
        QKlienti.Active := False;
        if AnsiContainsText(QKlienti.SQL.Text, 'DESC') then
            QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER ' + SQLText +
                ' ORDER BY NOMER DESC'))
        else
            QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER ' + SQLText +
                ' ORDER BY NOMER ASC'));
    end;
    if (AFieldName = 'BALANS') and (not (AnsiContainsText(QKlienti.SQL.Text,
        'BALANS'))) then
    begin
        QKlienti.Active := False;
        QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER ' + SQLText +
            ' ORDER BY BALANS DESC'));
    end;
    if AnsiContainsText(QKlienti.SQL.Text, 'DESC') then
        QKlienti.SQL.Text := (AnsiReplaceText(QKlienti.SQL.Text, 'DESC', 'ASC'))
    else if AnsiContainsText(QKlienti.SQL.Text, 'ASC') then
        QKlienti.SQL.Text := (AnsiReplaceText(QKlienti.SQL.Text, 'ASC', 'DESC'))
    else
        QKlienti.SQL.Text := QKlienti.SQL.Text + ' ASC';
    QKlienti.Active := True;
    QKarti.Active := False;
    QKarti.SQL.SetText(PChar('SELECT * FROM kartiall WHERE klientdetail = ' +
        IntToStr2(QKlienti.FieldValues['NOMER']) + ' ORDER BY KARTANOMER '));
    Qkarti.SQL.Text := QKarti.SQL.Text;
    QKarti.Active := True;
end;

procedure TMainForm.Edit6Change(Sender: TObject);
var
    Ime, SQLText: string;
begin
    if MainForm.AdvPageControl1.ActivePageIndex = 17 then
        Ime := Edit6.Text;
    if MainForm.AdvPageControl1.ActivePageIndex = 18 then
        Ime := Edit10.Text;
    Ime := AnsiLowerCase(Ime);
    QKlienti.Active := False;
    SQLText := 'SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER WHERE LOWER(IME) LIKE "' + (Ime) + '%"';
    if not (ShowAllKlientsCb.Checked) then
        SQLText := SQLText + ' and NOMER >-1 ';
    QKlienti.SQL.SetText(PChar(SQLText + ' ORDER BY IME'));
    QKlienti.Active := True;
    if QKlienti.RecordCount > 0 then
        wwDBGrid6RowChanged(Sender)
    else
    begin
        QKarti.Active := False;
        SQLText := 'SELECT * FROM kartiall ';
        QKarti.SQL.SetText(PChar(SQLText + ' ORDER BY KARTANOMER'));
        QKarti.Active := True;
    end;
end;

procedure TMainForm.wwDBGrid6RowChanged(Sender: TObject);
var
    suma: Integer;
begin
    QKarti.Active := False;
    QKarti.SQL.SetText(PChar('SELECT * FROM kartiall WHERE klientdetail = ' +
        '"' + IntToStr2(QKlienti.FieldValues['NOMER']) + '"' +
        ' ORDER BY KARTANOMER'));
    QKarti.Active := True;
    if (varType(KARTICHIP.FieldValues['SUMA']) <> varNull) then
        suma := KARTICHIP.FieldValues['SUMA'] / Solariumi.FieldValues['CENA']
    else
        suma := 0;
    //    if suma > 2 then
    //        Label157.Caption := '~' + IntToStr2(suma) + ' минути'
    //    else
    //        Label157.Caption := '';
end;

procedure TMainForm.Edit7Change(Sender: TObject);
var
    SQLText: string;
begin
    QKarti.Active := False;
    if StrLen(PChar(KartaSearchBox.Text)) > 0 then
        QKarti.SQL.SetText(PChar('SELECT * FROM kartiall WHERE KARTANOMER = ' +
            KartaSearchBox.Text + ''))
    else
        QKarti.SQL.SetText(PChar('SELECT * FROM kartiall ORDER BY KARTANOMER'));
    QKarti.Active := True;
    QKlienti.Active := False;
    SQLText := '';
    if not (ShowAllKlientsCb.Checked) then
        SQLText := ' and NOMER >-1 ';
    if QKarti.FieldValues['klientdetail'] > 0 then
        QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER WHERE NOMER = ' +
            IntToStr2(QKarti.FieldValues['klientdetail']) + ''))
    else
        QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER ' + SQLText +
            ' ORDER BY NOMER DESC'));
    QKlienti.Active := True;
    wwDBGrid6RowChanged(Sender);
end;

procedure TMainForm.wwDBGrid7TitleButtonClick(Sender: TObject;
    AFieldName: string);
begin
    if AFieldName = 'KARTANOMER' then
    begin
        QKarti.Active := False;
        QKarti.SQL.SetText(PChar('SELECT * FROM kartiall ORDER BY KARTANOMER DESC'));
        QKarti.Active := True;
        if QKarti.RecordCount > 0 then
        begin
            QKlienti.Active := False;
            QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER WHERE NOMER = ' +
                IntToStr2(QKarti.FieldValues['klientdetail']) + ''));
            QKlienti.Active := True;
        end
        else
        begin
            QKlienti.Active := False;
            QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER WHERE NOMER = 0'));
            QKlienti.Active := True;
        end;
    end;
    if AFieldName = 'STARTDATE' then
    begin
        QKarti.Active := False;
        QKarti.SQL.SetText(PChar('SELECT * FROM kartiall ORDER BY STARTDATE DESC'));
        QKarti.Active := True;
        if QKarti.RecordCount > 0 then
        begin
            QKlienti.Active := False;
            QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER WHERE NOMER = ' +
                IntToStr2(QKarti.FieldValues['klientdetail']) + ''));
            QKlienti.Active := True;
        end
        else
        begin
            QKlienti.Active := False;
            QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER WHERE NOMER = 0'));
            QKlienti.Active := True;
        end;
    end;
end;

procedure TMainForm.wwDBGrid7RowChanged(Sender: TObject);
var
    KlientNo, i1: Integer;
begin
    //   i1:=AdvPageControl1.ActivePageIndex;
    //   if i1=17 then
    //   begin
    //    KartaSearchBox.Text:='';
    //    if QKlienti.RecordCount<2 then
    //     begin
    //      QKlienti.Active:=False;
    //      if QKarti.FieldValues['klientdetail']>0 then
    //       begin
    //        QKlienti.SQL.SetText(PChar('SELECT * FROM klienti WHERE NOMER = '+
    //         IntToStr2(QKarti.FieldValues['klientdetail']) +''));
    //        QKlienti.Active:=True;
    //       end
    //       else
    //       begin
    //        QKlienti.SQL.SetText(PChar('SELECT * FROM klienti ORDER BY NOMER DESC'));
    //        QKlienti.Active:=True;
    //       end;
    //      end
    //     else
    //      begin
    //       KlientNo:= QKlienti.FieldValues['NOMER'];
    //      end;
    //    end;
end;

procedure TMainForm.Edit5Change(Sender: TObject);
begin
    Edit5.Text := '';
end;

procedure TMainForm.IzborNaPlashtane4Hide(Sender: TObject);
begin
    SLE4442Deinit();
end;

procedure TMainForm.IzborNaPlashtane4Show(Sender: TObject);
begin
    //AdvComboBox1.ItemIndex:=0;
    LMDMemo1.SetFocus;
    Edit1.Text := '0';
    LMDMemo1.Text := 'Няма плащане';
    SLE4442Init();
    Label137.Font.Color := clRed;
end;

procedure TMainForm.PlannerMaskDatePicker2Change(Sender: TObject);
begin
    LoadChart(ComboBox1.ItemIndex);
end;

procedure TMainForm.Label171Click(Sender: TObject);
var
  I: Integer;
  ime: string;
  familia: string;
  telefon: string;
  address: string;
  selectedFile: string;
  linetext: string;
  dlg: TSaveDialog;
  myFile : TextFile;
  sl: TStringList;
begin
  sl := TStringList.Create;
  selectedFile := '';
  dlg := TSaveDialog.Create(nil);
  try
    dlg.InitialDir := 'C:\';
    dlg.Filter := 'CSV files (*.csv)|*.csv';
    if dlg.Execute(Handle) then
      selectedFile := dlg.FileName;
  finally
    dlg.Free;
  end;

  if selectedFile <> '' then
  begin
      familia:= ' ';
      AssignFile(myFile, selectedFile);
      ReWrite(myFile);
      linetext:= 'Name,Given Name,Additional Name,Family Name,Yomi Name,Given Name Yomi,Additional Name Yomi,Family Name Yomi,Name Prefix,Name Suffix,Initials,Nickname,Short Name,Maiden Name,Birthday,Gender,Location,';
      linetext:= linetext + 'Billing Information,Directory Server,Mileage,Occupation,Hobby,Sensitivity,Priority,Subject,Notes,Group Membership,';
      linetext:= linetext + 'E-mail 1 - Type,E-mail 1 - Value,E-mail 2 - Type,E-mail 2 - Value,Phone 1 - Type,Phone 1 - Value,Website 1 - Type,Website 1 - Value';
      WriteLn(myFile, linetext);
      Qklienti.First();
      while not Qklienti.Eof do
      begin
        if (varType(Qklienti.FieldValues['IME']) <> varNull) then
            ime:= Qklienti.FieldValues['IME']
            else  ime:= '';
        sl.DelimitedText := ime;
        if sl.count > 1 then
        begin
            familia := sl[1];
            ime := sl[0]
        end;
        if (varType(Qklienti.FieldValues['TELEFON']) <> varNull) then
            telefon:= Qklienti.FieldValues['TELEFON']
            else  telefon:= '';
        if (varType(Qklienti.FieldValues['ADRES']) <> varNull) then
            address:= Qklienti.FieldValues['ADRES']
            else  address:= '';
        WriteLn(myFile, ime + ',' + ime +  ',,' + familia  + ',,,,,,,,,,,,,,,,,,,,,,,* SolarStudio,,,,'+ address +',Mobile,' + telefon + ',,');
        Qklienti.Next();
      end;
      CloseFile(myFile);
  end;
  sl.Free;
end;

procedure TMainForm.Label17Click(Sender: TObject);
begin
//    if MainForm.Label21.color = clblack then
    if(PasswordForm.IsMaster = true) then
        AdvPageControl1.ActivePageIndex := 13;
end;

procedure TMainForm.AdvComboBox2Change(Sender: TObject);
var
    R: Boolean;
begin
    R := QKarti.Locate('KARTANOMER', StrToInt(AdvComboBox2.Text), []);
    if R then
        Label149.Color := clBlack
    else
        Label149.Color := clRed;
    AdvComboBox1.ItemIndex := PoseshteniaPaid[AdvComboBox2.ItemIndex]
end;

procedure TMainForm.KlientLabel_p18DblClick(Sender: TObject);
begin
    if PasswordForm.ShowModal = MROK then
    begin
        LMDButton7.Visible := True;
        LMDButton5.Visible := True;
        wwDBGrid7.ReadOnly := False;
    end;
end;

procedure TMainForm.RzBmpButton1MouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // Label40.top:= Label40.top+3;
    Image7Click(Sender);
end;

procedure TMainForm.RzBmpButton1MouseUpton1MouseUp(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // Label40.top:= Label40.top-3;
end;

procedure TMainForm.RzBmpButton2MouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // Label33.Top:= Label33.Top+3;
    Image6Click(Sender);
end;

procedure TMainForm.RzBmpButton2MouseUp(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    //  Label33.Top:= Label33.Top-3;
end;

procedure TMainForm.RzBmpButton3MouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    //   Label47.Top:= Label47.Top+3;
    Image8Click(Sender);
end;

procedure TMainForm.RzBmpButton3MouseUp(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // Label47.Top:= Label47.Top-3;
end;

procedure TMainForm.RzBmpButton4MouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // Label154.Top:= Label154.Top+3;
    Image9Click(Sender);
end;

procedure TMainForm.RzBmpButton4MouseUp(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    //Label154.Top:= Label154.Top-3;
end;

procedure TMainForm.AdvTabSheet5Show(Sender: TObject);
begin
    Label154.Caption := IntToStr2(SOLARIUMI.FieldValues['STAPKA'] *
        SOLARIUMI.FieldValues['KOEFICIENT']);
    Label33.Caption := IntToStr2(SOLARIUMI.FieldValues['STAPKA'] *
        SOLARIUMI.FieldValues['KOEFICIENT']);
    Label40.Caption := IntToStr2(SOLARIUMI.FieldValues['STAPKA']);
    Label47.Caption := IntToStr2(SOLARIUMI.FieldValues['STAPKA']);
end;

procedure TMainForm.PayChipCardClick(Sender: TObject);
var
    Result1: string;
    Ostatak: Real;
    Date: TDateTime;
    temp_discount: Real;
begin
    if (Label130.Visible and DBText7.Visible) or Label72.visible then
    begin
        if (PriceCash > 0) or (PriceCard > 0) then
        begin
            if (KARTICHIP.FieldValues['ENDDATE'] > 0) and
                (KARTICHIP.FieldValues['ENDDATE'] < DateOf(Now)) and not
                    IsChipCard then
            begin
                Application.MessageBox(PChar('Валидността на картата е изтекла!'), PChar(''), MB_OK);
                exit;
            end;
            if (KARTICHIP.FieldValues['STARTTIME'] > 0) and
                (KARTICHIP.FieldValues['STARTTIME'] < TimeOf(Now)) and not
                    IsChipCard then
            begin
                Application.MessageBox(PChar('Картата не може да бъде ползвана сега!'), PChar(''), MB_OK);
                exit;
            end;
            if (Card.PIN <> Internet.FieldValues['PIN']) and (Card.PIN <> '')
                then
            begin
                Application.MessageBox(PChar('Тази карта не може да бъде използвана в това студио!'), PChar(''), MB_OK);
                exit;
            end;
            if (KARTICHIP.FieldValues['ONCE_PERDAY'] = true) and
                (Card.StudioNomer = Internet.FieldValues['STUDIONOMER']) then
            begin
                PLASHTANIA.Last;
                Date := DateOf(Now);
                while (PLASHTANIA.FieldValues['DATA'] = Date) and (PLASHTANIA.RecNo > 1) do
                begin
                    if ((PLASHTANIA.FieldValues['SOLARIUM'] > -1) and
                        (PLASHTANIA.FieldValues['OTCHIPKARTA'] =
                        KARTICHIP.FieldValues['KLIENTNOMER'])) then
                    begin
                        Application.MessageBox(PChar('Тази карта позволява само едно печене на ден!'), PChar(''), MB_OK);
                        exit;
                    end;
                    PLASHTANIA.Prior;
                end;
            end;
            PaidCash := 0;
            TobePaidCash := 0;
            Label71.visible := True;
            Label72.visible := True;
            if PriceCard = PriceCash then
                PaidChipCard := PriceCard - (PaidCard + PaidCash)
            else
                PaidChipCard := PriceCard;
            if (PaidChipCard) > Card.Balans then
                PaidChipCard := Card.Balans;
            FmtStr(Result1, '%4.2f', [(PaidChipCard)]);
            temp_discount := VipDiscount;
            VipDiscount := 0;
            CalcPaid;
            VipDiscount := temp_discount;
        end;
    end
        // else
        // AdvPageControl1.ActivePage:=AdvTabsheet19;
end;

procedure TMainForm.wwDBEdit7KeyPress(Sender: TObject; var Key: Char);
begin
    if (Key in ['a'..'f']) then
        Key := UpCase(Key);
    if (Key in ['A'..'F']) or (Key in ['0'..'9']) or (Key < ' ') then
    else
        Key := #0;
end;

procedure TMainForm.Label139Click(Sender: TObject); //ChipCard Payment
var
    result1: string;
begin
    if KARTICHIP.State in [dsEdit, dsInsert] then
        KARTICHIP.Post;
    if QKLIENTI.State in [dsEdit, dsInsert] then
        QKLIENTI.Post;
    //    if PriceCard>0 then
    //    begin
    //        AdvPageControl1.ActivePage:=AdvTabsheet4;
    //        Label71.visible:=True;
    //        Label72.visible:=True;
    //        PayChipCardClick(Sender);
    //        //  PaidChipCard:=PriceCard ;//-(PaidCard+PaidCash); Removed...
    //        //  if PaidChipCard>Card.Balans then PaidChipCard:=Card.Balans;
    //        //  FmtStr(Result1,'%4.2f',[PaidChipCard]);
    //    end
    //    else
    AdvPageControl1.ActivePageIndex := 1;
end;

procedure TMainForm.KartaSearchBoxKeyPress(Sender: TObject; var Key: Char);
begin
    if (TimeKeyPress = 0) or (Length(KartaSearchBox.Text) < 1) then
        TimeKeyPress := Now;
    if not (Key in ['0'..'9']) then
    begin
        if Key <> chr(8) then
            Key := #0;
    end
    else if (PasswordForm.ModalResult <> MROK) and (SecondsBetween(Now,
        TimeKeyPress) >= 1) and (Length(KartaSearchBox.Text) > 5) then
        Key := #0;
end;

procedure TMainForm.AdvComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
    Key := #0;
end;

procedure TMainForm.KartaSearchBoxKeyUp(Sender: TObject; var Key: Word;
    Shift: TShiftState);
var
    SQLText: string;
begin
    QKarti.Active := False;
    if StrLen(PChar(KartaSearchBox.Text)) > 0 then
        QKarti.SQL.SetText(PChar('SELECT * FROM kartiall WHERE KARTANOMER = ' +
            KartaSearchBox.Text + ''))
    else
        QKarti.SQL.SetText(PChar('SELECT * FROM kartiall ORDER BY KARTANOMER'));
    QKarti.Active := True;
    QKlienti.Active := False;
    if not ShowAllKlientsCb.Checked then
        SQLText := ' WHERE NOMER >-1 ';
    if QKarti.FieldValues['klientdetail'] > 0 then
        QKlienti.SQL.SetText(PChar('SSELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER WHERE NOMER = ' +
            IntToStr2(QKarti.FieldValues['klientdetail']) + ''))
    else
        QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER ' + SQLText +
            ' ORDER BY NOMER DESC'));
    QKlienti.Active := True;
    wwDBGrid6RowChanged(Sender);
    if Length(KartaSearchBox.Text) > 0 then
    begin
        while not QKarti.Eof do
        begin
            if QKarti.FieldValues['KARTANOMER'] = StrToInt(KartaSearchBox.Text)
                then
                break;
            QKarti.Next;
        end;
    end;
end;

procedure TMainForm.N2Click(Sender: TObject);
var
    SQLText: string;
begin
    if not ShowAllKlientsCb.Checked then
        SQLText := ' WHERE NOMER > -1 ';
    AdvPageControl1.ActivePageIndex := 18;
    QKlienti.Active := False;
    QKlienti.SQL.SetText(PChar('SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER = c.KLIENTNOMER ' + SQLText +
        ' ORDER BY IME DESC'));
    CardNomer := 0;
    QKlienti.Active := True;
    Label137.Font.Color := clRed;
end;

procedure TMainForm.N1Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 17;
end;

procedure TMainForm.Label92MouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
var
    point1: TPoint;
begin
    point1.X := x;
    point1.Y := y;
    point1 := Label92.ClientToScreen(point1);
    Label92.PopupMenu.Popup(Point1.X, Point1.Y);
end;

procedure TMainForm.DBCheckBox1Exit(Sender: TObject);
begin
    Internet.Edit;
    Internet.Post;
end;

procedure TMainForm.LMDButton10Click(Sender: TObject);
begin
    if Application.MessageBox(PChar(GetMessage('M30')),
        PChar(GetMessage('M31')), MB_OKCANCEL) = IDOK then
        //if Application.MessageBox(PChar('Ще бъдат изтрити всички стоки!?'),PChar('Стоки?!'),MB_OKCANCEL		)=IDOK	 then
    begin
        while STOKITE.RecordCount > 0 do
            STOKITE.Delete;
    end;
end;

procedure TMainForm.LMDButton12Click(Sender: TObject);
begin
    if Application.MessageBox(PChar(GetMessage('M32')),
        PChar(GetMessage('M33')), MB_OKCANCEL) = IDOK then
        //if Application.MessageBox(PChar('Ще бъдат изтрити всички видове карти!?'),PChar('Карти?!'),MB_OKCANCEL		)=IDOK	 then
    begin
        while KARTI.RecordCount > 0 do
            KARTI.Delete;
    end;
end;

procedure TMainForm.LMDButton13Click(Sender: TObject);
var
    q: TABSQuery;
begin
    if Application.MessageBox(PChar(GetMessage('M34')),
        PChar(GetMessage('M35')), MB_OKCANCEL) = IDOK then
        //if Application.MessageBox(PChar('Ще бъдат изтрити всички клиенти!?'),PChar('Клиенти?!'),MB_OKCANCEL		)=IDOK	 then
        q := TABSQuery.Create(MainForm);
    q.Databasename := 'sol1';
    q.ReadOnly := False;
    q.RequestLive := TRUE;
    q.SQL.SetText(PChar('DELETE FROM KARTICHIP'));
    q.ExecSQL;
    q.Close;
    q.RequestLive := TRUE;
    q.SQL.SetText(PChar('DELETE FROM CHIPKARTI'));
    q.ExecSQL;
    q.Close;
    q.RequestLive := TRUE;
    q.SQL.SetText(PChar('DELETE FROM KARTIALL'));
    q.ExecSQL;
    q.Close;
    q.RequestLive := TRUE;
    q.SQL.SetText(PChar('DELETE FROM KLIENTI'));
    q.ExecSQL;
    q.Close;
    Table3.Append;
    Table3.FieldValues['NOMER'] := 1;
    Table3.FieldValues['IME'] := GetMessage('M36');
    Table3.Post;
    MainForm.sol1.FlushBuffers;
    MainForm.Timer1.Enabled := false;
    MainForm.sol1.Close;
    MainForm.sol1.Connected := false;
    Sleep(1000);
    MainForm.sol1.Connected := false;
    MainForm.sol1.Connected := false;
    MainForm.sol1.Connected := false;
    MainForm.sol1.Connected := false;
    MainForm.sol1.Connected := false;
    MainForm.sol1.Connected := false;
    MainForm.sol1.CompactDatabase();
    OpenTables;
    MainForm.Timer1.Enabled := true;
    //Table3.FieldValues['IME']:='Администратор';

end;

procedure TMainForm.LMDButton14Click(Sender: TObject);
var
    q: TABSQuery;
begin
    //if Application.MessageBox(PChar('Ще бъдат изтрити всички протоколи!?'),PChar('Warning'),MB_OKCANCEL		)=IDOK	 then
    if Application.MessageBox(PChar(GetMessage('M79')), PChar('Warning'),
        MB_OKCANCEL) = IDOK then
        MainForm.Timer1.Enabled := false;
    q := TABSQuery.Create(MainForm);
    q.Databasename := 'sol1';
    q.ReadOnly := False;
    q.RequestLive := TRUE;
    q.SQL.SetText(PChar('DELETE FROM plashtania'));
    q.ExecSQL;
    q.Free;
    Plashtania.Append;
    plashtania.FieldValues['BROI'] := 0;
    plashtania.FieldValues['DATA'] := Date;
    plashtania.FieldValues['CHAS'] := TimeToStr(Time);
    plashtania.FieldValues['OTCHIPKARTA'] := 1;
    plashtania.FieldValues['STOKA'] := 0;
    plashtania.FieldValues['SUMABROI'] := 0;
    Plashtania.Post;
    MainForm.sol1.FlushBuffers;
    MainForm.sol1.Close;

    MainForm.sol1.Connected := false;
    MainForm.sol1.Connected := false;
    MainForm.sol1.Connected := false;
    Sleep(1000);
    MainForm.sol1.Connected := false;
    MainForm.sol1.Connected := false;
    MainForm.sol1.Connected := false;
    MainForm.sol1.CompactDatabase();
    OpenTables;
    MainForm.Timer1.Enabled := true;
end;

procedure TMainForm.NuliraneChipCartaButtonClick(Sender: TObject);
    procedure ReturnDeposit(KartaNomer: Integer);
    begin
        if MainForm.STOKI.Locate('STOKATIP', 'D', []) and (KartaNomer > 0) then
        begin
            MainForm.STOKI.Edit;
            MainForm.STOKI.FieldValues['STOKANASKLAD'] :=
                MainForm.STOKI.FieldValues['STOKANASKLAD'] + 1;
            MainForm.STOKI.post;
            Plashtania.Append;
            plashtania.FieldValues['BROI'] := 1;
            plashtania.FieldValues['DATA'] := Date;
            plashtania.FieldValues['CHAS'] := TimeToStr(Time);
            plashtania.FieldValues['OTCHIPKARTA'] := KartaNomer;
            plashtania.FieldValues['STOKA'] :=
                MainForm.STOKI.FieldValues['STOKAKOD'];
            plashtania.FieldValues['SUMABROI'] :=
                -MainForm.STOKI.FieldValues['STOKACENA'];
            Plashtania.Post;
        end;
    end;
var
    KartaNomer: Integer;
    IsOK: Integer;

begin
    if ((Card.PIN <> Internet.FieldValues['PIN']) and (Card.PIN <> '')) {  or
    (KARTICHIP.fieldvalues['suma']>0)}then
    begin // Message shoud be corrected...
        IsOK := Application.MessageBox(PChar(GetMessage('M78')),
            PChar('Warning'), MB_OKCANCEL);
        //Application.MessageBox(PChar('Картата може да се нулира само във студиото където е издадена!'),PChar('Warning'),MB_OK);
        SLE4442ReadCardInfo();
        SLE4442ShowCardInfo();
        if ((IsOK <> MROK) or (PasswordForm.ShowModal <> MROK)) then
            exit;
    end;
    if not IsChipCard then
        if not (MainForm.STOKI.Locate('STOKATIP', 'D', [])) then
        begin
            if PasswordForm.ModalResult <> MROK then
                if PasswordForm.ShowModal <> MROK then
                    exit;
        end;
    if Application.MessageBox(PChar(GetMessage('M77')), PChar('?!'), MB_OKCANCEL)
        = IDOK then
    begin
        //Картата ще бъде изчистена!?
        KARTICHIP.Edit;
        KARTICHIP.FieldValues['COUNTER'] := 0;
        KARTICHIP.FieldValues['DISCOUNT'] := 0;
        KARTICHIP.FieldValues['SUMA'] := 0;
        KARTICHIP.Post;
        if not IsChipCard then
        begin
            ReturnDeposit(KARTICHIP.FieldValues['KLIENTNOMER']);
        end;

        if Card.ErrCounter > 2 then
        begin
            Card.ConStatus := card.ConStatus;
            Data := Card.PIN; //Internet.FieldValues['PIN'];
            SLE4442Submit();
            SLE4442ReadCardInfo();
            if ((not (Card.ErrCounter > 2)) or (Card.ConStatus = 0)) then
                exit
            else
            begin
                KartaNomer := Card.CardNomer;
                ClearCard();
                SLE4442ReadCardInfo();
                Data := 'ffffff';
                SLE4442ChangePIN();
                Card.PIN := 'ffffff'; //Internet.FieldValues['PIN'];
                SLE4442WriteCardInfo();
                SLE4442ShowCardInfo();
                if ((Card.CardNomer < 0) and (KartaNomer > 0)) then
                begin //successful cleaning - return deposit
                    ReturnDeposit(KartaNomer);
                    Card.ErrCounter := Card.ErrCounter;
                end;
            end;
        end;
    end
    else
    begin
        Application.MessageBox(PChar(GetMessage('M76')), PChar('Warning'),
            MB_OK);
        //Application.MessageBox(PChar('Картата не е записана!'),PChar('Warning'),MB_OK);
    end;
end;

procedure TMainForm.LMDLImage115Click(Sender: TObject);
begin
    DBLUCombo1.Visible := TRUE;
end;

procedure TMainForm.ZarezdaneButtonClick(Sender: TObject);
var
    Balans1: real;
    Result2: Integer;
    HasCard: Boolean;
begin //Зареждане
    if not (QKlienti.RecordCount = 1) and not IsReader then
        Exit;
    if KARTICHIP.FieldValues['ENDDATE'] > 0 then
        Exit;
    if( CardNomer <> 0) then
    begin
        QKlienti.Active := False;
        QKlienti.Active := True;
        Qklienti.Locate('NOMER', CardNomer, []);
    end;
    if not IsReader then
        Card.NewCard := KARTICHIP.FieldValues['COUNTER'] = -1
    else
        Card.NewCard := (Card.CardNomer = -1);
    HasCard := Card.ClientNomer > 0;
    if IsReader and (Card.CardNomer < 0) then
        HasCard := true;

    if not IsReader or (Card.CardNomer < 0) then
    begin // If new card or no card
        CardNomer := QKlienti.FieldValues['NOMER'];
        Card.StudioName := Internet.FieldValues['STUDIONAME'];
        Card.StudioNomer := Internet.FieldValues['STUDIONOMER'];
        Card.ClientName := QKlienti.FieldValues['IME'];
        //Card.PIN:=Internet.FieldValues['PIN'];
        Card.ClientNomer := QKlienti.FieldValues['NOMER'];
        Card.CardNomer := Card.ClientNomer;
        if (not IsReader) and ((varType(KARTICHIP.FieldValues['SUMA']) = varNull)
            or KARTICHIP.FieldValues['COUNTER'] = -1) then
        begin
            Card.NewCard := true;
        end;
        if (not IsReader) and (varType(KARTICHIP.FieldValues['SUMA']) <> varNull)
            then
        begin
            Card.Balans := KARTICHIP.FieldValues['SUMA'];
        end;
        if (Card.Balans < 0) then
            Card.Balans := 0;
    end;
    if IsReader then
    begin
        if not HasCard then
        begin
            Application.MessageBox(PChar('Поставете карта!!!'),
                PChar('Warning'), MB_OK);
            Exit;
        end;
        Data := Card.PIN; //'ffffff';
        if Card.ErrCounter > 2 then
        begin
            SLE4442Submit();
            // SLE4442ReadCardInfo();
        end;
        if not (Card.ErrCounter > 5) then
        begin
            if not (Card.ConStatus = 0) then
            begin
                Application.MessageBox(PChar('ERROR - Replace Card!!!'),
                    PChar('Warning'), MB_OK);
            end;
            exit;
        end;
        if (Card.CardNomer > 0) and (Card.ClientNomer <>
            QKlienti.FieldValues['NOMER']) then
        begin
            // Application.MessageBox(PChar('Картата е на друг клиент и не е нулирана!'),PChar('Warning'),MB_OK);
            Application.MessageBox(PChar(GetMessage('M75')), PChar('Warning'),
                MB_OK);
            // SLE4442ReadCardInfo();SLE4442ShowCardInfo();
            exit;
        end;
        if (Card.PIN <> Internet.FieldValues['PIN']) and not Card.NewCard then
        begin
            // Application.MessageBox(PChar('Картата може да се зарежда само във студиото където е издадена!'),PChar('Warning'),MB_OK);
            Application.MessageBox(PChar(GetMessage('M74')), PChar('Warning'),
                MB_OK);
            // SLE4442ReadCardInfo();SLE4442ShowCardInfo();
            exit;
        end;
    end;

    Karti.Active := False;
    Karti.SQL.SetText(PChar('SELECT * FROM STOKI WHERE STOKAKOD < 0 AND POSESHTENIA > 0 AND SUMA > 0'));
    Karti.Active := True;
    if (sol1.InTransaction) then
    begin
        //Application.MessageBox(PChar('Базата данни е в транзакция. Това не би трябвало да се случва... Моля рапортувайте тази грешка на автора'), PChar('Вътрешна грешка'), MB_OK);
//        sol1.Rollback;
        sol1.Commit;
    end;
    sol1.StartTransaction;

    RefillForm.ShowModal;
    if RefillForm.ModalResult = mrOK then
    begin
        if IsReader and (KARTICHIP.FieldValues['SUMA'] > 0) then
        begin
            Result2 :=
                Application.MessageBox(PChar('Локалната база данни съдържа заредена сума. Да се прехвърли ли?'), PChar('Прехвърляне на сума'), MB_YESNO);
            if Result2 = 6 then
            begin
                Card.Balans := Card.Balans + KARTICHIP.FieldValues['SUMA'];
                Balans1 := Card.Balans;
                if ((Balans1 - Card.Balans) < 0.02) then
                begin
                    Application.MessageBox(PChar('Сумата за клиента от локалната база данни '
                        + ConvertCurr1(KARTICHIP.FieldValues['SUMA']) +
                        ' ще бъде добавена към Чип картата'),
                        PChar('Добавяне на сума'), MB_OK);
                    KARTICHIP.edit;
                    KARTICHIP.FieldValues['SUMA'] := 0;
                    KARTICHIP.post;
                end;
            end;
        end;
        Balans1 := Card.Balans;
        Data := Card.PIN; //'ffffff';
        SLE4442Submit();
        if IsChipCard and (Card.ErrCounter > 5) then
        begin
            Card.CardNomer := Card.ClientNomer; //QKlienti.FieldValues['NOMER'];
            Data := Internet.FieldValues['PIN'];
            if (strLen(PChar(Data)) <> 6) then
            begin
                Application.MessageBox(PChar('Невалидна настройка за PIN код.'),
                    PChar(''));
                if sol1.InTransaction then
                    sol1.Rollback;
                Exit;
            end;
            SLE4442ChangePIN();
            Card.PIN := Internet.FieldValues['PIN'];
            SLE4442WriteCardInfo();
            SLE4442ReadCardInfo();
        end
        else
        begin
            if KARTICHIP.RecordCount = 0 then
            begin
                KARTICHIP.Append;
                KARTICHIP.FieldValues['SUMA'] := 0;
                KARTICHIP.Post;
            end;
            KARTICHIP.Edit;
            if (KARTICHIP.FieldValues['SUMA'] <> KARTICHIP.FieldValues['SUMA'])
                then
                KARTICHIP.FieldValues['SUMA'] := 0; // for null value
            KARTICHIP.FieldValues['SUMA'] := Card.Balans;
            if (KARTI.FieldValues['VALIDNOST_KARTI'] > 0) then
            begin
                KARTICHIP.FieldValues['ENDDATE'] := Date +
                    KARTI.FieldValues['VALIDNOST_KARTI'];
            end;
            if (KARTICHIP.FieldValues['ONCE_PERDAY'] <>
                KARTICHIP.FieldValues['ONCE_PERDAY']) or Card.NewCard then
            begin
                if (GetStudioWorkType() <= 0) then
                begin
                    KARTICHIP.FieldValues['ONCE_PERDAY'] := false;
                end
                else
                begin
                    KARTICHIP.FieldValues['ONCE_PERDAY'] := true;
                end;
            end;
            KARTICHIP.Post;
            Balans1 := Card.balans;
        end;
        if ((Card.Balans - Balans1) < 2) then
            sol1.Commit(True)
        else
        begin
            sol1.Rollback;
            //  Application.MessageBox(PChar('Картата не е записана правилно!'),PChar('Warning'),MB_OK);
            Application.MessageBox(PChar(GetMessage('M73')), PChar('Warning'),
                MB_OK);
        end;
    end
    else
        sol1.Rollback;
    if IsChipCard then
    begin
        SLE4442ReadCardInfo();
        SLE4442ShowCardInfo();
    end;

end;

procedure TMainForm.Label143Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 2;
    wwDBGrid12RowChanged(nil);
end;

procedure TMainForm.ManuStoki17Show(Sender: TObject);
begin
    Karti.Active := False;
    Karti.SQL.SetText(PChar('SELECT * FROM STOKI WHERE STOKAKOD < 0'));
    Karti.Active := True;
    STOKITE_SKLAD.Active := true;
    STOKITE_SKLAD.ReadOnly := false;
end;

procedure TMainForm.N3Click(Sender: TObject);

begin
    AddStokaButtonClick(1);
end;

procedure TMainForm.LMDButton1MouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    point1: TPoint;
begin
    //point1.X:=x; point1.Y:=y;
    //point1:=LMDButton1.ClientToScreen(point1);
    //LMDButton1.PopupMenu.Popup(Point1.X,Point1.Y);
end;

procedure TMainForm.LMDButton2Click(Sender: TObject);
begin
    LMDButton5Click(Sender);
end;

procedure TMainForm.N4Click(Sender: TObject);
begin
    AddStokaButtonClick(2);
end;

procedure TMainForm.N5Click(Sender: TObject);

begin
    AddStokaButtonClick(0);
end;

procedure TMainForm.ChipKarti19Hide(Sender: TObject);
begin
    SLE4442Deinit();
end;

procedure TMainForm.ChipKarti19Show(Sender: TObject);
begin
    if (GetStudioWorkType() < 3) then
    begin
      //  NovKlientButton.Visible := false;
    end;
    QKlienti.Active := True;
    Label137.Caption := GetMessage('M67'); //'Няма карта';
    Label137.Font.Color := clRed;
    if (PasswordForm.IsMaster = true) then
    begin
        PercentEdit.enabled := true;
        SumaEdit.enabled := true;
        PosEdit.enabled := true;
        OncePerDayBox.enabled := true;
        ValidnostDate.enabled := true;
        ValidnostTime.enabled := true;
    end
    else
    begin
        PercentEdit.enabled := false;
        SumaEdit.enabled := false;
        PosEdit.enabled := false;
        OncePerDayBox.enabled := false;
        ValidnostDate.enabled := false;
        ValidnostTime.enabled := false;
    end;
    wwDBGrid5.Columns[1].ReadOnly := not (PasswordForm.ModalResult = mrOK);
    SLE4442Init();
end;

procedure TMainForm.NovKlientButtonClick(Sender: TObject);
var
    maxnomer: integer;
    nomer: integer;
    L: Boolean;
    _Q: TABSQuery;
    SQLText: string;
begin
    _Q := TABSQuery.Create(nil);
    _Q.Databasename := 'sol1';
    _Q.ReadOnly := False;
    _Q.RequestLive := True;
    maxnomer := 0;
    nomer := 0;
    Table3.First;
    L := False;
    while (not L) do
    begin
        nomer := Table3.FieldByName('NOMER').AsInteger;
        if (nomer > 0) and (nomer > maxnomer) then
            maxnomer := nomer;
        L := Table3.Eof;
        Table3.Next;
    end;

    Table3.Append;
    Table3.FieldValues['NOMER'] := maxnomer + 1;
    Table3.FieldValues['BALANS'] := 0;
    Table3.FieldValues['FIRMA'] := 0;
    Table3.FieldValues['IME'] := GetMessage('M66') + IntTostr(maxnomer + 1);
    //'Нов клиент №'
    Table3.Post;
    Table3.Last;
    QKlienti.Active := False;
    if not ShowAllKlientsCb.Checked then
        SQLText := ' WHERE NOMER >-1 ';

    QKlienti.SQL.SetText(PChar('SELECT * FROM klienti ' + SQLText +
        ' ORDER BY NOMER DESC'));
    QKlienti.Active := True;
    ZarezdaneButtonClick(Sender);
    if RefillForm.ModalResult = mrOK then
    begin
        _Q.SQL.SetText(PChar('select * from KARTICHIP where KLIENTNOMER = ' +
            IntToStr(QKLIENTI.FieldValues['NOMER'])));
        _Q.Open;
        if _Q.RecordCount > 0 then
        begin
            _Q.Edit;
            _Q.FieldValues['SUMA'] := 0;
            _Q.FieldValues['COUNTER'] := -1;
        end
        else
            _Q.Append;
        _Q.FieldValues['KLIENTNOMER'] := QKLIENTI.FieldValues['NOMER'];
        _Q.FieldValues['COUNTER'] := -1;
        _Q.FieldValues['DISCOUNT'] := 0;
        if not IsReader then
            _Q.FieldValues['SUMA'] := _Q.FieldValues['SUMA'] +
                KARTI.FieldValues['SUMA'];
        if (GetStudioWorkType() = 1) or (GetStudioWorkType() = 4)then
           _Q.FieldValues['ONCE_PERDAY'] := TRUE
        else
           _Q.FieldValues['ONCE_PERDAY'] := FALSE;
        _Q.Post;
        if QKlienti.RecNo > 1 then
        begin
            QKLIENTI.Prior;
            QKLIENTI.Next;
        end;
    end
    else
    begin
        if QKLIENTI.State in [dsInsert, dsEdit] then
            QKLIENTI.Post;

        QKlienti.Delete;
    end;
    _Q.Free;
end;

procedure TMainForm.Label144Click(Sender: TObject);
begin
    AdvPageControl1.ActivePageIndex := 22;
end;

procedure TMainForm.AddressComboBoxDropDown(Sender: TObject);
var
    i: byte;
    data1: byte;
begin
    IOResult := ReadFile(hDevice, IOByte, 1, IOCount, 0);
    IOResult := ReadFile(hDevice, IOByte, 1, IOCount, 0);
    IOResult := ReadFile(hDevice, IOByte, 1, IOCount, 0);
    AddressComboBox.Items.Clear;
    for i := 0 to 15 do
    begin
        Data1 := 128 + i * 8; // Get status command for selected chanel
        IOResult := WriteFile(hDevice, Data1, 1, IOCount, 0);
        IOByte := 0;
        if(BaudRate = 1200) then sleep(200)
        else sleep(200); //DEBUG 20
        IOResult := ReadFile(hDevice, IOByte, 1, IOCount, 0);

        if IOCount > 0 then
        begin
            IOCount := 1;
            AddressComboBox.Items.Add(IntToStr(i));
        end;
    end;
end;

procedure TMainForm.BcloseClick(Sender: TObject);
begin
    try
        sol1.FlushBuffers;
    except

    end;
    Timer1.Enabled := False;
    try
        backup(false);
    except

    end;
    Application.Terminate;
end;

procedure LoadChart(index: integer);
var
    i, j, l: integer;
    k: real;
begin
    MainForm.QStatistika.Active := False;
    if MainForm.ComboBox1.ItemIndex < 0 then
    begin
        MainForm.ComboBox1.ItemIndex := 0; index := 0;
    end;
    case index of
        0: //Общо за периода сума лева
            begin
                MainForm.QStatistika.SQL.Text := 'SELECT  CAST (SUM (SUMABROI) '
                    +
                    'AS CURRENCY) AS BROI1, MIN (SOLARIUM) AS SOLARIUM1,  CAST(MIN (SOLARIUM) as STRING) AS WEEKDAY FROM PLASHTANIA WHERE' +
                    '(DATA BETWEEN "' + MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text + '") ';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;

        1: //Общо за периода брой посещения
            begin
                MainForm.QStatistika.SQL.Text :=
                    'SELECT SUM(STOKA) AS STOKA1, COUNT (*)' +
                    'AS BROI1, MIN (SOLARIUM) AS SOLARIUM1, CAST(MIN (SOLARIUM) as STRING) AS WEEKDAY FROM PLASHTANIA WHERE' +
                    '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text + '")';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;
        2: //Общо за периода брой посещения по солариум
            begin
                MainForm.QStatistika.SQL.Text := 'SELECT  COUNT (*)' +
                    'AS BROI1,SOLARIUM  AS SOLARIUM1,  CAST(SUM (STOKA) as STRING) AS WEEKDAY FROM PLASHTANIA WHERE' +
                    '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") GROUP by SOLARIUM';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;
        3: //Общо за периода посещения като сума лева
            begin
                MainForm.QStatistika.SQL.Text := 'SELECT  CAST (SUM (SUMABROI)'
                    +
                    'AS CURRENCY) AS BROI1, MIN (SOLARIUM) AS SOLARIUM1,  CAST(MIN (SOLARIUM) as STRING) AS WEEKDAY FROM PLASHTANIA WHERE' +
                    '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text + '") ';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;

        4: //Общо за периода посещения като сума лева по солариум
            begin
                MainForm.QStatistika.SQL.Text := 'SELECT  CAST (SUM (SUMABROI)'
                    +
                    'AS CURRENCY) AS BROI1, SOLARIUM AS SOLARIUM1,  CAST(MIN (SOLARIUM) as STRING) AS WEEKDAY FROM PLASHTANIA WHERE' +
                    '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") GROUP BY SOLARIUM';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;

        5: //Общо за периода отработени часове
            begin
                MainForm.QStatistika.SQL.Text :=
                    'SELECT ROUND (SUM(CAST(BROI as float)/60) ,2) ' +
                    'AS BROI1, MIN (SOLARIUM) AS SOLARIUM1,  CAST(MIN (SOLARIUM) as STRING) AS WEEKDAY FROM PLASHTANIA WHERE' +
                    '(SOLARIUM > 0) AND (PLASHTANIA.DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text + '")';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;

        6: //Общо за периода отработени часове по солариуми
            begin
                MainForm.QStatistika.SQL.Text :=
                    '  SELECT   ROUND (SUM(CAST(BROI as float)/60) ,2) ' +
                    'AS BROI1,SOLARIUM AS SOLARIUM1, CAST(SUM (STOKA) as STRING) AS WEEKDAY FROM PLASHTANIA WHERE' +
                    '(SOLARIUM > 0) AND (PLASHTANIA.DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") GROUP BY SOLARIUM';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;

        7: //Общо за периода брой стоки козметика по стока
            begin
                MainForm.QStatistika.SQL.Text := 'SELECT COUNT (*) ' +
                    'AS BROI1, STOKA AS SOLARIUM1, S.WEEKDAY FROM PLASHTANIA P LEFT OUTER JOIN ' +
                    '(SELECT STOKAKOD, STOKAIME AS WEEKDAY FROM STOKI ) S ON P.STOKA = S.STOKAKOD WHERE' +
                    '(STOKA > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") GROUP BY STOKA, WEEKDAY ';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;
        8: //Общо за периода козметика като сума лева
            begin
                MainForm.QStatistika.SQL.Text := 'SELECT CAST (SUM (SUMABROI) '
                    +
                    'AS CURRENCY) AS BROI1, STOKA AS SOLARIUM1, S.WEEKDAY FROM PLASHTANIA P LEFT OUTER JOIN ' +
                    '(SELECT STOKAKOD, STOKAIME AS WEEKDAY FROM STOKI ) S ON P.STOKA = S.STOKAKOD WHERE' +
                    '(STOKA > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") GROUP BY STOKA, WEEKDAY ';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;

        9: //Общо за периода продадени (заредени) карти
            begin
                MainForm.QStatistika.SQL.Text := 'SELECT COUNT (*) ' +
                    'AS BROI1, STOKA AS SOLARIUM1, S.WEEKDAY FROM PLASHTANIA P LEFT OUTER JOIN ' +
                    '(SELECT STOKAKOD, STOKAIME AS WEEKDAY FROM STOKI ) S ON P.STOKA = S.STOKAKOD WHERE' +
                    '(STOKA <-1) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") GROUP BY STOKA, WEEKDAY ';
                MainForm.Chart1.BottomAxis.Labels := False;
            end;
        10: //Работа на солариумите по ден от периода
            begin
                MainForm.QStatistika.SQL.Text :=
                    'SELECT DATA, ROUND (SUM(CAST(BROI as float)/60) ,2) AS BROI1' +
                    ', (SOLARIUM - SOLARIUM) AS SOLARIUM1,  TOSTRING(DATA,"DD/M") AS WEEKDAY FROM PLASHTANIA WHERE '
                    + '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") GROUP BY  WEEKDAY, DATA, SOLARIUM1 order by data';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
        11: //Работа на солариумите по ден от периода по солариум
            begin
                MainForm.QStatistika.SQL.Text :=
                    'SELECT  ROUND (SUM(CAST(BROI as float)/60) ,2) AS BROI1' +
                    ', SOLARIUM AS SOLARIUM1,  TOSTRING(DATA,"DD/M") AS WEEKDAY FROM PLASHTANIA WHERE '
                    + '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") group by data, solarium';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
        12: //Работа на солариумите по ден от седмица общо в лева
            begin
                if MainForm.PlannerMaskDatePicker1.Date >=
                    MainForm.PlannerMaskDatePicker2.Date then
                    MainForm.PlannerMaskDatePicker2.Date :=
                        MainForm.PlannerMaskDatePicker1.Date + 7;
                MainForm.PlannerMaskDatePicker2.Date :=
                    MainForm.PlannerMaskDatePicker2.Date +
                    (DayOfWeek(MainForm.PlannerMaskDatePicker2.Date) -
                    DayOfWeek(MainForm.PlannerMaskDatePicker1.Date));
                MainForm.QStatistika.SQL.Text :=
                    'SELECT   CAST (SUM (SUMABROI) AS CURRENCY) ' +
                    'AS BROI1, CAST(TOSTRING(DATA,"DW") AS INTEGER) AS SOLARIUM1, TOSTRING(DATA,"DW") AS WEEKDAY FROM PLASHTANIA WHERE '
                    + '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") group by wEEKDAY, solarium1';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
        13: //Работа на солариумите по ден от седмицата общо в часове
            begin
                if MainForm.PlannerMaskDatePicker1.Date >=
                    MainForm.PlannerMaskDatePicker2.Date then
                    MainForm.PlannerMaskDatePicker2.Date :=
                        MainForm.PlannerMaskDatePicker1.Date + 7;
                MainForm.PlannerMaskDatePicker2.Date :=
                    MainForm.PlannerMaskDatePicker2.Date +
                    (DayOfWeek(MainForm.PlannerMaskDatePicker2.Date) -
                    DayOfWeek(MainForm.PlannerMaskDatePicker1.Date));
                MainForm.QStatistika.SQL.Text :=
                    'SELECT  ROUND (SUM(CAST(BROI as float)/60) ,2) ' +
                    'AS BROI1, CAST(TOSTRING(DATA,"DW") AS INTEGER) AS SOLARIUM1, TOSTRING(DATA,"DW") AS WEEKDAY FROM PLASHTANIA WHERE '
                    + '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") group by wEEKDAY, solarium1';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
        14: //Работа на солариумите по ден от седмица по солариум в лева
            begin
                if MainForm.PlannerMaskDatePicker1.Date >=
                    MainForm.PlannerMaskDatePicker2.Date then
                    MainForm.PlannerMaskDatePicker2.Date :=
                        MainForm.PlannerMaskDatePicker1.Date + 7;
                MainForm.PlannerMaskDatePicker2.Date :=
                    MainForm.PlannerMaskDatePicker2.Date +
                    (DayOfWeek(MainForm.PlannerMaskDatePicker2.Date) -
                    DayOfWeek(MainForm.PlannerMaskDatePicker1.Date));
                MainForm.QStatistika.SQL.Text :=
                    'SELECT  CAST (SUM(SUMABROI) AS CURRENCY) ' +
                    'AS BROI1, SOLARIUM AS SOLARIUM1,  TOSTRING(DATA,"DW") AS WEEKDAY FROM PLASHTANIA WHERE '
                    + '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") group by wEEKDAY,  solarium1';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
        15: //Работа на солариумите по ден от седмицата общо брой посещения
            begin
                if MainForm.PlannerMaskDatePicker1.Date >=
                    MainForm.PlannerMaskDatePicker2.Date then
                    MainForm.PlannerMaskDatePicker2.Date :=
                        MainForm.PlannerMaskDatePicker1.Date + 7;
                MainForm.PlannerMaskDatePicker2.Date :=
                    MainForm.PlannerMaskDatePicker2.Date +
                    (DayOfWeek(MainForm.PlannerMaskDatePicker2.Date) -
                    DayOfWeek(MainForm.PlannerMaskDatePicker1.Date));
                MainForm.QStatistika.SQL.Text := 'SELECT  COUNT (*)' +
                    'AS BROI1, CAST(TOSTRING(DATA,"DW") AS INTEGER) AS SOLARIUM1, TOSTRING(DATA,"DW") AS WEEKDAY FROM PLASHTANIA WHERE '
                    + '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") group by wEEKDAY, solarium1';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
        16: //Работа на солариумите по ден от седмицата по солариум в часове
            begin
                if MainForm.PlannerMaskDatePicker1.Date >=
                    MainForm.PlannerMaskDatePicker2.Date then
                    MainForm.PlannerMaskDatePicker2.Date :=
                        MainForm.PlannerMaskDatePicker1.Date + 7;
                MainForm.PlannerMaskDatePicker2.Date :=
                    MainForm.PlannerMaskDatePicker2.Date +
                    (DayOfWeek(MainForm.PlannerMaskDatePicker2.Date) -
                    DayOfWeek(MainForm.PlannerMaskDatePicker1.Date));
                MainForm.QStatistika.SQL.Text :=
                    'SELECT  ROUND (SUM(CAST(BROI as float)/60) ,2) ' +
                    'AS BROI1, SOLARIUM AS SOLARIUM1,  TOSTRING(DATA,"DW") AS WEEKDAY FROM PLASHTANIA WHERE '
                    + '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") group by wEEKDAY, solarium';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
        17: //Работа на солариумите по ден от седмицата по солариуми бр. посещения
            begin
                if MainForm.PlannerMaskDatePicker1.Date >=
                    MainForm.PlannerMaskDatePicker2.Date then
                    MainForm.PlannerMaskDatePicker2.Date :=
                        MainForm.PlannerMaskDatePicker1.Date + 7;
                MainForm.PlannerMaskDatePicker2.Date :=
                    MainForm.PlannerMaskDatePicker2.Date +
                    (DayOfWeek(MainForm.PlannerMaskDatePicker2.Date) -
                    DayOfWeek(MainForm.PlannerMaskDatePicker1.Date));
                MainForm.QStatistika.SQL.Text := 'SELECT  COUNT (*)' +
                    'AS BROI1, SOLARIUM AS SOLARIUM1,  TOSTRING(DATA,"DW") AS WEEKDAY FROM PLASHTANIA WHERE '
                    + '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") group by wEEKDAY,  solarium';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
        18: //Работа на солариумите по часове
            begin
                MainForm.QStatistika.SQL.Text :=
                    'SELECT  ROUND (SUM(CAST(BROI as float)/60) ,2) ' +
                    'AS BROI1,SOLARIUM AS SOLARIUM1,  TOSTRING(CHAS,"HH24") AS WEEKDAY FROM PLASHTANIA WHERE' +
                    '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") group by wEEKDAY , solarium ORDER BY WEEKDAY';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
        19: //Работа на солариумите по месеци
            begin
                if MainForm.PlannerMaskDatePicker1.Date >
                    MainForm.PlannerMaskDatePicker2.Date then
                    MainForm.PlannerMaskDatePicker2.Date :=
                        MainForm.PlannerMaskDatePicker1.Date;
                //      MainForm.PlannerMaskDatePicker2.Date:=MainForm.PlannerMaskDatePicker2.Date-
                 //     DayOfTheMonth(MainForm.PlannerMaskDatePicker2.Date)+
                 //     DaysInMonth(YearOf(MainForm.PlannerMaskDatePicker2.Date), MonthOf(MainForm.PlannerMaskDatePicker2.Date));
                //      MainForm.PlannerMaskDatePicker1.Date:=MainForm.PlannerMaskDatePicker1.Date-
                 //     (DayOfTheMonth(MainForm.PlannerMaskDatePicker1.Date)+1);
                MainForm.QStatistika.SQL.Text :=
                    'SELECT  ROUND (SUM(CAST(BROI as float)/60) ,2) ' +
                    'AS BROI1,SOLARIUM AS SOLARIUM1,  TOSTRING(DATA,"YYYY/MM")  AS WEEKDAY FROM PLASHTANIA WHERE' +
                    '(SOLARIUM > 0) AND (DATA BETWEEN "' +
                    MainForm.PlannerMaskDatePicker1.Text +
                    '" AND "' + MainForm.PlannerMaskDatePicker2.Text +
                    '") group by wEEKDAY, solarium ORDER BY WEEKDAY';
                MainForm.Chart1.BottomAxis.Labels := True;
            end;
    end;

    MainForm.QStatistika.Active := True;

end;

procedure TMainForm.RzCheckBox1Click(Sender: TObject);
var
    i: integer;
begin
    {if MainForm.RzCheckBox1.Checked=true then
     begin
      i:=  DayOf(PlannerMaskDatePicker1.Date);
      if PlannerMaskDatePicker1.Date>=PlannerMaskDatePicker2.Date then PlannerMaskDatePicker2.Date:=PlannerMaskDatePicker1.Date;
      RecodeYear(PlannerMaskDatePicker1.Date,(YearOf(PlannerMaskDatePicker2.Date)-1));
      RecodeMonth(PlannerMaskDatePicker1.Date,MonthOf(PlannerMaskDatePicker2.Date));
      RecodeDay(PlannerMaskDatePicker1.Date,1);
      PlannerMaskDatePicker2.Date:=EndOfTheMonth(PlannerMaskDatePicker2.Date);
     end;
    LoadChart;}
end;

procedure TMainForm.SolariumiInfo8Show(Sender: TObject);
begin
    ImageName := SOLARIUMI.FieldByName('PICTURE').AsString;
    if FileExists(ImageName) then
        Image16.Picture.LoadFromFile(ImageName);
    Image18.Picture := Image16.Picture;
    Label115.Caption := IntToStr(SOLARIUMI.RecNo);
    Label116.Caption := IntToStr(SOLARIUMI.RecNo);
    Label117.Caption := IntToStr(SOLARIUMI.RecNo);
end;

procedure TMainForm.LMDButton15Click(Sender: TObject);
begin
    //if Application.MessageBox(PChar('Ще бъдат изтрити всички издадени клубни карти!?'),PChar('Карти?!'),MB_OKCANCEL		)=IDOK	 then
    if Application.MessageBox(PChar(GetMessage('M64')),
        PChar(GetMessage('M65')), MB_OKCANCEL) = IDOK then
    begin
        MainForm.Timer1.Enabled := false;
        MainForm.sol1.FlushBuffers;
        MainForm.sol1.Close;
        Kartiall.EmptyTable;
        MainForm.sol1.Connected := false;
        MainForm.sol1.Connected := false;
        Sleep(1000);
        MainForm.sol1.Connected := false;
        MainForm.sol1.Connected := false;
        MainForm.sol1.Connected := false;
        MainForm.sol1.Connected := false;
        MainForm.sol1.CompactDatabase();
        OpenTables;
        MainForm.Timer1.Enabled := true;
    end;
end;

procedure TMainForm.LMDButton1Click(Sender: TObject);
var
    ime1: string;
    Karta: Integer;
    Nomer: Integer;
    i: Integer;
begin
    if not QKLIENTI.IsEmpty then
    begin
        Nomer := 0;
        Ime1 := QKLIENTI.FieldValues['IME'];
        Karta := QKLIENTI.FieldValues['NOMER'];
        if QKLIENTI.FieldValues['NOMER2'] = null then
        begin
            QKLIENTI.Edit;
            QKLIENTI.FieldValues['NOMER2'] := 1;
            QKLIENTI.Post;
        end;
        QKLIENTI.First;
        for i := 0 to QKLIENTI.RecordCount - 1 do
        begin
            if (Nomer <= QKLIENTI.FieldValues['NOMER2']) then
                Nomer := QKLIENTI.FieldValues['NOMER2'];
            QKLIENTI.Next;
        end;
        Nomer := Nomer + 1;
        if(sol1.InTransaction) then sol1.commit(true);
        sol1.StartTransaction;
        try
            QKLIENTI.Append;
            QKLIENTI.FieldValues['Firma'] := Firmite.FieldValues['NOMER'];
            QKLIENTI.FieldValues['NOMER2'] := Nomer;
            QKLIENTI.FieldValues['NOMER'] := Karta;
            QKLIENTI.FieldValues['IME'] := 'Нов Служителужител ' +
                inttostr(Nomer);
            QKLIENTI.Post;
            sol1.Commit();
        except
            sol1.Rollback;
        end;
    end
    else
        Application.MessageBox(PChar('Избраната фирма няма нито една карта!'),
            PChar(''))
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
    Timer2Time := Timer2Time + 1;
    if Timer2Time > 16 then
    begin
        Timer2.Enabled := False;
        Timer1.Interval := 1000;
        TimerTime1 := 0;
        Timer1.Enabled := True;
    end
    else
        label64.Caption := leftstr('Solar studio 1.2', Timer2Time);
end;

procedure TMainForm.BHelpClick(Sender: TObject);
var
    S1: string;
    S2: string;
begin
    S1 := AnsiReplaceStr(Application.ExeName, 'exe', 'htm');
    S2 := ExtractFilePath(Application.ExeName);

    //ShellExecute( testform.ParentWindow, PChar('open'),PChar('f:\SolarStudio1\SolarStudio1.htm'),PChar(''),'F:\SolarStudio1', sw_ShowNormal );
    ShellExecute(MainForm.ParentWindow, PChar('open'), PChar(S1), PChar(''),
        PChar(S2), sw_ShowNormal);

end;

procedure TMainForm.SolariumiCeni9Show(Sender: TObject);
begin
    Label117.Caption := IntToStr(SOLARIUMI.RecNo);
    QCeni.Active := False;
    QCeni.SQL.Text := ('select * from TABLICA_CENI where SOLARIUM = ' +
        IntToStr(SOLARIUMI.RecNo + 100));
    QCeni.Active := True;
end;

procedure TMainForm.ComboBox1Change(Sender: TObject);
begin
    LoadChart(ComboBox1.ItemIndex);
end;

procedure TMainForm.ComboBox2Change(Sender: TObject);
begin
    Qklienti.RecNo := ComboBox2.ItemIndex + 1;
end;


Procedure TMainForm.Protokol13Show(Sender: TObject);
begin
    DayTotal.Last;
    if PasswordForm.ModalResult = MROK then
        DBLUCombo1.Visible := true
    else
        DBLUCombo1.Visible := false;
end;

procedure TMainForm.PaymentOKLabelMouseDown(Sender: TObject; Button:
    TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin
    PaymentOKLabel.Top := PaymentOKLabel.Top + 3;
    PaymentOKLabelClick(sender);
end;

procedure TMainForm.PaymentOKLabelMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin
    PaymentOKLabel.Top := PaymentOKLabel.Top - 3;
end;

procedure TMainForm.StatistikaBox1Click(Sender: TObject);
begin
    if StatistikaBox1.Checked = true then
    begin
        wwDBGrid10.Visible := True;
        chart1.Left := 220;
        chart1.Width := chart1.Width - (220 - 16);
    end
    else
    begin
        wwDBGrid10.Visible := False;
        chart1.Left := 16;
        chart1.Width := chart1.Width + (220 - 16);
    end;
end;

procedure TMainForm.Label21Click(Sender: TObject);
begin
    // if MainForm.Label21.color=clblack then
    if(PasswordForm.IsMaster = true) then
    begin
        Image32.Picture := image50.Picture;
        AdvPageControl1.ActivePageIndex := 10;
    end;
end;

procedure TMainForm.Label2Click(Sender: TObject);
var
    CopyStatus: Boolean;
    FileName1: string;
    FileName2: string;
begin
    OpenDialog1.Execute;
    if OpenDialog1.Files.Count > 0 then
    begin
        MainForm.Timer1.Enabled := false;
        MainForm.sol1.FlushBuffers;
        MainForm.sol1.Close;
        FileName2 := LeftStr(Application.ExeName, 2) + '\SolarStudio1\data\solarbas.ABS';
        FileName1 := OpenDialog1.Files.Strings[0];
        CopyStatus := CopyFIle(PChar(FileName1), PChar(FileName2), False);
        if CopyStatus then
            Application.MessageBox(PChar('Разархивиране ... успешно!'),
                PChar('Разархивиране'), MB_OK)
        else
            Application.MessageBox(PChar('Разархивиране ... Грешка!'),
                PChar('Разархивиране'), MB_OK);
        Backuped := True;
        OpenTables;
    end;
end;

procedure TMainForm.Label3Click(Sender: TObject);
var
    CopyStatus: Boolean;
    FileName1: string;
    FileName2: string;
begin
    SaveDialog1.Execute;
    if SaveDialog1.Files.Count > 0 then
    begin
        Timer1.Enabled := False;
        MainForm.sol1.FlushBuffers;
        MainForm.sol1.Close;
        FileName1 := sol1.DatabaseFileName;
        FileName2 := SaveDialog1.Files.Strings[0];
        CopyStatus := CopyFIle(PChar(FileName1), PChar(FileName2), False);
        if CopyStatus then
            Application.MessageBox(PChar('Архивиране на данните... успешно!'),
                PChar('Архивиране'), MB_OK)
        else
            Application.MessageBox(PChar('Архивиране на данните... Грешка!'),
                PChar('Архивиране'), MB_OK);
        Backuped := True;
        OpenTables;
        Timer1.Enabled := True;
    end;
end;

procedure TMainForm.FirmaComboCloseUp(Sender: TObject);
begin
    if QKLIENTI.State in [dsEdit, dsInsert] then
        QKLIENTI.Post;

end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Timer1.Enabled := False;
    backup(false);
    //sol1.Close;
  //  IniFile.Free;
    EndLang();
end;

procedure TMainForm.Image2MouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin
    FormMoveStarted := true;
    FormMoveStartY := Y; //-MainForm.Top;
    FormMoveStartX := X; //-MainForm.Left;
end;

procedure TMainForm.Image2MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin
    FormMoveStarted := false;
end;

procedure TMainForm.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
begin
    if FormMoveStarted then
    begin
        MainForm.Top := MainForm.Top + Y - FormMoveStartY;
        MainForm.Left := MainForm.Left + X - FormMoveStartX;
    end;
end;

procedure TMainForm.Planner1HeaderDblClick(Sender: TObject;
    SectionIndex: Integer);
begin
    PlannerDatePicker1.Date := dateof(now);
end;

procedure TMainForm.Planner2HeaderDblClick(Sender: TObject;
    SectionIndex: Integer);
begin
    PlannerDatePicker1.Date := PlannerDatePicker1.Date + 1;
end;

procedure TMainForm.PlannerDatePicker1Change(Sender: TObject);
begin
    DBDaySource1.Day := PlannerDatePicker1.Date;
    DBDaySource2.Day := PlannerDatePicker1.Date + 1;
    DBDaySource3.Day := PlannerDatePicker1.Date + 2;
end;

procedure TMainForm.PlannerMaskDatePicker1DaySelect(Sender: TObject;
    SelDate: TDateTime);
begin
    PlannerMaskDatePicker2Change(sENDER);
end;

procedure TMainForm.PlannerMaskDatePicker2DaySelect(Sender: TObject;
    SelDate: TDateTime);
begin
    PlannerMaskDatePicker2Change(Sender);
end;

procedure TMainForm.Statistika12Show(Sender: TObject);
begin
    ComboBox1.Clear;
    ComboBox1.Text := GetMessage('M63');
    ComboBox1.Items.Add(GetMessage('M43'));
    ComboBox1.Items.Add(GetMessage('M44'));
    ComboBox1.Items.Add(GetMessage('M45'));
    ComboBox1.Items.Add(GetMessage('M46'));
    ComboBox1.Items.Add(GetMessage('M47'));
    ComboBox1.Items.Add(GetMessage('M48'));
    ComboBox1.Items.Add(GetMessage('M49'));
    ComboBox1.Items.Add(GetMessage('M50'));
    ComboBox1.Items.Add(GetMessage('M51'));
    ComboBox1.Items.Add(GetMessage('M52'));
    ComboBox1.Items.Add(GetMessage('M53'));
    ComboBox1.Items.Add(GetMessage('M54'));
    ComboBox1.Items.Add(GetMessage('M55'));
    ComboBox1.Items.Add(GetMessage('M56'));
    ComboBox1.Items.Add(GetMessage('M57'));
    ComboBox1.Items.Add(GetMessage('M58'));
    ComboBox1.Items.Add(GetMessage('M59'));
    ComboBox1.Items.Add(GetMessage('M60'));
    ComboBox1.Items.Add(GetMessage('M61'));
    ComboBox1.Items.Add(GetMessage('M62'));

end;

procedure TMainForm.DBComboBox4Change(Sender: TObject);
begin
    SOLARIUMI.FieldValues['LAMPILASTDATE'] := DateOf(now);
end;

procedure TMainForm.DBComboBox5Change(Sender: TObject);
begin
    SOLARIUMI.FieldValues['LICEVILASTDATE'] := DateOf(now);
end;

procedure TMainForm.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
    if Key > #31 then

    begin
        if LastKey = '?' then
        begin
            keyBuff := '';
        end;
        KeyBuff := KeyBuff + Key;
        lastKey := Key;
        if (AnsiContainsStr(keyBuff, '+')) and (key = '?') then
        begin
            edit6.text := rightstr(leftstr(KeyBuff, 5), 4);
            Key := #0;
        end;
    end;
end;

procedure TMainForm.Timer3Timer(Sender: TObject);
var
    tmp: Integer;
begin
    Timer3.Enabled := false;
    if AdvPageControl1.ActivePageIndex in [3, 15, 18] then
        SLE4442ShowCardInPaiment();
    if (AdvPageControl1.ActivePageIndex in [3]) then
        CalcPaid;
end;

procedure TMainForm.Timer4Timer(Sender: TObject);
begin
    DayTotal.Last; //Za Gluposti
    Timer4.Enabled := False;
end;

procedure TMainForm.Timer6Timer(Sender: TObject);
begin
    Timer6.Enabled := false
end;

procedure TMainForm.TipNaRabotaComboChange(Sender: TObject);
begin
  TipNaRabotaCombo.Tag := 1;
end;

procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
    Planner1.Display.DisplayScale := TrackBar1.Position;
    Planner2.Display.DisplayScale := Round(TrackBar1.Position * 0.6);
    Planner3.Display.DisplayScale := Round(TrackBar1.Position * 0.6);
end;

procedure TMainForm.PopalniCeniTableButton2Click(Sender: TObject);
begin
    QCeni.First;
    while (not QCeni.Eof) do
    begin
        QCeni.Edit;
        QCeni.FieldValues['CENA'] := solariumi.FieldValues['CENA'];
        QCeni.Post;
        QCeni.Next;
    end;
end;

procedure TMainForm.PopalniCeniTableButtonClick(Sender: TObject);
var
    i1: Integer;
begin
    CeniTable.First;
    while (not CeniTable.Eof) do
    begin
        CeniTable.Edit;
        CeniTable.FieldValues['CENA'] := CeniTable.FieldValues['MINUTA'] *
            solariumi.FieldValues['CENA'];
        CeniTable.Post;
        CeniTable.Next;
    end;
end;

procedure TMainForm.PosEditEnter(Sender: TObject);
begin
    //if not(PasswordForm.ModalResult=MROK) then
    //if not (LMDDBLabeledMaskEdit1.Font.Color=clRed) then
      // PasswordForm.ShowModal;

end;

procedure TMainForm.Button111Click(Sender: TObject);
var
    q: TABSQuery;
begin
    if (PasswordForm.ModalResult = MROK) or (PasswordForm.ShowModal = MROK) then
    begin
        q := TABSQuery.Create(nil);
        q.Databasename := 'sol1';
        q.ReadOnly := False;
        q.RequestLive := True;
        q.SQL.SetText(PChar('SELECT * FROM kartichip WHERE KLIENTNOMER = ' +
            IntToStr(QKLIENTI.FieldValues['NOMER'])));
        q.open;
        if q.IsEmpty and (QKLIENTI.FieldValues['NOMER'] > 0) then
        begin
            VipDiscount := 0;
            q.Append;
            q.FieldValues['KLIENTNOMER'] := QKLIENTI.FieldValues['NOMER'];
            q.FieldValues['COUNTER'] := 0;
            q.FieldValues['DISCOUNT'] := 0;
            q.FieldValues['SUMA'] := 0;
            q.Post;
            QKLIENTI.Next;
            QKLIENTI.Prior;
        end;
    end;
end;

function TMainForm.GetStudioWorkType(): Integer;
begin
    result := TipNaRabotaIndex;
end;

end.

