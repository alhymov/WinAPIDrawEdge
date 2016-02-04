object Form10: TForm10
  Left = 0
  Top = 0
  Caption = 'Form10'
  ClientHeight = 449
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 228
    Top = 0
    Width = 51
    Height = 449
    Align = alClient
    OnPaint = PaintBox1Paint
    ExplicitLeft = 272
    ExplicitTop = 248
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 222
    Height = 443
    Align = alLeft
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = -2
    object laRect: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 363
      Width = 214
      Height = 13
      Align = alTop
      Caption = 'laRect'
      ExplicitTop = 375
      ExplicitWidth = 30
    end
    object rgEdge: TRadioGroup
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 214
      Height = 93
      Align = alTop
      Caption = 'Edge'
      ItemIndex = 0
      Items.Strings = (
        'EDGE_BUMP'
        'EDGE_ETCHED'
        'EDGE_RAISED'
        'EDGE_SUNKEN')
      TabOrder = 0
      OnClick = rgEdgeClick
    end
    object clFlags: TCheckListBox
      AlignWithMargins = True
      Left = 4
      Top = 103
      Width = 214
      Height = 254
      Align = alTop
      ItemHeight = 13
      Items.Strings = (
        'BF_ADJUST'
        'BF_BOTTOM'
        'BF_BOTTOMLEFT'
        'BF_BOTTOMRIGHT'
        'BF_DIAGONAL'
        'BF_DIAGONAL_ENDBOTTOMLEFT'
        'BF_DIAGONAL_ENDBOTTOMRIGHT'
        'BF_DIAGONAL_ENDTOPLEFT'
        'BF_DIAGONAL_ENDTOPRIGHT'
        'BF_FLAT'
        'BF_LEFT'
        'BF_MIDDLE'
        'BF_MONO'
        'BF_RECT'
        'BF_RIGHT'
        'BF_SOFT'
        'BF_TOP'
        'BF_TOPLEFT'
        'BF_TOPRIGHT')
      TabOrder = 1
      OnClick = rgEdgeClick
      ExplicitTop = 115
    end
    object tbMargins: TTrackBar
      AlignWithMargins = True
      Left = 4
      Top = 382
      Width = 214
      Height = 31
      Align = alTop
      Ctl3D = True
      Max = 100
      ParentCtl3D = False
      PageSize = 25
      Frequency = 10
      TabOrder = 2
      OnChange = rgEdgeClick
      ExplicitTop = 394
    end
    object chMarkers: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 419
      Width = 214
      Height = 17
      Align = alTop
      Caption = 'Markers'
      TabOrder = 3
      OnClick = rgEdgeClick
      ExplicitLeft = 64
      ExplicitTop = 464
      ExplicitWidth = 97
    end
  end
end
