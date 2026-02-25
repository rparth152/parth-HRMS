<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminDocList.aspx.cs" Inherits="parth_HRMS.AdminDocList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<head runat="server">
    <title>Admin Document Name List</title>

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
    font-family: "Segoe UI", sans-serif;
    background: #f5f7fb;
    margin: 0;
    padding: 20px;
}

/* Right aligned page wrapper */
.page-wrapper {
    max-width: 500px;
    margin-left: auto;   /* pushes content to the right */
}

/* Header */
.page-title {
    font-size: 24px;
    font-weight: 600;
    color: #2c3e50;
}

.breadcrumb {
    font-size: 14px;
    color: #6c757d;
    margin-bottom: 20px;
}

/* Card */
.card {
    background: #fff;
    border: 1px solid #e3e6f0;
    border-radius: 6px;
    padding: 20px;
}

.card-title {
    font-weight: 600;
    margin-bottom: 15px;
}

/* Button */
.btn-orange {
    background: #f26522;
    color: #fff;
    border: none;
    padding: 8px 18px;
    border-radius: 4px;
}

.btn-orange:hover {
    background: #d9541b;
}

/* Table */
table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background: #eef1f7;
    padding: 10px;
    text-align: left;
}

td {
    padding: 10px;
    border-top: 1px solid #e3e6f0;
}
    </style>
</head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
  

    <!-- Page Title -->
    <div class="page-title">Admin Document Name List</div>
    

    <!-- Add Button -->
    <div style="text-align:right; margin-bottom:10px;">
        <asp:Button ID="btnAdd" runat="server" Text="Add Document" CssClass="btn-orange" OnClick="btnAdd_Click" />
    </div>

    <!-- Card -->
    <div class="card">

        <div class="card-title">Admin Document Name List</div>

        <!-- Controls -->
        <div style="display:flex; justify-content:space-between; margin-bottom:10px;">

            <div>
                Row Per Page
                <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div>
                Search:
                <asp:TextBox ID="txtSearch" runat="server"
                    AutoPostBack="true"
                    OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
            </div>

        </div>

        <!-- Grid -->
        <asp:GridView ID="GridView1" runat="server"
            AutoGenerateColumns="False"
            DataKeyNames="Id"
            AllowPaging="true"
            PageSize="5"
            DataSourceID="SqlDataSource1">

            <Columns>

    <asp:BoundField DataField="Id" HeaderText="Document ID" ReadOnly="True" />

    <asp:BoundField DataField="DocName" HeaderText="Document Name" />

    <%-- Action Column --%>
    <asp:TemplateField HeaderText="Action">
        <ItemTemplate>

            <asp:LinkButton ID="EditButton" runat="server"
                CommandName="Edit"
                CssClass="me-2"
                ToolTip="Edit">
                <i class="bi bi-pencil-square text-primary"></i>
            </asp:LinkButton>

            <asp:LinkButton ID="DeleteButton" runat="server"
                CommandName="Delete"
                OnClientClick="return confirm('Delete this document?');"
                ToolTip="Delete">
                <i class="bi bi-trash text-danger"></i>
            </asp:LinkButton>

        </ItemTemplate>
    </asp:TemplateField>

</Columns>

        </asp:GridView>

        <!-- SQL DataSource -->
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:dbconn %>"
            SelectCommand="SELECT * FROM addAdminDocNames"
            DeleteCommand="DELETE FROM addAdminDocNames WHERE Id=@Id">

            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>

        </asp:SqlDataSource>

    </div>


</asp:Content>




