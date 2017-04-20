﻿<%@ Page Language="C#"%>
<%
	string FlowID = Request.QueryString["flowid"];
	string StepID = Request.QueryString["stepid"];
	string GroupID = Request.QueryString["groupid"];
	string TaskID = Request.QueryString["taskid"];
	string InstanceID = Request.QueryString["instanceid"];
	string DisplayModel = Request.QueryString["display"] ?? "0";
	string DBConnID = "06075250-30dc-4d32-bf97-e922cb30fac8";
	string DBTable = "TempTest_CustomForm";
	string DBTablePK = "ID";
	string DBTableTitle = "Title";
	if(InstanceID.IsNullOrEmpty()){InstanceID = Request.QueryString["instanceid1"];}
	RoadFlow.Platform.Dictionary BDictionary = new RoadFlow.Platform.Dictionary();
	RoadFlow.Platform.WorkFlow BWorkFlow = new RoadFlow.Platform.WorkFlow();
	RoadFlow.Platform.WorkFlowTask BWorkFlowTask = new RoadFlow.Platform.WorkFlowTask();
	string fieldStatus = BWorkFlow.GetFieldStatus(FlowID, StepID);
	LitJson.JsonData initData = BWorkFlow.GetFormData(DBConnID, DBTable, DBTablePK, InstanceID, fieldStatus, "{}", TaskID);
	string TaskTitle = BWorkFlow.GetFromFieldData(initData, DBTable, DBTableTitle);
%>
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />
<script src="Scripts/Forms/common.js" type="text/javascript" ></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1" />
<input type="hidden" id="TempTest_CustomForm.Title" name="TempTest_CustomForm.Title" value="<%=TaskTitle.IsNullOrEmpty() ? BWorkFlow.GetAutoTaskTitle(FlowID, StepID, Request.QueryString["groupid"]) : TaskTitle %>" />
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest_CustomForm.Title" />
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8" />
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest_CustomForm" />
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID" />
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title" />
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1" />
<script type="text/javascript">
	var initData = <%=BWorkFlow.GetFormDataJsonString(initData)%>;
	var fieldStatus = "1"=="<%=Request.QueryString["isreadonly"]%>"? {} : <%=fieldStatus%>;
	var displayModel = '<%=DisplayModel%>';
	$(window).load(function (){
		formrun.initData(initData, "TempTest_CustomForm", fieldStatus, displayModel);
	});
