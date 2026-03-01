unit MenuKasaFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Buttons, Mask,
  ComCtrls, jpeg, DB,
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
  TMenuKasaFrame = class(TFrame)
    Image55: TImage;
    LMDLImage30: TLMDLImage;
    LMDLImage94: TLMDLImage;
    LMDLImage29: TLMDLImage;
    LMDLImage28: TLMDLImage;
    Image63: TImage;
    Image61: TImage;
    LMDSimpleLabel3: TLMDSimpleLabel;
    Label6: TLabel;
    Label111: TLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDLImage25: TLMDLImage;
    LMDLImage26: TLMDLImage;
    LMDNImage5: TLMDNImage;
    LMDSimpleLabel7: TLMDSimpleLabel;
    LMDLImage27: TLMDLImage;
    LMDSimpleLabel8: TLMDSimpleLabel;
    DBText15: TDBText;
    DBText16: TDBText;
    DBText17: TDBText;
    Label165: TLabel;
    Label166: TLabel;
    DBText18: TDBText;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    wwDBGrid9: TwwDBGrid;
    KasaGrid: TwwDBGrid;
    Memo1: TMemo;
    ComboBox2: TComboBox;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

end.
