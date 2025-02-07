using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace UserManagement.View
{
    public partial class AddEditUser : System.Web.UI.Page
    {
        // Jika User belum login akan diarahkan ke login page
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("~/View/LoginPage.aspx");
                return;
            }

            // Kalau ada query string, akan jadi edit user
            if (!IsPostBack)
            {
                if (Request.QueryString["Username"] != null)
                {
                    string username = Request.QueryString["Username"];
                    LoadUserData(username);
                    LblTitle.Text = "Edit User";
                    TBoxUsername.Enabled = false;
                }
                else
                {
                    LblTitle.Text = "Add New User";
                }
            }
        }

        private void LoadUserData(string username)
        {
            // Load User data untuk edit
            string connString = ConfigurationManager.ConnectionStrings["UserConnString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("GetUserByUsername", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Username", username);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        TBoxUsername.Text = reader["Username"].ToString();
                        TBoxFirstName.Text = reader["FirstName"].ToString();
                        TBoxLastName.Text = reader["LastName"].ToString();
                        CBoxActive.Checked = Convert.ToBoolean(reader["Active"]);
                        TBoxPassword.Attributes["value"] = reader["Password"].ToString();
                        TBoxConfirmPassword.Attributes["value"] = reader["Password"].ToString();
                    }
                    conn.Close();
                }
            }
        }


        protected void BtnSave_Click(object sender, EventArgs e)
        {
            // Validasi TextBox kosong
            if (string.IsNullOrWhiteSpace(TBoxUsername.Text) || 
                string.IsNullOrWhiteSpace(TBoxFirstName.Text) ||
                string.IsNullOrWhiteSpace(TBoxLastName.Text) ||
                string.IsNullOrWhiteSpace(TBoxPassword.Text) ||
                string.IsNullOrWhiteSpace(TBoxConfirmPassword.Text))

            {
                LblError.Text = "Field must not be empty!";
                LblError.Visible = true;
                return;
            }

            // Validasi Password Confirmation
            if (TBoxPassword.Text != TBoxConfirmPassword.Text)
            {
                LblError.Text = "Passwords do not match!";
                LblError.Visible = true;
                return;
            }

            // Validasi lagi cek apakah user sudah login, untuk get username user
            string currentUser = Session["user"] as string;
            if (string.IsNullOrEmpty(currentUser))
            {
                Response.Redirect("~/View/LoginPage.aspx");
                return;
            }

            // Update / Insert data ke db
            string connString = ConfigurationManager.ConnectionStrings["UserConnString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("UpdateInsert", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Username", TBoxUsername.Text);
                    cmd.Parameters.AddWithValue("@FirstName", TBoxFirstName.Text);
                    cmd.Parameters.AddWithValue("@LastName", TBoxLastName.Text);
                    cmd.Parameters.AddWithValue("@Active", CBoxActive.Checked);
                    cmd.Parameters.AddWithValue("@LastModifiedBy", currentUser);
                    cmd.Parameters.AddWithValue("@LastModifiedDate", DateTime.Now);

                    if (!string.IsNullOrEmpty(TBoxPassword.Text))
                    {
                        cmd.Parameters.AddWithValue("@Password", TBoxPassword.Text);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@Password", DBNull.Value);
                    }

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            Response.Redirect("~/View/UserList.aspx");
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/View/UserList.aspx");
        }
    }
}