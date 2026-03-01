unit MenuStokiFrame;

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
  TMenuStokiFrame = class(TFrame)
    Image56: TImage;
    LMDLImage65: TLMDLImage;
    LMDLImage64: TLMDLImage;
    LMDLImage20: TLMDLImage;
    LMDLImage19: TLMDLImage;
    LMDSimpleLabel2: TLMDSimpleLabel;
    Label123: TLabel;
    LMDLImage21: TLMDLImage;
    Label88: TLabel;
    Label124: TLabel;
    DobaviStokaBtn: TLabel;
    StokaEditBtn: TLabel;
    StokiteTab: TAdvPageControl;
    AdvTabSheet20: TAdvTabSheet;
    wwDBGrid3: TwwDBGrid;
    AdvTabSheet21: TAdvTabSheet;
    wwDBGrid4: TwwDBGrid;
    AdvTabSheet22: TAdvTabSheet;
    wwDBGrid11: TwwDBGrid;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

end.
