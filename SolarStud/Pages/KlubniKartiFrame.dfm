object KlubniKartiFrame: TKlubniKartiFrame
  Width = 800
  Height = 600
  object Image58: TImage

    Left = -3

    Top = -4

    Width = 794

    Height = 594

    AutoSize = True

  end

  object LMDLImage13: TLMDLImage

    Left = 32

    Top = 56

    Width = 725

    Height = 57

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage63: TLMDLImage

    Left = 622

    Top = 503

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    OnClick = EndButtonCardClick

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage62: TLMDLImage

    Left = 41

    Top = 503

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    OnClick = Label94Click

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage18: TLMDLImage

    Left = 477

    Top = 549

    Width = 132

    Height = 17

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage17: TLMDLImage

    Left = 309

    Top = 549

    Width = 160

    Height = 17

    Bevel.Mode = bmCustom

    OnClick = Label120Click

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage16: TLMDLImage

    Left = 184

    Top = 549

    Width = 117

    Height = 17

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage15: TLMDLImage

    Left = 32

    Top = 224

    Width = 505

    Height = 273

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage14: TLMDLImage

    Left = 536

    Top = 224

    Width = 217

    Height = 273

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage12: TLMDLImage

    Left = 32

    Top = 128

    Width = 725

    Height = 89

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object KlientLabel_p18: TLabel

    Left = 142

    Top = 139

    Width = 63

    Height = 18

    Alignment = taCenter

    Anchors = [akTop]

    BiDiMode = bdRightToLeftNoAlign

    Caption = #1050#1083#1080#1077#1085#1090

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentBiDiMode = False

    ParentFont = False

    Transparent = True

    Layout = tlCenter

    OnDblClick = KlientLabel_p18DblClick

  end

  object Label129: TLabel

    Left = 518

    Top = 153

    Width = 78

    Height = 18

    Alignment = taCenter

    Anchors = [akTop]

    AutoSize = False

    BiDiMode = bdRightToLeftNoAlign

    Caption = #1050#1072#1088#1090#1072

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentBiDiMode = False

    ParentFont = False

    Transparent = True

    Layout = tlCenter

    ExplicitLeft = 519

  end

  object Label94: TLabel

    Left = 56

    Top = 529

    Width = 108

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

  object Label126: TLabel

    Left = 638

    Top = 527

    Width = 109

    Height = 31

    Alignment = taCenter

    AutoSize = False

    Caption = #1048#1047#1061#1054#1044

    Color = clNone

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clMaroon

    Font.Height = -24

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentColor = False

    ParentFont = False

    Transparent = True

    OnClick = EndButtonCardClick

  end

  object Label125: TLabel

    Left = 302

    Top = 73

    Width = 166

    Height = 25

    Alignment = taCenter

    Anchors = [akTop]

    BiDiMode = bdRightToLeftNoAlign

    Caption = #1050#1083#1091#1073#1085#1080' '#1082#1072#1088#1090#1080

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -21

    Font.Name = 'Verdana'

    Font.Style = [fsBold]

    ParentBiDiMode = False

    ParentFont = False

    Transparent = True

    Layout = tlCenter

    ExplicitLeft = 303

  end

  object Label169: TLabel

    Left = 208

    Top = 194

    Width = 95

    Height = 13

    Caption = #1055#1086#1082#1072#1078#1080' '#1080#1079#1090#1088#1080#1090#1080#1090#1077

    Transparent = True

  end

  object wwDBGrid6: TwwDBGrid

    Left = 41

    Top = 234

    Width = 485

    Height = 255

    DisableThemes = True

    Selected.Strings = (

      'NOMER'#9'10'#9#1085#1086#1084#1077#1088

      'IME'#9'30'#9#1080#1084#1077

      'TELEFON'#9'11'#9#1090#1077#1083#1077#1092#1086#1085

      'SUMA'#9'10'#9#1057#1091#1084#1072

      'BALANS'#9'7'#9#1054#1073#1086#1088#1086#1090

      'ADRES'#9'21'#9#1077'-'#1084#1077#1081#1083)

    IniAttributes.Delimiter = ';;'

    TitleColor = 3131647

    OnRowChanged = wwDBGrid6RowChanged

    FixedCols = 1

    ShowHorzScrollBar = True

    DataSource = DataSource2

    KeyOptions = []

    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgWordWrap, dgNoLimitColSize, dgFixedResizable]

    TabOrder = 0

    TitleAlignment = taLeftJustify

    TitleFont.Charset = RUSSIAN_CHARSET

    TitleFont.Color = clWindowText

    TitleFont.Height = -11

    TitleFont.Name = 'Tahoma'

    TitleFont.Style = []

    TitleLines = 1

    TitleButtons = True

    OnTitleButtonClick = wwDBGrid6TitleButtonClick

    OnEnter = wwDBGrid6RowChanged

    OnExit = wwDBGrid6Exit

    PaintOptions.AlternatingRowRegions = [arrDataColumns, arrActiveDataColumn]

    PaintOptions.AlternatingRowColor = 15790320

    PaintOptions.ActiveRecordColor = clGreen

  end

  object wwDBGrid7: TwwDBGrid

    Left = 544

    Top = 232

    Width = 201

    Height = 256

    DisableThemes = True

    Selected.Strings = (

      'KARTANOMER'#9'10'#9#1085#1086#1084#1077#1088

      'STARTDATE'#9'10'#9#1076#1086' '#1076#1072#1090#1072

      'POSESHTENIA'#9'5'#9#1087#1086#1089'.')

    IniAttributes.Delimiter = ';;'

    TitleColor = 3131647

    OnRowChanged = wwDBGrid7RowChanged

    FixedCols = 0

    ShowHorzScrollBar = True

    DataSource = DataSource10

    KeyOptions = []

    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgNoLimitColSize]

    ReadOnly = True

    TabOrder = 2

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

  object LMDButton5: TLMDButton

    Left = 344

    Top = 137

    Width = 97

    Height = 33

    Caption = #1080#1079#1090#1088#1074#1072#1085#1077

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clRed

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = []

    ParentFont = False

    TabOrder = 3

    OnClick = LMDButton5Click

    Color = 7720166

    ParentColor = False

  end

  object LMDButton6: TLMDButton

    Left = 344

    Top = 177

    Width = 97

    Height = 33

    Caption = #1085#1086#1074' '#1082#1083#1080#1077#1085#1090

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = []

    ParentFont = False

    TabOrder = 4

    OnClick = LMDButton6Click

    Color = 7720166

    ParentColor = False

  end

  object LMDButton7: TLMDButton

    Left = 616

    Top = 137

    Width = 89

    Height = 33

    Caption = #1080#1079#1090#1088#1080#1074#1072#1085#1077

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clRed

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = []

    ParentFont = False

    TabOrder = 5

    OnClick = LMDButton7Click

    Color = 7720166

    ParentColor = False

  end

  object LMDButton8: TLMDButton

    Left = 616

    Top = 176

    Width = 89

    Height = 33

    Caption = #1085#1086#1074#1072

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -16

    Font.Name = 'Verdana'

    Font.Style = []

    ParentFont = False

    TabOrder = 6

    OnClick = Label120Click

    Color = 7720166

    ParentColor = False

  end

  object Edit6: TEdit

    Left = 52

    Top = 167

    Width = 273

    Height = 21

    TabOrder = 1

    OnChange = Edit6Change

    OnKeyPress = Edit6KeyPress

  end

  object KartaSearchBox: TEdit

    Left = 519

    Top = 185

    Width = 91

    Height = 21

    TabOrder = 7

    OnKeyPress = KartaSearchBoxKeyPress

    OnKeyUp = KartaSearchBoxKeyUp

  end

  object ShowAllKlientsCb: TCheckBox

    Left = 312

    Top = 194

    Width = 13

    Height = 16

    TabOrder = 8

    OnClick = Edit6Change

  end

end