<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEditUser.aspx.cs" Inherits="UserManagement.View.AddEditUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add/Edit User</title>
    <link rel="stylesheet" type="text/css" href="~/CSS/styles.css" />
</head>
<body>
    <div class="container user-form-container">
        <h2>
            <asp:Label ID="LblTitle" runat="server" Text="Add User"></asp:Label>
        </h2>

        <form id="form1" runat="server">
            <div class="form-group">
                <asp:Label ID="LblUsername" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="TBoxUsername" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblFirstName" runat="server" Text="First Name"></asp:Label>
                <asp:TextBox ID="TBoxFirstName" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblLastName" runat="server" Text="Last Name"></asp:Label>
                <asp:TextBox ID="TBoxLastName" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblActive" runat="server" Text="Active"></asp:Label>
                <asp:CheckBox ID="CBoxActive" runat="server" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblPassword" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="TBoxPassword" runat="server" CssClass="form-control" TextMode="Password" />
            </div>

            <div class="form-group">
                <asp:Label ID="LblConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
                <asp:TextBox ID="TBoxConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
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
