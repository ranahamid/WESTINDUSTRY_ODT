tableextension 50011 "ODT SalesHeaderExt" extends "Sales Header" //MyTargetTableId
{
  fields
  {
    field(50000;"ODT AFE";Text[50])
    {
      Caption = 'AFE';
      DataClassification = ToBeClassified;
    }
    field(50001;"ODT Business Unit";Text[50])
    {
      Caption = 'Business Unit';
      DataClassification = ToBeClassified;
    }
    field(50002;"ODT Cost Centre";Code[50])
    {
      Caption = 'Cost Centre';
      DataClassification = ToBeClassified;
    }
    field(50003;"ODT Client File";Text[50])
    {
      Caption = 'Client File';
      DataClassification = ToBeClassified;
    }
    field(50004;"ODT GL";Text[50])
    {
      Caption = 'GL';
      DataClassification = ToBeClassified;
    }
    field(50005;"ODT Major";Text[50])
    {
      Caption = 'Major';
      DataClassification = ToBeClassified;
    }
    field(50006;"ODT Minor";Text[50])
    {
      Caption = 'Minor';
      DataClassification = ToBeClassified;
    }
    field(50007;"ODT MSA";Text[50])
    {
      Caption = 'MSA';
      DataClassification = ToBeClassified;
    }
    field(50008;"ODT MSO";Text[50])
    {
      Caption = 'MSO';
      DataClassification = ToBeClassified;
    }
    field(50009;"ODT Purchase Order";Code[50])
    {
      Caption = 'Purchase Order';
      DataClassification = ToBeClassified;
    }
    field(50010;"ODT Service Order";Code[50])
    {
      Caption = 'Service Order';
      DataClassification = ToBeClassified;
    }
    field(50011;"ODT Job No.";Code[20])
    {
      Caption = 'Job No.';
      DataClassification = ToBeClassified;
      TableRelation = Job."No." WHERE(Status=const(Open));
    }
    field(50012;"ODT Job Description";Text[100])
    {
      Caption = 'Job No.';
      DataClassification = ToBeClassified;
    }
    field(50020;"ODT Field Ticket No.";Code[20])
    {
      Caption = 'Job No.';
      DataClassification = ToBeClassified;
    }
    field(50059;"ODT Project Manager";Code[50])
    {
      Caption = 'Purchase Order';
      DataClassification = ToBeClassified;
      Editable = FALSE;
    }
  }
}
