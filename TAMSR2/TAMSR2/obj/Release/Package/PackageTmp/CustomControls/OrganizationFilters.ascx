<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrganizationFilters.ascx.cs" Inherits="TAMSR2.CustomControls.OrganizationFilters" %>



<div id="divOrganizationFilters">
    <form action="#" id="form_Org_Filters" class="form-horizontal">
        <div class="control-group" style='float: left;'>
            <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
            <div class="controls chzn-controls">
                <select id="ddOrgFilterLevel" name="orgFilterLevel" level="0" onchange="LoadLeaves(this)" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="control-group" style=''>
            <label class="control-label"><%=Resources.Resource.scheduleLocation %><span class="required">*</span></label>
            <div class="controls chzn-controls">
                <select id="ddOrgFilterLevel1" name="orgFilterLevel1" level="1" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </form>
    <div style="clear: both;"></div>
</div>

<div id="divOrganizationFilterScripts">
   <script src="../assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js" type="text/javascript"></script>   
    <script type="text/javascript">
        
        $(document).ready(function () {
            LoadOrganizationNodes();
        });

        function LoadOrganizationNodes() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   $("#ddOrgFilterLevel").html(html);
                   $("#ddOrgFilterLevel").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var sch = $.getQueryString('sch') + "";
                   tempOrg = true;
                   if (sch != "" && tempLoc == true) {
                       Edit(sch);
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
        function LoadLeaves() {
            alert("");
            var pID = $(this).val();
            var pLevel = $(this).attr("level");
            alert("parentID=" + pID + " \nlevel=" + pLevel);

        }
        function LoadOrganizationLeaves(parentID, parentLevel) {
            var d = "key=getIdNameListString&parent=" + parentID;
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    var nd = parseInt(parentLevel) + 1;
                   $("#ddOrgFilterLevel" + nd).html(html);
                   $("#ddOrgFilterLevel" + nd).trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var sch = $.getQueryString('sch') + "";
                   tempOrg = true;
                   if (sch != "" && tempLoc == true) {
                       Edit(sch);
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

    </script>
</div>