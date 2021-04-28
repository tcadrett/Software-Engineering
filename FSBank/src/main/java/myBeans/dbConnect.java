/*
  Written by: Terri Cadrette
  Created Mar 13, 2021
 */
package myBeans;

import java.sql.*;

/**
 *
 * @author Terri
 */
public class dbConnect {
    // Connection strings

    private final String driver = "com.mysql.jdbc.Driver";
    private final String url = "jdbc:mysql://localhost:3306/fsbank";
    private final String user = "mahadev";
    private final String pwd = "mahadev";

    // JDBC variables and methods
    private Connection conn = null;
    private Statement stm = null;
    private PreparedStatement pstm = null;
    private ResultSet rst = null;
    private ResultSetMetaData rsmd = null;

    /*-----------PRIVATE FUNCTIONS-----------------*/
    /**
     * Close current mySQL database connection
     *
     * @return String
     */
    private String closeDB() {
        String out = "CLOSED";
        try {
            stm.close(); // close statement
            conn.close(); // close connection
            System.out.println("Closed DB");
        } catch (Exception e) {
            out = e.getMessage();
        }
        return out;
    }

    /**
     * Open a connection to the database
     *
     * @return String
     */
    private String openDB() {
        String out = "OPEN";
        try {
            Class.forName(driver); // Load Driver
            conn = DriverManager.getConnection(url, user, pwd); // Connect to db
            stm = conn.createStatement(); // create statment
        } catch (Exception e) {
            out = e.getMessage(); // if error, set out to error
        }
        return out; // return output notifier
    }

    /*-----------PUBLIC FUNCTIONS-----------------*/
    /**
     * Clear non-numerical characters from input phone number.
     *
     * @param phone
     * @return String
     */
    public String cleanPhone(String phone) {
        String out = phone.replace("-", "");
        out = out.replace(".", "");
        out = out.replace(" ", "");
        return out;
    }

    /**
     *
     * @param status account status
     * @return string label of account status
     */
    public String decodeAccountStatus(String status) {
        switch (status) {
            case "0":
                return "Pending Request";
            case "1":
                return "Active";
            case "2":
                return "Closed";
            default:
                return "ERROR: Invalid Account Status";
        }
    }

    /**
     *
     * @param type account type
     * @return string label of account type
     */
    public String decodeAccountType(String type) {
        switch (type) {
            case "0":
                return "Suspended";
            case "1":
                return "Account Holder";
            case "2":
                return "Clerk";
            case "3":
                return "Administrator";
            default:
                return "ERROR: Invalid Account Type";
        }
    }

    /**
     *
     * @param sql first column inserted as Value, subsequent columns as text
     * separated by delimiter
     * @param delim Delimiter between subsequent columns
     * @param style Style classes to be applied to option tag
     * @return String html string
     */
    public String htmlDropdownQuery(String sql, String delim, String style) {
        String html = "";
        String output = openDB(); // open connection to database
        if (output.equals("OPEN")) {
            try {
                rst = stm.executeQuery(sql);  // execute sql query - results in rst
                rsmd = rst.getMetaData();           // } Get column count
                int noCol = rsmd.getColumnCount();  // |

                while (rst.next()) {
                    html += "<option value = '" + rst.getShort(1) + "' class='" + style + "'>";
                    for (int i = 2; i < noCol; i++) {
                        html += rst.getString(i) + delim;
                    }
                    html += rst.getString(noCol);
                    html += "</option>\n";
                }
                output = closeDB();
                return html;

            } catch (Exception e) {
                return e.getMessage();
            }
        } else {
            return output;
        }

    }

    /**
     *
     * @param sql SQL statement
     * @param delim Delimiters
     * @param liStyle style to add to <li> element
     * @return  <li></li> from sql statement
     */
    public String htmlListQuery(String sql, String delim, String liStyle) {
        String html = "";
        String output = openDB(); // open connection to database
        if (output.equals("OPEN")) {
            try {
                rst = stm.executeQuery(sql);  // execute sql query - results in rst
                rsmd = rst.getMetaData();           // } Get column count
                int noCol = rsmd.getColumnCount();  // |

                while (rst.next()) {
                    html += "<li " + liStyle + ">";
                    for (int i = 1; i <= noCol; i++) {  // add val
                        html += rst.getString(i) + delim;
                    }
                    html += "</li>\n";
                }
                output = closeDB();
                return html;
            } catch (Exception e) {
                return e.getMessage();
            }
        } else {
            return output;
        }

    }

