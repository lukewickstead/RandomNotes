PART III - Data Access

- [Chapter 8: Data Binding](#Cap8)
- [Chapter 9: Model Binding](#Cap9)
- [Chapter 10: Querying With LINQ](#Cap10)
- [Chapter 11: Entity Framework](#Cap11)
- [Chapter 12: Dynamic Data](#Cap12)

#Chapter 8: Data Binding# {#Cap8}

Bind entire collections of data to controls at run time without requiring you to write large amounts of code.

The controls understood they were data-bound and would render the appropriate HTML for each item in the data collection.

##DATA SOURCE CONTROLS##

In ASP.NET 1.0/1.1, you typically performed a data-binding operation by writing some data access code to retrieve a DataReader or a DataSet object; then you bound that data

```
SqlConnection conn = new SqlConnection();
SqlCommand cmd = new SqlCommand("SELECT * FROM Customers", conn);
SqlDataAdapter da = new SqlDataAdapter(cmd);
DataSet ds = new DataSet();
da.Fill(ds);

DataGrid1.DataSource = ds;
DataGrid1.DataBind();
```

Since ASP.NET 1.0/1.1, ASP.NET has introduced an additional layer of abstraction through the use of data source controls.

ASP.NET has seven built-in data source controls, each used for a specific type of data access.

|CONTROL NAME| DESCRIPTION|
|SqlDataSource| Provides access to any data source that has an ADO.NET Data Provider available; by default, the control has access to the ODBC, OLE DB, SQL Server, Oracle, and SQL Server Compact providers. |
|LinqDataSource| Provides access to different types of LinqToSql objects using LINQ queries. |
|ObjectDataSource| Provides specialized data access to business objects or other classes that return data. |
|XmlDataSource| Provides specialized data access to XML documents, either physically on disk or in memory. |
|SiteMapDataSource| Provides specialized access to sitemap data for a website that is stored by the sitemap provider. |
|AccessDataSource| Provides specialized access to Access databases. |
|EntityDataSource| Provides specialized access to Entity Framework models.|

All the data source controls are derived from either the DataSourceControl class or the HierarchicalDataSourceControl class,

derived from Control and implement the IDataSource and IListSource interfaces.

should you need to, you can easily create your own custom data source controls

##SqlDataSource Control##

###Configuring a Data Connection###

> *NOTE* Optimistic Concurrency is a database technique that can help you prevent the accidental overwriting of data. When Optimistic Concurrency is enabled, the UPDATE and DELETE SQL statements used by the SqlDataSource control are modified so that they include both the original and updated values. When the queries are executed, the data in the targeted record is compared to the SqlDataSource controls’ original values and if a difference is found, which indicates that the data has changed since it was originally retrieved by the SqlDataSource control, the update or delete will not occur.

```
<asp:SqlDataSource ID="SqlDataSource1" Runat="server"
   SelectCommand="SELECT * FROM [Customers]"
   ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
/>
```

###Data Source Mode Property###

This property allows you to tell the control whether it should use a DataSet (the default selection) or a DataReader internally when retrieving the data.

This is the fastest and most efficient way to read data from your data source because a DataReader does not have the memory and processing overhead of a DataSet.

Choosing to use a DataSet makes the data source control more powerful by enabling the control to perform other operations such as filtering, sorting, and paging. It also enables the built-in caching capabilities of the control.

###Filtering Data Using SelectParameters###

You want to be able to specify parameters in your query to limit the data that is returned.

SqlDataSource’s SelectParameters collection to create parameters that it uses at run time to filter the data returned from the query.

The SelectParameters collection consists of types that derive from the Parameters class.

|PARAMETER |DESCRIPTION|
|ControlParameter| Uses the value of a property of the specified control |
|CookieParameter| Uses the key value of a cookie |
|FormParameter| Uses the key value from the Forms collection |
|QueryStringParameter| Uses a key value from the QueryString collection |
|ProfileParameter| Uses a key value from the user’s profile |
|RouteParameter| Uses a key value from the route segment of the requested URL |
|SessionParameter| Uses a key value from the current user’s session|

Parameter controls derive from the Parameter

|PROPERTY| DESCRIPTION|
|Type| Allows you to strongly type the value of the parameter |
|ConvertEmptyStringToNull| Indicates the control should convert the value assigned to it to Null if it is equal to System.String.Empty |
|DefaultValue| Allows you to specify a default value for the parameter if it is evaluated as Null|

```
<asp:SqlDataSource ID="SqlDataSource1" Runat="server"
    SelectCommand="SELECT * FROM [Customers] WHERE ([CustomerID] = @CustomerID)"
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    DataSourceMode="DataSet">
    <SelectParameters>
        <asp:QueryStringParameter Name="CustomerID" QueryStringField="ID" Type="String"></asp:QueryStringParameter>
    </SelectParameters>
</asp:SqlDataSource>
```

###Conflict Detection###

Conflict Detection property

When this property is set to OverwriteChanges, the user who updated the value last wins.

If the value is set to CompareAllValues, the control compares the original values in the database to the ones received from the user.

One way to determine whether your update has encountered a concurrency error is by testing the AffectedRows property in the SqlDataSource’s Updated event.

```
protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
{
    if (e.AffectedRows > 0)
        this.lblMessage.Text = "The record has been updated";
    else
        this.lblMessage.Text = "Possible concurrency violation";
}
```


###Handling Database Errors###

you can use the SqlDataSource control’s Updated event to handle a database error that has bubbled back to the application as an exception.

```
protected void SqlDataSource1_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
{
    if (e.Exception != null)
    {
        this.lblMessage.Text = e.Exception.Message;
        e.ExceptionHandled = true;
    }
}
```

Setting the ExceptionHandled property to True tells .NET that you have successfully handled the exception and that it is safe to continue executing.

##AccessDataSource Control##

Specialized access to Access databases using the Jet Data provider,

Still uses SQL commands to perform data retrieval because it is derived from the SqlDataSource.

##LinqDataSource Control##

Much like the SqlDataSource control, which generates queries for SQL databases by converting its property settings into SQL queries, the LinqDataSource generates Linq queries for LinqToSql data objects in your application.

##EntityDataSource Control##

bind to and navigate data from an Entity Framework model.

```
<asp:EntityDataSource ID="EntityDataSource1" runat="server"
    ConnectionString="name=NorthwindEntities"
    DefaultContainerName="NorthwindEntities" EnableDelete="True"
    EnableFlattening="False" EnableInsert="True" EnableUpdate="True"
    EntitySetName="Customers" EntityTypeFilter="Customer">
</asp:EntityDataSource>
```

The query used by the control to select data can be completely customized using the CommandText property. This property accepts an Entity SQL command as input. If both CommandText and EntitySetName are set, the control throws an InvalidOperationException. The control also allows data to be grouped and filtered using the GroupBy and Where properties. Both properties accept Entity SQL expressions that specify a grouping operation or filtering operation, respectively. Using the CommandText or GroupBy properties results in the data source control generating a custom projection, which as discussed earlier means that inserts, updates, and deletes are ignored, even if explicitly enabled.

##Using the QueryExtender for Complex Filters##

QueryExtender comes into play, by allowing you to define complex searches, data range filters, complex multicolumn OrderBy clauses, and even completely custom expressions.

|EXPRESSION TYPE| DESCRIPTION|
|SearchExpression| Searches a field or fields for string values and compares them to a specified string. The expression can perform “StartsWith,” “EndsWith,” or “Contains” searches. |
|RangeExpression| Like the SearchExpression, but uses a pair of values to define a minimum and maximum range. |
|PropertyExpression| Compares a property value of a column to a specified value. |
|OrderByExpression| Enables you to sort data by a specified column and sort direction. |
|CustomExpression| Enables you to provide a custom LINQ expression. |
|MethodExpression| Enables you to invoke a method containing a custom LINQ query. |
|OfTypeExpression| Enables you to filter elements in the data source by type.|

The QueryExtender works with any data source control that implements the IQueryableDataSource interface.

By default this includes the LinqDataSource and EntityDataSource controls.

```
<asp:EntityDataSource ID="EntityDataSource1" runat="server"
     ConnectionString="name=NorthwindEntities"
     DefaultContainerName="NorthwindEntities" EnableDelete="True"
     EnableFlattening="False" EnableInsert="True" EnableUpdate="True"
     EntitySetName="Customers" EntityTypeFilter="Customer">
</asp:EntityDataSource>
<asp:QueryExtender ID="QueryExtender2"
     runat="server" TargetControlID=" EntityDataSource1">
     <asp:SearchExpression SearchType="StartsWith" DataFields="CustomerID">
       <asp:QueryStringParameter DefaultValue="A" QueryStringField="search" />
     </asp:SearchExpression>
   </asp:QueryExtender>
```

the expression filters the query results to only CustomerIDs that start with the value specified by the query string field "search".

##XmlDataSource Control##

The XmlDataSource control provides you with a simple way of binding XML documents, either in-memory or located on a physical drive.

consume an RSS feed from the MSDN website, selecting all the item nodes within it for binding to a bound list control such as the GridView.

```
<asp:XmlDataSource ID="XmlDataSource1" Runat="server"
     DataFile="http://msdn.microsoft.com/rss.xml"
     XPath="rss/channel/item" />
```

The control provides the Data property, which accepts a simple string of XML to which the control can bind.

> *Note* that if both the Data and DataFile properties are set, the DataFile property takes precedence over the Data property.

One method is GetXmlDocument, which allows you to export the XML by returning a basic System.Xml.XmlDocument object that contains the XML loaded in the data source control.

Save method to persist changes made to the XmlDataSource control’s loaded XML back to disk.

Executing this method assumes you have provided a file path in the DataFile property.

##ObjectDataSource Control##

The ObjectDataSource control gives you the power to bind data controls directly to middle-layer business objects that can be hard-coded or automatically generated from programs such as Object Relational (O/R) mappers.

```
public class Customer
{
     public string CustomerID { get; set; }
     public string CompanyName { get; set; }
     public string ContactName { get; set; }
     public string ContactTitle { get; set; }
}

public class CustomerRepository
{
    public CustomerRepository()
    {
    }
    public List<Customer> Select(string customerId)
    {
        // Implement logic here to retrieve the Customer
        // data based on the methods customerId parameter
        List<Customer> _customers = new List<Customer>();
        _customers.Add(new Customer()
        {
            CompanyName = "Acme", 
            ContactName = "Wiley Cyote",
            ContactTitle = "President",
            CustomerID = "ACMEC"
        });
       return _customers;
     }         

    public void Insert(Customer c)
    {
        // Implement Insert logic
    }

    public void Update(Customer c)
    {
        // Implement Update logic
    }

    public void Delete(Customer c)
    {
        // Implement Delete logic
    }       
}
```


The methods that the ObjectDataSource uses to perform CRUD operations must follow certain rules in order for the control to understand. For example, the control’s SELECT method must return a DataSet, DataReader, or a strongly typed collection.

```
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server"
    DeleteMethod="Delete" InsertMethod="Insert"
    SelectMethod="Select" TypeName="CustomerRepository"
    UpdateMethod="Update" DataObjectTypeName="Customer">
    <SelectParameters>
        <asp:QueryStringParameter Name="customerId"
            QueryStringField="ID" Type="string" />
    </SelectParameters>
</asp:ObjectDataSource>
```

##SiteMapDataSource Control##

The SiteMapDataSource enables you to work with data stored in your website’s SiteMap configuration file

This can be useful if you are changing your sitemap data at run time, perhaps based on user rights or status.

> *Note* two items regarding the SiteMapDataSource control. One is that it does not support any of the data caching options that exist in the other data source controls provided (covered in the next section), so you cannot automatically cache your sitemap data. Another is that the SiteMapDataSource control does not have any configuration wizards like the other data source controls. This is because the SiteMap control can be bound only to the SiteMap configuration data file of your website, so no other configuration is possible.

##DATA SOURCE CONTROL CACHING##

ASP.NET includes a great caching infrastructure that allows you to cache on the server arbitrary objects for set periods of time.

The data source controls leverage this built-in caching infrastructure to allow you to easily cache their query results.

> *NOTE* The SqlDataSource control’s caching features are available only if you have set the DataSourceMode property to DataSet. If it is set to DataReader, the control will throw a NotSupportedException.

```
<asp:SqlDataSource ID="SqlDataSource1" Runat="server"
     SelectCommand="SELECT * FROM [Customers]"
     ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
     DataSourceMode="DataSet" ConflictDetection="CompareAllValues"
     EnableCaching="True" CacheKeyDependency="SomeKey"
     CacheDuration="Infinite" />
```

if you are using the SqlDataSource control you can use that control’s SqlCacheDependency property to create SQL dependencies.

##DATA-BOUND CONTROLS##

##GridView##

The GridView control is a powerful data grid control that allows you to display an entire collection of data, add sorting and paging, and perform inline editing.

In this example the explicit field definitions have been removed to allow the control to automatically generate columns based on the structure of the data source.

```
<asp:GridView ID="GridView1" runat="server"
       DataSourceID="SqlDataSource1">
</asp:GridView>
```

setting its AutoGenerateFields property to False and generating a field in the GridView’s Columns collection for each public property or database table column exposed by the data source.

```
<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1"
   AutoGenerateColumns="False" DataKeyNames="CustomerID">
   <Columns>
     <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" ReadOnly="True" SortExpression="CustomerID" />
     <asp:BoundField DataField="CompanyName" HeaderText="CompanyName" SortExpression="CompanyName" />
```

The control also detects read-only properties in the data source and sets the field’s ReadOnly property.

When the GridView is rendering, it raises a number of events

|EVENT NAME| DESCRIPTION |
|--|--|
|DataBinding| Raised as the GridView’s data-binding expressions are about to be evaluated. |
|RowCreated| Raised each time a new row is created in the grid. Before the grid can be rendered, a GridViewRow object must be created for each row in the control. The RowCreated event allows you to insert custom content into the row as it is being created. |
|RowDataBound| Raised as each GridViewRow is bound to the corresponding data in the data source. This event allows you to evaluate the data being bound to the current row and to affect the output if you need to. |
|DataBound| Raised after the binding is completed and the GridView is ready to be rendered.|


```
protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
{
    if (e.Row.DataItem != null)
    {
        System.Data.DataRowView drv = (System.Data.DataRowView)e.Row.DataItem;
        if (drv["Region"] == System.DBNull.Value)
        {
            e.Row.BackColor = System.Drawing.Color.Red;
            e.Row.ForeColor = System.Drawing.Color.White;
        }
    }
}
```


###Handling Null and Empty Data Conditions###

EmptyDataText property. This property allows you to specify a string of text that is displayed to the user when no data is present for the GridView to bind to.

creates a special DataRow containing the EmptyDataText value and displays that to the users.

```
<asp:GridView ID="GridView1" Runat="server"
   DataSourceID="SqlDataSource1" DataKeyNames="CustomerID"
   AutoGenerateColumns="True"
   EmptyDataText="No data was found using your query">
</asp:GridView>
```

The other option is to use the EmptyDataTemplate control template to completely customize the special row the user sees

```
<EmptyDataTemplate>
    No data could be found based on your query parameters.
    Please enter a new query. 
</EmptyDataTemplate>
```

The GridView also allows you to configure a value to display if the GridView encounters a Null value when binding to a data source. For an example of this, add a column using a <asp:BoundField> control,

```
<asp:BoundField DataField="Region" HeaderText="Region"
    NullDisplayText="N/A" SortExpression="Region" />
```

###Column Sorting###

To enable sorting in the GridView control just set the AllowSorting attribute to True.

```
<asp:GridView ID="GridView1" Runat="server"
    DataSourceID="SqlDataSource1" DataKeyNames="CustomerID"
    AutoGenerateColumns="True" AllowSorting="True">
</asp:GridView>
```

After enabling sorting, you will see that all the grid’s column headers have now become hyperlinks.

The GridView sorting can handle both ascending and descending sorting.

descending. The GridView also includes a Sort method that can accept multiple SortExpressions to enable multicolumn sorting.

```
<script runat="server">
protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
{
    string oldExpression = GridView1.SortExpression;
    string newExpression = e.SortExpression;
    if (oldExpression.IndexOf(newExpression) < 0)
    {
        if (oldExpression.Length > 0)
            e.SortExpression = newExpression + "," + oldExpression;
        else
            e.SortExpression = newExpression;
    }
    else
    {
        e.SortExpression = oldExpression;
    }
}
```

###Paging GridView Data###

set the AllowPaging property to True

The control defaults to a page size of 10 records and adds the pager to the bottom of the grid.

```
<asp:GridView ID="GridView1" Runat="server"
    DataSourceID="SqlDataSource1" DataKeyNames="CustomerID"
    AutoGenerateColumns="True" AllowSorting="True"
    AllowPaging="True">
</asp:GridView>
```

control the number of records displayed on the page using the GridView’s PageSize attribute.

PagerSettings Mode attribute allows you to dictate how the grid’s pager is displayed using the various pager modes including NextPrevious, NextPreviousFirstLast, Numeric (the default value), or NumericFirstLast.

PagerStyle element in the GridView, you can customize how the grid displays the pager text, including font color, size, and type, as well as text alignment and a variety of other style options.

```
<asp:GridView ID="GridView1" Runat="server" DataSourceID="SqlDataSource1"
    DataKeyNames="CustomerID" AutoGenerateColumns="True"
    AllowSorting="True" AllowPaging="True" PageSize="10">
    <PagerStyle HorizontalAlign="Center" />
    <PagerSettings Position=»TopAndBottom»
      FirstPageText=»Go to the first page»
      LastPageText=»Go to the last page»
      Mode=»NextPreviousFirstLast»>
    </PagerSettings>
</asp:GridView>
```

###Customizing Columns in the GridView###

for all of these properties, except those that return a Boolean type, the grid defaults to using its standard BoundField type, which treats all types as strings. For Boolean types the grid will use the CheckBoxField by default.

|FIELD CONTROL| DESCRIPTION|
|--|--|
|BoundField| Displays the value of a field in a data source. This is the default column type of the GridView control. |
|CheckBoxField| Displays a check box for each item in the GridView control. This column field type is commonly used to display fields with a Boolean value. |
|HyperLinkField| Displays the value of a field in a data source as a hyperlink URL. This column field type allows you to bind a second field to the hyperlink’s text. |
|ButtonField| Displays a command button or command link for each item in the GridView control. This allows you to create a column of custom button or link controls, such as an Add or Remove button. |
|CommandField| Represents a field that displays command buttons or links to perform select, edit, insert, or delete operations in a data-bound control. |
|ImageField| Automatically displays an image when the data in the field represents an image or displays an image from the URL provided. |
|TemplateField| Displays user-defined content for each item in the GridView control according to a specified template. This column field type allows you to create a customized column field.|

```
<asp:HyperLinkField DataTextField="CompanyName"
   HeaderText="CompanyName" DataNavigateUrlFields="CustomerID,Country"
   SortExpression="CompanyName"
   DataNavigateUrlFormatString=http://www.example.com/Customer.aspx?id={0}&country={1} 
/>
```

###Using the TemplateField Column###

A key column type available in the GridView control is the TemplateField

The TemplateField provides you with six templates that enable you to customize different areas or states of the column,

|TEMPLATE NAME | DESCRIPTION |
|--|--|
|ItemTemplate| Template used for displaying a TemplateField cell in the data-bound control |
|AlternatingItemTemplate| Template used for displaying an alternate TemplateField cell |
|EditItemTemplate| Template used for displaying a TemplateField cell in edit state |
|InsertItemTemplate| Template used for displaying a TemplateField cell in insert state |
|HeaderTemplate| Template used for displaying the header section of the TemplateField |
|FooterTemplate| Template used for displaying the footer section of the TemplateField|

```
<asp:TemplateField HeaderText="CurrentStatus">
 <ItemTemplate>
   <table>
    <tr>
     <td ><asp:Button ID="Button2" runat="server" Text="Enable" /></td>
     <td ><asp:Button ID="Button3" runat="server" Text="Disable" /></td>
    </tr>
  </table>
 </ItemTemplate>
</asp:TemplateField>
```

Because the GridView control is data-bound, you can also access the data being bound to the control using data-binding expressions such as the Eval, XPath, or Bind

```
<asp:TemplateField HeaderText="CurrentStatus">
 <ItemTemplate>
  <table>
   <tr>
    <td>
     <asp:Button ID="Button2" runat="server" Text='<%# "Enable " + Eval("CustomerID") %>' />
    </td>
    <td>
     <asp:Button ID="Button3" runat="server" Text='<%# "Disable " + Eval("CustomerID") %>' />
    </td>
   </tr>
  </table>
 </ItemTemplate>
</asp:TemplateField>
```

InsertTemplate and EditTemplate. These templates are used by the grid when a row enters insert or edit mode.

###Editing GridView Row Data###

The configuration needed to enable end users to place grid rows into edit mode and insert or delete data via the GridView is identical regardless of the bound data source control.

The configuration needed to enable the data source control to persist these changes to the underlying data store is specific to each data source control.

####Configuring the SqlDataSource for Updates####

modify the SqlDataSource control by adding an UpdateCommand

```
<asp:SqlDataSource ID="SqlDataSource1" Runat="server"
    SelectCommand="SELECT * FROM [Customers]"
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    DataSourceMode="DataSet"
    UpdateCommand="UPDATE [Customers] SET [CompanyName] = @CompanyName,
      [ContactName] = @ContactName, [ContactTitle] = @ContactTitle,
      [Address] = @Address, [City] = @City, [Region] = @Region,
      [PostalCode] = @PostalCode, [Country] = @Country,
      [Phone] = @Phone,[Fax] = @Fax
      WHERE [CustomerID] = @ CustomerID">
</asp:SqlDataSource>
```

placeholders such as @CompanyName, @Country, @Region, and @CustomerID. These placeholders represent the information that will come from the GridView

Each placeholder corresponds to a Parameter element defined in the SqlDataSource control’s UpdateParameters collection.

```
<UpdateParameters>
     <asp:Parameter Type="String" Name="CompanyName"></asp:Parameter>
     <asp:Parameter Type="String" Name="ContactName"></asp:Parameter>
```

Each Parameter uses two properties to create a connection to the underlying data source, Name, which is the database column name, and Type, which is the database column’s data type.

####Configuring GridView for Updates####

The GridView includes two built-in ways to place a row into edit mode — the AutoGenerateEditButton property and the CommandField.

When the AutoGenerateEditButton property is set to True, this tells the grid to add a ButtonField column with an edit button for each row.

```
<asp:GridView ID="GridView1" Runat="server"
   DataSourceID="SqlDataSource1" DataKeyNames="CustomerID"
   AutoGenerateColumns="True" AllowSorting="True" AllowPaging="True" AutoGenerateEditButton="true" />
```

The CommandField column is a special field type that allows you to enable end users to execute different commands on rows in the GridView.

```
<asp:CommandField ShowHeader="True" HeaderText="Command" ShowEditButton="True" />
```

This allows you to display the command as a link, a button, or even an image.

you need to ensure the grid knows which database table columns are configured as its primary key.

```
<asp:GridView ID="GridView1" Runat="server"   DataSourceID="SqlDataSource1" DataKeyNames="CustomerID"
   AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True">
```

you can specify more than one column

You can control which columns the grid allows to be edited by adding the ReadOnly property to the columns that you do not want users to edit.

```
<asp:BoundField DataField="CustomerID" HeaderText="CustomerID" SortExpression="CustomerID" ReadOnly="True" />
```

####Handling Errors When Updating Data####

check for errors when updating data through the GridView, using the RowUpdated event.

```
<script runat="server">
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
      if (e.Exception != null)
      {
        this.lblErrorMessage.Text = e.Exception.Message;
      }
    }
</script>
```

###Using the TemplateField’s EditItemTemplate###

a better editing experience for the Region column would be to present the possible values as a drop-down list rather than as a simple textbox,

change the Region column from a BoundField to a TemplateField and add ItemTemplate and EditItemTemplate.

```
<asp:TemplateField HeaderText="Country">
    <ItemTemplate><%# Eval("Country") %></ItemTemplate>
    <EditItemTemplate>
      <asp:DropDownList ID="DropDownList1" runat="server"
        DataSourceID="SqlDataSource2"
        DataTextField="Country" DataValueField="Country">
      </asp:DropDownList>
      <asp:SqlDataSource ID="SqlDataSource2" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT DISTINCT [Country] FROM [Customers]">
      </asp:SqlDataSource>
    </EditItemTemplate>
</asp:TemplateField>
```

To show the currently selected country in the DropDownList control, you use the RowDataBound event.

```
<script runat="server">
protected void GridView1_RowDataBound(object sender,  GridViewRowEventArgs e)
{
    // Check for a row in edit mode.
    if ( (e.Row.RowState == DataControlRowState.Edit) || (e.Row.RowState == (DataControlRowState.Alternate |  DataControlRowState.Edit)) )
    {
        System.Data.DataRowView drv = (System.Data.DataRowView)e.Row.DataItem;
        DropDownList ddl = (DropDownList)e.Row.Cells[8].FindControl("DropDownList1");
        ListItem li = ddl.Items.FindByValue(drv["Country"].ToString());
        li.Selected = true;
    }
}
</script>
```

The RowState property is a bitwise combination of DataControlRowState values.


|ROWSTATE| DESCRIPTION|
| Alternate| Indicates that this row is an alternate row Edit Indicates the row is currently in edit mode|
| Insert| Indicates the row is a new row, and is currently in insert mode|
| Normal| Indicates the row is currently in a normal state|
| Selected| Indicates the row is currently the selected row in the GridView|

The RowState can be in multiple states at once — for example, alternate and edit — therefore, you need to use a bitwise comparison to properly determine whether the GridViewRow is in an edit state.

You also need to use a GridView event to add the value of the DropDownList control back into the GridView after the user updates the row.

```
<script runat="server">
protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
{
    GridViewRow gvr = this.GridView1.Rows[this.GridView1.EditIndex];
    DropDownList ddl = (DropDownList)gvr.Cells[8].FindControl("DropDownList1");
    e.NewValues["Country"] = ddl.SelectedValue;
}
</script>
```

EditIndex. This property contains the index of the GridViewRow that is currently in an edit state.

###Deleting GridView Data###

add a Delete button to the grid by setting the AutoGenerateDeleteButton property

```
<asp:GridView ID="GridView2" Runat="server"
      DataSourceID="SqlDataSource1" DataKeyNames="CustomerID"
      AutoGenerateColumns="True" AllowSorting="True" AllowPaging="True"
     AutoGenerateEditButton="true" AutoGenerateDeleteButton="true"/>
```

```
<asp:SqlDataSource ID="SqlDataSource1" Runat="server"
    SelectCommand="SELECT * FROM [Customers]"
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    DataSourceMode="DataSet"
    DeleteCommand="DELETE From Customers WHERE (CustomerID = @CustomerID)"
```

define this parameter from within the SqlDataSource control. To do this, add a <DeleteParameters> section to the SqlDataSource control.

```
<DeleteParameters>
    <asp:Parameter Name="CustomerID" Type="String"></asp:Parameter>
</DeleteParameters>
```

checking for database errors when you delete data is a good idea.

use the GridView’s RowDeleted event and the SqlDataSource’s Deleted event to check for errors that might have occurred during the deletion.

```
<script runat="server">
protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
{
    if (e.Exception != null)
    {
        this.lblErrorMessage.Text = e.Exception.Message;
        e.ExceptionHandled = true;
    }
}

protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
{
    if (e.Exception != null)
    {
        this.lblErrorMessage.Text = e.Exception.Message;
        e.ExceptionHandled = true;
     }
}
</script>
```

arguments. If these properties are not empty, an exception has occurred that you can handle. If you do choose to handle the exception, you should set the ExceptionHandled property to True; otherwise, the exception will continue to bubble up to the end user. DetailsView The DetailsView control is a data-bound control that enables you to work with a single data record at a time. Although the GridView control is excellent for viewing a collection of data, there are many scenarios where you want to show a single record rather than an entire collection. The DetailsView control allows you to do this and provides many of the same data-manipulation and display capabilities as the GridView, including features such as paging, updating, inserting, and deleting data.

```
<asp:DetailsView ID="DetailsView1" Runat="server"
    DataSourceID="SqlDataSource1" DataKeyNames="CustomerID"
    AutoGenerateRows="True"></asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" Runat="server"
        SelectCommand="SELECT * FROM [Customers]"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DataSourceMode="DataSet">
    </asp:SqlDataSource>
```

If you simply want to display a single record, you would probably want to change the SqlDataSource control’s SelectCommand so that it returns only one customer,

you can allow your end users to page through the data by setting the DetailsView’s AllowPaging property to True,

```
<asp:DetailsView ID="DetailsView1" Runat="server"
    DataSourceID="SqlDataSource1" DataKeyNames="CustomerID"
    AutoGenerateRows="True" AllowPaging="true">
</asp:DetailsView>
```

Also, like the GridView, the DetailsView control enables you to customize the control’s pager using the PagerSettings-Mode, as well as the Pager style.

###Customizing the DetailsView Display###

By default, the control displays each public property from its bound data source.

using the same basic syntax used for the GridView control, you can specify that only certain properties be displayed.

```
<asp:DetailsView ID="DetailsView1" Runat="server"
    DataSourceID="SqlDataSource1" DataKeyNames="CustomerID"
    AutoGenerateRows="False">
    <Fields>
        <asp:BoundField ReadOnly="True" HeaderText="CustomerID" DataField="CustomerID" SortExpression="CustomerID" Visible="False" />
        <asp:BoundField ReadOnly="True" HeaderText="CompanyName" DataField="CompanyName" SortExpression="CompanyName" />
        <asp:BoundField HeaderText="ContactName" DataField="ContactName" SortExpression="ContactName" />
        <asp:BoundField HeaderText="ContactTitle" DataField="ContactTitle" SortExpression="ContactTitle" />
   </Fields>
</asp:DetailsView>
```

###Using the DetailsView and GridView Together###

you use the GridView to display a master view of the data and the DetailsView to show the details of the selected GridView row.

```
<html>
   <head id="Head1" runat="server">
     <title>GridView & DetailsView Controls</title>
   </head>
   <body>
     <form id="form1" runat="server">
       <p>
         <asp:GridView ID="GridView1" runat="server"
            DataSourceId="SqlDataSource1"
            DataKeyNames="CustomerID"
            AutoGenerateSelectButton="True" AllowPaging="True"
            AutoGenerateColumns="True" PageSize="5">
           <SelectedRowStyle ForeColor="White" BackColor="#738A9C"
              Font-Bold="True" />
         </asp:GridView>
       </p>
       <p><b>Customer Details:</b></p>
       <asp:DetailsView ID="DetailsView1" runat="server" DataSourceId="SqlDataSource2" 
          AutoGenerateRows="True" DataKeyNames="CustomerID">
       </asp:DetailsView>
           <asp:SqlDataSource ID="SqlDataSource1" runat="server"
          SelectCommand="SELECT * FROM [Customers]"
          ConnectionString="<%$ ConnectionStrings:ConnectionString %>" />
           <asp:SqlDataSource ID="SqlDataSource2" runat="server"
          SelectCommand="SELECT * FROM [Customers]"
          FilterExpression="CustomerID='{0}'"
          ConnectionString="<%$ ConnectionStrings:ConnectionString %>">
          <FilterParameters>
            <asp:ControlParameter Name="CustomerID"
              ControlId="GridView1"
              PropertyName="SelectedValue" />
          </FilterParameters>
       </asp:SqlDataSource>
     </form>
    </body>
</html>
```

the second SqlDataSource control, named SqlDataSource2. A FilterExpression used to filter the data retrieved by the SelectCommand has been added. In this case, the value of the FilterExpression is set to CustomerID='{0}' indicating that the control should filter the data it returns by the CustomerID value given to it.

###SelectParameters versus FilterParameters###

Although both produce essentially the same result, they use very different methods.

SelectParameters allows the developer to inject values into a WHERE clause specified in the SelectCommand. This limits the rows that are returned from the SQL Server and held in memory by the data source control.

The disadvantage is that you are confined to working with the limited subset of data returned by the SQL query.

FilterParameters, on the other hand, do not use a WHERE, instead requiring all the data to be returned from the server and then applying a filter to the data source control’s in-memory data.

The disadvantage of the filter method is that more data has to be returned from the data store.

However, in some cases such as when you are performing many filters of one large chunk of data (for instance, to enable paging in DetailsView) this is an advantage as you do not have to call out to your data store each time you need the next record. All the data is stored in cache memory by the data source control.


###Inserting, Updating, and Deleting Data Using DetailsView###

Inserting data using the DetailsView is similar to inserting data using the GridView control.

add the AutoGenerateInsertButton property


```
<asp:DetailsView ID="DetailsView1" runat="server"
    DataSourceId="SqlDataSource1" DataKeyNames="CustomerID"
   AutoGenerateRows="True" AutoGenerateInsertButton="True" />
```

Then add the InsertCommand and corresponding InsertParameters elements to the SqlDataSource control,


```
<asp:SqlDataSource ID="SqlDataSource1" runat="server"
   SelectCommand="SELECT * FROM [Customers]"
   InsertCommand="INSERT INTO [Customers] ([CustomerID],
     [CompanyName], [ContactName], [ContactTitle], [Address],
     [City], [Region], [PostalCode], [Country], [Phone], [Fax])
     VALUES (@CustomerID, @CompanyName, @ContactName, @ContactTitle,
     @Address, @City, @Region, @PostalCode,@Country, @Phone, @Fax)"
   DeleteCommand="DELETE FROM [Customers]  WHERE [CustomerID] = @original_CustomerID"
   ConnectionString="<%$ ConnectionStrings:ConnectionString %>">
    <InsertParameters>
        <asp:Parameter Type="String" Name="CustomerID"></asp:Parameter>
        <asp:Parameter Type="String" Name="CompanyName"></asp:Parameter>
        <asp:Parameter Type="String"  Name="ContactName"></asp:Parameter>
        <asp:Parameter Type="String" Name="ContactTitle"></asp:Parameter>
        <asp:Parameter Type="String" Name="Address"></asp:Parameter>
        <asp:Parameter Type="String" Name="City"></asp:Parameter>
        <asp:Parameter Type="String" Name="Region"></asp:Parameter>
        <asp:Parameter Type="String" Name="PostalCode"></asp:Parameter>
        <asp:Parameter Type="String" Name="Country"></asp:Parameter>
        <asp:Parameter Type="String" Name="Phone"></asp:Parameter>
        <asp:Parameter Type="String" Name="Fax"></asp:Parameter>
    </InsertParameters>
</asp:SqlDataSource>
```

Updating and deleting data using the DetailsView control are similar to updating and deleting data using the GridView. Simply specify the UpdateCommand or DeleteCommand attributes in the DetailsView control; then provide the proper UpdateParameters and DeleteParameters elements.

##ListView##

ASP.NET includes another list-style control that bridges the gap between the highly structured GridView control, and the anything goes, unstructured controls like DataList and Repeater.

chose the GridView because it was easy to use and offered powerful features such as data editing, paging, and sorting. Unfortunately, the more developers dug into the control, the more they found that controlling the way it rendered its HTML output was exceedingly difficult.

On the other side of the coin, many developers were drawn to DataList or Repeater because of the enhanced control they achieved over rendering. These controls contained little to no notion of layout and allowed developers total freedom in laying out their data.

Unfortunately, these controls lacked some of the basic features of the GridView, such as paging and sorting, or in the case of the Repeater, any notion of data editing.

This is where the ListView can be useful.

The control itself emits no runtime generated HTML markup; instead it relies on a series of 11 control templates that represent the different areas of the control and the possible states of those areas.

the developer retains complete control over not only the markup for individual data items in the control, but also of the markup for the layout of the entire control.

Additionally, because the control readily understands and handles data editing and paging, you can let the control do much of the data-management work, allowing you to focus primarily on data display.

###Getting Started with the ListView###

you need to define at least an ItemTemplate and LayoutTemplate to use the control. The LayoutTemplate serves as the root template for the control, and the ItemTemplate serves as the template for each data item in the control.

You have two options for defining the templates needed by the ListView. You can either edit the templates directly by changing the Current View option in the ListView smart tag, or you can select a predefined layout from the control’s smart tag.

###ListView Templates###

After you have applied a layout template to the ListView, if you look at the Source window in Visual Studio, you can see that to provide the layout the control generated a significant chunk of markup.

If you closely examine the markup that has been generated for the Grid layout used in the previous section, you will see that, by default, the control creates markup for seven control templates:

- ItemTemplate
- AlternatingItemTemplate
- SelectedItemTemplate
- InsertItemTemplate
- EditItemTemplate
- EmptyDataTemplate
- LayoutTemplate.

These are just some of the 11 templates that the control exposes,

|TEMPLATE NAME| DESCRIPTION|
|--|--|
|ItemTemplate| Provides a user interface (UI) for each data item in the control |
|AlternatingItemTemplate| Provides a unique UI for alternating data items in the control |
|SelectedItemTemplate| Provides a unique UI for the currently selected data item |
|InsertItemTemplate| Provides a UI for inserting a new data item into the control |
|EditItemTemplate| Provides a UI for editing an existing data item in the control |
|EmptyItemTemplate| Provides a unique UI for rows created when there is no more data to display in the last group of the current page| 
|EmptyDataTemplate| The template shown when the bound data object contains no data items |
|LayoutTemplate| The template that serves as the root container for the ListView control and is used to control the overall layout of the data items |
|GroupSeparatorTemplate| Provides a separator UI between groups |
|GroupTemplate| Provides a unique UI for grouped content ItemSeparatorTemplate Provides a separator UI between each data item|

###ListView Data Item Rendering###

The LayoutTemplate is the root control template and therefore is where you should define the overall layout for the collection of data items in the ListView.

generated by the Grid layout, you can see the LayoutTemplate includes a <table> element definition, a single table row (tr) definition, and a td element defined for each column header.

The ItemTemplate, on the other hand, is where you define the layout for an individual data item.

generated for the Grid layout, its ItemTemplate is a single table row tr element followed by a series of table cell td elements that contain the actual data.

the ItemTemplate should be rendered within the Layout Template,

what is needed is a mechanism to tell the control exactly where within the LayoutTemplate to place the ItemTemplate.

The item container is an HTML container element with the runat = "server" attribute set and an id attribute whose value is itemContainer.

The element can be any valid HTML container element, although if you examine the default Grid LayoutTemplate you will see that it uses the <tbody> element.

```
<tbody id="itemContainer"> </tbody>
```

you can change the id value the control will look for by changing the control’s ItemContainerID property.

The ListView uses the element identified as the itemContainer to position not only the ItemTemplate, but also any item-level template, such as the AlternativeItemTemplate, EditItemTemplate, EmptyItemTemplate, InsertItemTemplate, ItemSeparatorTemplate, and SelectedItemTemplate.


###ListView Group Rendering###

The group container works in conjunction with the GroupTemplate to allow you to divide a large group of data items into smaller sets.

The number of items in each group is set by the control’s GroupItemCount property.

This is useful when you want to output some additional HTML after some number of item templates has been rendered.

you have three templates to relate: the ItemTemplate to the GroupTemplate, and the GroupTemplate to the LayoutTemplate.

If you have defined the GroupTemplate, the control requires that you define a group container; otherwise it throws an exception.

The group container works the same way as the item container described in the previous section, except that the container element’s id value should be groupContainer, rather than itemContainer.

GroupContainerID property of the control.

```
<table id="groupContainer" runat="server" border="" style="">   </table>
```

define an item container, but rather than doing this in the LayoutTemplate, you need to do it in the GroupTemplate.

```
<tr id="itemContainer" runat="server">   </tr>
```

###Using the EmptyItemTemplate###

the number of data items bound to the ListView control may not be perfectly divisible by the GroupItemCount value.

This template is rendered if you are using the GroupTemplate and there are not enough data items remaining to reach the GroupItemCount value.

###ListView Data Binding and Commands###

each template uses the standard ASP.NET inline data-binding syntax to position the values of each data item in the defined layout.

```
<asp:Label ID="ProductNameLabel" runat="server"
     Text='<%# Eval("ProductName") %>' />
```

if you enable editing in the Grid layout you will see that the EditItemTemplate simply replaces the ASP.NET label used by the ItemTemplate with a textbox or check box,

```
<asp:TextBox ID="ProductNameTextBox" runat="server"
     Text='<%# Bind("ProductName") %>' />
```

Again, this flexibility allows you to choose exactly how you want to allow your end user to edit the data (if you want it to be editable).

To get the ListView to show the EditItemTemplate for a data item, the control uses the same commands concept found in the GridView control.

|COMMAND NAME| DESCRIPTION|
|Edit| Places the specific data item into edit mode and shows the EditTemplate for the data item|
| Delete| Deletes the specific data item from the underlying data source|
| Select| Sets the ListView control’s selected index to the index of the specific data item|

These commands are used in conjunction with the ASP.NET Button control’s CommandName property.

```
<asp:Button ID="DeleteButton" runat="server"
     CommandName="Delete" Text="Delete" />
   <asp:Button ID="EditButton" runat="server"
     CommandName="Edit" Text="Edit" />
```

Other templates in the ListView offer other commands, as shown in Table 8-11.

|TEMPLATE COMMAND NAME| DESCRIPTION|
| EditItemTemplate Update| Updates the data in the ListView’s data source and returns the data item to the ItemTemplate display |
|EditItemTemplate| Cancel Cancels the edit and returns the data item to the ItemTemplate |
|InsertItemTemplate |Insert Inserts the data into the ListView’s data source |
|InsertItemTemplate| Cancel Cancels the insert and resets the InsertTemplate controls binding values|

###ListView Paging and the Pager Control###

ASP.NET includes another control called DataPager that the ListView uses to provide paging capabilities.

The DataPager control is designed to display the navigation for paging to the end user and to coordinate data paging with any data-bound control that implements the IPagableItemContainer interface, which in ASP.NET is the ListView control.

```
<asp:datapager ID="DataPager1" runat="server">
    <Fields>
        <asp:nextpreviouspagerfield ButtonType="Button" FirstPageText="First"
            LastPageText="Last" NextPageText="Next" PreviousPageText="Previous"
            ShowFirstPageButton="True" ShowLastPageButton="True" />
    </Fields>
</asp:datapager>
```

using the NextPreviousPager object results in the DataPager rendering Next and Previous buttons as its user interface.

The DataPager control includes three types of Field objects:

the NextPreviousPagerField; the NumericPagerField object, which generates a simple numeric page list; and the TemplatePagerField, which allows you to specify your own custom paging user interface.

because the DataPager exposes a Fields collection rather than a simple Field property, you can display several Field objects within a single DataPager control.

```
<asp:DataPager ID="DataPager1" runat="server">
  <Fields>
    <asp:TemplatePagerField>
      <PagerTemplate>
        Page <asp:Label ID="Label1" runat="server" Text="<%# (Container.StartRowIndex/Container.PageSize)+1%>" />
        of <asp:Label ID="Label2" runat="server" Text="<%# Container.TotalRowCount/Container.PageSize%>" />
      </PagerTemplate>
    </asp:TemplatePagerField>
  </Fields>
</asp:DataPager>
```

Notice that the example uses ASP.NET data binding to provide the total page count, page size, and the row that the page should start on;

Unlike the paging provided by the GridView, DataPager, because it is a separate control, gives you total freedom over where to place it on your web page.

the only significant change you should notice is the use of the PagedControlID property.

```
<asp:DataPager ID="DataPager1" runat="server" PagedControlID="ListView1">
  <Fields>
    <asp:NumericPagerField />
  </Fields>
</asp:DataPager>
```

##FormView##

The FormView control functions like the DetailsView control in that it displays a single data item from a bound data source control and allows adding, editing, and deleting data. What makes it unique is that it displays the data in custom templates, which gives you much greater control over how the data is displayed and edited.

```
<html xmlns="http://www.w3.org/1999/xhtml" > 
<head runat="server">
  <title>Using the FormView control</title>
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <asp:FormView ID="FormView1" Runat="server" DataSourceID="SqlDataSource1" DataKeyNames="CustomerID" AllowPaging="True">

        <EditItemTemplate>
          CustomerID: 
          <asp:Label Text='<%# Eval("CustomerID") %>' Runat="server" ID="CustomerIDLabel1"></asp:Label><br />
          CompanyName:
          <asp:TextBox Text='<%# Bind("CompanyName") %>' Runat="server" ID="CompanyNameTextBox"></asp:TextBox><br />
          ContactName:
          <asp:TextBox Text='<%# Bind("ContactName") %>' Runat="server" ID="ContactNameTextBox"></asp:TextBox><br />
      
          <asp:Button ID="Button2" Runat="server" Text="Button" CommandName="update" />
          <asp:Button ID="Button3" Runat="server" Text="Button" CommandName="cancel" />       
        </EditItemTemplate>       
        <ItemTemplate>
          <table width="100%">
            <tr>
              <td style="width: 439px">
                <b><span style="font-size: 14pt"> Customer Information</span></b>
              </td>
              <td style="width: 439px" align="right">
                CustomerID:
                <asp:Label ID="CustomerIDLabel" Runat="server" Text='<%# Bind("CustomerID") %>'></asp:Label>
              </td>
            </tr>
           <tr>
             <td colspan="2">
               CompanyName:
               <asp:Label ID="CompanyNameLabel" Runat="server" Text='<%# Bind("CompanyName") %>'></asp:Label>
               <br />
               ContactName:
               <asp:Label ID="ContactNameLabel" Runat="server" Text='<%# Bind("ContactName") %>'></asp:Label>
               <br />
           </tr>
         </table>               
         <asp:Button ID="Button1" Runat="server" Text="Button" CommandName="edit" />
      </ItemTemplate>
    </asp:FormView>

       <asp:SqlDataSource ID="SqlDataSource1" Runat="server" SelectCommand="SELECT * FROM [Customers]"        
         ConnectionString="<%$ ConnectionStrings:ConnectionString %>">
       </asp:SqlDataSource>
     </div>
  </form>
</body>
</html>
```

##OTHER DATA-BOUND CONTROLS##

###TreeView###

The TreeView displays hierarchically structured data. Because of this, it can be data-bound only to the XmlDataSource and the SiteMapDataSource controls that are designed to bind to hierarchically structured data sources like a SiteMap file.

```
<siteMap>
    <siteMapNode url="page3.aspx" title="Home" description="" roles="">
    <siteMapNode url="page2.aspx" title="Content" description="" roles="" />
    <siteMapNode url="page4.aspx" title="Links" description="" roles="" />
    <siteMapNode url="page1.aspx" title="Comments" description="" roles="" />
</siteMap>
```

```
<html xmlns="http://www.w3.org/1999/xhtml" >
  <head runat="server">
    <title>Using the TreeView control</title> 
  </head>
  <body>
    <form id="form1" runat="server">
      <div>
        <asp:TreeView ID="TreeView1" Runat="server" DataSourceID="SiteMapDataSource1" />
        <asp:SiteMapDataSource ID="SiteMapDataSource1" Runat="server" />
      </div>
    </form>
  </body>
</html>
```

###Menu###

Like the TreeView control, the Menu control is capable of displaying hierarchical data in a vertical pop-out style menu.

It can be data-bound only to the XmlDataSource and the SiteMapDataSource controls.

```
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
  <title>Using the Menu control</title>
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <asp:Menu ID="Menu1" Runat="server" DataSourceID="SiteMapDataSource1" />
      <asp:SiteMapDataSource ID="SiteMapDataSource1" Runat="server" />
    </div>
  </form>
</body>
</html>
```


###Chart###

This is a great control for getting you up and running with some good-looking charts. 

Those are a lot of different chart styles!

It is part of the System.Web.DataVisualization namespace.

##INLINE DATA-BINDING SYNTAX##

In ASP.NET 1.0/1.1, if you needed to use inline data binding, you might have created something like

```
<asp:Repeater ID="Repeater1" runat="server"
    DataSourceID="SqlDataSource1">
   <HeaderTemplate>
     <table>
   </HeaderTemplate>
   <ItemTemplate>
     <tr>
      <td>
        <%# Container.DataItem("ProductID")%><BR/>
        <%# Container.DataItem("ProductName")%><BR/>
        <%# DataBinder.Eval(
            Container.DataItem, "UnitPrice", "{0:c}")%><br/>
       </td>
     </tr>
   </ItemTemplate>
   <FooterTemplate>
     </table>
   </FooterTemplate>
</asp:Repeater>
```

In later versions of ASP.NET, you are given a simpler syntax and several powerful binding tools to use.

###Data-Binding Syntax###

ASP.NET contains three ways to perform data binding.

One way is that you can continue to use the existing method of binding, using the Container.DataItem syntax:

```
<%# Container.DataItem("Name") %>
```

the simplest form of binding, which is to use the Eval method directly:

```
<%# Eval("Name") %>
```

You can also continue to format data using the formatter overload of the Eval method:

```
<%# Eval("HireDate", "{0:mm dd yyyy}" ) %>
```

ASP.NET includes a form of data binding called two-way data binding.

Two-way data binding allows you to support both read and write operations for bound data.

This is done using the Bind method, which, other than using a different method name, works just like the Eval method:

```
<%# Bind("Name") %>
```

The Bind method should be used in controls such as the GridView, DetailsView, or FormView, where autoupdates to the data source are implemented.

Anything between the <%# %> delimiters is treated as an expression.

```
<%# "Foo " + Eval("Name") %>
```

```
<%# DoSomeProcess( Eval("Name") )%>
```

##XML Data Binding##

Additionally, except for the different method names, these binding methods work exactly the same as the Eval and Bind methods discussed earlier.

These binders should be used when you are using the XmlDataSource control.

```
<% XPathBinder.Eval(Container.DataItem, "employees/employee/Name") %>
```

The XPathBinder binds the result of an XPath query.

Also has a shorthand format:

```
<% XPath("employees/employee/Name") %>
```

```
supports applying formatting to the data:
```

```
<% XPath("employees/employee/HireDate", "{0:mm dd yyyy}") %>
```

The XPathBinder returns a single node using the XPath query provided. Should you want to return multiple nodes from the XmlDataSource control, you can use the class’s Select method. This method returns a list of nodes that match the supplied XPath query:

```
<% XPathBinder.Select(Container.DataItem,"employees/employee") %>
```

Or use the shorthand syntax:

```
<% XpathSelect("employees/employee") %>
```

##USING EXPRESSIONS AND EXPRESSION BUILDERS##

```
ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
```

Expressions contained in the <%$ %\> delimiters. This indicates to ASP.NET that this is an expression to be parsed.

The ConnectionStrings expression prefix, which tells ASP.NET to use the ConnectionStringsExpressionBuilder class to parse the expression.

```
<asp:Label runat="server" ID="Label1"
   Text="<%$ AppSettings: LabelText %>" />
```

```
<asp:Label runat="server" ID="Label1"
   Text="<%$ Resources: MyAppResources,Label1Text %>" />
```

You can also create your own expressions by deriving a class from the System.Web.Compilation.ExpressionBuilder base class.

```
[ExpressionPrefix("MyFirstCustomExpression")]   
[ExpressionEditor("MyFirstCustomExpressionEditor")]   
public class MyFirstCustomExpression : ExpressionBuilder   
{
     public override System.CodeDom.CodeExpression
       GetCodeExpression(BoundPropertyEntry entry, object parsedData,
         ExpressionBuilderContext context)
     {
       return new CodeCastExpression("Int64",
         new CodePrimitiveExpression(1000));
     }   
}
```

GetCodeExpression method. This method supplies you with several parameters that can be helpful in executing this method, and it returns a CodeExpression object to ASP.NET that it can execute at run time to retrieve the data value.

> *NOTE* The CodeExpression class is a base class in .NET’s CodeDom infrastructure. Classes that are derived from the CodeExpression class provide abstracted ways of generating .NET code, whether VB or C#. This CodeDom infrastructure helps you create and run code dynamically at run time.

The BoundPropertyEntry parameter entry tells you exactly which property the expression is bound to.

adding an ExpressionBuilders node to the compilation node in your web.config

```
<compilation debug="true" strict="false" explicit="true">
   <expressionBuilders>
     <add expressionPrefix="MyCustomExpression" type="MyCustomExpression"/>
   </expressionBuilders> 
</compilation>
```

#Chapter 9: Model Binding# {#Cap9}

Model binding was introduced in ASP.NET MVC. Model binding made it easier to bring the data submitted by the client into a format that’s suitable for use and validation on the server.

When ASP.NET MVC 2.0 was released, a new system called “extensible model binding” was introduced.

However, in ASP.NET 4.5 model binding can also be used for building ASP.NET Web Forms applications.

##MODEL BINDING##

Model binding serves two purposes. It provides a way to fetch values from the client and bind them to a model.

It also provides a validation mechanism whereby, once the model is bound, you can run validation rules to determine if the model is valid before saving the model.

Allows developers to easily integrate patterns, such as PRG (Post-Redirect-Get), Repository, and so on,

You can use model binding to extract the values from the control so that the client values can be used for inspection at the server, and the controls can bind to the values returned from the model binding system.

Model binding works with existing data-bound controls

A model can be either an ADO.NET Entity Framework model or an Entity Framework Code First model.

###Selecting Data###

ItemType tells the model binding system which type of model the control should bind to.

The SelectMethod property determines which method to call on the page to get the records.

```
<asp:GridView ID="GridView1" runat="server" ItemType="Customer" AllowPaging="true" AllowSorting="true" PageSize="2" SelectMethod="SelectCustomers"></asp:GridView>
```

```
CustomerContext _context = new CustomerContext();       
public IEnumerable<Customer> SelectCustomers()       
{
    return _context.Customer.AsEnumerable();
}
```

##Paging##

The GridView control has built-in paging and sorting features. Using model binding, you can take advantage of these features by returning an IQueryable<T> from the model binding Select method.

To get paging and sorting, you need to enable paging and sorting on the GridView control

```
CustomerContext _context = new CustomerContext();           

public IQueryable<Customer> SelectCustomers()
{                             
    return _context.Customer.AsQueryable();
}
```

##Filtering##

Filtering can be achieved in model binding by using ValueProviders and ValueProvider attributes.

```
public IEnumerable<Customer> SelectCustomers([System.Web.ModelBinding.QueryString] int? id)
{           
    if(id.HasValue)
        return _context.Customer.Where(c => c.ID == id).AsEnumerable();
    else
        return _context.Customer.AsEnumerable();
    }
```

##Using Value Providers##

how to use the QueryString value provider attribute to filter the results.

The model binding system performs any type conversion as needed.

The value provider attributes eventually get the value from ValueProviders and tell the model binding system which ValueProvider to use.

|VALUE PROVIDER ATTRIBUTES| DESCRIPTION|
|--|--|
| Form| The value is retrieved from the Form collection. |
|Control| The value is retrieved from the specified control. |
|QueryString| The value is retrieved from the QueryString collection. |
|Cookie| The value is retrieved from the Cookie collection. |
|Profile| The value is retrieved from the Profile collection. |
|RouteData| The value is retrieved from the RouteData collection. |
|Session| The value is retrieved from the Session collection.|

##Filtering Using Control##

where you want to filter a result based on a value coming from another server control.

You might often find the need to filter values based on a drop-down list,

```
<asp:DropDownList ID="DropDown1" runat="server" ItemType="Customer"
  SelectMethod="SelectCustomersForDropDownList" AppendDataBoundItems="true"
  AutoPostBack="true"
  DataTextField="ID" DataValueField="ID">
</asp:DropDownList>
<asp:GridView ID="GridView1" runat="server" ItemType="Customer" SelectMethod="SelectCustomers"> </asp:GridView>
```

```
public IEnumerable<Customer> SelectCustomers([System.Web.ModelBinding.Control] int? DropDown1)       
{           
    if (DropDown1.HasValue)               
        return _context.Customer.Where(c => c.ID == DropDown1).AsEnumerable();           
    else
        return _context.Customer.AsEnumerable();       
}   

public IEnumerable<Customer> SelectCustomersForDropDownList()
{           
    return _context.Customer.AsEnumerable();
}
```

##Inserting Data##

You can use the DetailsView control to insert a record.

set a new property called InsertMethod,

```
<asp:DetailsView runat="server" ItemType="Customer" SelectMethod="SelectCustomers"
    InsertMethod="InsertCustomer" AutoGenerateInsertButton="true" AllowPaging="true">   
</asp:DetailsView>
```

```
public void InsertCustomer(Customer customer)       
{           
    _context = new CustomerContext()           
    if(ModelState.IsValid)           
    {
        _context.Customer.Add(customer);
    }
}
```

When you insert a value, the model binding system takes the values from the DetailsView control and populates the customer type model so the customer model can be used at the server for any kind of validation.

##Updating Data##

the data control will often not be able to provide values for each member of the model, either because those members are relationship objects or they are not rendered in the control.

In these cases, it’s best to take in the primary key, load the model from the data storage, and tell the model binding system to bind the values from the data control to the model.

```
<asp:DetailsView runat="server" ItemType="Customer" SelectMethod="SelectCustomers"           
    UpdateMethod="UpdateCustomer" AutoGenerateEditButton="true" DataKeyNames="ID"           
    AllowPaging="true">
</asp:DetailsView>
```

```
CustomerContext _context = new CustomerContext();

public Customer SelectCustomers()
{
    return _context.Customer.First();
}          

public void UpdateCustomer(int id)
{
    _context = new CustomerContext();           

    var customer = _context.Customer.Where(c => c.ID == id).First();           
    TryUpdateModel(customer);           
    if(ModelState.IsValid)
    {
    }
}
```

All data-bound controls have a property called DataKeyNames that uniquely identifies a record.

This property has the names of the primary key fields.

When you call TryUpdateModel, the model binding system updates the values of the customer model with the ones specified by the user when he/she updated the record.

>*NOTE* Just as you perform an update operation by setting the UpdateMethod property on the control, you can set the DeleteMethod to perform a delete operation, on the record.

##Validating Records in a Model Binding System##

In the majority of cases, you would want to validate a record for some custom business logic before saving the record in the database.

The benefit of the model binding system is that it cleanly separates binding from validation.

The validation errors thrown from the model binding system are displayed through a validation summary, so this makes it easy to customize the UI and helps maintain clean code.

One benefit of enabling model binding in ASP.NET Web Forms is that you can plug in different validation mechanisms.

data annotation attributes,

```
[Required()]   
public string FirstName { get; set; }
```

In this case, if you do not enter a value for the FirstName field, the call to TryUpdateModel() will return false. If you have a ValidationSummary control on the page, then you will get the error message displayed in the validation summary.

The other way to check for any validation errors is to check the ModelState property of the page.

This property is populated by the model binding system in case any errors happened during model binding.

```
<asp:ValidationSummary runat="server" ShowModelStateErrors="true" />
```

##Separating Business Logic from the page##

You have to tell the model binding system where to load the model binding methods. This is done by overriding the OnCallingDataMethods method of the data-bound control.

The model binding system will then instantiate the repository class and will look for the methods in the class.

```
protected void GridView1_CallingDataMethods(object sender, CallingDataMethodsEventArgs e)   
{
    e.DataMethodsObject = new CustomerRepository();
}
```

##USING STRONGLY TYPED CONTROLS##

ASP.NET 2.0 Web Forms introduced the concept of templated controls. Templates allow you to customize the markup emitted from server controls and are typically used with data-binding expressions.

This section looks at the improvements that have happened in ASP.NET 4.5 to make data binding and HTML encoding easier.

In ASP.NET 2.0 one-way data binding was accomplished with the Eval() and Bind() helpers. These helpers do a late binding to the data.

```
<asp:FormView ID="editCustomer" runat="server">
    <ItemTemplate>
        <div>
            First Name:<%# Eval("FirstName") %>
        </div>
    </ItemTemplate>
</asp:FormView>
```

One drawback of this approach is that since these expressions are late bound, you have to pass in a string to represent the property name. This means you do not get IntelliSense for member names, support for code navigation (like Go To Definition), or compile-time checking support.

When a control is strongly typed, it means that you can declare which type of data the control is going to be bound to, by way of a new property called ItemType.

When you set this property, the control will have two new properties for the bind expressions — Item and BindItem.

Item is equivalent to Eval(), whereas BindItem is equivalent to Bind().

```
<asp:FormView ID="editCustomer" runat="server" ItemType="Customer" SelectMethod="SelectCustomer" >
    <ItemTemplate>
        <div> First Name:<%# Item.FirstName %> </div>
    </ItemTemplate>
</asp:FormView>
```

##EXTENDING MODEL BINDING##

the Model Binding system is built in such a way that you can easily customize and extend the model binding system to match your development scenarios.

###Custom Value Providers###

These provide basic support for specifying where the model binding system should fetch the value from.

However, there are cases when you really don’t know where the value might come from, or you want to write your application so you have a fallback mechanism

```
public class AggregateValueProvider : IValueProvider, IUnvalidatedValueProvider  
{
    private readonly List<IUnvalidatedValueProvider> _valueProviders = new List<IUnvalidatedValueProvider>();

    public AggregateValueProvider(ModelBindingExecutionContext modelBindingExecutionContext)
    {
        _valueProviders.Add(new FormValueProvider(modelBindingExecutionContext))
        _valueProviders.Add(new QueryStringValueProvider(modelBindingExecutionContext));     
    }

    public bool ContainsPrefix(string prefix)
    {
         return _valueProviders.Any(vp => vp.ContainsPrefix(prefix));
    }

    public ValueProviderResult GetValue(string key)
    {
        return GetValue(key, false);
    }       

    public ValueProviderResult GetValue(string key, bool skipValidation)
    {
        return _valueProviders.Select(vp => vp.GetValue(key, skipValidation)).LastOrDefault();
    }  
}     

public class AggregateValueAttribute : ValueProviderSourceAttribute
{
    public override IValueProvider GetValueProvider(ModelBindingExecutionContext modelBindingExecutionContext)
    {
        return new AggregateValueProvider(modelBindingExecutionContext);
    }
}
```


the model binding system calls into this custom value provider, the custom value provider will first check the Form collection to retrieve the value, and if there is no value found, then the QueryString collection will be checked.

```
CustomerContext _context = new CustomerContext();         
public IEnumerable<Customer> SelectCustomers([AggregateValue] int? id)     
{         
    if(id.HasValue)         
        return _context.Customer.Where(c => c.ID == id).AsEnumerable();
    else
        return _context.Customer.AsEnumerable();
}
```

##Custom Model Binders##

there are cases when the model binding system cannot bind to a specific data type.

To implement a custom model binder, you have to implement a provider and a binder.

A provider is called by the model binding system to check if the provider can handle a particular type.

The binder is responsible for parsing the value from the model binding system and populating the model.

```
public class MyDateTimeBinder : IModelBinder
{
    public bool BindModel(ModelBindingExecutionContext modelBindingExecutionContext, ModelBindingContext bindingContext)
    {
        var valueProviderResult = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
        var inputdate = valueProviderResult != null ? valueProviderResult.AttemptedValue : null;
        DateTime dt = new DateTime();         
        bool success = DateTime.TryParse(inputdate, CultureInfo.GetCultureInfo("en-GB"),
        DateTimeStyles.None, out dt);         
        bindingContext.Model = dt;           
        return bindingContext.Model != null;     
    }
}

public class MyDateTimeProvider : System.Web.ModelBinding.ModelBinderProvider  {
    public override IModelBinder GetBinder(ModelBindingExecutionContext modelBindingExecutionContext, ModelBindingContext bindingContext)
    {
        if (bindingContext.ModelType == typeof(DateTime))
            return new MyDateTimeBinder();
        return null;
    }
}
```

When the model binding system tries to bind data to a model, it looks through a list of registered providers to see which provider can find a binder to bind a value for a specific type. The registered providers are called in order.

how you can register the model binder with the application.

```
System.Web.ModelBinding.ModelBinderProviders.Providers.Insert(0, new MyDateTimeProvider());
```

##Custom ModelDataSource##

The implementation uses the extensible model binding and the controls architecture. Model binding is implemented as a data source called ModelDataSource, which implements IDataSource. This is the same pattern followed by other ObjectDataSource objects.

This means that this implementation is fully extensible. If you want to override the behavior of how the select calls happen, then you can write your own ModelDataSource and ModelDataSourceView objects and plug them into the model binding system. This is useful if you want to extend the model binding system to make scenarios such as master-detail binding easier to implement.

```
public class MyModelView : ModelDataSourceView
{         
    private readonly MyModelDataSource _owner;
    public MyModelView(MyModelDataSource owner) : base(owner)
    {
        _owner = owner;
    }
    
    protected override IEnumerable ExecuteSelect(DataSourceSelectArguments arguments)
    {
        CustomerContext _context = new CustomerContext();
        return _context.Customer.Take(3).AsEnumerable();
        //return _context.Customer.Distinct<Customer>().AsEnumerable();
    }
}

public class MyModelDataSource : ModelDataSource
{         
    private MyModelView _view;           
    public MyModelDataSource(Control dataControl) : base(dataControl)
    {
    }

    public override ModelDataSourceView View
    {
        get
        {
            if (_view == null)
            {
                _view = new MyModelView(this);
            }
            return _view;
        }
    }
```


On the data control, you can override the ModelDataSource that the control should use by overriding an event called OnCreatingModelDataSource.

```
protected void GridView1_CreatingModelDataSource(object sender, CreatingModelDataSourceEventArgs e)
{
    e.ModelDataSource = new CS.MyModelDataSource((GridView)sender);
}
```

#Chapter 10: Querying With LINQ# {#Cap10}

.NET 3.5 introduced a new technology called Language Integrated Query, or LINQ (pronounced “link”).

Since that time LINQ has continued to become an integral technology in .NET development.

LINQ is designed to fill the gap that exists between traditional .NET languages, which offer strong typing and object-oriented development, and query languages such as SQL, with syntax specifically designed for query operations.

LINQ includes three basic types of queries: LINQ to Objects; LINQ to XML; and LINQ used in the context of databases, like LINQ to SQL or LINQ to Entities.

> *NOTE* While this chapter focuses primarily on the LINQ capabilities included in the .NET Framework, LINQ is highly extensible and can be used to create query frameworks over just about any data source. How to implement your own LINQ provider is beyond the scope of this chapter. There are many custom implementations of LINQ used to query a wide variety of data stores such as LDAP, SharePoint, and even Amazon.com. Roger Jennings from Oakleaf Systems maintains a list of third-party LINQ providers on his blog at http://oakleafblog.blogspot.com/2007/03/third-party-linq-providers.html

##LINQ TO OBJECTS##

LINQ to Objects enables you to perform complex query operations against any enumerable object (any object that implements the IEnumerable interface).

###Replacing Traditional Queries with LINQ###

Rather than requiring you to very specifically define exactly how you want a query to execute, LINQ gives you the power to stay at a more abstract level. By defining what you want the query to return, you leave it up to .NET and its compilers to determine the specifics of exactly how the query will run.

The base LINQ functionality is located in the System.Core.dll assembly.

###Basic LINQ Queries and Projections###

```
var query = from m in movies
select m;

var query = from m in movies
select new { m.Title, m.Genre };

var query = from m in movies
select new { MovieTitle = m.Title, MovieGenre = m. Genre };

var query = from m in movies
orderby m.Title descending
select new { MovieTitle = m.Title, MovieGenre = m. Genre };

var query = movies.Select(m => m);
```

###Ordering Results Using a Custom Comparer###

```
using System.Collections.Generic;
public class LastNameComparer : IComparer<string>   
{       
    public int Compare(string x, string y)
    {
        var director1LastName = x.Substring(x.LastIndexOf(' '));
        var director2LastName = y.Substring(y.LastIndexOf(' '));
        return director1LastName.CompareTo(director2LastName);
    }
}
```


```
var query = movies.OrderByDescending(m => m.Director, new LastNameComparer())
.Select(m => new {MovieDirector = m.Director, MovieTitle = m.Title, MovieGenre = m.Genre });
```

##Deferred Execution##

An interesting feature of LINQ is its deferred execution behavior. This means that even though you may execute the query statements at a specific point in your code, LINQ is smart enough to delay the actual execution of the query until it is accessed.

a LINQ query returns an IQueryable, which inherits from IEnumerable, the data is not available until you actual iterate over it.

##Filtering Data Using LINQ##

var query = from m in movies
where m.Genre==0
select m;
```

var query = from m in movies
where m.Genre == 0 && m.RunTime > 92
select m;
```

##Grouping Data Using LINQ##

```
var query = from m in movies           
group m by m.Genre into g           
select new { Genre = g.Key, Count = g.Count() };

##Using Other LINQ Operators##

```
var movies = GetMovies();          
this.TotalMovies.Text = movies.Count.ToString();     
this.LongestRuntime.Text = movies.Max(m => m.RunTime).ToString();     
this.ShortestRuntime.Text = movies.Min(m => m.RunTime).ToString();     
this.AverageRuntime.Text = movies.Average(m => m.RunTime).ToString();}
```

##Making LINQ Joins##

```
public class Genre
{     
    public int ID { get; set; }     
    public string Name { get; set; }
}
```

```
public List<Genre> GetGenres()
{
    return new List<Genre> {
        new Genre { ID=0, Name="Comedy" } ,
        new Genre { ID=1, Name="Drama" } ,
        new Genre { ID=2, Name="Action" }
    };   
}
```


```
var movies = GetMovies();     
var genres = GetGenres();          
var query = from m in movies           
join g in genres on m.Genre equals g.ID           
select new { m.Title, Genre = g.Name } ;
```

##Paging Using LINQ##

```
var movies = GetMovies();     
var genres = GetGenres();          
var query = (from m in movies           
join g in genres on m.Genre equals g.ID           
select new { m.Title, g.Name }).Skip(10).Take(10);
```

##LINQ TO XML##

LINQ to XML enables you to use the same basic LINQ syntax to query XML documents.

LINQ to XML features are contained in their own separate assembly, the System.Xml.Linq assembly.

```
<?xml version="1.0" encoding="utf-8" ?>
<Movies>
  <Movie>
    <Title>Shrek</Title>
    <Director>Andrew Adamson</Director>
    <Genre>0</Genre>
    <ReleaseDate>5/16/2001</ReleaseDate>
    <RunTime>89</RunTime>
  </Movie>
  <Movie>
    <Title>Fletch</Title>
    <Director>Michael Ritchie</Director>
    <Genre>0</Genre>
    <ReleaseDate>5/31/1985</ReleaseDate>
    <RunTime>96</RunTime>
  </Movie>
  <Movie>
    <Title>Casablanca</Title>
    <Director>Michael Curtiz</Director>
    <Genre>1</Genre>
    <ReleaseDate>1/1/1942</ReleaseDate>
    <RunTime>102</RunTime>
  </Movie>
</Movies>
```

```
var query = from m in
XElement.Load(MapPath("Movies.xml")).Elements("Movie")
select m;
```

> *Notice* that in this query, you tell LINQ where to load the XML data from, and from which elements in that document it should retrieve the data, which in this case are all the Movie elements.

the query used in the listing returns a collection of generic XElement objects, not Movie objects as you might have expected. This is because by itself LINQ has no way of identifying what object type each node should be mapped to. Thankfully, you can add a bit of mapping logic to the query to tell it to map each node to a Movie

```
var query = from m in XElement.Load(MapPath("Movies.xml")).Elements("Movie")         
select new Movie {
  Title = (string)m.Element("Title"),
  Director = (string)m.Element("Director"),
  Genre = (int)m.Element("Genre"),
  ReleaseDate = (DateTime)m.Element("ReleaseDate"),
  RunTime = (int)m.Element("RunTime")             
};
```

> *WARNING* Note that the XElement’s Load method attempts to load the entire XML document; therefore, trying to load very large XML files using this method is not a good idea.

##Joining XML Data##

LINQ to XML supports all the same query filtering and grouping operations as LINQ to Objects. It also supports joining data and can actually join data from two different XML documents

```
<?xml version="1.0" encoding="utf-8" ?>
<Genres>
  <Genre>
    <ID>0</ID>
    <Name>Comedy</Name>
  </Genre>
  <Genre>
    <ID>1</ID>
    <Name>Drama</Name>
  </Genre>
  <Genre>
    <ID>2</ID>
    <Name>Action</Name>
  </Genre>
</Genres>
```

```
protected void Page_Load(object sender, EventArgs e)
{
  var query = from m in XElement.Load(MapPath("Movies.xml")).Elements("Movie")
  join g in XElement.Load(MapPath("Genres.xml")).Elements("Genre")
    on (int)m.Element("Genre") equals (int)g.Element("ID")

  select new {
    Title = (string)m.Element("Title"),
    Director = (string)m.Element("Director"),
    Genre = (string)g.Element("Name"),
    ReleaseDate = (DateTime)m.Element("ReleaseDate"),
    RunTime = (int)m.Element("RunTime")
  };
```

##LINQ TO SQL##

LINQ to SQL, as the name implies, enables you to quickly and easily query SQL-based data sources, such as SQL Server 2005 and above.

Framework. Its features are located in the System.Data.Linq assembly.

##Using the O/R Mapper##

LINQ to SQL also includes a basic Object/Relation (O/R) mapper directly in Visual Studio. The O/R mapper enables you to quickly map SQL-based data sources to CLR objects that you can then use LINQ to query.

You use the O/R mapper by adding the new LINQ to SQL Classes file to your website project.

Drag the Movies table from the Server Explorer onto the design surface. Notice that as soon as you drop the database table onto the design surface, it is automatically interrogated to identify its structure.

##Accessing and Querying Data##

###Accessing Data###

```
MoviesDataContext dc = new MoviesDataContext();
```

In this case, you created an instance of the MoviesDataContext, which is the name of the data context class generated by the LINQ to SQL file you added earlier.


> *NOTE* Because the data context class is automatically generated by the LINQ to SQL file, its name will change each time you create a new LINQ to SQL file. The name of this class is determined by appending the name of your LINQ to SQL Class file with the DataContext suffix, so if you named your LINQ to SQL file AdventureWorks.dbml, the data context class would be AdventureWorksDataContext.

###Writing LINQ Queries###

```
MoviesDataContext dc = new MoviesDataContext();
var query = from m in dc.Movies
select m;
```

You can view the SQL that LINQ generated for the query by writing the query to the Visual Studio output window,

```
MoviesDataContext dc = new MoviesDataContext();
var query = from m in dc.Movies
  select m;

System.Diagnostics.Debug.WriteLine(query);
```

As you can see, the SQL generated is standard SQL syntax, and LINQ is quite good at optimizing the queries it generates, even for more complex queries such as the grouping query

```
MoviesDataContext dc = new MoviesDataContext();
var query = from m in dc.Movies
  group m by m.Genre into g
  select new { Genre = g.Key, Count = g.Count() };

System.Diagnostics.Debug.WriteLine(query);
```

> *Note* that SQL to LINQ generates SQL that is optimized for the version of SQL Server you’re using.

LINQ also includes a logging option you can enable by setting the Log property of the data context.

###Using Other SQL Query Methods###

Although LINQ to SQL does an excellent job generating the SQL query syntax, there may be times when it’s better to use other SQL query methods, such as stored procedures or views.

###Using a SQL View###

To use a SQL view with LINQ to SQL, you drag the view onto the LINQ to SQL design surface, just as you would a standard SQL table.

After the view is on the design surface, you can execute queries against it, just as you did the SQL tables,

```
MoviesDataContext dc = new MoviesDataContext();
var query = from m in dc.AllMovies
select m;
System.Diagnostics.Debug.WriteLine(query);
```

###Using Stored Procedures###

Unlike tables or views, which LINQ to SQL exposes as properties, stored procedures can require parameters.

```
CREATE PROCEDURE dbo.GetGenre( @id int )
AS
   SELECT * FROM Genre WHERE ID = @id
```

You can add a stored procedure to your LINQ to SQL designer just as you did the tables and views, by dragging them from the Server Explorer onto the LINQ to SQL Classes design surface.

If you expect your stored procedure to return a collection of data from a table in your database, you should drop the stored procedure onto the LINQ class that represents the types returned by the query.

The stored procedure shown in Listing 10-27 will return all the Genre records that match the provided ID. Therefore, you should drop the GetGenres stored procedure onto the Genres table in the Visual Studio designer.

LINQ to SQL exposes them as method calls.

```
MoviesDataContext dc = new MoviesDataContext();

this.GridView1.DataSource = dc.GetGenre(1);
```

###Making Insert, Update, and Delete Queries through LINQ###

Not only can you use LINQ to SQL to create powerful queries that select data from a data source, but you can also use it to manage insert, update, and delete operations.

LINQ to SQL uses the object class representations of the SQL structures and dynamically generates SQL INSERT, UPDATE, and DELETE commands.

####Inserting Data Using LINQ####

Inserting data using LINQ to SQL is as easy as creating a new instance of the object you want to insert, and adding that to the object collection.

The LINQ classes provide two methods — InsertOnSubmit and InsertAllOnSubmit:

- InsertOnSubmit method accepts a single entity as its method parameter, allowing you to insert a single entity,
- InsertAllOnSubmit method accepts a collection as its method parameter, allowing you to insert an entire collection of data in a single method call.

LINQ to SQL does require the extra step of calling the Data Context object’s SubmitChanges method.

```
MoviesDataContext dc = new MoviesDataContext();
Movie m = new Movie { Title="The Princess Bride", Director="Rob Reiner", Genre=0, ReleaseDate=DateTime.Parse("9/25/1987"), Runtime=98 };
dc.Movies.InsertOnSubmit(m);
dc.SubmitChanges();
```

####Using Stored Procedures to Insert Data####

Of course, you might already have a complex stored procedure written to handle the insertion of data into your database table.

select the entity you want to insert data into, which in this case is the Movies entity. After selecting the entity, open its properties window and locate the Default Methods section,

The Default Methods section contains three properties — Delete, Insert, and Update — which define the behavior LINQ should use when executing these actions on the Movies table.

By default, each property is set to the value UseRuntime, which tells LINQ to dynamically generate SQL statements at run time.

change the Behavior radio button selection from Use Runtime to Customize. Next, select the appropriate stored procedure from the drop-down list below the radio buttons.

When you select the stored procedure, LINQ automatically tries to match the table columns to the stored procedure input parameters. However, you can change these manually, if needed.

Now, when you run the code from Listing 10-31, LINQ will use the stored procedure you configured instead of dynamically generating a SQL INSERT statement.

####Updating Data Using LINQ####

```
MoviesDataContext dc = new MoviesDataContext();
var movie = dc.Movies.Single(m => m.Title == "Fletch");
movie.Genre = 1;
dc.SubmitChanges();
```

####HANDLING DATA CONCURRENCY####

By default, LINQ to SQL also includes and uses optimistic concurrency. That means that if two users retrieve the same record from the database and both try to update it, the first user to submit his or her update to the server wins. If the second user attempts to update the record after the first, LINQ to SQL will detect that the original record has changed and will raise a ChangeConflictException.

####Deleting Data Using LINQ####

The DeleteOnSubmit and DeleteAllOnSubmit

DeleteOnSubmit method removes a single object from the collection

DeleteAllOnSubmit method removes all records from the collection.


```
MoviesDataContext dc = new MoviesDataContext();          

//Select and remove all Action movies     
var query = from m in dc.Movies         
  where m.Genre == 2         
  select m;          

dc.Movies.DeleteAllOnSubmit(query);          

//Select a single movie and remove it     
var movie = dc.Movies.Single(m => m.Title == "Fletch");     
dc.Movies.DeleteOnSubmit(movie);          
dc.SubmitChanges();
```

##LINQ TO ENTITIES##

LINQ to SQL is a great tool to use when you need quick construction of your data access code. It also works very well when you have a relatively well-designed database. However, LINQ to SQL supports only one-to-one mapping between entity classes and database tables.

Entity Framework (EF) is an object-relational mapper that enables .NET developers to work with relational data using domain-specific objects, which makes up what is called the conceptual model.

EF also allows connections to many different data providers. As such, you can mix and match a number of different database vendors, application servers, or protocols to design an aggregated mash-up of objects that are constructed from a variety of tables, sources, services, etc.

LINQ to Entities enables developers to write queries against the Entity Framework conceptual model

While LINQ to SQL queries eventually create SQL that is executed against the backing database, LINQ to Entities converts LINQ queries to command tree queries which are understood by the Entity Framework, executes the queries against the Entity Framework, and returns objects that can be used by both the Entity Framework and LINQ.

Although the code that is executed behind the scenes when you run a LINQ to Entities query is very different than that of a LINQ to SQL query, the LINQ syntax looks the same.

##Creating an Entity Framework Data Model##

In order to work with LINQ to Entities you need to create an EF Data Model.

ADO.NET Entity Data Model item. Select this item and name it MoviesDM.edmx. Choose the Generate from database option in the Entity Data Model Wizard.

After making the changes, save the MovieDM.edmx file. Right-click on the MovieDM.edmx file and select Run Custom Tool to regenerate the entity classes with the changes you made to the properties.

##Accessing Data##

```
MoviesEntities dc = new MoviesEntities();
```

MoviesEntities, which is the name of the data context class generated by LINQ to Entities based on the connection settings name specified in the Entity Data Model Wizard.

##Writing LINQ Queries##

```
MoviesEntities dc = new MoviesEntities();         
var query = from m in dc.EFMovies select m;
```

```
MoviesEntities dc = new MoviesEntities();       
var query = from m in dc.EFMovies         
  where m.Genre == 0         
  orderby m.Director         
  select m;
```

#Chapter 11: Entity Framework# {#Cap11}

Using the Entity Framework (along with LINQ), you now have a lightweight façade that provides a strongly typed interface to the underlying data stores that you are working with.

##CAN WE SPEAK THE SAME LANGUAGE?##

The difficulty is that objects in code and objects in the database are inherently different beasts.

The Entity Framework provides the capability to map your application objects to your relational database schemas.

When you represent your data within the database, you are representing it as a logical model through the database’s relational schema.

However, coding your application is accomplished using a conceptual model.

Having both logical and conceptual layers forced the creation of a mapping layer. The mapping layer allows you to transfer objects from the .NET classes that you are working with in your code to the relational database schemas that you are working with within the database,

This mapping layer is sometimes thought of as a data access layer.

Entity Framework consists of the following:

- A model of your database that is represented in the code of your application 
- A definition of the datastore that you are working with (for example, your data representation within a SQL Server database) 
- A mapping between the two elements

##Development Workflow Options##

Developers like options. You have three options for working with data in the Entity Framework:

Database First Model First Code First; When you already have a database, you can use the Entity Framework to generate a data model for you.

Using Database First, you build your model layer on a design surface from an existing database.

Using Model First, you define your model layer using the designer and then use that to generate your database schema.

In Code First development, you define your model using “plain old classes.” Database creation and persistence is enabled through the use of a convention over configuration approach, so no explicit configuration is necessary.

##The Entity Data Model##

The Entity Data Model (EDM) is an abstract conceptual model of data as you want to represent it in your code.

This first conceptual layer is created using the Conceptual Schema Definition Language (CSDL), which is an XML definition of your objects.

The logical layer is defined using the Store Schema Definition Language (SSDL).

This includes a definition of the tables, their relations, and their constraints.

The last piece of the Entity Data Model is the mapping layer. This layer maps the CSDL and the SSDL instances using the Mapping Specification Language (MSL).

The three layers — the conceptual model, the logical model, and the mapping between them — are stored in XML in an .edmx file

##CREATING YOUR FIRST ENTITY DATA MODEL##

To create the App_Data folder where you will add the database file, right-click on the project and select Add Add ASP.NET Folder App_Data.

To add this database, right-click on the App_Data folder from the Solution Explorer and select the option to add an existing item.

Connection string:

```
metadata=res://*/EmployeeDM.csdl|res://*/EmployeeDM.ssdl|res://*/EmployeeDM.msl;
   provider=System.Data.SqlClient;
   provider connection string="Data Source=(LocalDB)\v11.0;
   attachdbfilename=|DataDirectory|\AdventureWorks2012_Data.mdf;
   integrated security=True; MultipleActiveResultSets=True; App=EntityFramework "
```

The designer uses T4 templates to automatically generate a DbContext file and files for each of the entities you selected to be generated from the database.

##Using the Entity Framework Designer##

Visual Studio also provides you with some views to work with the Entity Framework; the Model Browser, the Entity Data Model Mapping Details

##Building an ASP.NET Web Form Using Your EDM##

```
<%@ Page Language="C#" AutoEventWireup="true"
  CodeBehind="BasicGrid.aspx.cs" Inherits="AspnetEntityFx.BasicGrid" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" > <head runat="server">
<title>My EDM</title> </head> <body>
  <form id="form1" runat="server">
    <div>
      <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </div>
  </form>
</body>
</html>
```

```
using System;
using System.Linq;
namespace AspnetEntityFx
{
  public partial class BasicGrid : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      AdventureWorks2012_DataEntities adventureWorks2012_DataEntities = new AdventureWorks2012_DataEntities();
      
      var query = from emp in
      adventureWorks2012_DataEntities.Employees
      select emp;

      GridView1.DataSource = query.ToList();
      GridView1.DataBind();
   }
  }
}
```

##UNDERSTANDING RELATIONSHIPS##

###One-to-One and One-to-Many Relationships###

A one-to-one relationship is a construct in which one table maps to one type within your Entity Data Model. This is also called a Table per Type model (TPT).

```
AdventureWorks2012_DataEntities adventureWorks2012_DataEntities = new AdventureWorks2012_DataEntities();
foreach (var employee in adventureWorks2012_DataEntities.Employees)
{
  ListItem li = new ListItem();
  li.Text = employee.BusinessEntityID + " ";

  foreach (var pay in employee.EmployeePayHistories)
  {
    li.Text += "Pay Rate: " + pay.Rate + " ";
  }

  BulletedList1.Items.Add(li);
  }
}
```


At first, the Employees objects are accessed and none of the other objects are actually loaded. The first time the EmployeePayHistory object is accessed, it will be automatically loaded if it has not already been.

###Many-to-One and Many-to-Many Relationships###

In addition to the one-to-one and the one-to-many relationships, the Entity Framework supports many-to-one and many-to-many relationships. In these relationships, the Entity Framework will perform the appropriate table joins for you when you query the database.

```
AdventureWorks2012_DataEntities1 adventureWorks2012_DataEntities = new AdventureWorks2012_DataEntities1();

var query = from o in adventureWorks2012_DataEntities.SalesOrderHeaders
  where o.SalesOrderDetails.Any(Quantity => Quantity.OrderQty > 5)
  select new {o.PurchaseOrderNumber, o.Customer.CustomerID, o.SalesPersonID};

GridView1.DataSource = query.ToList();
GridView1.DataBind();
```

In this case, you are working with all the items in the SalesOrderHeader table where the quantity of the order is more than five. From the items selected, the fields are pulled for the dynamic object from across a couple of tables.

###PERFORMING INHERITANCE WITHIN THE EDM###

You can perform inheritance when constructing your Entity Data Model just as easily as you can when dealing with your objects within the CLR.

Inheritance gives you the capability to work with and look for specialized objects that you determine. For an example of this feature, in this section you modify the Vendor object so that you can build a query that will look for inactive vendors by object reference rather than through value interpretation.

Create a new Entity Data Model (Vendor.edmx file) that contains only the Vendor table (Purchasing section).

As you can see from this figure, the ActiveFlag property is of type bit, which means it is either a zero or a one representing a False or True,

For this example, you will build a specialized type that is a reference to an inactive vendor so that you can differentiate between active and inactive.

Add Entity from the provided menu.

From this window, provide an entity name of InactiveVendor and have it inherit from a base type of Vendor.

Delete the ActiveFlag scalar property from the Vendor entity object, because you will not need

Highlight the Vendor object. Mapping Details view within Visual Studio. From this view, add a condition of ActiveFlag being equal to 1,

Now you set up the InactiveVendor object.

```
AdventureWorks2012_DataEntities3 adventureWorks2012_DataEntities = new AdventureWorks2012_DataEntities3();
var query = from v in adventureWorks2012_DataEntities.Vendors
  .OfType<InactiveVendor>()
  select v;

GridView1.DataSource = query.ToList();
GridView1.DataBind();
```

You can now use the OfType extension method to look for objects of type InactiveVendor.

##USING THE ENTITYDATASOURCE CONTROL##

The EntityDataSource control makes working with your Entity Data Model from your ASP.NET applications easy. The control will handle the LINQ work necessary to bind to any of your controls.

```
<%@ Page Language="C#" AutoEventWireup="true"
  CodeBehind="EntityDataSource.aspx.cs" Inherits="AspnetEntityFx. EntityDataSource" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
  <title> </title>
</head>
<body>
  <form id="form1" runat="server">
    <asp:GridView ID="GridView1" runat="server"> </asp:GridView>
    <br />
    <asp:EntityDataSource ID="EntityDataSource1" runat="server"> </asp:EntityDataSource>
  </form>
</body>
</html>
```

Configuring the Data Source Control; You should also tie the GridView1 control to the EntityDataSource1 control by assigning the DataSourceID property to this control.

```
<%@ Page Language="C#" AutoEventWireup="true"
       CodeBehind="EntityDataSource.aspx.cs" Inherits="AspnetEntityFx. EntityDataSource" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
  <title> </title>
</head>
<body>
  <form id="form1" runat="server">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True"
      DataSourceID="EntityDataSource1">
    </asp:GridView>
    <asp:EntityDataSource ID="EntityDataSource1" runat="server"
      ConnectionString="name=AdventureWorks2012_DataEntities1NorthwindEntities"
      DefaultContainerName="AdventureWorks2012_DataEntities1NorthwindEntities"
      EnableDelete="True" EnableFlattening="False"
      EnableInsert="True"
      EnableUpdate="True" EntitySetName="Customers">
    </asp:EntityDataSource>
  </form>
  </body>
</html>
```

##ENTITY FRAMEWORK CODE FIRST##

Code First uses a convention-over-configuration approach, allowing you to focus on defining your models

These classes can then be mapped to an existing database or be used to generate a schema that can be used to generate a new database.

If any additional configuration is needed, such as more advanced mapping, you can use data annotations or a fluent API to provide the additional details.

Code First Migrations allow you to express a database schema migration in code. Each time a change is made to your model that you wish to publish to your database, you create a migration.

Each migration is a class representing the changes made to the model since the last migration.

###Creating a Code First Model###

The basic page that will use your Code First model

```
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CodeFirst.aspx.cs" Inherits="AspnetEntityFX.CodeFirst" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Code First Model</title>
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </div>
  </form>
</body>
</html>
```

In the ASP.NET code-behind page you are going to: Create your initial model, which will consist of two classes. Then you will create a derived context. The context is a class that represents the session to the database. This is what allows you to query and save data. For the sake of this example, these classes will simply be added after the Page class in the same file. Usually, each of these classes will reside in their own file. The context is derived from System.Data.Entity.DbContext. For each class in the model, you will create a DbSet. This will tell Entity Framework which entities will be mapped to the database. Next, you will add some code to the Page_Load method to add some data to the database and display that data.

```
using System;   
using System.Collections.Generic;   
using System.Data.Entity;   
using System.Linq;     

namespace AspnetEntityFX   
{
  public partial class CodeFirst : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      using (var context = new TeamContext())
      {
        var team = new Team { TeamName = "Team 1" };
        context.Teams.Add(team);
        team = new Team { TeamName = "Team 2" };
        context.Teams.Add(team);
        team = new Team { TeamName = "Team 3" };
 
        context.Teams.Add(team);
        context.SaveChanges();

        var query = from t in context.Teams
        select t;
                 
        GridView1.DataSource = query.ToList();
        GridView1.DataBind();
      }
    }
  }

  public class Team
  {
    public int TeamId { get; set; }
    public string TeamName { get; set; }
  }

  public class Player
  {
    public int PlayerId { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
  }

  public class TeamContext : DbContext
  {
    public DbSet<Team> Teams { get; set; }         
    public DbSet<Player> Players { get; set; }
  }
}
```

That is all the code that is necessary to have Entity Framework create a database based on your model. Notice that you don’t have to create a connection to a database or even reference a connection string. That is due to the convention-over-configuration approach of Code First.

In order to tell Entity Framework to map your model classes to the database, you create a DbSet<EntityType> for each model class.   public DbSet<Team> Teams { get; set; }; public DbSet<Player> Players { get; set; };

In order to use your new model, you will add some data to the database that will be created for you. You simply need to create a new instance of your class, add it to the Teams DbSet, and tell the database context to persist the changes to the database.   var team = new Team { TeamName = "Test 3" };   context.Teams.Add(team);   context.SaveChanges();

Now you can query the data using the database context just as you did with the Entity Data Model you created using the Database First designer workflow.   var query = from t in context.Teams select t

Once you have the IQueryable returned from the LINQ query, you bind the data to the GridView control.   GridView1.DataSource = query.ToList();   GridView1.DataBind();

###Convention over Configuration###

In the previous example, a database was created for you by DbContext based on a default convention.

The database is created the first time you do anything that causes a connection to the database to be established.

Regardless of the database used, the database is named using the fully qualified name of the derived context. In this example, the database name is AspnetEntityFX.TeamContext.

The DbContext determined what classes needed to be included in the model based on the DbSet properties you defined. Code First then used a set of default conventions to determine table names, column names, primary keys, data types, and other parts of the database schema. Note that these default conventions can be modified using configuration entries.

##Relationships in Code First##

The Entity Framework uses navigation properties to represent a relationship between two entity types.

Navigation properties can manage relationships in both directions. If the relationship is one-to-one, a property is created referencing the related type. If the relationship is one-to-many or many-to-one, the property is a collection of the type involved in the relationship. Properties can also be used to represent foreign keys on a dependent object using the default Code First conventions.

```
public class Team
{
  public int TeamId { get; set; }
  public string TeamName { get; set; }
  public virtual List<Player> Players { get; set; }
}

public class Player
{
  public int PlayerId { get; set; }
  public string FirstName { get; set; }
  public string LastName { get; set; }
  public int TeamId { get; set; }
  public virtual Team Team { get; set; }
}
```

A relationship was created from a Team to a collection of related Player entities.   

```
public virtual List<Player> Players { get; set; }
```

By making the Players property virtual, you are instructing the DbContext to lazy load the Players collection.

A relationship was also created from a player back to a team.

Another property was added to instruct Code First to create a foreign key to the Team database table when the database schema is generated.

```
public int TeamId { get; set; }   
public virtual Team Team { get; set; }
```

##Code First Migrations##

Code First Migrations were introduced in Entity Framework 4.3.1.

Prior to that, modifying your Code First model meant the database would be dropped and re-created.

Code First models, migrations are also built using code. However, you can use a few Package Manager Console commands to build the migrations for you.

Open the Package Manager Console by clicking on Tools Library Package Manager Package Manager Console from the Visual Studio menu. At the console prompt, run the command Enable-Migrations. If you have been following along with the other examples in this chapter, you will have multiple derived contexts in the project. Therefore, the Enable-Migrations command responds with a message that it cannot determine which context you would like to enable migrations for. You must tell the command which context you want to enable migrations for. In order to do this, run the command Enable-Migrations -ContextTypeName AspnetEntityFX.TeamContext.

After the command completes, a new Migrations folder is added to your project and two new files have been placed in the folder.

The first file, Configuration.cs, contains the configuration settings Migrations will use for the derived context. The second file is the initial migration file. It contains the changes that have already been applied to the database. The migration filename includes a timestamp used for ordering the migrations.

Now you need to create a new migration that includes the changes you made to the model in the previous section.

In the Package Manager Console, run the command Add-Migration TeamPlayerRelationship.

The contents of the new migration file

```
namespace AspnetEntityFX.Migrations
{
  using System;     
using System.Data.Entity.Migrations;

public partial class TeamPlayerRelationship : DbMigration
{
  public override void Up()
  {
    AddColumn("dbo.Players", "TeamId", c => c.Int(nullable: false));             
    AddForeignKey("dbo.Players", "TeamId", "dbo.Teams", "TeamId", cascadeDelete: true);
    CreateIndex("dbo.Players", "TeamId");
  }                  

  public override void Down()
  {
    DropIndex("dbo.Players", new[] { "TeamId" });
    DropForeignKey("dbo.Players", "TeamId", "dbo.Teams");
    DropColumn("dbo.Players", "TeamId");}
  }
}
```

The add migration command only creates a migration file containing the updates to the database schema. It does not apply those updates automatically.

Run the Update-Database command in the Package Manager Console.

#Chapter 12: Dynamic Data# {#Cap12}

ASP.NET offers a feature that enables you to dynamically create data-driven web applications.

ASP.NET Dynamic Data is more than purely a code generator,

This feature allows you to quickly and easily create data entry or applications that allow your end users to work with and view the backend database.

You can also easily integrate Dynamic Data into your applications and build a rich UI layer that’s driven by model binding and data annotation attributes.

##DYNAMIC DATA FEATURES##

ASP.NET Dynamic Data’s capabilities were introduced with the .NET Framework 3.5 SP1. They have since been enhanced to work with Entity Framework in .NET Framework 4.5.

create a new Dynamic Data Entities Web Site project.

will create a base application that is not connected to any database or object model from the start. It’s your job to make these connections.

Looking at the Core Files Created in the Default Application

The items that are generated for you and what is presented here in the Visual Studio Solution Explorer are generally referred to as scaffolding.

Even though you will find a lot of pre-generated code in your Solution Explorer, you are not even required to use this code to work with ASP.NET Dynamic Data. In fact, you can even add ASP.NET Dynamic Data to preexisting applications and you don’t have to start from the ASP.NET Dynamic Data project template.

##Application Features##

folder called DynamicData.

This folder contains the pre-generated ASP.NET application that enables you to work with your database through a browser.

The goal of this application is to enable you to work with your database through the entire CRUD process (Create, Read, Update, and Delete).

Expanding the DynamicData folder, you find the following folders:

- Content 
- CustomPages 
- EntityTemplates 
- FieldTemplates 
- Filters 
- PageTemplates

In addition to these folders, you will find a web.config file that is specific to this application.

- The Content folder in this part of the application includes a user control that is used in the Page Templates, as well as the underlying images that are used by the style sheet of the application.
- The CustomPages folder is a separate folder that allows you to put any custom pages that you might include in the data-driven web application. When you create an application from scratch, you will not find any file in this folder. It is intentionally blank.
- The EntityTemplates folder makes getting the layout you want quite easy, thereby not requiring you to build a custom page. Initially, there is a Default.ascx (user control), and the edit and insert versions of this control are found in the folder.
- The FieldTemplates folder is interesting because it has some of the more granular aspects of the application. The entire application is designed to work off a database, but it really does not have any idea what type of database it is going to be working from. The FieldTemplates folder is a way that the application can present any of the underlying data types that are coming from the database.
- The Filters folder is used to create drop-down menus for Booleans (true/false values), foreign keys, and enumerations. These menus enable the end user to filter tables based upon keys within the database.
- The PageTemplates folder contains the core pages that you use to bring the application together. Notice that pages exist for many of the core constructs that you will use in representing your tables in the application. 

The PageTemplates folder includes the following pages:

- Details.aspx 
- Edit.aspx 
- Insert.aspx 
- List.aspx 
- ListDetails.aspx

- List.aspx page for the tables in your connected database.
- Details.aspx pages when you are examining a single row from the table,
- ListDetails.aspx page for examining master details views of the table and row relationships.
- Edit.aspx and Insert.aspx pages, in turn, for the types of operations that they describe.
- Global.asax file has the definition of all the routes used by the Dynamic Data application.

You can use Data Annotations to customize the column names that will be displayed on the UI and also use them to add validation to the column names being inputted by the users.

##Running the Application##

Once the DynamicDataWebSite is created, you need to incorporate a database that you are able to work with.

The next step is to establish a defined entity data model layer that will work with the underlying database.

You can register the NorthwindEntities object in the overall solution. NorthwindEntities is the data model that was built using the LINQ to Entities. You register this NorthwindEntities context in the Global.asax file,

```
DefaultModel.RegisterContext(typeof(NORTHWNDModel.NORTHWNDEntities), new ContextConfiguration() { ScaffoldAllTables = true });
```

##Results of the Application##

As you run the application, notice that the first page allows you to see all the tables that you made a part of your data model,

Clicking a table name (which is a hyperlink in the application) provides the contents of the table.

Table view is nicely styled and includes the ability to edit, delete, or view the details of each row

Where a one-to-many relationship exists, you can drill down deeper into

The final aspect to understand about this application is that because it is an ASP.NET 4 application, it makes proper use of AJAX.

##Adding Dynamic Data to an Existing Application##

When ASP.NET Dynamic Data was introduced with the .NET Framework 3.5 SP1, it took a bit of setup in order to get dynamic aspects on your pages. With the release of the .NET Framework 4.5, it is a lot easier to add dynamic data functionality to portions to your Web Forms pages.

This is now possible by using the new DynamicDataManager server control or EnablingDynamicData in the Page_Init call.

```
<%@ Page Language="C#" %>
<script runat="server">
protected void Page_Init()
{
GridView1.EnableDynamicData(typeof(Customer));
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>DynamicDataManager Example</title>
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <asp:GridView ID="GridView1" runat="server" AllowPaging="True"
        DataSourceID="EntityDataSource1"
        AutoGenerateColumns="False" DataKeyNames="RegionID">
        <Columns>
          <asp:BoundField DataField="RegionID" HeaderText="RegionID" ReadOnly="True"
            SortExpression="RegionID"></asp:BoundField>
          <asp:BoundField DataField="RegionDescription"
            HeaderText="RegionDescription"
            SortExpression="RegionDescription">
          </asp:BoundField>
        </Columns>
      </asp:GridView>
      <asp:EntityDataSource ID="EntityDataSource1" runat="server"
        EntitySetName="Regions"
        ConnectionString="name=NORTHWNDEntities"
        DefaultContainerName="NORTHWNDEntities"
        EnableDelete="True" EnableFlattening="False" EnableInsert="True"
        EnableUpdate="True">
      </asp:EntityDataSource>
    </div>
  </form>
</body>
</html>
```

##UNDERSTANDING MODEL BINDING##

To use model binding with Dynamic Data, you just have to use model binding with the data-bound controls.

###Attribute Driven UI###

This section explains how you can leverage the Field and Entity Templates along with Data Annotation attributes to customize the look of a particular column or table.

Table 12-1 lists some of the common attributes that you can use to customize the UI. You can find all these attributes in System.ComponentModel.DataAnnotations.dll.
| Attribute | Description |
|--|--||
|DataType| Specifies the type that should be associated with this column|
|Display| Specifies how the columns are displayed by Dynamic Data, such as the name of the column |
|DisplayFormat| Specifies how data fields are formatted by ASP.NET| 
|Dynamic| Data Enum Enables a .NET Framework enumeration to be mapped to a data column |
|ScaffoldColumn| Specifies whether the column should be scaffolded by the system |
|UIHint| Specifies the field template that Dynamic Data uses to display a data field|

###Field Templates###

The Field Templates folder contains user controls that map to a particular type of column.

For example, DateTime.ascx is used by the Dynamic Data system to display a column of type DateTime.

you can change the column name that will display the LastName column using the Display attribute.

```
[Display(Name="Last Part of Name")]
public string LastName { get; set; }
```

Now assume that you want to change the look-and-feel of the edit/insert view of the LastName column.

You can do this by creating a new Dynamic Data Field Template user control and using it to change the UI.

and choose the Dynamic Data field item template.

```
[UIHint("LastName")]
public string LastName { get; set; }
```

###Entity Templates###

Entity templates are user controls that Dynamic Data uses to show all the columns in a table.

```
<asp:EntityTemplate runat="server" ID="EntityTemplate1">
  <ItemTemplate>
    <tr class="td">
      <td class="DDLightHeader">
        <asp:Label runat="server" OnInit="Label_Init" OnPreRender="Label_PreRender" />
      </td>
      <td>
        <asp:DynamicControl runat="server" ID="DynamicControl" Mode="Insert" OnInit="DynamicControl_Init" />
      </td>
    </tr>
  </ItemTemplate>
</asp:EntityTemplate>
```

FormView control using EntityTemplate for inserting

```
<asp:FormView runat="server" ID="FormView1" DefaultMode="Insert"  ItemType="Customer" InsertMethod="InsertCustomer">
  <InsertItemTemplate>
    <table>
      <asp:DynamicEntity ID="DynamicEntity1" runat="server" Mode="Insert" />
      <tr>
        <td>
          <asp:LinkButton ID="Insert" runat="server" CommandName="Insert" Text="Insert" />
          <asp:LinkButton ID="Cancel" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="false" />
        </td>
      </tr>
    </table>
  </InsertItemTemplate>
</asp:FormView>
```

You can share the entity templates to create a common look-and-feel for all the tables in the database.

If you want to customize the view for a particular table, you can create a custom entity template for that particular table.

by creating a subfolder under DynamicData\EntityTemplates.

The subfolder should be named after the name of the table, Customer in this case.

###Attribute Driven Validation##

Attribute driven validation is a way to add some validation logic to your application by using Data Annotations.

|ATTRIBUTE NAME| DESCRIPTION|
| Key| Denotes one or more properties that uniquely identify an entity |
|Range| Specifies the numeric range constraints for the value of a data field |
|RegularExpression| Specifies that a data field value in ASP.NET Dynamic Data must match the specified regular expression|
| Required| Specifies that a data field value is required |
|StringLength| Specifies the minimum and maximum length of characters that are allowed in a data field|

###Basic Validation###

When model binding binds the data, the model binding system uses Dynamic Data to handle validation for the columns in the table.

This means that the application gets client-side as well as server-side validation for the columns and any validation errors can be viewed in the ValidationSummary control.

###Data Annotations###

```
[RegularExpression("a*")]
public string LastName { get; set; }
```
