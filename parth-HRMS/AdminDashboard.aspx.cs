using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace parth_HRMS
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
            if (!IsPostBack)
            {
                Bindchart();
            }
        }

        public void Bindchart() {
            string q = @"SELECT Status, COUNT(*) AS TotalCount FROM [User] GROUP BY Status";

            SqlDataAdapter da = new SqlDataAdapter(q, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            Chart1.DataSource = dt;
            Chart1.Series["UserStatus"].XValueMember = "Status";
            Chart1.Series["UserStatus"].YValueMembers = "TotalCount";
            Chart1.DataBind();
        }
    }
}