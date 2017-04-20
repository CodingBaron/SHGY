﻿<%@ Page Language="C#" %>
<%
    WebForm.Common.Tools.CheckLogin();
    string typeid = Request.QueryString["typeid"];
    if(!typeid.IsGuid())
    {
        Response.Write("");
        Response.End();
    }
    string typeids = "";
    if (typeid.IsGuid())
    {
        typeids = new RoadFlow.Platform.Dictionary().GetAllChildsIDString(typeid.ToGuid());
    }
    string query = "";
    string pager;
    RoadFlow.Platform.WorkFlowForm workFlowFrom = new RoadFlow.Platform.WorkFlowForm();
    var forms = workFlowFrom.GetPagerData(out pager, query, "", typeids, "", 1000000); 
    System.Text.StringBuilder html = new System.Text.StringBuilder();
    foreach(var form in forms.OrderBy(p=>p.Name))
    {
        html.Append("<tr>");
        html.AppendFormat("<td style='background:#ffffff;'>{0}</td>",form.Name);
        html.AppendFormat("<td style='background:#ffffff;'>{0}</td>", form.CreateTime.ToDateTimeStringS());
        html.AppendFormat("<td style='background:#ffffff;'>{0}</td>", form.CreateUserName);
        html.AppendFormat("<td style='background:#ffffff;'>{0}</td>", workFlowFrom.GetStatusTitle(form.Status));
        html.AppendFormat("<td style='background:#ffffff;'>{0}</td>", string.Format(@"<a href=""javascript:void(0);"" onclick=""openform('{0}');return false;"">
                    <img src=""{1}/Images/ico/folder_classic_opened.png"" alt="""" style=""vertical-align:middle; border:0;"" />
                    <span style=""vertical-align:middle;"">打开</span>
                    </a>
                    <a href=""javascript:void(0);"" onclick=""delform('{0}');return false;"">
                    <img src=""{1}/Images/ico/cancel.gif"" alt="""" style=""vertical-align:middle; border:0; margin-left:5px;"" />
                    <span style=""vertical-align:middle;"">删除</span>
                    </a>", form.ID, WebForm.Common.Tools.BaseUrl));
        html.Append("</tr>");
    }
    Response.Write(html.ToString());
    Response.End();
%>