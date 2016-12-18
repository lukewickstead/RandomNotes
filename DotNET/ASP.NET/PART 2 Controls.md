
#Professional ASP.NET 4.5 - Part II - Controls#

- [Chapter 4: ASP.NET Server Controls and Client-Side Scripts](#Cap4)
- [Chapter 5: ASP.NET Web Server Controls](#Cap5)
- [Chapter 6: Validation and Server](#Cap6)
- [Chapter 7: User and Server Controls](#Cap7)

#Chapter 4: ASP.NET Server Controls and Client-Side Scripts# {#Cap4}

##ASP.NET SERVER CONTROLS##

When a request comes in, ASP.NET examines the request to see which browser type is making the request, as well as the version of the browser, and then it produces HTML output specific to that browser. This process is accomplished by processing a User Agent header retrieved from the HTTP request to sniff the browser.

##Types of Server Controls##

ASP.NET provides two distinct types of server controls — HTML server controls and web server controls.

| Control Type | When To Use |
|--|--|
|HTML Server |When converting traditional ASP 3.0 web pages to ASP.NET web pages and speed of completion is a concern. It is a lot easier to change your HTML elements to HTML server controls than it is to change them to web server controls. When you prefer a more HTML-type programming model. When you want to explicitly control the code that is generated for the browser. Using ASP.NET MVC for this (covered in Chapter 34) might be a better answer.|
|Web Server| When you require a richer set of functionality to perform complicated page requirements. When you are developing web pages that will be viewed by a multitude of browser types and that require different code based upon these types. When you prefer a more Visual Basic–type programming model that is based on the use of controls and control properties.|

##CSS Rendering in ASP.NET 5.4##

In ASP.NET 3.5 and earlier, the rendered HTML from the ASP.NET server controls that you used weren’t always compliant with the latest HTML standards.

As an example, in ASP.NET 3.5, you could set the Enabled property of the server control to False.

```
<span id="Label1" disabled="disabled">Hello there!</span>
```

In ASP.NET 4 and ASP.NET 4.5, the <pages> element within the web.config file instructs ASP.NET what version style to use when rendering controls. The default value is 4.0 as shown in the following code:

```
<pages controlRenderingCompatibilityVersion="4.0" />
```

If this value is set to 4.0, ASP.NET will disable the control using CSS correctly as shown here:
```
<span id="Label1" class="aspNetDisabled">Hello there!</span>
```

**NOTE** The value of the controlRenderingCompatibilityVersion attribute can be any value formatted with a single digit and a single decimal value. Any value less than 4.0 renders the disabled attribute. A value of 4.0 or greater renders the class attribute.

##HTML SERVER CONTROLS##

ASP.NET enables you to take HTML elements and, with relatively little work on your part, turn them into server-side controls. Afterward, you can use them to control the behavior and actions of elements implemented in your ASP.NET pages.

```
<input id="Button1" type="button" value="button" />
```

In this state, the Button control is not a server-side control. It is simply an HTML element and nothing more.

```
<input id="Button1" type="button" value="button" runat="server"/>
```

You can work with the selected element on the server side as you would work with any of the web server controls.

```
<input id="Button1" type="button" value="Submit" runat="server"                onserverclick="Button1_ServerClick" />
```

If you are working with HTML elements as server controls, you must include an id attribute so that the server control can be identified in the server-side code.

##Looking at the HtmlControl Base Class##

All the HTML server controls use a class that is derived from the HtmlControl base class (fully qualified as System.Web.UI.HtmlControls.HtmlControl).

##Looking at the HtmlContainerControl Class##

The HtmlControl base class is used for those HTML classes that are focused on HTML elements that can be contained within a single node. For instance, the img, input, and link elements work from classes derived from the HtmlControl class.

Other HTML elements, such as a, form, and select, require an opening and closing set of tags. These elements use classes that are derived from the HtmlContainerControl class, a class specifically designed to work with HTML elements that require a closing tag.

- InnerHtml — Enables you to specify content that can include HTML elements to be placed between the opening and closing tags of the specified control
- InnerText — Enables you to specify raw text to be placed between the opening and closing tags of the specified control

##Looking at All of the HTML Classes##

|CLASS| HTML ELEMENT RENDERED HtmlAnchor |
|--|--|
|HtmlAnchor | a |
|HtmlArea | area |
 etc

You gain access to one of these classes when you convert an HTML element to an HTML server control with the runat server and id attributes:

```
runat="server", id="MyId"
```
This gives you access to the class in the code behdind:

```
Title1.Text = DateTime.Now.ToString()
```
The HtmlGenericControl class provides server-side access to any HTML element you want which does not explicitly have a HTML class.

##Using the HtmlGenericControl Class##

Using the HtmlGenericControl class, you can get server-side access to the p, span, or other elements that would otherwise be unreachable.

Use the normal html element along with runat server and id elements, in the code behind the element is accessed via the HtmlGenericControl class

```
Progress1.Attributes["max"] = "100";
```

You can assign values to the attributes of an HTML element using the HtmlGenericControl class’s Attributes property, specifying

By using the HtmlGenericControl class, along with the other HTML classes, you can manipulate every element of your ASP.NET pages from your server-side code.

##IDENTIFYING ASP.NET SERVER CONTROLS##

When you create your ASP.NET pages with a series of controls, many of the controls are nested and many are even dynamically laid out by ASP.NET itself. For instance, when you are working with user controls, the GridView, ListView, Repeater, and more, ASP.NET is constructing a complicated control tree that is rendered to the page.

When this occurs, ASP.NET provides these dynamic controls with IDs. When it does, IDs such as GridView1$ctl02$ctl00 are generated.

Because these IDs are unpredictable, the ID generation makes it difficult to work with the control from client-side code.

To help with this situation, ASP.NET 4.5 includes the ability to control the IDs that are used for your controls.

ASP.NET 4.5 includes the ability to control these assignments through the use of the ClientIDMode attribute.

The possible values of the ClientIDMode attribute include AutoID, Inherit, Predictable, and Static.

```
<muc:MyUserControl ID="MyUserControl1" runat="server" ClientIDMode="AutoID" />
```

- If you use Inherit, the same values would be populated as if you used AutoID. The reason is that it uses the containing control, the page, or the application in building the control.
- The Inherit value is the default value for all controls.
- Predictable is generally used for data-bound controls that have a nesting of other controls (for example, the Repeater control). When used with a ClientIDRowSuffix property value, it appends this value rather than increments with a number (for example, ctrl1, ctrl2).
- A value of Static gives you the name of the control you have assigned. 
	- name: MyUserControl1$TextBox1 MyUserControl1$Button1 
	- id: TextBox1 Button1

##MANIPULATING PAGES AND SERVER CONTROLS WITH JAVASCRIPT##

The first is to apply JavaScript directly to the controls on your ASP.NET pages.

```
<body onload="javascript:document.forms[0]['TextBox1'].value=Date();">
```

ASP.NET uses the Page.ClientScript property to register and place JavaScript functions on your ASP.NET pages.

More methods and properties than just these three are available through the ClientScript object (which references an instance of System.Web.UI.ClientScriptManager),

**NOTE** The Page.RegisterStartupScript and the Page.RegisterClientScriptBlock methods from the .NET Framework 1.0/1.1 are now considered obsolete. Both of these possibilities for registering scripts required a key/script set of parameters. Because two separate methods were involved, there was a possibility that some key-name collisions would occur. The Page.ClientScript property is meant to bring all the script registrations under one umbrella, making your code less error–prone.

##Using Page.ClientScript.RegisterClientScriptBlock##

```
protected void Page_Load(object sender, EventArgs e) 
{
    string myScript = @"function AlertHello() { alert('Hello ASP.NET'); }";
    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyScript", myScript, true);
    }
```

The two possible constructions of the 
- RegisterClientScriptBlock method are the following: RegisterClientScriptBlock (type, key, script) 
- RegisterClientScriptBlock (type, key, script, script tag specification)

##Using Page.ClientScript.RegisterStartupScript##

The RegisterStartupScript method is not that different from the RegisterClientScriptBlock method. The big difference is that the RegisterStartupScript places the script at the bottom of the ASP.NET page instead of at the top.

If you have a bit of JavaScript that is working with one of the controls on your page, in most cases you want to use the RegisterStartupScript method instead of RegisterClientScriptBlock.

##Using Page.ClientScript.RegisterClientScriptInclude##

Many developers place their JavaScript inside a .js file, which is considered a best practice because it makes it very easy to make global JavaScript changes to the application.

```
string myScript = "myJavaScriptCode.js";
Page.ClientScript.RegisterClientScriptInclude("myKey", myScript);
```

Which produces:

```
<script src="myJavaScriptCode.js" type="text/javascript"></script>
```

#Chapter 5: ASP.NET Web Server Controls# {#Cap5}

HTML server controls enable you to manipulate HTML elements from your server-side code. On the other hand, web server controls are powerful because they are not explicitly tied to specific HTML elements; rather, they are more closely aligned to the specific functionality that you want to generate.

##AN OVERVIEW OF WEB SERVER CONTROLS##


The output, of course, is based on the capabilities of the container that is making the request. This means that each requestor might see a different HTML output because each is requesting the same page with a different browser type or version. ASP.NET takes care of all the browser detection and the work associated with it on your behalf.

By default, all web server controls provided by ASP.NET use an asp prefix at the beginning of the control declaration.

```
<asp:Label ID="Label1" runat="server" Text="Hello World"></asp:Label>
```

##THE LABEL SERVER CONTROL##

The Label server control is used to display text in the browser.

```
<asp:Label ID="Label1" runat="server" Text="Hello World" />
```
The label text can be put between the opening and closing node
```
<asp:Label ID="Label1" runat="server">Hello World</asp:Label>
```
Set from the code behind:

```
Label1.Text = "Hello ASP.NET!";
```
Good practice to underline the hot key letter
```
<asp:Label ID="Label1" runat="server" AccessKey="N" AssociatedControlID="Textbox1">User<u>n</u>ame
</asp:Label>
```

```
<asp:Label ID="Label2" runat="server" AccessKey="P" AssociatedControlID="Textbox2">
```

Hot keys are assigned with the AccessKey attribute.

##THE LITERAL SERVER CONTROL##

The Literal server control works very much like the Label server control does. This control was always used in the past for text that you wanted to push out to the browser but keep unchanged in the process (a literal state).

Label control alters the output by placing <span> elements around the text as shown:

<span id="Label1">Here is some text</span>

Literal does not output any additional markup unless it is placed within the text along with a mode of encode.

<asp:Literal ID="Literal1" runat="server" Mode="Encode"  Text="<strong>Here is some text</strong>"></asp:Literal>

Adding Mode="Encode" encodes the output before it is received by the consuming application: 

```
<b>Label</b>
```

This is ideal if you want to display code in your application. Other values for the Mode attribute include Transform and PassThrough.

For instance, not all devices accept HTML elements, so, if the value of the Mode attribute is set to Transform, these elements are removed from the string before it is sent to the consuming application.

A value of PassThrough for the Mode property means that the text is sent to the consuming application without any changes being made to the string.

##THE TEXTBOX SERVER CONTROL##

```
<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
```

The TextBox control can allow end users to input their passwords into a form.

```
<asp:TextBox ID="TextBox1" runat="server" TextMode="Password"></asp:TextBox>
```

The TextBox server control can be used as a multiline textbox. The code for accomplishing this task is as follows:

```
<asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Width="300px"   Height="150px"></asp:TextBox>
```

The Width and Height attributes set the size of the text area, but these are optional attributes

The Wrap attribute. When set to True (which is the default), the text entered into the text area wraps to the next line if needed. When set to False, the end user can type continuously in a single line until she presses the Enter key,

###Using the Focus() Method###

The Focus() method enables you to dynamically place the end user’s cursor in an appointed form element

```
FirstNameTextBox.Focus();
```

###Using AutoPostBack###

ASP.NET pages work in an event-driven way. When an action on a web page triggers an event, server-side code is initiated.

If you double-click the button in Design view of Visual Studio 2012, you can see the code page with the structure of the Button1_Click event already in place. This is because OnClick is the most common event of the Button control.

Double-clicking the TextBox control constructs an OnTextChanged event.

```
ID="TextBox1" runat="server" AutoPostBack="True"                 OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
```

```
protected void TextBox1_TextChanged(object sender, EventArgs e)
{
    Response.Write("OnTextChanged event triggered");
}
```

To make this work, you must add the AutoPostBack attribute to the TextBox control and set it to True.

For the AutoPostBack feature to work, the browser viewing the page must support ECMAScript.

###Using AutoCompleteType#
##

One of the great capabilities for any Web Form is smart auto-completion.

Enable with the AutoCompleteType attribute.

You have to help the textboxes on your form to recognize the type of information that they should be looking for.

Look at the possible values of the AutoCompleteType attribute:

Disabled Company HomeFax BusinessCity DisplayName Homepage BusinessCountryRegion HomeState HomePhone BusinessFax HomeStreetAddress JobTitle BusinessPhone HomeZipCode LastName BusinessState Email MiddleName BusinessStreetAddress Enabled Notes BusinessUrl FirstName Office BusinessZipCode Gender Pager Cellular HomeCity Search Department HomeCountryRegion

```
<asp:TextBox ID="TextBox1" runat="server"         AutoCompleteType="HomeStreetAddress"></asp:TextBox>
```

Which outputs:

```
<input name="TextBox1" type="text" vcard_name="vCard.Home.StreetAddress" id="TextBox1" />
```

##THE BUTTON SERVER CONTROL##

Buttons post back and cause all validators to be run. This can be disabled with the CausesValidation Property

The CommandName Property can be used to tag the buttons so that the code can make logical decisions based on which button on the form was clicked.

```
<asp:Button ID="Button1" runat="server" OnCommand="Button_Command" CommandName="DoSomething1" Text="Button 1" /> <asp:Button ID="Button2" runat="server" OnCommand="Button_Command" CommandName="DoSomething2" Text="Button 2" />
```

The first thing to notice is what is not present — any attribute mention of an OnClick event. Instead, you use the OnCommand event, which points to an event called Button_Command.

```
protected void Button_Command(object sender,      System.Web.UI.WebControls.CommandEventArgs e)
{
    switch (e.CommandName)
    {
        case ("DoSomething1"):
            Response.Write("Button 1 was selected");
            break;
        case ("DoSomething2"):             
            Response.Write("Button 2 was selected");
            break;
        }
    }
}
```

Notice that this method uses System.Web.UI.WebControls.CommandEventArgs instead of the typical System.EventArgs. This gives you access to the member CommandName

You can add some parameters to be passed in to the Command event beyond what is defined in the CommandName property. You do this by using the Button control’s CommandArgument property.

###Buttons That Work with Client-Side JavaScript###

```
<asp:Button ID="Button1" runat="server" Text="Button"
    OnClientClick="AlertHello()" OnClick="Button1_Click" />
```

OnClientClick points to the client-side function, unlike the OnClick attribute that points to the server-side event.

PostBackUrl enables you to perform cross-page posting.

```
PostBackUrl="Page2.aspx"
```

##THE LINKBUTTON SERVER CONTROL##

The LinkButton server control is a variation of the Button control. It is the same except that the LinkButton control takes the form of a hyperlink.

```
<asp:LinkButton ID="LinkButton1" Runat="server" OnClick="LinkButton1_Click">     Submit your name to our database </asp:LinkButton>
```

##THE IMAGEBUTTON SERVER CONTROL##

Enables you to use a custom image as the form’s button

```
<asp:ImageButton ID="ImageButton1" runat="server"     OnClick="ImageButton1_Click" ImageUrl="search.jpg" />
```

ImageButton takes a different construction for the OnClick event.

```
protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
{
    // Code here
}
```

You can use this object to determine where in the image the end user clicked by using both e.X and e.Y coordinates.

##THE HYPERLINK SERVER CONTROL##

Hyperlinks are links that allow end users to transfer from one page to another.

```
<asp:HyperLink ID="HyperLink1" runat="server" Text="Go to this page here"     NavigateUrl="Default2.aspx"></asp:HyperLink>
```

Can be used for images as well as text. Instead of the Text attribute, it uses the ImageUrl property:

```
<asp:HyperLink ID="HyperLink2" runat="server" ImageUrl="MyLinkImage.gif"     NavigateUrl="Default2.aspx"></asp:HyperLink>
```

##THE DROPDOWNLIST SERVER CONTROL##

The DropDownList server control enables you to place an HTML select box

It is usually used for a medium- to large-sized collection.

If the collection size is relatively small, consider using the RadioButtonList server control

The DropDownList control displays a single item and allows the end user to make a selection

**Note** that the appearance of the scroll bar in the drop-down list is automatically created by the browser depending on the browser version and the number of items contained in the list.

```
<asp:DropDownList ID="DropDownList1" runat="server">     
    <asp:ListItem>Select an Item</asp:ListItem>          
    <asp:ListItem>Car</asp:ListItem>     
    <asp:ListItem>Airplane</asp:ListItem>     
    <asp:ListItem>Train</asp:ListItem>
</asp:DropDownList>
```

```
string[] carArray = new[] { "Ford", "Honda", "BMW", "Dodge" };
DropDownList2.DataSource = carArray;
DropDownList2.DataBind();
```

##THE LISTBOX SERVER CONTROL##

The ListBox control behaves differently from the DropDownList control in that it displays more of the collection to the end user, and it enables the end user to make multiple selections

```
<asp:ListBox ID="ListBox1" runat="server">     
    <asp:ListItem>ASP.NET 4.5</asp:ListItem>     
    <asp:ListItem>ASP.NET MVC 4</asp:ListItem>     
    <asp:ListItem>jQuery 1.8.x</asp:ListItem>     
    <asp:ListItem>Visual Studio 2012</asp:ListItem> 
</asp:ListBox>
```

You can use the SelectionMode attribute to let your end users make multiple selections

```

<asp:ListBox ID="ListBox1" runat="server" SelectionMode="Multiple">
    <asp:ListItem>ASP.NET 4.5</asp:ListItem>     
    <asp:ListItem>ASP.NET MVC 4</asp:ListItem>     
    <asp:ListItem>jQuery 1.8.x</asp:ListItem>     
    <asp:ListItem>Visual Studio 2012</asp:ListItem>
</asp:ListBox>
```

```
ListBox1.Items.Add(TextBox1.Text.ToString());
```

```
foreach (ListItem li in ListBox1.Items)
{
    if (li.Selected)
    {
        Label1.Text += li.Text + "<br>";
    }
}
```

###Adding Items to a Collection###

```
ListBox1.Items.Add(TextBox1.Text)
```

```
<option value="ASP.NET 4.5">ASP.NET 4.5</option>
```

```
ListBox1.Items.Add(new ListItem("Modernizr 2.6.x", "Modernizr"));
```

```
<option value="Modernizr">Modernizr 2.6.x</option>
```

##THE CHECKBOX SERVER CONTROL##

Use either the CheckBox control or the CheckBoxList

The CheckBox control allows you to place single check boxes

CheckBoxList control allows you to place collections of check boxes

You can use multiple CheckBox controls on your ASP.NET pages, but each check box is treated as its own element with its own associated events.

On the other hand, the CheckBoxList control allows multiple check boxes and specific events for the entire group.

```
<asp:CheckBox ID="CheckBox1" runat="server" Text="Donate $10 to my cause!" OnCheckedChanged="CheckBox1_CheckedChanged" AutoPostBack="true" />
```

###How to Determine Whether Check Boxes Are Checked###

```
if (CheckBox1.Checked == true) {
    Response.Write("Thanks for your donation!");
}
```

###Assigning a Value to a Check Box###

```
if (Member == true) {
    CheckBox1.Checked = true;
}
```

###Aligning Text around the Check Box###

Using the CheckBox control’s TextAlign property, you can realign the text so that it appears on the other side of the check box:

```
<asp:CheckBox ID="CheckBox1" runat="server" Text="Donate $10 to my cause!" OnCheckedChanged="CheckBox1_CheckedChanged" AutoPostBack="true" TextAlign="Left" />
```

The possible values of the TextAlign property are Right (the default setting) and Left.

##THE CHECKBOXLIST SERVER CONTROL##

The idea is that a CheckBoxList server control instance is a collection of related items, each being a check box unto itself.

```
<asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="CompanyName" RepeatColumns="3" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
</asp:CheckBoxList>
```

```
foreach (ListItem li in CheckBoxList1.Items)
{
    if (li.Selected == true)
    {
```

The CheckBoxList control binds itself to the SqlDataSource control using a few properties:

The DataSourceID property is used to associate the CheckBoxList control with the results that come back from the SqlDataSource control.

Then the DataTextField property is used to retrieve the name of the field

RepeatColumns property, which specifies how many columns (three in this example) can be used to display the results.

The RepeatDirection property instructs the CheckBoxList control about how to lay out the items bound to the control on the web page. Possible values include Vertical and Horizontal. The default value is Vertical.

##THE RADIOBUTTON SERVER CONTROL##

Radio buttons are generally form elements that require at least two options.

```
<asp:RadioButton ID="RadioButton1" runat="server" Text="Yes" GroupName="Set1" />
<asp:RadioButton ID="RadioButton2" runat="server" Text="No" GroupName="Set1"/>
```

```
<asp:RadioButton ID="RadioButton1" runat="server" Text="Visual Basic" GroupName="LanguageChoice" OnCheckedChanged="RadioButton_CheckedChanged" AutoPostBack="True" />             

<asp:RadioButton ID="RadioButton2" runat="server" Text="C#"                 GroupName="LanguageChoice"                 OnCheckedChanged="RadioButton_CheckedChanged"                 AutoPostBack="True" />
```

```
protected void RadioButton_CheckedChanged(object
sender, EventArgs e)
{
    if (RadioButton1.Checked == true)
    {
        Response.Write("You selected Visual Basic");
    }
    else
    {
        Response.Write("You selected C#");
    }
}
```

One advantage that the RadioButton control has over a RadioButtonList control (which is discussed next) is that it enables you to place other items (text, controls, or images) between the RadioButton controls themselves.

##THE RADIOBUTTONLIST SERVER CONTROL##

```
<asp:RadioButtonList ID="RadioButtonList1" runat="server">     
    <asp:ListItem Selected="True">English</asp:ListItem>     
    <asp:ListItem>Russian</asp:ListItem>     
    <asp:ListItem>Finnish</asp:ListItem>     
    <asp:ListItem>Swedish</asp:ListItem>
</asp:RadioButtonList>
```

```
Label1.Text = "You selected: " + RadioButtonList1.SelectedItem.ToString();
```

##IMAGE SERVER CONTROL##

The Image server control enables you to work with the images that appear on your web page from the server-side code.

```
<asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Windows.jpg" />
```

```
Image1.ImageUrl = "~/Images/Windows8.jpg";
```

Special circumstances can prevent end users from viewing an image that is part of your web page. They might be physically unable to see the image, or they might be using a text-only browser.

```
<asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Windows.jpg"   DescriptionUrl="~/WindowsImage.txt" /> 
```

```
<img id="Image1" src="Images/Windows.jpg" longdesc="WindowsImage.txt" />
```

If you want to program events based on button clicks, use the ImageButton server

##TABLE SERVER CONTROL##

```
<asp:Table ID="Table1" runat="server">
    <asp:TableRow ID="TableRow1" runat="server" Font-Bold="True" ForeColor="White" BackColor="DarkGray">
        <asp:TableHeaderCell>First Name</asp:TableHeaderCell>
        <asp:TableHeaderCell>Last Name</asp:TableHeaderCell>     </asp:TableRow>
    <asp:TableRow>         
        <asp:TableCell>Jason</asp:TableCell>         
        <asp:TableCell>Gaylord</asp:TableCell>     
    </asp:TableRow>
    <asp:TableRow>         
        <asp:TableCell>Scott</asp:TableCell>         
        <asp:TableCell>Hanselman</asp:TableCell>     
    </asp:TableRow>
    <asp:TableRow>         
        <asp:TableCell>Todd</asp:TableCell>         
        <asp:TableCell>Miranda</asp:TableCell>     
    </asp:TableRow>
    <asp:TableRow>         
        <asp:TableCell>Pranav</asp:TableCell>         
        <asp:TableCell>Rastogi</asp:TableCell>     
    </asp:TableRow>
</asp:Table>
```

```
TableRow tr = new TableRow();

TableCell fname = new TableCell();
fname.Text = "Christian";
tr.Cells.Add(fname);

TableCell lname = new TableCell();
lname.Text = "Wenz";
tr.Cells.Add(lname);

Table1.Rows.Add(tr);
```

###Using the Caption Attribute###

```
<asp:Table ID="Table1" runat="server" Caption="<b>Table 1:</b> This is an example of a caption above a table."
```

By default, the caption is placed at the top center

CaptionAlign. Its settings include Bottom, Left, NotSet, Right, and Top.

The TableHeaderRow and TableFooterRow elements can be used to add a header or a footer to your table.

```
<asp:TableHeaderRow>
<asp:TableFooterRow>
```

##THE CALENDAR SERVER CONTROL##

```
<asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
```

###Making a Date Selection from the Calendar Control###

```
Calendar1.SelectedDate.ToShortDateString());
```

###Choosing a Date Format to Output from the Calendar###

- ToFileTime: Converts the selection to the local operating system file time: 129961296000000000. 
- ToFileTimeUtc: Converts the selection to the operating system file time, but instead of using the local time zone, the UTC time is used: 129961152000000000. 
- ToLocalTime: Converts the current coordinated universal time (UTC) to local time: 10/30/2012 8:00:00 PM. 
- ToLongDateString: Converts the selection to a human-readable string in a long format: Wednesday, October 31, 2012. 
- ToLongTimeString: Converts the selection to a time value (no date is included) of a long format: 12:00:00 AM. 
- ToOADate: Converts the selection to an OLE Automation date equivalent: 41213.
- ToShortDateString: Converts the selection to a human-readable string in a short format: 10/31/2012. 
- ToShortTimeString: Converts the selection to a time value (no date is included) in a short format: 12:00 AM. 
- ToString: Converts the selection to the following: 10/31/2012 12:00:00 AM. 
- ToUniversalTime: Converts the selection to universal time (UTC): 10/31/2012 4:00:00 AM.

###Making Day, Week, or Month Selections###

By default, the Calendar control enables you to make single day selections.

You can use the SelectionMode property to change this behavior

Possible values of this property include Day, DayWeek, DayWeekMonth, and None.

###Working with Date Ranges###

Even if an end user makes a selection that encompasses an entire week or an entire month, you get back from the selection only the first date of this range.

```
for (int i = 0; i < Calendar1.SelectedDates.Count; i++)
{
    Label1.Text += Calendar1.SelectedDates[i].ToShortDateString() + "<br>";
}
```

```
Calendar1.SelectedDates[0].ToShortDateString();
```

```
Calendar1.SelectedDates[Calendar1.SelectedDates.Count-1].ToShortDateString();
```

### Controlling How a Day Is Rendered In the Calendar ###

```
<asp:Calendar ID="Calendar1" runat="server" OnDayRender="Calendar1_DayRender" 
  Height="190px" BorderColor="White" Width="350px" ForeColor="Black" 
  BackColor="White" BorderWidth="1px" NextPrevFormat="FullMonth" 
  Font-Names="Verdana" Font-Size="9pt">
    <SelectedDayStyle ForeColor="White" BackColor="#333399"></SelectedDayStyle>
    <OtherMonthDayStyle ForeColor="#999999" </OtherMonthDayStyle>
    <TodayDayStyle BackColor="#CCCCCC"></TodayDayStyle>
    <NextPrevStyle ForeColor="#333333" VerticalAlign="Bottom" Font-Size="8pt" Font-Bold="True"></NextPrevStyle>
    <DayHeaderStyle Font-Size="8pt" Font-Bold="True"></DayHeaderStyle>
    <TitleStyle ForeColor="#333399" BorderColor="Black" Font-Size="12pt" Font-Bold="True" BackColor="White" BorderWidth="4px"></TitleStyle>
</asp:Calendar>
```

```
protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
{
    e.Cell.VerticalAlign = VerticalAlign.Top;
    if (e.Day.DayNumberText == "18")
    {
        e.Cell.Controls.Add(new LiteralControl("<p>User Group Meeting!</p>"));
        e.Cell.BorderColor = System.Drawing.Color.Black;
        e.Cell.BorderWidth = 1;
        e.Cell.BorderStyle = BorderStyle.Solid;
        e.Cell.BackColor = System.Drawing.Color.LightGray;
    }
}
```

```
public void Calendar1_DayRender(Object sender, DayRenderEventArgs e) {
    if (e.Day.Date < DateTime.Now)
    {
        e.Day.IsSelectable = false;
    }
}
```

##ADROTATOR SERVER CONTROL##

With the AdRotator control, you can configure your application to show a series of advertisements to the end users.

###THE XML SERVER CONTROL###

The Xml server control provides a means of getting XML and transforming it using an XSL style sheet.

```
<asp:Xml ID="Xml1" runat="server" DocumentSource="Food.xml" TransformSource="FoodTemplate.xslt"></asp:Xml>
```

This method takes only a couple of attributes to make it work: DocumentSource, which points to the path of the XML file, and TransformSource, which provides the XSLT file to use in transforming the XML document.

The other way to use the Xml server control is to load the XML into an object and then pass the object to the Xml control,

##PANEL SERVER CONTROL##

The Panel server control encapsulates a set of controls you can use to manipulate or lay out your ASP.NET pages.

It is basically a wrapper for other controls, enabling you to take a group of server controls along with other elements (such as HTML and images) and turn them into a single unit.

The advantage of using the Panel control to encapsulate a set of other elements is that you can manipulate these elements as a single unit using one attribute set in the Panel control itself.

The Panel control also has the capability to scroll with scrollbars that appear automatically


```
<form id="form1" runat="server">
<asp:Panel ID="Panel1" runat="server" Height="300" Width="300" ScrollBars="auto">
    <p>Lorem ipsum dolor sit amet...</p>
</asp:Panel>
```

The Panel control wraps the text by default as required.

To change this behavior, use the Wrap attribute, which takes a boolean value:

```
<asp:Panel ID="Panel1" runat="server" Height="300" Width="300" ScrollBars="auto" Wrap="False" />
```

The ScrollBars attribute. In addition to Auto, its values include None, Horizontal, Vertical, and Both.

HorizontalAlign. It enables you to set how the content in the Panel control is horizontally aligned. The possible values of this attribute include NotSet, Center, Justify, Left, and Right.

It is also possible to move the vertical scrollbar to the left side of the Panel control by using the Direction attribute. Direction can be set to NotSet, LeftToRight, and RightToLeft.

##THE PLACEHOLDER SERVER CONTROL##

It is a placeholder for you to interject objects dynamically into your page.

```
<asp:PlaceHolder ID="PlaceHolder1" runat="server" />
```

```
Label MyNameLabel = new Label();
MyNameLabel.Text = "Welcome, Jason!";
PlaceHolder1.Controls.Add(MyNameLabel);

##BULLETEDLIST SERVER CONTROL##

The BulletedList server control is meant to display a bulleted list of items easily in an ordered (using the HTML <ol> element) or unordered (using the HTML <ul> element) fashion.

Constructed of any number of <asp:ListItem> controls or can be data-bound to a data source

```
<asp:BulletedList ID="Bulletedlist1" runat="server">
    <asp:ListItem>United States</asp:ListItem>
    <asp:ListItem>United Kingdom</asp:ListItem>
```

The use of the BulletedList element, along with ListItem elements, produces a simple bulleted list

The BulletedList control also enables you to easily change the style of the list with just one or two attributes.

The BulletStyle attribute changes the style of the bullet that precedes each line of the list. It has possible values of Numbered, LowerAlpha, UpperAlpha, LowerRoman, UpperRoman, Disc, Circle, Square, NotSet, and CustomImage.

You can change the starting value of the first item in any of the numbered styles (Numbered, LowerAlpha, UpperAlpha, LowerRoman, UpperRoman) by using the FirstBulletNumber attribute.

To employ images as bullets, use the CustomImage

```
<asp:BulletedList ID="Bulletedlist1" BulletStyle="CustomImage" BulletImageUrl="~/search.jpg" runat="server">
```

The BulletedList control has an attribute called DisplayMode, which has three possible values: Text, HyperLink, and LinkButton.

Using Text means that the items in the bulleted list are laid out only as text.

HyperLink means that each of the items is turned into a hyperlink

A value of LinkButton turns each bulleted list item into a hyperlink that posts back to the same page.

```
<asp:BulletedList ID="BulletedList1" runat="server" OnClick="BulletedList1_Click" DisplayMode="LinkButton">
    <asp:ListItem>United States</asp:ListItem>
```

```
protected void BulletedList1_Click(object sender, BulletedListEventArgs e)
{
    Label1.Text = "The index of item you selected: " + e.Index + "<br>The value of the item selected: " + BulletedList1.Items[e.Index].Text;
}
```


```
<asp:BulletedList ID="BulletedList1" runat="server" DataSourceID="XmlDataSource1" DataTextField="Title"> </asp:BulletedList>
<asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/Listing05-31.xml" XPath="Books/Book"></asp:XmlDataSource>
```

##HIDDENFIELD SERVER CONTROL##

```
<asp:HiddenField ID="HiddenField1" runat="Server" />
```

```
HiddenField1.Value = Guid.NewGuid().ToString();
```

```
protected void HiddenField1_ValueChanged(object sender, EventArgs e)
{
   // Handle event here 
}
```

The ValueChanged event is triggered when the ASP.NET page is posted back to the server if the value of the HiddenField server control has changed since the last time the page was drawn.


##FILEUPLOAD SERVER CONTROL##

In the very early days of ASP.NET, you could upload files using the HTML FileUpload server control. This control put an <input type="file"> element on your web page to enable the end user to upload files to the server.

You had to make a couple of modifications to the page. For example, you were required to add enctype="multipart/form-data" to the page’s <form> element.

since ASP.NET 2.0,

When giving a page the capability to upload files, you simply include the FileUpload control, and ASP.NET takes care of the rest, including adding the enctype attribute to the page’s form element.

###Uploading Files Using the FileUpload Control###

```
<form id="form1" runat="server">         
<asp:FileUpload ID="FileUpload1" runat="server" />
```

```
if (FileUpload1.HasFile)
    try
    {
        FileUpload1.SaveAs("C:\Uploads\" + FileUpload1.FileName);
        Label1.Text = "File name: " + 
            FileUpload1.PostedFile.FileName + "<br>" + 
            FileUpload1.PostedFile.ContentLength + " kb<br>" + 
            "Content type: " + FileUpload1.PostedFile.ContentType;
    }
    catch (Exception ex)
    {
        Label1.Text = "ERROR: " + ex.Message.ToString();
    } else {
        Label1.Text = "You have not specified a file."; 
    }
}
```

When compiling and running this page, you may notice a few things in the generated source code of the page.

```
<form method="post" action="Listing05-34.aspx" id="form1" enctype="multipart/form-data">
```

modified the page’s form element on your behalf by adding the appropriate enctype attribute.

FileUpload control was converted to an HTML input:

```
<input type="file"> element.
```

###Giving ASP.NET Proper Permissions to Upload Files###

Errors may occur because the destination folder on the server is not writable for the account used by ASP.NET.

Make sure the IIS_IUSRS account is included in the list and has the proper permissions to write to disk.

> NOTE Prior to IIS 7.0, the ASP.NET user account (aspnet_user) was used to control permissions.

###Understanding File Size Limitations###

The default size limitation is 4MB (4096KB);

The httpRuntime section of the web.config.comments

The maxRequestLength property dictates the size of the request made to the web server.

The value presented is in kilobytes. To allow files larger than the default of 4MB, change the maxRequestLength property as follows: maxRequestLength="10240"

When changing the maxRequestLength property, be aware of the setting provided for the executionTimeout property. This property sets the time (in seconds) for a request to attempt to execute to the server before ASP.NET shuts down the request (whether or not it is finished). The default setting is 90 seconds.

The end user receives a timeout error notification in the browser if the time limit is exceeded.

###Uploading Multiple Files from the Same Page###

```
<form id="form1" runat="server">
<p>
    <asp:FileUpload ID="FileUpload1" runat="server" />
</p>
<p>
    <asp:FileUpload ID="FileUpload2" runat="server" />
</p>
<p>
    <asp:FileUpload ID="FileUpload3" runat="server" />
</p>
<p>
    <asp:Button ID="Button1" runat="server" Text="Upload" OnClick="Button1_Click" />
</p>
<p>
    <asp:Label ID="Label1" runat="server"></asp:Label>
</p>
</form>
```

```
protected void Button1_Click(object sender, EventArgs e)
{
         string filepath = "C:\Uploads";
         HttpFileCollection uploadedFiles = Request.Files;
         for (int i = 0; i < uploadedFiles.Count; i++)
         {
             HttpPostedFile userPostedFile = uploadedFiles[i];
             try
             {
                 if (userPostedFile.ContentLength > 0)
                 {
                     Label1.Text += "<u>File #" + (i + 1) +
                       "</u><br>";
                     Label1.Text += "File Content Type: " +
                       userPostedFile.ContentType + "<br>";
                     Label1.Text += "File Size: " +
                       userPostedFile.ContentLength + "kb<br>";
                     Label1.Text += "File Name: " +
                       userPostedFile.FileName + "<br>";
                     userPostedFile.SaveAs(filepath + "\" +
                   Path.GetFileName(userPostedFile.FileName));
                     Label1.Text += "Location where saved: " +
                   filepath + "\" +
                   Path.GetFileName(userPostedFile.FileName) +
                   "<p>";
                 }
             }
             catch (Exception Ex)
             {
                 Label1.Text += "Error: <br>" + Ex.Message;
             }
         }
     }
}
```


###Placing the Uploaded File into a Stream Object###

```
Stream myStream; myStream = FileUpload1.FileContent;
```

```
MemoryStream myStream;   
myStream = (MemoryStream)FileUpload1.FileContent;   
Byte[] myByteArray = new Byte[FileUpload1.PostedFile.ContentLength];   
myByteArray = myStream.ToArray();
```

##MULTIVIEW AND VIEW SERVER CONTROLS##

The MultiView and View server controls work together to give you the capability to turn on/off sections of an ASP.NET page.

Turning sections on and off, which means activating or deactivating a series of View controls within a MultiView control, is similar to changing the visibility of Panel controls. For certain operations, however, you may find that the MultiView control is easier to manage and work with.

The sections, or views, do not change on the client-side; rather, they change with a postback to the server. You can put any number of elements and controls in each view, and the end user can work through the views based upon the sequence numbers that you assign to the views.

drag and drop a MultiView control onto the design surface and then drag and drop any number of View controls inside the MultiView control. Place the elements you want within the View controls.

```
<asp:MultiView ID="MultiView1" runat="server"> 
    <asp:View ID="View1" runat="server">
        <em>Making a Great Book</em><br />
        <br />
        Surround yourself with talented authors.<br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Next Step" OnClick="NextView" />
    </asp:View>
    <asp:View ID="View2" runat="server">
        <em>Making a Great Book</em><br />
        <br />
        Write content you are passionate about.<br />
        <br />
        <asp:Button ID="Button2" runat="server" Text="Next Step" OnClick="NextView" />
        </asp:View>
    <asp:View ID="View3" runat="server">
        <em>Making a Great Book</em><br />
        <br />
        Have a bunch of smart technical editors review your work.<br />
        <br />
        <asp:Button ID="Button3" runat="server" Text="Next Step" OnClick="NextView" />
    </asp:View>
    <asp:View ID="View4" runat="server">
        <em>Making a Great Book</em><br />
        <br />
        Release the book to publishing!
    </asp:View>
</asp:MultiView>
```

```
protected void Page_Load(object sender, EventArgs e)
{
    if (!Page.IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
        }
    }
    void NextView(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex += 1;
    }
}
```

By default, the ActiveViewIndex, which describes the view that should be showing, is set to -1. This means that no view shows when the page is generated.

##WIZARD SERVER CONTROL##

Much like the MultiView control, the Wizard server control enables you to build a sequence of steps that is displayed to the end user.

When you are constructing a step-by-step process that includes logic on the steps taken, use the Wizard control to manage the entire process.

```
<form id="form1" runat="server">
    <asp:Wizard ID="Wizard1" runat="server" DisplaySideBar="True" ActiveStepIndex="0">
        <WizardSteps>
            <asp:WizardStep ID="WizardStep1" runat="server" Title="Step 1">
                This is the first step.
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep2" runat="server" Title="Step 2">
                This is the second step.
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep3" runat="server" Title="Step 3">
                This is the third and final step.
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>
```

The order in which the WizardSteps are defined is based completely on the order in which they appear within the WizardSteps element

DisplaySideBar. In this example, it is set to True by default — meaning that a side navigation system in the displayed control enables the end user to quickly navigate to other steps in the process.

The ActiveStepIndex attribute of the Wizard control defines the first wizard step. In this case, it is the first step — 0.

###Customizing the Side Navigation###

The links are created based on the Title property’s

####Examining the AllowReturn Attribute###

AllowReturn attribute. By setting this attribute on one of the wizard steps to False, you can remove the capability for end users to go back to this step after they have viewed it.

####Working with the StepType Attribute####

The StepType attribute defines the structure of the buttons used on the steps. By default, the Wizard control places only a Next button on the first step. It understands that you do not need the Previous button there. It also knows to use a Next and Previous button on the middle step, and it uses Previous and Finish buttons on the last step.

by default, the StepType attribute is set to Auto,

In addition to Auto, StepType value options include Start, Step, Finish, and Complete.

```
<asp:WizardStep ID="WizardStep4" runat="server" Title="Final Step" StepType="Complete">
    Thanks for working through the steps.
</asp:WizardStep>
```

When the end user clicks the Finish button in Step 3, the last step — Final Step — is shown and no buttons appear with it.

####Adding a Header to the Wizard Control####

```
<asp:Wizard ID="Wizard1" runat="server" DisplaySideBar="True" ActiveStepIndex="0" 
    HeaderText="Step by Step with the Wizard Control" HeaderStyle-BackColor="DarkGray" 
    HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="20">
</asp:Wizard>
```

This code creates a header that appears on each of the steps in the wizard.

####Working with the Wizard’s Navigation System####

DisplayCancelButton attribute to True, and a Cancel button appears within the navigation

The possible values of these button-specific elements include Button, Image, and Link. Button is the default and means that the navigation system uses buttons. A value of Image enables you to use image buttons, and Link turns a selected item in the navigation system into a hyperlink.

To redirect the user with one of these buttons, you use the CancelDestinationPageUrl or the FinishDestinationPageUrl attributes and set the appropriate URL as the destination.

Finally, you are not required to use the default text included with the buttons in the navigation system. You can change the text of each of the buttons using the CancelButtonText, FinishStepButtonText, FinishStepPreviousButtonText, NextStepButtonText, PreviousStepButtonText, and StartStepNextButtonText attributes.

####Utilizing Wizard Control Events####

One of the most convenient capabilities of the Wizard control is that it enables you to divide large forms into logical pieces.

|EVENT| DESCRIPTION|
|--|--|
| ActiveStepChanged| Triggers when the end user moves from one step to the next. It does not matter if the step is the middle or final step in the series. This event simply covers each step change generically. |
|CancelButtonClick| Triggers when the end user clicks the Cancel button in the navigation system. |
|FinishButtonClick| Triggers when the end user clicks the Finish button in the navigation system. |
|NextButtonClick| Triggers when the end user clicks the Next button in the navigation system. |
|PreviousButtonClick| Triggers when the end user clicks the Previous button in the navigation system. |
|SideBarButtonClick| Triggers when the end user clicks one of the links contained within the sidebar navigation of the Wizard control.|

The Wizard control remembers all the end user’s input in each of the steps by means of the view state in the page, which enables you to work with all these values in the last step.

```
<form id="form1" runat="server">
    <asp:Wizard ID="Wizard1" runat="server" DisplaySideBar="True" ActiveStepIndex="0" OnFinishButtonClick="Wizard1_FinishButtonClick">
        <WizardSteps>
```

```
protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
{
}
```

####Using the Wizard Control to Show Form Elements####

One nice thing about putting form elements in the Wizard step process is that the Wizard control remembers each input into the form elements from step to step, enabling you to save the results of the entire form at the last step.

It also means that when the end user presses the Previous button, the data that is entered into the form previously is still there and can be changed.

```
<asp:WizardStep ID="WizardStep3" runat="server" Title="Provided Information" StepType="Complete" OnActivate="WizardStep3_Activate">
    <asp:Label ID="Label1" runat="server" />
</asp:WizardStep>
```

```

<%@ Page Language="C#" %>
   <!DOCTYPE html>
   <script runat="server">
       protected void WizardStep3_Activate(object sender, EventArgs e)
       {
           Label1.Text = "First name: " + fnameTextBox.Text.ToString() + "<br>" +
               "Last name: " + lnameTextBox.Text.ToString() + "<br>" +
               "Email: " + emailTextBox.Text.ToString();
       }
   </script>
```

Since you want to show this step only if the end user specifies that he or she is a member in WizardStep2,

```
void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
{
    if (e.NextStepIndex == 2)
    {
         if (RadioButton1.Checked == true)
         {
             Wizard1.ActiveStepIndex = 2;
         }
         else
         {
             Wizard1.ActiveStepIndex = 3;
         }
     }
}
```

To check whether you should show a specific step in the process, use the NextButtonClick event from the Wizard control.

##IMAGEMAP SERVER CONTROL##

The ImageMap server control enables you to turn an image into a navigation menu.

```
<asp:ImageMap ID="ImageMap1" runat="server" HotSpotMode="PostBack" ImageUrl="~/Images/kids.jpg" OnClick="ImageMap1_Click">
    <asp:CircleHotSpot PostBackValue="Addison" Radius="26" X="145" Y="372" />
    <asp:CircleHotSpot PostBackValue="Brayden" Radius="20" X="181" Y="314" />
    <asp:CircleHotSpot PostBackValue="Arianna" Radius="28" X="245" Y="344" />
</asp:ImageMap>

```

```
protected void ImageMap1_Click(object sender, ImageMapEventArgs e)
{
    Response.Write("You selected: " + e.PostBackValue);
}
```

Besides the CircleHotSpot control, you can also use the RectangleHotSpot and the PolygonHotSpot controls.

The HotSpotMode attribute can take the values PostBack, Navigate, or InActive.

You must determine which hotspot is selected. You make this determination by giving each hotspot (<asp:CircleHotSpot>) a postback value with the PostBackValue attribute.

#Chapter 6: Validation and Server# {#Cap6}

##ASP.NET VALIDATION SERVER CONTROLS##

ASP.NET 4.5 did introduce a new validation technique by using unobtrusive JavaScript capabilities,

The available validation server controls include: RequiredFieldValidator CompareValidator RangeValidator RegularExpressionValidator CustomValidator DynamicValidator ValidationSummary

>NOTE If the ASP.NET Validation controls don’t meet your needs, you can certainly write your own custom validation controls. However, third-party controls are available, such as Peter Blum’s Validation and More (VAM) from www.peterblum.com/DES, which includes more than 50 ASP.NET validation controls.

|VALIDATION SERVER CONTROL| DESCRIPTION|
|--|--|

|RequiredFieldValidator| Ensures that the user does not skip a form entry field. |
|CompareValidator| Allows for comparisons between the user’s input and another item using a comparison operator (equals, greater than, less than, and so on). |
|RangeValidator| Checks the user’s input based upon a lower- and upper-level range of numbers or characters.|
|RegularExpressionValidator |Checks that the user’s entry matches a pattern defined by a regular expression. This control is good to use to check e-mail addresses and phone numbers. |
|CustomValidator| Checks the user’s entry using custom-coded validation logic. |
|DynamicValidator| Works with exceptions that are thrown from entity data models and extension methods. This control is part of the ASP.NET Dynamic Data Framework. For more information about this control, be sure to search the Internet for DynamicValidator. |
|ValidationSummary| Displays all the error messages from the validators in one specific spot on the page.|

##Validation Causes##

Validation doesn’t just happen; it occurs in response to an event. In most cases, it is a button click event.

The Button, LinkButton, and ImageButton server controls all have the capability to cause a page’s form validation to initiate.

The CausesValidation property is set to True. As stated, this behavior is the default

```
<asp:Button ID="Button1" runat="server" Text="Cancel" CausesValidation="false" />
```

##Unobtrusive Validation in ASP.NET 4.5##

Unobtrusive validation helps to reduce the invasion on the user’s interaction with the web application.

Instead of rendering JavaScript inline, HTML5 data-* attributes are added to the appropriate form elements. In ASP.NET 4.5, the jQuery validation plugin is used and the unobtrusive validation functionality is enabled by default.

```
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
    Text="Required!" ControlToValidate="TextBox1" EnableClientScript="true">
</asp:RequiredFieldValidator>
```

```
if (Page.IsValid)
{
     Label1.Text = "Page is valid!";
}
```

You can enable unobtrusive validation by adding the following to the web.config file:

```
<appSettings>
       <add key="ValidationSettings:UnobtrusiveValidationMode" value="WebForms" />
</appSettings>
```

The value of ValidationSettings:UnobtrusiveValidationMode can be None or WebForms/

Instead of setting this value in the web.config file, you can also set this value in the global.asax file’s Application_Start

```
ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.WebForms;
```

If you want to set this value on a page-by-page basis, you can. In the Page_Load event,

```
Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.WebForms;
```

You still have to register the jQuery JavaScript library with the ASP.NET Ajax ScriptManager (see sidebar).

```
install-package jQuery.
install-package AspNet.ScriptManager.jQuery.
```

##The RequiredFieldValidator Server Control##

The RequiredFieldValidator control simply checks to see whether any characters were entered into the HTML form element.

The Text property. This property is the value that is shown to the end user via the web page if the validation fails.

The ControlToValidate property. This property is used to make an association between this validation server control and the ASP.NET form element that requires the validation.

You can also express this error message between the RequiredFieldValidator opening and closing nodes,

```
<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
     runat="server" ControlToValidate="TextBox1"
     EnableClientScript="true"> Required!
</asp:RequiredFieldValidator>
```

Looking at the Results Generated

```

<!-- Abbreviated for clarity -->
<input name="TextBox1" type="text" id="TextBox1" />
<span data-val-controltovalidate="TextBox1" id="RequiredFieldValidator1" data-val="true"
      data-val-evaluationfunction="RequiredFieldValidatorEvaluateIsValid"
      data-val-initialvalue="" style="visibility:hidden;">
        Required!
</span>
<br />
<input type="submit" name="Button1" value="Submit" onclick="javascript:WebForm
_   DoPostBackWithOptions(new WebForm_PostBackOptions("Button1", "", true,   "", "", false, false))" id="Button1" />
```

The WebForm_DoPostBackWithOptions JavaScript function initiates the client-side validation.

Notice that the span element includes four attributes that begin with data-val. These attributes help the JavaScript functions determine which elements should be used for validation and how the validation should be handled.

>*NOTE* The data-* attributes are only rendered when unobtrusive validation is turned on. When unobtrusive validation is not turned on, JavaScript will be emitted to the browser to handle the validation such as:

```
<script type="text/javascript">
//<![CDATA[
var RequiredFieldValidator1 = document.all ? document.all["RequiredFieldValidator1"] : document.getElementById("RequiredFieldValidator1");
RequiredFieldValidator1.controltovalidate = "TextBox1";   
RequiredFieldValidator1.evaluationfunction = "RequiredFieldValidatorEvaluateIsValid";   
RequiredFieldValidator1.initialvalue = "";
   //]]>
</script>
```

###Using the InitialValue Property###

initial value is rendered as an attribute named data-val-initialvalue on the span element.

Sometimes you have form elements that are populated with some default properties (for example, from a datastore), and these form elements might present the end user with values that require changes before the form can be submitted to the server.

The end user is then required to change that text value before he or she can submit the form. Listing 6-4 shows an example of using this property.

```
<asp:TextBox ID="TextBox1" runat="server" Text="Wrox"></asp:TextBox>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
    runat="server" ControlToValidate="TextBox1" InitialValue="Wrox" 
    EnableClientScript="true" Text="Please change the value of the textbox!" />
```

The RequiredFieldValidator control requires a change in this value for the page to be considered valid.

###Disallowing Blank Entries and Requiring Changes at the Same Time###

One thing the end user can do to get past the form validation is to submit the page with no value entered in this particular textbox.

you must put an additional RequiredFieldValidator control on the page.

```
<asp:TextBox ID="TextBox1" runat="server" Text="Wrox"></asp:TextBox>   
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
    runat="server" ControlToValidate="TextBox1" InitialValue="Wrox"
    EnableClientScript="true" Text="Please change the value of the textbox!" />   
<asp:RequiredFieldValidator ID="RequiredFieldValidator2"
    runat="server" ControlToValidate="TextBox1"
    EnableClientScript="true" Text="Please do not leave this field blank!" />
```

###Validating Drop-Down Lists with the RequiredFieldValidator Control###

```
<asp:DropDownList>
ID="DropDownList1" runat="server">
    <asp:ListItem Selected="True">Select a profession</asp:ListItem>
    <asp:ListItem>Programmer</asp:ListItem>
    <asp:ListItem>Lawyer</asp:ListItem>
    <asp:ListItem>Doctor</asp:ListItem>
    <asp:ListItem>Artist</asp:ListItem>
</asp:DropDownList>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
    runat="server" Text="Please make a selection"
    ControlToValidate="DropDownList1" InitialValue="Select a profession">
</asp:RequiredFieldValidator>
```

##The CompareValidator Server Control##

The CompareValidator control enables you to compare two form elements as well as to compare values contained within form elements to a constant value that you specify.

For example, you can specify that a form element’s value must be an integer and greater than a specified number.

You can also state that values must be strings, dates, or other data types that are at your disposal for comparison purposes.

###Validating against Other Controls###

```
<asp:CompareValidator ID="CompareValidator1" runat="server" 
    Text="Passwords do not match!" ControlToValidate="TextBox2" ControlToCompare="TextBox1">
</asp:CompareValidator>
```

###Validating against Constants###

```
<asp:CompareValidator ID="CompareValidator1" runat="server" 
    Text="You must enter a number" ControlToValidate="TextBox1" 
    Type="Integer" Operator="DataTypeCheck">
</asp:CompareValidator>
```

In this example, the end user is required to type a number into the textbox.

The Type property can take the following values: 

- Currency
- Date
- Double
- Integer
- String

```
<asp:CompareValidator ID="CompareValidator1" runat="server"
    Text="You must be at least 18 to join" ControlToValidate="TextBox1" Type="Integer"
    Operator="GreaterThanEqual" ValueToCompare="18">
</asp:CompareValidator>
```

it also uses the Operator and the ValueToCompare properties to ensure that the number is greater than 18.

The Operator property can take one of the following values: 

- Equal 
- NotEqual 
- GreaterThan 
- GreaterThanEqual 
- LessThan 
- LessThanEqual 
- DataTypeCheck

##The RangeValidator Server Control##

```
<asp:RangeValidator ID="RangeValidator1" runat="server"
       ControlToValidate="TextBox1" Type="Integer"
       Text="You must be between 30 and 40"
       MaximumValue="40" MinimumValue="30">
</asp:RangeValidator>
```

The RangeValidator control makes an analysis of the value provided and makes sure the value is somewhere in the range, including the minimum and maximum values, of 30 to 40.

The RangeValidator control also makes sure that what is entered is an integer data type.

It uses the Type property, which is set to Integer. The other possible data types for the RangeValidator control include the same values used, and as mentioned earlier, for the CompareValidator control.

By default, the Type property of any of the validation controls is set to String, which allows you to ensure that the string’s ASCII value submitted is within a particular range.

```
<asp:RangeValidator ID="RangeValidator1" runat="server"
     Text="You must only select a date within the next two weeks."
     ControlToValidate="TextBox1" Type="Date">
</asp:RangeValidator>
```

```
protected void Page_Load(object sender, EventArgs e){
  RangeValidator1.MinimumValue = DateTime.Now.ToShortDateString();
  RangeValidator1.MaximumValue = DateTime.Now.AddDays(14).ToShortDateString();
}
```

##The RegularExpressionValidator Server Control##

Using the RegularExpressionValidator control, you can check a user’s input based on a pattern that you define using a regular expression.

```
<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
    Text="You must enter an email address"
    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*.\w+([-.]\w+)*"
    ControlToValidate="TextBox1">
</asp:RegularExpressionValidator>
```

> *NOTE* In addition to working with the Regular Expression Editor to help you with these sometimes-complicated regular expression strings, you can also find a good-sized collection of them at an Internet site called RegExLib found at www.regexlib.com.

##The CustomValidator Server Control##

The CustomValidator control enables you to build your own client-side or server-side validations that you can then easily apply to your Web Forms.

###Using Client-Side Validation###

<script type="text/javascript">
  function validateNumber(oSrc, args) {
    args.IsValid = (args.Value % 5 == 0);
  }
</script>

```
<asp:CustomValidator ID="CustomValidator1"
    runat="server" ControlToValidate="TextBox1"
    Text="Number must be divisible by 5"
    ClientValidationFunction="validateNumber">
</asp:CustomValidator>
```

The source parameter is a reference to the validation control itself.

The arguments parameter is an object containing two properties, args.IsValid and args.Value.

###Using Server-Side Validation###

```
<asp:CustomValidator ID="CustomValidator1"
    runat="server" ControlToValidate="TextBox1"
    Text="Number must be divisible by 5" 
    OnServerValidate="ValidateNumber">
</asp:CustomValidator>
```

```
void ValidateNumber(object source, ServerValidateEventArgs args)
{
    try
    {
        int num = int.Parse(args.Value);
        args.IsValid = ((num % 5) == 0);
    } catch (Exception ex)
    {
        args.IsValid = false;
    }
}
```


###Using Client-Side and Server-Side Validation Together As stated earlier###

you should take steps to also reconstruct the client-side function as a server-side function.

```
<asp:CustomValidator ID="CustomValidator1"
    runat="server" ControlToValidate="TextBox1"
    Text="Number must be divisible by 5"
    OnServerValidate="ValidateNumber"
    ClientValidationFunction="validateNumber">
</asp:CustomValidator>

##The ValidationSummary Server Control##

You can use this validation control to consolidate error reporting for all the validation errors that occur on a page instead of leaving it up to each individual validation control.

By default, the ValidationSummary control shows the list of validation errors as a bulleted list,

```
<asp:ValidationSummary 
    ID="ValidationSummary1" runat="server" 
    HeaderText="You received the following errors:">
</asp:ValidationSummary>
```

In most cases, you do not want these errors to appear twice on a page for the end user.

You can change this behavior by using the Text property of the validation controls, in addition to the ErrorMessage property, as you have typically done throughout this chapter. The Text property is the value of the text displayed within the validation control. The ErrorMessage property is the value of the text displayed within the validation summary

```
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
    runat="server" ErrorMessage="You must enter your first name" 
    Text="*" ControlToValidate="TextBox1">
</asp:RequiredFieldValidator>

The Text property is used by the validation control and is not utilized by the ValidationSummary control.

DisplayMode property of the ValidationSummary:

- BulletList 
- List 
- SingleParagraph

You can also utilize a dialog box instead of displaying the results to the web page.

```
<asp:ValidationSummary ID="ValidationSummary1" runat="server"
    ShowMessageBox="true" ShowSummary="false">
</asp:ValidationSummary>

##TURNING OFF CLIENT-SIDE VALIDATION##

You might want all validations done on the server, no matter what capabilities the requesting containers offer.

You can take a few approaches to turning off this functionality.

The first option is at the control level. Each of the validation server controls has a property called EnableClientScript. This property is set to True by default,

```
<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
    runat="server" ErrorMessage="You must enter your first name"
    Text="*" ControlToValidate="TextBox1" EnableClientScript="false">
</asp:RequiredFieldValidator>
```

You can also remove a validation control’s client-side capability programmatically

```
protected void Page_Load(Object sender, EventArgs e)   
{
    RequiredFieldValidator1.EnableClientScript = false;
    RequiredFieldValidator2.EnableClientScript = false;
}
```

Turn off the client-side script capabilities for all the validation controls on a page from within the Page_Load event.

```
protected void Page_Load(Object sender, EventArgs e)   
{
    foreach (BaseValidator bv in Page.Validators)
    {
        bv.EnableClientScript = false;
    }
}
```

###USING IMAGES AND SOUNDS FOR ERROR NOTIFICATIONS###

To use an image for the error, you use the Text property of any of the validation controls. You simply place some appropriate HTML as the value of this property,

```
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
    Text="<img src='error.jpg' alt='Error!' />" 
    ControlToValidate="TextBox1" EnableClientScript="true">
</asp:RequiredFieldValidator>
```

The other interesting twist you can create is to add a sound notification when an error occurs.

```
<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
   runat="server" ControlToValidate="TextBox1" EnableClientScript="false"
   Text="<audio controls='' src='C:\Windows\Media\tada.wav' autoplay='autoplay'></audio>">
</asp:RequiredFieldValidator>
```

You can find a lot of the Windows system sounds in the C:\Windows\Media directory.

> *NOTE* When referencing a sound file (such as this one), you must be sure that the web application has proper permissions to listen to the sound. It is recommended that the sounds be hosted within the application or on a content delivery network (CDN).

When working with sounds for error notifications, you have to disable the client-side script capability for that particular control because if you do not, the sound plays when the page loads in the browser, whether or not a validation error has been triggered.

##WORKING WITH VALIDATION GROUPS##

Different validation controls are often assigned to two distinct forms on the page.

However, in this example, unexpected behavior may occur. For instance, when the end user submits one form, the validation controls in the other form may be fired even though the user is not working with that form.

In other scenarios, developers may want to simply break up a form and validate controls differently.

ASP.NET Web Controls contains a ValidationGroup property that enables you to separate the validation controls into separate groups.

It enables you to activate only the required validation controls when an end user clicks a button on the page.

```
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
    Text="* You must submit a username!"
    ControlToValidate="TextBox1" ValidationGroup="Login">
</asp:RequiredFieldValidator>
```

```
<asp:Button ID="Button2" runat="server" Text="Sign-up" ValidationGroup="Newsletter" /> 
```

Core server controls also have the ValidationGroup property because things like button clicks must be associated with specific validation groups.

Another great feature with the validation controls is a property called SetFocusOnError.

If a validation error is thrown when the form is submitted, the property places the page focus on the form element that receives the error.

```
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
    Text="* You must submit a username!" SetFocusOnError="true"
    ControlToValidate="TextBox1" ValidationGroup="Login">
</asp:RequiredFieldValidator>
```

Note that if you have multiple validation controls on your page with the SetFocusOnError property set to True, and more than one validation error occurs, the uppermost form element that has a validation error gets the focus.


#Chapter 7: User and Server Controls# {#Cap7}

##USER CONTROLS##

User controls represent the most basic form of ASP.NET visual encapsulation.

###Creating User Controls###

has an .ascx extension.

If you attempt to load the user control directly into your browser, ASP.NET returns an error telling you that this type of file cannot be served to the client.


```
<%@ Control Language="C#" ClassName="Listing07_01" %>     <script runat="server">     </script>
```

Notice that the source uses the @Control directive rather than the @Page directive

tags. In fact, if you try to add a server-side form tag to the user control, ASP.NET returns an error when the page is served to the client.

User controls participate fully in the page-rendering life cycle, and controls contained within a user control behave just as they would if placed onto a standard ASP.NET web page. This means that the user control has its own page events (such as Init, Load, and Prerender) that execute as the page is processed, and that controls within the user control will also fire events as they normally would.

```
<%@ Control Language="C#" ClassName="Listing07_03" %>   
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Label1.Text = "The quick brown fox jumped over the lazy dog";
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        this.Label1.Text = "The quick brown fox clicked the button on the page";
    }
</script>
```

###Interacting with User Controls###

```
<%@ Control Language="C#" ClassName="Listing07_04" %>
<script runat="server">
    public string Text { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Label1.Text = this.Text;
    }
</script>
<asp:Label ID="Label1" runat="server" Text="Label">
</asp:Label>
```

```
protected void Page_Load(Object sender, EventArgs e)
{
     Listing0704.Text = "The quick brown fox jumped over the lazy dog";
}
```

###Loading User Controls Dynamically###

You can also create and add user controls to the Web Form dynamically at run time.

The ASP.NET Page object includes the LoadControl method,

```
Control myForm = Page.FindControl("Form1");
Control c1 = LoadControl("Listing07-04.ascx");
myForm.Controls.Add(c1);

```
> *NOTE* Adding user controls that contain certain ASP.NET elements such as a Label, HyperLink, or Image directly to the Page object’s Controls collection is possible; however, it is generally safer to be consistent and add them to the Form. Adding a control that must be contained within the Form, such as a Button control, to the Page object’s Controls collection results in a runtime parser error.


> *NOTE* Remember that you need to re-add your control to the ASP.NET page each time the page performs a postback.


```
<%@ Page Language="C#" %>
   <!DOCTYPE html>
   <script runat="server">
     protected void Page_Load(object sender, EventArgs e)
     {
         Control myForm = Page.FindControl("Form1");
         Listing07_04 c1 = (Listing07_04)LoadControl("Listing07-04.ascx");
         myForm.Controls.Add(c1);
         c1.ID = "Listing07_04";
         c1.Text = "Text about our custom user control.";
     }
   </script>
```

Notice that the sample adds the control to the Form’s Controls collection and then sets the Text property. The ordering of this is important because after a page postback occurs the control’s ViewState is not calculated until the control is added to the Controls collection. Therefore, if you set the Text value (or any other property of the user control) before the control’s ViewState is calculated, the value is not persisted in the ViewState.

One additional twist to adding user controls dynamically occurs when you are using output caching to cache the user controls. In this case, after the control has been cached, the LoadControl method does not return a new instance of the control. Instead, it returns the cached copy of the control.

This presents problems when you try to cast the control to its native type because, after the control is cached, the LoadControl method returns it as a PartialCachingControl object rather than as its native type.

To solve this problem, you simply test the object type before attempting the cast.

```
Control myForm = Page.FindControl("Form1");
Control c1 = LoadControl("Listing07-04.ascx");
myForm.Controls.Add(c1);
    if (c1 is Listing07_04)
    {
        ((Listing07_04)c1).ID = "Listing07_04";
        ((Listing07_04)c1).Text = "Text about our custom user control (not cached)";
     }
     else if ((c1 is PartialCachingControl) &&
       ((PartialCachingControl)c1).CachedControl != null)
     {
         Listing07_04 listingControl =
           ((Listing07_04)((PartialCachingControl)c1).CachedControl);
         listingControl.ID = "Listing07_04";
         listingControl.Text = "Text about our custom user control (partially cached)";
     }
}
```

there may be times when you want to add the control in a different event, such as a Button’s Click event or the SelectedIndexChanged event of a DropDownList control. Using these events to add user controls dynamically presents new challenges. Because these events may not be raised each time a page postback occurs,

A simple way to do this is to use the ASP.NET session to track when the user control is added to the web page.

```
<%@ Page Language="C#" %>
<!DOCTYPE html>
<script runat="server">
protected void Page_Load(object sender, EventArgs e)
{
    if ((Session["Listing07-04"] == null) || (!(bool)Session["Listing07-04"]))
    {
        Control myForm = Page.FindControl("Form1");
        Control c1 = LoadControl("Listing07-04.ascx");
        ((Listing07_04)c1).Text = "Loaded after first page load";
        myForm.Controls.Add(c1);
        Session["Listing07-04"] = true;
    }
}
protected void Button1_Click(object sender, EventArgs e)
{
    if ((Session["Listing07-04"] != null) && ((bool)Session["Listing07-04"]))
    {
        Control myForm = Page.FindControl("Form1");
        Control c1 = LoadControl("Listing07-04.ascx");
        ((Listing07_04)c1).Text = "Loaded after a postback";
        myForm.Controls.Add(c1);
    }
}
</script>
```


