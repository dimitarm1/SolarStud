object RefillForm: TRefillForm
  Left = 192
  Top = 107
  HorzScrollBar.Visible = False
  Caption = #1047#1072#1088#1077#1078#1076#1072#1085#1077
  ClientHeight = 244
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LMDLImage91: TLMDLImage
    Left = 0
    Top = 0
    Width = 502
    Height = 249
    Bevel.Mode = bmCustom
    ForceTransparent = True
    ImageList = MainForm.LMDImageList4
    Style = sbStretch
  end
  object Label1: TLabel
    Left = 29
    Top = 19
    Width = 80
    Height = 22
    Caption = #1050#1072#1088#1090#1072'  '#8470
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 343
    Top = 17
    Width = 143
    Height = 210
  end
  object Shape1: TShape
    Left = 354
    Top = 42
    Width = 113
    Height = 49
    Pen.Color = clLime
    Pen.Style = psInsideFrame
    Pen.Width = 4
  end
  object Shape2: TShape
    Left = 353
    Top = 154
    Width = 113
    Height = 49
    Pen.Color = clRed
    Pen.Style = psInsideFrame
    Pen.Width = 4
  end
  object Label2: TLabel
    Left = 24
    Top = 181
    Width = 140
    Height = 22
    Caption = #1062#1077#1085#1072' '#1085#1072' '#1082#1072#1088#1090#1072#1090#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 24
    Top = 209
    Width = 219
    Height = 22
    Caption = #1057#1091#1084#1072' '#1079#1072#1088#1077#1076#1077#1085#1072' '#1074' '#1082#1072#1088#1090#1072#1090#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object DBText2: TDBText
    Left = 229
    Top = 177
    Width = 101
    Height = 26
    Alignment = taRightJustify
    DataField = 'STOKACENA'
    DataSource = MainForm.DataSource6
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
  end
  object DBText1: TDBText
    Left = 239
    Top = 209
    Width = 91
    Height = 26
    Alignment = taRightJustify
    DataField = 'SUMA'
    DataSource = MainForm.DataSource6
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 29
    Top = 48
    Width = 60
    Height = 22
    Caption = #1050#1083#1080#1077#1085#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 88
    Top = 109
    Width = 134
    Height = 22
    Caption = #1042#1080#1076' '#1085#1072' '#1082#1072#1088#1090#1072#1090#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object Panel1: TPanel
    Left = 360
    Top = 48
    Width = 103
    Height = 38
    Caption = #1044#1040
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Panel1Click
  end
  object Panel2: TPanel
    Left = 359
    Top = 160
    Width = 103
    Height = 39
    Caption = #1053#1045
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Panel2Click
  end
  object DBEdit1: TDBEdit
    Left = 24
    Top = 78
    Width = 297
    Height = 26
    DataField = 'IME'
    DataSource = MainForm.DataSource2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object Edit1: TMaskEditEx
    Left = 115
    Top = 17
    Width = 206
    Height = 26
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Version = '1.2.0.0'
  end
  object DBLUCombo2: TDBLUCombo
    Left = 24
    Top = 137
    Width = 297
    Height = 26
    Color = clWindow
    Version = '2.2.0.1'
    Visible = True
    ButtonWidth = 18
    Ctl3D = True
    DropWidth = 0
    Enabled = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsItalic]
    ItemIndex = 0
    ItemHeight = 18
    Items.Strings = (
      #1063#1080#1087' '#1082#1072#1088#1090#1072'  90 '#1084#1080#1085'. 180W'
      #1063#1080#1087' '#1082#1072#1088#1090#1072' '#1079#1072' 120 '#1084#1080#1085'. 180W'
      #1044#1077#1087#1086#1079#1080#1090' '#1079#1072'   '#1095#1080#1087'-'#1082#1072#1088#1090#1072' '
      #1063#1080#1087' '#1082#1072#1088#1090#1072' '#1079#1072' 120 '#1084#1080#1085'. 240W'
      #1063#1080#1087' '#1082#1072#1088#1090#1072' '#1079#1072' 240 '#1084#1080#1085'. 180W'
      #1063#1080#1087' '#1082#1072#1088#1090#1072' '#1079#1072' 60 '#1084#1080#1085'. 240W'
      #1063#1080#1087' '#1082#1072#1088#1090#1072' '#1079#1072' 90 '#1084#1080#1085'. 240W'
      #1063#1080#1087' '#1082#1072#1088#1090#1072' '#1079#1072' 240 '#1084#1080#1085'. 240W'
      #1053#1086#1074#1072' '#1050#1083#1091#1073#1085#1072' '#1082#1072#1088#1090#1072'-20'
      #1053#1086#1074#1072' '#1050#1083#1091#1073#1085#1072' '#1082#1072#1088#1090#1072'-21'
      #1063#1080#1087' '#1082#1072#1088#1090#1072' '#1079#1072' 540 '#1083#1074'.'
      #1050#1072#1088#1090#1072' '#1079#1072' 280 '#1087#1086#1089#1077#1097#1077#1085#1080#1103)
    LabelPosition = lpLeftCenter
    LabelTransparent = True
    LabelFont.Charset = RUSSIAN_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -16
    LabelFont.Name = 'Verdana'
    LabelFont.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
    Text = #1063#1080#1087' '#1082#1072#1088#1090#1072'  90 '#1084#1080#1085'. 180W'
    AutoHistory = False
    AutoHistoryLimit = 0
    AutoHistoryDirection = ahdFirst
    AutoSynchronize = True
    ReturnIsTab = False
    FileLookup = False
    Persist.Enable = False
    Persist.Storage = stInifile
    Persist.Count = 0
    Persist.MaxCount = False
    MatchCase = False
    ModifiedColor = clHighlight
    ShowModified = False
    DataField = 'STOKAIME'
    DataSource = MainForm.DataSource6
    DataLookup = True
    LookUpMode = lmGoto
    ReadOnly = True
  end
  object MaskEdit2: TMaskEditEx
    Left = 115
    Top = 48
    Width = 206
    Height = 26
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Version = '1.2.0.0'
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    Top = 216
  end
end
