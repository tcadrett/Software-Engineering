<%-- 
    Document   : Template
    Created on : Apr 6, 2021, 6:29:40 PM
    Author     : tcadrett
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.dbConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <title>FSBank</title>
        <%@include file="header.jsp" %>
    </head>
    <body id="myPage">
        <div class="w3-container w3-padding 32">



            <%
                dbConnect dbconnect = new dbConnect();
                String selection = request.getQueryString(); // get query
                // remove "=Edit" leftover from form
                selection = selection.substring(0, selection.length() - 5);

                String viewerID = "-1";
                int viewerPermiss = -1;
                try {
                    viewerID = session.getAttribute("acctID").toString();
                    viewerPermiss = Integer.parseInt(dbconnect.queryDB("SELECT AcctType FROM accounts WHERE AcctID = ?;", viewerID)[0]);
                } catch (Exception e) {
                    // do nothing. viewerID is already -1
                }

                //String stat = selection.substring(0, 1); // Status ('A' or 'R')
                String id = selection.substring(1); // Request ID #

                String sql = "SELECT * FROM accounts WHERE AcctID = ?;";
                String[] result = dbconnect.queryDB(sql, id);

            %>


            <div class="w3-row">
                <div class="w3-col m3"><p></p></div>
                <div class="w3-col m6">
                    <h1>Modify Account</h1>
                </div></div>
            <div class="w3-row">

                <div class="w3-col m3"><p></p></div>
                <div class=" w3-col m6 w3-card">
                    <div class='w3-container'>
                        <div class='w3-margin'></div>

                        <form action='modifyAccountInfoAction.jsp' class=''>

                            <label>First Name</label>

                            <input class='w3-input' type='text' name='FirstName' 
                                   value='<%out.print(result[1]);%>' required/>
                            <label>Last Name</label>

                            <input class='w3-input' type='text' name='LastName' 
                                   value='<%out.print(result[2]);%>' required/>
                            <label>Email</label>

                            <input class='w3-input' type='text' name='Email' 
                                   value='<%out.print(result[3]);%>' required/>
                            <label>Phone</label>

                            <input class='w3-input' type='text' name='Phone' 
                                   value='<%out.print(result[4]);%>' required/>
                            <label>Username</label>
                            <input class='w3-input' type='text' name='Username'
                                   value='<%out.print(result[7]);%>' required/>
                            <hr>


                            <%if (viewerPermiss == 3) {%>
                            <!-- Apply Session Control to only show this select option to admins" -->
                            <label>Account Type</label>
                            <select class='w3-select' name='AccountType' size='1' >
                                <option 

                                    <%
                                        if (result[5].equals("0")) {
                                            out.print(" selected ");
                                        }
                                    %>
                                    value="0">Suspended</option>
                                <option 

                                    <%
                                        if (result[5].equals("1")) {
                                            out.print(" selected ");
                                        }
                                    %>
                                    value="1">Account Holder</option>
                                <option 
                                    <%
                                        if (result[5].equals("2")) {
                                            out.print(" selected ");
                                        }
                                    %>
                                    value="2">Clerk</option>
                                <option 
                                    <%
                                        if (result[5].equals("3")) {
                                            out.print(" selected ");
                                        }
                                    %>
                                    value="3">Administrator</option>
                            </select>

                            <label>Account Status</label>
                            <select class='w3-select' name='AccountStatus' size='1' >
                                <option 
                                    <%
                                        if (result[6].equals("0")) {
                                            out.print(" selected ");

                                        }
                                        out.print("Value='0'>" + dbconnect.decodeAccountStatus("0"));
                                    %>
                            </option>
                            <option 
                                <%
                                    if (result[6].equals("1")) {
                                        out.print(" selected ");

                                    }
                                    out.print("Value='1'>" + dbconnect.decodeAccountStatus("1"));
                                %>
                        </option>
                        <option 
                            <%
                                if (result[6].equals("2")) {
                                    out.print(" selected ");

                                }
                                out.print("Value='2'>" + dbconnect.decodeAccountStatus("2"));
                            %>
                    </option>

                </select>
                <hr>

                <%} else {  // hidden versions for all but admins%> 
                <input type="hidden" name="AccountType" value ="<%out.print(result[5]);%>"/>
                <input type="hidden" name="AccountStatus" value="<%out.print(result[6]);%>"/>
                <% }%>

                <input type='hidden' name='acctID' value='<%out.print(id);%>'>
                <input class="w3-button w3-teal" type='submit' value='Submit' name='Submit' />
                <div class='w3-margin'></div>
            </form>
        </div>
    </div>
</div>

</div>
</body>
</html>
