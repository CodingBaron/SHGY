﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tree.aspx.cs" Inherits="WebForm.Applications.Documents.Tree" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="tree"></div>
    </form>
    <script type="text/javascript">
        var appID = '<%=Request.QueryString["appid"]%>';
        var tabID = '<%=Request.QueryString["tabid"]%>';
        var roadTree = null;
        $(function ()
        {
            roadTree = new RoadUI.Tree({ id: "tree", path: "Tree1.ashx", refreshpath: "TreeRefresh.ashx", onclick: openUrl });
        });
        function openUrl(json)
        {
            parent.frames[1].location = "List.aspx?dirid=" + json.id + "&appid=" + appID + "&tabid=" + tabID;
        }
        function reLoad(id)
        {
            roadTree.refresh(id);
        }
    </script>
</body>
</html>
