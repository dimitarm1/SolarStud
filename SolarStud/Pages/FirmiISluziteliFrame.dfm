object FirmiISluziteliFrame: TFirmiISluziteliFrame
  Width = 800
  Height = 600
  object NulImage: TImage

    Left = 704

    Top = 496

    Width = 81

    Height = 81

  end

  object Image6: TImage

    Left = -3

    Top = -14

    Width = 794

    Height = 594

    AutoSize = True

  end

  object Label160: TLabel

    Left = 646

    Top = 539

    Width = 114

    Height = 29

    Alignment = taCenter

    AutoSize = False

    Caption = #1050#1056#1040#1049

    Color = clActiveBorder

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clMaroon

    Font.Height = -24

    Font.Name = 'Verdana'

    Font.Style = []

    ParentColor = False

    ParentFont = False

    Transparent = True

  end

  object LMDLImage141: TLMDLImage

    Left = 634

    Top = 515

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    OnClick = CancelButtonClick

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage142: TLMDLImage

    Left = 27

    Top = 514

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage143: TLMDLImage

    Left = 188

    Top = 557

    Width = 130

    Height = 17

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage144: TLMDLImage

    Left = 332

    Top = 557

    Width = 130

    Height = 17

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage145: TLMDLImage

    Left = 481

    Top = 557

    Width = 130

    Height = 17

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object Label161: TLabel

    Left = 644

    Top = 540

    Width = 116

    Height = 29

    Alignment = taCenter

    AutoSize = False

    Caption = #1048#1047#1061#1054#1044

    Color = clActiveBorder

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clMaroon

    Font.Height = -24

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentColor = False

    ParentFont = False

    Transparent = True

    OnClick = CancelButtonClick

  end

  object LMDLImage22: TLMDLImage

    Left = 14

    Top = 341

    Width = 763

    Height = 167

    Bevel.Mode = bmCustom

    ForceTransparent = True


    ImageIndex = 2

    Style = sbStretch

  end

  object Label163: TLabel

    Left = 27

    Top = 350

    Width = 138

    Height = 29

    AutoSize = False

    Caption = #1057#1083#1091#1078#1080#1090#1077#1083#1080

    Color = clBlack

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -24

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentColor = False

    ParentFont = False

    Transparent = True

  end

  object Label162: TLabel

    Left = 34

    Top = 538

    Width = 126

    Height = 29

    Alignment = taCenter

    Anchors = [akTop]

    AutoSize = False

    BiDiMode = bdRightToLeftNoAlign

    Caption = #1055#1045#1063#1040#1058

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -24

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentBiDiMode = False

    ParentFont = False

    Transparent = True

    Layout = tlCenter

    OnClick = Label94Click

  end

  object wwDBGrid12: TwwDBGrid

    Left = 16

    Top = 53

    Width = 755

    Height = 252

    DisableThemes = True

    PictureMasks.Strings = (

      'POSESHTENIA'#9'10,20,30'#9'T'#9'F')

    Selected.Strings = (

      'NOMER'#9'6'#9#1053#1086#1084#1077#1088

      'IME'#9'32'#9#1060#1080#1088#1084#1072

      'ADRES'#9'25'#9#1040#1076#1088#1077#1089

      'TELEFON'#9'15'#9#1058#1077#1083#1077#1092#1086#1085)

    MemoAttributes = [mSizeable, mWordWrap, mGridShow]

    IniAttributes.Enabled = True

    IniAttributes.Delimiter = ';;'

    IniAttributes.CheckNewFields = True

    TitleColor = 3131647

    OnRowChanged = wwDBGrid12RowChanged

    FixedCols = 0

    ShowHorzScrollBar = True

    DataSource = DataSource19

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -16

    Font.Name = 'Arial'

    Font.Style = []

    KeyOptions = []

    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgNoLimitColSize]

    ParentFont = False

    TabOrder = 0

    TitleAlignment = taLeftJustify

    TitleFont.Charset = RUSSIAN_CHARSET

    TitleFont.Color = clWindowText

    TitleFont.Height = -16

    TitleFont.Name = 'Arial'

    TitleFont.Style = []

    TitleLines = 1

    TitleButtons = False

  end

  object DBNavigator2: TDBNavigator

    Left = 14

    Top = 311

    Width = 760

    Height = 25

    DataSource = DataSource19

    TabOrder = 1

  end

  object wwDBGrid13: TwwDBGrid

    Left = 165

    Top = 350

    Width = 601

    Height = 151

    DisableThemes = True

    Selected.Strings = (

      'NOMER2'#9'7'#9#1053#1086#1084#1077#1088#9'F'

      'NOMER'#9'6'#9#1050#1072#1088#1090#1072#9'F'

      'IME'#9'26'#9#1080#1084#1077

      'TELEFON'#9'11'#9#1090#1077#1083#1077#1092#1086#1085

      'ADRES'#9'20'#9#1077'-'#1084#1077#1081#1083

      'BALANS'#9'7'#9#1054#1073#1086#1088#1086#1090)

    IniAttributes.Delimiter = ';;'

    TitleColor = 3131647

    FixedCols = 2

    ShowHorzScrollBar = True

    Color = 377594

    DataSource = DataSource2

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -11

    Font.Name = 'Verdana'

    Font.Style = []

    KeyOptions = []

    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgWordWrap, dgNoLimitColSize]

    ParentFont = False

    TabOrder = 2

    TitleAlignment = taLeftJustify

    TitleFont.Charset = RUSSIAN_CHARSET

    TitleFont.Color = clWindowText

    TitleFont.Height = -11

    TitleFont.Name = 'Tahoma'

    TitleFont.Style = []

    TitleLines = 1

    TitleButtons = True

    UseTFields = False

    LineColors.ShadowColor = clGray

    FooterColor = 12449017

    FooterCellColor = 12449017

    PaintOptions.BackgroundDrawStyle = bdsCenter

    PaintOptions.AlternatingRowRegions = [arrDataColumns, arrActiveDataColumn]

    PaintOptions.AlternatingRowColor = 15790320

    PaintOptions.ActiveRecordColor = clGreen

  end

  object LMDButton1: TLMDButton

    Left = 44

    Top = 464

    Width = 41

    Height = 25

    Caption = '+'

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -21

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentFont = False

    TabOrder = 3

    OnClick = LMDButton1Click

    ButtonStyle = ubsExplorer

    Color = 2669047

    FontFX.DisabledStyle = ds3d

    FontFX.LightDepth = 0

    FontFX.Style = tdRaisedShadow

    ParentColor = False

  end

  object LMDButton2: TLMDButton

    Left = 105

    Top = 464

    Width = 41

    Height = 25

    Caption = '-'

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clRed

    Font.Height = -21

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentFont = False

    TabOrder = 4

    OnClick = LMDButton2Click

    ButtonStyle = ubsFlatUnColored

    Color = 2669047

    FontFX.DisabledStyle = ds3d

    FontFX.LightDepth = 0

    FontFX.Style = tdRaisedShadow

    ParentColor = False

  end

end