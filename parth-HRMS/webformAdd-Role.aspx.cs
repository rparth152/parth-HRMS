using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace parth_HRMS
{
    public partial class Add_Role : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
            string Role = Session["Role"].ToString();
            if (!IsPostBack)
            {
                FetchStaus();
                BindGridViewData();
                

            }
        }
        public void FetchStaus()
        {
            string q = "exec [fetchstatus]";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DropDownList1.DataSource = rdr;
            DropDownList1.DataTextField = "status";
            DropDownList1.DataValueField = "status";
            DropDownList1.DataBind();
        }
        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label lbl = (Label)GridView1.Rows[e.RowIndex].FindControl("ID");
            String Name = lbl.Text;
            
            string q = $"exec Deldept {Name}";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();
            BindGridViewData();
        }
        private void BindGridViewData()
        {
            
            string q = $"exec sprole ";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            GridView1.DataSource = rdr;
            GridView1.DataBind();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string Role = Session["Role"].ToString();
            string _role = TextBox1.Text;
            string status = DropDownList1.SelectedValue;
            string q = $"exec sp_Role '{_role}','{status}','{Role}'";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();
            BindGridViewData();
        }
    }
}