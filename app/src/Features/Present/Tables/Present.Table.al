table 50100 "Present"
{
    LookupPageId = Presents;
    DrillDownPageId = Presents;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}