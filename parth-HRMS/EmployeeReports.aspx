<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EmployeeReports.aspx.cs" Inherits="parth_HRMS.EmployeeReports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
	<!-- Main CSS -->
	<link rel="stylesheet" href="assets/css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="style" href="//cdn.datatables.net/2.3.7/css/dataTables.dataTables.min.css"/>
	<script src="//cdn.datatables.net/2.3.7/js/dataTables.min.js"></script>
	<script>
        $(document).ready(function () {
            $('#<%= gvEmployees.ClientID %>').DataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	        <div>

            <!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1">Employee Report</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item">
									<a href="index.html"><i class="ti ti-smart-home"></i></a>
								</li>
								<li class="breadcrumb-item">
									HR
								</li>
								<li class="breadcrumb-item active" aria-current="page">Employee Report</li>
							</ol>
						</nav>
					</div>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap ">
						<div class="mb-2">
							<div class="dropdown">
								<a href="javascript:void(0);" class="dropdown-toggle btn btn-white d-inline-flex align-items-center" data-bs-toggle="dropdown">
									<i class="ti ti-file-export me-1"></i>Export
								</a>
								<ul class="dropdown-menu  dropdown-menu-end p-3">
									<li>
										<a href="javascript:void(0);" class="dropdown-item rounded-1"><i class="ti ti-file-type-pdf me-1"></i>Export as PDF</a>
									</li>
									<li>
										<a href="javascript:void(0);" class="dropdown-item rounded-1"><i class="ti ti-file-type-xls me-1"></i>Export as Excel </a>
									</li>
								</ul>
							</div>
							
						</div>
						<div class="head-icons ms-2">
							<a href="javascript:void(0);" class="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Collapse" id="collapse-header">
								<i class="ti ti-chevrons-up"></i>
							</a>
						</div>
					</div>
				</div>


			<!-- /Breadcrumb -->
                <div class="row">
                    <div class="col-xl-6 d-flex">
                        <div class="row flex-fill">

                            <!-- Total Companies -->
                            <div class="col-lg-6 col-md-6 d-flex">
                                <div class="card flex-fill">
                                    <div class="card-body">
                                        <div class="overflow-hidden d-flex mb-2 align-items-center">
											<span class="me-2"><img src="assets/img/reports-img/employee-report-icon.svg" alt="Img" class="img-fluid"></span>
										   <div>
												<p class="fs-14 fw-normal mb-1 text-truncate">Total Employee</p>


												<h5>

													 <asp:Label ID="lblTotalEmployee" runat="server" Text="0"></asp:Label>

												</h5>

										   </div>
										</div>
										<div>
											<p class="fs-12 fw-normal d-flex align-items-center text-truncate "><span class="text-success fs-12 d-flex align-items-center me-1"><i class="ti ti-arrow-wave-right-up me-1"></i>+20.01%</span>from last week</p>
										</div>
                                    </div>
                                </div>
                            </div>
                            <!-- /Total Companies -->

                            <!-- Total  Department -->
							<div class="col-lg-6 col-md-6 d-flex">
                                <div class="card flex-fill">
                                    <div class="card-body">
                                        <div class="overflow-hidden d-flex mb-2 align-items-center">
											<span class="me-2"><img src="assets/img/reports-img/employee-report-success.svg" alt="Img" class="img-fluid"></span>
										   <div>
												<p class="fs-14 fw-normal mb-1 text-truncate">Total Department</p>
												<h5>
													<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
												</h5>
										   
										   </div>
										</div>
										<div>
											<p class="fs-12 fw-normal d-flex align-items-center text-truncate "><span class="text-success fs-12 d-flex align-items-center me-1"><i class="ti ti-arrow-wave-right-up me-1"></i>+20.01%</span>from last week</p>
										</div>
                                    </div>
                                </div>
                            </div>
                            <!-- /Total Companies -->

                            <!-- Total Active employee -->
							<div class="col-lg-6 col-md-6 d-flex">
                                <div class="card flex-fill">
                                    <div class="card-body">
                                        <div class="overflow-hidden d-flex mb-2 align-items-center">
											<span class="me-2"><img src="assets/img/reports-img/employee-report-info.svg" alt="Img" class="img-fluid"></span>
										   <div>
											   <p class="fs-14 fw-normal mb-1 text-truncate">Active Employee</p>

												<h5>
												<asp:Label ID="Label1" runat="server" Text="0"></asp:Label>
												</h5>
										   </div>
										</div>
										<div>
											<p class="fs-12 fw-normal d-flex align-items-center text-truncate "><span class="text-success fs-12 d-flex align-items-center me-1"><i class="ti ti-arrow-wave-right-up me-1"></i>+20.01%</span>from last week</p>
										</div>
                                    </div>
                                </div>
                            </div>
                           

                            <!-- Inactive Employee -->
                            <div class="col-lg-6 col-md-6 d-flex">
                                <div class="card flex-fill">
                                    <div class="card-body">
                                        <div class="overflow-hidden d-flex mb-2 align-items-center">
											<span class="me-2"><img src="assets/img/reports-img/employee-report-danger.svg" alt="Img" class="img-fluid"></span>
										   <div>
												<p class="fs-14 fw-normal mb-1 text-truncate">Inactive Employee</p>
													<h5>
														<asp:Label ID="Label3" runat="server" Text="0"></asp:Label>

													</h5>
										   </div>
										</div>
										<div>
											<p class="fs-12 fw-normal d-flex align-items-center text-truncate "><span class="text-success fs-12 d-flex align-items-center me-1"><i class="ti ti-arrow-wave-right-up me-1"></i>+20.01%</span>from last week</p>
										</div>
                                    </div>
                                </div>
                            </div>
                            <!-- /Company Location -->
                        </div>
                    </div>
					<div class="col-xl-6 d-flex">
                       <div class="card flex-fill">
							<div class="card-header border-0 pb-0">
								<div class="d-flex flex-wrap justify-content-between align-items-center row-gap-2">
									<div class="d-flex align-items-center ">
										<span class="me-2"><i class="ti ti-chart-bar text-danger"></i></span>
										<h5>Employee </h5>
									</div>
									<div class="d-flex align-items-center">
										<p class="d-inline-flex align-items-center me-3 mb-0">
											<i class="ti ti-square-filled fs-12 text-success me-2"></i>
											Active Employees
										</p>
										<p class="d-inline-flex align-items-center">
											<i class="ti ti-square-filled fs-12 text-gray-1 me-2 mb-0"></i>
											Inactive Employees
										</p>
									</div>
									<div class="dropdown">
										<a href="javascript:void(0);" class="dropdown-toggle btn btn-sm fs-12 btn-white d-inline-flex align-items-center" data-bs-toggle="dropdown">
											This Year
										</a>
										<ul class="dropdown-menu  dropdown-menu-end p-2">
											<li>
												<a href="javascript:void(0);" class="dropdown-item rounded-1">2024</a>
											</li>
											<li>
												<a href="javascript:void(0);" class="dropdown-item rounded-1">2023</a>
											</li>
											<li>
												<a href="javascript:void(0);" class="dropdown-item rounded-1">2022</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="card-body py-0">

								<!-- Hidden Fields -->
								<asp:HiddenField ID="hfMonths" runat="server" />
								<asp:HiddenField ID="hfActiveData" runat="server" />
								<asp:HiddenField ID="hfInactiveData" runat="server" />

								<!-- Chart Canvas -->
								<canvas id="employeeChart" height="120"></canvas>

							</div>
						</div>
                    </div>					
				</div>


			<div class="card">
					
					<!---DropList -->
					<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
						
						<h5>Employees List</h5>
						<div class="d-flex my-xl-auto right-content align-items-center flex-wrap row-gap-3">
                            <div class="me-3">
								<div class="input-icon-end position-relative">
									<input type="text" class="form-control date-range bookingrange" placeholder="dd/mm/yyyy - dd/mm/yyyy">
									<span class="input-icon-addon">
										<i class="ti ti-chevron-down"></i>
									</span>
								</div>
							</div>
									
							<div class="dropdown me-3">

									<asp:LinkButton ID="btnDesignation" runat="server"
										CssClass="dropdown-toggle btn btn-white d-inline-flex align-items-center"
										data-bs-toggle="dropdown">
										Designation
									</asp:LinkButton>

									<ul class="dropdown-menu dropdown-menu-end p-3">
										<li>
											<asp:LinkButton ID="btnAbsent" runat="server"
												CssClass="dropdown-item rounded-1"
												OnClick="btnAbsent_Click">
												Absent
											</asp:LinkButton>
										</li>

										<li>
											<asp:LinkButton ID="btnAll" runat="server"
												CssClass="dropdown-item rounded-1"
												OnClick="btnAll_Click">
												Present
											</asp:LinkButton>
										</li>

									</ul>
								</div>

							<div class="dropdown me-3">

									<asp:LinkButton ID="btnStatus" runat="server"
										CssClass="dropdown-toggle btn btn-white d-inline-flex align-items-center"
										data-bs-toggle="dropdown">
										Select Status
									</asp:LinkButton>

									<ul class="dropdown-menu dropdown-menu-end p-3">

										<li>
											<asp:LinkButton ID="btnActive" runat="server"
												CssClass="dropdown-item rounded-1"
												OnClick="btnActive_Click">
												Active
											</asp:LinkButton>
										</li>

										<li>
											<asp:LinkButton ID="btnInactive" runat="server"
												CssClass="dropdown-item rounded-1"
												OnClick="btnInactive_Click">
												Inactive
											</asp:LinkButton>
										</li>

									
										

									</ul>
								</div>
						
							<div class="dropdown">

								<asp:LinkButton ID="btnSortMain" runat="server"
									CssClass="dropdown-toggle btn btn-white d-inline-flex align-items-center"
									data-bs-toggle="dropdown">
									Sort By
								</asp:LinkButton>

								<ul class="dropdown-menu dropdown-menu-end p-3">

									<li>
										<asp:LinkButton ID="btnAsc" runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="btnAsc_Click">
											Ascending
										</asp:LinkButton>
									</li>

									<li>
										<asp:LinkButton ID="btnDesc" runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="btnDesc_Click">
											Descending
										</asp:LinkButton>
									</li>

									<li>
										<asp:LinkButton ID="btnLastMonth" runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="btnLastMonth_Click">
											Last Month
										</asp:LinkButton>
									</li>

									<li>
										<asp:LinkButton ID="btnLast7Days" runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="btnLast7Days_Click">
											Last 7 Days
										</asp:LinkButton>
									</li>

								</ul>
							</div>
						</div>
					</div>

					<div class="card-body p-0">
    <div class="custom-datatable-filter table-responsive">

        <asp:GridView ID="gvEmployees" runat="server"
            AutoGenerateColumns="False"
            CssClass="table"
            DataKeyNames="UserId">

            <Columns>

                <%-- Emp ID --%>
                <asp:BoundField DataField="UserId" HeaderText="Emp ID" />

                <%-- Name + Profile Picture --%>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <div class="d-flex align-items-center">
                            <img src='<%# Eval("ProfilePicture") %>'
                                class="img-fluid rounded-circle"
                                width="40" height="40" />
                            <div class="ms-2">
                                <p class="mb-0 text-dark">
                                    <%# Eval("FullName") %>
                                </p>
                                <span class="fs-12">
                                    <%# Eval("Name") %>
                                </span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>

                <%-- Email --%>
                <asp:BoundField DataField="Email" HeaderText="Email" />

                <%-- Department --%>
                <asp:BoundField DataField="Name" HeaderText="Department" />

                <%-- Phone --%>
                <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" />

                <%-- Joining Date --%>
                <asp:BoundField DataField="DateOfJoining"
                    HeaderText="Joining Date"
                    DataFormatString="{0:dd MMM yyyy}" />

                <%-- Status --%>
                <asp:TemplateField HeaderText="Status">
				<ItemTemplate>
					<asp:Label ID="lblStatus" runat="server"
						Text='<%# Eval("Status") %>'
						CssClass='<%# Eval("Status").ToString() == "Active" 
							? "badge badge-success" 
							: "badge badge-danger" %>'>
					</asp:Label>
				</ItemTemplate>
			</asp:TemplateField>

            </Columns>
        </asp:GridView>

    </div>
</div>
				</div>

			</div>

			<div class="footer d-sm-flex align-items-center justify-content-between border-top bg-white p-3">
				<p class="mb-0">2014 - 2025 &copy; SmartHR.</p>
				<p>Designed &amp; Developed By <a href="javascript:void(0);" class="text-primary">Dreams</a></p>
			</div>

				
        
    

				




		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    window.onload = function () {

        var months = document.getElementById('<%= hfMonths.ClientID %>').value.split(',');
        var activeData = document.getElementById('<%= hfActiveData.ClientID %>').value.split(',');
        var inactiveData = document.getElementById('<%= hfInactiveData.ClientID %>').value.split(',');

        var ctx = document.getElementById('employeeChart').getContext('2d');

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: months,
                datasets: [
                    {
                        label: 'Active Employees',
                        data: activeData,
                        backgroundColor: 'green'
                    },
                    {
                        label: 'Inactive Employees',
                        data: inactiveData,
                        backgroundColor: 'gray'
                    }
                ]
            }
        });
    };
</script>
        
</asp:Content>
