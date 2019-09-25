page 50008 "ODT LSD Directions"
{
  // version NB03.75,NB03.87
  // NB03.87 2018-07-24 ODTTG Adding sorting key
  PageType = List;
  RefreshOnActivate = true;
  SourceTable = "ODT LSD Directions";
  SourceTableView = SORTING("LSD Format", LSD, "Create Datetime");

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        field(ID;ID)
        {
          ApplicationArea = All;
          Editable = false;
        }
        field("Directions Old";"Directions Old")
        {
          ApplicationArea = All;
          ShowMandatory = true;

          trigger OnAssistEdit();
          begin
            CurrPage.UPDATE(false);
          //LSDDirectionText.GetLSDDirections("LSD Format",LSD,ID);       //<NB03.83/>
          //LSDDirectionText.RUN;                                         //<NB03.83/>
          end;
        }
        field("Default Directions";"Default Directions")
        {
          ApplicationArea = All;
        }
        field(HasMap;HasMap)
        {
          ApplicationArea = All;
          Caption = 'Map';
          Editable = false;

          trigger OnDrillDown();
          begin
            LSDDirection.RESET;
            LSDDirection.SETRANGE("LSD Format", "LSD Format");
            LSDDirections.SETRANGE(LSD, LSD);
            LSDDirections.SETRANGE(ID, ID);
            if LSDDirections.FINDFIRST then PAGE.RUN(50315, LSDDirection);
          end;
        }
        field("Customer No.";"Customer No.")
        {
          ApplicationArea = All;
        }
        field("Customer Name";"Customer Name")
        {
          ApplicationArea = All;
        }
        field(Active;Active)
        {
          ApplicationArea = All;
        }
      }
    }
  }
  actions
  {
    area(processing)
    {
      action(Map)
      {
        ApplicationArea = All;
        Image = Map;

        trigger OnAction();
        begin
          LSDDirection.SETRANGE("LSD Format", "LSD Format");
          LSDDirection.SETRANGE(LSD, LSD);
          LSDDirection.SETRANGE(ID, ID);
          LSDMap.SETTABLEVIEW(LSDDirection);
          LSDMap.EDITABLE:=true;
          LSDMap.RUN;
        end;
      }
    }
  }
  trigger OnAfterGetRecord();
  begin
    HasMap:=false;
    if LSDDirection.GET("LSD Format", LSD, ID)then if LSDDirection.Map.HASVALUE then HasMap:=true
      else
        HasMap:=false;
  end;
  trigger OnInit();
  begin
    HasMap:=false;
  end;
  var Desc3Txt: Text;
  InStr: InStream;
  OutStr: OutStream;
  LSDDirectionText: Page "ODT LSD Directions Text";
  MapPage: Page "ODT FT Map";
  LSDDirection: Record "ODT LSD Directions";
  HasMap: Boolean;
  LSDMap: Page "ODT LSD Map";
  LSDDirections: Record "ODT LSD Directions";
  IDRename: Integer;
}