    // TODO: Further generalize HTML table function
    /**
     *
     * @param sql SQL Statement
     * @param type "Head" or "Headless"
     * @param headStyle html style to add to the header row
     * @param rowStyle html style to add to data rows
     * @param headCellStyle html style to add to header cells
     * @param rowCellStyle html style to add to row cells
     * @param headAddi additional html to go at the end of the header row
     * @param rowAddi additional html to go at the end of the data rows
     * @return
     */
    public String htmlTableQuery(String sql, String type, String headStyle, String rowStyle, String headCellStyle, String rowCellStyle, String headAddi, String rowAddi) {
        String html = "";
        String output = openDB(); // open connection to database
        if (output.equals("OPEN")) {
            try {
                rst = stm.executeQuery(sql);  // execute sql query - results in rst
                rsmd = rst.getMetaData();           // } Get column count
                int noCol = rsmd.getColumnCount();  // |

                // Check if Account Type or Account Status columns are returned.
                //  set isAcct and isStat to specified column
                int isAcct = 0;
                int isStat = 0;
                for (int i = 1; i <= noCol; i++) {
                    if (rsmd.getColumnName(i).equals("AcctType")) {
                        isAcct = i;
                    }
                    if (rsmd.getColumnName(i).equals("AcctStatus")) {
                        isStat = i;
                    }
                }

                switch (type) {
                    case "Head":
                        // create column headings
                        html += "<tr " + headStyle + ">\n";
                        for (int i = 0; i < noCol; i++) {
                            html += "<th " + headCellStyle + ">" + rsmd.getColumnName(i + 1) + "</th>\n";
                        }
                        html += headAddi;
                        html += "</tr>\n";
                        // create rows
                        while (rst.next()) {
                            html += "<tr " + rowStyle + ">";
                            for (int i = 0; i < noCol; i++) {
                                if (isAcct != 0 && i + 1 == isAcct) {
                                    html += "<td " + rowCellStyle + ">" + decodeAccountType(rst.getString(i + 1)) + "</td>\n";
                                } else if (isStat != 0 && i + 1 == isStat) {
                                    html += "<td " + rowCellStyle + ">" + decodeAccountStatus(rst.getString(i + 1)) + "</td>\n";
                                } else {
                                    html += "<td " + rowCellStyle + ">" + rst.getString(i + 1) + "</td>\n";
                                }
                            }
                            html += rowAddi;
                            html += "</tr>\n";
                        }
                        break;
                    case "Headless":
                        // create rows
                        while (rst.next()) {
                            html += "<tr " + rowStyle + ">";
                            for (int i = 0; i < noCol; i++) {
                                if (isAcct != 0 && i + 1 == isAcct) {
                                    html += "<td " + rowCellStyle + ">" + decodeAccountType(rst.getString(i + 1)) + "</td>\n";
                                } else if (isStat != 0 && i + 1 == isStat) {
                                    html += "<td " + rowCellStyle + ">" + decodeAccountStatus(rst.getString(i + 1)) + "</td>\n";
                                } else {
                                    html += "<td " + rowCellStyle + ">" + rst.getString(i + 1) + "</td>\n";
                                }
                            }
                            html += rowAddi;
                            html += "</tr>\n";
                        }
                        break;
                }
                output = closeDB();
                return html;
            } catch (Exception e) {
                return e.getMessage();
            }
        } else {
            return output;
        }
    }

//    public String viewAccounts(String trStyle, String tdStyle, String buttonStyle) {
//        String html = "";
//        String output = openDB();
//        if (output.equals("OPEN")) {
//            try {
//                String sql = "SELECT AcctID, FName, LName, AcctType, Username, CreationDate FROM accounts WHERE AcctStatus = 1 ORDER BY LName, FName;";
//                rst = stm.executeQuery(sql);  // execute sql query - results in rst
//                rsmd = rst.getMetaData();           // } Get column count
//                int noCol = rsmd.getColumnCount();  // |
//
//                while (rst.next()) {
//                    html += "<tr class='" + trStyle + "'>";
//
//                    for (int i = 1; i <= noCol; i++) {
//                        html += "<td class='" + tdStyle + "'>";
//                        html += rst.getString(i);
//                        html += "</td>";
//                        html += "<input type='submit' value='Modify' class='" + buttonStyle + "', name='" + rst.getString(1) + "'/>";
//
//                    }
//
//                    html += "</tr>";
//                }
//                output = closeDB();
//                return html;
//            } catch (Exception e) {
//                return e.getMessage();
//            }
//        } else {
//            return output;
//        }
//    }
    public String viewAccounts(String trStyle, String tdStyle, String buttonStyle) {
        String html = "";
        String output = openDB();
        if (output.equals("OPEN")) {
            try {
                String sql = "SELECT AcctID, FName, LName, AcctType, Username, Email, Phone, CreationDate FROM accounts WHERE AcctStatus = 1 ORDER BY AcctType, FName, LName, CreationDate;";
                rst = stm.executeQuery(sql);  // execute sql query - results in rst
                rsmd = rst.getMetaData();           // } Get column count
                int noCol = rsmd.getColumnCount();  // |
                /*
                    // Potential error text if no results are 
                    html += "<tr class='" + trStyle + "'>";
                    html += "<td class='" + tdStyle + "'>";
                    html += "No entries to display!";
                    html += "</td></tr>";
                 */

                while (rst.next()) {
                    html += "<tr class='" + trStyle + "'>";
                    // Fill columns
                    for (int i = 0; i < noCol ; i++) {

                        html += "<td class='" + tdStyle + "'>";
                        if (i == 3) {
                            html += decodeAccountType(rst.getString(i + 1));
                        } else {
                            html += rst.getString(i + 1);
                        }
                        html += "</td>";
                    }
                    // Add Action Buttons - 
                    //Button name is "M#" where # is the account ID.
                    //  noCol is the column where AcctID may be found
                    html += "<td " + tdStyle + ">";
                    html += "<input type='submit' value='Details' class='" + buttonStyle + "', name='M" + rst.getString(1) + "'/>";
                    html += "</td>";

                    html += "</tr>";
                }

                output = closeDB();
                return html;

            } catch (Exception e) {
                return e.getMessage();
            }
        } else {
            return output;
        }
    }

