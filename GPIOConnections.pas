unit GPIOConnections;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, Main;

type

  { TFormGpioConnections }

  TFormGpioConnections = class(TForm)
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    cbGpio10: TComboBox;
    cbGpio11: TComboBox;
    cbGpio12: TComboBox;
    cbGpio13: TComboBox;
    cbGpio14: TComboBox;
    cbGpio15: TComboBox;
    cbGpio16: TComboBox;
    cbGpio17: TComboBox;
    cbGpio18: TComboBox;
    cbGpio19: TComboBox;
    cbGpio2: TComboBox;
    cbGpio20: TComboBox;
    cbGpio21: TComboBox;
    cbGpio22: TComboBox;
    cbGpio23: TComboBox;
    cbGpio24: TComboBox;
    cbGpio25: TComboBox;
    cbGpio26: TComboBox;
    cbGpio27: TComboBox;
    cbGpio3: TComboBox;
    cbGpio4: TComboBox;
    cbGpio5: TComboBox;
    cbGpio6: TComboBox;
    cbGpio7: TComboBox;
    cbGpio8: TComboBox;
    cbGpio9: TComboBox;
    GroupBox1: TGroupBox;
    ImgPin_1: TImage;
    ImgPin_10: TImage;
    ImgPin_11: TImage;
    ImgPin_12: TImage;
    ImgPin_13: TImage;
    ImgPin_14: TImage;
    ImgPin_15: TImage;
    ImgPin_16: TImage;
    ImgPin_17: TImage;
    ImgPin_18: TImage;
    ImgPin_19: TImage;
    ImgPin_2: TImage;
    ImgPin_20: TImage;
    ImgPin_21: TImage;
    ImgPin_22: TImage;
    ImgPin_23: TImage;
    ImgPin_24: TImage;
    ImgPin_25: TImage;
    ImgPin_26: TImage;
    ImgPin_27: TImage;
    ImgPin_28: TImage;
    ImgPin_29: TImage;
    ImgPin_3: TImage;
    ImgPin_30: TImage;
    ImgPin_31: TImage;
    ImgPin_32: TImage;
    ImgPin_33: TImage;
    ImgPin_34: TImage;
    ImgPin_35: TImage;
    ImgPin_36: TImage;
    ImgPin_37: TImage;
    ImgPin_38: TImage;
    ImgPin_39: TImage;
    ImgPin_4: TImage;
    ImgPin_40: TImage;
    ImgPin_41: TImage;
    ImgPin_42: TImage;
    ImgPin_43: TImage;
    ImgPin_5: TImage;
    ImgPin_6: TImage;
    ImgPin_7: TImage;
    ImgPin_8: TImage;
    ImgPin_9: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure CheckAssignedConnection(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    FGpioControls: TGpioControls;
    procedure SetGpioControls(GpioControls: TGpioControls);
    function GetGpioWirings: TGpioWirings;
  public
    { public declarations }
    property GpioControls: TGpioControls read FGpioControls write SetGpioControls;
    property GpioWirings: TGpioWirings read GetGpioWirings;
  end;

var
  FormGpioConnections: TFormGpioConnections;

implementation
uses LCLType;

{$R *.lfm}
{
 checks all combos to avoid same GPIO assigned to different controls
}
procedure TFormGpioConnections.CheckAssignedConnection(Sender: TObject);
var
  i: integer;
  can_assign: boolean;
  msgtext: string;
  msgcaption: string;
  answer: integer;
begin
  // only assignet to comboboxes
  can_assign := true;
  if Sender is TComboBox then
  begin
    // ItemIndex = 0 means no control assigned
	  if TComboBox(Sender).ItemIndex > 0 then
    begin
      with FormGpioConnections do
      begin
		    for i := 0 to ControlCount -1 do
        begin
			    if Controls[i] is TComboBox then
          begin
            if Controls[i] <> Sender then
            begin
              if TComboBox(Controls[i]).ItemIndex = TComboBox(Sender).ItemIndex then
              begin
								msgtext := Format(
                							'Wiring connection for %s already assigned to GPIO %d.'+#13+
                							'Override connection for GPIO %d ?',
                							[TComboBox(Sender).Items[TComboBox(Sender).ItemIndex],
                             	 Controls[i].Tag,
                               Controls[i].Tag ]);
                msgcaption := 'Wiring conflict';
                can_assign := false;
								answer := MessageDlg(msgcaption,msgtext, mtConfirmation,[mbYes,mbNo],0);
                if answer = IDYES then
                begin
						      TComboBox(Controls[i]).ItemIndex := 0;
                end
                else
                begin
                  TComboBox(Sender).ItemIndex := 0;
                end;
                break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{
	populate Wiring comboboxes with list of main's unit defined connections
}
procedure TFormGpioConnections.FormCreate(Sender: TObject);
var
  i: integer;
  gc: TGpioControl;
begin
	 with FormGpioConnections do
   begin
     for i := 0 to ControlCount -1 do
     begin
				if Controls[i] is TComboBox then
        begin
          TComboBox(Controls[i]).Items.Clear;
          for gc := Low(TGpioControl) to High(TGpioControl) do
          begin
						TComboBox(Controls[i]).Items.Add(GPIOWiringsDesc[gc]);
          end;
        end;
     end;
   end;
end;

{
	Update comboboxes' ItemIndex upon values from passed GpioControls
  uses control's TAG value, which must be set to corresponding GPIO port
  number for each combobox.
}
procedure TFormGpioConnections.SetGpioControls(GpioControls: TGpioControls);
var
  i: integer;
begin
  FGpioControls := GpioControls;
  with FormGpioConnections do
  begin
    for i := 0 to ControlCount -1 do
    begin
 			if Controls[i] is TComboBox then
       begin
         TComboBox(Controls[i]).ItemIndex := ord(FGpioControls[Controls[i].Tag]);
       end;
    end;
  end;
end;
{
	Update FGpioWinrings to reflect current Wiring connections

  TGpioWirings = array[TGpioControl] of longint;

}
function TFormGpioConnections.GetGpioWirings: TGpioWirings;
var
  gc :TGpioControl;
  gw :TGpioWirings;
  i: integer;
begin
  for gc := Low(TGpioControl) to High(TGpioControl) do
  begin
    gw[gc] := 0;
  end;
  with FormGpioConnections do
  begin
    for i := 0 to ControlCount -1 do
    begin
 			if Controls[i] is TComboBox then
       begin
         if TComboBox(Controls[i]).ItemIndex <> 0 then
         begin
         	 gw[TGpioControl(TComboBox(Controls[i]).ItemIndex)] := Controls[i].Tag;
         end;
       end;
    end;
  end;
  GetGpioWirings := gw;
end;

end.

