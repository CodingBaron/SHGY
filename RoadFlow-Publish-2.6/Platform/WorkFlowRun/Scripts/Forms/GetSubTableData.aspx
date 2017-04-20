<%@ Page Language="C#" %>
<%
    string secondtable = Request["secondtable"];
    string primarytablefiled = Request["primarytablefiled"];
    string secondtableprimarykey = Request["secondtableprimarykey"];
    string primarytablefiledvalue = Request["primarytablefiledvalue"];
    string secondtablerelationfield=Request["secondtablerelationfield"];
    string dbconnid = Request["dbconnid"];
    string subtableformat = Request["subtableformat"];

    LitJson.JsonData data = new RoadFlow.Platform.WorkFlow().GetSubTableData(dbconnid, secondtable, secondtablerelationfield, primarytablefiledvalue, secondtableprimarykey, subtableformat);

    Response.Write(data.ToJson());
%>