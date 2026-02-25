<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EmpGrid.aspx.cs" Inherits="parth_HRMS.EmpGrid" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <title>Smarthr Admin </title>
           


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    		<div>
          <div class="page-wrapper">
			<div class="content">
				<!-- Breadcrumb -->
				<div class="d-md-flex d-block align-items-center justify-content-between page-breadcrumb mb-3">
					<div class="my-auto mb-2">
						<h2 class="mb-1">Employee</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item">
									<a href="index.html"><i class="ti ti-smart-home"></i></a>
								</li>
								<li class="breadcrumb-item">
									Employee
								</li>
								<li class="breadcrumb-item active" aria-current="page">Employee List</li>
							</ol>
						</nav>
					</div>
					<div class="d-flex my-xl-auto right-content align-items-center flex-wrap ">
						<div class="me-2 mb-2">
							<div class="d-flex align-items-center border bg-white rounded p-1 me-2 icon-list">
								<a href="employees.html" class="btn btn-icon btn-sm active bg-primary text-white me-1"><i class="ti ti-list-tree"></i></a>
								<a href="employees-grid.html" class="btn btn-icon btn-sm"><i class="ti ti-layout-grid"></i></a>
                            </div>
                        </div>
                        <div class="me-2 mb-2">
							<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>

                                    <asp:Button
                                        ID="Button2"
                                        runat="server"
                                        Text="Export to PDF"
                                        OnClick="Button2_Click" />

                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="Button2" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <div class="mb-2">
                            <a href="#" data-bs-toggle="modal" data-bs-target="#add_employee" class="btn btn-primary d-flex align-items-center"><i class="ti ti-circle-plus me-2"></i>Add Employee</a>
                        </div>
						<div class="head-icons ms-2">
							<a href="javascript:void(0);" class="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Collapse" id="collapse-header">
								<i class="ti ti-chevrons-up"></i>
							</a>
						</div>
					</div>
				</div>
				<!-- /Breadcrumb -->

				<%--<div class="row">

					<!-- Total Plans -->
					<div class="col-lg-3 col-md-6 d-flex">
						<div class="card flex-fill">
							<div class="card-body d-flex align-items-center justify-content-between">
								<div class="d-flex align-items-center overflow-hidden">
									<div>
										<span class="avatar avatar-lg bg-dark rounded-circle"><i class="ti ti-users"></i></span>
									</div>
									<div class="ms-2 overflow-hidden">
										<p class="fs-12 fw-medium mb-1 text-truncate">Total Employee</p>
										<h4>1007</h4>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /Total Plans -->

					<!-- Total Plans -->
					<div class="col-lg-3 col-md-6 d-flex">
						<div class="card flex-fill">
							<div class="card-body d-flex align-items-center justify-content-between">
								<div class="d-flex align-items-center overflow-hidden">
									<div>
										<span class="avatar avatar-lg bg-success rounded-circle"><i class="ti ti-user-share"></i></span>
									</div>
									<div class="ms-2 overflow-hidden">
										<p class="fs-12 fw-medium mb-1 text-truncate">Active</p>
										<h4>1007</h4>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /Total Plans -->

					<!-- Inactive Plans -->
					<div class="col-lg-3 col-md-6 d-flex">
						<div class="card flex-fill">
							<div class="card-body d-flex align-items-center justify-content-between">
								<div class="d-flex align-items-center overflow-hidden">
									<div>
										<span class="avatar avatar-lg bg-danger rounded-circle"><i class="ti ti-user-pause"></i></span>
									</div>
									<div class="ms-2 overflow-hidden">
										<p class="fs-12 fw-medium mb-1 text-truncate">InActive</p>
										<h4>1007</h4>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /Inactive Companies -->

					<!-- No of Plans  -->
					<div class="col-lg-3 col-md-6 d-flex">
						<div class="card flex-fill">
							<div class="card-body d-flex align-items-center justify-content-between">
								<div class="d-flex align-items-center overflow-hidden">
									<div>
										<span class="avatar avatar-lg bg-info rounded-circle"><i class="ti ti-user-plus"></i></span>
									</div>
									<div class="ms-2 overflow-hidden">
										<p class="fs-12 fw-medium mb-1 text-truncate">New Joiners</p>
										<h4>67</h4>
									</div>
								</div>
							</div>
						</div>
					</div>--%>
					<!-- /No of Plans -->

