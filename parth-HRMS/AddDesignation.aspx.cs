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
    public partial class AddDesignation : System.Web.UI.Page
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
                FeatchDesignation();
                if (GridView1.Rows.Count > 0)
                {
                    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
                }

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
        //private void BindGridViewData()
        //{
        //    string q = $"exec fetchDesi ";

        //    SqlCommand cmd = new SqlCommand(q, conn);
        //    SqlDataReader rdr = cmd.ExecuteReader();

        //    GridView1.DataSource = rdr;
        //    GridView1.DataBind();
        //}
        public void FeatchDesignation()
        {
            string q = "exec sp_featchDesignation";
            SqlDataAdapter ada = new SqlDataAdapter(q, conn);
            DataTable dt = new DataTable();
            ada.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            //string Desiname = TextBox1.Text;
            //string Deptid = DropDownList1.SelectedValue;
            //string status = DropDownList2.SelectedValue;
            //string Role = Session["Role"].ToString();
            //string q = $"exec adddesi '{Desiname}','{status}','{Role}','{Deptid}'";
            //SqlCommand cmd = new SqlCommand(q, conn);
            //cmd.ExecuteNonQuery();
            //FeatchDesignation();

            //Session["Deptid"] = rdr["DepartmentId"];
            //string Deptid = Session["Deptid"].ToString();

            //string q = $"exec [Designations] '{DeptName}','{status}','{Role}','{Deptid}'";
            //SqlCommand cmd = new SqlCommand(q, conn);
            //cmd.ExecuteNonQuery();
            //BindGridViewData();

        }
        protected void Button2_Click(object sender, EventArgs e)
        { }
        }
}