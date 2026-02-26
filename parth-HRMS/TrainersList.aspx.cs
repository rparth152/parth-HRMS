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
    public partial class TrainersList : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
        private int pageSize = 10;

        protected int CurrentPage
        {
            get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 0; }
            set { ViewState["CurrentPage"] = value; }
        }

        protected int TotalPages
        {
            get { return ViewState["TotalPages"] != null ? (int)ViewState["TotalPages"] : 0; }
            set { ViewState["TotalPages"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlEntries.SelectedValue = "10";
                ddlSortFilter.SelectedValue = "Recent";
                LoadTrainers();
            }
        }

        private void LoadTrainers()
        {
            pageSize = int.Parse(ddlEntries.SelectedValue);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_GetAllTrainers", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Optional search filter
                string search = txtSearch.Text.Trim();
                if (!string.IsNullOrEmpty(search))
                {
                    dt = dt.Select($"FirstName + ' ' + LastName LIKE '%{search}%' OR Phone LIKE '%{search}%' OR Email LIKE '%{search}%'").CopyToDataTable();
                }

                // Optional sort
                string sort = ddlSortFilter.SelectedValue;
                if (sort == "ASC") dt.DefaultView.Sort = "TrainerId ASC";
                else if (sort == "DESC") dt.DefaultView.Sort = "TrainerId DESC";

                dt = dt.DefaultView.ToTable();

                // Pagination
                int totalRecords = dt.Rows.Count;
                TotalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

                DataTable dtPage = dt.Clone();
                int start = CurrentPage * pageSize;
                int end = Math.Min(start + pageSize, totalRecords);
                for (int i = start; i < end; i++)
                    dtPage.ImportRow(dt.Rows[i]);

                rptTrainers.DataSource = dtPage;
                rptTrainers.DataBind();

                lblShowingText.Text = $"Showing {start + 1} to {end} of {totalRecords} entries";
               // lblEmptyData.Visible = dtPage.Rows.Count == 0;

                BindPagination();
            }
        }

        private void BindPagination()
        {
            List<object> pages = new List<object>();
            for (int i = 0; i < TotalPages; i++)
            {
                pages.Add(new { PageIndex = i, PageText = (i + 1).ToString() });
            }
            rptPagination.DataSource = pages;
            rptPagination.DataBind();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            CurrentPage = 0;
            LoadTrainers();
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0) CurrentPage--;
            LoadTrainers();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (CurrentPage < TotalPages - 1) CurrentPage++;
            LoadTrainers();
        }

        protected void rptPagination_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                CurrentPage = int.Parse(e.CommandArgument.ToString());
                LoadTrainers();
            }
        }

        protected void rptTrainers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int trainerId = int.Parse(e.CommandArgument.ToString());

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                if (e.CommandName == "Delete")
                {
                    SqlCommand cmd = new SqlCommand("sp_DeleteTrainer", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TrainerId", trainerId);
                    cmd.ExecuteNonQuery();
                }
                else if (e.CommandName == "Edit")
                {
                    SqlCommand cmd = new SqlCommand("sp_GetTrainingById", con); // Actually you need a sp_GetTrainerById if exists
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TrainerId", trainerId);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hfTrainerId.Value = dr["TrainerId"].ToString();
                        txtFirstName.Text = dr["FirstName"].ToString();
                        txtLastName.Text = dr["LastName"].ToString();
                        txtPhone.Text = dr["Phone"].ToString();
                        txtEmail.Text = dr["Email"].ToString();
                        txtDescription.Text = dr["Description"].ToString();
                        ddlRole.SelectedValue = dr["Role"].ToString();
                        ddlStatus.SelectedValue = dr["Status"].ToString();
                        hfExistingImage.Value = dr["ProfilePicture"].ToString();
                        btnSubmitTrainer.Text = "Update Trainer";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenModal", "openModal();", true);
                    }
                    dr.Close();
                }
                else if (e.CommandName == "ToggleStatus")
                {
                    SqlCommand cmdGet = new SqlCommand("sp_GetTrainingById", con); // Ideally, create sp_GetTrainerById
                    cmdGet.CommandType = CommandType.StoredProcedure;
                    cmdGet.Parameters.AddWithValue("@TrainerId", trainerId);
                    string currentStatus = cmdGet.ExecuteScalar().ToString();
                    string newStatus = currentStatus == "Active" ? "Inactive" : "Active";

                    SqlCommand cmdUpdate = new SqlCommand("sp_UpdateTrainer", con);
                    cmdUpdate.CommandType = CommandType.StoredProcedure;
                    cmdUpdate.Parameters.AddWithValue("@TrainerId", trainerId);
                    cmdUpdate.Parameters.AddWithValue("@FirstName", ""); // Fetch current values or pass them
                    cmdUpdate.Parameters.AddWithValue("@LastName", "");
                    cmdUpdate.Parameters.AddWithValue("@Phone", "");
                    cmdUpdate.Parameters.AddWithValue("@Email", "");
                    cmdUpdate.Parameters.AddWithValue("@Role", "");
                    cmdUpdate.Parameters.AddWithValue("@Description", "");
                    cmdUpdate.Parameters.AddWithValue("@Status", newStatus);
                    cmdUpdate.Parameters.AddWithValue("@ProfilePicture", "");
                    cmdUpdate.ExecuteNonQuery();
                }
            }
            LoadTrainers();
        }

        protected void btnSubmitTrainer_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string email = txtEmail.Text.Trim();
            string role = ddlRole.SelectedValue;
            string description = txtDescription.Text.Trim();
            string status = ddlStatus.SelectedValue;
            string profilePicture = hfExistingImage.Value;

            if (fuProfilePicture.HasFile)
            {
                string filename = Guid.NewGuid().ToString() + "_" + fuProfilePicture.FileName;
                fuProfilePicture.SaveAs(Server.MapPath("~/Uploads/Trainers/") + filename);
                profilePicture = "~/Uploads/Trainers/" + filename;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                if (!string.IsNullOrEmpty(hfTrainerId.Value)) // Update
                {
                    cmd.CommandText = "sp_UpdateTrainer";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TrainerId", hfTrainerId.Value);
                }
                else // Insert
                {
                    cmd.CommandText = "sp_InsertTrainer";
                    cmd.CommandType = CommandType.StoredProcedure;
                }

                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Role", role);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@ProfilePicture", profilePicture);

                cmd.ExecuteNonQuery();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseModal", "var myModal = bootstrap.Modal.getInstance(document.getElementById('addTrainerModal')); if(myModal) myModal.hide();", true);
            clearForm();
            LoadTrainers();
        }

        private void clearForm()
        {
            hfTrainerId.Value = "";
            hfExistingImage.Value = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtPhone.Text = "";
            txtEmail.Text = "";
            txtDescription.Text = "";
            ddlRole.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            btnSubmitTrainer.Text = "Add Trainer";
        }
    }
}