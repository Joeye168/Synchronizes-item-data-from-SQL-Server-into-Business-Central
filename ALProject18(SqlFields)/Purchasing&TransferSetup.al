table 53210 "Item Purch Xfer Setup"
{
    DataClassification = ToBeClassified;
    fields
    {

        field(1; "Item No"; Code[20]) { TableRelation = Item."No."; }

        field(2; "XferUoM"; Code[10]) { TableRelation = "Unit of Measure".Code; }
        field(3; "XferUnits"; Decimal) { DecimalPlaces = 0 : 5; }

        field(4; "PurchUoM"; Code[10]) { TableRelation = "Unit of Measure".Code; }
        field(5; "PurchUnits"; Decimal) { DecimalPlaces = 0 : 5; }
        field(6; "PurchUoMPrice"; Decimal) { DecimalPlaces = 0 : 5; }
        field(7; "PurchUoMDisc%"; Decimal) { DecimalPlaces = 0 : 2; }

        field(8; "PurchUoM1"; Code[10]) { TableRelation = "Unit of Measure".Code; }
        field(9; "PurchUnits1"; Decimal) { DecimalPlaces = 0 : 5; }
        field(10; "Disc%1"; Decimal) { DecimalPlaces = 0 : 2; }

        field(11; "PurchUoM2"; Code[10]) { TableRelation = "Unit of Measure".Code; }
        field(12; "PurchUnits2"; Decimal) { DecimalPlaces = 0 : 5; }
        field(13; "Disc%2"; Decimal) { DecimalPlaces = 0 : 2; }
        field(14; "CurrencyCode"; Code[10]) { TableRelation = Currency.Code; }
    }

    keys
    {

        key(PK; "Item No") { Clustered = true; }
    }
}

page 53211 "Item Purch Xfer Setup ListPart"
{
    PageType = ListPart;
    SourceTable = "Item Purch Xfer Setup";
    Caption = 'Item Purchasing & Transfer Setup';
    DelayedInsert = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the item number this setup applies to.';
                }
                field("Xfer UoM"; Rec."XferUoM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer unit of measure for warehouse transfer.';
                }
                field("Xfer Units"; Rec."XferUnits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity per transfer UoM.';
                }

                field("Purch UoM"; Rec."PurchUoM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Default purchase unit of measure.';
                }
                field("Purch Units"; Rec."PurchUnits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity per purchase UoM.';
                }
                field("Purch UoM Price"; Rec."PurchUoMPrice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Price per purchase UoM.';
                }
                field("Purch UoM Disc%"; Rec."PurchUoMDisc%")
                {
                    ApplicationArea = All;
                    ToolTip = 'Discount percentage for purchase UoM.';
                }

                field("Purch UoM1"; Rec."PurchUoM1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Alternate purchase UoM level 1.';
                }
                field("Purch Units1"; Rec."PurchUnits1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity per UoM level 1.';
                }
                field("Disc%1"; Rec."Disc%1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Discount percentage for level 1 UoM.';
                }

                field("Purch UoM2"; Rec."PurchUoM2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Alternate purchase UoM level 2.';
                }
                field("Purch Units2"; Rec."PurchUnits2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity per UoM level 2.';
                }
                field("Disc%2"; Rec."Disc%2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Discount percentage for level 2 UoM.';
                }
                field("Currency Code"; Rec."CurrencyCode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Currency code for the purchase prices.';
                }
            }
        }
    }
}

pageextension 53212 ItemCardPurchXferPartExt extends "Item Card"
{
    layout
    {
        addafter(Replenishment)
        {
            group("🟩 Item Purch & Transfer Setup")
            {
                Caption = '🟩 Item Purch & Transfer Setup';
                part(ItemPurchXferPart; "Item Purch Xfer Setup ListPart")
                {
                    ApplicationArea = All;
                    SubPageLink = "Item No" = FIELD("No.");
                    UpdatePropagation = Both;  // 双向刷新

                }
            }
        }
    }
}




page 53210 "Item Purch Xfer Setup API"
{
    PageType = API;
    SourceTable = "Item Purch Xfer Setup";
    DelayedInsert = true;
    APIPublisher = 'joe';
    APIGroup = 'ItemFieldsFromSQL';
    APIVersion = 'v1.0';
    EntityName = 'itemPurchXferSetup';
    EntitySetName = 'itemPurchXferSetups';
    ODataKeyFields = "SystemId";



    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("ItemNo"; Rec."Item No") { ApplicationArea = All; }

                field("XferUoM"; Rec."XferUoM") { }
                field("XferUnits"; Rec."XferUnits") { }
                field("PurchUoM"; Rec."PurchUoM") { }
                field("PurchUnits"; Rec."PurchUnits") { }
                field("PurchUoMPrice"; Rec."PurchUoMPrice") { }
                field("PurchUoMDisc"; Rec."PurchUoMDisc%") { }
                field("PurchUoM1"; Rec."PurchUoM1") { }
                field("PurchUnits1"; Rec."PurchUnits1") { }
                field("Disc1"; Rec."Disc%1") { }
                field("PurchUoM2"; Rec."PurchUoM2") { }
                field("PurchUnits2"; Rec."PurchUnits2") { }
                field("Disc2"; Rec."Disc%2") { }
                field("CurrencyCode"; Rec."CurrencyCode") { }
            }
        }
    }
}

