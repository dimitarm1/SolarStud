object ProtokolFrame: TProtokolFrame
  Width = 800
  Height = 600
  object Image50: TImage

    Left = -3

    Top = -4

    Width = 794

    Height = 594

    AutoSize = True

  end

  object LMDLImage115: TLMDLImage

    Left = 13

    Top = 49

    Width = 758

    Height = 65

    Bevel.Mode = bmCustom

    OnClick = LMDLImage115Click

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage67: TLMDLImage

    Left = 632

    Top = 505

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    OnClick = CancelButtonClick

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage66: TLMDLImage

    Left = 16

    Top = 504

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    OnClick = PrintDayReportClick

    ForceTransparent = True


    Style = sbStretch

  end

  object Label107: TLabel

    Left = 22

    Top = 528

    Width = 118

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

    OnClick = PrintDayReportClick

  end

  object Label109: TLabel

    Left = 643

    Top = 528

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

  object Label52: TLabel

    Left = 259

    Top = 65

    Width = 267

    Height = 29

    Alignment = taCenter

    AutoSize = False

    Caption = #1044#1085#1077#1074#1077#1085' '#1087#1088#1086#1090#1086#1082#1086#1083

    Color = clActiveBorder

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -24

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentColor = False

    ParentFont = False

    Transparent = True

  end

  object LMDLImage45: TLMDLImage

    Left = 13

    Top = 120

    Width = 763

    Height = 381

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage140: TLMDLImage

    Left = 311

    Top = 516

    Width = 316

    Height = 50

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage139: TLMDLImage

    Left = 159

    Top = 517

    Width = 153

    Height = 49

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object Label170: TLabel

    Left = 335

    Top = 528

    Width = 62

    Height = 29

    Alignment = taCenter

    Anchors = [akTop]

    AutoSize = False

    BiDiMode = bdRightToLeftNoAlign

    Caption = #1060#1080#1083#1090#1098#1088

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -16

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentBiDiMode = False

    ParentFont = False

    Transparent = True

    Layout = tlCenter

    OnClick = PrintDayReportClick

    ExplicitLeft = 336

  end

  object wwDBGrid2: TwwDBGrid

    Left = 22

    Top = 127

    Width = 742

    Height = 365

    DisableThemes = True

    Selected.Strings = (

      'CHAS'#9'12'#9#1063#1072#1089

      'SOLARIUM'#9'3'#9#1057#1086#1083'.'

      'STOKAIME'#9'30'#9#1057#1090#1086#1082#1072

      'BROI'#9'5'#9#1073#1088'.'

      'CENA'#9'10'#9#1062#1077#1085#1072

      'DISCOUNT'#9'5'#9#1054#1090#1089#1090'.'

      'SUMABROI'#9'10'#9#1074' '#1073#1088#1086#1081

      'OTKARTA'#9'10'#9#1082#1072#1088#1090#1072

      'POSESHTENIA'#9'5'#9#1087#1086#1089#1077#1097'.'

      'OTCHIPKARTA'#9'10'#9#1095#1080#1087' '#1082#1072#1088#1090#1072

      'KARTASUMA'#9'7'#9#1095#1080#1087' '#1089#1091#1084#1072

      'STUDIOCODE'#9'7'#9#1089#1090#1091#1076#1080#1086' '#8470

      'KLIENTNOMER'#9'6'#9#1089#1083#1091#1078' '#8470)

    IniAttributes.Enabled = True

    IniAttributes.FileName = 'SolarStudio1.2.ini'

    IniAttributes.SectionName = 'Protokol'

    IniAttributes.Delimiter = ';;'

    IniAttributes.CheckNewFields = True

    ExportOptions.ExportType = wwgetHTML

    ExportOptions.FileName = 'otchet.html'

    ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]

    ExportOptions.TitleName = 'Dneven otchet za dnes'

    TitleColor = 3131647

    FixedCols = 0

    ShowHorzScrollBar = True

    Color = clCream

    DataSource = DataSource5

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -11

    Font.Name = 'Verdana'

    Font.Style = []

    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]

    ParentFont = False

    ReadOnly = True

    TabOrder = 0

    TitleAlignment = taLeftJustify

    TitleFont.Charset = RUSSIAN_CHARSET

    TitleFont.Color = clWindowText

    TitleFont.Height = -11

    TitleFont.Name = 'Tahoma'

    TitleFont.Style = []

    TitleLines = 1

    TitleButtons = True

    UseTFields = False

    OnTitleButtonClick = wwDBGrid2TitleButtonClick

    PaintOptions.AlternatingRowColor = clMoneyGreen

  end

  object DBLUCombo1: TPlannerMaskDatePicker

    Left = 184

    Top = 528

    Width = 108

    Height = 24

    Hint = #1044#1072#1090#1072' '#1079#1072' '#1087#1088#1086#1090#1086#1082#1086#1083#1072

    Color = clWindow

    Enabled = True

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -13

    Font.Name = 'Verdana'

    Font.Style = []

    ParentFont = False

    TabOrder = 1

    Visible = True

    OnChange = DBLUCombo11Change

    AutoFocus = False

    Flat = False

    FlatLineColor = clBlack

    FlatParentColor = True

    ShowModified = False

    FocusColor = clWindow

    FocusBorder = False

    FocusFontColor = clBlack

    LabelAlwaysEnabled = False

    LabelPosition = lpLeftTop

    LabelMargin = 4

    LabelTransparent = False

    LabelFont.Charset = RUSSIAN_CHARSET

    LabelFont.Color = clWindowText

    LabelFont.Height = -11

    LabelFont.Name = 'MS Sans Serif'

    LabelFont.Style = []

    ModifiedColor = clRed

    SelectFirstChar = False

    Version = '1.5.0.3'

    ButtonStyle = bsButton

    ButtonWidth = 16

    Etched = False

    Glyph.Data = {

      62010000424D620100000000000042000000280000000C0000000C0000000100

      1000030000002001000000000000000000000000000000000000007C0000E003

      00001F000000596B596B596B596B596B596B596B596B596B596B596B596B596B

      596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B

      596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B

      596B596B596B596B596B596B596B596B0000596B596B596B596B596B596B596B

      596B596B596B000000000000596B596B596B596B596B596B596B596B00000000

      000000000000596B596B596B596B596B596B0000000000000000000000000000

      596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B

      596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B

      596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B596B

      596B596B596B}

    HideCalendarAfterSelection = False

    object TPlannerCalendar

      Left = 0

      Top = 0

      Width = 180

      Height = 180

      EventDayColor = clBlack

      EventMarkerColor = clYellow

      EventMarkerShape = evsCircle

      BackgroundPosition = bpTiled

      BevelOuter = bvNone

      BorderWidth = 1

      Look = lookFlat

      DateDownColor = clNone

      DateHoverColor = clNone

      DayFont.Charset = RUSSIAN_CHARSET

      DayFont.Color = clWindowText

      DayFont.Height = -11

      DayFont.Name = 'Tahoma'

      DayFont.Style = []

      WeekFont.Charset = RUSSIAN_CHARSET

      WeekFont.Color = clWindowText

      WeekFont.Height = -11

      WeekFont.Name = 'Tahoma'

      WeekFont.Style = []

      WeekName = 'Wk'

      TextColor = clBlack

      SelectColor = clTeal

      SelectFontColor = clWhite

      InActiveColor = clGray

      HeaderColor = clNone

      FocusColor = clHighlight

      InversColor = clTeal

      WeekendColor = clRed

      NameOfDays.Monday = #1087#1086#1085#1077#1076#1077#1083#1085#1080#1082

      NameOfDays.Tuesday = #1074#1090#1086#1088#1085#1080#1082

      NameOfDays.Wednesday = #1089#1088#1103#1076#1072

      NameOfDays.Thursday = #1095#1077#1090#1074#1098#1088#1090#1098#1082

      NameOfDays.Friday = #1087#1077#1090#1098#1082

      NameOfDays.Saturday = #1089#1098#1073#1086#1090#1072

      NameOfDays.Sunday = #1085#1077#1076#1077#1083#1103

      NameOfMonths.January = #1071#1085#1091#1072#1088#1080

      NameOfMonths.February = #1060#1077#1074#1088#1091#1072#1088#1080

      NameOfMonths.March = #1052#1072#1088#1090

      NameOfMonths.April = #1040#1087#1088#1080#1083

      NameOfMonths.May = #1052#1072#1081

      NameOfMonths.June = #1070#1085#1080

      NameOfMonths.July = #1070#1083#1080

      NameOfMonths.August = #1040#1074#1075#1091#1089#1090

      NameOfMonths.September = #1057#1077#1087#1090#1077#1084#1074#1088#1080

      NameOfMonths.October = #1054#1082#1090#1086#1084#1074#1088#1080

      NameOfMonths.November = #1053#1086#1077#1084#1074#1088#1080

      NameOfMonths.December = #1044#1077#1082#1077#1084#1074#1088#1080

      NameOfMonths.UseIntlNames = True

      StartDay = 7

      TodayFormat = '"Today" DDD/mm, YYYY'

      Day = 2

      Month = 5

      Year = 2009

      TabOrder = 0

      Font.Charset = RUSSIAN_CHARSET

      Font.Color = clWindowText

      Font.Height = -11

      Font.Name = 'Tahoma'

      Font.Style = []

      CaptionColor = clNone

      CaptionTextColor = clBlack

      LineColor = clGray

      Line3D = True

      GradientStartColor = clWhite

      GradientEndColor = clBtnFace

      GradientDirection = gdVertical

      MonthGradientStartColor = clNone

      MonthGradientEndColor = clNone

      MonthGradientDirection = gdHorizontal

      HintPrevYear = 'Previous Year'

      HintPrevMonth = 'Previous Month'

      HintNextMonth = 'Next Month'

      HintNextYear = 'Next Year'

      Version = '1.7.5.0'

    end

  end

  object ProtokolFilterEdit: TEdit

    Left = 416

    Top = 532

    Width = 178

    Height = 21

    TabOrder = 2

    OnChange = ProtokolFilterEditChange

  end

end