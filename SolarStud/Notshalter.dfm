object NotshalterForm: TNotshalterForm
  Left = 192
  Top = 107
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1040#1074#1072#1088#1080#1077#1085' '#1096#1072#1083#1090#1077#1088
  ClientHeight = 252
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LMDLImage91: TLMDLImage
    Left = 0
    Top = 0
    Width = 502
    Height = 257
    Bevel.Mode = bmCustom
    ForceTransparent = True
    ImageList = MainForm.LMDImageList4
    Style = sbStretch
  end
  object Bevel1: TBevel
    Left = 32
    Top = 151
    Width = 441
    Height = 57
  end
  object Bevel2: TBevel
    Left = 192
    Top = 154
    Width = 113
    Height = 25
    Shape = bsFrame
  end
  object Bevel3: TBevel
    Left = 192
    Top = 178
    Width = 113
    Height = 25
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 168
    Top = 46
    Width = 153
    Height = 38
    Caption = #1050#1040#1041#1048#1053#1040' ?'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -27
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 152
    Top = 94
    Width = 197
    Height = 30
    Caption = #1040#1074#1072#1088#1080#1077#1085' '#1096#1072#1083#1090#1077#1088
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Arial Black'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 155
    Top = 96
    Width = 197
    Height = 30
    Caption = #1040#1074#1072#1088#1080#1077#1085' '#1096#1072#1083#1090#1077#1088
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = 'Arial Black'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
  end
  object Shape1: TShape
    Left = 36
    Top = 154
    Width = 113
    Height = 49
    Pen.Color = clLime
    Pen.Style = psInsideFrame
    Pen.Width = 4
  end
  object Shape2: TShape
    Left = 347
    Top = 154
    Width = 113
    Height = 49
    Pen.Color = clRed
    Pen.Style = psInsideFrame
    Pen.Width = 4
  end
  object Label4: TLabel
    Left = 200
    Top = 159
    Width = 97
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = #1058#1045#1057#1058
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    Transparent = True
    OnClick = Label4Click
  end
  object Label5: TLabel
    Left = 200
    Top = 183
    Width = 97
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1040#1059#1047#1040
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    Transparent = True
    OnClick = Label5Click
  end
  object Panel1: TPanel
    Left = 41
    Top = 160
    Width = 104
    Height = 38
    Caption = #1057#1058#1040#1056#1058
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Panel1Click
  end
  object Panel2: TPanel
    Left = 354
    Top = 160
    Width = 103
    Height = 38
    Caption = #1057#1058#1054#1055
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Panel2Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 80
    OnTimer = Timer1Timer
    Left = 72
    Top = 40
  end
end
