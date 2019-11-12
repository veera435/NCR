/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Audit;

/**
 *
 * @author pillive1
 */
public class NcrAudit {

    private String NCR_NO;

    public String getNCR_NO() {
        return NCR_NO;
    }

    public void setNCR_No(String ncr_no) {
        this.NCR_NO = ncr_no;
    }

    private String STAFF_NO;

    public String getSTAFF_NO() {
        return STAFF_NO;
    }

    public void setSTAFF_NO(String staff_no) {
        if (staff_no != null) {
            this.STAFF_NO = staff_no;
        }
    }

    private String FY_YEAR;

    public String getFY_YEAR() {
        return FY_YEAR;
    }

    public void setFY_YEAR(String fy_year) {
        if (fy_year != null) {
            this.FY_YEAR = fy_year;
        }
    }

    private String AUDITEE_STFNO;

    public String getAUDITEE_STFNO() {

        return AUDITEE_STFNO;

    }

    public void setAUDITEE_STFNO(String auditee_stfno) {
        if (auditee_stfno != null) {
            this.AUDITEE_STFNO = auditee_stfno;
        }

    }

    private String AUDITOR_STFNO;

    public String getAUDITOR_STFNO() {

        return AUDITOR_STFNO;

    }

    public void setAUDITOR_STFNO(String auditor_stfno) {
        if (auditor_stfno != null) {
            this.AUDITOR_STFNO = auditor_stfno;
        }

    }

    private String AUDITOR_INT_NAME;

    public String getAUDITOR_INT_NAME() {

        return AUDITOR_INT_NAME;

    }

    public void setAUDITOR_INT_NAME(String auditor_int_name) {
        if (auditor_int_name != null) {
            this.AUDITOR_INT_NAME = auditor_int_name;
        }

    }

    private String AUDITOR_EXT_NAME;

    public String getAUDITOR_EXT_NAME() {

        return AUDITOR_EXT_NAME;

    }

    public void setAUDITOR_EXT_NAME(String auditor_ext_name) {
        if (auditor_ext_name != null) {
            this.AUDITOR_EXT_NAME = auditor_ext_name;
        }

    }

    private String AUDIT_DATE;

    public String getAUDIT_DATE() {
        return AUDIT_DATE;
    }

    public void setAUDIT_DATE(String audit_date) {
        if (audit_date != null && audit_date.isEmpty() == false) {
            this.AUDIT_DATE = audit_date;
        }
    }
    private String AUDIT_AREA;

    public String getAUDIT_AREA() {
        return AUDIT_AREA;
    }

    public void setAUDIT_AREA(String audit_area) {
        if (audit_area != null) {
            this.AUDIT_AREA = audit_area;
        }
    }
    
    private String AUDIT_AREA_NAME;

    public String getAUDIT_AREA_NAME() {
        return AUDIT_AREA_NAME;
    }

    public void setAUDIT_AREA_NAME(String audit_area_name) {
        if (audit_area_name != null) {
            this.AUDIT_AREA_NAME = audit_area_name;
        }
    }
    private String AUDITEE_NAME;

    public String getAUDITEE_NAME() {
        return AUDITEE_NAME;
    }

    public void setAUDITEE_NAME(String auditee_name) {
        if (auditee_name != null) {
            this.AUDITEE_NAME = auditee_name;
        }
    }

    private String AUDIT_OBSERVATION;

    public String getAUDIT_OBSERVATION() {
        return AUDIT_OBSERVATION;
    }

    public void setAUDIT_OBSERVATION(String audit_observation) {
        if (audit_observation != null) {
            this.AUDIT_OBSERVATION = audit_observation;
        }
    }

    private String EMAIL;

    public String getEMAIL() {
        return EMAIL;
    }

    public void setEMAIL(String email) {
        if (email != null) {
            this.EMAIL = email;
        }
    }
    private String NCR_TYPE;

    public String getNCR_TYPE() {
        return NCR_TYPE;
    }

    public void setNCR_TYPE(String ncr_type) {
        if (ncr_type != null) {
            this.NCR_TYPE = ncr_type;
        }
    }
    private String NCR_DETAILS;

    public String getNCR_DETAILS() {
        return NCR_DETAILS;
    }

    public void setNCR_DETAILS(String ncr_details) {
        if (ncr_details != null) {
            this.NCR_DETAILS = ncr_details;
        }
    }
    private String NCR_PLAN_CLS_DATE;

    public String getNCR_PLAN_CLS_DATE() {
        return NCR_PLAN_CLS_DATE;
    }

