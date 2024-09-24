unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Grids, Data.DB, Data.Win.ADODB,
  Vcl.DBGrids, Vcl.DBCtrls, System.Actions, Vcl.ActnList, frxClass, frxDesgn,
  frxCross, frxDBSet;

type
  TForm2 = class(TForm)
    Menu: TPanel;
    Analytics: TPanel;
    AnalyticsLabel: TLabel;
    Analytimg: TImage;
    Dashboard: TPanel;
    DashLabel: TLabel;
    Homeimg: TImage;
    Products: TPanel;
    ProductLabel: TLabel;
    Proimg: TImage;
    Users: TPanel;
    UsersLabel: TLabel;
    Usersimg: TImage;
    Clients: TPanel;
    ClientLabel: TLabel;
    Clientimg: TImage;
    Reviwes: TPanel;
    RevLabel: TLabel;
    Revimg: TImage;
    Settings: TPanel;
    SettingLabel: TLabel;
    Settimg: TImage;
    Owork: TPanel;
    OWorkLabel: TLabel;
    TopBar: TPanel;
    Label5: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel10: TPanel;
    Profits: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label12: TLabel;
    Workers: TPanel;
    Label13: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    stck: TPanel;
    Label14: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    OnOrders: TPanel;
    Label15: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    TopSales: TPanel;
    tpsales: TLabel;
    StringGrid1: TStringGrid;
    SalesStats: TPanel;
    Panel9: TPanel;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    CustmLbl: TLabel;
    StringGrid2: TStringGrid;
    DelBtn: TPanel;
    TabSheet3: TTabSheet;
    ADOConnection2: TADOConnection;
    DataSource2: TDataSource;
    ADOTable2: TADOTable;
    Panel6: TPanel;
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    totalLbl: TLabel;
    ToT: TLabel;
    FactureBtn: TPanel;
    Panel12: TPanel;
    DBGrid1: TDBGrid;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    FltrDB1: TEdit;
    Stores: TADOConnection;
    STORETAB: TADOTable;
    STORESRC: TDataSource;
    CustName: TComboBox;
    FltrCat: TComboBox;
    Filter: TPanel;
    Return: TPanel;
    TabSheet4: TTabSheet;
    Panel2: TPanel;
    DBGrid3: TDBGrid;
    DataSource3: TDataSource;
    ADOTable3: TADOTable;
    DBNavigator2: TDBNavigator;

// -----------------------------

    //
    procedure FormCreate(Sender: TObject);

    //  Change Panel Color
    procedure PanelHover(Sender: TObject);

    //  Return Panel Color
    procedure PanelLeave(Sender: TObject);

//  -------------
    //  Go to Statistics  (TABSHEET 1)
    procedure AnalyticsDblClick(Sender: TObject);

    //  Go to Getion de Vente    (TABSHEET 2)
    procedure DashboardDblClick(Sender: TObject);

    //   Go to see all products  (TABSHEET 3)
    procedure ProductsClick(Sender: TObject);

    //   Go to see all Clients  (TABSHEET 4)
    procedure ClientsClick(Sender: TObject);
//  -------------
    //  Press "Enter" to update total label
    procedure UpdateTotValByKeyPress(Sender: TObject; var Key: Char);

    //  Delete  row from stringGrid 2
    procedure DeleteRow(StringGrid: TStringGrid; RowIndex: Integer);

    //  Delete product from buying
    procedure DelBtnClick(Sender: TObject);
//  -------------
    //  Select product to buy
    procedure SelectToBuy(Column: TColumn);

    //  Decrease Num of bought products from Quantity
    procedure DecreaseNumPr();

    //  Buying System
    procedure GestionDeVente(Sender: TObject);

    //  Save Boughts into table
    procedure MoveBoughtsToSOLDS();

    //  Delete Boughts in the table
    procedure DeleteAllRecordsInTable(const tableName: string);

    //  Search in products
    procedure SearchInDBGrid1(Sender: TObject);

    //  return table
    procedure ClearFilterInDBGrid1(Sender: Tobject);

    //  Display most bought products
    procedure SortAndDisplayInStringGrid;


//  ------------------------
  private
    { Private declarations }
    FEditingCol, FEditingRow: Integer;
    FEditing: Boolean;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
//  -------------------------

//  -------
procedure TForm2.AnalyticsDblClick(Sender: TObject);
begin

  // Change the active page to the first tab sheet when Analytics is double-clicked
    PageControl1.ActivePage:= Tabsheet1;
