<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebForm.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>RoadFlow工作流平台-登录</title>
    <meta name="viewport" content="width=device-width" />
    <meta name="description" content="主要产品包括.NET开源工作流引擎(RoadFlow),.NET快速开发平台,OA办公自动化系统" />
    <meta name="keywords" content=".NET开源工作流引擎,.NET快速开发平台,RoadFlow,OA办公自动化系统" />

</head>
<body style="background:#f3f7f9; overflow:hidden;">
    <form id="form1" runat="server">
    <div id="bgdiv" class="loginbgdiv"></div>
    <div id="logindiv" style="display:none; margin-top:8px;">
        <input type="hidden" id="Force" name="Force" value="0" />
        <input type="hidden" id="AntiForgeryTokenHidden" value=""  runat="server" />
        <table cellpadding="0" cellspacing="1" border="0" style="width:95%; margin:0 auto;">
            <tr>
                <td style="width:70px; height:45px; text-align:right;">帐号：</td>
                <td><input type="text" class="mytext" id="Account" name="Account" value="" maxlength="50" style="width:170px;" /></td>
            </tr>
            <tr>
                <td style="height:45px; text-align:right;">密码：</td>
                <td><input type="password" class="mytext" id="Password" name="Password" maxlength="50" style="width:170px;" /></td>
            </tr>
            <tr id="novcode" style="display:none;">
                <td style="height:45px; text-align:right;">验证码：</td>
                <td><input type="text" class="mytext" id="VCode" name="VCode" maxlength="4" style="width:80px;" />
                    <img alt="" src="VCode.ashx?<%=DateTime.Now.Ticks %>" onclick="cngimg();" style="vertical-align:middle;" id="VcodeImg" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <input type="submit" value="&nbsp;&nbsp;登&nbsp;&nbsp;录&nbsp;&nbsp;" id="loginbutton" name="loginbutton" onclick="return checkForm();" class="mybutton" />
                </td>
            </tr>
            <%if("1"!=Request.QueryString["session"]){%>
            <tr>
                <td>&nbsp;</td>
                <td style="text-align:left; vertical-align:bottom; height:23px;"><span style="color:blue; margin-right:10px;">用户名:xhb 密码:111</span><a href="http://www.cqroad.cn" target="_blank" ><span style="color:blue;">官网:cqroad.cn</span></a></td>
            </tr>
            <%} %>
        </table>
    </div>
    </form>

    <script type="text/javascript">
        var win = new RoadUI.Window();
        $(function ()
        {
            var left = $(window).width() - 500;
            var top = $(window).height() - 280;
            win.open({ elementid: "logindiv", width: 300, height: 200, top: top, left: left, showico: false, title: "用户登录", resize: false, ismodal: false, showclose: false });
        });
    
        var isVcode = '1' == '<%=Session[RoadFlow.Utility.Keys.SessionKeys.IsValidateCode.ToString()]%>';
        var isSessionLost = "1" == '<%=Request.QueryString["session"]%>';

        $(window).load(function ()
        {
            if (isVcode)
            {
                if (!isSessionLost)
                {
                    top.win.resize(300, 250);
                }
                $("#novcode").show();
            }
           <%=Script%>
        });
        function checkForm()
        {
            var form1 = document.forms[0];
            if ($.trim($("#Account").val()).length == 0)
            {
                alert("帐号不能为空!");
                $("#Account").focus();
                return false;
            }
            if ($.trim($("#Password").val()).length == 0)
            {
                alert("密码不能为空!");
                $("#Password").focus();
                return false;
            }
            if (isVcode && form1.VCode && $.trim($("#VCode").val()).length == 0)
            {
                alert("验证码不能为空!");
                $("#VCode").focus();
                return false;
            }
            return true;
        }
        function cngimg()
        {
            $('#VcodeImg').attr('src', 'VCode.ashx?' + new Date().toString());
        }
    </script>
</body>
</html>
