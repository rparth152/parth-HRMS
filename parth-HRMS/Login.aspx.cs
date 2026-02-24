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
    public partial class Login : System.Web.UI.Page
    {   SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            string em, pass;
            em = TextBox1.Text;
            pass = TextBox2.Text;
            string q = $"exec [dbo].[login] '{em}','{pass}'";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();
            Session["Email"] = $"{em}";
            Session["Pass"] = $"{pass}";
            

            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    Session["Role"] = rdr["RoleName"];
                    if (rdr["Email"].Equals(em) && rdr["PasswordHash"].Equals(pass) && rdr["RoleName"].Equals("Admin"))
                    {
                        Response.Redirect("AdminDashboard.aspx");
                    }
                    else if (rdr["Email"].Equals(em) && rdr["PasswordHash"].Equals(pass) && rdr["RoleId"].Equals("Manager"))
                    {
                    }
                    else if (rdr["Email"].Equals(em) && rdr["PasswordHash"].Equals(pass) && rdr["RoleId"].Equals("User"))
                    {
                    }
                }
            }
        }
    }
}