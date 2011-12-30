unit statistika1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeeEdit, TeEngine, Series, ExtCtrls, TeeProcs, Chart, DBChart,
  DB, TeeDBEdit, TeeDBCrossTab, TeeData, ABSMain, TeeComma, TeeOpenGL,
  Grids, TeeChartGrid, StdCtrls, TeeLisB, DBCtrls, DBGrids;

type
  Tstatistikatest = class(TForm)
    ABSDatabase1: TABSDatabase;
    ABSTable1: TABSTable;
    DataSource1: TDataSource;
    TeeCommander1: TTeeCommander;
    Chart1: TChart;
    Series1: TBarSeries;
    DBCrossTabSource1: TDBCrossTabSource;
    ABSQuery1: TABSQuery;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    ABSQuery2: TABSQuery;
    ABSQuery3: TABSQuery;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  statistikatest: Tstatistikatest;

implementation

{$R *.dfm}

procedure Tstatistikatest.Button1Click(Sender: TObject);
begin
Chart1.Series[0].Title:='Сумарна';
end;

end.
