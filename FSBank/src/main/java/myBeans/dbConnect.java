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

  public String htmlDropdownQuery() {
    return "";
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
                html += "<td " + rowCellStyle + ">" + rst.getString(i + 1) + "</td>\n";
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
                html += "<td " + rowCellStyle + ">" + rst.getString(i + 1) + "</td>\n";
              }
              html += rowAddi;
              html += "</tr>\n";
            }
            break;
        }

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
   * @return headless html table of account requests
   */
  public String viewAccountRequests(String trStyle, String tdStyle) {
    String html = "";
    String output = openDB();
    if (output.equals("OPEN")) {
      try {
        String sql = "SELECT FName, LName, Email, Phone, accountType, ReqID FROM accountreq;";
        rst = stm.executeQuery(sql);  // execute sql query - results in rst
        rsmd = rst.getMetaData();           // } Get column count
        int noCol = rsmd.getColumnCount();  // |

        while (rst.next()) {
          html += "<tr " + trStyle + ">";
          // Fill columns
          for (int i = 0; i < noCol - 1; i++) {

            html += "<td " + tdStyle + ">";
            if (i == 4) {
              // decode account type
              switch (rst.getString(i + 1)) {
                case "0":
                  html += "Suspended";
                  break;
                case "1":
                  html += "Account Holder";
                  break;
                case "2":
                  html += "Clerk";
                  break;
                case "3":
                  html += "Administrator";
                  break;
                default:
                  html += "N/A";
                  break;
              }
            } else {
              html += rst.getString(i + 1);

            }
            html += "</td>";
          }
          // Add Action Buttons - Button name is "A-RequestID" or "D-RequestID"
          html += "<td " + tdStyle + ">";
          html += "<input type='submit' value='Accept' name='A" + rst.getString(noCol) + "'/>";
          html += "</td>";

          html += "<td " + tdStyle + ">";
          html += "<input type='submit' value='Reject' name='R" + rst.getString(noCol) + "'/>";
          html += "</td>";

          html += "</tr>";
        }
        return html;

      } catch (Exception e) {
        return e.getMessage();
      }
    } else {
      return output;
    }
  }

  // Validate login credentials
  public String[] loginCred() {
    String[] result = {""};
    return result;
  }

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
      String[] output = new String[1];
      output[1] = "ERROR: " + out;
      return output;
    }
  }

  /**
   *
   * @param sql SQL statement
   * @return String
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
