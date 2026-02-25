<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EmpDocList.aspx.cs" Inherits="parth_HRMS.EmpDocList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Employee Document Name List</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #f5f6fa;
        }
        .card-custom {
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .page-title {
            font-weight: 600;
            color: #2c3e50;
        }
        .btn-orange {
            background-color: #ff6b2c;
            color: white;
            border: none;
        }
        .btn-orange:hover {
            background-color: #e85a1f;
            color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid mt-4">

        <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h3 class="page-title">Employee Document Name List</h3>
            
        </div>

        <asp:Button ID="btnAdd" runat="server" Text="+ Add Document"
            CssClass="btn btn-orange px-4 py-2" OnClick="btnAdd_Click"/>
    </div>

    <!-- Card -->
    <div class="card card-custom">
        <div class="card-body">

            <!-- Top Controls -->
            <div class="row mb-3">
                <div class="col-md-6 d-flex align-items-center">
                    <label class="me-2">Row Per Page</label>
                    <asp:DropDownList ID="ddlPageSize" runat="server"
                        CssClass="form-select w-auto">
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>25</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-6 text-end">
                    <label class="me-2">Search:</label>
                    <asp:TextBox ID="txtSearch" runat="server"
                        CssClass="form-control d-inline w-auto"
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
                AllowPaging="True"
                PageSize="5">

                <Columns>

                    <asp:BoundField DataField="Id" HeaderText="Document ID"
                        ReadOnly="True" />

                    <asp:BoundField DataField="DocName"
                        HeaderText="Document Name" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server"
                                CommandName="Edit"
                                CssClass="btn btn-sm btn-outline-primary me-1">
                                ✏
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" runat="server"
                                CommandName="Delete"
                                CssClass="btn btn-sm btn-outline-danger"
                                OnClientClick="return confirm('Delete this record?');">
                                🗑
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>

            <!-- Data Source -->
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:dbconn %>"
                SelectCommand="SELECT * FROM addEmpDocNames"
                InsertCommand="INSERT INTO addEmpDocNames (DocName) VALUES (@DocName)"
                UpdateCommand="UPDATE addEmpDocNames SET DocName=@DocName WHERE Id=@Id"
                DeleteCommand="DELETE FROM addEmpDocNames WHERE Id=@Id">

                <InsertParameters>
                    <asp:Parameter Name="DocName" Type="String" />
                </InsertParameters>

                <UpdateParameters>
                    <asp:Parameter Name="DocName" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>

                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>

        </div>
    </div>

</div>
</asp:Content>
