using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
namespace parth_HRMS
{
    public partial class Designation : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
            if (!IsPostBack)
            {
                FetchDept();
                FetchStaus();
                BindGridViewData();

            }
        }
        public void FetchStaus()
        {
            string q = "exec [dbo].[fetchstatus]";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DropDownList2.DataSource = rdr;
            DropDownList2.DataTextField = "status";
            DropDownList2.DataValueField = "status";
            DropDownList2.DataBind();
        }
        public void FetchDept()
        {
            string q = "exec [dbo].[fetchdept]";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DropDownList1.DataSource = rdr;
            DropDownList1.DataTextField = "Name";
            DropDownList1.DataValueField = "DepartmentId";
            DropDownList1.DataBind();
        }
        private void BindGridViewData()
        {
            string q = $"exec fetchDesi ";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            GridView1.DataSource = rdr;
            GridView1.DataBind();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string Desiname = TextBox1.Text;
            string Deptid = DropDownList1.SelectedValue;
            string status = DropDownList2.SelectedValue;
            string Role = Session["Role"].ToString();
            string q = $"exec adddesi '{Desiname}','{status}','{Role}','{Deptid}'";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();
            BindGridViewData();
            
            //Session["Deptid"] = rdr["DepartmentId"];
            //string Deptid = Session["Deptid"].ToString();

            //string q = $"exec [Designations] '{DeptName}','{status}','{Role}','{Deptid}'";
            //SqlCommand cmd = new SqlCommand(q, conn);
            //cmd.ExecuteNonQuery();
            //BindGridViewData();
            
        }
    }
}