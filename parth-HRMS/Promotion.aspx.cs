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
    public partial class Promotion : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        public int CurrentPage
        {
            get { return ViewState["CurrentPage"] == null ? 0 : (int)ViewState["CurrentPage"]; }
            set { ViewState["CurrentPage"] = value; }
        }

        public int TotalPages
        {
            get { return ViewState["TotalPages"] == null ? 0 : (int)ViewState["TotalPages"]; }
            set { ViewState["TotalPages"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEmployeeDropdown();
                BindPromotions();
            }
        }

        // ===============================
        // Dropdown Binding
        // ===============================
        private void BindEmployeeDropdown()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT UserID, FirstName FROM Users", con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    ddlEmployee.DataSource = dr;
                    ddlEmployee.DataTextField = "EmployeeName";
                    ddlEmployee.DataValueField = "UserID";
                    ddlEmployee.DataBind();

                    ddlEmployee.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Employee --", "0"));
                }
            }
        }

        // ===============================
        // Get All + Filters + Pagination
        // ===============================
        private void BindPromotions()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetAllPromotions", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            // SEARCH
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                dt = dt.AsEnumerable()
                    .Where(r => r["EmployeeName"].ToString().ToLower()
                    .Contains(txtSearch.Text.ToLower()))
                    .CopyToDataTable();
            }

            // DATE FILTER
            if (ddlFilterDate.SelectedValue != "All")
            {
                DateTime now = DateTime.Now;

                if (ddlFilterDate.SelectedValue == "Today")
                    dt = dt.AsEnumerable()
                        .Where(r => Convert.ToDateTime(r["Date"]).Date == now.Date)
                        .CopyToDataTable();

                if (ddlFilterDate.SelectedValue == "Last7Days")
                    dt = dt.AsEnumerable()
                        .Where(r => Convert.ToDateTime(r["Date"]) >= now.AddDays(-7))
                        .CopyToDataTable();

                if (ddlFilterDate.SelectedValue == "LastMonth")
                    dt = dt.AsEnumerable()
                        .Where(r => Convert.ToDateTime(r["Date"]) >= now.AddMonths(-1))
                        .CopyToDataTable();
            }

            // SORT
            if (ddlSort.SelectedValue == "ASC")
                dt = dt.AsEnumerable()
                    .OrderBy(r => Convert.ToDateTime(r["Date"]))
                    .CopyToDataTable();
            else
                dt = dt.AsEnumerable()
                    .OrderByDescending(r => Convert.ToDateTime(r["Date"]))
                    .CopyToDataTable();

            // PAGINATION
            int pageSize = Convert.ToInt32(ddlEntries.SelectedValue);
            int totalRecords = dt.Rows.Count;

            TotalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            var pagedData = dt.AsEnumerable()
                .Skip(CurrentPage * pageSize)
                .Take(pageSize);

            if (pagedData.Any())
                rptPromotions.DataSource = pagedData.CopyToDataTable();
            else
                rptPromotions.DataSource = null;

            rptPromotions.DataBind();

            lblShowingText.Text = $"Showing {Math.Min((CurrentPage * pageSize) + 1, totalRecords)} to {Math.Min((CurrentPage + 1) * pageSize, totalRecords)} of {totalRecords} entries";

            BindPagination();
        }

        private void BindPagination()
        {
            var pages = Enumerable.Range(0, TotalPages)
                .Select(i => new { PageIndex = i, PageText = (i + 1).ToString() });

            rptPagination.DataSource = pages;
            rptPagination.DataBind();
        }

        // ===============================
        // Insert / Update
        // ===============================
        protected void btnSubmitPromotion_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;

                    if (string.IsNullOrEmpty(hfPromotionId.Value))
                        cmd.CommandText = "sp_InsertPromotion";
                    else
                    {
                        cmd.CommandText = "sp_UpdatePromotion";
                        cmd.Parameters.AddWithValue("@PromotionId", hfPromotionId.Value);
                    }

                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@UserID", ddlEmployee.SelectedValue);
                    cmd.Parameters.AddWithValue("@DesignationFrom", txtDesigFrom.Text);
                    cmd.Parameters.AddWithValue("@DesignationTo", txtDesigTo.Text);
                    cmd.Parameters.AddWithValue("@Date", txtPromoDate.Text);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindPromotions();
            ScriptManager.RegisterStartupScript(this, GetType(), "close", "var myModalEl = document.getElementById('addPromotionModal'); var modal = bootstrap.Modal.getInstance(myModalEl); modal.hide();", true);
        }

        // ===============================
        // Edit / Delete
        // ===============================
        protected void rptPromotions_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Edit")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_GetPromotionById", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PromotionId", id);

                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            hfPromotionId.Value = dr["PromotionId"].ToString();
                            ddlEmployee.SelectedValue = dr["UserID"].ToString();
                            txtDesigFrom.Text = dr["DesignationFrom"].ToString();
                            txtDesigTo.Text = dr["DesignationTo"].ToString();
                            txtPromoDate.Text = Convert.ToDateTime(dr["Date"]).ToString("yyyy-MM-dd");
                        }
                    }
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "open", "openModal();", true);
            }

            if (e.CommandName == "Delete")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_DeletePromotion", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PromotionId", id);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                BindPromotions();
            }
        }

        // ===============================
        // Pagination Buttons
        // ===============================
        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
            {
                CurrentPage--;
                BindPromotions();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (CurrentPage < TotalPages - 1)
            {
                CurrentPage++;
                BindPromotions();
            }
        }

        protected void rptPagination_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                CurrentPage = Convert.ToInt32(e.CommandArgument);
                BindPromotions();
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindPromotions();
        }
    }
}