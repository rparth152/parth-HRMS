<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HolidaysList.aspx.cs" Inherits="parth_HRMS.HolidaysList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <title>Holidays List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.05); border-radius: 8px; }
        .btn-orange { background-color: #f37021; color: white; border: none; font-weight: 500;}
        .btn-orange:hover { background-color: #d65c17; color: white; }
        .table-header th { background-color: #e9ecef !important; color: #333 !important; font-weight: 600; }
        .action-icon { color: #6c757d; cursor: pointer; margin: 0 5px; text-decoration: none; }
        .action-icon:hover { color: #000; }
        .page-link { color: #6c757d; }
        .page-item.active .page-link { background-color: #f8f9fa; border-color: #dee2e6; color: #000; font-weight: bold; }
        .breadcrumb-text { color: #6c757d; font-size: 0.9rem; }
        
       
        /* Active Status Badge Styling */
.badge-active { background-color: #0acf97; color: white; padding: 6px 12px; border-radius: 4px; font-weight: 600; font-size: 0.85rem; text-decoration: none; display: inline-block;}
.badge-active:hover { color: white; }
.badge-active i { font-size: 8px; vertical-align: middle; margin-right: 4px; }

/* Inactive Status Badge Styling (Red color) */
.badge-inactive { background-color: #dc3545; color: white; padding: 6px 12px; border-radius: 4px; font-weight: 600; font-size: 0.85rem; text-decoration: none; display: inline-block;}
.badge-inactive:hover { color: white; }
.badge-inactive i { font-size: 8px; vertical-align: middle; margin-right: 4px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="container-fluid p-4">
                    
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="fw-bold mb-0" style="color: #2c3e50;">Holidays</h2>
                            <div class="breadcrumb-text mt-1"><i class="fas fa-home"></i> / Event / Holidays List</div>
                        </div>
                        <button type="button" class="btn btn-orange px-4 py-2" data-bs-toggle="modal" data-bs-target="#addHolidayModal" onclick="clearModal();">
                            <i class="fas fa-plus-circle me-1"></i> Add Holiday
                        </button>
                    </div>

                    <div class="card p-3">
                        <div class="border-bottom pb-3 mb-3">
                            <h5 class="mb-0 fw-bold">Holidays Details</h5>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="d-flex align-items-center gap-2">
                                <span>Show</span>
                                <asp:DropDownList ID="ddlEntries" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed" CssClass="form-select form-select-sm w-auto">
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                    <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                </asp:DropDownList>
                                <span>entries</span>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <span>Search:</span>
                                <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" OnTextChanged="Filter_Changed" CssClass="form-control form-control-sm"></asp:TextBox>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-bordered align-middle">
                                <thead class="table-header text-muted">
                                    <tr>
                                        <th>ID </th>
                                        <th>Title </th>
                                        <th>Status </th>
                                        <th>Date </th>
                                        <th>Action </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptHolidays" runat="server" OnItemCommand="rptHolidays_ItemCommand">
                                        <ItemTemplate>
    <tr>
        <td><%# Eval("Id") %></td>
        <td><%# Eval("Title") %></td>
        
        <td>
            <asp:LinkButton ID="btnToggleStatus" runat="server" 
                CommandName="ToggleStatus" 
                CommandArgument='<%# Eval("Id") %>'
                CssClass='<%# Eval("Status").ToString() == "Active" ? "badge-active" : "badge-inactive" %>'>
                <i class="fas fa-circle"></i> <%# Eval("Status") %>
            </asp:LinkButton>
        </td>
        <td><%# Eval("Date") %></td>
        <td>
            <asp:LinkButton ID="btnEdit" runat="server" CssClass="action-icon" CommandName="Edit" CommandArgument='<%# Eval("Id") %>'>
                <i class="far fa-edit"></i>
            </asp:LinkButton>
            <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-icon" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' OnClientClick="return confirm('Are you sure you want to delete this event?');">
                <i class="far fa-trash-alt"></i>
            </asp:LinkButton>
        </td>
    </tr>
</ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="<tr><td colspan='5' class='text-center'>No records found.</td></tr>"></asp:Label>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mt-2">
                            <asp:Label ID="lblShowingText" runat="server" CssClass="text-muted"></asp:Label>
                            <nav>
                                <ul class="pagination pagination-sm mb-0">
                                    <li class="page-item <%= CurrentPage == 0 ? "disabled" : "" %>">
                                        <asp:LinkButton ID="btnPrev" runat="server" CssClass="page-link" OnClick="btnPrev_Click">Previous</asp:LinkButton>
                                    </li>
                                    
                                    <asp:Repeater ID="rptPagination" runat="server" OnItemCommand="rptPagination_ItemCommand">
                                        <ItemTemplate>
                                            <li class="page-item <%# Convert.ToInt32(Eval("PageIndex")) == CurrentPage ? "active" : "" %>">
                                                <asp:LinkButton ID="btnPage" runat="server" CssClass="page-link" CommandName="Page" CommandArgument='<%# Eval("PageIndex") %>'>
                                                    <%# Eval("PageText") %>
                                                </asp:LinkButton>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <li class="page-item <%= CurrentPage == TotalPages - 1 || TotalPages == 0 ? "disabled" : "" %>">
                                        <asp:LinkButton ID="btnNext" runat="server" CssClass="page-link" OnClick="btnNext_Click">Next</asp:LinkButton>
                                    </li>
                                </ul>
                            </nav>
                        </div>

                    </div>
                </div>

                <div class="modal fade" id="addHolidayModal" tabindex="-1" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title fw-bold" id="modalTitle">Add New Event</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body">
                          <asp:HiddenField ID="hfEventId" runat="server" />
                          <div class="mb-3">
                              <label class="form-label text-muted">Event Title</label>
                              <asp:TextBox ID="txtEventTitle" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                          </div>
                          <div class="mb-3">
                              <label class="form-label text-muted">Event Date</label>
                              <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                          </div>
                          <div class="mb-3">
                              <label class="form-label text-muted">Event Type</label>
                              <asp:DropDownList ID="ddlEventType" runat="server" CssClass="form-select" required="true"></asp:DropDownList>
                          </div>
                      </div>
                      <div class="modal-footer justify-content-start">
                        <asp:Button ID="btnSubmitEvent" runat="server" Text="Add Event" CssClass="btn btn-orange" OnClick="btnSubmitEvent_Click" />
                      </div>
                    </div>
                  </div>
                </div>

                <script type="text/javascript">
                    function openModal() {
                        var myModal = new bootstrap.Modal(document.getElementById('addHolidayModal'));
                        myModal.show();
                    }
                    function clearModal() {
                        document.getElementById('<%= hfEventId.ClientID %>').value = '';
                        document.getElementById('<%= txtEventTitle.ClientID %>').value = '';
                        document.getElementById('<%= txtEventDate.ClientID %>').value = '';
                        document.getElementById('<%= ddlEventType.ClientID %>').selectedIndex = 0;
                        document.getElementById('modalTitle').innerText = 'Add New Event';
                        document.getElementById('<%= btnSubmitEvent.ClientID %>').value = 'Add Event';
                    }
                </script>

            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
