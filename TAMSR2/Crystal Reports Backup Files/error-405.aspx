<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="error-405.aspx.cs" Inherits="TAMSR2.ErrorPages.error_405" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
  <title><%=Resources.Resource.error405 %> - <%=Resources.Resource.applicationName %></title>
   <!-- BEGIN PAGE LEVEL STYLES -->
   <link href="../assets/<%= languageStr %>/css/pages/error.css" rel="stylesheet" type="text/css"/>
   <!-- END PAGE LEVEL STYLES -->

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
         <div id="portlet-config" class="modal hide">
            <div class="modal-header">
               <button data-dismiss="modal" class="close" type="button"></button>
               <h3>Widget Settings</h3>
            </div>
            <div class="modal-body">
               <p>Here will be a configuration form</p>
            </div>
         </div>
         <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
         <div class="container-fluid">
            <!-- BEGIN PAGE HEADER-->
            <div class="row-fluid">
               <div class="span12">
                  <!-- BEGIN STYLE CUSTOMIZER -->
                  <div class="color-panel hidden-phone">
                     <div class="color-mode-icons icon-color"></div>
                     <div class="color-mode-icons icon-color-close"></div>
                     <div class="color-mode">
                        <p>THEME COLOR</p>
                        <ul class="inline">
                           <li class="color-black current color-default" data-style="default"></li>
                           <li class="color-blue" data-style="blue"></li>
                           <li class="color-brown" data-style="brown"></li>
                           <li class="color-purple" data-style="purple"></li>
                           <li class="color-white color-light" data-style="light"></li>
                        </ul>
                        <label class="hidden-phone">
                        <input type="checkbox" class="header" checked value="" />
                        <span class="color-mode-label">Fixed Header</span>
                        </label>                   
                     </div>
                  </div>
                  <!-- END BEGIN STYLE CUSTOMIZER -->    
                  <!-- BEGIN PAGE TITLE & BREADCRUMB-->			
			<h3 class="page-title">
									405 Page					<small>405 page sample</small>
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href="../Common/Default.aspx">Home</a> 
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#">Extra</a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#">405 Page</a></li>
						
						
			</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->          
            <div class="row-fluid">
               <div class="span12">
                  <div class="row-fluid page-500">
                     <div class="span5 number">
                        405
                     </div>
                     <div class="span7 details">
                        <h3>Method Not Allowed</h3>
                        <p>
                           You don't have neccessary permissions to this process <br />if you have then contact administrator about this.
                        </p>
                     </div>
                  </div>
               </div>
            </div>
            <!-- END PAGE CONTENT-->
         </div>
         <!-- END PAGE CONTAINER-->    
    
</asp:Content>
