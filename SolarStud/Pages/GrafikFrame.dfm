object GrafikFrame: TGrafikFrame
  Width = 800
  Height = 600
  object Image7: TImage

    Left = -3

    Top = -4

    Width = 794

    Height = 594

    AutoSize = True

  end

  object LMDLImage23: TLMDLImage

    Left = 477

    Top = 505

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object LMDLImage150: TLMDLImage

    Left = 624

    Top = 505

    Width = 137

    Height = 64

    Bevel.Mode = bmCustom

    ForceTransparent = True


    Style = sbStretch

  end

  object Label164: TLabel

    Left = 636

    Top = 528

    Width = 108

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

    OnClick = CancelButtonClick

    ExplicitLeft = 638

  end

  object Page23PrintBtn: TLabel

    Left = 508

    Top = 528

    Width = 68

    Height = 29

    Alignment = taCenter

    Anchors = [akTop]

    BiDiMode = bdRightToLeftNoAlign

    Caption = #1055#1077#1095#1072#1090

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -24

    Font.Name = 'Arial'

    Font.Style = [fsBold]

    ParentBiDiMode = False

    ParentFont = False

    Transparent = True

    Layout = tlCenter

    OnClick = Page23PrintBtnClick

    ExplicitLeft = 509

  end

  object Planner1: TDBPlanner

    Left = 0

    Top = -4

    Width = 417

    Height = 570

    Margins.Left = 0

    Margins.Top = 0

    Margins.Right = 0

    Margins.Bottom = 0

    ActiveDisplay = True

    AttachementGlyph.Data = {

      F6000000424DF600000000000000760000002800000010000000100000000100

      0400000000008000000000000000000000001000000000000000000000000000

      8000008000000080800080000000800080008080000080808000C0C0C0000000

      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888

      8888888888700078888888888708880788888888808808808888888880808080

      8888888880808080888888888080808088888888808080808888888880808080

      8888888880808080888888888080808088888888808080808888888888808080

      8888888888808880888888888888000888888888888888888888}

    AutoInsDel = True

    Caption.Title = ' <b>'#1043#1088#1072#1092#1080#1082' '#1079#1072' '#1076#1077#1085#1103'</b>'

    Caption.Font.Charset = RUSSIAN_CHARSET

    Caption.Font.Color = clWhite

    Caption.Font.Height = -13

    Caption.Font.Name = 'Verdana'

    Caption.Font.Style = []

    Caption.Height = 16

    DayNames.Strings = (

      'Sun'

      'Mon'

      'Tue'

      'Wed'

      'Thu'

      'Fri'

      'Sat')

    DefaultItem.BorderColor = clNone

    DefaultItem.CaptionBkg = clBlack

    DefaultItem.CaptionFont.Charset = RUSSIAN_CHARSET

    DefaultItem.CaptionFont.Color = clWindowText

    DefaultItem.CaptionFont.Height = -8

    DefaultItem.CaptionFont.Name = 'MS Sans Serif'

    DefaultItem.CaptionFont.Style = []

    DefaultItem.CaptionType = ctText

    DefaultItem.CaptionText = #1056#1077#1079#1077#1088#1074#1080#1088#1072#1085

    DefaultItem.Color = clRed

    DefaultItem.ColorTo = clRed

    DefaultItem.Cursor = -1

    DefaultItem.Editor = SimpleItemEditor1

    DefaultItem.Font.Charset = RUSSIAN_CHARSET

    DefaultItem.Font.Color = clWindowText

    DefaultItem.Font.Height = -11

    DefaultItem.Font.Name = 'Tahoma'

    DefaultItem.Font.Style = []

    DefaultItem.InplaceEdit = peForm

    DefaultItem.ItemBegin = 16

    DefaultItem.ItemEnd = 17

    DefaultItem.ItemPos = 0

    DefaultItem.Name = 'PlannerItem0'

    DefaultItem.ShowDeleteButton = True

    DefaultItem.SelectColor = 8421631

    DefaultItem.SelectFontColor = clNavy

    DefaultItem.Shadow = False

    DefaultItem.TrackColor = 8388863

    DefaultItem.TrackVisible = False

    DeleteGlyph.Data = {

      36050000424D3605000000000000360400002800000010000000100000000100

      0800000000000001000000000000000000000001000000000000000000000000

      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA

      A6000020400000206000002080000020A0000020C0000020E000004000000040

      20000040400000406000004080000040A0000040C0000040E000006000000060

      20000060400000606000006080000060A0000060C0000060E000008000000080

      20000080400000806000008080000080A0000080C0000080E00000A0000000A0

      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0

      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0

      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000

      20004000400040006000400080004000A0004000C0004000E000402000004020

      20004020400040206000402080004020A0004020C0004020E000404000004040

      20004040400040406000404080004040A0004040C0004040E000406000004060

      20004060400040606000406080004060A0004060C0004060E000408000004080

      20004080400040806000408080004080A0004080C0004080E00040A0000040A0

      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0

      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0

      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000

      20008000400080006000800080008000A0008000C0008000E000802000008020

      20008020400080206000802080008020A0008020C0008020E000804000008040

      20008040400080406000804080008040A0008040C0008040E000806000008060

      20008060400080606000806080008060A0008060C0008060E000808000008080

      20008080400080806000808080008080A0008080C0008080E00080A0000080A0

      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0

      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0

      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000

      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020

      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040

      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060

      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080

      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0

      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0

      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000

      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D9ED07070707

      0707070707070707ECD9EC5E5E5E5E5E5E5E5E5E5E5E5E5E5DED070D0E161616

      161616160E0E0E0E5E07070D161656561616161616160E0E5E07070D16AF075E

      56561657B7EF0E0E5E07070D56AFF6075F565FAFF6AF160E5E07070D565EAFF6

      075FEFF6AF17160E5E07070D5E5E5EAFF607F6AF161616165E07070D5E5E5E5E

      EFF60756161616165E07070D5E5E5FEFF6EFF6075E1616165E07070D5F5F07F6

      EF5EAFF6075616165E07070D6707F6075E5656AFF60716165E07070DA7AF075F

      5E5E5E5EAFAF56165E07070DA7A7675F5F5E5E5E5E5E56165E07EDAF0D0D0D0D

      0D0D0D0D0D0D0D0D5EECD9ED070707070707070707070707EDD1}

    DirectMove = True

    DisjunctSelect = True

    Display.ActiveStart = 48

    Display.ActiveEnd = 120

    Display.CurrentPosFrom = 282373

    Display.CurrentPosTo = 282379

    Display.DisplayStart = 48

    Display.DisplayEnd = 131

    Display.DisplayScale = 20

    Display.DisplayUnit = 10

    Display.ShowCurrent = True

    Display.ShowCurrentItem = True

    DragItem = True

    EnableFlashing = True

    FlashColor = 33023

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clBlack

    Font.Height = -9

    Font.Name = 'Tahoma'

    Font.Pitch = fpFixed

    Font.Style = []

    Footer.Captions.Strings = (

      ''

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0')

    Footer.CompletionFormat = '%d%%'

    Footer.Completion.Font.Charset = RUSSIAN_CHARSET

    Footer.Completion.Font.Color = clWindowText

    Footer.Completion.Font.Height = -11

    Footer.Completion.Font.Name = 'Arial'

    Footer.Completion.Font.Style = []

    Footer.Height = 16

    Footer.Font.Charset = RUSSIAN_CHARSET

    Footer.Font.Color = clWindowText

    Footer.Font.Height = -8

    Footer.Font.Name = 'Tahoma'

    Footer.Font.Style = []

    Footer.ShowCompletion = True

    GradientHorizontal = True

    GridLeftCol = 1

    GridLineColor = clGray

    GridTopRow = 0

    Header.Alignment = taCenter

    Header.AutoSize = True

    Header.Captions.Strings = (

      ''

      ''

      #1057#1086#1083#1072#1088#1080#1091#1084

      #1052#1072#1085#1080#1082#1102#1088

      ''

      ''

      ''

      '')

    Header.ColorTo = 2669047

    Header.CustomGroups = <

      item

        Span = 4

      end>

    Header.Height = 23

    Header.Font.Charset = RUSSIAN_CHARSET

    Header.Font.Color = clWindowText

    Header.Font.Height = -9

    Header.Font.Name = 'Tahoma'

    Header.Font.Orientation = 1

    Header.Font.Style = []

    Header.GroupFont.Charset = RUSSIAN_CHARSET

    Header.GroupFont.Color = clWindowText

    Header.GroupFont.Height = -7

    Header.GroupFont.Name = 'Tahoma'

    Header.GroupFont.Style = []

    Header.GroupCaptions.Strings = (

      '12.30.1899')

    Header.ItemHeight = 21

    Header.TextHeight = 21

    Header.WordWrap = True

    HTMLOptions.CellFontStyle = []

    HTMLOptions.HeaderFontStyle = []

    HTMLOptions.SidebarFontStyle = []

    InActiveDays.Sat = False

    InActiveDays.Sun = False

    ItemGap = 0

    Items = <>

    ItemSelection.AutoEditOnAutoInsert = True

    Mode.Month = 5

    Mode.PeriodStartDay = 10

    Mode.PeriodStartMonth = 5

    Mode.PeriodStartYear = 2009

    Mode.PeriodEndDay = 27

    Mode.PeriodEndMonth = 6

    Mode.PeriodEndYear = 2009

    Mode.TimeLineStart = 39943.000000000000000000

    Mode.TimeLineNVUBegin = 0

    Mode.TimeLineNVUEnd = 0

    Mode.Year = 2009

    MultiSelect = True

    NavigatorButtons.Visible = False

    Sidebar.Background = 6345725

    Sidebar.Font.Charset = RUSSIAN_CHARSET

    Sidebar.Font.Color = clWindowText

    Sidebar.Font.Height = -11

    Sidebar.Font.Name = 'Arial'

    Sidebar.Font.Style = []

    Sidebar.HourFontRatio = 1.800000000000000000

    Sidebar.TimeIndicator = True

    Positions = 7

    PositionAutoSize = True

    PositionGroup = 7

    PositionProps = <>

    PrintOptions.FooterFont.Charset = RUSSIAN_CHARSET

    PrintOptions.FooterFont.Color = clWindowText

    PrintOptions.FooterFont.Height = -11

    PrintOptions.FooterFont.Name = 'Tahoma'

    PrintOptions.FooterFont.Style = []

    PrintOptions.HeaderFont.Charset = RUSSIAN_CHARSET

    PrintOptions.HeaderFont.Color = clWindowText

    PrintOptions.HeaderFont.Height = -11

    PrintOptions.HeaderFont.Name = 'Tahoma'

    PrintOptions.HeaderFont.Style = []

    TrackBump = True

    TrackProportional = True

    URLGlyph.Data = {

      F6000000424DF600000000000000760000002800000010000000100000000100

      0400000000008000000000000000000000001000000000000000000000000000

      8000008000000080800080000000800080008080000080808000C0C0C0000000

      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800

      0088888808F8F0F8F80888808000000000808880F070888070F0888080000000

      0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0

      88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227

      888887F8F8222208888888776888208888888887777778888888}

    Version = '2.5.6.1'

    WheelDelta = 2

    OnHeaderDblClick = Planner1HeaderDblClick

    ItemSource = DBDaySource1

  end

  object PlannerDatePicker1: TPlannerDatePicker

    Left = 323

    Top = -1

    Width = 94

    Height = 18

    Flat = False

    LabelFont.Charset = RUSSIAN_CHARSET

    LabelFont.Color = clWindowText

    LabelFont.Height = -11

    LabelFont.Name = 'Tahoma'

    LabelFont.Style = []

    Lookup.Separator = ';'

    Color = clWindow

    Enabled = True

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -8

    Font.Name = 'Tahoma'

    Font.Style = []

    ParentFont = False

    ReadOnly = False

    TabOrder = 1

    Visible = True

    OnChange = PlannerDatePicker1Change

    Version = '1.6.2.2'

    ButtonStyle = bsDropDown

    ButtonWidth = 14

    Etched = False

    Glyph.Data = {

      DA020000424DDA0200000000000036000000280000000D0000000D0000000100

      200000000000A402000000000000000000000000000000000000D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC0000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00000000000000000000000000D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC000000000000000000000000000000000000000000D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC000000000000000000000000000000

      0000000000000000000000000000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9

      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00}

    Calendar = cal_.Owner

    HideCalendarAfterSelection = True

    object cal_: TPlannerCalendar

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

      ReturnIsSelect = True

      ShowGotoToday = True

      ShowToday = True

      StartDay = 7

      TodayFormat = '"Today" DDD/mm, YYYY'

      Day = 10

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

  object Planner2: TDBPlanner

    Left = 439

    Top = 3

    Width = 330

    Height = 290

    ActiveDisplay = True

    AttachementGlyph.Data = {

      F6000000424DF600000000000000760000002800000010000000100000000100

      0400000000008000000000000000000000001000000000000000000000000000

      8000008000000080800080000000800080008080000080808000C0C0C0000000

      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888

      8888888888700078888888888708880788888888808808808888888880808080

      8888888880808080888888888080808088888888808080808888888880808080

      8888888880808080888888888080808088888888808080808888888888808080

      8888888888808880888888888888000888888888888888888888}

    AutoInsDel = True

    Caption.Title = ' <b>'#1043#1088#1072#1092#1080#1082' '#1079#1072' '#1091#1090#1088#1077'</b>'

    Caption.Font.Charset = RUSSIAN_CHARSET

    Caption.Font.Color = clWhite

    Caption.Font.Height = -12

    Caption.Font.Name = 'Verdana'

    Caption.Font.Style = []

    Caption.Height = 12

    DayNames.Strings = (

      'Sun'

      'Mon'

      'Tue'

      'Wed'

      'Thu'

      'Fri'

      'Sat')

    DefaultItem.AllowOverlap = False

    DefaultItem.Background = True

    DefaultItem.BorderColor = clLime

    DefaultItem.CaptionBkg = clBlack

    DefaultItem.CaptionFont.Charset = RUSSIAN_CHARSET

    DefaultItem.CaptionFont.Color = clWindowText

    DefaultItem.CaptionFont.Height = -11

    DefaultItem.CaptionFont.Name = 'Tahoma'

    DefaultItem.CaptionFont.Style = []

    DefaultItem.CaptionText = #1056#1077#1079#1077#1088#1074#1072#1094#1080#1103

    DefaultItem.Color = 8388863

    DefaultItem.ColorTo = 2669047

    DefaultItem.Cursor = -1

    DefaultItem.Editor = SimpleItemEditor1

    DefaultItem.FixedPos = True

    DefaultItem.FixedSize = True

    DefaultItem.Font.Charset = RUSSIAN_CHARSET

    DefaultItem.Font.Color = clWindowText

    DefaultItem.Font.Height = -11

    DefaultItem.Font.Name = 'Tahoma'

    DefaultItem.Font.Style = []

    DefaultItem.ItemBegin = 16

    DefaultItem.ItemEnd = 17

    DefaultItem.ItemPos = 0

    DefaultItem.Name = 'PlannerItem0'

    DefaultItem.ReadOnly = True

    DefaultItem.ShowDeleteButton = True

    DefaultItem.Shadow = True

    DefaultItem.Text.Strings = (

      #1056#1077#1079#1077#1088#1074#1072#1094#1080#1103)

    DeleteGlyph.Data = {

      36050000424D3605000000000000360400002800000010000000100000000100

      0800000000000001000000000000000000000001000000000000000000000000

      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA

      A6000020400000206000002080000020A0000020C0000020E000004000000040

      20000040400000406000004080000040A0000040C0000040E000006000000060

      20000060400000606000006080000060A0000060C0000060E000008000000080

      20000080400000806000008080000080A0000080C0000080E00000A0000000A0

      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0

      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0

      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000

      20004000400040006000400080004000A0004000C0004000E000402000004020

      20004020400040206000402080004020A0004020C0004020E000404000004040

      20004040400040406000404080004040A0004040C0004040E000406000004060

      20004060400040606000406080004060A0004060C0004060E000408000004080

      20004080400040806000408080004080A0004080C0004080E00040A0000040A0

      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0

      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0

      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000

      20008000400080006000800080008000A0008000C0008000E000802000008020

      20008020400080206000802080008020A0008020C0008020E000804000008040

      20008040400080406000804080008040A0008040C0008040E000806000008060

      20008060400080606000806080008060A0008060C0008060E000808000008080

      20008080400080806000808080008080A0008080C0008080E00080A0000080A0

      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0

      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0

      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000

      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020

      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040

      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060

      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080

      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0

      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0

      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000

      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D9ED07070707

      0707070707070707ECD9EC5E5E5E5E5E5E5E5E5E5E5E5E5E5DED070D0E161616

      161616160E0E0E0E5E07070D161656561616161616160E0E5E07070D16AF075E

      56561657B7EF0E0E5E07070D56AFF6075F565FAFF6AF160E5E07070D565EAFF6

      075FEFF6AF17160E5E07070D5E5E5EAFF607F6AF161616165E07070D5E5E5E5E

      EFF60756161616165E07070D5E5E5FEFF6EFF6075E1616165E07070D5F5F07F6

      EF5EAFF6075616165E07070D6707F6075E5656AFF60716165E07070DA7AF075F

      5E5E5E5EAFAF56165E07070DA7A7675F5F5E5E5E5E5E56165E07EDAF0D0D0D0D

      0D0D0D0D0D0D0D0D5EECD9ED070707070707070707070707EDD1}

    DirectMove = True

    Display.ActiveStart = 48

    Display.ActiveEnd = 120

    Display.CurrentPosFrom = 282359

    Display.CurrentPosTo = 282365

    Display.DisplayStart = 48

    Display.DisplayEnd = 131

    Display.DisplayScale = 12

    Display.DisplayUnit = 10

    Display.ShowCurrent = True

    Display.ShowCurrentItem = True

    DragItem = True

    EditRTF = True

    EditDirect = True

    EnableFlashing = True

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -11

    Font.Name = 'Tahoma'

    Font.Style = []

    Footer.Captions.Strings = (

      ''

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0')

    Footer.CompletionFormat = '%d%%'

    Footer.Completion.Font.Charset = RUSSIAN_CHARSET

    Footer.Completion.Font.Color = clWindowText

    Footer.Completion.Font.Height = -11

    Footer.Completion.Font.Name = 'Arial'

    Footer.Completion.Font.Style = []

    Footer.Font.Charset = RUSSIAN_CHARSET

    Footer.Font.Color = clWindowText

    Footer.Font.Height = -11

    Footer.Font.Name = 'Tahoma'

    Footer.Font.Style = []

    Footer.ShowCompletion = True

    GridLeftCol = 1

    GridLineColor = clGray

    GridTopRow = 0

    Header.Alignment = taCenter

    Header.AutoSize = True

    Header.Captions.Strings = (

      ''

      #1057#1086#1083#1072#1088#1080#1091#1084

      #1057#1086#1083#1072#1088#1080#1091#1084

      ''

      ''

      ''

      ''

      '')

    Header.ColorTo = 2669047

    Header.CustomGroups = <>

    Header.Height = 21

    Header.Font.Charset = RUSSIAN_CHARSET

    Header.Font.Color = clWindowText

    Header.Font.Height = -7

    Header.Font.Name = 'Arial'

    Header.Font.Style = []

    Header.GroupFont.Charset = RUSSIAN_CHARSET

    Header.GroupFont.Color = clWindowText

    Header.GroupFont.Height = -7

    Header.GroupFont.Name = 'Tahoma'

    Header.GroupFont.Style = []

    Header.GroupCaptions.Strings = (

      '12.30.1899')

    Header.ItemHeight = 17

    Header.TextHeight = 19

    HTMLOptions.CellFontStyle = []

    HTMLOptions.HeaderFontStyle = []

    HTMLOptions.SidebarFontStyle = []

    InActiveDays.Sat = False

    InActiveDays.Sun = False

    Items = <>

    Mode.Month = 5

    Mode.PeriodStartDay = 10

    Mode.PeriodStartMonth = 5

    Mode.PeriodStartYear = 2009

    Mode.PeriodEndDay = 27

    Mode.PeriodEndMonth = 6

    Mode.PeriodEndYear = 2009

    Mode.TimeLineStart = 39943.000000000000000000

    Mode.TimeLineNVUBegin = 0

    Mode.TimeLineNVUEnd = 0

    Mode.Year = 2009

    NavigatorButtons.Visible = False

    Sidebar.Background = 6345725

    Sidebar.Font.Charset = RUSSIAN_CHARSET

    Sidebar.Font.Color = clWindowText

    Sidebar.Font.Height = -11

    Sidebar.Font.Name = 'Arial'

    Sidebar.Font.Style = []

    Sidebar.HourFontRatio = 1.800000000000000000

    Sidebar.TimeIndicator = True

    Positions = 7

    PositionGroup = 7

    PositionProps = <>

    PrintOptions.FooterFont.Charset = RUSSIAN_CHARSET

    PrintOptions.FooterFont.Color = clWindowText

    PrintOptions.FooterFont.Height = -11

    PrintOptions.FooterFont.Name = 'Tahoma'

    PrintOptions.FooterFont.Style = []

    PrintOptions.HeaderFont.Charset = RUSSIAN_CHARSET

    PrintOptions.HeaderFont.Color = clWindowText

    PrintOptions.HeaderFont.Height = -11

    PrintOptions.HeaderFont.Name = 'Tahoma'

    PrintOptions.HeaderFont.Style = []

    URLGlyph.Data = {

      F6000000424DF600000000000000760000002800000010000000100000000100

      0400000000008000000000000000000000001000000000000000000000000000

      8000008000000080800080000000800080008080000080808000C0C0C0000000

      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800

      0088888808F8F0F8F80888808000000000808880F070888070F0888080000000

      0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0

      88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227

      888887F8F8222208888888776888208888888887777778888888}

    Version = '2.5.6.1'

    WheelDelta = 2

    OnHeaderDblClick = Planner2HeaderDblClick

    ItemSource = DBDaySource2

  end

  object Planner3: TDBPlanner

    Left = 439

    Top = 300

    Width = 330

    Height = 199

    ActiveDisplay = True

    AttachementGlyph.Data = {

      F6000000424DF600000000000000760000002800000010000000100000000100

      0400000000008000000000000000000000001000000000000000000000000000

      8000008000000080800080000000800080008080000080808000C0C0C0000000

      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888

      8888888888700078888888888708880788888888808808808888888880808080

      8888888880808080888888888080808088888888808080808888888880808080

      8888888880808080888888888080808088888888808080808888888888808080

      8888888888808880888888888888000888888888888888888888}

    AutoInsDel = True

    Caption.Title = ' <b>'#1043#1088#1072#1092#1080#1082' '#1079#1072' '#1076#1088#1091#1075#1080' '#1076#1077#1085'</b>'

    Caption.Font.Charset = RUSSIAN_CHARSET

    Caption.Font.Color = clWhite

    Caption.Font.Height = -12

    Caption.Font.Name = 'Verdana'

    Caption.Font.Style = []

    Caption.Height = 12

    DayNames.Strings = (

      'Sun'

      'Mon'

      'Tue'

      'Wed'

      'Thu'

      'Fri'

      'Sat')

    DefaultItem.AllowOverlap = False

    DefaultItem.Background = True

    DefaultItem.BorderColor = clLime

    DefaultItem.CaptionBkg = clBlack

    DefaultItem.CaptionFont.Charset = RUSSIAN_CHARSET

    DefaultItem.CaptionFont.Color = clWindowText

    DefaultItem.CaptionFont.Height = -11

    DefaultItem.CaptionFont.Name = 'Tahoma'

    DefaultItem.CaptionFont.Style = []

    DefaultItem.CaptionText = #1056#1077#1079#1077#1088#1074#1072#1094#1080#1103

    DefaultItem.Color = 8388863

    DefaultItem.ColorTo = 2669047

    DefaultItem.Cursor = -1

    DefaultItem.Editor = SimpleItemEditor1

    DefaultItem.FixedPos = True

    DefaultItem.FixedSize = True

    DefaultItem.Font.Charset = RUSSIAN_CHARSET

    DefaultItem.Font.Color = clWindowText

    DefaultItem.Font.Height = -11

    DefaultItem.Font.Name = 'Tahoma'

    DefaultItem.Font.Style = []

    DefaultItem.ItemBegin = 16

    DefaultItem.ItemEnd = 17

    DefaultItem.ItemPos = 0

    DefaultItem.Name = 'PlannerItem0'

    DefaultItem.ReadOnly = True

    DefaultItem.ShowDeleteButton = True

    DefaultItem.Shadow = True

    DefaultItem.Text.Strings = (

      #1056#1077#1079#1077#1088#1074#1072#1094#1080#1103)

    DeleteGlyph.Data = {

      36050000424D3605000000000000360400002800000010000000100000000100

      0800000000000001000000000000000000000001000000000000000000000000

      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA

      A6000020400000206000002080000020A0000020C0000020E000004000000040

      20000040400000406000004080000040A0000040C0000040E000006000000060

      20000060400000606000006080000060A0000060C0000060E000008000000080

      20000080400000806000008080000080A0000080C0000080E00000A0000000A0

      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0

      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0

      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000

      20004000400040006000400080004000A0004000C0004000E000402000004020

      20004020400040206000402080004020A0004020C0004020E000404000004040

      20004040400040406000404080004040A0004040C0004040E000406000004060

      20004060400040606000406080004060A0004060C0004060E000408000004080

      20004080400040806000408080004080A0004080C0004080E00040A0000040A0

      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0

      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0

      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000

      20008000400080006000800080008000A0008000C0008000E000802000008020

      20008020400080206000802080008020A0008020C0008020E000804000008040

      20008040400080406000804080008040A0008040C0008040E000806000008060

      20008060400080606000806080008060A0008060C0008060E000808000008080

      20008080400080806000808080008080A0008080C0008080E00080A0000080A0

      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0

      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0

      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000

      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020

      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040

      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060

      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080

      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0

      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0

      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000

      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D9ED07070707

      0707070707070707ECD9EC5E5E5E5E5E5E5E5E5E5E5E5E5E5DED070D0E161616

      161616160E0E0E0E5E07070D161656561616161616160E0E5E07070D16AF075E

      56561657B7EF0E0E5E07070D56AFF6075F565FAFF6AF160E5E07070D565EAFF6

      075FEFF6AF17160E5E07070D5E5E5EAFF607F6AF161616165E07070D5E5E5E5E

      EFF60756161616165E07070D5E5E5FEFF6EFF6075E1616165E07070D5F5F07F6

      EF5EAFF6075616165E07070D6707F6075E5656AFF60716165E07070DA7AF075F

      5E5E5E5EAFAF56165E07070DA7A7675F5F5E5E5E5E5E56165E07EDAF0D0D0D0D

      0D0D0D0D0D0D0D0D5EECD9ED070707070707070707070707EDD1}

    DirectMove = True

    Display.ActiveStart = 48

    Display.ActiveEnd = 120

    Display.CurrentPosFrom = 282359

    Display.CurrentPosTo = 282365

    Display.DisplayStart = 48

    Display.DisplayEnd = 131

    Display.DisplayScale = 12

    Display.DisplayUnit = 10

    Display.ShowCurrent = True

    Display.ShowCurrentItem = True

    DragItem = True

    EditRTF = True

    EditDirect = True

    EnableFlashing = True

    Font.Charset = RUSSIAN_CHARSET

    Font.Color = clWindowText

    Font.Height = -11

    Font.Name = 'Tahoma'

    Font.Style = []

    Footer.Captions.Strings = (

      ''

      '0'

      '0'

      '0'

      '0'

      '0'

      '0'

      '0')

    Footer.CompletionFormat = '%d%%'

    Footer.Completion.Font.Charset = RUSSIAN_CHARSET

    Footer.Completion.Font.Color = clWindowText

    Footer.Completion.Font.Height = -11

    Footer.Completion.Font.Name = 'Arial'

    Footer.Completion.Font.Style = []

    Footer.Font.Charset = RUSSIAN_CHARSET

    Footer.Font.Color = clWindowText

    Footer.Font.Height = -11

    Footer.Font.Name = 'Tahoma'

    Footer.Font.Style = []

    Footer.ShowCompletion = True

    GridLeftCol = 1

    GridLineColor = clGray

    GridTopRow = 0

    Header.Alignment = taCenter

    Header.AutoSize = True

    Header.Captions.Strings = (

      ''

      ''

      ''

      ''

      ''

      ''

      ''

      '')

    Header.ColorTo = 2669047

    Header.CustomGroups = <>

    Header.Height = 21

    Header.Font.Charset = RUSSIAN_CHARSET

    Header.Font.Color = clWindowText

    Header.Font.Height = -7

    Header.Font.Name = 'Arial'

    Header.Font.Style = []

    Header.GroupFont.Charset = RUSSIAN_CHARSET

    Header.GroupFont.Color = clWindowText

    Header.GroupFont.Height = -7

    Header.GroupFont.Name = 'Tahoma'

    Header.GroupFont.Style = []

    Header.GroupCaptions.Strings = (

      '12.30.1899')

    Header.ItemHeight = 17

    Header.TextHeight = 19

    HTMLOptions.CellFontStyle = []

    HTMLOptions.HeaderFontStyle = []

    HTMLOptions.SidebarFontStyle = []

    InActiveDays.Sat = False

    InActiveDays.Sun = False

    Items = <>

    Mode.Month = 5

    Mode.PeriodStartDay = 10

    Mode.PeriodStartMonth = 5

    Mode.PeriodStartYear = 2009

    Mode.PeriodEndDay = 27

    Mode.PeriodEndMonth = 6

    Mode.PeriodEndYear = 2009

    Mode.TimeLineStart = 39943.000000000000000000

    Mode.TimeLineNVUBegin = 0

    Mode.TimeLineNVUEnd = 0

    Mode.Year = 2009

    NavigatorButtons.Visible = False

    Sidebar.Background = 6345725

    Sidebar.Font.Charset = RUSSIAN_CHARSET

    Sidebar.Font.Color = clWindowText

    Sidebar.Font.Height = -11

    Sidebar.Font.Name = 'Arial'

    Sidebar.Font.Style = []

    Sidebar.HourFontRatio = 1.800000000000000000

    Sidebar.TimeIndicator = True

    Positions = 7

    PositionGroup = 7

    PositionProps = <>

    PrintOptions.FooterFont.Charset = RUSSIAN_CHARSET

    PrintOptions.FooterFont.Color = clWindowText

    PrintOptions.FooterFont.Height = -11

    PrintOptions.FooterFont.Name = 'Tahoma'

    PrintOptions.FooterFont.Style = []

    PrintOptions.HeaderFont.Charset = RUSSIAN_CHARSET

    PrintOptions.HeaderFont.Color = clWindowText

    PrintOptions.HeaderFont.Height = -11

    PrintOptions.HeaderFont.Name = 'Tahoma'

    PrintOptions.HeaderFont.Style = []

    URLGlyph.Data = {

      F6000000424DF600000000000000760000002800000010000000100000000100

      0400000000008000000000000000000000001000000000000000000000000000

      8000008000000080800080000000800080008080000080808000C0C0C0000000

      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800

      0088888808F8F0F8F80888808000000000808880F070888070F0888080000000

      0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0

      88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227

      888887F8F8222208888888776888208888888887777778888888}

    Version = '2.5.6.1'

    WheelDelta = 2

    ItemSource = DBDaySource3

  end

  object TrackBar1: TTrackBar

    Left = 0

    Top = 570

    Width = 790

    Height = 14

    Cursor = crHandPoint

    Align = alBottom

    BorderWidth = 2

    LineSize = 3

    Max = 30

    Min = 7

    Position = 20

    ShowSelRange = False

    TabOrder = 4

    ThumbLength = 15

    TickMarks = tmTopLeft

    TickStyle = tsNone

    OnChange = TrackBar1Change

  end

end