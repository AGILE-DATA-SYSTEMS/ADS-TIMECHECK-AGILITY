/*
 * A jQuery plugin which generates a basic .xls file with bold headers from a HTML table.
 *
 * Original code by Shreedhar Bhat from this StackOverflow answer: https://stackoverflow.com/a/44255259,
 * with some small modifications by Carlo Pantaleo.
 *
 * Usage: let your HTML table be like:
 * <table id="myTable">
 *     <thead>
 *         ...
 *     </thead>
 *     <tbody>
 *         ...
 *     </tbody>
 * </table>
 *
 * Call:
 * $('#myTable').tableExport({
 *      filename: 'myExport.xls'
 * });
 *
 * to generate and download the Excel file 'myExport.xls'
 *
 *
 * Authors: Carlo Pantaleo, Shreedhar Bhat
 */

(function ($) {
    $.fn.extend({
        tableExport: function (options) {
            var defaults = {
                type: 'excel',
                ignoreColumn: [],
                filename: 'Export.xlsx',
                escape: 'true',
                htmlContent: 'false',
                consoleLog: 'false'
            };
            $.extend(defaults, options);

            var el = this;

            if (defaults.type === 'excel') {
                var ReportHeading = "Transactional Report(" + ($('#cbShowDetail').prop('checked') == true ? "Detail" : "Summary") + ")";
                var excel = "<table>";
                // Header
                var NoOfColumns = $('#sample_1 thead th').length;

                excel += "<tr>";
                excel += "<td colspan='" + NoOfColumns + "' style='text-align:center;font-size:24px;font-weight:bold;'>" + ReportHeading + "<td>";
                //$('.page-content #form_1').find('select').each(function (i, key) {
                var ddlText = "";
                for (var i = 1; i <= $('.page-content #form_1').find('select').length; i++) {
                    if ($('.page-content #form_1').find('select[order=' + i + ']').attr('hide') == '1')
                        continue;
                    //if (i == 4)
                    //    excel += "</tr><tr>";

                    ddlText = $('.page-content #form_1').find('select[order=' + i + ']').find('option:selected').val() == "" ? "" : $('.page-content #form_1').find('select[order=' + i + ']').find('option:selected').text();
                    excel += "<tr>";
                    excel += "<td style='font-weight:bold;'> " + $('.page-content #form_1').find('select[order=' + i + ']').parents('.control-group').find('label').text().replace('*', '') + "</td > ";
                    excel += "<td>" + ddlText + "</td>";
                    excel += "</tr>";
                }
                excel += "<tr><td></td></tr>";
                excel += '</tr>';
                $(el).find('thead').find('tr').each(function () {
                    excel += "<tr>";
                    $(this).filter(':visible').find('th').each(function (index, data) {
                        if ($(this).css('display') !== 'none') {
                            if (defaults.ignoreColumn.indexOf(index) === -1) {
                                excel += "<td><b>" + parseString($(this)) + "</b></td>";
                            }
                        }
                    });
                    excel += '</tr>';
                });
                // Row Vs Column
                var rowCount = 1;
                if ($('#sample_1+.row-fluid').find('.dataTables_info').length > 0) {
                    $('#sample_1').DataTable().fnDestroy();
                }
                $(el).find('tbody').find('tr').each(function () {
                    excel += "<tr>";
                    var colCount = 0;
                    $(this).filter(':visible').find('td').each(function (index, data) {
                        if ($(this).css('display') !== 'none') {
                            if (defaults.ignoreColumn.indexOf(index) === -1) {
                                excel += "<td>" + parseString($(this)) + "</td>";
                            }
                        }
                        colCount++;
                    });
                    rowCount++;
                    excel += '</tr>';
                });
                if ($('#sample_1+.row-fluid').find('.dataTables_info').length <= 0) {
                    $('#sample_1').DataTable();
                }
                //var date = new Date();
                //var currentTimeStamp = date.getHours() + ":" + date.getMinutes() + ":" + date
                excel += "<tfoot>";
                excel += "<tr>";
                excel += "</tr>";
                excel += "<tr>";
                excel += "<td style='font-weight:bold;'>Username</td>";
                excel += "<td></td>";
                excel += "</tr>";
                excel += "<tr>";
                excel += "<td style='font-weight:bold;'>Timestamp</td>";
                excel += "<td>" + $(el).find('tbody').find('tr').first().find('td.TimeStamp').text() + "</td>";
                excel += "</tr>";
                excel += "</tfoot>";
                excel += '</table>';
                if (defaults.consoleLog === 'true') {
                    console.log(excel);
                }
                var excelFile = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:" + defaults.type + "' xmlns='http://www.w3.org/TR/REC-html40'>";
                excelFile += "<head>";
                excelFile += "<!--[if gte mso 9]>";
                excelFile += "<xml>";
                excelFile += "<x:ExcelWorkbook>";
                excelFile += "<x:ExcelWorksheets>";
                excelFile += "<x:ExcelWorksheet>";
                excelFile += "<x:Name>";
                excelFile += "{worksheet}";
                excelFile += "</x:Name>";
                excelFile += "<x:WorksheetOptions>";
                excelFile += "<x:DisplayGridlines/>";
                excelFile += "</x:WorksheetOptions>";
                excelFile += "</x:ExcelWorksheet>";
                excelFile += "</x:ExcelWorksheets>";
                excelFile += "</x:ExcelWorkbook>";
                excelFile += "</xml>";
                excelFile += "<![endif]-->";
                excelFile += "</head>";
                excelFile += "<body>";

                excelFile += excel;
                excelFile += "</body>";
                excelFile += "</html>";
                var base64data = "base64," + btoa(excelFile);
                var uri = 'data:application/vnd.ms-excel;' + base64data;
                var link = document.createElement("a");
                link.href = uri;
                link.style = "visibility:hidden";
                link.download = defaults.filename;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }

            function parseString(data) {
                if (defaults.htmlContent === 'true') {
                    content_data = data.html().trim();
                } else {
                    content_data = data.text().trim();
                }
                if (defaults.escape === 'true') {
                    content_data = encodeURI(content_data);
                }
                return content_data;
            }

            //Check original template for lot of convertion like to xml,json,pdf,etc
        }
    });
})(jQuery);