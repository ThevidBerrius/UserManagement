<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="UserManagement.View.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
        <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 400px;
            background-color: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-size: 14px;
            color: #555;
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border-radius: 4px;
            border: 1px solid #ddd;
            box-sizing: border-box;
        }
        .error {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
        .btn {
            width: 100%;
            background-color: green;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-align: center;
        }
        .btn:hover {
            background-color: darkgreen;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
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
                <asp:Button ID="BtnLogin" runat="server" Text="Login" CssClass="btn" OnClick="BtnLogin_Click"/>
            </div>
        </div>
    </form>
</body>
</html>
