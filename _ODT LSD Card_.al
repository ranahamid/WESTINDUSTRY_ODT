page 50006 "ODT LSD Card"
{
  Caption = 'LSD Card';
  PageType = Card;
  SourceTable = "ODT LSD";
  UsageCategory = Tasks;
  ApplicationArea = All;
  AdditionalSearchTerms = 'field ticket';

  layout
  {
    area(content)
    {
      group(General)
      {
        field("LSD Format Code";"LSD Format Code")
        {
          ApplicationArea = All;
        }
        field("LSD Code";"LSD Code")
        {
          ApplicationArea = All;
        }
        field("Surface LSD Format";"Surface LSD Format")
        {
          Visible = false;
          ApplicationArea = All;
        }
        field("Surface LSD";"Surface LSD")
        {
          Visible = CheckType;
          ApplicationArea = All;

          trigger OnValidate();
          begin
            CurrPage.UPDATE;
          end;
        }
        field("No. of Downhole LSD";"No. of Downhole LSD")
        {
          DrillDown = true;
          DrillDownPageID = "ODT LSD List";
          Visible = ShowDownholeCount;
          ApplicationArea = All;
        }
      // field("Bottom Hole"; "Bottom Hole")
      // {
      //     Caption = 'Bottom Hole';
      //     ApplicationArea = All;
      // }
      // field(Start; Start)
      // {
      //     Caption = 'Start';
      //     ApplicationArea = All;
      // }
      // field(Path; Path)
      // {
      //     Caption = 'Path';
      //     ApplicationArea = All;
      // }
      // field("ODT End"; "ODT End")
      // {
      //     Caption = 'End';
      //     ApplicationArea = All;
      // }
      }
      part(LSDDirectionsSubform;50015)
      {
        Caption = 'LSD Directions Subform';
        SubPageLink = "LSD Format"=FIELD("Surface LSD Format"), "LSD"=FIELD("Surface LSD");
        ApplicationArea = All;
      }
    }
  }
  actions
  {
    area(creation)
    {
      action(PrintLSD)
      {
        Image = Print;
        Promoted = true;
        PromotedCategory = "Report";
        PromotedIsBig = true;
        ApplicationArea = All;

        trigger OnAction();
        var // LSDReport : Report Report50017;
        // LSDDirections : Record Table50311;
        // RecRef : RecordRef;
        // LSDDirect : Record Table50311;
        begin
        //<NB03.83>+
        // CurrPage.LSDDirectionsSubform.PAGE.GetRec(LSDDirections);
        // //LSDReport.RUNMODAL;
        // LSDDirect.SETRANGE("LSD Format",LSDDirections."LSD Format");
        // LSDDirect.SETRANGE(LSD,LSDDirections.LSD);
        // //LSDDirect.SETRANGE(ID,LSDDirections.ID);
        // LSDDirect.SETRANGE("Default Directions",true);
        // //REPORT
        // REPORT.RUNMODAL(REPORT::Report50017,true,false,LSDDirect);
        // //</NB03.83>+
        end;
      }
    }
    area(navigation)
    {
      action(DownholeLSD)
      {
        Caption = 'Downhole LSD';
        Image = MapDimensions;
        Promoted = true;
        PromotedCategory = Process;
        PromotedIsBig = true;
        RunPageMode = Create;
        Visible = ShowDownholeCount;
        ApplicationArea = All;

        trigger OnAction();
        var DownholeLSD: Record "ODT LSD";
        DownholeLSDPage: Page "ODT Downhole LSD";
        begin
          //COMMIT;
          DownholeLSD.RESET;
          DownholeLSD.SETRANGE(Type, Type::Downhole);
          DownholeLSD.SETRANGE("Surface LSD Format", "LSD Format Code");
          DownholeLSD.SETRANGE("Surface LSD", "LSD Code");
          DownholeLSDPage.SETTABLEVIEW(DownholeLSD);
          DownholeLSDPage.EDITABLE(true);
          DownholeLSDPage.ReceiveLSDInfo("LSD Format Code", "LSD Code");
          DownholeLSDPage.RUNMODAL;
        //<SE17.02 2018-05-31 end insert>
        end;
      }
    }
  }
  trigger OnAfterGetRecord();
  begin
    if Type = Type::Downhole then begin
      CheckType:=true;
      ShowDownholeCount:=false;
    end;
  end;
  trigger OnOpenPage();
  begin
    CheckType:=false;
    ShowDownholeCount:=true;
    if Type = Type::Downhole then begin
      CheckType:=true;
      ShowDownholeCount:=false;
    end;
  end;
  trigger OnQueryClosePage(CloseAction: Action): Boolean;
  begin
    //<NB03.87>
    if(Type = Type::Downhole) and ("LSD Code" <> '') and ("LSD Format Code" <> '')then TESTFIELD("Surface LSD");
  //</NB03.87>
  end;
  var CheckType: Boolean;
  ShowDownholeCount: Boolean;
}
