object OsnovniNastroikiFrame: TOsnovniNastroikiFrame
  Width = 800
  Height = 600
  object Image51: TImage

    Left = -5

    Top = -5

    Width = 794

    Height = 594

    AutoSize = True

  end

  object LMDLImage146: TLMDLImage

    Left = 624

    Top = 505

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    OnClick = SettingsEndButtonClick

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage46: TLMDLImage

    Left = 55

    Top = 80

    Width = 678

    Height = 65

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage43: TLMDLImage

    Left = 56

    Top = 168

    Width = 353

    Height = 289

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object Label74: TLabel

    Left = 96

    Top = 189

    Width = 169

    Height = 18

    Alignment = taRightJustify

    Caption = #1053#1086#1084#1077#1088' '#1085#1072' '#1089#1090#1091#1076#1080#1086#1090#1086

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    Transparent = True

  end

  object Label134: TLabel

    Left = 96

    Top = 219

    Width = 147

    Height = 18

    Alignment = taRightJustify

    Caption = #1048#1084#1077' '#1085#1072' '#1089#1090#1091#1076#1080#1086#1090#1086

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    Transparent = True

  end

  object Label135: TLabel

    Left = 96

    Top = 253

    Width = 176

    Height = 18

    Alignment = taRightJustify

    Caption = #1055#1048#1053' '#1082#1086#1076' '#1079#1072' '#1082#1072#1088#1090#1080#1090#1077

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    Transparent = True

  end

  object Label42: TLabel

    Left = 152

    Top = 305

    Width = 115

    Height = 18

    Alignment = taCenter

    Caption = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083#1080

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    Transparent = True

  end

  object Label95: TLabel

    Left = 648

    Top = 527

    Width = 83

    Height = 29

    Alignment = taCenter

    Anchors = [akTop]

    AutoSize = False

    BiDiMode = bdRightToLeftNoAlign

    Caption = #1048#1047#1061#1054#1044

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clMaroon

    Font.Height = -24

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentBiDiMode = False

    ParentFont = False

    Transparent = True

    Layout = tlCenter

    OnClick = SettingsEndButtonClick

    ExplicitLeft = 650

  end

  object LMDLImage44: TLMDLImage

    Left = 416

    Top = 168

    Width = 312

    Height = 289

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object Label58: TLabel

    Left = 265

    Top = 102

    Width = 289

    Height = 25

    Alignment = taCenter

    AutoSize = False

    Caption = #1054#1089#1085#1086#1074#1085#1080' '#1085#1072#1089#1090#1088#1086#1081#1082#1080

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -21

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    Transparent = True

  end

  object LMDLImage147: TLMDLImage

    Left = 32

    Top = 505

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object wwDBEdit6: TwwDBEdit

    Left = 283

    Top = 187

    Width = 33

    Height = 21

    DataField = 'STUDIONOMER'

    DataSource = DataSource3

    TabOrder = 0

    UnboundDataType = wwDefault

    WantReturns = False

    WordWrap = False

  end

  object wwDBEdit5: TwwDBEdit

    Left = 283

    Top = 217

    Width = 89

    Height = 21

    DataField = 'STUDIONAME'

    DataSource = DataSource3

    TabOrder = 1

    UnboundDataType = wwDefault

    WantReturns = False

    WordWrap = False

  end

  object wwDBEdit7: TwwDBEdit

    Left = 284

    Top = 251

    Width = 49

    Height = 21

    DataField = 'PIN'

    DataSource = DataSource3

    TabOrder = 2

    UnboundDataType = wwDefault

    WantReturns = False

    WordWrap = False

    OnKeyPress = wwDBEdit7KeyPress

  end

  object LMDButton10: TLMDButton

    Left = 464

    Top = 184

    Width = 217

    Height = 33

    Caption = #1080#1079#1090#1088#1080#1080' '#1089#1090#1086#1082#1080#1090#1077

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clRed

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    TabOrder = 3

    OnClick = LMDButton10Click

    ButtonStyle = ubsDelphi

    Color = 12449017

    ParentColor = False

  end

  object LMDButton12: TLMDButton

    Left = 464

    Top = 224

    Width = 217

    Height = 33

    Caption = #1080#1079#1090#1088#1080#1080' '#1082#1072#1088#1090#1080#1090#1077

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clRed

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    TabOrder = 4

    OnClick = LMDButton12Click

    ButtonStyle = ubsDelphi

    Color = 12449017

    ParentColor = False

  end

  object LMDButton13: TLMDButton

    Left = 464

    Top = 344

    Width = 217

    Height = 33

    Caption = #1080#1079#1090#1088#1080#1080' '#1082#1083#1080#1077#1085#1090#1080#1090#1077

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clRed

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    TabOrder = 5

    OnClick = LMDButton13Click

    ButtonStyle = ubsDelphi

    Color = 12449017

    ParentColor = False

  end

  object LMDButton14: TLMDButton

    Left = 464

    Top = 384

    Width = 217

    Height = 33

    Caption = #1080#1079#1090#1088#1080#1080' '#1087#1088#1086#1090#1086#1082#1086#1083#1080#1090#1077

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clRed

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    TabOrder = 6

    OnClick = LMDButton14Click

    ButtonStyle = ubsDelphi

    Color = 12449017

    ParentColor = False

  end

  object LMDButton15: TLMDButton

    Left = 464

    Top = 304

    Width = 217

    Height = 33

    Caption = #1080#1079#1090#1088#1080#1080' '#1082#1083#1091#1073#1085#1080#1090#1077' '#1082#1072#1088#1090#1080

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clRed

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentFont = False

    TabOrder = 7

    OnClick = LMDButton15Click

    ButtonStyle = ubsDelphi

    Color = 12449017

    ParentColor = False

  end

  object wwDBGrid1: TwwDBGrid

    Left = 91

    Top = 329

    Width = 269

    Height = 81

    DisableThemes = True

    Selected.Strings = (

      'IME'#9'12'#9#1048#1084#1077

      'PAROLA'#9'25'#9#1055#1072#1088#1086#1083#1072)

    IniAttributes.Delimiter = ';;'

    TitleColor = 3131647

    OnRowChanged = wwDBGrid7RowChanged

    FixedCols = 0

    ShowHorzScrollBar = True

    DataSource = personalset

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -11

    Font.Name = 'Tahoma'

    Font.Style = []

    KeyOptions = []

    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgWordWrap, dgNoLimitColSize]

    ParentFont = False

    TabOrder = 8

    TitleAlignment = taLeftJustify

    TitleFont.Charset = RUSSIAN_CHARSET

    TitleFont.Color = clWindowText

    TitleFont.Height = -11

    TitleFont.Name = 'Tahoma'

    TitleFont.Style = []

    TitleLines = 1

    TitleButtons = True

    OnTitleButtonClick = wwDBGrid7TitleButtonClick

    PaintOptions.ActiveRecordColor = clGreen

  end

  object DBNavigator1: TDBNavigator

    Left = 90

    Top = 416

    Width = 270

    Height = 25

    DataSource = personalset

    TabOrder = 9

  end

end