<%--				</div>
				

			</div>--%>
				<asp:DataList ID="DataList1" runat="server" RepeatColumns="4" RepeatDirection="Horizontal">
                    <ItemTemplate>
                        <div class="card" style="width: 18rem;">
                            <img class="card-img-top" src='<%#Eval("ProfilePicture") %>'' alt="Card image cap">
                            <div class="card-body">
                                <h5 class="card-title"><b>Name:</b><%#Eval("FirstName") %></h5>
								<ul class="list-group list-group-flush">
									<li class="list-group-item"<b>Salary:</b><%#Eval("Gender") %></li>
									<li class="list-group-item"<b>Reporting to:</b><%#Eval("ReportingManager") %></li>

								</ul>
                                  <a href="#" class="btn btn-primary">Go somewhere</a>
                            </div>
                        </div>
                    </ItemTemplate>

                </asp:DataList>
			  			    <div class="grid-card">
        <asp:GridView ID="GridView1" runat="server"
            CssClass="table table-bordered table-striped">

            <Columns>
                <asp:TemplateField HeaderText="delete">
                    <ItemTemplate>
<%--                        <asp:Button ID="button2" runat="server" Text="delete" OnClick="Button2_Click" CommandName="Delete" />--%>
<%--												<span class='badge <%#Eval("Status").ToString()=="Active"?"bg-success":"bg-danger" %>'><%# Eval("Status") %> </span>--%>
						
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
                              </div>
                <div class="footer d-sm-flex align-items-center justify-content-between border-top bg-white p-3">
                    <p class="mb-0">2014 - 2025 &copy; SmartHR.</p>
                    <p>Designed &amp; Developed By <a href="javascript:void(0);" class="text-primary">Dreams</a></p>
                </div>

            </div>
              <!-- /Page Wrapper -->

              <!-- Add Employee -->
              <div class="modal fade" id="add_employee">
                  <div class="modal-dialog modal-dialog-centered modal-lg">
                      <div class="modal-content">
                          <div class="modal-header">
                              <div class="d-flex align-items-center">
                                  <h4 class="modal-title me-2">Add New Employee</h4>
                                  <span>Employee  ID : EMP -0024</span>
                              </div>
                              <button type="button" class="btn-close custom-btn-close" data-bs-dismiss="modal" aria-label="Close">
                                  <i class="ti ti-x"></i>
                              </button>
                          </div>
                          <div class="contact-grids-tab">
                              <ul class="nav nav-underline" id="myTab" role="tablist">
                                  <li class="nav-item" role="presentation">
                                      <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#basic-info" type="button" role="tab" aria-selected="true">Basic Information</button>
                                  </li>
                              </ul>
                          </div>
                          <div class="tab-content" id="myTabContent">
                              <div class="tab-pane fade show active" id="basic-info" role="tabpanel" aria-labelledby="info-tab" tabindex="0">

                                  <div class="modal-body pb-0">
                                      <div class="row">

                                          <!-- PROFILE IMAGE -->
                                          <div class="col-md-12">
                                              <div class="d-flex align-items-center flex-wrap row-gap-3 bg-light w-100 rounded p-3 mb-4">
                                                  <div class="d-flex align-items-center justify-content-center avatar avatar-xxl rounded-circle border border-dashed me-2 flex-shrink-0 text-dark frames">
                                                      <i class="ti ti-photo text-gray-2 fs-16"></i>
                                                  </div>
                                                  <div class="profile-upload">
                                                      <div class="mb-2">
                                                          <h6 class="mb-1">Upload Profile Image</h6>
                                                          <p class="fs-12">Image should be below 4 mb</p>
                                                      </div>
                                                      <div class="profile-uploader d-flex align-items-center">
                                                          <div class="drag-upload-btn btn btn-sm btn-primary me-2">
                                                              Upload
                                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control image-sign" />
                                                          </div>
                                                          <a href="javascript:void(0);" class="btn btn-light btn-sm">Cancel</a>
                                                      </div>
                                                  </div>
                                              </div>
                                          </div>

                                          <!-- FIRST NAME -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">First Name <span class="text-danger">*</span></label>
                                                  <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- LAST NAME -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Last Name</label>
                                                  <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- EMPLOYEE ID (UI ONLY) -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Employee ID <span class="text-danger">*</span></label>
                                                  <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- ROLE -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Role <span class="text-danger">*</span></label>
                                                  <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-control"></asp:DropDownList>
                                              </div>
                                          </div>

                                          <!-- JOINING DATE -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Joining Date <span class="text-danger">*</span></label>
                                                  <div class="input-icon-end position-relative">
                                                      <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control datetimepicker" placeholder="dd/mm/yyyy"></asp:TextBox>
                                                      <span class="input-icon-addon">
                                                          <i class="ti ti-calendar text-gray-7"></i>
                                                      </span>
                                                  </div>
                                              </div>
                                          </div>

                                          <!-- DATE OF BIRTH (ADDED) -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Date of Birth <span class="text-danger">*</span></label>
                                                  <div class="input-icon-end position-relative">
                                                      <asp:TextBox ID="TextBoxDOB" runat="server" CssClass="form-control datetimepicker" placeholder="dd/mm/yyyy"></asp:TextBox>
                                                      <span class="input-icon-addon">
                                                          <i class="ti ti-calendar text-gray-7"></i>
                                                      </span>
                                                  </div>
                                              </div>
                                          </div>

                                          <!-- USERNAME (UI ONLY) -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Username <span class="text-danger">*</span></label>
                                                  <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- EMAIL -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Email <span class="text-danger">*</span></label>
                                                  <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- PASSWORD -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Password <span class="text-danger">*</span></label>
                                                  <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- CONFIRM PASSWORD (UI ONLY) -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                                  <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- PHONE -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                                                  <asp:TextBox ID="TextBox9" runat="server" CssClass="form-control"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- COMPANY (UI ONLY) -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Company</label>
                                                  <asp:TextBox ID="TextBox10" runat="server" CssClass="form-control"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- DEPARTMENT -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Department</label>
                                                  <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control"></asp:DropDownList>
                                              </div>
                                          </div>

                                          <!-- DESIGNATION -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Designation</label>
                                                  <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control"></asp:DropDownList>
                                              </div>
                                          </div>

                                          <!-- GENDER (ADDED) -->
                                          <div class="col-md-6">
                                              <div class="mb-3">
                                                  <label class="form-label">Gender <span class="text-danger">*</span></label>
                                                  <asp:DropDownList ID="DropDownGender" runat="server" CssClass="form-control">
                                                      <asp:ListItem Text="-- Select Gender --" Value="" />
                                                      <asp:ListItem Text="Male" Value="Male" />
                                                      <asp:ListItem Text="Female" Value="Female" />
                                                      <asp:ListItem Text="Other" Value="Other" />
                                                  </asp:DropDownList>
                                              </div>
                                          </div>

                                          <!-- ADDRESS (ADDED) -->
                                          <div class="col-md-12">
                                              <div class="mb-3">
                                                  <label class="form-label">Address <span class="text-danger">*</span></label>
                                                  <asp:TextBox ID="TextBoxAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                              </div>
                                          </div>

                                          <!-- ABOUT -->
                                          <div class="col-md-12">
                                              <div class="mb-3">
                                                  <label class="form-label">About <span class="text-danger">*</span></label>
                                                  <asp:TextBox ID="TextBox11" runat="server" CssClass="form-control" Rows="3"></asp:TextBox>
                                              </div>
                                          </div>

                                      </div>
                                  </div>

                                  <!-- FOOTER -->
                                  <div class="modal-footer">
                                      <button type="button" class="btn btn-outline-light border me-2" data-bs-dismiss="modal">Cancel</button>
                                      <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary" />
                                  </div>

                              </div>
                          </div>
                      </div>
                  </div>
              </div>
              <!-- /Add Employee -->
            
		<!-- Edit Employee -->
		<div class="modal fade" id="edit_employee">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<div class="d-flex align-items-center">
							<h4 class="modal-title me-2">Edit Employee</h4><span>Employee  ID : EMP -0024</span>
						</div>
						<button type="button" class="btn-close custom-btn-close" data-bs-dismiss="modal" aria-label="Close">
							<i class="ti ti-x"></i>
						</button>
					</div>
					
						<div class="contact-grids-tab">
							<ul class="nav nav-underline" id="myTab2" role="tablist">
								<li class="nav-item" role="presentation">
								  <button class="nav-link active" id="info-tab2" data-bs-toggle="tab" data-bs-target="#basic-info2" type="button" role="tab" aria-selected="true">Basic Information</button>
								</li>
								<li class="nav-item" role="presentation">
								  <button class="nav-link" id="address-tab2" data-bs-toggle="tab" data-bs-target="#address2" type="button" role="tab" aria-selected="false">Permissions</button>
								</li>
							</ul>
						</div>
						<div class="tab-content" id="myTabContent2">
							<div class="tab-pane fade show active" id="basic-info2" role="tabpanel" aria-labelledby="info-tab2" tabindex="0">
									<div class="modal-body pb-0 ">	
										<div class="row">
											<div class="col-md-12">
												<div class="d-flex align-items-center flex-wrap row-gap-3 bg-light w-100 rounded p-3 mb-4">                                                
													<div class="d-flex align-items-center justify-content-center avatar avatar-xxl rounded-circle border border-dashed me-2 flex-shrink-0 text-dark frames">
														<img src="assets/img/users/user-13.jpg" alt="img" class="rounded-circle">
													</div>                                              
													<div class="profile-upload">
														<div class="mb-2">
															<h6 class="mb-1">Upload Profile Image</h6>
															<p class="fs-12">Image should be below 4 mb</p>
														</div>
														<div class="profile-uploader d-flex align-items-center">
															<div class="drag-upload-btn btn btn-sm btn-primary me-2">
																Upload
																<input type="file" class="form-control image-sign" multiple="">
															</div>
															<a href="javascript:void(0);" class="btn btn-light btn-sm">Cancel</a>
														</div>
														
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">First Name <span class="text-danger"> *</span></label>
													<input type="text" class="form-control" value="Anthony">
												</div>									
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">Last Name</label>
													<input type="email" class="form-control" value="Lewis">
												</div>									
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">Employee ID <span class="text-danger"> *</span></label>
													<input type="text" class="form-control" value="Emp-001">
												</div>									
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">Joining Date <span class="text-danger"> *</span></label>
													<div class="input-icon-end position-relative">
														<input type="text" class="form-control datetimepicker" placeholder="dd/mm/yyyy" value="17-10-2022">
														<span class="input-icon-addon">
															<i class="ti ti-calendar text-gray-7"></i>
														</span>
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">Username <span class="text-danger"> *</span></label>
													<input type="text" class="form-control" value="Anthony">
												</div>									
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">Email <span class="text-danger"> *</span></label>
													<input type="email" class="form-control" value="anthony@example.com	">
												</div>									
											</div>
											<div class="col-md-6">
												<div class="mb-3 ">
													<label class="form-label">Password <span class="text-danger"> *</span></label>
													<div class="pass-group">
														<input type="password" class="pass-input form-control">
														<span class="ti toggle-password ti-eye-off"></span>
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="mb-3 ">
													<label class="form-label">Confirm Password <span class="text-danger"> *</span></label>
													<div class="pass-group">
														<input type="password" class="pass-inputs form-control">
														<span class="ti toggle-passwords ti-eye-off"></span>
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">Phone Number <span class="text-danger"> *</span></label>
													<input type="text" class="form-control" value="(123) 4567 890">
												</div>									
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">Company<span class="text-danger"> *</span></label>
													<input type="text" class="form-control" value="Abac Company">
												</div>									
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">Department</label>
													<select class="select">
														<option>Select</option>
														<option>All Department</option>
														<option selected>Finance</option>
														<option>Developer</option>
														<option>Executive</option>
													</select>
												</div>		
											</div>
											<div class="col-md-6">
												<div class="mb-3">
													<label class="form-label">Designation</label>
													<select class="select">
														<option>Select</option>
														<option selected>Finance</option>
														<option>Developer</option>
														<option>Executive</option>
													</select>
												</div>		
											</div>
											<div class="col-md-12">
												<div class="mb-3">
													<label class="form-label">About <span class="text-danger"> *</span></label>
													<textarea class="form-control" rows="3"></textarea>
												</div>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-outline-light border me-2" data-bs-dismiss="modal">Cancel</button>
										<button type="submit" class="btn btn-primary">Save </button>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-outline-light border me-2" data-bs-dismiss="modal">Cancel</button>
									<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#success_modal">Save </button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		<!-- /Edit Employee -->

		<!-- Add Employee Success -->
		<div class="modal fade" id="success_modal" role="dialog">
			<div class="modal-dialog modal-dialog-centered modal-sm">
				<div class="modal-content">
					<div class="modal-body">
						<div class="text-center p-3">
							<span class="avatar avatar-lg avatar-rounded bg-success mb-3"><i class="ti ti-check fs-24"></i></span>
							<h5 class="mb-2">Employee Added Successfully</h5>
							<p class="mb-3">Stephan Peralt has been added with Client ID : <span class="text-primary">#EMP - 0001</span>
							</p>
							<div>
								<div class="row g-2">
									<div class="col-6">
										<a href="employees.html" class="btn btn-dark w-100">Back to List</a>
									</div>
									<div class="col-6">
										<a href="employee-details.html" class="btn btn-primary w-100">Detail Page</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
    <!-- /Add Client Success -->
    
    <!-- Delete Modal -->
		<div class="modal fade" id="delete_modal">
			<div class="modal-dialog modal-dialog-centered modal-sm">
				<div class="modal-content">
					<div class="modal-body text-center">
						<span class="avatar avatar-xl bg-transparent-danger text-danger mb-3">
							<i class="ti ti-trash-x fs-36"></i>
						</span>
						<h4 class="mb-1">Confirm Delete</h4>
						<p class="mb-3">You want to delete all the marked items, this cant be undone once you delete.</p>
						<div class="d-flex justify-content-center">
							<a href="javascript:void(0);" class="btn btn-light me-3" data-bs-dismiss="modal">Cancel</a>
							<a href="employees.html" class="btn btn-danger">Yes, Delete</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Delete Modal -->

	


          </div>
</asp:Content>
