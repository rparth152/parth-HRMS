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
    public partial class addAdminDoc : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string docName = TextBox1.Text;

            SqlConnection conn = new SqlConnection(cs);

            string q = "Insert into addAdminDocNames (DocName) values (@DocName)";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.Parameters.AddWithValue("@DocName", docName);
            Response.Write("<script>alert('Document Added')</script>");
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {

        }
    }
}