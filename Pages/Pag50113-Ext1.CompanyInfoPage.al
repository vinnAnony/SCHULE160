pageextension 50113 CompanyInfoPage extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addafter(Picture)
        {
            field(DemoCompany; "Demo Company")
            {
                ApplicationArea = All;
                Editable = true;
                Visible = true;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}