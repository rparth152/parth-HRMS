<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="webformDesignation.aspx.cs" Inherits="parth_HRMS.Designation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Department name:-<asp:DropDownList ID="DropDownList1" runat="server">
            </asp:DropDownList>
            <br />
            <br />
            Designation Name:-<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <br />
            Status:-<asp:DropDownList ID="DropDownList2" runat="server">
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add" />
        </div>
        <asp:GridView ID="GridView1" runat="server" >
        </asp:GridView>
    </form>
</body>
</html>
