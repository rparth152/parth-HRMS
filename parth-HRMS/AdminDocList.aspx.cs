using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace parth_HRMS
{
    public partial class AdminDocList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand =
                "SELECT * FROM addAdminDocNames WHERE DocName LIKE '%" + txtSearch.Text + "%'";

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("addAdminDoc.aspx");
        }
        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView1.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
        }
    }
}