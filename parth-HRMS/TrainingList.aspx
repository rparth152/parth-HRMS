<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TrainingList.aspx.cs" Inherits="parth_HRMS.TrainingList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Training List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
    body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    .card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.05); border-radius: 8px; }
    .btn-orange { background-color: #f37021; color: white; border: none; font-weight: 500;}
    .btn-orange:hover { background-color: #d65c17; color: white; }
    .table-header th { background-color: #e9ecef !important; color: #333 !important; font-weight: 600; }
    .avatar { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; margin-right: 8px; }
    .action-icon { color: #6c757d; cursor: pointer; margin: 0 5px; text-decoration: none; }
    .action-icon:hover { color: #000; }
    .page-link { color: #6c757d; }
    .page-item.active .page-link { background-color: #f8f9fa; border-color: #dee2e6; color: #000; font-weight: bold; }
    .breadcrumb-text { color: #6c757d; font-size: 0.9rem; }
    
    /* Status Badges */
    .badge-active { background-color: #32cd32; color: white; padding: 5px 10px; border-radius: 4px; font-weight: 600; font-size: 0.8rem; text-decoration: none; display: inline-block;}
    .badge-active:hover { color: white; }
    .badge-inactive { background-color: #dc3545; color: white; padding: 5px 10px; border-radius: 4px; font-weight: 600; font-size: 0.8rem; text-decoration: none; display: inline-block;}
    .badge-inactive:hover { color: white; }
    .badge-active i, .badge-inactive i { font-size: 8px; vertical-align: middle; margin-right: 4px; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
 
 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
     <ContentTemplate>
         <div class="container-fluid p-4">
             
             <div class="d-flex justify-content-between align-items-center mb-4">
                 <div>
                     <h2 class="fw-bold mb-0" style="color: #2c3e50;">Training</h2>
                     <div class="breadcrumb-text mt-1"><i class="fas fa-home"></i> / Performance / Training List</div>
                 </div>
                 <button type="button" class="btn btn-orange px-4 py-2" data-bs-toggle="modal" data-bs-target="#addTrainingModal" onclick="clearModal();">
                     <i class="fas fa-plus-circle me-1"></i> Add Training
                 </button>
             </div>

             <div class="card p-3">
                 <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-3">
                     <h5 class="mb-0 fw-bold">Training List</h5>
                     <asp:DropDownList ID="ddlSortFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed" CssClass="form-select form-select-sm w-auto">
                         <asp:ListItem Text="Sort By: Ascending" Value="ASC"></asp:ListItem>
                         <asp:ListItem Text="Descending" Value="DESC"></asp:ListItem>
                         <asp:ListItem Text="Last 7 Days" Value="Last7Days"></asp:ListItem>
                         <asp:ListItem Text="Recently Added" Value="Recent"></asp:ListItem>
                         <asp:ListItem Text="Last Month" Value="LastMonth"></asp:ListItem>
                     </asp:DropDownList>
                 </div>

                 <div class="d-flex justify-content-between align-items-center mb-3">
                     <div class="d-flex align-items-center gap-2">
                         <span>Row Per Page:</span>
                         <asp:DropDownList ID="ddlEntries" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed" CssClass="form-select form-select-sm w-auto">
                             <asp:ListItem Text="5" Value="5"></asp:ListItem>
                             <asp:ListItem Text="10" Value="10"></asp:ListItem>
                             <asp:ListItem Text="25" Value="25"></asp:ListItem>
                         </asp:DropDownList>
                         <span>Entries</span>
                     </div>
                     <div class="d-flex align-items-center gap-2">
                         <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" OnTextChanged="Filter_Changed" CssClass="form-control form-control-sm" placeholder="Search..."></asp:TextBox>
                     </div>
                 </div>

                 <div class="table-responsive">
                     <table class="table table-bordered align-middle">
                         <thead class="table-header text-muted">
                             <tr>
                                 <th>TrainingId </th>
                                 <th>Trainer Name </th>
                                 <th>Training Type </th>
                                 <th>User (Employee) </th>
                                 <th>Training Cost </th>
                                 <th>Description </th>
                                 <th>Status </th>
                                 <th>Start Date </th>
                                 <th>End Date </th>
                                 <th>Actions</th>
                             </tr>
                         </thead>
                         <tbody>
                             <asp:Repeater ID="rptTraining" runat="server" OnItemCommand="rptTraining_ItemCommand">
                                 <ItemTemplate>
                                     <tr>
                                         <td><%# Eval("TrainingId") %></td>
                                         <td>
                                             <div class="d-flex align-items-center">
                                                 <img src='<%# Eval("TrainerAvatar") %>' class="avatar" alt="Trainer" />
                                                 <span><%# Eval("TrainerName") %></span>
                                             </div>
                                         </td>
                                         <td><%# Eval("TrainingTypeName") %></td>
                                         <td>
                                             <div class="d-flex align-items-center">
                                                 <img src='<%# Eval("EmployeeAvatar") %>' class="avatar" alt="User" />
                                                 <span><%# Eval("EmployeeName") %></span>
                                             </div>
                                         </td>
                                         <td><%# Eval("TrainingCost", "{0:0.00}") %></td>
                                         <td><%# Eval("Description") %></td>
                                         <td>
                                             <asp:LinkButton ID="btnToggleStatus" runat="server" 
                                                 CommandName="ToggleStatus" 
                                                 CommandArgument='<%# Eval("TrainingId") %>'
                                                 CssClass='<%# Eval("Status").ToString() == "Active" ? "badge-active" : "badge-inactive" %>'>
                                                 <i class="fas fa-circle"></i> <%# Eval("Status") %>
                                             </asp:LinkButton>
                                         </td>
                                         <td><%# Convert.ToDateTime(Eval("StartDate")).ToString("yyyy-MM-dd") %></td>
                                         <td><%# Convert.ToDateTime(Eval("EndDate")).ToString("yyyy-MM-dd") %></td>
                                         <td>
                                             <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-icon" CommandName="Delete" CommandArgument='<%# Eval("TrainingId") %>' OnClientClick="return confirm('Delete this record?');">
                                                 <i class="far fa-trash-alt"></i>
                                             </asp:LinkButton>
                                             <asp:LinkButton ID="btnEdit" runat="server" CssClass="action-icon" CommandName="Edit" CommandArgument='<%# Eval("TrainingId") %>'>
                                                 <i class="far fa-edit"></i>
                                             </asp:LinkButton>
                                         </td>
                                     </tr>
                                 </ItemTemplate>
                                 <FooterTemplate>
                                     <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="<tr><td colspan='10' class='text-center text-muted'>No records found.</td></tr>"></asp:Label>
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

         <div class="modal fade" id="addTrainingModal" tabindex="-1" aria-hidden="true">
           <div class="modal-dialog modal-lg">
             <div class="modal-content">
               <div class="modal-header">
                 <h5 class="modal-title fw-bold" id="modalTitle">Add Training List</h5>
                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
                   <asp:HiddenField ID="hfTrainingId" runat="server" />
                   
                   <div class="mb-3">
                       <label class="form-label text-muted">Trainer</label>
                       <asp:DropDownList ID="ddlTrainer" runat="server" CssClass="form-select" required="true"></asp:DropDownList>
                   </div>
                   
                   <div class="mb-3">
                       <label class="form-label text-muted">Training Type</label>
                       <asp:DropDownList ID="ddlTrainingType" runat="server" CssClass="form-select" required="true"></asp:DropDownList>
                   </div>
                   
                   <div class="mb-3">
                       <label class="form-label text-muted">Employee</label>
                       <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-select" required="true"></asp:DropDownList>
                   </div>
                   
                   <div class="mb-3">
                       <label class="form-label text-muted">Training Cost</label>
                       <asp:TextBox ID="txtTrainingCost" runat="server" CssClass="form-control" TextMode="Number" step="0.01" required="true"></asp:TextBox>
                   </div>
                   
                   <div class="mb-3">
                       <label class="form-label text-muted">Description</label>
                       <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                   </div>
                   
                   <div class="mb-3">
                       <label class="form-label text-muted">Status</label>
                       <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                           <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                           <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                       </asp:DropDownList>
                   </div>
                   
                   <div class="mb-3">
                       <label class="form-label text-muted">Start Date</label>
                       <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                   </div>
                   
                   <div class="mb-3">
                       <label class="form-label text-muted">End Date</label>
                       <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                   </div>

               </div>
               <div class="modal-footer justify-content-end">
                 <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-orange px-4" OnClick="btnSubmit_Click" />
               </div>
             </div>
           </div>
         </div>

         <script type="text/javascript">
             function openModal() {
                 var myModal = new bootstrap.Modal(document.getElementById('addTrainingModal'));
                 myModal.show();
             }
             function clearModal() {
                 document.getElementById('<%= hfTrainingId.ClientID %>').value = '';
                 document.getElementById('<%= ddlTrainer.ClientID %>').selectedIndex = 0;
                 document.getElementById('<%= ddlTrainingType.ClientID %>').selectedIndex = 0;
                 document.getElementById('<%= ddlEmployee.ClientID %>').selectedIndex = 0;
                 document.getElementById('<%= txtTrainingCost.ClientID %>').value = '';
                 document.getElementById('<%= txtDescription.ClientID %>').value = '';
                 document.getElementById('<%= ddlStatus.ClientID %>').selectedIndex = 0;
                 document.getElementById('<%= txtStartDate.ClientID %>').value = '';
                 document.getElementById('<%= txtEndDate.ClientID %>').value = '';
                 document.getElementById('modalTitle').innerText = 'Add Training List';
                 document.getElementById('<%= btnSubmit.ClientID %>').value = 'Submit';
             }
         </script>

     </ContentTemplate>
 </asp:UpdatePanel>
</asp:Content>
