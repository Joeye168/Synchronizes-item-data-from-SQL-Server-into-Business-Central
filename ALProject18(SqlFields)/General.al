// ===============================================
//  TABLEEXTENSION: ItemGeneralExt
// ===============================================
tableextension 53100 ItemGeneralExt extends Item
{
    fields
    {
        // 🔵 描述与派生
        field(53190; "Desc Length"; Integer)
        {
            Caption = 'Desc Length';
            DataClassification = ToBeClassified;
        }
        field(53191; "First 30 chars."; Text[30])
        {
            Caption = 'First 30 chars.';
            DataClassification = ToBeClassified;
        }
        field(53192; "Next 10 chars."; Text[10])
        {
            Caption = 'Next 10 chars.';
            DataClassification = ToBeClassified;
        }

        // 🟢 标识 & 编码
        field(53193; "UPC1"; Code[30])
        {
            Caption = 'UPC';
            DataClassification = ToBeClassified;
        }
        field(53194; "CAT"; Code[20])
        {
            Caption = 'CAT';
            DataClassification = ToBeClassified;
        }
        field(53195; "SUB CAT"; Code[20])
        {
            Caption = 'SUB CAT';
            DataClassification = ToBeClassified;
        }
        field(53196; "UNIQUE ID"; Code[50])
        {
            Caption = 'Unique ID';
            DataClassification = ToBeClassified;
        }
        field(53197; "SIZE CODE"; Code[20])
        {
            Caption = 'Size Code';
            DataClassification = ToBeClassified;
        }

        // 🟣 生命周期 & 状态
        field(53198; "DATE ADDED"; Date)
        {
            Caption = 'Date Added';
            DataClassification = ToBeClassified;
        }
        field(53199; "Item Status"; Option)
        {
            Caption = 'Item Status';
            OptionMembers = Active,Inactive,Blocked;
            DataClassification = ToBeClassified;
        }
        field(53200; "Store Order Block"; Option)
        {
            Caption = 'Store Order Block';
            OptionMembers = " ",Y,N;
            DataClassification = ToBeClassified;
        }

        // 🟡 销售/业务标识
        field(53201; "Sell Fractions"; Option)
        {
            Caption = 'Sell Fractions';
            OptionMembers = " ",Y,N;
            DataClassification = ToBeClassified;
        }
        field(53202; "Add to US (4444)"; Option)
        {
            Caption = 'Add to US (4444)';
            OptionMembers = " ",Y,N;
            DataClassification = ToBeClassified;
        }
        field(53203; "Add to PetSave"; Option)
        {
            Caption = 'Add to PetSave';
            OptionMembers = " ",Y,N;
            DataClassification = ToBeClassified;
        }
        field(53204; "NEW Item sheet required"; Option)
        {
            Caption = 'NEW Item sheet required';
            OptionMembers = " ",Y,N;
            DataClassification = ToBeClassified;
        }
        field(53205; "ASWO#"; Text[40])
        {
            Caption = 'ASWO#';
            DataClassification = ToBeClassified;
        }
        field(53206; "in 998 Y/N"; Option)
        {
            Caption = 'in 998 Y/N';
            OptionMembers = " ",Y,N;
            DataClassification = ToBeClassified;
        }
        field(53207; "WebItem?"; Option)
        {
            Caption = 'WebItem?';
            OptionMembers = " ",Y,N;
            DataClassification = ToBeClassified;
        }
        field(53208; "FDA Item?"; Option)
        {
            Caption = 'FDA Item?';
            OptionMembers = "Y","N"," ";
            DataClassification = ToBeClassified;
        }

        // 🟠 新增字段
        field(53003; "Commission%"; Decimal)
        {
            Caption = 'Commission%';
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;
        }
        field(53209; "CommissionAmt"; Decimal)
        {
            Caption = 'Commission Amount';
            DataClassification = ToBeClassified;
        }
        field(53210; "Import FrtAmt"; Decimal)
        {
            Caption = 'Import Freight Amount';
            DataClassification = ToBeClassified;
        }
        field(53211; "DEPT"; Code[20])
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
        }
        field(53212; "SUBDEPT"; Code[20])
        {
            Caption = 'Sub Department';
            DataClassification = ToBeClassified;
        }
        field(53213; "Color Code"; Code[20])
        {
            Caption = 'Color Code';
            DataClassification = ToBeClassified;
        }
        field(53214; "Mfg Code for Country of Origin"; Code[20])
        {
            Caption = 'Mfg Code for Country of Origin';
            DataClassification = ToBeClassified;
        }
        field(53516; "Product ID"; Code[20])
        {
            Caption = 'Product ID';
            DataClassification = ToBeClassified;
        }


    }
}






