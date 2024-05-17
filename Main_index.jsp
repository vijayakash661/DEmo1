<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<html>
<head>
    <title>UrbanFix home page</title>
</head>
<body>
    <h2>UrbanFix - Reported Problems</h2>
    <table>
        <tr>
            <th>Category</th>
            <th>Description</th>
            <th>Location</th>
            <th>Date Reported</th>
        </tr>
        <% 
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/home?useSSL=false";
            String username = "root";
            String password = "Chellam25@yahoo.com";
            
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.jdbc.Driver");

                // Get a connection to the database
                conn = DriverManager.getConnection(url, username, password);

                // SQL query to fetch data from the database
                String sql = "SELECT category, description, location, report_date FROM user_reports";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                // Iterate through the result set and display the data in the table
                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getTimestamp("report_date") %></td>
        </tr>
        <% 
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("sql error " + e);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                out.println("class error " + e);
            } finally {
                try {
                    // Close all resources
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
</body>
</html>
