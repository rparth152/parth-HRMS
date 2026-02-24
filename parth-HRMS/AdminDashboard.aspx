<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="AdminDashboard.aspx.cs"
    Inherits="parth_HRMS.AdminDashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
    .card {
        margin-top: 30px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        border-radius: 10px;
    }

    .card-header {
        background-color: #f8f9fa;
        font-weight: 600;
    }

    canvas {
        max-width: 100% !important;
    }
</style>
    <div class="container-fluid">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card">
                <div class="card-header">
                    <h4>User Status Overview</h4>
                </div>
                <div class="card-body text-center">

                    <asp:Chart ID="Chart1" runat="server" Width="400px" Height="300px">
                        <Series>
                            <asp:Series Name="UserStatus"
                                ChartType="Pie"
                                XValueMember="Status"
                                YValueMembers="TotalCount">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>

                </div>
            </div>
        </div>
    </div>
</div>


</asp:Content>
