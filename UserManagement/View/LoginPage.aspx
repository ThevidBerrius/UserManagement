<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="UserManagement.View.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="~/CSS/styles.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container login-container">
            <h1>Login</h1>
            <div class="form-group">
                <asp:Label ID="LblUsername" runat="server" Text="Username" AssociatedControlID="TBoxUsername"></asp:Label>
                <asp:TextBox ID="TBoxUsername" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <asp:Label ID="LblPassword" runat="server" Text="Password" AssociatedControlID="TBoxPassword"></asp:Label>
                <asp:TextBox ID="TBoxPassword" runat="server" CssClass="form-control" TextMode="Password" />
            </div>
            <div class="form-group">
                <asp:Label ID="ErrorLbl" runat="server" CssClass="error"></asp:Label>
            </div>
            <div class="form-group">
                <asp:Button ID="BtnLogin" runat="server" Text="Login" CssClass="btn login-btn" OnClick="BtnLogin_Click" />
            </div>
        </div>
    </form>
</body>
</html>
