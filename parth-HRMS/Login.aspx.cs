using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace parth_HRMS
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection conn;
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
            //string dbEmail = rdr[0].ToString();
            //string dbPass = rdr[1].ToString();
            //string role = rdr[3].ToString();

            if (rdr.HasRows)
            {
                //if (rdr.Read())
                //{
                //    Session["Email"] = rdr["Email"].ToString();
                //    Session["Role"] = rdr["Role"].ToString();

                //    Response.Redirect("Dashboard.aspx");
                //}
                //else
                //{
                //    //Label1.Text = "Invalid Email or Password";
                //}
                while (rdr.Read())
                {
                    Session["Role"] = rdr[3];
                    if (rdr["Email"].ToString() == em && rdr["PasswordHash"].ToString() == pass && rdr["RoleName"].ToString() == "Admin")
                    {
                        Response.Redirect("ManagerDashboard.aspx");
                        //Response.Redirect("AdminDashboard.aspx");
                    }
                    //else if (dbEmail == em && dbPass == pass && role == "Manager")
                    //{

                    //    Response.Redirect("ManagerDashboard.aspx");
                    //}
                    //else if (dbEmail == em && dbPass == pass && role == "Employee")
                    //{

                    //    Response.Redirect("UserDashboard.aspx");
                    //}
                    else
                    {
                        Response.Redirect("<script>alert('Invalid Email or Password')</script>");
                    }
                }

            }

        }
    }
}