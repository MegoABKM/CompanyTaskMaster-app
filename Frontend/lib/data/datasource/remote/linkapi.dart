class AppLink {
  // static const String server =
  //     "http://10.0.2.2:8080/tasknotate"; // will be changed if there is a real host

  static const String server = 'http://192.168.1.112:8080/tasknotate';

  static const String fileUpload = "$server/uploadfile.php";
  static const String profileUpload = "$server/uploadprofilefile.php";
  static const String filedelete = "$server/deletefile.php";
  static const String profiledelete = "$server/deleteprofilefile.php";
  static const String imageStatic = "$server/uploadimage.php";
  static const String imageplaceserver = "$server/upload/images/company/";
  static const String imageprofileplace =
      "$server/upload/files/company/profile/";
  // static const String filePlaceServer = "$server/upload/files/company/";

  // static const String imagescompany = "$imageStatic/company";

  //-----------------------auth--------------------------------//
  static const String signup = "$server/auth/signup.php";
  static const String verifycode = "$server/auth/verifycodesign.php";
  static const String login = "$server/auth/login.php";
  static const String resendverifycode = "$server/auth/resendcode.php";
  static const String signupgoogle = "$server/auth/googlesignup.php";
  static const String checksignupgoogle = "$server/auth/checkgooglesignup.php";

  //-----------------------forgetpassword--------------------------------//

  static const String checkemail = "$server/forgetpassword/checkemail.php";
  static const String verifycoderesetpassword =
      "$server/forgetpassword/verifycoderesetpassword.php";
  static const String resetpassword =
      "$server/forgetpassword/resetpassword.php";

  //========================home==================

  static const String homepage = "$server/home.php";

  // company
  static const String createcompany = "$server/company/createcompany.php";
  static const String deletecompany = "$server/company/deletecompany.php";
  static const String updatecompany = "$server/company/updatecompany.php";
  static const String managercompany = "$server/company/managerhome.php";
  static const String workspace = "$server/company/workspace.php";

  static const String progressbar =
      "$server/company/updateprogressbartasks.php";

  static const String showrequestjoin = "$server/company/showrequestjoin.php";
  static const String acceptrequestjoin =
      "$server/company/acceptrequestjoin.php";
  static const String rejectrequestjoin =
      "$server/company/rejectrequestjoin.php";
  static const String deleteemployeecompany =
      "$server/company/deleteemployee.php";
  static const String viewnotificationmanager =
      "$server/company/viewuserstatustask.php";

  static const String viewprofile = "$server/company/viewprofile.php";
  static const String updateprofile = "$server/company/updateprofile.php";

  //taskcompany
  static const String taskcompany = "$server/taskcompany";

  static const String taskcreatecompany = "$taskcompany/createtaskcompay.php";
  static const String taskdeletecompany = "$taskcompany/deletetaskcompany.php";
  static const String taskupdatecompany = "$taskcompany/updatetaskcompany.php";
  static const String taskviewdetails = "$taskcompany/viewtaskcompany.php";

//taskdetails
  static const String taskcompanydetails = "$server/taskcompanydetails";

  static const String deletefile =
      "$taskcompanydetails/deletefiletaskdatabase.php";
  static const String getfiledata = "$taskcompanydetails/getfiledata.php";
  static const String creatsubtask = "$taskcompanydetails/createsubtask.php";
  static const String updatesubtask = "$taskcompanydetails/updatesubtask.php";
  static const String updatefilename =
      "$taskcompanydetails/updatenamefiletask.php";
  static const String saveattachment =
      "$taskcompanydetails/createattachment.php";

//assignusertotask
  static const String assinguser = "$server/taskassignuser";

  static const String assigntasktoemployee =
      "$assinguser/assignusertotaskcreate.php";
  static const String assigntaskupdateemployee =
      "$assinguser/updateassignusertotask.php";

  //employee home
  static const String employee = "$server/employee";
  static const String empjoinrequest = "$employee/requestjoincompany.php";
  static const String employeehome = "$employee/getemployeecompanydata.php";
  static const String employeeviewtask = "$employee/viewtaskemployee.php";
  static const String employeeInsertUpdateTask =
      "$employee/addandupdatetaskcheck.php";
  static const String workspaceemployee =
      "$server/employee/viewworkspaceemployee.php";
}
