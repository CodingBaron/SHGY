﻿<%@ Page Language="C#"%>
<%
	string FlowID = Request.QueryString["flowid"];
	string StepID = Request.QueryString["stepid"];
	string GroupID = Request.QueryString["groupid"];
	string TaskID = Request.QueryString["taskid"];
	string InstanceID = Request.QueryString["instanceid"];
	string DisplayModel = Request.QueryString["display"] ?? "0";
	string DBConnID = "06075250-30dc-4d32-bf97-e922cb30fac8";
	string DBTable = "TempTest_Purchase";
	string DBTablePK = "ID";
	string DBTableTitle = "Title";
	if(InstanceID.IsNullOrEmpty()){InstanceID = Request.QueryString["instanceid1"];}
	RoadFlow.Platform.Dictionary BDictionary = new RoadFlow.Platform.Dictionary();
	RoadFlow.Platform.WorkFlow BWorkFlow = new RoadFlow.Platform.WorkFlow();
	RoadFlow.Platform.WorkFlowTask BWorkFlowTask = new RoadFlow.Platform.WorkFlowTask();
	string fieldStatus = BWorkFlow.GetFieldStatus(FlowID, StepID);
	LitJson.JsonData initData = BWorkFlow.GetFormData(DBConnID, DBTable, DBTablePK, InstanceID, fieldStatus, "{\"temptest_purchase.sqdatetime\":\"yyyy-MM-dd\"}", TaskID);
	string TaskTitle = BWorkFlow.GetFromFieldData(initData, DBTable, DBTableTitle);
%>
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />
<script src="Scripts/Forms/common.js" type="text/javascript" ></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="2" />
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest_Purchase.Title" />
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8" />
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest_Purchase" />
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID" />
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title" />
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1" />
<script type="text/javascript">
	var initData = <%=BWorkFlow.GetFormDataJsonString(initData)%>;
	var fieldStatus = "1"=="<%=Request.QueryString["isreadonly"]%>"? {} : <%=fieldStatus%>;
	var displayModel = '<%=DisplayModel%>';
	$(window).load(function (){
		formrun.initData(initData, "TempTest_Purchase", fieldStatus, displayModel);
	});
