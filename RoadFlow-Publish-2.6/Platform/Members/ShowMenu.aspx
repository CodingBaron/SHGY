<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowMenu.aspx.cs" Inherits="WebForm.Platform.Members.ShowMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<%
    string id = Request.QueryString["id"];    
%>
<body>
    <form id="form1">
        <div class="toolbar" style="margin-top:0; border-top:none 0; position:fixed; top:0; left:0; right:0; margin-left:auto; z-index:999; width:100%; margin-right:auto; height:30px;">
            
            <div style="padding-top:5px;">查看<%=new RoadFlow.Platform.Users().GetName(id.ToGuid()) %>的已分配菜单</div>
        </div>
        <div style="padding:40px 1px 1px 4px; overflow:auto;">
            <div id="treeDiv" style="margin:0; overflow:auto;"></div>
        </div>
    </form>

    <script type="text/javascript">
        $(function ()
        {
            initMenu();
        });
        function initMenu()
        {
            mainTree = new RoadUI.Tree({
                id: "treeDiv", path: "/Platform/Home/Menu.ashx?showsource=1&userid=<%=id%>",
                refreshpath: "/Platform/Home/MenuRefresh.ashx?showsource=1&userid=<%=id%>",
                showroot: false, showline: true, onclick: null
            });
        }
    </script>
</body>
</html>
