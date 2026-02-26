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
    public partial class Holidays : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEventTypes();
            }
        }

        // ==========================
        // Bind Event Types
        // ==========================
        private void BindEventTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetAllEventTypes", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptEventTypes.DataSource = dt;
                rptEventTypes.DataBind();

                // Show empty message if no data
                if (dt.Rows.Count == 0)
                {
                    rptEventTypes.Controls.Add(new LiteralControl(
                        "<tr><td colspan='4' class='text-center text-muted'>No event types found.</td></tr>"
                    ));
                }
            }
        }

        // ==========================
        // Insert Event Type
        // ==========================
        protected void btnAddEventType_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtEventTypeName.Text))
                return;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_InsertEventType", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Name", txtEventTypeName.Text.Trim());
                cmd.Parameters.AddWithValue("@Color", txtColor.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            txtEventTypeName.Text = "";
            txtColor.Text = "#000000";

            BindEventTypes();
        }

        // ==========================
        // Delete Event Type
        // ==========================
        protected void rptEventTypes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("sp_DeleteEventType", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Id", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                BindEventTypes();
            }
        }
    }
}