    /**
     *
     * @param trStyle row style
     * @param tdStyle cell style
     * @param buttonStyle button style
     * @return headless html table of account requests
     */
    public String viewAccountRequests(String trStyle, String tdStyle, String buttonStyle) {
        String html = "";
        String output = openDB();
        if (output.equals("OPEN")) {
            try {
                String sql = "SELECT FName, LName, Email, Phone, AcctType, AcctID FROM accounts WHERE AcctStatus = 0 ORDER BY CreationDate;";
                rst = stm.executeQuery(sql);  // execute sql query - results in rst
                rsmd = rst.getMetaData();           // } Get column count
                int noCol = rsmd.getColumnCount();  // |
                /*
                    // Potential error text if no results are 
                    html += "<tr class='" + trStyle + "'>";
                    html += "<td class='" + tdStyle + "'>";
                    html += "No entries to display!";
                    html += "</td></tr>";
                 */

                while (rst.next()) {
                    html += "<tr class='" + trStyle + "'>";
                    // Fill columns
                    for (int i = 0; i < noCol - 1; i++) {

                        html += "<td class='" + tdStyle + "'>";
                        if (i == 4) {
                            html += decodeAccountType(rst.getString(i + 1));
                        } else {
                            html += rst.getString(i + 1);
                        }
                        html += "</td>";
                    }
                    // Add Action Buttons - Button name is "A-RequestID" or "D-RequestID"
                    html += "<td " + tdStyle + ">";
                    html += "<input type='submit' value='Accept' class='" + buttonStyle + "', name='A" + rst.getString(noCol) + "'/>";
                    html += "</td>";

                    html += "<td " + tdStyle + ">";
                    html += "<input type='submit' value='Reject' class='" + buttonStyle + "',name='R" + rst.getString(noCol) + "'/>";
                    html += "</td>";

                    html += "</tr>";
                }

                output = closeDB();
                return html;

            } catch (Exception e) {
                return e.getMessage();
            }
        } else {
            return output;
        }
    }

    /**
     * @param ledger // ledger ID
     * @param ledgerType // ledger type: checking, savings, credit, loan
     * @return html // html code for ledger widget
     */
    public String ledgerWidget(String ledger, String ledgerType) {
        String html = "";
        String[] values = {" ", " ", " ", " "};
        String[] titles = {"Title", "Balance:", "Interest:", "Card # ", "Payment Due Date:"};

        // populate values and titles based on account type and database output
        try {
            switch (ledgerType) {
                case "checking":
                    values = queryDB("SELECT Balance, Interest FROM checking WHERE CheckingID = ?;", ledger);
                    titles[0] = "Checking Account # " + ledger;
                    break;
                case "savings":
                    values = queryDB("SELECT Balance, Interest FROM savings WHERE SavingsID = ?;", ledger);
                    titles[0] = "Savings Account # " + ledger;
                    break;
                case "credit":
                    values = queryDB("SELECT Balance, APR, CardNumber, DueDate FROM credit WHERE CreditID = ?;", ledger);
                    titles[0] = "Credit Account # " + ledger;
                    titles[2] = "APR:";
                    break;
                case "loan":
                    values = queryDB("SELECT Balance, APR, Principal, DueDate FROM loans WHERE LoanID = ?;", ledger);
                    titles[0] = "Loan Account # " + ledger;
                    titles[2] = "APR:";
                    titles[3] = "Principal:";
                    break;
                default:
                    break;
            }

            html += "                    <div class=\"w3-container w3-teal\">\n"
                    + "                        <h2> " + titles[0] + "</h2>\n"
                    + "                    </div>\n"
                    + "                    <div class=\"w3-container\">\n"
                    + "                        <table class=\"w3-table\">\n";

            System.out.println(values.length);
            for (int i = 0; i < values.length; i++) {
                if (!values[i].equals(" ")) {
                    System.out.println(ledger + " " + ledgerType + i);

                    html += ("<tr> <td>" + titles[i + 1] + "</td> <td>");

                    //TODO FIX FORMATTING
                    switch (i) {
                        default:
                            break;
                        case 0: // balance
                            html += "$";
                            html += String.format("%.2f", Double.parseDouble(values[i]));
                            break;
                        case 1: // interest
                            html += String.format("%.2f", Double.parseDouble(values[i]));
                            html += "%";
                            break;
                        case 2: // principal or card number
                            switch (ledgerType) {
                                case "credit":
                                    html += values[i];
                                    break;
                                case "loan":
                                    html += "$";
                                    html += String.format("%.2f", Double.parseDouble(values[i]));
                                    break;
                                default:
                                    break;
                            }
                            break;
                    }

                    html += "</td> </tr>";
                }
            }

            html += "                        </table>\n"
                    + "                    </div>";
            return html;
        } catch (Exception e) {
            html = e.getMessage();
            if (html != null) {
                System.out.println("Error in ledgerWidget: " + html);
            }
            return "";
        }
    }

// Validate login credentials
    public String[] loginCred() {
        String[] result = {""};
        return result;
    }

