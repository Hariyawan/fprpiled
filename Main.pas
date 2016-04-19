unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ActnList, StdCtrls, ExtCtrls, Buttons, ComCtrls, XMLPropStorage, Unix,
  BaseUnix,
  GPIOInterface;

type

  TGpioControl = (
                gc_none,
  						  gc_led_y,gc_led_r,gc_led_g,gc_led_b,gc_led_w,
  							gc_rgb_r,gc_rgb_g,gc_rgb_b,
                gc_ry_r,gc_ry_y,
                gc_gy_g,gc_gy_y);

  TGpioControls = array[TAvailableGpio] of TGpioControl;
  TGpioWirings = array[TGpioControl] of longint;
  TGpioWiringsDesc = array[TGpioControl] of string;

  { TFormMain }

  TFormMain = class(TForm)
    ActExit: TAction;
    ActAbout: TAction;
    ActGpioConnections: TAction;
    ActTurnRyYellowOff: TAction;
    ActTurnRyYellowOn: TAction;
    ActTurnGyYellowOff: TAction;
    ActTurnGyYellowOn: TAction;
    ActTurnRyRedOff: TAction;
    ActTurnRyRedOn: TAction;
    ActTurnGyGreenOff: TAction;
    ActTurnGyGreenOn: TAction;
    ActTurnBlueOff: TAction;
    ActTurnBlueOn: TAction;
    ActTurnWhiteOff: TAction;
    ActTurnWhiteOn: TAction;
    ActTurnRgbGreenOff: TAction;
    ActTurnRgbBlueOff: TAction;
    ActTurnRgbBlueOn: TAction;
    ActTurnRgbGreenOn: TAction;
    ActTurnRgbRedOff: TAction;
    ActTurnRgbRedOn: TAction;
    ActTurnYellowOff: TAction;
    ActTurnYellowOn: TAction;
    ActTurnRedOff: TAction;
    ActTurnRedOn: TAction;
    ActResetGPIO: TAction;
    ActTurnGreenOff: TAction;
    ActTurnGreenOn: TAction;
    ActionList1: TActionList;
    BoxRYLed: TGroupBox;
    BoxGYLed: TGroupBox;
    GroupBox1: TGroupBox;
    BoxSingleLeds: TGroupBox;
    BoxRgbLed: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    ImgLedBlueOff: TImage;
    ImgLedBlueOn: TImage;
    ImgGyYellowOff: TImage;
    ImgGyYellowOn: TImage;
    ImgGyGreenOff: TImage;
    ImgGyGreenOn: TImage;
    ImgLedWhiteOff: TImage;
    ImgLedWhiteOn: TImage;
    ImgRyRedOff: TImage;
    ImgRyRedOn: TImage;
    ImgRyYellowOff: TImage;
    ImgRyYellowOn: TImage;
    ImgRgbBlueOff: TImage;
    ImgRgbBlueOn: TImage;
    ImgRgbGreenOff: TImage;
    ImgRgbGreenOn: TImage;
    ImgRgbRedOff: TImage;
    ImgRgbRedOn: TImage;
    ImgLedYellowOff: TImage;
    ImgLedYellowOn: TImage;
    ImgLedRedOn: TImage;
    ImgLedRedOff: TImage;
    ImgLedGreenOff: TImage;
    ImgLedGreenOn: TImage;
    MainMenu1: TMainMenu;
    MemoLog: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    ToggleLedB: TToggleBox;
    ToggleRyR: TToggleBox;
    ToggleRgbR: TToggleBox;
    ToggleRgbG: TToggleBox;
    ToggleRgbB: TToggleBox;
    ToggleLedY: TToggleBox;
    ToggleLedR: TToggleBox;
    ToggleLedG: TToggleBox;
    ToggleGyG: TToggleBox;
    ToggleRyY: TToggleBox;
    ToggleLedW: TToggleBox;
    ToggleGyY: TToggleBox;
    XMLPropStorage1: TXMLPropStorage;

    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure ActExitExecute(Sender: TObject);
    procedure ActResetGPIOExecute(Sender: TObject);
    procedure ActAboutExecute(Sender: TObject);
    procedure ActGpioConnectionsExecute(Sender: TObject);

    procedure ActTurnRedOffExecute(Sender: TObject);
    procedure ActTurnRedOnExecute(Sender: TObject);
    procedure ToggleLedRChange(Sender: TObject);

    procedure ActTurnGreenOffExecute(Sender: TObject);
    procedure ActTurnGreenOnExecute(Sender: TObject);
    procedure ToggleLedGChange(Sender: TObject);

    procedure ActTurnBlueOffExecute(Sender: TObject);
    procedure ActTurnBlueOnExecute(Sender: TObject);
    procedure ToggleLedBChange(Sender: TObject);

    procedure ActTurnWhiteOffExecute(Sender: TObject);
    procedure ActTurnWhiteOnExecute(Sender: TObject);
    procedure ToggleLedWChange(Sender: TObject);

    procedure ActTurnYellowOffExecute(Sender: TObject);
    procedure ActTurnYellowOnExecute(Sender: TObject);
    procedure ToggleLedYChange(Sender: TObject);

    procedure ActTurnRgbGreenOffExecute(Sender: TObject);
    procedure ActTurnRgbGreenOnExecute(Sender: TObject);
    procedure ToggleRgbGChange(Sender: TObject);

    procedure ActTurnRgbRedOffExecute(Sender: TObject);
    procedure ActTurnRgbRedOnExecute(Sender: TObject);
    procedure ToggleRgbRChange(Sender: TObject);

    procedure ActTurnRgbBlueOffExecute(Sender: TObject);
    procedure ActTurnRgbBlueOnExecute(Sender: TObject);
    procedure ToggleRgbBChange(Sender: TObject);

    procedure ActTurnRyRedOffExecute(Sender: TObject);
    procedure ActTurnRyRedOnExecute(Sender: TObject);
    procedure ToggleRyRChange(Sender: TObject);

    procedure ActTurnRyYellowOffExecute(Sender: TObject);
    procedure ActTurnRyYellowOnExecute(Sender: TObject);
    procedure ToggleRyYChange(Sender: TObject);

    procedure ActTurnGyGreenOffExecute(Sender: TObject);
    procedure ActTurnGyGreenOnExecute(Sender: TObject);
    procedure ToggleGyGChange(Sender: TObject);

    procedure ActTurnGyYellowOffExecute(Sender: TObject);
    procedure ActTurnGyYellowOnExecute(Sender: TObject);
    procedure ToggleGyYChange(Sender: TObject);


  private
    { private declarations }
    FGpioInterface: TGpioInterface;
    FGpioControls: TGpioControls;
    FGpioWirings: TGpioWirings;

    procedure RestoreGPIO;
    procedure SaveGPIO;
    procedure ResetGPIO;
    procedure UpdateGpioControls;
    procedure UpdateButtonsCaption;
    function TurnLedOn(GpioNumber: TAvailableGpio): longint;
    function TurnLedOff(GpioNumber: TAvailableGpio): longint;
  public
    { public declarations }
  end;

