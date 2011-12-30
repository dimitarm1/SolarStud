object SLE4432_4442Main: TSLE4432_4442Main
  Left = 192
  Top = 107
  Width = 676
  Height = 514
  Caption = 'Card 4442 '
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 77
    Height = 16
    Caption = 'Card Status'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 32
    Width = 96
    Height = 14
    Caption = #1048#1084#1077' '#1085#1072' '#1089#1090#1091#1076#1080#1086#1090#1086
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 56
    Width = 110
    Height = 14
    Caption = #1053#1086#1084#1077#1088' '#1085#1072' '#1089#1090#1091#1076#1080#1086#1090#1086
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 80
    Width = 73
    Height = 14
    Caption = #1048#1084#1077' '#1082#1083#1080#1077#1085#1090#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 8
    Top = 104
    Width = 39
    Height = 14
    Caption = #1041#1072#1083#1072#1085#1089
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 8
    Top = 128
    Width = 43
    Height = 14
    Caption = 'PIN '#1082#1086#1076
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 8
    Top = 152
    Width = 89
    Height = 14
    Caption = #1053#1086#1084#1077#1088' '#1085#1072' '#1082#1072#1088#1090#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object mMsg: TRichEdit
    Left = 264
    Top = 8
    Width = 313
    Height = 289
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object bReset: TButton
    Left = 440
    Top = 320
    Width = 59
    Height = 25
    Caption = 'R&eset'
    TabOrder = 1
    OnClick = bResetClick
  end
  object bQuit: TButton
    Left = 512
    Top = 320
    Width = 57
    Height = 25
    Caption = '&Quit'
    TabOrder = 2
    OnClick = bQuitClick
  end
  object gbFunction: TGroupBox
    Left = 0
    Top = 200
    Width = 249
    Height = 281
    Caption = 'Functions'
    TabOrder = 3
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 43
      Height = 14
      Caption = 'Address'
    end
    object Label3: TLabel
      Left = 144
      Top = 24
      Width = 39
      Height = 14
      Caption = 'Length'
    end
    object Label4: TLabel
      Left = 16
      Top = 56
      Width = 71
      Height = 14
      Caption = 'Data (String)'
    end
    object tLen: TEdit
      Left = 192
      Top = 24
      Width = 41
      Height = 22
      MaxLength = 2
      TabOrder = 0
      OnExit = tLenExit
      OnKeyPress = tLenKeyPress
      OnKeyUp = tLenKeyUp
    end
    object tData: TEdit
      Left = 16
      Top = 72
      Width = 217
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 256
      ParentFont = False
      TabOrder = 1
    end
    object bRead: TButton
      Left = 136
      Top = 112
      Width = 97
      Height = 25
      Caption = '&Read'
      TabOrder = 2
      OnClick = bReadClick
    end
    object bWrite: TButton
      Left = 136
      Top = 152
      Width = 97
      Height = 25
      Caption = '&Write'
      TabOrder = 3
      OnClick = bWriteClick
    end
    object tAdd: TEdit
      Left = 64
      Top = 24
      Width = 33
      Height = 22
      MaxLength = 2
      TabOrder = 4
      OnKeyPress = tAddKeyPress
      OnKeyUp = tAddKeyUp
    end
    object bWriteProt: TButton
      Left = 16
      Top = 152
      Width = 97
      Height = 25
      Caption = 'Write &Protect'
      TabOrder = 5
      OnClick = bWriteProtClick
    end
    object bSubmit: TButton
      Left = 16
      Top = 192
      Width = 97
      Height = 25
      Caption = '&Submit Code'
      TabOrder = 6
      OnClick = bSubmitClick
    end
    object bReadCtr: TButton
      Left = 16
      Top = 112
      Width = 97
      Height = 25
      Caption = 'Read Err C&tr'
      TabOrder = 7
      OnClick = bReadCtrClick
    end
    object bChange: TButton
      Left = 136
      Top = 192
      Width = 97
      Height = 25
      Caption = 'C&hange Code'
      TabOrder = 8
      OnClick = bChangeClick
    end
    object Button3: TButton
      Left = 16
      Top = 232
      Width = 97
      Height = 25
      Caption = 'New card'
      TabOrder = 9
      OnClick = Button3Click
    end
  end
  object Button1: TButton
    Left = 264
    Top = 296
    Width = 59
    Height = 25
    Caption = 'Status'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 264
    Top = 328
    Width = 59
    Height = 25
    Caption = 'Restart'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 112
    Top = 32
    Width = 113
    Height = 22
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = #1057#1090#1091#1076#1077#1085#1090#1089#1082#1080' '#1075#1088#1072#1076
  end
  object Edit2: TEdit
    Left = 168
    Top = 56
    Width = 57
    Height = 22
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Text = '11'
  end
  object Edit3: TEdit
    Left = 112
    Top = 80
    Width = 113
    Height = 22
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Text = #1055#1077#1090#1082#1086' '#1087#1077#1090#1088#1086#1074
  end
  object Edit4: TEdit
    Left = 112
    Top = 104
    Width = 113
    Height = 22
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    Text = '99.9'
  end
  object Edit5: TEdit
    Left = 112
    Top = 128
    Width = 113
    Height = 22
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Text = 'ffffff'
  end
  object Edit6: TEdit
    Left = 112
    Top = 152
    Width = 113
    Height = 22
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Text = '12345'
  end
  object Timer3: TTimer
    Interval = 300
    OnTimer = Timer3Timer
    Left = 376
    Top = 320
  end
end
