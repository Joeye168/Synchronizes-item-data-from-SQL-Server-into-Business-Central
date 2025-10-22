page 50110 "Item Unit of Measure API"
{
    PageType = API;
    SourceTable = "Item Unit of Measure";
    DelayedInsert = true; // ✅ 必须加
    APIPublisher = 'joe';
    APIGroup = 'ItemFieldsFromSQL';
    APIVersion = 'v1.0';
    EntityName = 'itemUnitOfMeasure';
    EntitySetName = 'itemUnitsOfMeasure';

    ODataKeyFields = "SystemId";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'System ID';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ItemNo"; Rec."Item No.") { }
                field("Code"; Rec.Code) { }
                field("QtyPerUnitofMeasure"; Rec."Qty. per Unit of Measure") { }
                field(Height; rec.Height) { }
                field(Width; rec.Width) { }
                field(Length; rec.Length) { }
                field(Cubage; Rec.Cubage) { }
                field(Weight; Rec.Weight) { }
            }
        }
    }
}