const
	GPIOWiringsDesc: TGpioWiringsDesc = ('none','Led Yellow','Led Red','Led Green','Led Blue','Led White',
  									 'RGB Red','RGB Green','RGB Blue','RY Red','RY Yellow','GY Green','GY Yellow');
var
  FormMain: TFormMain;

implementation
uses About, GPIOConnections;

{$R *.lfm}

{
 *******************************************************************************
 TFormMain
 *******************************************************************************
}
{
	Update buttons captions to reflect current GPIO wiring connections
}
procedure TFormMain.UpdateButtonsCaption;
begin
  ToggleLedY.Caption := format('Yellow ( GPIO%d )', [FGpioWirings[gc_led_y]]);
  ToggleLedR.Caption := format('Red    ( GPIO%d )', [FGpioWirings[gc_led_r]]);
  ToggleLedG.Caption := format('Green  ( GPIO%d )', [FGpioWirings[gc_led_g]]);
  ToggleLedB.Caption := format('Blue   ( GPIO%d )', [FGpioWirings[gc_led_b]]);
  ToggleLedW.Caption := format('White  ( GPIO%d )', [FGpioWirings[gc_led_w]]);
  ToggleRgbR.Caption := format('Red    ( GPIO%d )', [FGpioWirings[gc_rgb_r]]);
  ToggleRgbG.Caption := format('Green  ( GPIO%d )', [FGpioWirings[gc_rgb_g]]);
  ToggleRgbB.Caption := format('Blue   ( GPIO%d )', [FGpioWirings[gc_rgb_b]]);
  ToggleRyR.Caption := format('Red     ( GPIO%d )', [FGpioWirings[gc_ry_r]]);
  ToggleRyY.Caption := format('Yellow  ( GPIO%d )', [FGpioWirings[gc_ry_y]]);
  ToggleGyG.Caption := format('Green   ( GPIO%d )', [FGpioWirings[gc_gy_g]]);
  ToggleGyY.Caption := format('Yellow  ( GPIO%d )', [FGpioWirings[gc_gy_y]]);
