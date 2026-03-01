object MenuStokiFrame: TMenuStokiFrame
  Width = 800
  Height = 600
  object Image56: TImage

    Left = -4

    Top = -5

    Width = 794

    Height = 594

    AutoSize = True

  end

  object LMDLImage65: TLMDLImage

    Left = 624

    Top = 505

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    OnClick = SettingsEndButtonClick

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage64: TLMDLImage

    Left = 32

    Top = 505

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    OnClick = Label123Click

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage20: TLMDLImage

    Left = 477

    Top = 520

    Width = 127

    Height = 47

    Bevel.Mode = bmCustom

    OnClick = Label124Click

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage19: TLMDLImage

    Left = 184

    Top = 520

    Width = 127

    Height = 47

    Bevel.Mode = bmCustom

    OnClick = DobaviStokaBtnClick

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDSimpleLabel2: TLMDSimpleLabel

    Left = 531

    Top = 323

    Width = 119

    Height = 29

    Color = 9561074

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -19

    Font.Name = 'Arial Black'

    Font.Style = []

    Font3D.ShadowDepth = 3

    ParentColor = False

    ParentFont = False

    Caption = #1050#1086#1079#1084#1077#1090#1080#1082#1072

    Options = []

  end

  object Label123: TLabel

    Left = 61

    Top = 529

    Width = 82

    Height = 29

    Alignment = taCenter

    Anchors = [akTop]

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

    OnClick = Label123Click

  end

  object LMDLImage21: TLMDLImage

    Left = 330

    Top = 520

    Width = 127

    Height = 47

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object Label88: TLabel

    Left = 637

    Top = 528

    Width = 108

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

    OnClick = SettingsEndButtonClick

  end

  object Label124: TLabel

    Left = 485

    Top = 533

    Width = 108

    Height = 31

    Alignment = taCenter

    AutoSize = False

    Caption = #1048#1079#1090#1088#1080#1081

    Color = clNone

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clMaroon

    Font.Height = -19

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentColor = False

    ParentFont = False

    Transparent = True

    OnClick = Label124Click

  end

  object DobaviStokaBtn: TLabel

    Left = 212

    Top = 533

    Width = 73

    Height = 22

    Alignment = taCenter

    Anchors = [akTop]

    BiDiMode = bdRightToLeftNoAlign

    Caption = #1044#1086#1073#1072#1074#1080

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -19

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentBiDiMode = False

    ParentFont = False

    Transparent = True

    Layout = tlCenter

    OnClick = DobaviStokaBtnClick

    ExplicitLeft = 213

  end

  object StokaEditBtn: TLabel

    Left = 330

    Top = 533

    Width = 127

    Height = 34

    Alignment = taCenter

    AutoSize = False

    Caption = #1055#1088#1086#1084#1103#1085#1072

    Color = clNone

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -19

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentColor = False

    ParentFont = False

    Transparent = True

    Visible = False

    OnClick = StokaEditBtnClick

  end

  object StokiteTab: TAdvPageControl

    AlignWithMargins = True

    Left = 24

    Top = 19

    Width = 737

    Height = 474

    Margins.Left = 0

    Margins.Top = 0

    Margins.Right = 0

    Margins.Bottom = 0

    ActivePage = AdvTabSheet20

    ActiveFont.Charset = RUSSIAN_CHARSET

    ActiveFont.Color = clMaroon

    ActiveFont.Height = -19

    ActiveFont.Name = 'Arial'

    ActiveFont.Style = []

    DockSite = True

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -16

    Font.Name = 'Arial'

    Font.Style = []

    HotTrack = True

    MultiLine = True

    ParentFont = False

    RaggedRight = True

    DefaultTabColor = clNone

    DefaultTabColorTo = 2669047

    ActiveColor = clNone

    ActiveColorTo = clTeal

    TabBorderColor = 6345725

    TabSheet3D = True

    TabSheetBorderColor = 2669047

    TabHoverColor = clLime

    TabHoverBorder = clBlack

    TabBackGroundColor = 2669047

    TabMargin.RightMargin = 0

    TabOverlap = 0

    RoundEdges = True

    Version = '1.5.0.8'

    TabHeight = 30

    TabOrder = 0

    TabPosition = tpLeft

    TabWidth = 85

    OnChange = StokiteTabChange

    object AdvTabSheet20: TAdvTabSheet

      Caption = #1050#1072#1088#1090#1080

      Color = 13036541

      ColorTo = 2669047

      TabColor = clNone

      TabColorTo = 2669047

      object wwDBGrid3: TwwDBGrid

        Left = 0

        Top = 0

        Width = 699

        Height = 466

        DisableThemes = True

        PictureMasks.Strings = (

          'POSESHTENIA'#9'10,20,30'#9'T'#9'F')

        Selected.Strings = (

          'STOKAKOD'#9'3'#9#1050#1086#1076

          'STOKAIME'#9'22'#9#1048#1084#1077

          'STOKANASKLAD'#9'7'#9#1053#1072' '#1089#1082#1083#1072#1076

          'STOKACENA'#9'8'#9#1062#1077#1085#1072

          'POSESHTENIA'#9'8'#9#1052#1080#1085'../'#1087#1086#1089'.'

          'SUMA'#9'13'#9#1047#1072#1088#1077#1076#1077#1085#1072' '#1089#1091#1084#1072

          'VALIDNOST_KARTI'#9'9'#9#1042#1072#1083#1080#1076#1085#1086#1089#1090)

        IniAttributes.Enabled = True

        IniAttributes.FileName = '\SolarStudio1\grid1.ini'

        IniAttributes.Delimiter = ';;'

        IniAttributes.CheckNewFields = True

        TitleColor = 3131647

        FixedCols = 0

        ShowHorzScrollBar = True

        Align = alClient

        DataSource = DataSource6

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

        TitleButtons = True

        OnTitleButtonClick = wwDBGrid3TitleButtonClick

        OnFieldChanged = wwDBGrid3FieldChanged

      end

    end

    object AdvTabSheet21: TAdvTabSheet

      Caption = #1057#1090#1086#1082#1080

      Color = 6345725

      ColorTo = clNone

      TabColor = clNone

      TabColorTo = 2669047

      OnShow = AdvTabSheet21Show

      object wwDBGrid4: TwwDBGrid

        Left = 0

        Top = 0

        Width = 699

        Height = 466

        DisableThemes = True

        PictureMasks.Strings = (

          'POSESHTENIA'#9'10,20,30'#9'T'#9'T')

        Selected.Strings = (

          'STOKAKOD'#9'4'#9#1050#1086#1076

          'STOKAIME'#9'30'#9#1057#1090#1086#1082#1072

          'STOKANASKLAD'#9'3'#9#1073#1088'.'

          'SUMA'#9'7'#9#1062#1077#1085#1072'1'

          'STOKATOTAL_IN'#9'9'#9#1057#1091#1084#1072'1'

          'STOKACENA'#9'7'#9#1062#1077#1085#1072

          'STOKATOTAL_SELL'#9'10'#9#1057#1091#1084#1072

          'STOKACENACARD'#9'11'#9#1062#1077#1085#1072' '#1089' '#1082#1072#1088#1090#1072)

        IniAttributes.Enabled = True

        IniAttributes.Delimiter = ';;'

        IniAttributes.CheckNewFields = True

        TitleColor = 3131647

        FixedCols = 0

        ShowHorzScrollBar = True

        Align = alClient

        DataSource = DataSource23

        KeyOptions = []

        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgNoLimitColSize]

        TabOrder = 0

        TitleAlignment = taLeftJustify

        TitleFont.Charset = RUSSIAN_CHARSET

        TitleFont.Color = clWindowText

        TitleFont.Height = -16

        TitleFont.Name = 'Arial'

        TitleFont.Style = []

        TitleLines = 1

        TitleButtons = True

        OnTitleButtonClick = StokiGridTitleButtonClick

      end

    end

    object AdvTabSheet22: TAdvTabSheet

      Caption = #1059#1089#1083#1091#1075#1080

      Color = 6345725

      ColorTo = clNone

      TabColor = clNone

      TabColorTo = 2669047

      object wwDBGrid11: TwwDBGrid

        Left = 0

        Top = 0

        Width = 699

        Height = 466

        DisableThemes = True

        PictureMasks.Strings = (

          'POSESHTENIA'#9'10,20,30'#9'T'#9'T')

        Selected.Strings = (

          'STOKAKOD'#9'5'#9#1050#1086#1076

          'STOKAIME'#9'28'#9#1059#1089#1083#1091#1075#1072

          'STOKANASKLAD'#9'8'#9#1053#1072' '#1089#1082#1083#1072#1076

          'STOKACENA'#9'7'#9#1062#1077#1085#1072

          'STOKACENACARD'#9'10'#9#1057' '#1082#1072#1088#1090#1072)

        IniAttributes.Enabled = True

        IniAttributes.Delimiter = ';;'

        IniAttributes.CheckNewFields = True

        TitleColor = 3131647

        FixedCols = 0

        ShowHorzScrollBar = True

        Align = alClient

        DataSource = DataSource18

        KeyOptions = []

        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgNoLimitColSize]

        TabOrder = 0

        TitleAlignment = taLeftJustify

        TitleFont.Charset = RUSSIAN_CHARSET

        TitleFont.Color = clWindowText

        TitleFont.Height = -16

        TitleFont.Name = 'Arial'

        TitleFont.Style = []

        TitleLines = 1

        TitleButtons = True

        OnTitleButtonClick = wwDBGrid11TitleButtonClick

      end

    end

  end

end