<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UplDocList.aspx.cs" Inherits="parth_HRMS.UplDocList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Uploaded Document List</title>

<style>
    body {
        margin: 0;
        font-family: Arial, Helvetica, sans-serif;
        background-color: #f4f6f9;
    }

    /* Page Header */
    .page-header {
        padding: 20px 30px;
        background: #fff;
        border-bottom: 1px solid #ddd;
    }

    .page-title {
        font-size: 26px;
        font-weight: bold;
        color: #2c3e50;
    }

    .breadcrumb {
        color: #6c757d;
        font-size: 14px;
        margin-top: 5px;
    }

    /* Card */
    .card {
        margin: 25px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 0 8px rgba(0,0,0,0.08);
    }

    /* Card Header */
    .card-header {
        padding: 12px 20px;
        font-weight: bold;
        border-bottom: 1px solid #e3e3e3;
        background: #f8f9fa;
    }

    /* Controls Row */
    .controls {
        padding: 15px 20px;
    }

    /* Grid */
    .grid {
        width: 100%;
        border-collapse: collapse;
    }

    .grid th {
        background: #e9ecef;
        padding: 10px;
        border-bottom: 2px solid #dee2e6;
        text-align: center;
    }

    .grid td {
        padding: 10px;
        border-bottom: 1px solid #eee;
        text-align: center;
    }

    .action a {
        margin: 0 5px;
        text-decoration: none;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- PAGE TITLE -->
<div class="page-header">
    <div class="page-title">Uploaded Document List</div>
</div>

<!-- CARD -->
<div class="card">

    <div class="card-header">
        Uploaded Document List
    </div>

    <div class="controls">

        Row Per Page
        <asp:DropDownList ID="DropDownList1" runat="server"
            AutoPostBack="True"
            OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            <asp:ListItem>5</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>20</asp:ListItem>
        </asp:DropDownList>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        Search:
        <asp:TextBox ID="TextBox1" runat="server"
            AutoPostBack="True"
            OnTextChanged="TextBox1_TextChanged"></asp:TextBox>

    </div>

    <asp:GridView ID="GridView1" runat="server"
        CssClass="grid"
        AutoGenerateColumns="False"
        DataKeyNames="id"
        AllowPaging="True"
        OnPageIndexChanging="GridView1_PageIndexChanging"
        OnRowCommand="GridView1_RowCommand">

        <Columns>

            <asp:BoundField DataField="id" HeaderText="Document ID" />
            <asp:BoundField DataField="DocName" HeaderText="Document Name" />
            <asp:BoundField DataField="user" HeaderText="User ID" />

            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <span class="action">
                        <asp:LinkButton ID="btnDownload" runat="server"
                            CommandName="Download"
                            CommandArgument='<%# Eval("FilePath") %>'>⬇</asp:LinkButton>

                        <asp:LinkButton ID="btnDelete" runat="server"
                            CommandName="DeleteDoc"
                            CommandArgument='<%# Eval("id") %>'
                            OnClientClick="return confirm('Delete this document?');">🗑</asp:LinkButton>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</div>

</asp:Content>
