<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="UserManagement.View.UserList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        .container {
            width: 90%;
            margin: auto;
        }

        .btn {
            background-color: green;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
        }

        .export-dropdown {
            margin-left: 10px;
        }

        .gridview {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

            .gridview th, .gridview td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }

            .gridview th {
                background-color: #f2f2f2;
            }

        .edit-link {
            color: blue;
            text-decoration: underline;
            cursor: pointer;
        }

        .page-size-dropdown {
            margin-top: 20px;
        }
    </style>

</head>
<body>
 <form id="form1" runat="server">
        <div class="container">
            <asp:Button ID="BtnAddNew" runat="server" Text="Add New Login" CssClass="btn" OnClick="BtnAddNew_Click" />

            <asp:DropDownList ID="ExportDropdown" runat="server" CssClass="export-dropdown">
                <asp:ListItem Text="Export to PDF" Value="PDF" />
                <asp:ListItem Text="Export to XLS" Value="XLS" />
                <asp:ListItem Text="Export to CSV" Value="CSV" />
            </asp:DropDownList>
            <asp:Button ID="BtnExport" runat="server" Text="Export" CssClass="btn" OnClick="BtnExport_Click" />
            <asp:Button ID="BtnLogout" runat="server" Text="Logout" CssClass="btn" OnClick="BtnLogout_Click" />

            <asp:GridView ID="UserListGV" runat="server" CssClass="gridview" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="UserListGV_PageIndexChanging">
                <Columns>
                    <asp:TemplateField HeaderText="Edit">
                        <ItemTemplate>
                            <asp:HyperLink ID="EditLink" runat="server" CssClass="edit-link"
                                NavigateUrl='<%# "AddEditUser.aspx?Username=" + Eval("Username") %>'>Edit</asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                    <asp:BoundField DataField="Active" HeaderText="Active" />
                    <asp:BoundField DataField="LastModifiedBy" HeaderText="Last Modified By" />
                    <asp:BoundField DataField="LastModifiedDate" HeaderText="Last Modified Date" />
                </Columns>
            </asp:GridView>

            <div class="page-size-dropdown">
                <label for="PageSizeDropdown">Records per page:</label>
                <asp:DropDownList ID="PageSizeDropdown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageSizeDropdown_SelectedIndexChanged">
                    <asp:ListItem Text="5" Value="5" />
                    <asp:ListItem Text="10" Value="10" />
                    <asp:ListItem Text="15" Value="15" />
                    <asp:ListItem Text="20" Value="20" />
                </asp:DropDownList>
            </div>
        </div>
    </form></body>
</html>
