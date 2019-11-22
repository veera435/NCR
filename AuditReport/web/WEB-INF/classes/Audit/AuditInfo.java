/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Audit;

import db.dbcon;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author pillive1
 */
public class AuditInfo {

    public NcrAudit GetAuditInfoByNCRNo(String ncrno) throws SQLException {
        System.out.print("GetAuditInfoByNCRNo");
        NcrAudit objNcr = new NcrAudit();
        dbcon con = new dbcon();
        //Connection conn = con.getcon();
        //Statement st = con.getSt();
        ResultSet rs = null;
        Statement stmt = con.getSt();
        String qstring;
        //qstring = " select A.*,B.Audit_Name from AUDIT_INT_EXT A LEFT OUTER JOIN Audit_Area_Types B ON A.AUDIT_AREA = B.Audit_ID where NCR_NO = " + ncrno;
        qstring = "SELECT NCR_NO, FY_YEAR,AUDIT_DATE,AUDIT_AREA, AUDITEE_NAME,AUDITEE_STAFF_NO,AUDITOR_STAFF_NO,AUDITOR_INT_NAME,AUDITOR_EXT_NAME,AUDIT_OBSERVATION,NCR_TYPE, NCR_DETAILS,NCR_PLAN_CLS_DATE,ISO_CLAUSE, DOC_REF, EMAIL,NCR_ACTUAL_CLS_DATE, AUDITOR_ACTION,ISO_COORD_REMARKS,AUDITEE_REMARKS_CLS,CORRECTION, CORR_DT,CORRECTION_NAME,RCA,RCA_DT, RCA_NAME,CORR_ACTION,CORR_ACTION_DT,CORR_ACTION_NAME,AUDITOR_REV_DT,ATTACHMENT,NCR_CLS_CONF,NCR_CLS_CONF_DT,AUDITOR_REMARKS,STAFF_NO, B.Audit_Name,HOS_ACTION,HOS_REMARKS,COLEAD_AUDITOR_REMARKS,HOS_NAME,HOS_STFNO FROM AUDIT_INT_EXT A LEFT OUTER JOIN Audit_Area_Types B ON A.AUDIT_AREA = B.Audit_ID WHERE NCR_NO = " +  ncrno;
        //qstring = "{CALL usp_40_GET_AUDIT_INT_EXT(?)}";
        //System.out.println("query " + qstring);
        //cstmt = conn.prepareCall(qstring);
        //cstmt.setString(1, ncrno);
        rs = stmt.executeQuery(qstring);
        //rs = cstmt.executeQuery();

        //rs = (qstring);
        if (rs.next()) {
            objNcr.setNCR_No(rs.getString(1));
            objNcr.setFY_YEAR(rs.getString(2));
            objNcr.setAUDIT_DATE(rs.getString(3));
            objNcr.setAUDIT_AREA(rs.getString(4));
            objNcr.setAUDITEE_NAME(rs.getString(5));
            objNcr.setAUDITEE_STFNO(rs.getString(6));
            objNcr.setAUDITOR_STFNO(rs.getString(7));
            objNcr.setAUDITOR_INT_NAME(rs.getString(8));
            objNcr.setAUDITOR_EXT_NAME(rs.getString(9));
            objNcr.setAUDIT_OBSERVATION(rs.getString(10));
            objNcr.setNCR_TYPE(rs.getString(11));
            objNcr.setNCR_DETAILS(rs.getString(12));
            objNcr.setNCR_PLAN_CLS_DATE(rs.getString(13));
            objNcr.setISO_CLAUSE(rs.getString(14));
            objNcr.setDOC_REF(rs.getString(15));
            objNcr.setEMAIL(rs.getString(16));
            objNcr.setNCR_ACTUAL_CLS_DATE(rs.getString(17));
            objNcr.setAUDITOR_ACTION(rs.getString(18));
            objNcr.setISO_COORD_REMARKS(rs.getString(19));
            objNcr.setAUDITEE_REMARKS_CLS(rs.getString(20));
            objNcr.setCORRECTION(rs.getString(21));
            objNcr.setCORR_DT(rs.getString(22));
            objNcr.setCORRECTION_NAME(rs.getString(23));
            objNcr.setRCA(rs.getString(24));
            objNcr.setRCA_DT(rs.getString(25));
            objNcr.setRCA_NAME(rs.getString(26));
            objNcr.setCORR_ACTION(rs.getString(27));
            objNcr.setCORR_ACTION_DT(rs.getString(28));
            objNcr.setCORR_ACTION_NAME(rs.getString(29));
            objNcr.setAUDITOR_REV_DT(rs.getString(30));
            objNcr.setATTACHMENT(rs.getString(31));
            objNcr.setNCR_CLS_CONF(rs.getString(32));
            objNcr.setNCR_CLS_CONF_DT(rs.getString(33));
            objNcr.setAUDITOR_REMARKS(rs.getString(34));
            objNcr.setSTAFF_NO(rs.getString(35));
            objNcr.setAUDIT_AREA_NAME(rs.getString(36));
            objNcr.setHOS_ACTION(rs.getString(37));
            objNcr.setHOS_REMARKS(rs.getString(38));
            objNcr.setCOLEAD_AUDITOR_REMARKS(rs.getString(39));
            objNcr.setHOS_NAME(rs.getString(40));
            objNcr.setHOS_STFNO(rs.getString(41));
        }
        con.Conclose();
        return objNcr;
    }

    public List<AuditType> GetAuditTypes() throws SQLException {
        List<AuditType> arrAuditTypes = new ArrayList<AuditType>();
        dbcon con = new dbcon();
        String qstring = " select * from Audit_Area_Types";
        Statement stmt = con.getSt();
        ResultSet rs = stmt.executeQuery(qstring);
        while (rs.next()) {
            arrAuditTypes.add(new AuditType(rs.getInt("Audit_ID"), rs.getString("Audit_Name")));
        }
        return arrAuditTypes;
    }

    public List<NcrAudit> GetAuditBasicInfo(String ncrno) throws SQLException {
        List<NcrAudit> coll = new ArrayList<NcrAudit>();
        NcrAudit objNcr = null;
        dbcon con = new dbcon();
        ResultSet rs = null;
        Connection conn = con.getcon();
        CallableStatement cstmt = null;
        String qstring;
        qstring = "{CALL usp_50_GET_AUDIT_NCR_LIST(?)}";
        System.out.println("query " + qstring);
        cstmt = conn.prepareCall(qstring);
        cstmt.setString(1, ncrno);
        rs = cstmt.executeQuery();

        //rs = (qstring);
        while (rs.next()) {
            objNcr = new NcrAudit();
            objNcr.setNCR_No(rs.getString(1));
            objNcr.setNCR_TYPE(rs.getString(2));
            objNcr.setNCR_CLS_CONF(rs.getString(3));
            objNcr.setAUDITOR_ACTION(rs.getString(4));
            coll.add(objNcr);
        }
        con.Conclose();
        return coll;
    }
}
