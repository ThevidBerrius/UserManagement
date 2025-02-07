using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Text;

namespace UserManagement.View
{
    public partial class UserList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kalau user belum login, akan redirect ke login
            if (Session["user"] == null)
            {
                Response.Redirect("~/View/LoginPage.aspx");
            }

            if (!IsPostBack)
            {
                // Set Default Size GridView
                UserListGV.PageSize = 10;
                PageSizeDropdown.SelectedValue = "10";
                BindGridView();
            }
        }

        // Bind Data buat GridView
        private void BindGridView()
        {
            string connString = ConfigurationManager.ConnectionStrings["UserConnString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("GetAllUsers", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    UserListGV.DataSource = dt;
                    UserListGV.DataBind();
                }
            }
        }

        protected void BtnAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/View/AddEditUser.aspx");
        }

        protected void BtnExport_Click(object sender, EventArgs e)
        {
            ReportDocument reportDoc = new ReportDocument();
            string reportPath = Server.MapPath("~/Report/UserListReport.rpt");
            reportDoc.Load(reportPath);
            reportDoc.Refresh(); // Refresh from old data, biar export data terbaru
            
            ExportFormatType exportFormat = ExportFormatType.NoFormat;
            string fileExtension = "";

            // Untuk jenis file yang akan diexport
            switch (ExportDropdown.SelectedValue)
            {
                case "PDF":
                    exportFormat = ExportFormatType.PortableDocFormat;
                    fileExtension = "pdf";
                    break;
                case "XLS":
                    exportFormat = ExportFormatType.Excel;
                    fileExtension = "xls";
                    break;
                case "CSV":
                    exportFormat = ExportFormatType.CharacterSeparatedValues;
                    fileExtension = "csv";
                    break;
                default:
                    return;
            }

            // Penamaan file ketika didownload
            string fileName = "UserListReport_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + "." + fileExtension;

            // export CSV, encode as UTF-8 with BOM (Fix Error Symbol Checklist)
            if (fileExtension == "csv")
            {
                using (MemoryStream stream = (MemoryStream)reportDoc.ExportToStream(exportFormat))
                using (StreamReader reader = new StreamReader(stream, Encoding.UTF8))
                {
                    string csvContent = reader.ReadToEnd();

                    // UTF-8 encoding
                    byte[] utf8Bom = Encoding.UTF8.GetPreamble();
                    byte[] csvBytes = Encoding.UTF8.GetBytes(csvContent);
                    byte[] finalCsv = utf8Bom.Concat(csvBytes).ToArray();

                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "text/csv; charset=utf-8";
                    Response.AddHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
                    Response.BinaryWrite(finalCsv);
                    Response.Flush();
                    Response.End();
                }
            }
            else
            {
                using (MemoryStream stream = (MemoryStream)reportDoc.ExportToStream(exportFormat))
                {
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = GetContentType(fileExtension);
                    Response.AddHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
                    Response.BinaryWrite(stream.ToArray());
                    Response.Flush();
                    Response.End();
                }
            }
        }


        // function buat return MIME type
        private string GetContentType(string extension)
        {
            switch (extension)
            {
                case "pdf": return "application/pdf";
                case "xls": return "application/vnd.ms-excel";
                case "csv": return "text/csv";
                default: return "application/octet-stream"; // Generic Binary file
            }
        }

        // Logout
        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            // Clear Session + Balik ke login page
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/View/LoginPage.aspx");
        }

        // Handler buat pagination
        protected void UserListGV_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (e.NewPageIndex >= 0)
            {
                UserListGV.PageIndex = e.NewPageIndex;
            }
            else
            {
                string commandArg = ((LinkButton)sender).CommandArgument;
                int currentPage = UserListGV.PageIndex;

                if (commandArg == "Next")
                {
                    if (currentPage < UserListGV.PageCount - 1)
                        UserListGV.PageIndex = currentPage + 1;
                }
                else if (commandArg == "Prev")
                {
                    if (currentPage > 0)
                        UserListGV.PageIndex = currentPage - 1;
                }
            }

            BindGridView();
        }

        // Handle buat dropdown data yang mau ditampilkan
        protected void PageSizeDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedPageSize = int.Parse(PageSizeDropdown.SelectedValue);

            UserListGV.PageSize = selectedPageSize;

            BindGridView();
        }

        // Repeater untuk pagination (Penomoran halaman)
        protected void UserListGV_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Pager)
            {
                Repeater rptPages = (Repeater)e.Row.FindControl("rptPages");
                if (rptPages != null)
                {
                    List<int> pages = new List<int>();
                    for (int i = 1; i <= UserListGV.PageCount; i++)
                    {
                        pages.Add(i);
                    }
                    rptPages.DataSource = pages;
                    rptPages.DataBind();
                }
            }
        }

        // Manual page number input buat pagination
        protected void TBoxPageNumber_TextChanged(object sender, EventArgs e)
        {
            GridViewRow pagerRow = UserListGV.BottomPagerRow;
            if (pagerRow != null)
            {
                TextBox TBoxPageNumber = (TextBox)pagerRow.FindControl("TBoxPageNumber");
                if (TBoxPageNumber != null)
                {
                    int pageNumber;
                    if (int.TryParse(TBoxPageNumber.Text.Trim(), out pageNumber))
                    {
                        if (pageNumber > 0 && pageNumber <= UserListGV.PageCount)
                        {
                            UserListGV.PageIndex = pageNumber - 1;
                            BindGridView();
                        }
                        else
                        {
                            TBoxPageNumber.Text = (UserListGV.PageIndex + 1).ToString();
                        }
                    }
                }
            }
        }
    }
}