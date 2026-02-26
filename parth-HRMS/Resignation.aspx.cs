using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace parth_HRMS
{
    public partial class Resignation : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        public int CurrentPage
        {
            get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 0; }
            set { ViewState["CurrentPage"] = value; }
        }

        public int TotalPages
        {
            get { return ViewState["TotalPages"] != null ? (int)ViewState["TotalPages"] : 0; }
            set { ViewState["TotalPages"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEmployees();
                BindDepartments();
                BindResignations();
            }
        }

        // ================== Bind Employee ==================
        private void BindEmployees()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT UserID, EmployeeName FROM [Users]", con);
                con.Open();
                ddlEmployee.DataSource = cmd.ExecuteReader();
                ddlEmployee.DataTextField = "EmployeeName";
                ddlEmployee.DataValueField = "UserID";
                ddlEmployee.DataBind();
                ddlEmployee.Items.Insert(0, new ListItem("Select Employee", ""));
            }
        }

        // ================== Bind Department ==================
        private void BindDepartments()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT DepartmentId, DepartmentName FROM Departments", con);
                con.Open();
                ddlDepartment.DataSource = cmd.ExecuteReader();
                ddlDepartment.DataTextField = "DepartmentName";
                ddlDepartment.DataValueField = "DepartmentId";
                ddlDepartment.DataBind();
                ddlDepartment.Items.Insert(0, new ListItem("Select Department", ""));
            }
        }

        // ================== Get Data ==================
        private DataTable GetResignationData()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetAllResignations", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // ================== Bind Repeater ==================
        private void BindResignations()
        {
            DataTable dt = GetResignationData();

            // Search
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                var rows = dt.AsEnumerable()
                    .Where(r => r["EmployeeName"].ToString().ToLower()
                    .Contains(txtSearch.Text.ToLower()));

                dt = rows.Any() ? rows.CopyToDataTable() : dt.Clone();
            }

            // Sort
            if (ddlSort.SelectedValue == "DESC")
                dt = dt.AsEnumerable().OrderByDescending(r => r["ResignationId"]).CopyToDataTable();
            else
                dt = dt.AsEnumerable().OrderBy(r => r["ResignationId"]).CopyToDataTable();

            int pageSize = Convert.ToInt32(ddlEntries.SelectedValue);
            int totalRecords = dt.Rows.Count;

            TotalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            var pagedData = dt.AsEnumerable()
                .Skip(CurrentPage * pageSize)
                .Take(pageSize);

            rptResignations.DataSource = pagedData.Any() ? pagedData.CopyToDataTable() : null;
            rptResignations.DataBind();

            lblShowingText.Text = $"Showing {Math.Min(pageSize, totalRecords)} of {totalRecords} entries";

            BindPagination();
        }

        // ================== Pagination ==================
        private void BindPagination()
        {
            var pages = Enumerable.Range(0, TotalPages)
                .Select(i => new { PageIndex = i, PageText = i + 1 });

            rptPagination.DataSource = pages;
            rptPagination.DataBind();
        }

        protected void rptPagination_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                CurrentPage = Convert.ToInt32(e.CommandArgument);
                BindResignations();
            }
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
            {
                CurrentPage--;
                BindResignations();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (CurrentPage < TotalPages - 1)
            {
                CurrentPage++;
                BindResignations();
            }
        }

        // ================== INSERT / UPDATE ==================
        protected void btnSubmitResignation_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd;
                bool isUpdate = !string.IsNullOrEmpty(hfResignationId.Value);

                if (isUpdate)
                {
                    cmd = new SqlCommand("sp_UpdateResignation", con);
                    cmd.Parameters.AddWithValue("@ResignationId", Convert.ToInt32(hfResignationId.Value));
                }
                else
                {
                    cmd = new SqlCommand("sp_InsertResignation", con);
                }

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserID", Convert.ToInt32(ddlEmployee.SelectedValue));
                cmd.Parameters.AddWithValue("@DepartmentId", Convert.ToInt32(ddlDepartment.SelectedValue));
                cmd.Parameters.AddWithValue("@NoticeDate", Convert.ToDateTime(txtNoticeDate.Text));
                cmd.Parameters.AddWithValue("@ResignDate", Convert.ToDateTime(txtResignationDate.Text));
                cmd.Parameters.AddWithValue("@Reason", txtReason.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            hfResignationId.Value = "";
            BindResignations();
        }

        // ================== EDIT / DELETE ==================
        protected void rptResignations_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_DeleteResignation", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ResignationId", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                BindResignations();
            }

            else if (e.CommandName == "Edit")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_GetResignationById", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ResignationId", id);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        hfResignationId.Value = dr["ResignationId"].ToString();
                        ddlEmployee.SelectedValue = dr["UserID"].ToString();
                        ddlDepartment.SelectedValue = dr["DepartmentId"].ToString();
                        txtNoticeDate.Text = Convert.ToDateTime(dr["NoticeDate"]).ToString("yyyy-MM-dd");
                        txtResignationDate.Text = Convert.ToDateTime(dr["ResignDate"]).ToString("yyyy-MM-dd");
                        txtReason.Text = dr["Reason"].ToString();
                    }
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindResignations();
        }
    }
}