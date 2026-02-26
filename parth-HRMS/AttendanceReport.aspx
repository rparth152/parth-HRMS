<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AttendanceReport.aspx.cs" Inherits="parth_HRMS.AttendanceReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    	<title>Smarthr Admin Template</title>

	<!-- Favicon -->
	<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

	<!-- Apple Touch Icon -->
	<link rel="apple-touch-icon" sizes="180x180" href="assets/img/apple-touch-icon.png">

	<!-- Theme Script js -->
	<script src="assets/js/theme-script.js"></script>

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">

	<!-- Feather CSS -->
	<link rel="stylesheet" href="assets/plugins/icons/feather/feather.css">

	<!-- Tabler Icon CSS -->
	<link rel="stylesheet" href="assets/plugins/tabler-icons/tabler-icons.css">

	<!-- Select2 CSS -->
	<link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

	<!-- Fontawesome CSS -->
	<link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
	<link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

	 <!-- Color Picker Css -->
	<link rel="stylesheet" href="assets/plugins/flatpickr/flatpickr.min.css">
	<link rel="stylesheet" href="assets/plugins/@simonwep/pickr/themes/nano.min.css">

	<!-- Daterangepikcer CSS -->
	<link rel="stylesheet" href="assets/plugins/daterangepicker/daterangepicker.css">

	<!-- Datatable CSS -->
	<link rel="stylesheet" href="assets/css/dataTables.bootstrap5.min.css">

	<!-- Select2 CSS -->
	<link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">
    
    <!-- Bootstrap Tagsinput CSS -->
	<link rel="stylesheet" href="assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css">

	<!-- Main CSS -->
	<link rel="stylesheet" href="assets/css/style.css">


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="style" href="//cdn.datatables.net/2.3.7/css/dataTables.dataTables.min.css"/>
<script src="//cdn.datatables.net/2.3.7/js/dataTables.min.js"></script>
<script>

    $(document).ready(function () {
        $('#<%= gvAttendance.ClientID %>').DataTable();

        });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	 <div>

			<!-- Breadcrumb -->
			<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
				<div class="my-auto mb-2">
					<h2 class="mb-1">Attendance Report</h2>
					<nav>
						<ol class="breadcrumb mb-0">
							<li class="breadcrumb-item">
								<a href="index.html"><i class="ti ti-smart-home"></i></a>
							</li>
							<li class="breadcrumb-item">
								HR
							</li>
							<li class="breadcrumb-item active" aria-current="page">Attendance Report</li>
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
                                 <div class="d-flex align-items-center overflow-hidden mb-2">
										<div class="attendence-icon">
											<span><i class="ti ti-calendar text-primary"></i></span>
										</div>
                                     <div class="ms-2 overflow-hidden">
                                         <p class="fs-12 fw-normal mb-1 text-truncate">Total Working Days</p>
                                       <h4><asp:Label ID="lblWorkingDays" runat="server"></asp:Label></h4>
                                     </div>
                                 </div>
									<div class="attendance-report-bar mb-2">
										<div class="progress" role="progressbar" aria-label="Success example" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="height: 5px;">
											<div class="progress-bar bg-success" style="width: 85%"></div>
										  </div>
									</div>
									<div>
										<p class="fs-12 fw-normal d-flex align-items-center text-truncate"><span class="text-success fs-12 d-flex align-items-center me-1"><i class="ti ti-arrow-wave-right-up me-1"></i>+20.01%</span>from last month</p>
									</div>
                             </div>
                         </div>
                     </div>
                     <!-- /Total Companies -->

                      <!-- Total Companies -->
						 <div class="col-lg-6 col-md-6 d-flex">
                         <div class="card flex-fill">
                             <div class="card-body">
                                 <div class="d-flex align-items-center overflow-hidden mb-2">
										<div class="attendence-icon">
											<span><i class="ti ti-calendar text-info"></i></span>
										</div>
                                     <div class="ms-2 overflow-hidden">
                                         <p class="fs-12 fw-normal mb-1 text-truncate">Total Leave Taken</p>
                                       
											<h4><asp:Label ID="lblLeave" runat="server"></asp:Label></h4>

                                     </div>
                                 </div>
									<div class="attendance-report-bar mb-2">
										<div class="progress" role="progressbar" aria-label="Success example" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="height: 5px;">
											<div class="progress-bar bg-success" style="width: 85%"></div>
										  </div>
									</div>
									<div>
										<p class="fs-12 fw-normal d-flex align-items-center text-truncate"><span class="text-success fs-12 d-flex align-items-center me-1"><i class="ti ti-arrow-wave-right-up me-1"></i>+20.01%</span>from last month</p>
									</div>
                             </div>
                         </div>
                     </div>
                     <!-- /Total Companies -->

                     <!-- Inactive Companies -->
                      <div class="col-lg-6 col-md-6 d-flex">
                         <div class="card flex-fill">
                             <div class="card-body">
                                 <div class="d-flex align-items-center overflow-hidden mb-2">
										<div class="attendence-icon">
											<span><i class="ti ti-calendar text-pink"></i></span>
										</div>
                                     <div class="ms-2 overflow-hidden">
                                         <p class="fs-12 fw-normal mb-1 text-truncate">Total Holidays</p>
                                       
											<h4><asp:Label ID="lblHoliday" runat="server"></asp:Label></h4>

                                     </div>
                                 </div>
									<div class="attendance-report-bar mb-2">
										<div class="progress" role="progressbar" aria-label="Success example" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="height: 5px;">
											<div class="progress-bar bg-success" style="width: 85%"></div>
										  </div>
									</div>
									<div>
										<p class="fs-12 fw-normal d-flex align-items-center text-truncate"><span class="text-success fs-12 d-flex align-items-center me-1"><i class="ti ti-arrow-wave-right-up me-1"></i>+20.01%</span>from last month</p>
									</div>
                             </div>
                         </div>
                     </div>
                     <!-- /Inactive Companies -->

                     <!-- Company Location -->
                     <div class="col-lg-6 col-md-6 d-flex">
                         <div class="card flex-fill">
                             <div class="card-body">
                                 <div class="d-flex align-items-center overflow-hidden mb-2">
										<div class="attendence-icon">
											<span><i class="ti ti-calendar text-warning"></i></span>
										</div>
                                     <div class="ms-2 overflow-hidden">
                                         <p class="fs-12 fw-normal mb-1 text-truncate">Total Halfdays</p>
                                         

											<h4><asp:Label ID="lblHalfday" runat="server"></asp:Label></h4>

                                     </div>
                                 </div>
									<div class="attendance-report-bar mb-2">
										<div class="progress" role="progressbar" aria-label="Success example" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="height: 5px;">
											<div class="progress-bar bg-success" style="width: 85%"></div>
										  </div>
									</div>
									<div>
										<p class="fs-12 fw-normal d-flex align-items-center text-truncate"><span class="text-success fs-12 d-flex align-items-center me-1"><i class="ti ti-arrow-wave-right-up me-1"></i>+20.01%</span>from last month</p>
									</div>
                             </div>
                         </div>
                     </div>
                     <!-- /Company Location -->
                 </div>
             </div>
				<div class="col-xl-6">
                 <div class="card">
						<div class="card-header border-0 pb-0">
							<div class="d-flex flex-wrap justify-content-between align-items-center">
								<div class="d-flex align-items-center ">
									<span class="me-2"><i class="ti ti-chart-line text-danger"></i></span>
									<h5>Attendance  </h5>
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
						<div class="card-body py-0 px-2">
							
							
										<!---add the Chart code from notepad-->	

							<div id="attendance-report">


                            <asp:Chart ID="Chart1" runat="server" Height="20px" Width="1000px">

                                 <series>
                                     <asp:Series Name="Present"
                                         ChartType="Line"
                                         BorderWidth="3"
                                         Color="Green">
                                     </asp:Series>

                                     <asp:Series Name="Absent"
                                         ChartType="Line"
                                         BorderWidth="3"
                                         Color="HotPink">
                                     </asp:Series>
                                 </series>

                                 <chartareas>
                                     <asp:ChartArea Name="ChartArea1">
                                     </asp:ChartArea>
                                 </chartareas>

                             </asp:Chart>

                         </div>

						</div>
                 </div>
             </div>					
			</div>


		<div class="card">
			<!--DropDownList-->
			<div class="card-header d-flex align-items-center justify-content-between flex-wrap row-gap-3">
					<h5>Employee Attendance</h5>
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
    
								<!-- Button -->
								<asp:LinkButton ID="btnStatus"
									runat="server"
									CssClass="dropdown-toggle btn btn-white d-inline-flex align-items-center"
									data-bs-toggle="dropdown">
									Select Status
								</asp:LinkButton>

								<!-- Dropdown Items -->
								<ul class="dropdown-menu dropdown-menu-end p-3">

									<li>
										<asp:LinkButton ID="lnkAll"
											runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="Status_Click"
											CommandArgument="">
											All
										</asp:LinkButton>
									</li>

									<li>
										<asp:LinkButton ID="lnkPresent"
											runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="Status_Click"
											CommandArgument="Present">
											Present
										</asp:LinkButton>
									</li>

									<li>
										<asp:LinkButton ID="lnkAbsent"
											runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="Status_Click"
											CommandArgument="Absent">
											Absent
										</asp:LinkButton>
									</li>

								</ul>
							</div>


									<div class="dropdown">

								<asp:LinkButton ID="btnSort"
									runat="server"
									CssClass="dropdown-toggle btn btn-white d-inline-flex align-items-center"
									data-bs-toggle="dropdown">
									Sort By : Last 7 Days
								</asp:LinkButton>

								<ul class="dropdown-menu dropdown-menu-end p-3">

									<li>
										<asp:LinkButton ID="lnkRecent"
											runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="Sort_Click"
											CommandArgument="Recent">
											Recently Added
										</asp:LinkButton>
									</li>

									<li>
										<asp:LinkButton ID="lnkAsc"
											runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="Sort_Click"
											CommandArgument="ASC">
											Ascending
										</asp:LinkButton>
									</li>

									<li>
										<asp:LinkButton ID="lnkDesc"
											runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="Sort_Click"
											CommandArgument="DESC">
											Descending
										</asp:LinkButton>
									</li>

									<li>
										<asp:LinkButton ID="lnkMonth"
											runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="Sort_Click"
											CommandArgument="LastMonth">
											Last Month
										</asp:LinkButton>
									</li>

									<li>
										<asp:LinkButton ID="lnkWeek"
											runat="server"
											CssClass="dropdown-item rounded-1"
											OnClick="Sort_Click"
											CommandArgument="Last7Days">
											Last 7 Days
										</asp:LinkButton>
									</li>

								</ul>
							</div>
						</div>
				</div>



				<div class="card-body p-0">
					<div class="custom-datatable-filter table-responsive">
						<table class="table datatable">
							
							
							
							<tbody>
							<asp:GridView ID="gvAttendance" runat="server"
							AutoGenerateColumns="False"
							CssClass="table datatable"
							ClientIDMode="Static">

							<Columns>

								<asp:TemplateField HeaderText="Name">
									<ItemTemplate>
										<div class="d-flex align-items-center">
											<div class="ms-2">
												<p class="text-dark mb-0">
													<%# Eval("FullName") %>
												</p>
											</div>
										</div>
									</ItemTemplate>
								</asp:TemplateField>

								<asp:BoundField DataField="Date" HeaderText="Date"
									DataFormatString="{0:dd MMM yyyy}" />

								<asp:BoundField DataField="CheckIn" HeaderText="Check In" />

								<asp:TemplateField HeaderText="Status">
									<ItemTemplate>
										<span class="badge badge-soft-success">
											<%# Eval("Status") %>
										</span>
									</ItemTemplate>
								</asp:TemplateField>

								<asp:BoundField DataField="CheckOut" HeaderText="Check Out" />
								<asp:BoundField DataField="BreakHours" HeaderText="Break" />
								<asp:BoundField DataField="Late" HeaderText="Late" />
								<asp:BoundField DataField="OvertimeHours" HeaderText="Overtime" />
								<asp:BoundField DataField="ProductionHours" HeaderText="Production Hours" />

							</Columns>

						</asp:GridView>
						
						</tbody>
						</table>
					</div>
				</div>
			</div>


 </div>
</asp:Content>
