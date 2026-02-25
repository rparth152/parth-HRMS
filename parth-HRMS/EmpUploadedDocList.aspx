<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EmpUploadedDocList.aspx.cs" Inherits="parth_HRMS.EmpUploadedDocList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Uploaded Document List</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <style>
        body {
            background: #f5f7fb;
        }

        .card-custom {
            border-radius: 8px;
            border: 1px solid #e3e6f0;
        }

        .table thead {
            background-color: #f1f3f7;
        }

        .page-title {
            font-weight: 600;
            color: #2c3e50;
        }

        .action-btn {
            font-size: 18px;
            padding: 6px 8px;
            border-radius: 6px;
            transition: 0.2s;
            margin-right: 6px;
        }

        .action-btn:hover {
            background: #eef2f7;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

    <!-- Page Title -->
    <h3 class="page-title mb-3">Uploaded Document List</h3>
    <p class="text-muted">Documents / Uploaded Document List</p>

    <!-- Card -->
    <div class="card card-custom shadow-sm">
        <div class="card-header bg-white fw-semibold">
            Uploaded Document List
        </div>

        <div class="card-body">

            <!-- Controls -->
            <div class="row mb-3 align-items-center">

                <div class="col-md-6">
                    <label class="me-2">Row Per Page</label>
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select d-inline-block w-auto"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>50</asp:ListItem>
                    </asp:DropDownList>
                    <span class="ms-1">Entries</span>
                </div>

                <div class="col-md-6 text-end">
                    <label class="me-2">Search:</label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control d-inline-block w-auto"
                        AutoPostBack="true"
                        OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
                </div>

            </div>

            <!-- Grid -->
            <asp:GridView ID="GridView1" runat="server"
                CssClass="table table-bordered table-hover"
                AutoGenerateColumns="False"
                DataKeyNames="Id"
                DataSourceID="SqlDataSource1"
                AllowPaging="true">

                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Document ID" ReadOnly="True" />
                    <asp:BoundField DataField="DocName" HeaderText="Document Name" />
                    <asp:BoundField DataField="FilePath" HeaderText="User ID" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>

                            <asp:LinkButton ID="btnEdit" runat="server"
                                CommandName="Edit"
                                CssClass="text-primary action-btn"
                                ToolTip="Edit"
                                OnClientClick="return confirm('Do you want to edit this record?');">
                                <i class="bi bi-pencil-square"></i>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" runat="server"
                                CommandName="Delete"
                                CssClass="text-danger action-btn"
                                ToolTip="Delete"
                                OnClientClick="return confirm('Are you sure to delete?');">
                                <i class="bi bi-trash"></i>
                            </asp:LinkButton>

                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

                <EmptyDataTemplate>
                    <div class="text-center p-3">No records found.</div>
                </EmptyDataTemplate>

            </asp:GridView>

        </div>
    </div>

</div>

<!-- SQL DataSource -->
<asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:dbconn %>"
    SelectCommand="SELECT * FROM addEmployeeDocNames"
    UpdateCommand="UPDATE addEmployeeDocNames SET DocName=@DocName, FilePath=@FilePath WHERE Id=@Id"
    DeleteCommand="DELETE FROM addEmployeeDocNames WHERE Id=@Id"
    InsertCommand="INSERT INTO addEmployeeDocNames (DocName, FilePath) VALUES (@DocName,@FilePath)">

    <DeleteParameters>
        <asp:Parameter Name="Id" Type="Int32" />
    </DeleteParameters>

    <UpdateParameters>
        <asp:Parameter Name="DocName" Type="String" />
        <asp:Parameter Name="FilePath" Type="String" />
        <asp:Parameter Name="Id" Type="Int32" />
    </UpdateParameters>

    <InsertParameters>
        <asp:Parameter Name="DocName" Type="String" />
        <asp:Parameter Name="FilePath" Type="String" />
    </InsertParameters>

</asp:SqlDataSource>
</asp:Content>
