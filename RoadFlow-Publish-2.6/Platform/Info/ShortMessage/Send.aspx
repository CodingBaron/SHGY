<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Send.aspx.cs" Inherits="WebForm.Platform.Info.ShortMessage.Send" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <br />
    <table cellpadding="0" cellspacing="1" border="0" width="90%" class="formtable">
        <tr>
            <th style="width: 80px;">标题：</th>
            <td><input type="text" id="Title1" name="Title1" class="mytext" runat="server" validate="empty" style="width: 85%"/></td>
        </tr>
        <tr>
            <th style="width: 80px;">内容：</th>
            <td><textarea id="Contents" name="Contents" class="mytextarea" validate="empty" style="width: 85%; height:70px;" runat="server"></textarea></td>
        </tr>
        <tr>
            <th style="width: 80px;">接收人：</th>
            <td><input type="text" id="ReceiveUserID" name="ReceiveUserID" class="mymember" runat="server" validate="empty" /></td>
        </tr>
    </table>
    <div class="buttondiv">
        <asp:Button ID="Button1" runat="server" Text="确定发送" OnClientClick="return new RoadUI.Validate().validateForm(document.forms[0]);" CssClass="mybutton" OnClick="Button1_Click" />

    </div>
    </form>
</body>
</html>
