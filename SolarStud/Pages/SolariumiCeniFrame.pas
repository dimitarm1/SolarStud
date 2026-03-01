unit SolariumiCeniFrame;

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
  TSolariumiCeniFrame = class(TFrame)
    Image17: TImage;
    LMDLImage107: TLMDLImage;
    LMDLImage106: TLMDLImage;
    LMDLImage110: TLMDLImage;
    LMDLImage109: TLMDLImage;
    LMDLImage108: TLMDLImage;
    LMDLImage55: TLMDLImage;
    LMDLImage54: TLMDLImage;
    Image31: TImage;
    Image30: TImage;
    Label50: TLabel;
    Label49: TLabel;
    Label48: TLabel;
    Label114: TLabel;
    Label117: TLabel;
    Label59: TLabel;
    Label73: TLabel;
    Label93: TLabel;
    Label118: TLabel;
    Label97: TLabel;
    Label53: TLabel;
    LMDLImage113: TLMDLImage;
    Label32: TLabel;
    Label28: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit6: TDBEdit;
    CeniGrid: TwwDBGrid;
    PopalniCeniTableButton: TRzButton;
    wwDBGrid8: TwwDBGrid;
    PopalniCeniTableButton2: TRzButton;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

end.