</script>
<p><br/></p><p> </p><table class="flowformtable" data-sort="sortDisabled" width="1686" cellspacing="1" cellpadding="0"><tbody><tr class="firstRow"><td style="border-color: rgb(221, 221, 221); word-break: break-all;" rowspan="1" colspan="1" valign="top" width="209">计算字段：</td><td style="border-color: rgb(221, 221, 221); word-break: break-all;" rowspan="1" colspan="1" valign="top" width="1476">长：<input name="TempTest_CustomForm.f1" title="" class="mytext" id="TempTest_CustomForm.f1" onchange="sum_TempTest_CustomForm_FlowCompleted();" value="" isflow="1" valuetype="2" type1="flow_text" type="text"/> 宽：<input name="TempTest_CustomForm.f2" title="" class="mytext" id="TempTest_CustomForm.f2" onchange="sum_TempTest_CustomForm_FlowCompleted();" value="" isflow="1" valuetype="2" type1="flow_text" type="text"/> 高：<input name="TempTest_CustomForm.f3" title="" class="mytext" id="TempTest_CustomForm.f3" onchange="sum_TempTest_CustomForm_FlowCompleted();" value="" isflow="1" valuetype="2" type1="flow_text" type="text"/> 面积：<input name="TempTest_CustomForm.FlowCompleted" title="" class="mytext" id="TempTest_CustomForm.FlowCompleted" readonly="readonly" value="" isflow="1" valuetype="2" type1="flow_text" isreadonly="1" type="text"/><script type="text/javascript">function sum_TempTest_CustomForm_FlowCompleted(){$("#TempTest_CustomForm\\.FlowCompleted").val(parseFloat(eval(parseFloat($("#TempTest_CustomForm\\.f1").val()||"0")*parseFloat($("#TempTest_CustomForm\\.f2").val()||"0")*parseFloat($("#TempTest_CustomForm\\.f3").val()||"0")) || "0"));$("#TempTest_CustomForm\\.FlowCompleted").change();}</script> </td></tr><tr><td style="border-color: rgb(221, 221, 221);" rowspan="1" colspan="1" valign="top" width="209">联动：</td><td style="border-color: rgb(221, 221, 221);" rowspan="1" colspan="1" valign="top" width="1476"><select class="myselect" id="TempTest_CustomForm.f15" name="TempTest_CustomForm.f15" isflow="1" type1="flow_select" linkagefield="TempTest_CustomForm.f16" linkagesource="dict" linkagesourcetext="" linkagesourceconn="7fa91179-1363-4e4e-bc1a-bf5c080baafd" onchange="RoadUI.Core.loadOptions(this);"><%=BDictionary.GetOptionsByID("fcc809ed-7e79-44a1-8688-47b4ed462bcb".ToGuid(), RoadFlow.Platform.Dictionary.OptionValueField.ID, "", false)%></select> <select class="myselect" id="TempTest_CustomForm.f16" name="TempTest_CustomForm.f16" isflow="1" type1="flow_select" linkagefield="TempTest_CustomForm.f17" linkagesource="sql" linkagesourcetext="select id,title from Dictionary where parentid='$queryform&value&$'" linkagesourceconn="06075250-30dc-4d32-bf97-e922cb30fac8" onchange="RoadUI.Core.loadOptions(this);"><%=BDictionary.GetOptionsByID("".ToGuid(), RoadFlow.Platform.Dictionary.OptionValueField.ID, "", false)%></select> <select class="myselect" id="TempTest_CustomForm.f17" name="TempTest_CustomForm.f17" isflow="1" type1="flow_select"><%=BDictionary.GetOptionsByID("".ToGuid(), RoadFlow.Platform.Dictionary.OptionValueField.ID, "", false)%></select></td></tr><tr><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="209">签章：</td><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="1476"><input name="TempTest_CustomForm.Contents_text" class="mybutton" id="TempTest_CustomForm.Contents_text" onclick="signature('TempTest_CustomForm.Contents_text',false);" src="<%=string.Concat("/Files/UserSigns/", RoadFlow.Platform.Users.CurrentUserID, ".gif")%>" value=" 签 章 " isflow="1" type1="flow_signature" ispassword="1" id1="TempTest_CustomForm.Contents" type="button"/></td></tr><tr><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="209">弹出选择：</td><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="1476"><input type="text" id="TempTest_CustomForm.f8" type1="flow_selectdiv" name="TempTest_CustomForm.f8" value="" appid="daa2be3e-2af8-4787-8a44-8293bd861893" titlefield="name" pkfield="id" paramsvalue="$(%22#TempTest_CustomForm%5C%5C.f10%22).val()" paramsname="xxx" isflow="1" class="myselectdiv" title=""/></td></tr><tr><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="209">流水号：</td><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="1476"><input type="text" type1="flow_serialnumber" id="TempTest_CustomForm.f4" name="TempTest_CustomForm.f4" value="" style="width: 200px; background-color: rgb(232, 232, 232);" placeholder="自动生成流水号" sqlwhere="year(wdate)=year(getdate())" length="5" isflow="1" class="mytext" title="" readonly=""/><input type="hidden" value="TempTest_CustomForm.f4" name="HasSerialNumber"/><input type="hidden" value="{'formatstring':'ROAD$date&yyyyMMddHHmmssfff&$','sqlwhere':'year(wdate)=year(getdate())','length':'5'}" name="HasSerialNumberConfig_TempTest_CustomForm.f4"/> <input type="hidden" value="TempTest_CustomForm.f4" name="HasSerialNumber"/><input type="hidden" value="{'formatstring':'undefined','sqlwhere':'year(wdate)=year(getdate())','length':'5'}" name="HasSerialNumberConfig_TempTest_CustomForm.f4"/><input type="hidden" value="TempTest_CustomForm.f4" name="HasSerialNumber"/><input type="hidden" value="{'formatstring':'undefined','sqlwhere':'year(wdate)=year(getdate())','length':'5'}" name="HasSerialNumberConfig_TempTest_CustomForm.f4"/><input type="hidden" value="TempTest_CustomForm.f4" name="HasSerialNumber"/><input type="hidden" value="{'formatstring':'undefined','sqlwhere':'year(wdate)=year(getdate())','length':'5'}" name="HasSerialNumberConfig_TempTest_CustomForm.f4"/><input type="hidden" value="TempTest_CustomForm.f4" name="HasSerialNumber"/><input type="hidden" value="{'formatstring':'undefined','sqlwhere':'year(wdate)=year(getdate())','length':'5'}" name="HasSerialNumberConfig_TempTest_CustomForm.f4"/><input type="hidden" value="TempTest_CustomForm.f4" name="HasSerialNumber"/><input type="hidden" value="{'formatstring':'undefined','sqlwhere':'year(wdate)=year(getdate())','length':'5'}" name="HasSerialNumberConfig_TempTest_CustomForm.f4"/></td></tr><tr><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="209">测试提示文字:</td><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="1476"><textarea isflow="1" type1="flow_textarea" id="TempTest_CustomForm.f22" name="TempTest_CustomForm.f22" class="mytext" style="width:99%;height:100px" placeholder="在这里输入您的信息"></textarea></td></tr><tr><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="209">按钮：</td><td rowspan="1" colspan="1" valign="top" style="border-color: rgb(221, 221, 221);" width="1476"><input type="button" class="mybutton" type1="flow_button" isflow="1" value="Test" id="TempTest_CustomForm.f10" name="TempTest_CustomForm.f10" style="width:100px" onclick="onclick_4a91a827cc7fc0fce2e35803fbe4837e (this);"/><script type="text/javascript">function onclick_4a91a827cc7fc0fce2e35803fbe4837e(srcObj){alert('test');}</script></td></tr><tr><td rowspan="1" colspan="1" valign="top" style="border-left-color: rgb(221, 221, 221); border-top-color: rgb(221, 221, 221);"><br/></td><td rowspan="1" colspan="1" valign="top" style="border-left-color: rgb(221, 221, 221); border-top-color: rgb(221, 221, 221);"><br/></td></tr><tr><td rowspan="1" colspan="2" valign="top" style="border-color: rgb(221, 221, 221);"><br/></td></tr></tbody></table><p><br/></p>