<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="addAdminDoc.aspx.cs" Inherits="parth_HRMS.addAdminDoc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add Admin Document Name</title>

    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f5f7fb;
            margin: 0;
            padding: 20px;
        }

        .page-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #2c3e50;
        }

        .breadcrumb {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 20px;
        }

        .card {
            background: #fff;
            border-radius: 6px;
            border: 1px solid #e3e6f0;
            padding: 20px;
        }

        .card-title {
            font-weight: 600;
            margin-bottom: 20px;
        }

        .form-control {
            width: 320px;
            padding: 8px 10px;
            border-radius: 4px;
            border: 1px solid #ced4da;
        }

        .btn-orange {
            background: #f26522;
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-orange:hover {
            background: #d9541b;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-title">&nbsp;&nbsp;&nbsp; Add Admin Document Name</div>
    <div class="breadcrumb">Admin / Add Admin Document Name</div>

    <div class="card">
        <div class="card-title">Add Admin Document Name</div>

        <label>Document Name</label><br />

        <asp:TextBox 
            ID="TextBox1" 
            runat="server" 
            CssClass="form-control"
            placeholder="Enter Document Name">
        </asp:TextBox>

        <br /><br />

        <asp:Button 
            ID="Button1" 
            runat="server" 
            Text="Add" 
            CssClass="btn-orange"
            OnClick="Button1_Click" />

    </div>

</asp:Content>