end;
{
	Save GPIO wiring connections to XML
}
procedure TFormMain.SaveGPIO;
begin
  XMLPropStorage1.StoredValue['led_y'] := IntToStr(FGpioWirings[gc_led_y]);
  XMLPropStorage1.StoredValue['led_r'] := IntToStr(FGpioWirings[gc_led_r]);
  XMLPropStorage1.StoredValue['led_g'] := IntToStr(FGpioWirings[gc_led_g]);
  XMLPropStorage1.StoredValue['led_b'] := IntToStr(FGpioWirings[gc_led_b]);
  XMLPropStorage1.StoredValue['led_w'] := IntToStr(FGpioWirings[gc_led_w]);
  XMLPropStorage1.StoredValue['rgb_r'] := IntToStr(FGpioWirings[gc_rgb_r]);
  XMLPropStorage1.StoredValue['rgb_g'] := IntToStr(FGpioWirings[gc_rgb_g]);
  XMLPropStorage1.StoredValue['rgb_b'] := IntToStr(FGpioWirings[gc_rgb_b]);
  XMLPropStorage1.StoredValue['ry_r'] := IntToStr(FGpioWirings[gc_ry_r]);
  XMLPropStorage1.StoredValue['ry_y'] := IntToStr(FGpioWirings[gc_ry_y]);
  XMLPropStorage1.StoredValue['gy_g'] := IntToStr(FGpioWirings[gc_gy_g]);
  XMLPropStorage1.StoredValue['gy_y'] := IntToStr(FGpioWirings[gc_gy_y]);
end;
{
	Restore GPIO wiring connections from XML
}
procedure TFormMain.RestoreGPIO;
begin
  // update controls' pointers to GPIO number from XML saved values
  FGpioWirings[gc_led_y] := StrToInt(XMLPropStorage1.StoredValue['led_y']);
  FGpioWirings[gc_led_r] := StrToInt(XMLPropStorage1.StoredValue['led_r']);
  FGpioWirings[gc_led_g] := StrToInt(XMLPropStorage1.StoredValue['led_g']);
  FGpioWirings[gc_led_b] := StrToInt(XMLPropStorage1.StoredValue['led_b']);
  FGpioWirings[gc_led_w] := StrToInt(XMLPropStorage1.StoredValue['led_w']);
  FGpioWirings[gc_rgb_r] := StrToInt(XMLPropStorage1.StoredValue['rgb_r']);
  FGpioWirings[gc_rgb_g] := StrToInt(XMLPropStorage1.StoredValue['rgb_g']);
  FGpioWirings[gc_rgb_b] := StrToInt(XMLPropStorage1.StoredValue['rgb_b']);
  FGpioWirings[gc_ry_r] := StrToInt(XMLPropStorage1.StoredValue['ry_r']);
  FGpioWirings[gc_ry_y] := StrToInt(XMLPropStorage1.StoredValue['ry_y']);
  FGpioWirings[gc_gy_g] := StrToInt(XMLPropStorage1.StoredValue['gy_g']);
  FGpioWirings[gc_gy_y] := StrToInt(XMLPropStorage1.StoredValue['gy_y']);

  // update GPIO pointers to controls & controls
	UpdateGpioControls;
