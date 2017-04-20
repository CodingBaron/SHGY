<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="WebForm.Test" %>

<html>
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
    <title></title>
    <link href="Scripts/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="Scripts/font-awesome/css/font-awesome-ie7.min.css" rel="stylesheet" />

    <script src="/Scripts/jquery.signalR-1.0.0.js"></script>
    <script src="/signalr/hubs"></script>

    <script type="text/javascript">
        $(function ()
        {
            var proxy = $.connection.signalRHub;
            $("#button1").click(function ()
            {
                proxy.server.sendMessage($("#text1").val(),"");
            });
            $.connection.hub.start();
        });
    </script>

</head>
<body style="padding-left:30px;">
    <form id="form1" runat="server">
        <br />
        <a href="RoadFlowOfficeClient:http://localhost:81/Files/UploadFiles/test.docx">Word</a>
        <br />
        <a href="RoadFlowOfficeClient:http://localhost:81/Files/UploadFiles/test.xlsx">Excel</a>
        <br />
        <a href="RoadFlowOfficeClient:http://localhost:81/Files/UploadFiles/test.pptx">PPT</a>
    </form>
    <br /><br /><br />
    <div>
        <a href="#" style="color:red;">
            <i class="fa fa-binoculars"></i> fa-camera-retro
        </a>
        
    </div>

    <input id="text1" type="text" />
    <input id="button1" type="button" value="Send" />
</body>
</html>
