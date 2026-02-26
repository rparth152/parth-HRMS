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
    public partial class TrainingTypes : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected int CurrentPage
        {
            get { return ViewState["CurrentPage"] == null ? 0 : (int)ViewState["CurrentPage"]; }
            set { ViewState["CurrentPage"] = value; }
        }

        protected int TotalPages
        {
            get { return ViewState["TotalPages"] == null ? 0 : (int)ViewState["TotalPages"]; }
            set { ViewState["TotalPages"] = value; }
        }

        int PageSize = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CurrentPage = 0;
                BindTrainingType();
            }
        }

        void BindTrainingType()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("sp_GetAllTrainingTypes", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                da.SelectCommand.Parameters.AddWithValue("@Search", txtSearch.Text.Trim());
                da.SelectCommand.Parameters.AddWithValue("@Sort", ddlSort.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                PageSize = Convert.ToInt32(ddlEntries.SelectedValue);

                PagedDataSource pg = new PagedDataSource();
                pg.DataSource = dt.DefaultView;
                pg.AllowPaging = true;
                pg.PageSize = PageSize;
                pg.CurrentPageIndex = CurrentPage;

                TotalPages = pg.PageCount;

                rptTrainingType.DataSource = pg;
                rptTrainingType.DataBind();

                lblShowingText.Text = $"Showing {CurrentPage * PageSize + 1} to {Math.Min((CurrentPage + 1) * PageSize, dt.Rows.Count)} of {dt.Rows.Count} entries";

                BindPagination();
            }
        }

        void BindPagination()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("PageIndex");
            dt.Columns.Add("PageText");

            for (int i = 0; i < TotalPages; i++)
            {
                dt.Rows.Add(i, i + 1);
            }

            rptPagination.DataSource = dt;
            rptPagination.DataBind();
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
            {
                CurrentPage--;
                BindTrainingType();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (CurrentPage < TotalPages - 1)
            {
                CurrentPage++;
                BindTrainingType();
            }
        }

        protected void rptPagination_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                CurrentPage = Convert.ToInt32(e.CommandArgument);
                BindTrainingType();
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindTrainingType();
        }

        protected void rptTrainingType_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_DeleteTrainingType", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TrainingTypeId", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            else if (e.CommandName == "Edit")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_GetTrainingTypeById", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TrainingTypeId", id);
                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hfTrainingTypeId.Value = dr["TrainingTypeId"].ToString();
                        txtTypeName.Text = dr["TrainingTypeName"].ToString();
                        txtDescription.Text = dr["Description"].ToString();
                        ddlStatus.SelectedValue = dr["Status"].ToString();

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                    }
                }
            }
            else if (e.CommandName == "ToggleStatus")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_ToggleTrainingTypeStatus", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TrainingTypeId", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindTrainingType();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd;

                if (string.IsNullOrEmpty(hfTrainingTypeId.Value))
                {
                    cmd = new SqlCommand("sp_InsertTrainingType", con);
                }
                else
                {
                    cmd = new SqlCommand("sp_UpdateTrainingType", con);
                    cmd.Parameters.AddWithValue("@TrainingTypeId", hfTrainingTypeId.Value);
                }

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@TrainingTypeName", txtTypeName.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindTrainingType();
        }
    }
}