end;
{

}
procedure TFormMain.UpdateGpioControls;
var
	pin: TAvailableGpio;
  gc: TGpioControl;
begin
  // update GPIO pointers to controls
  for pin := MinGpio to MaxGpio do
  begin
    FGpioControls[pin] := gc_none;
  end;
  // NOTE: begins from Succ(Low(TGpioControl)) to exclude
  // gc_none
  for gc := Succ(Low(TGpioControl)) to High(TGpioControl) do
  begin
    FGpioControls[FGpioWirings[gc]] :=  gc;
  end;
	// update buttons
  UpdateButtonsCaption;
end;
{
	Reset GPIO interface
}
procedure TFormMain.ResetGPIO;
begin
  FGpioInterface.ResetGPIO;
  MemoLog.Lines.Add('GPIO Reset.');
end;
{
	Generic method to turn raise GPIO pin status
}
function TFormMain.TurnLedOn(GpioNumber: TAvailableGpio): longint;
begin
  if FGpioInterface.GpioStatus[GpioNumber] = ioUnset then
  begin
     FGpioInterface.Setup(GpioNumber,ioOutput);
     MemoLog.Lines.Add(format('GPIO%d not in output mode, set to ouput mode: %d',[GpioNumber,FGpioInterface.ReturnCode]))
  end;
  if FGpioInterface.GpioStatus[GpioNumber] = ioOutput then
  begin
    Result := FGpioInterface.Output(GpioNumber,true);
    MemoLog.Lines.Add(format('Turn GPIO%d High: %d',[GpioNumber,FGpioInterface.ReturnCode]));
  end
  else
  begin
     Result := FGpioInterface.ReturnCode;
     MemoLog.Lines.Add(format('Turn GPIO%d High abosted',[GpioNumber]));
  end;
end;
{
	Generic method to shut GPIO pin status down
}
function TFormmain.TurnLedOff(GpioNumber: TAvailableGpio): longint;
begin
  Result := FGpioInterface.Output(GpioNumber,false);
  MemoLog.Lines.Add(format('Turn GPIO%d off: %d',[GpioNumber,FGpioInterface.ReturnCode]));
end;

{
 -------------------------------------------------------------------------------
 TFormMain events
}
procedure TFormMain.FormCreate(Sender: TObject);
begin
  FGpioInterface := TGpioInterface.Create;
end;
{
	Show About dialog
}
procedure TFormMain.ActAboutExecute(Sender: TObject);
begin
  FormAbout.Showmodal;
end;
{
	Show GPIO wiring connections setup dialog
}
procedure TFormMain.ActGpioConnectionsExecute(Sender: TObject);
begin
  FormGpioConnections.GpioControls := FGpioControls;
  //FormGpioConnections.
  if FormGpioConnections.ShowModal = mrOk then
  begin
		FGpioWirings := FormGpioConnections.GpioWirings;
    UpdateGpioControls;
  end;
end;

{
*******************************************************************************
		Form EVENTS
*******************************************************************************
}

{
	ON SHOW
}
procedure TFormMain.FormShow(Sender: TObject);
begin
  RestoreGPIO;
end;
{
	ON DESTROY
}
procedure TFormMain.FormDestroy(Sender: TObject);
begin
  ResetGPIO;
  FGpioInterface.Free;
end;
{
	ON CLOSE
}
procedure TFormMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveGPIO;
end;

{
*******************************************************************************
		ACTIONS
*******************************************************************************
}

{
	EXIT action
}
procedure TFormMain.ActExitExecute(Sender: TObject);
begin
  Close;
end;
{
	Reset GPIO status
}
procedure TFormMain.ActResetGPIOExecute(Sender: TObject);
begin
  ResetGPIO;
end;

{
 Single LEDs
}

