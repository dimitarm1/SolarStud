unit PageFrames;

interface

uses
  Classes, PageManager, PageIndices,
  // Page frame units
  LogoEkranFrame,
  OsnovenEkranFrame,
  FirmiISluziteliFrame,
  IzborNaPlashtaneFrame,
  IzborNaVremeFrame,
  MenuFrame,
  SolariumiNastroikiFrame,
  SolariumiInfoFrame,
  SolariumiCeniFrame,
  NachalnoUstanoviavaneFrame,
  ArhiviraneFrame,
  StatistikaFrame,
  ProtokolFrame,
  OsnovniNastroikiFrame,
  DrugiNastroikiFrame,
  MenuKasaFrame,
  MenuStokiFrame,
  KlubniKartiFrame,
  ChipKartiFrame,
  GrafikFrame;

procedure RegisterAllPages(APageManager: TPageManager);
procedure PreloadAllPages(APageManager: TPageManager);

implementation

procedure RegisterAllPages(APageManager: TPageManager);
begin
  APageManager.RegisterPage(PAGE_LOGO_EKRAN, PAGE_NAMES[PAGE_LOGO_EKRAN], TLogoEkranFrame);
  APageManager.RegisterPage(PAGE_OSNOVEN_EKRAN, PAGE_NAMES[PAGE_OSNOVEN_EKRAN], TOsnovenEkranFrame);
  APageManager.RegisterPage(PAGE_FIRMI_I_SLUZITELI, PAGE_NAMES[PAGE_FIRMI_I_SLUZITELI], TFirmiISluziteliFrame);
  APageManager.RegisterPage(PAGE_IZBOR_NA_PLASHTANE, PAGE_NAMES[PAGE_IZBOR_NA_PLASHTANE], TIzborNaPlashtaneFrame);
  APageManager.RegisterPage(PAGE_IZBOR_NA_VREME, PAGE_NAMES[PAGE_IZBOR_NA_VREME], TIzborNaVremeFrame);
  APageManager.RegisterPage(PAGE_MENU, PAGE_NAMES[PAGE_MENU], TMenuFrame);
  APageManager.RegisterPage(PAGE_SOLARIUMI_NASTROIKI, PAGE_NAMES[PAGE_SOLARIUMI_NASTROIKI], TSolariumiNastroikiFrame);
  APageManager.RegisterPage(PAGE_SOLARIUMI_INFO, PAGE_NAMES[PAGE_SOLARIUMI_INFO], TSolariumiInfoFrame);
  APageManager.RegisterPage(PAGE_SOLARIUMI_CENI, PAGE_NAMES[PAGE_SOLARIUMI_CENI], TSolariumiCeniFrame);
  APageManager.RegisterPage(PAGE_NACHALNO_USTANOVIAVANE, PAGE_NAMES[PAGE_NACHALNO_USTANOVIAVANE], TNachalnoUstanoviavaneFrame);
  APageManager.RegisterPage(PAGE_ARHIVIRANE, PAGE_NAMES[PAGE_ARHIVIRANE], TArhiviraneFrame);
  APageManager.RegisterPage(PAGE_STATISTIKA, PAGE_NAMES[PAGE_STATISTIKA], TStatistikaFrame);
  APageManager.RegisterPage(PAGE_PROTOKOL, PAGE_NAMES[PAGE_PROTOKOL], TProtokolFrame);
  APageManager.RegisterPage(PAGE_OSNOVNI_NASTROIKI, PAGE_NAMES[PAGE_OSNOVNI_NASTROIKI], TOsnovniNastroikiFrame);
  APageManager.RegisterPage(PAGE_DRUGI_NASTROIKI, PAGE_NAMES[PAGE_DRUGI_NASTROIKI], TDrugiNastroikiFrame);
  APageManager.RegisterPage(PAGE_MENU_KASA, PAGE_NAMES[PAGE_MENU_KASA], TMenuKasaFrame);
  APageManager.RegisterPage(PAGE_MENU_STOKI, PAGE_NAMES[PAGE_MENU_STOKI], TMenuStokiFrame);
  APageManager.RegisterPage(PAGE_KLUBNI_KARTI, PAGE_NAMES[PAGE_KLUBNI_KARTI], TKlubniKartiFrame);
  APageManager.RegisterPage(PAGE_CHIP_KARTI, PAGE_NAMES[PAGE_CHIP_KARTI], TChipKartiFrame);
  APageManager.RegisterPage(PAGE_GRAFIK, PAGE_NAMES[PAGE_GRAFIK], TGrafikFrame);
end;

procedure PreloadAllPages(APageManager: TPageManager);
var
  I: Integer;
begin
  // Preload all pages to ensure cross-page component access works
  for I := PAGE_LOGO_EKRAN to PAGE_GRAFIK do
    APageManager.PreloadPage(I);
end;

end.
