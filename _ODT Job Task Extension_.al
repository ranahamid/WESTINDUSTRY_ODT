pageextension 50002 "ODT Job Task Extension" extends "Job Task List"
{
    layout
    {
        addafter("Job Posting Group")
        {
            field("ODT Status"; "ODT Status")
            {
                ApplicationArea = Location;
                ToolTip = 'Specifies Status.';
            }
            field("ODT Closed"; "ODT Closed")
            {
                ApplicationArea = Location;
                ToolTip = 'Specifies Closed.';
            }
        }
        addafter("WIP-Total")
        {
            // control with underlying datasource
            field("Project Manager"; "Project Manager")
            {
                ApplicationArea = All;
                Caption = 'Project Manager';
            }
        }
    }
    actions
    {
    }
}
