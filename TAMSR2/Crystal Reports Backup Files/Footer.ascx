<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="TAMSR2.CustomControls.Footer" %>

<!-- BEGIN FOOTER -->
   <div class="footer">
      <div style="text-align: center;">
          <%=Resources.Resource.footerText %>
      </div>
      <div class="span pull-<%= pullDirectionStr %>">
         <span class="go-top"><i class="icon-angle-up"></i></span>
      </div>
   </div>
   <!-- END FOOTER -->
