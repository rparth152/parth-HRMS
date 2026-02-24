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
    public partial class Add_Dept : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
            string loggedInUser = Session["Email"].ToString();
            string pass = Session["Pass"].ToString();
            string Role = Session["Role"].ToString();

            if (!IsPostBack)
            {
                FetchStaus();
                BindGridViewData();

            }
        }
        public void FetchStaus()
        {
            string q = "exec fetchstatus";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DropDownList1.DataSource = rdr;
            DropDownList1.DataTextField = "status";
            DropDownList1.DataValueField = "status";
            DropDownList1.DataBind();
        }
        private void BindGridViewData()
        {
            string q = $"exec fetchdept ";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            
            string Role = Session["Role"].ToString();
            string dept = TextBox1.Text;
            string status = DropDownList1.SelectedValue;
            string q = $"exec [dbo].[Adddept] '{dept}','{status}','{Role}'";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();
            BindGridViewData();
        }

    }
}