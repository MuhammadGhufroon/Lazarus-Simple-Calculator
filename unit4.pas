unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TForm1 }
  TForm1 = class(TForm)
    Button0: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ButtonPlus: TButton;
    ButtonMultiplication: TButton;
    ButtonMinus: TButton;
    ButtonDivision: TButton;
    ButtonDot: TButton;
    ButtonEqual: TButton;
    Output: TEdit;
    ButtonDelete: TButton;
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonDotClick(Sender: TObject);
    procedure ButtonEqualClick(Sender: TObject);
    procedure ButtonNumberClick(Sender: TObject);
    procedure ButtonOperatorClick(Sender: TObject);
    procedure ButtonPlusClick(Sender: TObject);
    procedure ButtonMinusClick(Sender: TObject);
    procedure ButtonMultiplicationClick(Sender: TObject);
    procedure ButtonDivisionClick(Sender: TObject);
    procedure ButtonPercentageClick(Sender: TObject);
    procedure ProcessOperator(Op: Char);
  private
    Operand1, Operand2: Double;
    OperatorPressed: Boolean;
    CurrentOperator: Char;
    procedure ClearOperands;
    function CalculateResult: Double;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ClearOperands;
begin
  Operand1 := 0;
  Operand2 := 0;
  OperatorPressed := False;
end;

function TForm1.CalculateResult: Double;
begin
  case CurrentOperator of
    '+': Result := Operand1 + Operand2;
    '-': Result := Operand1 - Operand2;
    'x': Result := Operand1 * Operand2;
    '/':
      begin
        if Operand2 <> 0 then
          Result := Operand1 / Operand2
        else
        begin
          // Handle pembagian dengan nol
          ShowMessage('Error: Division by zero');
          Result := 0; // Mengembalikan hasil 0 jika terjadi pembagian dengan nol
        end;
      end;
  end;
end;

procedure TForm1.ProcessOperator(Op: Char);
begin
  if OperatorPressed then
    ButtonEqualClick(Self);

  OperatorPressed := True;
  CurrentOperator := Op;
  Operand1 := StrToFloat(Output.Text);
end;

procedure TForm1.ButtonNumberClick(Sender: TObject);
begin
  if OperatorPressed then
  begin
    Output.Text := '';
    OperatorPressed := False;
  end;
  Output.Text := Output.Text + (Sender as TButton).Caption;
end;

procedure TForm1.ButtonOperatorClick(Sender: TObject);
begin
  if not OperatorPressed then
  begin
    ProcessOperator((Sender as TButton).Caption[1]);
    OperatorPressed := True;
  end;
end;

procedure TForm1.ButtonDotClick(Sender: TObject);
begin
  if Pos('.', Output.Text) = 0 then
    Output.Text := Output.Text + '.';
end;

procedure TForm1.ButtonEqualClick(Sender: TObject);
begin
  if not OperatorPressed then
  begin
    Operand2 := StrToFloat(Output.Text);
    Output.Text := FloatToStr(CalculateResult);
    ClearOperands;
  end;
end;

procedure TForm1.ButtonDeleteClick(Sender: TObject);
begin
  Output.Text := '';
  ClearOperands;
end;

procedure TForm1.ButtonPlusClick(Sender: TObject);
begin
  if not OperatorPressed then
  begin
    ProcessOperator('+');
    OperatorPressed := True;
  end;
end;

procedure TForm1.ButtonMinusClick(Sender: TObject);
begin
  if not OperatorPressed then
  begin
    ProcessOperator('-');
    OperatorPressed := True;
  end;
end;

procedure TForm1.ButtonMultiplicationClick(Sender: TObject);
begin
  if not OperatorPressed then
  begin
    ProcessOperator('*');
    OperatorPressed := True;
  end;
end;

procedure TForm1.ButtonDivisionClick(Sender: TObject);
begin
  if not OperatorPressed then
  begin
    ProcessOperator('/');
    OperatorPressed := True;
  end;
end;

procedure TForm1.ButtonPercentageClick(Sender: TObject);
var
  PercentageValue: Double;
begin
  if not OperatorPressed then
  begin
    PercentageValue := StrToFloat(Output.Text) / 100;
    Output.Text := FloatToStr(PercentageValue);
    ClearOperands;
  end;
end;

end.

