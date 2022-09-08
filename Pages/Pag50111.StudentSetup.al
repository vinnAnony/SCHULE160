page 50111 "Student Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Setup";
    Editable = true;

    layout
    {
        area(Content)
        {

            field("Primary Key"; "Primary Key")
            {
                ApplicationArea = All;
            }
            field("No. Series"; "No. Series")
            {
                ApplicationArea = All;
            }
            field("Min. Age"; "Min. Age")
            {
                ApplicationArea = All;
            }
            field("Max. Age"; "Max. Age")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}