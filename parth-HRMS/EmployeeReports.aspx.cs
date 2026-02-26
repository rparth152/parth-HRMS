using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace parth_HRMS
{
    public partial class EmployeeReports : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();
            if (!IsPostBack)
            {
                GetTotalEmployee();
                GetTotalActiveEmployee();
                GetTotalDepartMent();
                LoadEmployeeChart();
                LoadEmployees();
                LoadAscDes();
            }

            getDataTable();


        }


        public void GetTotalEmployee()
        {
            string query = "select count(*) as TotalCount from [User] ";

            SqlCommand cmd = new SqlCommand(query, conn);

            int total = (int)cmd.ExecuteScalar();

            lblTotalEmployee.Text = total.ToString();

        }

        public void GetTotalActiveEmployee()
        {
            string query = "select count(*) as TotalCount from [User]  where status='Active'";
            SqlCommand cmd = new SqlCommand(query, conn);
            int active = (int)cmd.ExecuteScalar();
            Label1.Text = active.ToString();


        }

        public void GetTotalDepartMent()
        {
            string query = "select count(*) as TotalDepartMent from Departments";
            SqlCommand cmd = new SqlCommand(query, conn);
            int active = (int)cmd.ExecuteScalar();
            Label2.Text = active.ToString();


        }


        public void GetInActiveEmployee()
        {
            string query = " select count(*) as TotalCount from[User]  where status = 'InActive'";
            SqlCommand cmd = new SqlCommand(query, conn);
            int active = (int)cmd.ExecuteScalar();
            Label2.Text = active.ToString();


        }

        private void LoadEmployeeChart()
        {

            string query = @" SELECT FORMAT(DateOfJoining, 'yyyy-MM') AS Month,
                                SUM(CASE WHEN Status ='Active' THEN 1 ELSE 0 END) AS ActiveCount,
                                SUM(CASE WHEN Status ='InActive' THEN 1 ELSE 0 END) AS InactiveCount
                                FROM [User]
                                GROUP BY FORMAT(DateOfJoining, 'yyyy-MM')
                                ORDER BY Month; ";

            SqlCommand cmd = new SqlCommand(query, conn);

            SqlDataReader dr = cmd.ExecuteReader();

            StringBuilder months = new StringBuilder();
            StringBuilder active = new StringBuilder();
            StringBuilder inactive = new StringBuilder();

            while (dr.Read())
            {
                months.Append(dr["Month"].ToString() + ",");
                active.Append(dr["ActiveCount"].ToString() + ",");
                inactive.Append(dr["InactiveCount"].ToString() + ",");
            }

            hfMonths.Value = months.ToString().TrimEnd(',');
            hfActiveData.Value = active.ToString().TrimEnd(',');
            hfInactiveData.Value = inactive.ToString().TrimEnd(',');

        }

        private void LoadEmployees(string status = "", string sortType = "")
        {


            string query = @"SELECT 
                            u.UserId,
                            u.ProfilePicture,
                            (u.FirstName + ' ' + u.LastName) AS FullName,
                            u.Email,
                            d.Name,
                            u.PhoneNumber,
                            u.DateOfJoining,
                            u.Status
                         FROM [User] u
                         JOIN Departments d 
                            ON u.DepartmentId = d.DepartmentId";



            if (!string.IsNullOrEmpty(status))
            {
                query += " WHERE u.Status = @Status";
            }

            SqlCommand cmd = new SqlCommand(query, conn);

            if (!string.IsNullOrEmpty(status))
            {
                cmd.Parameters.AddWithValue("@Status", status);
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvEmployees.DataSource = dt;
            gvEmployees.DataBind();

            getDataTable();
        }


        private void LoadAscDes(string status = "", string sortType = "")
        {
            string query = @"SELECT 
                        u.UserId,
                        u.ProfilePicture,
                        (u.FirstName + ' ' + u.LastName) AS FullName,
                        u.Email,
                        d.Name,
                        u.PhoneNumber,
                        u.DateOfJoining,
                        u.Status
                     FROM [User] u
                     JOIN Departments d 
                        ON u.DepartmentId = d.DepartmentId
                     WHERE 1=1 ";


            if (!string.IsNullOrEmpty(status) &&
                status != "ASC" &&
                status != "DESC" &&
                status != "LAST7" &&
                status != "LASTMONTH")
            {
                query += " AND u.Status = @Status ";
            }

            if (sortType == "LAST7")
            {
                query += " AND u.DateOfJoining >= DATEADD(DAY, -7, GETDATE()) ";
            }
            else if (sortType == "LASTMONTH")
            {
                query += " AND u.DateOfJoining >= DATEADD(MONTH, -1, GETDATE()) ";
            }


            if (sortType == "ASC")
            {
                query += " ORDER BY u.DateOfJoining ASC ";
            }
            else if (sortType == "DESC")
            {
                query += " ORDER BY u.DateOfJoining DESC ";
            }

            SqlCommand cmd = new SqlCommand(query, conn);

            if (!string.IsNullOrEmpty(status) &&
                status != "ASC" &&
                status != "DESC" &&
                status != "LAST7" &&
                status != "LASTMONTH")
            {
                cmd.Parameters.AddWithValue("@Status", status);
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvEmployees.DataSource = dt;
            gvEmployees.DataBind();


            getDataTable();
        }

        public void getDataTable()
        {
            if (gvEmployees.Rows.Count > 0)
            {

                gvEmployees.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btnPresent_Click(object sender, EventArgs e)
        {
            LoadEmployees("Present");
        }

        protected void btnAbsent_Click(object sender, EventArgs e)
        {
            LoadEmployees("Absent");
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {
            LoadEmployees();
        }


        protected void btnActive_Click(object sender, EventArgs e)
        {
            LoadEmployees("Active");
        }

        protected void btnInactive_Click(object sender, EventArgs e)
        {
            LoadEmployees("Inactive");
        }

        protected void btnAsc_Click(object sender, EventArgs e)
        {
            LoadAscDes("", "ASC");
        }

        protected void btnDesc_Click(object sender, EventArgs e)
        {
            LoadAscDes("", "DESC");
        }

        protected void btnLast7Days_Click(object sender, EventArgs e)
        {
            LoadAscDes("", "LAST7");
        }

        protected void btnLastMonth_Click(object sender, EventArgs e)
        {
            LoadAscDes("", "LASTMONTH");
        }
    }
}