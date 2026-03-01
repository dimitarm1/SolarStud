unit SolariumiNastroikiFrame;

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
  TSolariumiNastroikiFrame = class(TFrame)
    Image11: TImage;
    LMDLImage101: TLMDLImage;
    LMDLImage100: TLMDLImage;
    LMDLImage111: TLMDLImage;
    LMDLImage90: TLMDLImage;
    LMDLImage91: TLMDLImage;
    LMDLImage53: TLMDLImage;
    LMDLImage52: TLMDLImage;
    Label61: TLabel;
    Image27: TImage;
    Image26: TImage;
    Label51: TLabel;
    Label45: TLabel;
    Label44: TLabel;
    Label43: TLabel;
    Label41: TLabel;
    Label39: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    Label36: TLabel;
    Label35: TLabel;
    Label34: TLabel;
    Label31: TLabel;
    Image16: TImage;
    Label96: TLabel;
    Label115: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label30: TLabel;
    Label67: TLabel;
    LMDLImage99: TLMDLImage;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label90: TLabel;
    DBText11: TDBText;
    Label106: TLabel;
    DBText12: TDBText;
    DBComboBox8: TDBComboBox;
    DBComboBox5: TDBComboBox;
    DBComboBox4: TDBComboBox;
    DBComboBox3: TDBComboBox;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    LMDDBCheckBox1: TLMDDBCheckBox;
    DBComboBox6: TDBComboBox;
    AddressComboBox: TDBComboBox;
    LMDButton16: TLMDButton;
    LMDButton17: TLMDButton;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

end.
