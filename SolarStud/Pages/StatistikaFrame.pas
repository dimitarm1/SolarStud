unit StatistikaFrame;

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
  TStatistikaFrame = class(TFrame)
    Image33: TImage;
    LMDLImage70: TLMDLImage;
    LMDLImage69: TLMDLImage;
    LMDLImage68: TLMDLImage;
    Label147: TLabel;
    Label150: TLabel;
    Label108: TLabel;
    Label68: TLabel;
    Label148: TLabel;
    LMDLImage127: TLMDLImage;
    LMDLImage128: TLMDLImage;
    LMDLImage131: TLMDLImage;
    PlannerMaskDatePicker1: TPlannerMaskDatePicker;
    PlannerMaskDatePicker2: TPlannerMaskDatePicker;
    Chart1: TChart;
    Series1: TBarSeries;
    ComboBox1: TComboBox;
    wwDBGrid10: TwwDBGrid;
    StatistikaBox1: TRzCheckBox;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

end.