// ===============================================
//  PAGEEXTENSION: ItemCardGeneralExt
// ===============================================
pageextension 53100 ItemCardGeneralExt extends "Item Card"
{
    layout
    {
        addlast(Item)
        {

            // 🔵 描述与派生
            group("🔵 Description & Derived")
            {
                Caption = '🔵 Description & Derived';

                field("Desc Length"; Rec."Desc Length") { ApplicationArea = All; }
                field("First 30 chars."; Rec."First 30 chars.") { ApplicationArea = All; }
                field("Next 10 chars."; Rec."Next 10 chars.") { ApplicationArea = All; }
            }

            // 🟢 标识 & 编码
            group("🟢 Identifiers & Codes")
            {
                Caption = '🟢 Identifiers & Codes';
                field("Product ID"; Rec."Product ID") { ApplicationArea = All; }
                field("UPC"; Rec."UPC1") { ApplicationArea = All; }
                field("ASWO#"; Rec."ASWO#") { ApplicationArea = All; }
                field("CAT"; Rec."CAT") { ApplicationArea = All; }
                field("SUB CAT"; Rec."SUB CAT") { ApplicationArea = All; }
                field("UNIQUE ID"; Rec."UNIQUE ID") { ApplicationArea = All; }
                field("SIZE CODE"; Rec."SIZE CODE") { ApplicationArea = All; }
                field("Color Code"; Rec."Color Code") { ApplicationArea = All; }
                field("Mfg Code for Country of Origin"; Rec."Mfg Code for Country of Origin") { ApplicationArea = All; }
            }

            // 🟣 生命周期 & 状态
            group("🟣 Lifecycle & Status")
            {
                Caption = '🟣 Lifecycle & Status';
                field("DATE ADDED"; Rec."DATE ADDED") { ApplicationArea = All; }
                field("Item Status"; Rec."Item Status") { ApplicationArea = All; }
                field("Store Order Block"; Rec."Store Order Block") { ApplicationArea = All; }
            }

            // 🟡 销售/业务标识
            group("🟡 Sales Flags")
            {
                Caption = '🟡 Sales Flags';
                field("Sell Fractions"; Rec."Sell Fractions") { ApplicationArea = All; }
                field("Add to US (4444)"; Rec."Add to US (4444)") { ApplicationArea = All; }
                field("Add to PetSave"; Rec."Add to PetSave") { ApplicationArea = All; }
                field("NEW Item sheet required"; Rec."NEW Item sheet required") { ApplicationArea = All; }
                field("in 998 Y/N"; Rec."in 998 Y/N") { ApplicationArea = All; }
                field("WebItem"; Rec."WebItem?") { ApplicationArea = All; }
                field("FDA Item?"; Rec."FDA Item?") { ApplicationArea = All; }
            }

            // 🟠 财务与分类信息
            group("🟠 Finance & Classification")
            {
                Caption = '🟠 Finance & Classification';
                field("Commission%"; Rec."Commission%") { ApplicationArea = All; }
                field("CommissionAmt"; Rec."CommissionAmt") { ApplicationArea = All; }
                field("Import FrtAmt"; Rec."Import FrtAmt") { ApplicationArea = All; }
                field("DEPT"; Rec."DEPT") { ApplicationArea = All; }
                field("SUBDEPT"; Rec."SUBDEPT") { ApplicationArea = All; }
            }
        }
    }
}






// ===============================================
//  PAGE: Item General API
// ===============================================
page 53101 "Item General API"
{
    PageType = API;
    Caption = 'Item General API';
    APIPublisher = 'joe';
    APIGroup = 'ItemFieldsFromSQL';
    APIVersion = 'v1.0';
    EntityName = 'itemGeneral';
    EntitySetName = 'itemGenerals';
    SourceTable = Item;
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            // 🔑 基本标识
            field(id; Rec.SystemId) { Caption = 'SystemId'; Editable = false; }
            field(no; Rec."No.") { Caption = 'No.'; }

            // 🔵 描述与派生
            field(Description; Rec.Description) { Caption = 'Decription'; }
            field(descLength; Rec."Desc Length") { Caption = 'Desc Length'; }
            field(first30; Rec."First 30 chars.") { Caption = 'First 30 chars.'; }
            field(next10; Rec."Next 10 chars.") { Caption = 'Next 10 chars.'; }

            // 🟢 标识 & 编码
            field(upc; Rec."UPC1") { Caption = 'UPC'; }
            field(productId; Rec."Product ID") { Caption = 'Product ID'; }
            field(aswo; Rec."ASWO#") { Caption = 'ASWO#'; }
            field(cat; Rec."CAT") { Caption = 'CAT'; }
            field(subCat; Rec."SUB CAT") { Caption = 'SUB CAT'; }
            field(uniqueId; Rec."UNIQUE ID") { Caption = 'Unique ID'; }
            field(sizeCode; Rec."SIZE CODE") { Caption = 'Size Code'; }
            field(colorCode; Rec."Color Code") { Caption = 'Color Code'; }
            field(mfgCodeForCountryOfOrigin; Rec."Mfg Code for Country of Origin") { Caption = 'Mfg Code for Country of Origin'; }
            field(in998YN; Rec."in 998 Y/N") { Caption = 'in 998 Y/N'; }

            // 🟣 生命周期 & 状态
            field(dateAdded; Rec."DATE ADDED") { Caption = 'Date Added'; }
            field(itemStatus; Rec."Item Status") { Caption = 'Item Status'; }
            field(storeOrderBlock; Rec."Store Order Block") { Caption = 'Store Order Block'; }

            // 🟡 销售/业务标识
            field(sellFractions; Rec."Sell Fractions") { Caption = 'Sell Fractions'; }
            field(addToUS4444; Rec."Add to US (4444)") { Caption = 'Add to US (4444)'; }
            field(addToPetSave; Rec."Add to PetSave") { Caption = 'Add to PetSave'; }
            field(newItemSheetRequired; Rec."NEW Item sheet required") { Caption = 'NEW Item sheet required'; }
            field(webItem; Rec."WebItem?") { Caption = 'WebItem?'; }
            field(fdaItem; Rec."FDA Item?") { Caption = 'FDA Item?'; }

            // 🟠 财务与分类信息
            field(commissionPct; Rec."Commission%") { Caption = 'Commission%'; }
            field(commissionAmt; Rec."CommissionAmt") { Caption = 'Commission Amount'; }
            field(importFrtAmt; Rec."Import FrtAmt") { Caption = 'Import Freight Amount'; }
            field(dept; Rec."DEPT") { Caption = 'Department'; }
            field(subDept; Rec."SUBDEPT") { Caption = 'Sub Department'; }
        }
    }
}
