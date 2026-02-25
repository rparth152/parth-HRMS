<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminFileUpl.aspx.cs" Inherits="parth_HRMS.AdminFileUpl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f1f3f7;
        }

        .card-custom {
            background: #fff;
            border-radius: 10px;
            border: 1px solid #e4e6ef;
        }

        .card-header-custom {
            font-weight: 600;
            font-size: 18px;
            color: #2c3e50;
            background: #fff;
            border-bottom: 1px solid #eee;
        }

        .btn-orange {
            background-color: #ff6a00;
            color: #fff;
            border: none;
        }

        .btn-orange:hover {
            background-color: #e85c00;
            color: #fff;
        }
    </style>

    <script>
        function addRow() {
            var container = document.getElementById("fileRows");
            var firstRow = container.querySelector(".file-row");
            var newRow = firstRow.cloneNode(true);

            newRow.querySelector("input[type='file']").value = "";
            container.appendChild(newRow);
        }

        function removeRow(btn) {
            var row = btn.closest(".file-row");
            var container = document.getElementById("fileRows");

            if (container.children.length > 1) {
                row.remove();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

    <div class="card card-custom shadow-sm">

        <!-- Header -->
        <div class="card-header card-header-custom">
            Admin File Upload
        </div>

        <!-- Body -->
        <div class="card-body">

            <!-- User -->
            <div class="mb-3">
                <label class="form-label">User</label>
                <asp:TextBox ID="txtUser" runat="server"
                    CssClass="form-control"
                    Placeholder="Enter user name"></asp:TextBox>
            </div>

            <!-- Files Section -->
            <label class="form-label">Upload Documents</label>

            <div id="fileRows">

                <!-- Row -->
                <div class="row mb-3 align-items-center file-row">

                    <div class="col-md-4">
                        <asp:DropDownList ID="DropDownList1" runat="server"
                            CssClass="form-select">
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <asp:FileUpload ID="FileUpload1" runat="server"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-2 text-end">
                        <button type="button" class="btn btn-orange me-1"
                            onclick="addRow()">
                            <i class="bi bi-plus"></i>
                        </button>

                        <button type="button" class="btn btn-outline-secondary"
                            onclick="removeRow(this)">
                            <i class="bi bi-trash"></i>
                        </button>
                    </div>

                </div>

            </div>

            <!-- Save Button -->
            <div class="mt-3">
                <asp:Button ID="btnSave" runat="server"
                    Text="Save Files"
                    CssClass="btn btn-orange px-4"
                    OnClick="btnSave_Click" />
            </div>

        </div>
    </div>

</div>
</asp:Content>
