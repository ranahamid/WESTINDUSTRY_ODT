page 50010 "ODT LSD Directions Text"
{
  // version NB03.75,NB03.83
  // NB03.83 2018-06-21 ODTAB
  Caption = 'LSD Directions';
  LinksAllowed = false;
  ShowFilter = false;

  layout
  {
    area(content)
    {
      // Caption = 'Direction';
      field(txt;txt)
      {
        ApplicationArea = All;
        Caption = 'Direction';
        MultiLine = true;
        ShowCaption = false;

        trigger OnValidate();
        begin
          case Type of Type::"LSD Directions": LSDDir.SetDirection(txt);
          //   Type::"Dispatch Directions":
          //     DispatchHeader.SetDirection(txt);
          //   Type::"Job Details":
          //     DispatchHeader.SetJobDetails(txt);
          end;
        end;
      }
    }
  }
  actions
  {
  }
  trigger OnOpenPage();
  begin
    case Type of Type::"LSD Directions": begin
      CurrPage.CAPTION('LSD Directions');
      txt:=LSDDir.GetDirection;
    end;
    Type::"Dispatch Directions": begin
      CurrPage.CAPTION('Dispatch Directions');
    //   txt := DispatchHeader.GetDirection;
    end;
    Type::"Job Details": begin
      CurrPage.CAPTION('Job Details');
    //   txt := DispatchHeader.GetJobDetails();
    end;
    end;
  end;
  var txt: Text;
  LSDDir: Record "ODT LSD Directions";
  // DispatchHeader : Record Table50300;
  Type: Option "LSD Directions", "Dispatch Directions", "Job Details";
  procedure GetLSDDirections(TableType: Option "LSD Directions", "Dispatch Directions", "Job Details";
  Key1: Code[20];
  Key2: Code[50];
  Key3: Code[20]);
  begin
    Type:=TableType;
    case Type of Type::"LSD Directions": LSDDir.GET(Key1, Key2, Key3);
    //   Type::"Dispatch Directions":
    //     DispatchHeader.GET(Key1);
    //   Type::"Job Details":
    //     DispatchHeader.GET(Key1);
    end;
  end;
}
