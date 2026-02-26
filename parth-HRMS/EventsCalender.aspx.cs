using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace parth_HRMS
{
    public partial class EventsCalender : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEventTypes();
                BindUpcomingEvents();
            }
        }

        // ==============================
        // Bind Event Types Dropdown
        // ==============================
        private void BindEventTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT Id, Name FROM EventTypes", con);
                con.Open();

                ddlEventType.DataSource = cmd.ExecuteReader();
                ddlEventType.DataTextField = "Name";
                ddlEventType.DataValueField = "Id";
                ddlEventType.DataBind();

                ddlEventType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Type", ""));
            }
        }

        // ==============================
        // Bind Upcoming Events (Right Side Cards)
        // ==============================
        private void BindUpcomingEvents()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetAllEvents", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptUpcomingEvents.DataSource = dt;
                rptUpcomingEvents.DataBind();
            }
        }

        // ==============================
        // Insert Event
        // ==============================
        protected void btnSubmitEvent_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_InsertEvent", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Title", txtEventTitle.Text);
                cmd.Parameters.AddWithValue("@Date", txtEventDate.Text);
                cmd.Parameters.AddWithValue("@EventTypeId", ddlEventType.SelectedValue);
                cmd.Parameters.AddWithValue("@Status", "Active");

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindUpcomingEvents();

            // Refresh Calendar via JS
            ScriptManager.RegisterStartupScript(this, this.GetType(), "refreshCalendar", "refreshCalendar();", true);
        }

        // ==============================
        // FullCalendar WebMethod
        // ==============================
        [WebMethod]
        public static string GetCalendarEvents()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetAllEvents", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                var events = new System.Collections.Generic.List<object>();

                foreach (DataRow row in dt.Rows)
                {
                    events.Add(new
                    {
                        id = row["Id"].ToString(),
                        title = row["Title"].ToString(),
                        start = row["Date"].ToString(),   // must be yyyy-MM-dd
                        color = row["Color"].ToString()
                    });
                }

                JavaScriptSerializer js = new JavaScriptSerializer();
                return js.Serialize(events);
            }
        }
    }
}