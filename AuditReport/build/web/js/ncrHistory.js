/* global objNcr */

function getHistory()
{
    var acc = $('#AUDITOR_AUDITEE_COORD').val();

    if (acc !== null && acc === "2") {
        $("input").prop('readonly', true);
        $("#NCR_CLS_CONF").prop('style', 'pointer-events: none;');
        $("#ISO_CLAUSE").prop('readonly', false);
        $("#ISO_COORD_REMARKS").prop('readonly', false);
        $("#files").hide();
        $(".isolog").hide();
    } else if (acc !== null && acc !== "2") {
        $("#AUDITOR_ACTION").prop('style', 'pointer-events: none;');
        $("#ISO_CLAUSE").prop('readonly', true);
        $("#ISO_COORD_REMARKS").prop('readonly', true);
        $("#A_NCR_CLS_CONF_DT").hide();
        $("#A_AUDITOR_REV_DT").hide();
    }
    getHistoryAJAX($('#NCR_NO').val());
}

function getHistoryAJAX(ncrno)
{
    $.ajax({
        url: "AuditHistory.jsp",
        data: {ncrnor: ncrno},
        success: function (data) {
            if (data.length > 0) {
                data = JSON.parse(data);
                console.info(data);
                var table = '';
                var tempId = -1;
                for (var i = 0; i < data.length; i++)
                {
                    if (tempId !== data[i].Id)
                    {
                        if (tempId !== -1)
                        {
                            table = table + '</table>';
                            tempId = data[i].Id;
                        }
                        table = table + '<table style="width:60%" border="1">';
                        table = table + '<tr>';
                        table = table + '<th bgcolor="#1B4F72" colspan="3">';
                        table = table + ' ' + data[i].UserName + ' made changes - ' + data[i].MODIFIED_DATE;
                        table = table + '</th>';
                        table = table + '</tr>';
                        table = table + '<tr><th bgcolor="#1B4F72">Filed';
                        table = table + '</th>';
                        table = table + '<th bgcolor="#1B4F72">Orignal Value</th><th bgcolor="#1B4F72">New Value</th></tr>';
                    }
                    if (tempId === -1 || tempId === data[i].Id)
                    {
                        table = table + '<tr>';
                        table = table + '<td>' + data[i].FIELD_NAME + '</td>';
                        table = table + '<td>' + data[i].FIELD_OLD_VALUE + '</td>';
                        table = table + '<td>' + data[i].FIELD_NEW_VALUE + '</td>';
                        table = table + '</tr>';
                    }
                    tempId = data[i].Id;
                }
                $('#dvHistory').html(table);
                $("#dialog").dialog();
            }
        },
        error: function (err) {
            console.info(err);
        }
    });
}

function initAutoComplete(auditorType)
{
    $("#AUDITEE_NAME").autocomplete({
        source: function (request, response) {
            //if (auditorType === "0") // only for internal
            //{
            var auditId = $('#AUDIT_AREA').val();
            $.ajax({
                url: "audituser.jsp",
                data: {name: request.term, val: auditId},
                success: function (data) {
                    debugger;
                    if (data.length > 0) {
                        data = JSON.parse(data);
                        response(data);
                    }
                },
                error: function (err) {
                    response([]);
                }
            });
            //}
        },
        select: function (event, ui) {
            $('#AUDITEE_NAME_HIDDEN').val(ui.item.Id);
            $('#AUDITEE_STFNO').val(ui.item.Id);
        }
    });
}

function inihostAutoComplete()
{
    $("#HOS_NAME").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "hosAudituser.jsp",
                data: {name: request.term},
                success: function (data) {
                    debugger;
                    if (data.length > 0) {
                        data = JSON.parse(data);
                        response(data);
                    }
                },
                error: function (err) {
                    response([]);
                }
            });
            //}
        },
        select: function (event, ui) {
            $('#HOS_STFNO').val(ui.item.Id);
        }
    });
}

function inicoleadtAutoComplete()
{
    $("#COLEAD_NAME").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "coleadAudituser.jsp",
                data: {name: request.term},
                success: function (data) {
                    debugger;
                    if (data.length > 0) {
                        data = JSON.parse(data);
                        response(data);
                    }
                },
                error: function (err) {
                    response([]);
                }
            });
            //}
        },
        select: function (event, ui) {
            $('#COLEAD_STFNO').val(ui.item.Id);
        }
    });
}