    public void setNCR_PLAN_CLS_DATE(String ncr_plan_cls_date) {
        if (ncr_plan_cls_date != null && ncr_plan_cls_date.isEmpty() == false) {
            this.NCR_PLAN_CLS_DATE = ncr_plan_cls_date;
        }
    }
    private String NCR_ACTUAL_CLS_DATE;

    public String getNCR_ACTUAL_CLS_DATE() {
        return NCR_ACTUAL_CLS_DATE;
    }

    public void setNCR_ACTUAL_CLS_DATE(String ncr_actual_cls_date) {
        if (ncr_actual_cls_date != null && ncr_actual_cls_date.isEmpty() == false) {
            this.NCR_ACTUAL_CLS_DATE = ncr_actual_cls_date;
        }
    }
    private String AUDITOR_ACTION;

    public String getAUDITOR_ACTION() {
        return AUDITOR_ACTION;
    }

    public void setAUDITOR_ACTION(String auditor_action) {
        if (auditor_action != null) {
            this.AUDITOR_ACTION = auditor_action;
        }
    }
    private String ISO_COORD_REMARKS;

    public String getISO_COORD_REMARKS() {
        return ISO_COORD_REMARKS;
    }

    public void setISO_COORD_REMARKS(String iso_coord_remarks) {
        if (iso_coord_remarks != null) {
            this.ISO_COORD_REMARKS = iso_coord_remarks;
        }
    }
    private String AUDITEE_REMARKS_CLS;

    public String getAUDITEE_REMARKS_CLS() {
        return AUDITEE_REMARKS_CLS;
    }

    public void setAUDITEE_REMARKS_CLS(String auditee_remarks_cls) {
        if (auditee_remarks_cls != null) {
            this.AUDITEE_REMARKS_CLS = auditee_remarks_cls;
        }
    }
    private String CORRECTION;

    public String getCORRECTION() {
        return CORRECTION;
    }

    public void setCORRECTION(String correction) {
        if (correction != null) {
            this.CORRECTION = correction;
        }
    }
    private String CORR_DT;

    public String getCORR_DT() {
        return CORR_DT;
    }

    public void setCORR_DT(String corr_dt) {
        if (corr_dt != null && corr_dt.isEmpty() == false) {
            this.CORR_DT = corr_dt;
        }
    }

    private String CORRECTION_NAME;

    public String getCORRECTION_NAME() {
        return CORRECTION_NAME;
    }

    public void setCORRECTION_NAME(String correction_name) {
        if (correction_name != null) {
            this.CORRECTION_NAME = correction_name;
        }
    }

    private String RCA;

    public String getRCA() {
        return RCA;
    }

    public void setRCA(String rca) {
        if (rca != null) {
            this.RCA = rca;
        }
    }

    private String RCA_DT;

    public String getRCA_DT() {
        return RCA_DT;
    }

    public void setRCA_DT(String rca_dt) {
        if (rca_dt != null && rca_dt.isEmpty() == false) {
            this.RCA_DT = rca_dt;
        }
    }

    private String RCA_NAME;

    public String getRCA_NAME() {
        return RCA_NAME;
    }

    public void setRCA_NAME(String rca_name) {
        if (rca_name != null) {
            this.RCA_NAME = rca_name;
        }
    }

    private String CORR_ACTION;

    public String getCORR_ACTION() {
        return CORR_ACTION;
    }

    public void setCORR_ACTION(String corr_action) {
        if (corr_action != null) {
            this.CORR_ACTION = corr_action;
        }
    }

    private String CORR_ACTION_DT;

    public String getCORR_ACTION_DT() {
        return CORR_ACTION_DT;
    }

    public void setCORR_ACTION_DT(String corr_action_dt) {
        if (corr_action_dt != null && corr_action_dt.isEmpty() == false) {
            this.CORR_ACTION_DT = corr_action_dt;
        }
    }

    private String CORR_ACTION_NAME;

    public String getCORR_ACTION_NAME() {
        return CORR_ACTION_NAME;
    }

    public void setCORR_ACTION_NAME(String corr_action_name) {
        if (corr_action_name != null) {
            this.CORR_ACTION_NAME = corr_action_name;
        }
    }

    private String AUDITOR_REV_DT;

    public String getAUDITOR_REV_DT() {
        return AUDITOR_REV_DT;
    }

