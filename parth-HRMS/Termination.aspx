<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Termination.aspx.cs" Inherits="parth_HRMS.Termination" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Termination</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
    body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    .card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.05); border-radius: 8px; }
    .btn-orange { background-color: #f37021; color: white; border: none; }
    .btn-orange:hover { background-color: #d65c17; color: white; }
    .table-header th { background-color: #e9ecef !important; color: #333 !important; font-weight: 600; }
    .avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; margin-right: 10px; }
    .action-icon { color: #6c757d; cursor: pointer; margin: 0 5px; text-decoration: none; }
    .action-icon:hover { color: #000; }
    .page-link { color: #6c757d; }
    .page-item.active .page-link { background-color: #f8f9fa; border-color: #dee2e6; color: #000; font-weight: bold; }
    .breadcrumb-text { color: #6c757d; font-size: 0.9rem; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div class="container-fluid p-4">
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold mb-0" style="color: #2c3e50;">Termination</h2>
                    <div class="breadcrumb-text mt-1"><i class="fas fa-home"></i> / Performance / Termination</div>
                </div>
                <button type="button" class="btn btn-orange px-4 py-2" onclick="clearModal();" data-bs-toggle="modal" data-bs-target="#addTerminationModal">
                    <i class="fas fa-plus-circle me-1"></i> Add Termination
                </button>
            </div>

            <div class="card p-3">
                
                <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-3">
                    <h5 class="mb-0 fw-bold">Termination List</h5>
                    <div class="d-flex gap-2">
                        <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed" CssClass="form-select form-select-sm">
                            <asp:ListItem Text="Sort By: Ascending" Value="ASC"></asp:ListItem>
                            <asp:ListItem Text="Sort By: Descending" Value="DESC"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlFilterDate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed" CssClass="form-select form-select-sm">
                            <asp:ListItem Text="All Records" Value="All"></asp:ListItem>
                            <asp:ListItem Text="Today" Value="Today"></asp:ListItem>
                            <asp:ListItem Text="Tomorrow" Value="Tomorrow"></asp:ListItem>
                            <asp:ListItem Text="Last 7 Days" Value="Last7Days"></asp:ListItem>
                            <asp:ListItem Text="Last Month" Value="LastMonth"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="d-flex align-items-center gap-2">
                        <span>Show</span>
                        <asp:DropDownList ID="ddlEntries" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed" CssClass="form-select form-select-sm w-auto">
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
                                <th>Employee Name </th>
                                <th>Termination Type </th>
                                <th>Notice Date </th>
                                <th>Resign Date </th>
                                <th>Reason </th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptTerminations" runat="server" OnItemCommand="rptTerminations_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src='<%# Eval("AvatarUrl") %>' class="avatar" alt="User" />
                                                <span><%# Eval("EmployeeName") %></span>
                                            </div>
                                        </td>
                                        <td><%# Eval("TerminationType") %></td> <td><%# Convert.ToDateTime(Eval("NoticeDate")).ToString("yyyy-MM-dd") %></td>
                                        <td><%# Convert.ToDateTime(Eval("ResignDate")).ToString("yyyy-MM-dd") %></td>
                                        <td><%# Eval("Reason") %></td>
                                        <td>
                                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="action-icon" CommandName="Edit" CommandArgument='<%# Eval("TerminationId") %>'>
                                                <i class="far fa-edit"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-icon" CommandName="Delete" CommandArgument='<%# Eval("TerminationId") %>' OnClientClick="return confirm('Are you sure you want to delete this record?');">
                                                <i class="far fa-trash-alt"></i>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="<tr><td colspan='6' class='text-center'>No records found.</td></tr>"></asp:Label>
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

        <div class="modal fade" id="addTerminationModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title fw-bold" id="modalTitle">Add Termination</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <asp:HiddenField ID="hfTerminationId" runat="server" />
                  <div class="mb-3">
                      <label class="form-label text-muted">Employee</label>
                      <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-select"></asp:DropDownList>
                  </div>
                  <div class="mb-3">
                      <label class="form-label text-muted">Termination Type</label>
                      <asp:DropDownList ID="ddlTerminationType" runat="server" CssClass="form-select">
                          <asp:ListItem Text="Select Termination Type" Value=""></asp:ListItem>
                          <asp:ListItem Text="Lack of Skills" Value="Lack of Skills"></asp:ListItem>
                          <asp:ListItem Text="Retirement" Value="Retirement"></asp:ListItem>
                          <asp:ListItem Text="Insubordination" Value="Insubordination"></asp:ListItem>
                          <asp:ListItem Text="Layoff" Value="Layoff"></asp:ListItem>
                          <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                      </asp:DropDownList>
                  </div>
                  <div class="mb-3">
                      <label class="form-label text-muted">Notice Date</label>
                      <asp:TextBox ID="txtNoticeDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                  </div>
                  <div class="mb-3">
                      <label class="form-label text-muted">Resign Date</label>
                      <asp:TextBox ID="txtResignDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                  </div>
                  <div class="mb-3">
                      <label class="form-label text-muted">Reason</label>
                      <asp:TextBox ID="txtReason" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" required="true"></asp:TextBox>
                  </div>
              </div>
              <div class="modal-footer justify-content-start">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-orange" OnClick="btnSubmit_Click" />
              </div>
            </div>
          </div>
        </div>

        <script type="text/javascript">
            function openModal() {
                var myModal = new bootstrap.Modal(document.getElementById('addTerminationModal'));
                myModal.show();
            }
            function clearModal() {
                document.getElementById('<%= hfTerminationId.ClientID %>').value = '';
                document.getElementById('<%= ddlEmployee.ClientID %>').selectedIndex = 0;
                document.getElementById('<%= ddlTerminationType.ClientID %>').selectedIndex = 0;
                document.getElementById('<%= txtNoticeDate.ClientID %>').value = '';
                document.getElementById('<%= txtResignDate.ClientID %>').value = '';
                document.getElementById('<%= txtReason.ClientID %>').value = '';
                document.getElementById('modalTitle').innerText = 'Add Termination';
                document.getElementById('<%= btnSubmit.ClientID %>').value = 'Submit';
            }
        </script>

    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
