table 50000 "ODT LSD Format"
{
  DataPerCompany = false;
  DrillDownPageID = "ODT LSD Format List";
  LookupPageID = "ODT LSD Format List";

  fields
  {
    field(10;"Code";Code[20])
    {
      NotBlank = true;
    }
    field(20;Description;Text[100])
    {
    }
    field(30;Format;Text[100])
    {
      trigger OnValidate();
      begin
        if Format <> '' then for i:=1 to STRLEN(Format)do if not(COPYSTR(Format, i, 1)in['n', 'l', 'L', 't', '-', '/'])then ERROR(Text000);
      end;
    }
  }
  keys
  {
    key(Key1;"Code")
    {
    }
  }
  fieldgroups
  {
  }
  var i: Integer;
  Text000: Label 'Format must only contain valid characters as specified in the Legend.';
  Text001: Label 'LSD %1 does not meet the formatting parameters of UWI Format %2 (%3).';
  procedure ValidateFormat(UWIFormat: Code[20];
  var LSD: Code[50]);
  var UWIFormatRec: Record "ODT LSD Format";
  RaiseError: Boolean;
  begin
    if UWIFormat = '' then exit;
    with UWIFormatRec do begin
      GET(UWIFormat);
      if Format = '' then exit;
      TESTFIELD(Format);
      RaiseError:=false;
      for i:=1 to STRLEN(Format)do begin
        case COPYSTR(Format, i, 1)of '-', '/': if not(COPYSTR(LSD, i, 1)in['-', '/'])then LSD:=COPYSTR(LSD, 1, i - 1) + COPYSTR(Format, i, 1) + COPYSTR(LSD, i);
        'n': if not TestNumeric(COPYSTR(LSD, i, 1))then RaiseError:=true;
        'l': if not TestAlpha(COPYSTR(LSD, i, 1), 0)then RaiseError:=true;
        'L': if not TestAlpha(COPYSTR(LSD, i, 1), 1)then RaiseError:=true;
        't': if not(TestNumeric(COPYSTR(LSD, i, 1)) or TestAlpha(COPYSTR(LSD, i, 1), 2))then RaiseError:=true;
        else
          RaiseError:=true;
        end;
      end;
      if STRLEN(Format) <> STRLEN(LSD)then RaiseError:=true;
      if RaiseError then ERROR(STRSUBSTNO(Text001, LSD, Code, Format));
    end;
  end;
  procedure TestNumeric(Char: Text[1]): Boolean;
  begin
    if Char in['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']then exit(true);
    exit(false);
  end;
  procedure TestAlpha(Char: Text[1];
  CheckCase: Option Lower, Upper, Both): Boolean;
  begin
    case CheckCase of CheckCase::Lower: if Char in['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']then exit(true);
    CheckCase::Upper: if Char in['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']then exit(true);
    CheckCase::Both: if Char in['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', //? +
 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']then exit(true);
    end;
    exit(false);
  end;
}
