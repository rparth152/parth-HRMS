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
    public partial class UplDocList : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownList1.Items.Add("5");
                DropDownList1.Items.Add("10");
                DropDownList1.Items.Add("20");

                BindGrid();
            }
        }

        void BindGrid()
        {
            SqlConnection conn = new SqlConnection(cs);

            string search = TextBox1.Text;
            string q = "SELECT * FROM addAdminDoc WHERE DocName LIKE @s OR [user] LIKE @s";

            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.Parameters.AddWithValue("@s", "%" + search + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.PageSize = Convert.ToInt32(DropDownList1.SelectedValue);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void GridView1_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void GridView1_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Download")
            {
                Response.Redirect(e.CommandArgument.ToString());
            }

            if (e.CommandName == "DeleteDoc")
            {
                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand("DELETE FROM addAdminDoc WHERE id=@id", conn);
                cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                BindGrid();
            }
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid();
        }
    }
}