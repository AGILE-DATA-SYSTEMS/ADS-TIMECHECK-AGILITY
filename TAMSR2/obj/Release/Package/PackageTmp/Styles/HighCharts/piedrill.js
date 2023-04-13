var levelCounter = 0;
var drilldowns = {};
var currentDrillDown = [];

//$(document).ready(function () {    
//   PieDrill();
//});

function PieDrill() {
    var dt = $("#txtDashboardDate").val();
    var d = "key=getPercentage";
    var emp = $("#ddEmp").val();
    var mgr = $("#ddMgr").val();
    var org = $("#ddOrg").val();
    var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";
    d += "&dt=" + dt;
    d += wc;
    $("#divDrillDownWidget").mask('Processing....');
    $.ajax({
        type: 'POST',
        data: d,
        url: window.requestPageUrl,
        success: function (html) {
            var j = $.parseJSON(html);
            GenerateViolationData(j.LatePercentage, j.EarlyPercentage, j.AbsentPercentage, j.LeavePercentage, j.PresentPercentage, j.MissedInPercentage, j.MissedOutPercentage);
            $("#divDrillDownWidget").unmask();
        },
        error: function (html) {
            Tab3(0, 0, 0, 0, 100);
            $("#divErrorMsg").css("display", "block");
            $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
            $("#divDrillDownWidget").unmask();
        }
    });

}


function GenerateViolationData(Late, Early, Absent, Leave, Normal, MissedIn, MissedOut) {
   
    var seriesData = [];
    var colors = {
        blue: "#3f51b5",//"#5fb4ef",
        purple: "#aa00ff",//"#7c38bc",
        orange: "#ffb848",//"#ff851b",
        red: "#e7191b",//"#cc3f44",
        green: "#28b779",// "#a1c436",
        pink: "#e91e63",
        seagreen: "#009688",
        SlateGray: "#708090",
        DeepPink: "#FF1493",
        SkyBlue: "#00BCD4",
        Brown: "#7f380a",
        ChocklateBrown: "#594840",
        IndianRed: "#CD5C5C",
        Yellow: "#ff9800"
    }; 
    seriesData.push({ name: 'Late In', y: Late, drilldown: true, color: colors.purple, violationType: "Late" });
    seriesData.push({ name: 'Early Out', y: Early, drilldown: true, color: colors.pink, violationType: "Early" });
    seriesData.push({ name: 'Absent', y: Absent, drilldown: true, color: colors.red, violationType: "Absent" });
    seriesData.push({ name: 'Leave', y: Leave, drilldown: true, color: colors.Yellow, violationType: "Leave" });
    seriesData.push({ name: 'Normal', y: Normal, drilldown: true, color: colors.green, violationType: "Normal" });
    seriesData.push({ name: 'Missed In', y: MissedIn, drilldown: true, color: colors.seagreen, violationType: "Missed In" });
    seriesData.push({ name: 'Missed Out', y: MissedOut, drilldown: true, color: colors.SkyBlue, violationType: "Missed Out" });
    
    GenerateDrillDownChart(seriesData);

};


function GenerateDrillDownChart(seriesData, drilldownSeries) {
    if (!$('#container-trend-drilldown') || $('#container-trend-drilldown').length <= 0)
        return;

    $('#container-trend-drilldown').highcharts({
        chart: {
            type: 'pie',
            events: {
                drillup: function (e) {
                     
                    drilldowns[currentDrillDown] = { data: []};
                    if(e.target.drilldownLevels <=0)
                    {
                        drilldowns = {};   
                    }
                },

                redraw: function (event) {
                },
                drilldown: function (e, a, b) {

                    if (!e.seriesOptions) {
                        var chart = this;
                        var violationType;
                        violationType = e.point.violationType.toLowerCase();
                        
                        if (violationType == "normal")
                            return;

                        var d = "key=getPercentage";
                        var dt = $("#txtDashboardDate").val();
                        var emp = $("#ddEmp").val();
                        var mgr = $("#ddMgr").val();
                        var org = $("#ddOrg").val();
                        var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";

                        
                         if (e.point.departmentCode)
                            d = "key=getPercentageDepartment&code=" + e.point.departmentCode + "&type=" + violationType;
                        else
                             d = "key=getPercentageDepartment&type=" + violationType;
                         
                         d += "&dt=" + dt;
                         d += wc; 
                         chart.showLoading('&nbsp');
                        $.ajax({
                            type: 'POST',
                            data: d,
                            url: window.requestPageUrl,
                            success: function (result) {
                                
                                result = JSON.parse(result);
                                var drilldownData = [];
                                levelCounter = levelCounter + 1;
                                if (drilldowns[e.point.name] && drilldowns[e.point.name].data.length > 0) {
                                    chart.hideLoading();
                                    $('.active-drilldown').attr("href", "#portlet-config");
                                    $('.active-drilldown').attr("data-toggle", "modal");
                                    $('.active-drilldown').click();

                                    LoadDepartmentViolationPopup(violationType, e.point.departmentCode);
                                    return false;
                                }
                                
                                if (!result || result.length <= 0) {
                                    chart.hideLoading();
                                    return false;
                                }

                                if (result.length === 1 && result[0].OrganizationCode == e.point.departmentCode) {
                                    chart.hideLoading();
                                    $('.active-drilldown').attr("href", "#portlet-config");
                                    $('.active-drilldown').attr("data-toggle", "modal");
                                    $('.active-drilldown').click();

                                    LoadDepartmentViolationPopup(violationType, e.point.departmentCode);
                                    return false;
                                }

                                for (var i = 0; i < result.length; i++) {
                                    drilldownData.push({ name: result[i].OrganizationName, y: result[i].PercentageValue, departmentCode: result[i].OrganizationCode, violationType: violationType, drilldown: true, dataLabels: { enabled: true, format: '{point.name}: {point.y:.1f}%', style: { fontSize: "9px" } } })
                                }
                                currentDrillDown =e.point.name;
                               
                                drilldowns[e.point.name] = {
                                    id: e.point.name,
                                    name: e.point.name,
                                    data: drilldownData,
                                    point: {
                                        events: {
                                            click: function (event) {
                                            }
                                        }
                                    }

                                };
                                var series = drilldowns[e.point.name];
                                chart.hideLoading();
                                chart.addSeriesAsDrilldown(e.point, series);

                            },
                            error: function (html) {
                                $("#divErrorMsg").css("display", "block");
                                $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                            }
                        });
                    }
                }
            }
        },
        title: {
            text: ''
        },
        credits: {
            enabled: false
        },
        plotOptions: {
            series: {
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '{point.name}: {point.y:.1f}%',
                    style: {
                        fontSize: "12px"
                    }
                }
            },

        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{series.name}</span><br>',
            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
        },
        series: [{
            id: "toplevel",
            name: 'Violations',
            colorByPoint: true,
            data: seriesData
        }],
        drilldown: {
            activeDataLabelStyle: {
                textDecoration: 'underline'
              
            },
            series: []
        }
    });
};




