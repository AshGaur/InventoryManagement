# InventoryManagement
An inventory/store management system to handle billing and monitor product in and out of the inventory. Also allows different access privileges to staff and owner using cookie sessions. 

J2EE Project with Cookie session management.
Access privileges for webpages/url checked through cookie and userid.
MySQL database equipped.
JSP and Servlets bulilt application with billing System on Issue Product.jsp.

Home Page/index.jsp : Login Page, with cookie check which redirects user to login home page that is Owner Home or staff home depending on the Usertype.
On successful Login,
User Directed to homeOwner.jsp/Staffhome.jsp.
If cookie not found, and url is accessed then the user is automatically redirected to the login page/index.jsp.

The HomeOwner.jsp Page consists of links to various features of the application:
1. Manage Staff
2. Manage Products
3. Issue Product
4. Add Staff
5. Add Product
6. Signout

The StaffHome page consists of links:
1. Manage Products
2. Issue Product
3. Add Product
4. Signout

Owner updated with a feature to kickoff a connected staff on the portal and sign him out just by one click.
Quantity check and validations updated for billing
Successfully deployed on AWS Beanstalk with successful JDBC connection with AWS RDS.
