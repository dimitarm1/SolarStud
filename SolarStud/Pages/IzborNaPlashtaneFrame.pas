unit IzborNaPlashtaneFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Buttons, Mask,
  ComCtrls, jpeg, DB, Gauges,
  // LMD components
  LMDControl, LMDBaseControl, LMDBaseGraphicControl, LMDGraphicControl,
  LMDCustomLImage, LMDLImage, LMDBaseImage, LMDCustomNImage, LMDNImage,
  LMDLEDCustomLabel, LMDLEDLabel, LMDCustomButton, LMDButton,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel,
  LMDBaseGraphicButton, LMDCustomShapeButton, LMDShapeButton,
  LMDCustomCheckBox, LMDDBCheckBox, LMDCheckBox,
  LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDDBMaskEdit, LMDDBEdit,
  LMDCustomMemo, LMDMemo,
  LMDCustomImageList, LMDImageList,
  // Woll2Woll components
  Wwdbgrid, wwdbedit, wwdblook, Wwdbcomb, wwradiogroup, wwcheckbox, Wwdotdot, wwclearpanel,
  // TMS components
  AdvCombo, AdvEdit, AdvPageControl, AdvToolBtn, AdvEdBtn, AdvDBLookupComboBox,
  // Raize components  
  RzButton, RzRadChk, RzDBDTP, RzDBCmbo, RzLabel, RzEdit, RzDBEdit,
  RzBorder, RzStatus, RzBmpBtn, RzCmboBx,
  // Planner components
  Planner, DBPlanner, PlannerDatePicker, PlanSimpleEdit, PlanItemEdit, PlannerMaskDatePicker,
  // Chart components
  Chart, TeEngine, TeeProcs, Series, DBChart;

type
  TIzborNaPlashtaneFrame = class(TFrame)
    Image4: TImage;
    LMDLImage105: TLMDLImage;
    LMDLImage104: TLMDLImage;
    LMDLImage103: TLMDLImage;
    LMDLImage2: TLMDLImage;
    LMDLImage102: TLMDLImage;
    LMDLImage83: TLMDLImage;
    Bevel3: TBevel;
    Label27: TLabel;
    Label26: TLabel;
    Label25: TLabel;
    Label62: TLMDLEDLabel;
    Label105: TLabel;
    Label130: TLabel;
    Label119: TLabel;
    Label127: TLabel;
    Bevel1: TBevel;
    Label149: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label113: TLabel;
    Bevel2: TBevel;
    Label71: TLabel;
    Label72: TLabel;
    DBText4: TDBText;
    DBText8: TDBText;
    Label29: TLabel;
    Gauge2: TGauge;
    PaymentOKLabel: TLabel;
    LMDLImage80: TLMDLImage;
    LMDLImage81: TLMDLImage;
    LMDLImage82: TLMDLImage;
    LMDLImage35: TLMDLImage;
    LMDLImage120: TLMDLImage;
    LMDLImage121: TLMDLImage;
    Label103: TLabel;
    Label60: TLabel;
    Label104: TLabel;
    LMDNImage1: TLMDNImage;
    LMDNImage2: TLMDNImage;
    LMDNImage3: TLMDNImage;
    Label155: TLabel;
    DBText13: TDBText;
    Bevel4: TBevel;
    VipLabel: TDBText;
    bonusLabel: TLabel;
    DBText9: TDBText;
    DBText14: TDBText;
    Label156: TLabel;
    Label158: TLabel;
    PriceCardLabel4: TLMDLEDLabel;
    PriceCardLabel3: TLabel;
    AdvComboBox1: TAdvComboBox;
    Edit1: TEdit;
    AdvComboBox2: TAdvComboBox;
    LMDMemo1: TMemo;
    DBText7: TComboBox;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

end.
