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
    public partial class AttendanceReport : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();
            if (!IsPostBack)
            {
                LoadAttendance();
                LoadCounts();
                getDataTable();
                LoadAttendance();
                //LoadChart();
            }

        }

        private void LoadAttendance()
        {
            string query = @"SELECT 
                            a.AttendanceId,
                            (u.FirstName + ' ' + u.LastName) AS FullName,
                            a.Date,
                            a.CheckIn,
                            a.CheckOut,
                            a.LunchIn,
                            a.LunchOut,
                            a.Status,
                            a.WorkingHours,
                            a.OvertimeHours,
                            a.BreakHours,
                            a.Late,
                            a.ProductionHours
                            FROM Attendance a
                            JOIN [User] u ON a.UserId = u.UserId";

            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvAttendance.DataSource = dt;
            gvAttendance.DataBind();

            getDataTable();
        }

        public void getDataTable()
        {
            if (gvAttendance.Rows.Count > 0)
            {

                gvAttendance.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        private void LoadCounts()
        {


            // Total Working Days
            SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM Attendance WHERE Status='Present'", conn);
            lblWorkingDays.Text = cmd1.ExecuteScalar().ToString();

            // Total Leave
            SqlCommand cmd2 = new SqlCommand("SELECT COUNT(*) FROM Attendance WHERE Status='Absent'", conn);
            lblLeave.Text = cmd2.ExecuteScalar().ToString();

            // Total Holidays
            SqlCommand cmd3 = new SqlCommand("SELECT COUNT(*) FROM Attendance WHERE Status='Holiday'", conn);
            lblHoliday.Text = cmd3.ExecuteScalar().ToString();

            // Total Halfdays
            SqlCommand cmd4 = new SqlCommand("SELECT COUNT(*) FROM Attendance WHERE Status='Halfday'", conn);
            lblHalfday.Text = cmd4.ExecuteScalar().ToString();

        }


        private void LoadAttendance(string status = "")
        {
            string query = @"SELECT 
                        a.AttendanceId,
                        (u.FirstName + ' ' + u.LastName) AS FullName,
                        a.Date,
                        a.CheckIn,
                        a.CheckOut,
                        a.Status,
                        a.BreakHours,
                        a.Late,
                        a.OvertimeHours,
                        a.ProductionHours
                     FROM Attendance a
                     JOIN [User] u 
                        ON a.UserId = u.UserId";

            if (!string.IsNullOrEmpty(status))
            {
                query += " WHERE a.Status = @Status";
            }

            SqlCommand cmd = new SqlCommand(query, conn);

            if (!string.IsNullOrEmpty(status))
            {
                cmd.Parameters.AddWithValue("@Status", status);
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvAttendance.DataSource = dt;
            gvAttendance.DataBind();

            getDataTable();
        }

        protected void btnPresent_Click(object sender, EventArgs e)
        {
            LoadAttendance("Present");
        }

        protected void btnAbsent_Click(object sender, EventArgs e)
        {
            LoadAttendance("Absent");
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {
            LoadAttendance();
        }

        protected void Status_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string selectedStatus = btn.CommandArgument;

            btnStatus.Text = string.IsNullOrEmpty(selectedStatus)
                                ? "Select Status"
                                : selectedStatus;

            LoadAttendance(selectedStatus);
            getDataTable();


        }


        private void LoadAttendance(string status = "", string sortType = "")
        {
            string query = @"SELECT 
                    u.UserId,
                    (u.FirstName + ' ' + u.LastName) AS FullName,
                    a.Date,
                    a.CheckIn,
                    a.CheckOut,
                    a.Status,
                    a.BreakHours,
                    a.Late,
                    a.OvertimeHours,
                    a.ProductionHours
                 FROM Attendance a
                 JOIN [User] u ON a.UserId = u.UserId";

            // Date Filters
            if (sortType == "Last7Days")
            {
                query += " WHERE a.Date >= DATEADD(DAY, -7, GETDATE())";
            }
            else if (sortType == "LastMonth")
            {
                query += " WHERE a.Date >= DATEADD(MONTH, -1, GETDATE())";
            }

            // Sorting
            if (sortType == "ASC")
            {
                query += " ORDER BY a.Date ASC";
            }
            else if (sortType == "DESC")
            {
                query += " ORDER BY a.Date DESC";
            }
            else if (sortType == "Recent")
            {
                query += " ORDER BY a.AttendanceId DESC";
            }

            SqlCommand cmd = new SqlCommand(query, conn);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvAttendance.DataSource = dt;
            gvAttendance.DataBind();

            getDataTable();
        }

        protected void Sort_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string sortType = btn.CommandArgument;

            btnSort.Text = "Sort By : " + btn.Text;

            LoadAttendance("", sortType);


        }

        private void LoadChart()
        {



            string query = @"
                SELECT 
                    DATENAME(MONTH, Date) AS MonthName,
                    MONTH(Date) AS MonthNumber,
                    SUM(CASE WHEN Status='Present' THEN 1 ELSE 0 END) AS PresentCount,
                    SUM(CASE WHEN Status='Absent' THEN 1 ELSE 0 END) AS AbsentCount
                FROM Attendance
                WHERE YEAR(Date) = YEAR(GETDATE())
                GROUP BY DATENAME(MONTH, Date), MONTH(Date)
                ORDER BY MonthNumber";

            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                string month = dr["MonthName"].ToString();
                int present = Convert.ToInt32(dr["PresentCount"]);
                int absent = Convert.ToInt32(dr["AbsentCount"]);

                Chart1.Series["Present"].Points.AddXY(month, present);
                Chart1.Series["Absent"].Points.AddXY(month, absent);
            }

        }




    }
}