function setPageAccess()
{
    var aacCode = $('#AUDITOR_AUDITEE_COORD').val();
    //alert(aacCode);
debugger;
    switch (aacCode) {
        case "0": // For Auditor
        {
            $("#DOC_REF, #AUDIT_OBSERVATION, #ISO_CLAUSE, #RCA_NAME").prop('readonly', false);
            $("#AUDITOR_ACTION").prop('style', 'pointer-events: none;');
            $("#AUDITEE_REMARKS_CLS, #CORRECTION, #CORRECTION_NAME, #RCA").prop('readonly', true);
            $("#ISO_COORD_REMARKS, #CORR_ACTION_NAME, #CORR_ACTION, #RCA_NAME,#HOS_REMARKS,#COLEAD_AUDITOR_REMARKS").prop('readonly', true);
            $("#A_NCR_CLS_CONF_DT, #A_CORR_DT, #A_NCR_ACTUAL_CLS_DATE").hide();
            $("#A_RCA_DT, #A_CORR_ACTION_DT").hide();
            $("#COLEAD_AUDITOR_ACTION, #HOS_ACTION").prop('style', 'pointer-events: none;');
            $("#COLEAD_NAME").prop('readonly', false);
            
            break;
        }
        case "1": // AUDITEE
        {
            $("#AUDITOR_ACTION").prop('style', 'pointer-events: none;');
            $("#ISO_CLAUSE,#AUDIT_OBSERVATION").prop('readonly', true);
            $("#HOS_NAME").prop('readonly', false);
            $("#NCR_CLS_CONF").prop('style', 'pointer-events: none;');
            $("#ISO_COORD_REMARKS,#AUDITOR_REMARKS, #NCR_DETAILS, #HOS_REMARKS,#COLEAD_AUDITOR_REMARKS").prop('readonly', true);
            $("#A_NCR_CLS_CONF_DT").hide();
            $("#A_AUDITOR_REV_DT, #A_NCR_PLAN_CLS_DATE, #A_AUDIT_DATE").hide();
            $("#NCR_TYPE").prop('style', 'pointer-events: none;');
            $("#FY_YEAR, #AUDIT_AREA, #COLEAD_AUDITOR_ACTION, #HOS_ACTION").prop('style', 'pointer-events: none;');
            break;
        }
        case "2": // ISOCOORD
        {
            $("input").prop('readonly', true);
            $("#NCR_CLS_CONF").prop('style', 'pointer-events: none;');
            $("#NCR_TYPE,#FY_YEAR,#AUDIT_AREA").prop('style', 'pointer-events: none;');
            $("#ISO_COORD_REMARKS, #EMAIL").prop('readonly', false);
            $("#AUDITEE_REMARKS_CLS, #NCR_DETAILS, #ISO_CLAUSE, #AUDIT_OBSERVATION").prop('readonly', true);
            $("#CORRECTION").prop('readonly', true);
            $("#RCA").prop('readonly', true);
            $("#CORR_ACTION").prop('readonly', true);
            $("#A_AUDITOR_REV_DT").hide();
            $("#files").hide();
            $(".isolog").hide();
            break;
        }
        case "3": // HOS
        {
             $("#AUDITOR_ACTION").prop('style', 'pointer-events: none;');
            $("#CORRECTION_NAME,#RCA_NAME,#RCA,#CORR_ACTION_NAME,#CORR_ACTION,#CORRECTION,#AUDITEE_REMARKS_CLS,#ISO_CLAUSE,#AUDIT_OBSERVATION,#DOC_REF").prop('readonly', true);
            $("#NCR_CLS_CONF").prop('style', 'pointer-events: none;');
            $("#ISO_COORD_REMARKS,#AUDITOR_REMARKS, #NCR_DETAILS,#COLEAD_AUDITOR_REMARKS").prop('readonly', true);
            $("#A_NCR_CLS_CONF_DT").hide();
            $("#COLEAD_NAME").prop('readonly', false);
            $("#A_AUDITOR_REV_DT, #A_NCR_PLAN_CLS_DATE, #A_AUDIT_DATE").hide();
            $("#NCR_TYPE,#AUDIT_AREA,#FY_YEAR, #COLEAD_AUDITOR_ACTION").prop('style', 'pointer-events: none;');
            $("#A_NCR_CLS_CONF_DT, #A_CORR_DT, #A_NCR_ACTUAL_CLS_DATE").hide();
            $("#A_RCA_DT, #A_CORR_ACTION_DT").hide();
            $("#files").hide();
            $(".isolog").hide();
            break;
        }
        case "4": // COOLED
        {
            $("#AUDITOR_ACTION").prop('style', 'pointer-events: none;');
            $("#ISO_CLAUSE,#AUDIT_OBSERVATION,#DOC_REF").prop('readonly', true);
            $("#NCR_CLS_CONF").prop('style', 'pointer-events: none;');
            $("#ISO_COORD_REMARKS,#AUDITOR_REMARKS, #NCR_DETAILS,#HOS_REMARKS").prop('readonly', true);
            $("#A_NCR_CLS_CONF_DT").hide();
            $("#A_AUDITOR_REV_DT, #A_NCR_PLAN_CLS_DATE, #A_AUDIT_DATE").hide();
            $("#NCR_TYPE,#AUDIT_AREA,#FY_YEAR,#HOS_ACTION").prop('style', 'pointer-events: none;');
            $("#A_NCR_CLS_CONF_DT, #A_CORR_DT, #A_NCR_ACTUAL_CLS_DATE").hide();
            $("#A_RCA_DT, #A_CORR_ACTION_DT").hide();
            $("#files").hide();
            $(".isolog").hide();
            //$("#hdnHOS_ACTION").remove();
            break;
        }
    }
}

