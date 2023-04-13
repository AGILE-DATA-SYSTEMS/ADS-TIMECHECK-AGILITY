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

<script>

     window.appDateFormat = '<%= ConfigurationManager.AppSettings["dateFormat"]%>';
    $(document).ready(function () {
        if (jQuery().datepicker) {
            $('.date-picker').datepicker({ format: window.appDateFormat });
        }
        $('.date-picker').on('change', function () {
            $('.datepicker').hide();
        });

        if (jQuery().timepicker) {

            $('.timepicker-24').val("00:00");
           
            $('.timepicker-24').timepicker({
                minuteStep: 1,
                showSeconds: false,
                showMeridian: false,
                defaultTime:"00:00"
            });
        }
    });

</script>