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
    public partial class Termination : System.Web.UI.Page
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
                BindTerminations();
            }
        }

        // ================== Bind Employee Dropdown ==================
        private void BindEmployees()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT UserId, EmployeeName FROM [dbo].[Users]", con);
                con.Open();
                ddlEmployee.DataSource = cmd.ExecuteReader();
                ddlEmployee.DataTextField = "EmployeeName";
                ddlEmployee.DataValueField = "UserID";
                ddlEmployee.DataBind();
                ddlEmployee.Items.Insert(0, new ListItem("Select Employee", ""));
            }
        }

        // ================== Get Data ==================
        private DataTable GetTerminationData()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetAllTerminations", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // ================== Bind Repeater ==================
        private void BindTerminations()
        {
            DataTable dt = GetTerminationData();

            // Search
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                var filteredRows = dt.AsEnumerable()
                    .Where(r => r["EmployeeName"].ToString().ToLower()
                    .Contains(txtSearch.Text.ToLower()));

                dt = filteredRows.Any() ? filteredRows.CopyToDataTable() : dt.Clone();
            }

            // Sort
            if (ddlSort.SelectedValue == "DESC")
                dt = dt.AsEnumerable().OrderByDescending(r => r["TerminationId"]).CopyToDataTable();
            else
                dt = dt.AsEnumerable().OrderBy(r => r["TerminationId"]).CopyToDataTable();

            int pageSize = Convert.ToInt32(ddlEntries.SelectedValue);
            int totalRecords = dt.Rows.Count;

            TotalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            var pagedData = dt.AsEnumerable()
                .Skip(CurrentPage * pageSize)
                .Take(pageSize);

            rptTerminations.DataSource = pagedData.Any() ? pagedData.CopyToDataTable() : null;
            rptTerminations.DataBind();

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
                BindTerminations();
            }
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
            {
                CurrentPage--;
                BindTerminations();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (CurrentPage < TotalPages - 1)
            {
                CurrentPage++;
                BindTerminations();
            }
        }

        // ================== Insert / Update ==================
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd;

                if (string.IsNullOrEmpty(hfTerminationId.Value))
                {
                    cmd = new SqlCommand("sp_InsertTermination", con);
                }
                else
                {
                    cmd = new SqlCommand("sp_UpdateTermination", con);
                    cmd.Parameters.AddWithValue("@TerminationId", hfTerminationId.Value);
                }

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserID", ddlEmployee.SelectedValue);
                cmd.Parameters.AddWithValue("@TerminationType", ddlTerminationType.SelectedValue);
                cmd.Parameters.AddWithValue("@NoticeDate", txtNoticeDate.Text);
                cmd.Parameters.AddWithValue("@ResignDate", txtResignDate.Text);
                cmd.Parameters.AddWithValue("@Reason", txtReason.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindTerminations();
        }

        // ================== Edit / Delete ==================
        protected void rptTerminations_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_DeleteTermination", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TerminationId", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                BindTerminations();
            }
            else if (e.CommandName == "Edit")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_GetTerminationById", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TerminationId", id);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        hfTerminationId.Value = dr["TerminationId"].ToString();
                        ddlEmployee.SelectedValue = dr["UserID"].ToString();
                        ddlTerminationType.SelectedValue = dr["TerminationType"].ToString();
                        txtNoticeDate.Text = Convert.ToDateTime(dr["NoticeDate"]).ToString("yyyy-MM-dd");
                        txtResignDate.Text = Convert.ToDateTime(dr["ResignDate"]).ToString("yyyy-MM-dd");
                        txtReason.Text = dr["Reason"].ToString();
                    }
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindTerminations();
        }
    }
}