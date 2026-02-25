<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EmpFileUpload.aspx.cs" Inherits="parth_HRMS.EmpFileUpload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>File Upload</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            background: #f5f6f8;
        }

        .card-custom {
            border-radius: 8px;
            border: 1px solid #e4e7ec;
        }

        .btn-orange {
            background-color: #f26522;
            color: white;
            border-radius: 6px;
            border: none;
            width: 38px;
            height: 38px;
            font-size: 18px;
            font-weight: bold;
        }

        .btn-orange:hover {
            background-color: #e55a1c;
        }

        .btn-save {
            background-color: #f26522;
            color: white;
            border-radius: 6px;
            border: none;
            padding: 8px 22px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <h4 class="mb-3">File Upload</h4>

        <div class="card card-custom p-4">

            <!-- User -->
            <div class="mb-3">
                <label class="form-label fw-semibold">User</label>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <!-- Row 1 -->
            <div class="row align-items-center mb-3">

                <div class="col-md-5">
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Placeholder="Document Name"></asp:TextBox>
                </div>

                <div class="col-md-5">
                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-2 text-end">
                    <button type="button" class="btn btn-orange" onclick="document.getElementById('<%= Panel2.ClientID %>').style.display='block'">
                        +
                    </button>
                </div>

            <!-- Row 2 -->
            <asp:Panel ID="Panel2" runat="server" Style="display:none;">

                <div class="row align-items-center mb-3">

                    <div class="col-md-5">
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" Placeholder="Document Name"></asp:TextBox>
                    </div>

                    <div class="col-md-5">
                        <asp:FileUpload ID="FileUpload2" runat="server" CssClass="form-control" />
                    </div>

                    <div class="col-md-2 text-end">
                        <asp:LinkButton ID="btnDeleteRow2" runat="server"
                            CssClass="btn btn-light border"
                            OnClick="btnDeleteRow2_Click">
                            <i class="bi bi-trash"></i>
                        </asp:LinkButton>

                    </div>

                </div>

            </asp:Panel>

            <!-- Save -->
            <div class="mt-3">
                <asp:Button ID="Button1" runat="server" Text="Save" CssClass="btn-save" OnClick="Button1_Click" />
            </div>

        </div>

    </div>

</asp:Content>
