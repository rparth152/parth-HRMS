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
    public partial class AdminFileUpl : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            if (!IsPostBack)
            {
                fetchDocs();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string user = txtUser.Text;
            string doc = DropDownList1.Text;
            string filepath = "";
            if (FileUpload1.HasFile)
            {
                filepath = "~/Uploads/" + FileUpload1.FileName;
                FileUpload1.SaveAs(Server.MapPath(filepath));
            }

            string q = $"exec sp_AddAdminDoc @user,@DocName,@FilePath";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.Parameters.AddWithValue("@user", user);
            cmd.Parameters.AddWithValue("@DocName", doc);
            cmd.Parameters.AddWithValue("@FilePath", filepath);
            Response.Write("<script>alert('Documents Added')</script>");
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        protected void txtDocName_TextChanged(object sender, EventArgs e)
        {

        }
        void fetchDocs()
        {

            string q = "SELECT DocName FROM addAdminDocNames";
            conn.Open();

            SqlCommand cmd = new SqlCommand(q, conn);
            DropDownList1.DataSource = cmd.ExecuteReader();
            DropDownList1.DataTextField = "DocName";
            DropDownList1.DataValueField = "DocName";
            DropDownList1.DataBind();

            conn.Close();

        }
    }
}