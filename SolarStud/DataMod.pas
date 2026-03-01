unit DataMod;

interface

uses
  SysUtils, Classes, DB, ABSMain, DBPlanner;

type
  TDM = class(TDataModule)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    sol1: TABSDatabase;
    SOLARIUMI: TABSTable;
    Table3: TABSTable;
    Internet: TABSTable;
    DataSource3: TDataSource;
    DayTotal: TABSQuery;
    DataSource5: TDataSource;
    Spravka1: TABSQuery;
    STOKI: TABSTable;
    KARTI: TABSQuery;
    DataSource6: TDataSource;
    DataSource7: TDataSource;
    STOKITE: TABSQuery;
    DataSource8: TDataSource;
    KARTIALL1: TABSTable;
    DataSource10: TDataSource;
    Sdelka: TABSQuery;
    PlashtaniaTable: TABSTable;
    DataSource9: TDataSource;
    MinMax: TABSQuery;
    DataSource11: TDataSource;
    DataSource12: TDataSource;
    KARTIALL: TABSTable;
    solariumspr: TABSTable;
    stokispr: TABSTable;
    DataSource13: TDataSource;
    Qklienti: TABSQuery;
    Qkarti: TABSQuery;
    DataSource14: TDataSource;
    QKartiPaid: TABSQuery;
    QChipKarti: TABSQuery;
    DataSource4: TDataSource;
    CHIPKARTI: TABSTable;
    QStatistika: TABSQuery;
    personal1: TABSTable;
    personalset: TDataSource;
    DataSource15: TDataSource;
    KARTICHIP: TABSTable;
    DataSource16: TDataSource;
    maxday: TABSQuery;
    Plashtania: TABSQuery;
    CENITABLE: TABSTable;
    DataSource17: TDataSource;
    QCeni: TABSQuery;
    USLUGITE: TABSQuery;
    DataSource18: TDataSource;
    Firmite: TABSQuery;
    DataSource19: TDataSource;
    Planner: TABSTable;
    DataSource20: TDataSource;
    DBDaySource1: TDBDaySource;
    DBDaySource2: TDBDaySource;
    DBDaySource3: TDBDaySource;
    PLANNER02: TABSTable;
    DataSource21: TDataSource;
    PLANNER03: TABSTable;
    DataSource22: TDataSource;
    STOKITE_SKLAD: TABSQuery;
    DataSource23: TDataSource;
    DataSource24: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

end.