// SINGLE RED
procedure TFormMain.ActTurnRedOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_led_r]) = 0 then
  begin
    ImgLedRedOff.Visible := true;
    ImgLedRedOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnRedOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_led_r]) = 0 then
  begin
    ImgLedRedOff.Visible := false;
    ImgLedRedOn.Visible := true;
  end;
end;
procedure TFormMain.ToggleLedRChange(Sender: TObject);
begin
  if ToggleLedR.Checked then
  begin
    ActTurnRedOnExecute(Sender);
  end
  else
  begin
    ActTurnRedOffExecute(Sender);
  end;
end;
// SINGLE GREEN
procedure TFormMain.ActTurnGreenOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_led_r]) = 0 then
  begin
    ImgLedGreenOff.Visible := true;
    ImgLedGreenOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnGreenOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_led_r]) = 0 then
  begin
    ImgLedGreenOff.Visible := false;
    ImgLedGreenOn.Visible := true;
  end;
end;

procedure TFormMain.ToggleLedGChange(Sender: TObject);
begin
  if ToggleLedG.Checked then
  begin
    ActTurnGreenOnExecute(Sender);
  end
  else
  begin
    ActTurnGreenOffExecute(Sender);
  end;
end;

//SINGLE BLUE
procedure TFormMain.ActTurnBlueOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_led_b]) = 0 then
  begin
    ImgLedBlueOff.Visible := true;
    ImgLedBlueOn.Visible := false;
  end;
end;
procedure TFormMain.ActTurnBlueOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_led_b]) = 0 then
  begin
    ImgLedBlueOff.Visible := false;
    ImgLedBlueOn.Visible := true;
  end;
end;
procedure TFormMain.ToggleLedBChange(Sender: TObject);
begin
  if ToggleLedB.Checked then
  begin
    ActTurnBlueOnExecute(Sender);
  end
  else
  begin
    ActTurnBlueOffExecute(Sender);
  end;
end;

// SINGLE WHITE
procedure TFormMain.ActTurnWhiteOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_led_w]) = 0 then
  begin
    ImgLedWhiteOff.Visible := true;
    ImgLedWhiteOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnWhiteOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_led_w]) = 0 then
  begin
    ImgLedWhiteOff.Visible := false;
    ImgLedWhiteOn.Visible := true;
  end;
end;
procedure TFormMain.ToggleLedWChange(Sender: TObject);
begin
  if ToggleLedW.Checked then
  begin
    ActTurnWhiteOnExecute(Sender);
  end
  else
  begin
    ActTurnWhiteOffExecute(Sender);
  end;
end;

// SINGLE YELLOW
procedure TFormMain.ActTurnYellowOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_led_y]) = 0 then
  begin
    ImgLedYellowOff.Visible := true;
    ImgLedYellowOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnYellowOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_led_y]) = 0 then
  begin
    ImgLedYellowOff.Visible := false;
    ImgLedYellowOn.Visible := true;
  end;
end;

procedure TFormMain.ToggleLedYChange(Sender: TObject);
begin
  if ToggleLedY.Checked then
  begin
    ActTurnYellowOnExecute(Sender);
  end
  else
  begin
    ActTurnYellowOffExecute(Sender);
  end;
end;
{
 RGB LED
}
// RGB RED
procedure TFormMain.ActTurnRgbRedOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_rgb_r]) = 0 then
  begin
    ImgRgbRedOff.Visible := true;
    ImgRgbRedOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnRgbRedOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_rgb_r]) = 0 then
  begin
    ImgRgbRedOff.Visible := false;
    ImgRgbRedOn.Visible := true;
  end;
end;

procedure TFormMain.ToggleRgbRChange(Sender: TObject);
begin
  if ToggleRgbR.Checked then
  begin
    ActTurnRgbRedOnExecute(Sender);
  end
  else
  begin
    ActTurnRgbRedOffExecute(Sender);
  end;
end;
// RGB GREEN
procedure TFormMain.ActTurnRgbGreenOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_rgb_g]) = 0 then
  begin
    ImgRgbGreenOff.Visible := true;
    ImgRgbGreenOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnRgbGreenOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_rgb_g]) = 0 then
  begin
    ImgRgbGreenOff.Visible := false;
    ImgRgbGreenOn.Visible := true;
  end;
