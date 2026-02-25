using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace parth_HRMS
{
    public partial class EmpGrid : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
            if (!IsPostBack)
            {
                BindGridViewData();
                BindDataListData();
                FetchDept();
                Fetchrole();
                FetchDesi();
                GridView1.Visible = false;
                if (GridView1.Rows.Count > 0)
                {
                    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
                }

            }
        }
        private void BindGridViewData()
        {
            string q = $"exec fuser ";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            GridView1.DataSource = rdr;
            GridView1.DataBind();
        }
        private void Fetchrole()
        {
            string q = "exec frole";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DropDownList3.DataSource = rdr;
            DropDownList3.DataTextField = "RoleName";
            DropDownList3.DataValueField = "RoleId";
            DropDownList3.DataBind();

        }
        private void FetchDesi()
        {
            string q = "exec fdesi";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DropDownList2.DataSource = rdr;
            DropDownList2.DataTextField = "Name";
            DropDownList2.DataValueField = "DesignationId";
            DropDownList2.DataBind();

        }
        private void BindDataListData()
        {
            string q = $"exec spflist ";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DataList1.DataSource = rdr;
            DataList1.DataBind();
        }
        public void FetchDept()
        {
            string q = "exec [dbo].[fetchdept]";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DropDownList1.DataSource = rdr;
            DropDownList1.DataTextField = "Name";
            DropDownList1.DataValueField = "DepartmentId";
            DropDownList1.DataBind();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string firstName, lastName, email, password, phone;
            string about, profilePic, gender, address;
            int roleId, deptId, desiId;
            DateTime doj, dob;
            firstName = TextBox1.Text;
            lastName = TextBox2.Text;
            email = TextBox6.Text;
            password = TextBox7.Text;
            phone = TextBox9.Text;
            about = TextBox11.Text;

            FileUpload1.SaveAs(Server.MapPath("Images/") + Path.GetFileName(FileUpload1.FileName));
            profilePic = "Images/" + Path.GetFileName(FileUpload1.FileName);
            roleId = int.Parse(DropDownList3.SelectedValue);
            deptId = int.Parse(DropDownList1.SelectedValue);
            desiId = int.Parse(DropDownList2.SelectedValue);

            doj = DateTime.Parse(TextBox4.Text);
            dob = DateTime.Parse(TextBoxDOB.Text);
            gender = DropDownGender.SelectedValue;
            address = TextBoxAddress.Text;



            string q = $"EXEC spInsertUser '{firstName}','{lastName}','{email}','{password}','{phone}','{roleId}','{deptId}','{desiId}','{doj}','{dob}','{gender}','{address}','{about}','{profilePic}'";//insert sp
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();
        }

        //protected void Button2_Click(object sender, EventArgs e)
        //{
        //    ExportGridToPDF();
        //}


        [Obsolete]
        private void ExportGridToPDF()
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=EmployeeList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            GridView1.AllowPaging = false;
            GridView1.DataBind();
            GridView1.RenderControl(hw);

            StringReader sr = new StringReader(sw.ToString());

            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);

            pdfDoc.Open();

            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            htmlparser.Parse(sr);

            pdfDoc.Close();

            Response.Flush();
            Response.SuppressContent = true;
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            // Required for GridView export
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ExportGridToPDF();
        }
    }
}