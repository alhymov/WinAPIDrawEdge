unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  Vcl.ComCtrls;

type
  TForm10 = class(TForm)
    Panel1: TPanel;
    rgEdge: TRadioGroup;
    clFlags: TCheckListBox;
    laRect: TLabel;
    tbMargins: TTrackBar;
    PaintBox1: TPaintBox;
    chMarkers: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure rgEdgeClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
  private
    { Private declarations }
    procedure Draw;
    function EdgeGet: Cardinal;
    function FlagsGet: Cardinal;
    procedure StateFlagsSet( const AValue: Cardinal );
    function StateFlagsGet: Cardinal;
    procedure StateSave;
    procedure StateRestore;
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

uses
  System.IniFiles;

procedure TForm10.Draw;
var
  qrc: TRect;
  Margin: Integer;
  LCanvas: TCanvas;
  //
  procedure Mark( X, Y: Integer );
  const
    LSize = 3;
  var
    R: TRect;
  begin
    R.Create( X-LSize, Y-LSize, X+LSize, Y+LSize );
    LCanvas.Brush.Color := clAqua;
    LCanvas.FillRect( R );
  end;
  //
begin
  Margin := tbMargins.Position;

  with PaintBox1 do begin
    LCanvas := Canvas;
    qrc.Create( 0, 0, Width, Height );
  end;

  LCanvas.FillRect( qrc );  //Clear

  qrc.Inflate( -Margin, -Margin, -Margin, -Margin  );
  if chMarkers.Checked then begin
    Mark( qrc.Left, qrc.Top );
    Mark( qrc.Left, qrc.Bottom );
    Mark( qrc.Right, qrc.Top );
    Mark( qrc.Right, qrc.Bottom );
  end;
  DrawEdge( LCanvas.Handle, qrc, EdgeGet, FlagsGet );

  laRect.Caption := Format( '%d, %d, %d, %d', [ qrc.Left, qrc.Top, qrc.Right, qrc.Bottom ] );
end;

procedure TForm10.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize := ( NewWidth > 499 ) and ( NewHeight > 499 );
end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  StateRestore;
end;

procedure TForm10.FormDestroy(Sender: TObject);
begin
  StateSave;
end;

function TForm10.EdgeGet: Cardinal;
const
  EDGE: array [ 0..3 ] of Cardinal = (
    EDGE_BUMP,
    EDGE_ETCHED,
    EDGE_RAISED,
    EDGE_SUNKEN);
begin
  Result := EDGE[ rgEdge.ItemIndex ];
end;

{$Region 'FLAGS'}
function TForm10.FlagsGet: Cardinal;
const
  BF: Array [ 0..18 ] of Cardinal = (
    BF_ADJUST,
    BF_BOTTOM,
    BF_BOTTOMLEFT,
    BF_BOTTOMRIGHT,
    BF_DIAGONAL,
    BF_DIAGONAL_ENDBOTTOMLEFT,
    BF_DIAGONAL_ENDBOTTOMRIGHT,
    BF_DIAGONAL_ENDTOPLEFT,
    BF_DIAGONAL_ENDTOPRIGHT,
    BF_FLAT,
    BF_LEFT,
    BF_MIDDLE,
    BF_MONO,
    BF_RECT,
    BF_RIGHT,
    BF_SOFT,
    BF_TOP,
    BF_TOPLEFT,
    BF_TOPRIGHT);
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to clFlags.Count-1 do
  if clFlags.Checked[ I ] then
    Result := Result or BF[ I ];
end;

function TForm10.StateFlagsGet: Cardinal;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to clFlags.Count-1 do
  if clFlags.Checked[ I ] then
    Result := Result or ( 1 shl I );
end;

procedure TForm10.StateFlagsSet(const AValue: Cardinal);
var
  I: Integer;
begin
  for I := 0 to clFlags.Count-1 do
    clFlags.Checked[ I ] := ( AValue and ( 1 shl I ) ) > 0;
end;
{$endregion 'FLAGS'}

procedure TForm10.PaintBox1Paint(Sender: TObject);
begin
  Draw;
end;

procedure TForm10.rgEdgeClick(Sender: TObject);
begin
  PaintBox1.Invalidate;
end;

const
  sSection = 'State';
  //ini values
  // Form
  ivState = 'State';
  ivTop = 'Top';
  ivLeft = 'Left';
  ivWidth = 'Width';
  ivHeight = 'Height';
  //Controls
  ivEdge = 'EDGE';
  ivBF = 'BF';
  ivMargins = 'Margins';
  ivMarkers = 'Markers';



procedure TForm10.StateSave;
var
  LWindowPlacement: TWindowPlacement;
begin
  with TIniFile.Create( ChangeFileExt( ParamStr( 0 ), '.ini' ) ) do
  try
    WriteInteger( sSection, ivState, Ord( WindowState ) );
    LWindowPlacement.length := SizeOf( LWindowPlacement );
    GetWindowPlacement( Handle, @LWindowPlacement );
    with LWindowPlacement.rcNormalPosition do begin
      WriteInteger( sSection, ivLeft, left );
      WriteInteger( sSection, ivTop, top );
      WriteInteger( sSection, ivWidth, right - left );
      WriteInteger( sSection, ivHeight, bottom - top );
    end;
    WriteInteger( sSection, ivEDGE, rgEdge.ItemIndex );
    WriteInteger( sSection, ivBF, StateFlagsGet );
    WriteInteger( sSection, ivMargins, tbMargins.Position );
    WriteInteger( sSection, ivMarkers, Byte( chMarkers.Checked ) );
  finally Free;
  end;
end;

procedure TForm10.StateRestore;
begin
  with TIniFile.Create( ChangeFileExt( ParamStr( 0 ), '.ini' ) ) do
  try
    Position := poDesigned;
    SetBounds(
      ReadInteger( sSection, ivLeft, Left ),
      ReadInteger( sSection, ivTop, Top ),
      ReadInteger( sSection, ivWidth, Width ),
      ReadInteger( sSection, ivHeight, Height )
    );
    WindowState := TWindowState(ReadInteger(sSection, ivState, Ord(wsNormal)));

    rgEdge.ItemIndex := ReadInteger( sSection, ivEDGE, rgEdge.ItemIndex );
    StateFlagsSet( ReadInteger( sSection, ivBF, StateFlagsGet ) );
    tbMargins.Position := ReadInteger( sSection, ivMargins, tbMargins.Position );
    chMarkers.Checked := ReadInteger( sSection, ivMarkers, Byte( chMarkers.Checked ) ) <> 0;

  finally Free;
  end;
end;



end.
