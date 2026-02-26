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
    public partial class HolidaysList : System.Web.UI.Page
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
                BindEventTypes();
                BindHolidays();
            }
        }

        // ================================
        // Bind Event Types Dropdown
        // ================================
        private void BindEventTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT Id, Name FROM EventTypes", con);
                con.Open();
                ddlEventType.DataSource = cmd.ExecuteReader();
                ddlEventType.DataTextField = "Name";
                ddlEventType.DataValueField = "Id";
                ddlEventType.DataBind();
                ddlEventType.Items.Insert(0, new ListItem("Select Type", ""));
            }
        }

        // ================================
        // Get Data
        // ================================
        private DataTable GetData()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetAllEvents", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // ================================
        // Bind Holidays
        // ================================
        private void BindHolidays()
        {
            DataTable dt = GetData();

            // Search
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                var rows = dt.AsEnumerable()
                    .Where(r => r["Title"].ToString().ToLower()
                    .Contains(txtSearch.Text.ToLower()));

                dt = rows.Any() ? rows.CopyToDataTable() : dt.Clone();
            }

            int pageSize = Convert.ToInt32(ddlEntries.SelectedValue);
            int totalRecords = dt.Rows.Count;

            TotalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            var pagedData = dt.AsEnumerable()
                .Skip(CurrentPage * pageSize)
                .Take(pageSize);

            rptHolidays.DataSource = pagedData.Any() ? pagedData.CopyToDataTable() : null;
            rptHolidays.DataBind();

            lblShowingText.Text = $"Showing {Math.Min(pageSize, totalRecords)} of {totalRecords} entries";

            BindPagination();
        }

        // ================================
        // Pagination
        // ================================
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
                BindHolidays();
            }
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
            {
                CurrentPage--;
                BindHolidays();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (CurrentPage < TotalPages - 1)
            {
                CurrentPage++;
                BindHolidays();
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindHolidays();
        }

        // ================================
        // Insert / Update
        // ================================
        protected void btnSubmitEvent_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd;

                if (!string.IsNullOrEmpty(hfEventId.Value))
                {
                    cmd = new SqlCommand("sp_UpdateEvent", con);
                    cmd.Parameters.AddWithValue("@Id", hfEventId.Value);
                }
                else
                {
                    cmd = new SqlCommand("sp_InsertEvent", con);
                }

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Title", txtEventTitle.Text);
                cmd.Parameters.AddWithValue("@Date", txtEventDate.Text);
                cmd.Parameters.AddWithValue("@EventTypeId", ddlEventType.SelectedValue);
                cmd.Parameters.AddWithValue("@Status", "Active");

                con.Open();
                cmd.ExecuteNonQuery();
            }

            hfEventId.Value = "";
            BindHolidays();
        }

        // ================================
        // Edit / Delete / Toggle
        // ================================
        protected void rptHolidays_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_DeleteEvent", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                BindHolidays();
            }

            else if (e.CommandName == "Edit")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_GetEventById", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", id);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        hfEventId.Value = dr["Id"].ToString();
                        txtEventTitle.Text = dr["Title"].ToString();
                        txtEventDate.Text = Convert.ToDateTime(dr["Date"]).ToString("yyyy-MM-dd");
                        ddlEventType.SelectedValue = dr["EventTypeId"].ToString();
                    }
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            }

            else if (e.CommandName == "ToggleStatus")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand getCmd = new SqlCommand("SELECT Status FROM Events WHERE Id=@Id", con);
                    getCmd.Parameters.AddWithValue("@Id", id);

                    string currentStatus = getCmd.ExecuteScalar().ToString();
                    string newStatus = currentStatus == "Active" ? "Inactive" : "Active";

                    SqlCommand updateCmd = new SqlCommand("UPDATE Events SET Status=@Status WHERE Id=@Id", con);
                    updateCmd.Parameters.AddWithValue("@Status", newStatus);
                    updateCmd.Parameters.AddWithValue("@Id", id);
                    updateCmd.ExecuteNonQuery();
                }

                BindHolidays();
            }
        }
    }
}