﻿<%@ Page Language="C#"%>
<%
	string FlowID = Request.QueryString["flowid"];
	string StepID = Request.QueryString["stepid"];
	string GroupID = Request.QueryString["groupid"];
	string TaskID = Request.QueryString["taskid"];
	string InstanceID = Request.QueryString["instanceid"];
	string DisplayModel = Request.QueryString["display"] ?? "0";
	string DBConnID = "06075250-30dc-4d32-bf97-e922cb30fac8";
	string DBTable = "TempTest_Vote";
	string DBTablePK = "ID";
	string DBTableTitle = "title";
	if(InstanceID.IsNullOrEmpty()){InstanceID = Request.QueryString["instanceid1"];}
	RoadFlow.Platform.Dictionary BDictionary = new RoadFlow.Platform.Dictionary();
	RoadFlow.Platform.WorkFlow BWorkFlow = new RoadFlow.Platform.WorkFlow();
	RoadFlow.Platform.WorkFlowTask BWorkFlowTask = new RoadFlow.Platform.WorkFlowTask();
	string fieldStatus = BWorkFlow.GetFieldStatus(FlowID, StepID);
	LitJson.JsonData initData = BWorkFlow.GetFormData(DBConnID, DBTable, DBTablePK, InstanceID, fieldStatus, "{}");
	string TaskTitle = BWorkFlow.GetFromFieldData(initData, DBTable, DBTableTitle);
%>
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />
<script src="Scripts/Forms/common.js" type="text/javascript" ></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1" />
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest_Vote.title" />
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8" />
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest_Vote" />
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID" />
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="title" />
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1" />
<script type="text/javascript">
	var initData = <%=BWorkFlow.GetFormDataJsonString(initData)%>;
	var fieldStatus = "1"=="<%=Request.QueryString["isreadonly"]%>"? {} : <%=fieldStatus%>;
	var displayModel = '<%=DisplayModel%>';
	$(window).load(function (){
		formrun.initData(initData, "TempTest_Vote", fieldStatus, displayModel);
	});
</script>
<p><br/></p><p style="text-align: center;"><br/><span style="font-size: 22px;"><strong>问卷调查统计</strong></span><br/></p><p><span style="font-size: 22px;"><strong><br/></strong></span></p><p><span style="font-size: 22px;"></span></p><table class="flowformtable" cellpadding="0" cellspacing="1"><tbody><tr class="firstRow"><td width="162" valign="top" style="word-break: break-all;">提交明细数据</td><td width="918" valign="top"><div style="margin:0 auto;"><%=new RoadFlow.Platform.WorkFlowForm().GetFormGridHtml(DBConnID, "0","0","select username 姓名,case votevalue when '0' then '别人介绍' when '1' then '搜索引擎' when '2' then '广告' end as 类别 from temptest_vote where instanceid=$querystring[instanceid]$".FilterWildcard())%></div></td></tr><tr><td valign="top" colspan="1" rowspan="1" style="word-break: break-all;" width="162">统计数据</td><td valign="top" colspan="1" rowspan="1" width="69"><div style="margin:0 auto;"><%=new RoadFlow.Platform.WorkFlowForm().GetFormGridHtml(DBConnID, "0","0","select case votevalue when '0' then '别人介绍' when '1' then '搜索引擎' when '2' then '广告' end as 类别,COUNT(*) 票数 from TempTest_Vote where instanceid=3 group by votevalue".FilterWildcard())%></div></td></tr></tbody></table><p><span style="font-size: 22px;"></span><br/></p>