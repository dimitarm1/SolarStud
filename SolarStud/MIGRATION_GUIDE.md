# Migration Guide: AdvPageControl1 to PageManager

## Overview

This guide explains how to migrate from the monolithic `AdvPageControl1` with 20 tab sheets
to a lazy-loaded frame-based architecture using `TPageManager`.

## Files Created

### Core Infrastructure
- `BasePageFrame.pas/.dfm` - Base class for all page frames
- `PageManager.pas` - Manages lazy loading and switching of pages
- `PageIndices.pas` - Constants for page indices
- `PageFrames.pas` - Registers all page frame classes

### Page Frame Files (in Pages/ folder)
Each former tab sheet now has its own frame with extracted components.

## Step-by-Step Migration

### Step 1: Backup your files
```bash
cp main.pas main.pas.backup
cp main.dfm main.dfm.backup
cp SolarStudio1.2.dpr SolarStudio1.2.dpr.backup
```

### Step 2: Update main.pas uses clause

Add these units to the uses clause:
```pascal
uses
  // ... existing units ...
  PageManager, PageIndices, PageFrames, BasePageFrame;
```

### Step 3: Modify TMainForm class declaration

Add to private section:
```pascal
private
  FPageManager: TPageManager;
```

Add to public section:
```pascal
public
  property PageManager: TPageManager read FPageManager;
  procedure ShowPage(APageIndex: Integer);
  function ActivePageIndex: Integer;
```

Remove these tab sheet declarations (they are now in separate frame units):
```pascal
// REMOVE these:
LogoEkran1: TAdvTabSheet;
OsnovenEkran2: TAdvTabSheet;
// ... all other TAdvTabSheet declarations
```

### Step 4: Add PageContainer to main.dfm

Replace the entire AdvPageControl1 object with a simple TPanel:
```
object PageContainer: TPanel
  Left = 0
  Top = 0
  Width = 792
  Height = 833
  Align = alClient
  BevelOuter = bvNone
  Color = clAppWorkSpace
  TabOrder = 0
end
```

### Step 5: Modify FormCreate in main.pas

Add after existing initialization code:
```pascal
procedure TMainForm.FormCreate(Sender: TObject);
begin
  // ... existing code ...
  
  // Initialize PageManager (replace AdvPageControl1.ActivePageIndex := 0)
  FPageManager := TPageManager.Create(PageContainer);
  RegisterAllPages(FPageManager);
  FPageManager.ShowPage(PAGE_LOGO_EKRAN);
  
  // ... rest of existing code ...
end;
```

### Step 6: Add FormDestroy

```pascal
procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FPageManager.Free;
end;
```

### Step 7: Add helper methods

```pascal
procedure TMainForm.ShowPage(APageIndex: Integer);
begin
  FPageManager.ShowPage(APageIndex);
end;

function TMainForm.ActivePageIndex: Integer;
begin
  Result := FPageManager.ActivePageIndex;
end;
```

### Step 8: Run the sed script to replace references

```bash
sed -f migrate_main_pas.sed main.pas > main_migrated.pas
# Review the changes, then:
mv main_migrated.pas main.pas
```

### Step 9: Remove/comment the AdvPageControl1Change procedure

The procedure can be removed - each frame's DoPageActivate handles activation.

### Step 10: Update the project file

Replace `SolarStudio1.2.dpr` with `SolarStudio1.2.dpr.new`

## Component Types to Add to Frame Uses Clauses

The extracted frames will need additional units based on their components.
Common additions:

```pascal
uses
  // Standard
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Gauges, Buttons, Mask,
  ComCtrls, jpeg,
  // Third-party (add as needed)
  AdvPageControl, LMDControl, LMDButton, LMDLImage, // etc.
  // Database
  DB, DBTables, ABSMain,
  // Base
  BasePageFrame;
```

## Testing Strategy

1. First, compile with empty frames (just show "Page X loaded")
2. Verify page switching works correctly
3. Gradually add components to each frame
4. Test each page thoroughly after adding components

## Troubleshooting

### Component not found error
Add the required unit to the frame's uses clause.

### Circular reference error
Move `uses MAIN;` to the implementation section of frame units.

### Event handler not found
Move the event handler to the frame or keep it on MainForm and reference as `MainForm.HandlerName`.

## Benefits After Migration

1. **Faster startup** - Only the initial page loads at startup
2. **Lower memory usage** - Unused pages don't consume memory
3. **Better code organization** - Each page is a separate unit
4. **Easier maintenance** - Changes to one page don't affect others
5. **Parallel development** - Multiple developers can work on different pages
