<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEditUser.aspx.cs" Inherits="UserManagement.View.AddEditUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add/Edit User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        .container {
            width: 400px;
            margin: auto;
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

            .form-group label {
                display: block;
                font-weight: bold;
            }

            .form-group input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

        .btn {
            padding: 10px 15px;
            border: none;
            color: white;
            cursor: pointer;
        }

        .btn-save {
            background-color: green;
        }

        .btn-cancel {
            background-color: red;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>
            <asp:Label ID="LblTitle" runat="server" Text="Add User"></asp:Label>
        </h2>

        <form id="form1" runat="server">
            <div class="form-group">
                <asp:Label ID="LblUsername" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="TBoxUsername" runat="server" CssClass="form-control" required="true" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblFirstName" runat="server" Text="First Name"></asp:Label>
                <asp:TextBox ID="TBoxFirstName" runat="server" CssClass="form-control" required="true" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblLastName" runat="server" Text="Last Name"></asp:Label>
                <asp:TextBox ID="TBoxLastName" runat="server" CssClass="form-control" required="true" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblPassword" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="TBoxPassword" runat="server" CssClass="form-control" TextMode="Password" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
                <asp:TextBox ID="TBoxConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblActive" runat="server" Text="Active"></asp:Label>
                <asp:CheckBox ID="CBoxActive" runat="server" />
            </div>

            <div>
                <asp:Label ID="LblError" runat="server" ForeColor="Red" Visible="false" />
            </div>

            <div>
                <asp:Button ID="BtnSave" runat="server" Text="Save" CssClass="btn btn-save" OnClick="BtnSave_Click" />
                <asp:Button ID="BtnCancel" runat="server" Text="Cancel" CssClass="btn btn-cancel" CausesValidation="false" OnClick="BtnCancel_Click" />
            </div>
        </form>
    </div>
</body>
</html>
