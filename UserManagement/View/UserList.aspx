<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="UserManagement.View.UserList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User List</title>
    <link rel="stylesheet" type="text/css" href="~/CSS/styles.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container user-list-container">
            <asp:Button ID="BtnAddNew" runat="server" Text="Add New Login" CssClass="btn btn-save" OnClick="BtnAddNew_Click" />

            <asp:DropDownList ID="ExportDropdown" runat="server" CssClass="export-dropdown">
                <asp:ListItem Text="Export to PDF" Value="PDF" />
                <asp:ListItem Text="Export to XLS" Value="XLS" />
                <asp:ListItem Text="Export to CSV" Value="CSV" />
            </asp:DropDownList>
            <asp:Button ID="BtnExport" runat="server" Text="Export" CssClass="btn btn-save" OnClick="BtnExport_Click" />
            <asp:Button ID="BtnLogout" runat="server" Text="Logout" CssClass="btn btn-cancel" OnClick="BtnLogout_Click" />

            <asp:GridView ID="UserListGV" runat="server" CssClass="gridview" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="UserListGV_PageIndexChanging" OnRowCreated="UserListGV_RowCreated">
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
                    <asp:TemplateField HeaderText="Active">
                        <ItemTemplate>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" Enabled="false" Checked='<%# Convert.ToBoolean(Eval("Active")) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="LastModifiedBy" HeaderText="Last Modified By" />
                    <asp:BoundField DataField="LastModifiedDate" HeaderText="Last Modified Date" />
                </Columns>

                <PagerStyle CssClass="gridview-pager" />
                <PagerTemplate>
                    <div class="pager-container">
                        <asp:LinkButton ID="lnkPrev" runat="server" CommandName="Page" CommandArgument="Prev"
                            Text="Previous" Enabled='<%# UserListGV.PageIndex > 0 %>' CssClass="pager-button" />

                        <asp:TextBox ID="TBoxPageNumber" runat="server" CssClass="pager-input"
                            Text='<%# UserListGV.PageIndex + 1 %>' AutoPostBack="true"
                            OnTextChanged="TBoxPageNumber_TextChanged"></asp:TextBox>
                        <span>of <%# UserListGV.PageCount %></span>

                        <asp:LinkButton ID="lnkNext" runat="server" CommandName="Page" CommandArgument="Next"
                            Text="Next" Enabled='<%# UserListGV.PageIndex < UserListGV.PageCount - 1 %>' CssClass="pager-button" />
                    </div>
                </PagerTemplate>
            </asp:GridView>

            <div class="page-size-dropdown">
                <label for="PageSizeDropdown">Data per page:</label>
                <asp:DropDownList ID="PageSizeDropdown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageSizeDropdown_SelectedIndexChanged">
                    <asp:ListItem Text="5" Value="5" />
                    <asp:ListItem Text="10" Value="10" />
                    <asp:ListItem Text="15" Value="15" />
                    <asp:ListItem Text="20" Value="20" />
                </asp:DropDownList>
            </div>
        </div>
    </form>
</body>
</html>
