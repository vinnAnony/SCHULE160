page 50115 "Schule Role Center"
{
    PageType = RoleCenter;
    Caption = 'Schule';

    layout
    {
        area(RoleCenter)
        {
            // part(Headline; "Headline RC Schule")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // part(Activities; "Schule Activities")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Student Application")
            {
                RunPageMode = Create;
                Caption = 'Student Application';
                ToolTip = 'Create a new student application.';
                Image = New;
                RunObject = page Student;
                ApplicationArea = Basic, Suite;
            }
        }
        area(Processing)
        {
            group(Listing)
            {
                // action("AppNameMasterData")
                // {
                //     RunPageMode = Create;
                //     Caption = 'AppNameMasterData';
                //     ToolTip = 'Register new AppNameMasterData';
                //     RunObject = page "AppNameMasterData Card";
                //     Image = DataEntry;
                //     ApplicationArea = Basic, Suite;
                // }
            }
            group("Approvals")
            {
                // action("AppNameSomeProcess")
                // {
                //     Caption = 'AppNameSomeProcess';
                //     ToolTip = 'AppNameSomeProcess description';
                //     Image = Process;
                //     RunObject = Codeunit "AppNameSomeProcess";
                //     ApplicationArea = Basic, Suite;
                // }
            }
            group("Schule Reports")
            {
                // action("Pending Student Application Approvals")
                // {
                //     Caption = 'Pending Student Application Approvals';
                //     ToolTip = 'Report for all pending student approvals';
                //     Image = Report;
                //     RunObject = report "AppNameSomeReport";
                //     ApplicationArea = Basic, Suite;
                // }
            }
        }
        area(Reporting)
        {
            // action("Approved Students")
            // {
            //     Caption = 'Approved Students';
            //     ToolTip = 'Approved Students description';
            //     Image = Report;
            //     RunObject = report "Approved Students";
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     PromotedIsBig = true;
            //     ApplicationArea = Basic, Suite;
            // }

        }
        area(Embedding)
        {
            action("Student List")
            {
                RunObject = page "Student List";
                ApplicationArea = Basic, Suite;
            }

        }
        area(Sections)
        {
            group(Setup)
            {
                Caption = 'Setup';
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Setup;

                action("Student Setup")
                {
                    ToolTip = 'Set up Min. Age, Max. Age and No. Series for Student Application.';
                    RunObject = Page "Student Setup";
                    ApplicationArea = Basic, Suite;

                }
                action("Service Connections")
                {
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    RunObject = Page "Service Connections";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

}