</script>
<p><br/></p><p><br/></p><p style="text-align: center;"><span style="font-size: 20px;"><strong>物资采购申请</strong></span><br/></p><table width="1686" class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled" uetable="null"><tbody><tr class="firstRow"><td width="328" valign="top" style="border-color: rgb(221, 221, 221);">申请人：<br/></td><td width="566" valign="top" style="border-color: rgb(221, 221, 221); -ms-word-break: break-all;"><input name="TempTest_Purchase.UserID" id="TempTest_Purchase.UserID" type="text" value="u_<%=new RoadFlow.Platform.WorkFlowTask().GetFirstSnderID(FlowID.ToGuid(), GroupID.ToGuid(), true)%>" more="0" type1="flow_org" isflow="1" class="mymember" title="" dept="0" station="0" user="1" workgroup="0" unit="0" rootid=""/></td><td width="224" valign="top" style="border-color: rgb(221, 221, 221);">部门：</td><td width="567" valign="top" style="border-color: rgb(221, 221, 221);"><input name="TempTest_Purchase.UserDept" id="TempTest_Purchase.UserDept" type="text" value="<%=new RoadFlow.Platform.WorkFlowTask().GetFirstSnderDeptID(FlowID.ToGuid(), GroupID.ToGuid())%>" more="0" type1="flow_org" isflow="1" class="mymember" title="" dept="1" station="0" user="0" workgroup="0" unit="0" rootid=""/></td></tr><tr><td width="328" valign="top" style="border-color: rgb(221, 221, 221);">申请日期：<br/></td><td width="566" valign="top" style="border-color: rgb(221, 221, 221);"><input name="TempTest_Purchase.SqDateTime" id="TempTest_Purchase.SqDateTime" type="text" value="<%=RoadFlow.Utility.DateTimeNew.ShortDate%>" defaultvalue="%3C%25=RoadFlow.Utility.DateTimeNew.ShortDate%25%3E" type1="flow_datetime" currentmonth="0" dayafter="0" daybefor="0" istime="0" format="yyyy-MM-dd" isflow="1" class="mycalendar" title=""/></td><td width="224" valign="top" style="border-color: rgb(221, 221, 221);">备注：</td><td width="567" valign="top" style="border-color: rgb(221, 221, 221);"><input type="text" id="TempTest_Purchase.Note" type1="flow_text" name="TempTest_Purchase.Note" value="" placeholder="在这里输入备注" align="left" style="width:80%;text-align:left;padding-right:3px;" valuetype="0" isflow="1" class="mytext" title=""/></td></tr><tr><td valign="top" style="border-color: rgb(221, 221, 221); -ms-word-break: break-all;" colspan="4">申请明细：  </td></tr><tr><td valign="top" style="border-color: rgb(221, 221, 221);" colspan="4"><table class="flowformsubtable" style="width:99%;margin:0 auto;" cellpadding="0" cellspacing="1" issubflowtable="1" id="subtable_TempTest_PurchaseList_ID_ID_PurchaseID"><thead><tr><th style="text-align:left;width:20%;padding-right:3px;">名称<input type="hidden" name="flowsubtable_id" value="TempTest_PurchaseList_ID_ID_PurchaseID"/><input type="hidden" name="flowsubtable_TempTest_PurchaseList_ID_ID_PurchaseID_secondtable" value="TempTest_PurchaseList"/><input type="hidden" name="flowsubtable_TempTest_PurchaseList_ID_ID_PurchaseID_primarytablefiled" value="ID"/><input type="hidden" name="flowsubtable_TempTest_PurchaseList_ID_ID_PurchaseID_secondtableprimarykey" value="ID"/><input type="hidden" name="flowsubtable_TempTest_PurchaseList_ID_ID_PurchaseID_secondtablerelationfield" value="PurchaseID"/></th><th style="text-align:left;width:20%;padding-right:3px;">型号</th><th style="text-align:left;width:10%;padding-right:3px;">单位</th><th style="text-align:left;width:10%;padding-right:3px;">单价</th><th style="text-align:left;width:20%;padding-right:3px;">数量</th><th style="text-align:right;width:10%;padding-right:3px;">金额</th><th></th></tr></thead><tbody><tr type1="listtr"><td colname="TempTest_PurchaseList_Name" iscount="0" style="text-align:left;padding-right:3px;"><input type="hidden" name="hidden_guid_TempTest_PurchaseList_ID_ID_PurchaseID" value="df5d57b4bebd9cd51236ed85bc1c653f"/><input type="hidden" name="flowsubid" value="TempTest_PurchaseList_ID_ID_PurchaseID"/><input type="text" class="mytext" issubflow="1" type1="subflow_text" name="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Name" id="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Name" colname="TempTest_PurchaseList_Name" style="width:150px" value="" defaultvalue="" valuetype="0"/><script type="text/javascript"></script></td><td colname="TempTest_PurchaseList_Model" iscount="0" style="text-align:left;padding-right:3px;"><input type="text" class="mytext" issubflow="1" type1="subflow_text" name="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Model" id="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Model" colname="TempTest_PurchaseList_Model" value="" defaultvalue="" valuetype="0"/><script type="text/javascript"></script></td><td colname="TempTest_PurchaseList_Unit" iscount="0" style="text-align:left;padding-right:3px;"><select class="myselect" name="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Unit" id="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Unit" issubflow="1" type1="subflow_select" colname="TempTest_PurchaseList_Unit" style="width:100px"><option value="件">件</option><option value="箱">箱</option><option value="套">套</option></select><script type="text/javascript"></script></td><td colname="TempTest_PurchaseList_Price" iscount="0" style="text-align:left;padding-right:3px;"><input type="text" class="mytext" issubflow="1" type1="subflow_text" name="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Price" id="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Price" colname="TempTest_PurchaseList_Price" value="" defaultvalue="" valuetype="4" onchange="onchange_c4b6bdc607bc44ee41da51ef4dbf3229(this);"/><script type="text/javascript">function onchange_c4b6bdc607bc44ee41da51ef4dbf3229(srcObj){var $tr=$(srcObj).parent().parent();
var quantity=$("[name$='TempTest_PurchaseList_Quantity']",$tr).val();
var price=$("[name$='TempTest_PurchaseList_Price']",$tr).val();
var sum=(parseInt(quantity)*parseFloat(price)).toFixed(2);
if(!isNaN(sum))
{
    $("[name$='TempTest_PurchaseList_Sum1']",$tr).val(sum);
}}</script></td><td colname="TempTest_PurchaseList_Quantity" iscount="0" style="text-align:left;padding-right:3px;"><input type="text" class="mytext" issubflow="1" type1="subflow_text" name="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Quantity" id="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Quantity" colname="TempTest_PurchaseList_Quantity" value="" defaultvalue="" valuetype="3" onchange="onchange_a9679cf15a8d5fb92c92f20be293a084(this);"/><script type="text/javascript">function onchange_a9679cf15a8d5fb92c92f20be293a084(srcObj){var $tr=$(srcObj).parent().parent();
var quantity=$("[name$='TempTest_PurchaseList_Quantity']",$tr).val();
var price=$("[name$='TempTest_PurchaseList_Price']",$tr).val();
var sum=(parseInt(quantity)*parseFloat(price)).toFixed(2);
if(!isNaN(sum))
{
    $("[name$='TempTest_PurchaseList_Sum1']",$tr).val(sum);
}}</script></td><td colname="TempTest_PurchaseList_Sum1" iscount="0" style="text-align:right;padding-right:3px;"><input type="text" class="mytext" issubflow="1" type1="subflow_text" name="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Sum1" id="TempTest_PurchaseList_ID_ID_PurchaseID_df5d57b4bebd9cd51236ed85bc1c653f_TempTest_PurchaseList_Sum1" colname="TempTest_PurchaseList_Sum1" value="" defaultvalue="" valuetype="0"/><script type="text/javascript"></script></td><td><input type="button" class="mybutton" style="margin-right:4px;" value="增加" onclick="formrun.subtableNewRow(this);"/><input type="button" class="mybutton" value="删除" onclick="formrun.subtableDeleteRow(this);"/></td></tr></tbody></table></td></tr><tr><td valign="top" style="border-top-color: rgb(221, 221, 221); border-left-color: rgb(221, 221, 221);" rowspan="1" colspan="4"><br/></td></tr></tbody></table><p><br/></p>