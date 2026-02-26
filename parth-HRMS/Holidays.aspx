<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Holidays.aspx.cs" Inherits="parth_HRMS.Holidays" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>Holidays / Event Types</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
<style>
    body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    .card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.05); border-radius: 8px; }
    .btn-orange { background-color: #f37021; color: white; border: none; font-weight: 500; }
    .btn-orange:hover { background-color: #d65c17; color: white; }
    .table-header th { background-color: #e9ecef !important; color: #333 !important; font-weight: 600; border-bottom: none; }
    .action-icon { color: #6c757d; cursor: pointer; text-decoration: none; }
    .action-icon:hover { color: #dc3545; } /* Red on hover for delete */
    .color-sample { width: 30px; height: 30px; border-radius: 4px; display: inline-block; border: 1px solid #dee2e6; }
    .breadcrumb-text { color: #6c757d; font-size: 0.9rem; }
    
    /* Custom styling for HTML5 color picker to match screenshot */
    .form-control-color { width: 60px; height: 40px; padding: 0.2rem; cursor: pointer; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-4">
    <div class="mb-4">
        <h2 class="fw-bold mb-0" style="color: #2c3e50;">Holidays</h2>
        <div class="breadcrumb-text mt-1"><i class="fas fa-home"></i> / Event / Holidays List</div>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-md-5 mb-4">
                    <div class="card p-4 h-100">
                        <h5 class="fw-bold mb-4">Add Event Type</h5>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Event Type Name</label>
                            <asp:TextBox ID="txtEventTypeName" runat="server" CssClass="form-control" placeholder="e.g. Holiday, Meeting" required="true"></asp:TextBox>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-semibold">Color</label>
                            <div>
                                <asp:TextBox ID="txtColor" runat="server" TextMode="Color" CssClass="form-control form-control-color" ToolTip="Choose your color"></asp:TextBox>
                            </div>
                            <small class="text-muted mt-1 d-block">Choose a color for this event type</small>
                        </div>
                        
                        <div>
                            <asp:Button ID="btnAddEventType" runat="server" Text="Add Event Type" CssClass="btn btn-orange px-4 py-2" OnClick="btnAddEventType_Click" />
                        </div>
                    </div>
                </div>

                <div class="col-md-7 mb-4">
                    <div class="card p-4 h-100">
                        <h5 class="fw-bold mb-4">Existing Event Types</h5>
                        
                        <div class="table-responsive">
                            <table class="table align-middle">
                                <thead class="table-header">
                                    <tr>
                                        <th>Name</th>
                                        <th>Color</th>
                                        <th>Sample</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptEventTypes" runat="server" OnItemCommand="rptEventTypes_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("Name") %></td>
                                                <td><%# Eval("Color") %></td>
                                                <td>
                                                    <div class="color-sample" style='<%# "background-color: " + Eval("Color") + ";" %>'></div>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-icon" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' OnClientClick="return confirm('Are you sure you want to delete this Event Type?');">
                                                        <i class="far fa-trash-alt"></i>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="<tr><td colspan='4' class='text-center text-muted'>No event types found.</td></tr>"></asp:Label>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
</asp:Content>
