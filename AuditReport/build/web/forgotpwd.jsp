<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>

<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>


 


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title></title>
        <style type="text/css">
            <!--
            .style5 {font-size: 12px}
            .style7 {
                font-family: Verdana, Arial, Helvetica, sans-serif, "Agency FB";
                font-weight: bold;
                color: #cccccc;
                font-size: 10;
            }
            .style8 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 12px; }
            .style10 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; color: #336699; }
            .style12 {
                font-family: Verdana, Arial, Helvetica, sans-serif;
                font-weight: bold;
                font-size: 10px;
                color: #336699;
            }
            .style13 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 12px; color: #336699; }
            -->
        </style>




    </head>

    <body bgcolor="#EAF2F8">

        <form name="CMLOGINFORM" method="post" action="emailPwd.jsp" >

            <table width="40%" border="0" align="center" bgcolor="#AED6F1">
                <tr bgcolor="#1B4F72">
                    <td colspan="2"><div align="center">
                            <div align="center"><span class="style7">Forgot Password </span></div></td>
                </tr>
                <tr bgcolor="#AED6F1">

                    <tr bgcolor="#AED6F1">
                        <td colspan="2" align="right"></td>
                    </tr>
                    <td colspan="2"><div align="center"> &nbsp</td>
                </tr>
                <tr bgcolor="#AED6F1">
                    <td><div align="right" class="style5"><span class="style10">Staff Number </span></div></td>
                    <td><span class="style8">
                            <label>
                                <input name="STNO" type="text" id="STNO" />
                            </label>
                        </span></td>
                </tr>
                

                <tr bgcolor="#AED6F1">
                    <td colspan="1">
                        <div align="left"></div></td>
                    <td colspan="1">
                        <div align="left">
                            <input type="Submit" value="Submit" />
                        </div></td>
                </tr>

                <tr bgcolor="#AED6F1">
                    <td colspan="2">&nbsp;</td>
                </tr>



            </table>
        </form>

    </body>
</html>
