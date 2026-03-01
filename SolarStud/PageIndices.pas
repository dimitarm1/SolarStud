unit PageIndices;

interface

const
  // Page indices - matching the original AdvPageControl1 tab order
  PAGE_LOGO_EKRAN = 0;              // LogoEkran1
  PAGE_OSNOVEN_EKRAN = 1;           // OsnovenEkran2
  PAGE_FIRMI_I_SLUZITELI = 2;       // FirmiISluziteli3
  PAGE_IZBOR_NA_PLASHTANE = 3;      // IzborNaPlashtane4
  PAGE_IZBOR_NA_VREME = 4;          // IzborNaVreme5
  PAGE_MENU = 5;                    // Menu6
  PAGE_SOLARIUMI_NASTROIKI = 6;     // SolariumiNastroiki7
  PAGE_SOLARIUMI_INFO = 7;          // SolariumiInfo8
  PAGE_SOLARIUMI_CENI = 8;          // SolariumiCeni9
  PAGE_NACHALNO_USTANOVIAVANE = 9;  // NachalnoUstanoviavane10
  PAGE_ARHIVIRANE = 10;             // Arhivirane11
  PAGE_STATISTIKA = 11;             // Statistika12
  PAGE_PROTOKOL = 12;               // Protokol13
  PAGE_OSNOVNI_NASTROIKI = 13;      // OsnovniNastroiki14
  PAGE_DRUGI_NASTROIKI = 14;        // DrugiNastroiki15
  PAGE_MENU_KASA = 15;              // MenuKasa16
  PAGE_MENU_STOKI = 16;             // ManuStoki17
  PAGE_KLUBNI_KARTI = 17;           // KlubniKarti18
  PAGE_CHIP_KARTI = 18;             // ChipKarti19
  PAGE_GRAFIK = 19;                 // Grafik23

  PAGE_COUNT = 20;

  // Page names for logging/debugging
  PAGE_NAMES: array[0..PAGE_COUNT-1] of string = (
    'LogoEkran',
    'OsnovenEkran',
    'FirmiISluziteli',
    'IzborNaPlashtane',
    'IzborNaVreme',
    'Menu',
    'SolariumiNastroiki',
    'SolariumiInfo',
    'SolariumiCeni',
    'NachalnoUstanoviavane',
    'Arhivirane',
    'Statistika',
    'Protokol',
    'OsnovniNastroiki',
    'DrugiNastroiki',
    'MenuKasa',
    'MenuStoki',
    'KlubniKarti',
    'ChipKarti',
    'Grafik'
  );

implementation

end.
