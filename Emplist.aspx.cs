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
    public partial class Emplist : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
            if (!IsPostBack) {
                BindGridViewData();
                BindDataListData();

                if (GridView1.Rows.Count > 0)
                {
                    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
                }

            }
        }
        private void BindGridViewData()
        {
            string q = $"exec fuser ";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            GridView1.DataSource = rdr;
            GridView1.DataBind();
        }
        private void BindDataListData()
        {
            string q = $"exec spflist ";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DataList1.DataSource = rdr;
            DataList1.DataBind();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string fname, lname, Doj, username, email, pass, conpass, number, company, Dept, Desi, profile;
            fname = TextBox1.Text;
            lname = TextBox2.Text;
            Doj = TextBox4.Text;
            username = TextBox5.Text;
            email = TextBox6.Text;
            pass = TextBox7.Text;
            conpass = TextBox8.Text;
            number = TextBox9.Text;
            company = TextBox10.Text;
            Dept = DropDownList1.SelectedValue;
            Desi = DropDownList2.SelectedValue;
            int empid = int.parse(TextBox3.Text);
            string q = $"";//insert sp
            Sqlcommand cmd = new Sqlcommand(q, conn);
            cmd.ExecuteNonQuery;
        }

       
    }
}