using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace UserManagement.View
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kalau used sudah login sebelumnya dan belum logout, langsung redirect ke UserList.aspx
            if (Session["user"] != null)
            {
                Response.Redirect("~/View/UserList.aspx");
            }
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string username = TBoxUsername.Text;
            string password = TBoxPassword.Text;

            // Validasi TextBox Kosong
            if (string.IsNullOrWhiteSpace(username) ||
                string.IsNullOrWhiteSpace(password))
            {
                ErrorLbl.Text = "Field must not be empty!";
                ErrorLbl.Visible = true;
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["UserConnString"].ConnectionString;

            using (SqlConnection connect = new SqlConnection(connString))
            {
                try
                {
                    // Validasi Input dengan Stored Procedure
                    connect.Open();
                    using (SqlCommand cmd = new SqlCommand("ValidateUser", connect))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);

                        int userCount = (int)cmd.ExecuteScalar();

                        if (userCount > 0)
                        {
                            Session["user"] = username;
                            Response.Redirect("~/View/UserList.aspx");
                        }
                        else
                        {
                            ErrorLbl.Text = "Invalid Credential!";
                        }
                    }
                }
                catch (Exception ex)
                {
                    ErrorLbl.Text = "Error: " + ex.Message; // untuk Debug
                }
            }
        }

    }
}