function getNCRList(aacno, staffno)
{
    if ($('#AUDIT_AREA').val() > -1)
    {
        $('#tblNcr tbody').html('');
        $.ajax({
            url: "AuditNcrList.jsp",
            data: {audit_area: $('#AUDIT_AREA').val(), staff_no: staffno, aac_no: aacno},
            success: function (data) {
                if (data.length > 0) {
                    data = JSON.parse(data);
                    console.info(data);
                    var table = '';
                    for (var i = 0; i < data.length; i++)
                    {
                        table = table + '<tr>';
                        table = table + '<td>' + data[i].AUDITOR_STAFF_NO + '</td>'; 
                        table = table + '<td style="cursor:pointer;" onclick="getDetails(' + data[i].NCRNO + ');">' + data[i].NCRNO + '</td>';
                        table = table + '<td>' + data[i].Audit_Name + '</td>';
                        table = table + '<td>' + data[i].NCR_DETAILS + '</td>';
                         table = table + '<td>' + data[i].ISO_CLAUSE + '</td>';
                        table = table + '<td>' + data[i].NCR_TYPE + '</td>';
                        table = table + '<td>' + data[i].NCR_CLS_CONF + '</td>';
                        table = table + '<td>' + data[i].AUDITOR_ACTION + '</td>';
                        table = table + '<td style="cursor:pointer;" onclick="getHistoryAJAX(' + data[i].NCRNO + ');">Click Here</td>';
                        table = table + '</tr>';
                    }
                    $('#tblNcr tbody').html(table);
                }
            },
            error: function (err) {
                console.info(err);
            }
        });
    }
}



