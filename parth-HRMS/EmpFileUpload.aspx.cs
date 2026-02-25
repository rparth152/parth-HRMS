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
    public partial class EmpFileUpload : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string name = TextBox1.Text;
            string doc = TextBox2.Text;
            string filepath = "";
            if (FileUpload1.HasFile)
            {
                filepath = "~/Uploads/" + FileUpload1.FileName;
                FileUpload1.SaveAs(Server.MapPath(filepath));
            }

            SqlConnection conn = new SqlConnection(cs);

            string q = $"exec sp_AddEmpDoc @DocName,@FilePath";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.Parameters.AddWithValue("@DocName", doc);
            cmd.Parameters.AddWithValue("@FilePath", filepath);
            Response.Write("<script>alert('Document Added')</script>");
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Panel2.Visible = true;
        }
        protected void btnDeleteRow2_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
        }
    }
}