end;

 //  -------
procedure TForm2.DashboardDblClick(Sender: TObject);
begin

  // Change the active page to the second tab sheet when Dashboard is double-clicked
    PageControl1.ActivePage:= Tabsheet2;
end;

//  -------
procedure TForm2.ProductsClick(Sender: TObject);
begin

  // Change the active page to the 3 tab sheet when products is double-clicked
    PageControl1.ActivePage:= Tabsheet3;
end;

procedure TForm2.ClientsClick(Sender: TObject);
begin

// Change the active page to the 4 tab sheet when Clients is double-clicked
    PageControl1.ActivePage:= Tabsheet4;
end;

//  -------
procedure TForm2.SelectToBuy(Column: TColumn);
var
  row, i, total: Integer;
begin
  // Initialize variables
  i := 1;
  total := 0;
  row := 1;

  // Find the first empty row in StringGrid2
  while (Form2.StringGrid2.Cells[0, row] <> '') do
  begin
    row := row + 1;
  end;

  // Populate StringGrid2 with data from DBGrid1
  Form2.StringGrid2.Cells[0, row] := DBGrid1.Fields[0].AsString;
  Form2.StringGrid2.Cells[1, row] := DBGrid1.Fields[1].AsString;
  Form2.StringGrid2.Cells[3, row] := DBGrid1.Fields[4].AsString;

  // If the quantity in StringGrid2 is empty, set it to 1
  if (Form2.StringGrid2.Cells[2, row] = '') then
    Form2.StringGrid2.Cells[2, row] := IntToStr(1);

  // Calculate the total cost and update the corresponding cell in StringGrid2
  Form2.StringGrid2.Cells[4, row] := IntToStr(StrToInt(Form2.StringGrid2.Cells[2, row]) * StrToInt(Form2.StringGrid2.Cells[3, row]));

  // Calculate the total cost of all items in StringGrid2
  while Form2.StringGrid2.Cells[4, i] <> '' do
  begin
    total := total + StrToInt(Form2.StringGrid2.Cells[4, i]);
    i := i + 1;
  end;

  // Update the Total label and the Label12 caption
  Form2.ToT.Caption := IntToStr(total) + ' DZD';
  Form2.Label12.Caption := '+' + Form2.ToT.Caption;
end;


procedure TForm2.SortAndDisplayInStringGrid;
begin


  // Sort the table based on the "Pieces" field in ascending order
  ADOTable1.Sort := 'Quantity ASC';

  // Apply the sort to the dataset
  ADOTable1.First;

  // Clear any existing filters
  ADOTable1.Filtered := False;

  // Set up the StringGrid columns
  StringGrid1.ColCount := 4; // Assuming you have four columns

  // Populate StringGrid with sorted data
  while not ADOTable1.Eof do
  begin
    StringGrid1.RowCount := StringGrid1.RowCount + 1;

    // Populate the StringGrid with data from the table
    StringGrid1.Cells[0, StringGrid1.RowCount - 1] := ADOTable1.FieldByName('Reference').AsString;
    StringGrid1.Cells[1, StringGrid1.RowCount - 1] := ADOTable1.FieldByName('Name').AsString;
    StringGrid1.Cells[2, StringGrid1.RowCount - 1] := ADOTable1.FieldByName('Quantity').AsString;
    StringGrid1.Cells[3, StringGrid1.RowCount - 1] := ADOTable1.FieldByName('Sold Price').AsString;

    ADOTable1.Next;
  end;
end;

//  -------
procedure TForm2.FormCreate(Sender: TObject);
var i,total:Integer;
begin
    i:=1;
    total:=0;

    StringGrid1.Cells[0,0]:='   Reference';
    StringGrid1.Cells[1,0]:='   Product';
    StringGrid1.Cells[2,0]:='   Pieces';
    StringGrid1.Cells[3,0]:='   Price per 1';
//--------------

    StringGrid2.Cells[0,0]:='Reference';
    StringGrid2.Cells[1,0]:='Product';
    StringGrid2.Cells[2,0]:='Pieces';
    StringGrid2.Cells[3,0]:='Price';
    StringGrid2.Cells[4,0]:='Total';