function validlogin()
{

    // alert("I am an alert box!");
    var NCR_NO = document.main.NCR_NO.value;
    var FY_YEAR = document.main.FY_YEAR.value;
    var AUDIT_DATE = document.main.AUDIT_DATE.value;
    var AUDIT_AREA = document.main.AUDIT_AREA.value;
    var AUDITEE_NAME = document.main.AUDITEE_NAME.value;
    var AUDITOR_NAME = document.main.AUDITOR_NAME.value;
    var ATTACHMENT = document.main.ATTACHMENT.value;
    var AUDIT_OBSERVATION = document.main.AUDIT_OBSERVATION.value;
    var NCR_TYPE = document.main.NCR_TYPE.value;
    var NCR_DETAILS = document.main.NCR_DETAILS.value;
    var NCR_PLAN_CLS_DATE = document.main.NCR_PLAN_CLS_DATE.value;
    var NCR_ACTUAL_CLS_DATE = document.main.NCR_ACTUAL_CLS_DATE.value;
    var AUDITOR_ACTION = document.main.AUDITOR_ACTION.value;
    var ISO_COORD_REMARKS = document.main.ISO_COORD_REMARKS.value;
    var AUDITEE_REMARKS_CLS = document.main.AUDITEE_REMARKS_CLS.value;
    var CORRECTION = document.main.CORRECTION.value;
    var CORR_DT = document.main.CORR_DT.value;
    var CORRECTION_NAME = document.main.CORRECTION_NAME.value;
    var RCA = document.main.RCA.value;
    var RCA_DT = document.main.RCA_DT.value;
    var RCA_NAME = document.main.RCA_NAME.value;
    var CORR_ACTION = document.main.CORR_ACTION.value;
    var CORR_ACTION_DT = document.main.CORR_ACTION_DT.value;
    var CORR_ACTION_NAME = document.main.CORR_ACTION_NAME.value;
    var AUDITOR_REV_DT = document.main.AUDITOR_REV_DT.value;
    var ISO_CLAUSE = document.main.ISO_CLAUSE.value;
    var DOC_REF = document.main.DOC_REF.value;
    var NCR_CLS_CONF = document.main.NCR_CLS_CONF.value;
    var NCR_CLS_CONF_DT = document.main.NCR_CLS_CONF_DT.value;
    //if (NCR_NO.length === 0)
    // {
    // alert("* Marked fields are mandatory.");
    //document.main.NCR_NO.focus();
    //return false;
    //}

    if (FY_YEAR.length === 0)
    {
        alert("* Marked fields are mandatory.");
        document.main.FY_YEAR.focus();
        return false;
    }

    if (AUDIT_DATE.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.AUDIT_DATE.focus();
        return false;
    }

    if (AUDIT_AREA.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.AUDIT_AREA.focus();
        return false;
    }

    if (AUDITEE_NAME.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.AUDITEE_NAME.focus();
        return false;
    }


    if (AUDITOR_NAME.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.AUDITOR_NAME.focus();
        return false;
    }
    if (AUDIT_OBSERVATION.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.AUDIT_OBSERVATION.focus();
        return false;
    }
    if (NCR_TYPE.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.NCR_TYPE.focus();
        return false;
    }
    if (NCR_DETAILS.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.NCR_DETAILS.focus();
        return false;
    }
    if (NCR_PLAN_CLS_DATE.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.NCR_PLAN_CLS_DATE.focus();
        return false;
    }
    if (NCR_ACTUAL_CLS_DATE.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.NCR_ACTUAL_CLS_DATE.focus();
        return false;
    }
    if (AUDITOR_ACTION.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.AUDITOR_ACTION.focus();
        return false;
    }
    if (ISO_COORD_REMARKS.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.ISO_COORD_REMARKS.focus();
        return false;
    }
    if (AUDITEE_REMARKS_CLS.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.AUDITEE_REMARKS_CLS.focus();
        return false;
    }
    if (CORRECTION.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.CORRECTION.focus();
        return false;
    }
    if (CORRECTION_NAME.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.CORRECTION_NAME.focus();
        return false;
    }
    if (RCA.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.RCA.focus();
        return false;
    }
    if (RCA_DT.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.RCA_DT.focus();
        return false;
    }
    if (RCA_NAME.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.RCA_NAME.focus();
        return false;
    }
    if (CORR_ACTION_DT.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.CORR_ACTION_DT.focus();
        return false;
    }
    if (CORR_ACTION_NAME.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.CORR_ACTION_NAME.focus();
        return false;
    }
    if (AUDITOR_REV_DT.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.AUDITOR_REV_DT.focus();
        return false;
    }
    if (ISO_CLAUSE.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.ISO_CLAUSE.focus();
        return false;
    }
    if (DOC_REF.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.DOC_REF.focus();
        return false;
    }
    if (NCR_CLS_CONF.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.NCR_CLS_CONF.focus();
        return false;
    }
    if (NCR_CLS_CONF_DT.length === 0)

    {
        alert("* Marked fields are mandatory.");
        document.main.NCR_CLS_CONF_DT.focus();
        return false;
    }
}

function deleteattachment(attachment, ncr_no)
{
    if (attachment !== null && attachment !== '')
    {
        var result = confirm("Are you sure want to delete ?");
        if (result) {
            var frm = document.getElementById('ncrform') || null;
            if (frm) {
                var element1 = document.createElement("input");
                element1.value = attachment;
                element1.name = "fileupload";
                frm.appendChild(element1);
                frm.action = 'NcrEdit.jsp?ncr_no=' + ncr_no;
                frm.submit();
            }
        }
    }
    return false;
}
function openChild(file, window) {
    childWindow = open(file, window, 'resizable=no,top=200, left=100,width=600,height=300');
    if (childWindow.opener === null)
        childWindow.opener = self;
}
function printForm()
{
    var printContents = document.getElementById("order1").innerHTML;
    var originalContents = document.body.innerHTML;
    document.body.innerHTML = printContents;
    window.print();
    document.body.innerHTML = originalContents;
}

function printForm2()
{
    var printContents = document.getElementById("order2").innerHTML;
    var originalContents = document.body.innerHTML;
    document.body.innerHTML = printContents;
    window.print();
    document.body.innerHTML = originalContents;
}