end;

procedure TFormMain.ToggleRgbGChange(Sender: TObject);
begin
  if ToggleRgbG.Checked then
  begin
    ActTurnRgbGreenOnExecute(Sender);
  end
  else
  begin
    ActTurnRgbGreenOffExecute(Sender);
  end;
end;

// RGB BLUE
procedure TFormMain.ActTurnRgbBlueOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_rgb_b]) = 0 then
  begin
    ImgRgbBlueOff.Visible := true;
    ImgRgbBlueOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnRgbBlueOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_rgb_b]) = 0 then
  begin
    ImgRgbBlueOff.Visible := false;
    ImgRgbBlueOn.Visible := true;
  end;
end;

procedure TFormMain.ToggleRgbBChange(Sender: TObject);
begin
  if ToggleRgbB.Checked then
  begin
    ActTurnRgbBlueOnExecute(Sender);
  end
  else
  begin
    ActTurnRgbBlueOffExecute(Sender);
  end;
end;

{
 RY LED
}
// RY RED
procedure TFormMain.ActTurnRyRedOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_ry_r]) = 0 then
  begin
    ImgRyRedOff.Visible := true;
    ImgRyRedOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnRyRedOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_ry_r]) = 0 then
  begin
    ImgRyRedOff.Visible := false;
    ImgRyRedOn.Visible := true;
  end;
end;

procedure TFormMain.ToggleRyRChange(Sender: TObject);
begin
  if ToggleRyR.Checked then
  begin
    ActTurnRyRedOnExecute(Sender);
  end
  else
  begin
    ActTurnRyRedOffExecute(Sender);
  end;
end;
// RY YELLOW
procedure TFormMain.ActTurnRyYellowOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_ry_y]) = 0 then
  begin
    ImgRyYellowOff.Visible := true;
    ImgRyYellowOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnRyYellowOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_ry_y]) = 0 then
  begin
    ImgRyYellowOff.Visible := false;
    ImgRyYellowOn.Visible := true;
  end;
end;

procedure TFormMain.ToggleRyYChange(Sender: TObject);
begin
  if ToggleRyY.Checked then
  begin
    ActTurnRyYellowOnExecute(Sender);
  end
  else
  begin
    ActTurnRyYellowOffExecute(Sender);
  end;
end;

{
	GY LED
}
// GY GREEN
procedure TFormMain.ActTurnGyGreenOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_gy_g]) = 0 then
  begin
    ImgGyGreenOff.Visible := true;
    ImgGyGreenOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnGyGreenOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_gy_g]) = 0 then
  begin
    ImgGyGreenOff.Visible := false;
    ImgGyGreenOn.Visible := true;
  end;
end;

procedure TFormMain.ToggleGyGChange(Sender: TObject);
begin
  if ToggleGyG.Checked then
  begin
    ActTurnGyGreenOnExecute(Sender);
  end
  else
  begin
    ActTurnGyGreenOffExecute(Sender);
  end;
end;
// GY YELLOW
procedure TFormMain.ActTurnGyYellowOffExecute(Sender: TObject);
begin
  if TurnLedOff(FGpioWirings[gc_gy_y]) = 0 then
  begin
    ImgGyYellowOff.Visible := true;
    ImgGyYellowOn.Visible := false;
  end;
end;

procedure TFormMain.ActTurnGyYellowOnExecute(Sender: TObject);
begin
  if TurnLedOn(FGpioWirings[gc_gy_y]) = 0 then
  begin
    ImgGyYellowOff.Visible := false;
    ImgGyYellowOn.Visible := true;
  end;
end;

procedure TFormMain.ToggleGyYChange(Sender: TObject);
begin
  if ToggleGyY.Checked then
  begin
    ActTurnGyYellowOnExecute(Sender);
  end
  else
  begin
    ActTurnGyYellowOffExecute(Sender);
  end;
end;
end.

