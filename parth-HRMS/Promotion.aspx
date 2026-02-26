<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Promotion.aspx.cs" Inherits="parth_HRMS.Promotion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Promotion Page</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
    body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    .card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.05); border-radius: 8px; }
    .btn-orange { background-color: #f37021; color: white; border: none; }
    .btn-orange:hover { background-color: #d65c17; color: white; }
    .table-header th { background-color: #d6d8db !important; color: #333 !important; }
    .avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; margin-right: 10px; }
    .action-icon { color: #6c757d; cursor: pointer; margin: 0 5px; text-decoration: none; }
    .action-icon:hover { color: #000; }
    .page-link { color: #6c757d; }
    .page-item.active .page-link { background-color: #f8f9fa; border-color: #dee2e6; color: #000; font-weight: bold; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div class="container-fluid p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold" style="color: #2c3e50;">Promotion</h2>
                <button type="button" class="btn btn-orange px-4 py-2" data-bs-toggle="modal" data-bs-target="#addPromotionModal" onclick="clearModal();">
                    <i class="fas fa-plus-circle me-1"></i> Add Promotion
                </button>
            </div>

            <div class="card p-3">
                <!-- Filters -->
                <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-3">
                    <h5 class="mb-0 fw-bold">Promotion List</h5>
                    <div class="d-flex gap-2">
                        <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed" CssClass="form-select form-select-sm">
                            <asp:ListItem Text="Sort By: Ascending" Value="ASC"></asp:ListItem>
                            <asp:ListItem Text="Descending" Value="DESC"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlFilterDate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed" CssClass="form-select form-select-sm">
                            <asp:ListItem Text="Filter By Date : All Records" Value="All"></asp:ListItem>
                            <asp:ListItem Text="Today" Value="Today"></asp:ListItem>
                            <asp:ListItem Text="Last 7 Days" Value="Last7Days"></asp:ListItem>
                            <asp:ListItem Text="Last Month" Value="LastMonth"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <!-- Entries & Search -->
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
                        <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" OnTextChanged="Filter_Changed" CssClass="form-control form-control-sm" placeholder="Search employee..."></asp:TextBox>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-bordered align-middle">
                        <thead class="table-header text-muted">
                            <tr>
                                <th>Employee Name </th>
                                <th>Designation From </th>
                                <th>Designation To  </th>
                                <th>Promotion Date  </th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptPromotions" runat="server" OnItemCommand="rptPromotions_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src='<%# Eval("AvatarUrl") %>' class="avatar" alt="User" />
                                                <span><%# Eval("EmployeeName") %></span>
                                            </div>
                                        </td>
                                        <td><%# Eval("DesignationFrom") %></td>
                                        <td><%# Eval("DesignationTo") %></td>
                                        <td><%# Convert.ToDateTime(Eval("Date")).ToString("yyyy-MM-dd") %></td>
                                        <td>
                                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="action-icon" CommandName="Edit" CommandArgument='<%# Eval("PromotionId") %>'>
                                                <i class="far fa-edit"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-icon" CommandName="Delete" CommandArgument='<%# Eval("PromotionId") %>' OnClientClick="return confirm('Are you sure you want to delete this record?');">
                                                <i class="far fa-trash-alt"></i>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <tr>
                                        <td colspan="5" class="text-center">
                                            <asp:Label ID="lblEmptyData" runat="server" Text="No records found." Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                </FooterTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
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

        <!-- Modal -->
        <div class="modal fade" id="addPromotionModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Add Promotion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <asp:HiddenField ID="hfPromotionId" runat="server" />
                  <div class="mb-3">
                      <label>Select Employee</label>
                      <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-select"></asp:DropDownList>
                  </div>
                  <div class="mb-3">
                      <label>Designation From</label>
                      <asp:TextBox ID="txtDesigFrom" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                  </div>
                  <div class="mb-3">
                      <label>Designation To</label>
                      <asp:TextBox ID="txtDesigTo" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                  </div>
                  <div class="mb-3">
                      <label>Promotion Date</label>
                      <asp:TextBox ID="txtPromoDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                  </div>
              </div>
              <div class="modal-footer">
                <asp:Button ID="btnSubmitPromotion" runat="server" Text="Submit" CssClass="btn btn-orange" OnClick="btnSubmitPromotion_Click" />
              </div>
            </div>
          </div>
        </div>

        <script type="text/javascript">
            function openModal() {
                var myModal = new bootstrap.Modal(document.getElementById('addPromotionModal'));
                myModal.show();
            }
            function clearModal() {
                document.getElementById('<%= hfPromotionId.ClientID %>').value = '';
                document.getElementById('<%= ddlEmployee.ClientID %>').selectedIndex = 0;
                document.getElementById('<%= txtDesigFrom.ClientID %>').value = '';
                document.getElementById('<%= txtDesigTo.ClientID %>').value = '';
                document.getElementById('<%= txtPromoDate.ClientID %>').value = '';
                document.getElementById('modalTitle').innerText = 'Add Promotion';
            }
        </script>

    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