//--------------

    DBGrid2.Columns[0].Width := 130;
    DBGrid2.Columns[1].Width := 180;
    DBGrid2.Columns[2].Width := 400;
    DBGrid2.Columns[3].Width := 100;
    DBGrid2.Columns[4].Width := 150;
    DBGrid2.Columns[5].Width := 180;
    DBGrid2.Columns[6].Width := 150;
//------------

    DBGrid1.Columns[0].Width := 200;
    DBGrid1.Columns[1].Width := 200;
    DBGrid1.Columns[2].Width := 230;
    DBGrid1.Columns[3].Width := 160;
    DBGrid1.Columns[4].Width := 130;
    DBGrid1.Columns[5].Width := 130;
    DBGrid1.Columns[6].Width := 200;
//-----------

    DBGrid3.Columns[0].Width := 300;
    DBGrid3.Columns[1].Width := 250;
    DBGrid3.Columns[2].Width := 300;
    DBGrid3.Columns[3].Width := 200;
    DBGrid3.Columns[4].Width := 200;
//------------

    Label12.Caption:= '+ '+Tot.Caption+' DZD';
    SortAndDisplayInStringGrid;
end;


//  -------
procedure TForm2.DeleteRow(StringGrid: TStringGrid; RowIndex: Integer);
var
  i, j: Integer;
begin
  // Check if the RowIndex is within the valid range
  if (RowIndex >= 0) and (RowIndex < StringGrid.RowCount) then
  begin
    // Move rows down starting from the row below the deleted row
    for i := RowIndex to StringGrid2.RowCount - 2 do
    begin
      for j := 0 to StringGrid2.ColCount - 1 do
      begin
        StringGrid2.Cells[j, i] := StringGrid2.Cells[j, i + 1];
      end;
    end;

    // Decrease the row count
    StringGrid2.RowCount := StringGrid2.RowCount - 1;
  end
  else
  begin
    ShowMessage('Invalid row index.');
  end;
end;

//  -------
procedure TForm2.DelBtnClick(Sender: TObject);
var i,total:Integer;
begin
      DeleteRow(StringGrid2, StringGrid2.Row);

      i:=1;
      total:=0;

      while Form2.StringGrid2.Cells[4,i] <>'' do
          begin
              total:=total+strtoint(Form2.StringGrid2.Cells[4,i]);
              i:=i+1;
          end;
      Form2.ToT.Caption :=inttostr(total)+' DZD';
end;

//  -------
procedure TForm2.PanelHover(Sender: TObject);
begin
  if (Sender is TPanel) then
    TPanel(Sender).Color := RGB(180, 212, 255);
end;

//  -------
procedure TForm2.PanelLeave(Sender: TObject);
begin

  if (Sender is TPanel) then
    TPanel(Sender).Color := clWhite;
end;

//  -------
procedure TForm2.UpdateTotValByKeyPress(Sender: TObject; var Key: Char);
var i,total:Integer;
begin
      i:=1;
      total:=0;
             // Check if the Enter key is pressed (ASCII code 13)
      if Key = #13 then
      begin
        // Get the text of the selected cell
        Form2.StringGrid2.Cells[4, StringGrid2.Row]:=inttostr(strtoint(Form2.StringGrid2.Cells[2, StringGrid2.Row])* strtoint(Form2.StringGrid2.Cells[3, StringGrid2.Row]));

      while StringGrid2.Cells[4,i] <>'' do
        begin
              total:=total+strtoint(StringGrid2.Cells[4,i]);
              i:=i+1;
        end;
    ToT.Caption :=inttostr(total)+' DZD';
    Label12.Caption := '+'+ToT.Caption;

      end;
end;

//  -------
procedure TForm2.DecreaseNumPr();
var
  i, j, colCount, currentRow: Integer;
  ADOConnectionST: TADOConnection;
  ADOTableST: TADOTable;
  numberOfPiecesInStringGrid2: Integer;
  referenceInStringGrid2: string;
