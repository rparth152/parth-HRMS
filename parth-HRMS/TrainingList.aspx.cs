using Org.BouncyCastle.Asn1.Cmp;
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
    public partial class TrainingList : System.Web.UI.Page
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

        int PageSize = 5;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CurrentPage = 0;
                BindTraining();
            }
        }

        void BindTraining()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("sp_GetAllTrainings", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dt = new DataTable();
                da.Fill(dt);

                PagedDataSource pg = new PagedDataSource();
                pg.DataSource = dt.DefaultView;
                pg.AllowPaging = true;
                pg.PageSize = PageSize;
                pg.CurrentPageIndex = CurrentPage;

                TotalPages = pg.PageCount;

                rptTraining.DataSource = pg;
                rptTraining.DataBind();

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
                BindTraining();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (CurrentPage < TotalPages - 1)
            {
                CurrentPage++;
                BindTraining();
            }
        }

        protected void rptPagination_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                CurrentPage = Convert.ToInt32(e.CommandArgument);
                BindTraining();
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindTraining();
        }

        protected void rptTraining_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_DeleteTraining", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TrainingId", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                BindTraining();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd;

                if (string.IsNullOrEmpty(hfTrainingId.Value))
                {
                    cmd = new SqlCommand("sp_InsertTraining", con);
                }
                else
                {
                    cmd = new SqlCommand("sp_UpdateTraining", con);
                    cmd.Parameters.AddWithValue("@TrainingId", hfTrainingId.Value);
                }

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@TrainerId", ddlTrainer.SelectedValue);
                cmd.Parameters.AddWithValue("@TrainingTypeId", ddlTrainingType.SelectedValue);
                cmd.Parameters.AddWithValue("@UserId", ddlEmployee.SelectedValue);
                cmd.Parameters.AddWithValue("@TrainingCost", txtTrainingCost.Text);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
                cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text);
                cmd.Parameters.AddWithValue("@CreatedAt", DateTime.Now);
                cmd.Parameters.AddWithValue("@CreatedBy", "Admin");
                cmd.Parameters.AddWithValue("@ModifiedAt", DateTime.Now);
                cmd.Parameters.AddWithValue("@ModifiedBy", "Admin");

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindTraining();
        }
    }
}