    public void setAUDITOR_REV_DT(String audit_rev_dt) {
        if (audit_rev_dt != null && audit_rev_dt.isEmpty() == false) {
            this.AUDITOR_REV_DT = audit_rev_dt;
        }
    }

    private String ISO_CLAUSE;

    public String getISO_CLAUSE() {
        return ISO_CLAUSE;
    }

    public void setISO_CLAUSE(String iso_clause) {
        if (iso_clause != null) {
            this.ISO_CLAUSE = iso_clause;
        }
    }

    private String DOC_REF;

    public String getDOC_REF() {
        return DOC_REF;
    }

    public void setDOC_REF(String doc_ref) {
        if (doc_ref != null) {
            this.DOC_REF = doc_ref;
        }
    }

    private String ATTACHMENT;

    public String getATTACHMENT() {
        return ATTACHMENT;
    }

    public void setATTACHMENT(String attachment) {
        if (attachment != null) {
            this.ATTACHMENT = attachment;
        }
    }

    private String NCR_CLS_CONF;

    public String getNCR_CLS_CONF() {
        return NCR_CLS_CONF;
    }

    public void setNCR_CLS_CONF(String ncr_cls_conf) {
        if (ncr_cls_conf != null) {
            this.NCR_CLS_CONF = ncr_cls_conf;
        }
    }

    private String NCR_CLS_CONF_DT;

    public String getNCR_CLS_CONF_DT() {
        return NCR_CLS_CONF_DT;
    }

    public void setNCR_CLS_CONF_DT(String ncr_cls_conf_dt) {
        if (ncr_cls_conf_dt != null && ncr_cls_conf_dt.isEmpty() == false) {
            this.NCR_CLS_CONF_DT = ncr_cls_conf_dt;
        }
    }
    private String AUDITOR_REMARKS;

    public String getAUDITOR_REMARKS() {
        return AUDITOR_REMARKS;
    }

    public void setAUDITOR_REMARKS(String auditor_remarks) {
        if (auditor_remarks != null && auditor_remarks.isEmpty() == false) {
            this.AUDITOR_REMARKS = auditor_remarks;
        }
    }
    
    private String hos_action;

    public String getHOS_ACTION() {
        return hos_action;
    }

    public void setHOS_ACTION(String hos_action) {
        if (hos_action != null && hos_action.isEmpty() == false) {
            this.hos_action = hos_action;
        }
    }
    
    private String hos_remarks;

    public String getHOS_REMARKS() {
        return hos_remarks;
    }

    public void setHOS_REMARKS(String hos_remarks) {
        if (hos_remarks != null && hos_remarks.isEmpty() == false) {
            this.hos_remarks = hos_remarks;
        }
    }
    
    private String colead_auditor_action;

    public String getCOLEAD_AUDITOR_ACTION() {
        return colead_auditor_action;
    }

    public void setCOLEAD_AUDITOR_ACTION(String colead_auditor_action) {
        if (colead_auditor_action != null && colead_auditor_action.isEmpty() == false) {
            this.colead_auditor_action = colead_auditor_action;
        }
    }
    
    private String colead_auditor_remarks;

    public String getCOLEAD_AUDITOR_REMARKS() {
        return colead_auditor_remarks;
    }

    public void setCOLEAD_AUDITOR_REMARKS(String colead_auditor_remarks) {
        if (colead_auditor_remarks != null && colead_auditor_remarks.isEmpty() == false) {
            this.colead_auditor_remarks = colead_auditor_remarks;
        }
    }
    private String HOS_NAME;

    public String getHOS_NAME() {
        return HOS_NAME;
    }

    public void setHOS_NAME(String hos_name) {
        if (hos_name != null) {
            this.HOS_NAME = hos_name;
        }
    }
    private String HOS_STFNO;

    public String getHOS_STFNO() {

        return HOS_STFNO;

    }

    public void setHOS_STFNO(String hos_stfno) {
        if (hos_stfno != null) {
            this.HOS_STFNO = hos_stfno;
        }

    }
    private String COLEAD_NAME;

    public String getCOLEAD_NAME() {
        return COLEAD_NAME;
    }

    public void setCOLEAD_NAME(String colead_name) {
        if (colead_name != null) {
            this.COLEAD_NAME = colead_name;
        }
    }
    private String COLEAD_STFNO;

    public String getCOLEAD_STFNO() {

        return COLEAD_STFNO;

    }

    public void setCOLEAD_STFNO(String colead_stfno) {
        if (colead_stfno != null) {
            this.COLEAD_STFNO = colead_stfno;
        }

    }
}