begin
  // ADOConnectionST and ADOTableST
  ADOConnectionST := TADOConnection.Create(nil);
  ADOConnectionST.LoginPrompt := False;
  ADOTableST := TADOTable.Create(nil);

  try
    // Set up ADO connection
    ADOConnectionST.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Users\ASUS\Documents\Embarcadero\Studio\Projects\p2\Database\Database1.mdb';  //Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\.\Database\Database1.mdb
    ADOConnectionST.Connected := True;

    // Set up ADOTable for DBGrid1 and DBGrid2
    ADOTableST.Connection := ADOConnection1;
    ADOTableST.TableName := 'Stock'; // Replace with the actual table name for DBGrid1 and DBGrid2
    ADOTableST.Open;

    // Get the number of columns in the StringGrid
    colCount := StringGrid2.ColCount;

    // Iterate through the rows of the StringGrid
    for currentRow := 1 to StringGrid2.RowCount - 1 do
    begin
      // Check if the 'Reference' field in StringGrid2 is not empty
      referenceInStringGrid2 := StringGrid2.Cells[0, currentRow];
      if referenceInStringGrid2 <> '' then
      begin
        // Find the corresponding record in ADOTableST based on the 'Reference' field
        if ADOTableST.Locate('Reference', referenceInStringGrid2, []) then
        begin
          // Update the quantity in both DBGrid1 and DBGrid2
          ADOTableST.Edit;
          numberOfPiecesInStringGrid2 := StrToInt(StringGrid2.Cells[2, currentRow]);
          ADOTableST.FieldByName('Quantity').AsInteger := ADOTableST.FieldByName('Quantity').AsInteger - numberOfPiecesInStringGrid2;
          ADOTableST.Post;
        end;
      end;
    end;

    // Refresh the DBGrid to reflect the changes
    DBGrid1.DataSource.DataSet.Refresh;
    DBGrid2.DataSource.DataSet.Refresh;
  finally
    // Free the resources
    ADOTableST.Close;
    ADOConnectionST.Connected := False;
    ADOConnectionST.Free;
    ADOTableST.Free;

  end;
end;

//  -------
procedure TForm2.MoveBoughtsToSOLDS;
var
  i: Integer;
begin

  STORETAB.Open;
  STORETAB.Insert;

   for i := 1 to StringGrid2.RowCount do
  begin
    if (StringGrid2.Cells[0, i] <> '') then
    begin
      STORETAB.Insert;

      // Assign values from TStringGrid to ADOTable fields

      STORETAB.FieldByName('Reference').AsString := StringGrid2.Cells[0, i];
      STORETAB.FieldByName('Product').AsString := StringGrid2.Cells[1, i];
      STORETAB.FieldByName('Pieces').AsString := StringGrid2.Cells[2, i];
      STORETAB.FieldByName('Price').AsString := StringGrid2.Cells[3, i];
      STORETAB.FieldByName('Total').AsString := StringGrid2.Cells[4, i];
      STORETAB.FieldByName('Client').AsString := CustName.Text;

      // Post the record to the table
      STORETAB.Post;
    end
  end;
  // Close table
  STORETAB.Close;
end;


//sedrgtsrthg

procedure TForm2.DeleteAllRecordsInTable(const tableName: string);
begin
  try
    // Open the table and delete all records
    STORETAB.Open;
    STORETAB.Last; // Move to the last record

    while not STORETAB.BOF do
    begin
      STORETAB.Delete;
      STORETAB.Prior; // Move to the previous record
    end;
    STORETAB.Last;
    STORETAB.Delete;
  except
    on E: Exception do
      ShowMessage('Error deleting records: ' + E.Message); // Handle any errors
  end;
end;

//  -------
procedure TForm2.GestionDeVente(Sender: TObject);
begin

  DecreaseNumPr;
  MoveBoughtsToSOLDS;
  frxReport1.ShowReport;
  DeleteAllRecordsInTable('Solds');


end;

//------------

procedure TForm2.SearchInDBGrid1(Sender: Tobject);
var
  searchValue: string;
  columnName: string;
begin
  // Get the search value from the FilterEdit box
  searchValue := FltrDB1.Text;

  // Get the selected column name from the FilterComboBox
  columnName := FltrCat.Text;

  if (columnName <> '') and (searchValue <> '') then
  begin
    // Apply the filter to the dataset of DataSource1 based on the selected column and search criteria
    DataSource1.DataSet.Filter := Format('%s = ''%s''', [columnName, searchValue]);
    DataSource1.DataSet.Filtered := True;

    // Check if any records match the filter
    if DataSource1.DataSet.IsEmpty then
      ShowMessage('Value not found in the specified category.');
  end
  else
    ShowMessage('Please select a category and enter a search value.');
end;

procedure TForm2.ClearFilterInDBGrid1(Sender: Tobject);
begin
  // Clear the filter conditions and refresh the dataset
  DataSource1.DataSet.Filtered := False;
  DataSource1.DataSet.Filter := '';
  DataSource1.DataSet.Refresh;
end;
end.
