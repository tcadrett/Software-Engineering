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
  private final String url = "jdbc:mysql://localhost:3306/settleshop";
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
  //Clear non-numerical characters from input phone number.
  public String cleanPhone(String phone) {
    String out = phone.replace("-", "");
    out = out.replace(".", "");
    out = out.replace(" ", "");
    return out;
  }

  public String htmlDropdownQuery() {
    return "";
  }

  public String htmlListQuery() {
    return "";
  }

  public String htmlTableQuery() {
    return "";
  }

  // Validate login credentials
  public String[] loginCred() {
    String[] result = {""};
    return result;
  }

  /**
   *
   * @param input input values
   * @return String[]
   */
  public String[] queryDB(String... input) {
    String out = openDB(); // open the database connection
    if (out.equals("OPEN")) {
      try {
        int noArgs = input.length;
        pstm = conn.prepareStatement(input[0]);
        for (int i = 0; i < noArgs; i++) {
          pstm.setString(i, input[i]);
        }

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
        output[1] = "ERROR: " + e.getMessage();
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
  private String updateDB(String sql) {
    String out = openDB();  // connect to database
    // if connection is successful
    if(out.equals("OPENED")){
      // try to execute the sql statement
      try {
        stm.executeUpdate(sql);
        out = closeDB();
      } catch (Exception e){
        out = e.getMessage(); // get error message if sql fails
      }
    }
    return out;
  }

}