    /**
     *
     * @param sql
     * @param user
     * @param pwd
     * @return
     */
    //Method to verify password. Avoids SQL injection
    public String[] isPwdValid(String sql, String user, String pwd) {
        String message = openDB();
        if (message.equals("Opened")) {
            try {
                pstm = conn.prepareStatement(sql);
                pstm.setString(1, user);
                pstm.setString(2, pwd);
                rst = pstm.executeQuery();
                rsmd = rst.getMetaData();
                int count = rsmd.getColumnCount();
                String[] result = new String[count];
                int records = 0;
                while (rst.next()) {
                    records++;
                    for (int i = 0; i < count; i++) {
                        result[i] = rst.getString(i + 1);
                    }
                }
                closeDB();
                if (records == 0) {
                    result[0] = "Error: Invalid Credentials";
                }
                return result;
            } catch (Exception e) {
                String[] result = new String[1];
                result[0] = "Error: " + e.getMessage();
                return result;
            }
        } else {
            String[] result = new String[1];
            result[0] = "Error: " + message;
            return result;
        }
    }

    /**
     *
     * @param input input values
     * @return String[]
     */
    public String[] queryDB(String... input) {
        System.out.println("Begin Query DB");
        String out = openDB(); // open the database connection
        System.out.println("Opened DB");

        if (out.equals("OPEN")) {
            System.out.println("DB Open");
            try {
                int noArgs = input.length;

                pstm = conn.prepareStatement(input[0]);
                System.out.println(pstm);
                for (int i = 1; i < noArgs; i++) {
                    pstm.setString(i, input[i]);
                }
                System.out.println(pstm);

                rst = pstm.executeQuery(); // Execute query

                rsmd = rst.getMetaData(); // get result metadata

                int noCol = rsmd.getColumnCount();  // construct output array
                String[] output = new String[noCol];

                int records = 0;
                // While there are records available...
                while (rst.next()) {
                    // count the number of records
                    records++;
                    // Insert record into output array
                    for (int i = 0; i < noCol; i++) {
                        output[i] = rst.getString(i + 1);
                    }
                }
                closeDB(); // close the database connection

                // Error if no records are found
                if (records == 0) {
                    output[0] = "Error: No records found";
                }

                return output;

            } catch (Exception e) {
                // SQL Failure
                String[] output = new String[1];
                output[0] = "ERROR: " + e.getMessage();
                return output;
            }
        } else {
            // DB Connection Failure
            String[] output = {""};
            output[0] = "ERROR: " + out;
            return output;
        }
    }

    /**
     *
     * @param input
     * @return
     */
    // Modify the database with an SQL statement
    public String updateDB(String... input) {
        String out = openDB();  // connect to database
        // if connection is successful
        if (out.equals("OPEN")) {
            // try to execute the sql statement
            System.out.println("DB Open");
            try {
                int noArgs = input.length;
                pstm = conn.prepareStatement(input[0]);

                System.out.println(pstm);

                for (int i = 1; i < noArgs; i++) {
                    pstm.setString(i, input[i]);
                }
                System.out.println(pstm);

                pstm.executeUpdate(); // Execute query
                out = closeDB();

            } catch (Exception e) {
                out = e.getMessage(); // get error message if sql fails
            }
        }
        return out;
    }

}
