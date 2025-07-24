// lib/data/datasource/remote/linkapi.dart

class AppLink {
  // static const String server =
  //     "http://10.0.2.2:8080/tasknotate"; // For Android Emulator
  static const String server =
      'http://192.168.1.112:8080/tasknotate'; // For physical device

  static const String fileUpload = "$server/uploadfile.php";
  static const String profileUpload = "$server/uploadprofilefile.php";
  static const String filedelete = "$server/deletefile.php";
  static const String profiledelete = "$server/deleteprofilefile.php";
  static const String imageStatic = "$server/uploadimage.php";
  static const String imageplaceserver = "$server/upload/images/company/";
  static const String imageprofileplace =
      "$server/upload/files/company/profile/";

  //----------------------- Auth --------------------------------//
  static const String signup = "$server/auth/signup.php";
  static const String verifycode = "$server/auth/verifycodesign.php";
  static const String login = "$server/auth/login.php";
  static const String resendverifycode = "$server/auth/resendcode.php";
  static const String signupgoogle = "$server/auth/googlesignup.php";
  static const String checksignupgoogle = "$server/auth/checkgooglesignup.php";

  //----------------------- Forget Password --------------------------------//
  static const String checkemail = "$server/forgetpassword/checkemail.php";
  static const String verifycoderesetpassword =
      "$server/forgetpassword/verifycoderesetpassword.php";
  static const String resetpassword =
      "$server/forgetpassword/resetpassword.php";

  //----------------------- Company --------------------------------//
  static const String company = "$server/company";
  static const String createcompany = "$company/createcompany.php";
  static const String deletecompany = "$company/deletecompany.php";
  static const String updatecompany = "$company/updatecompany.php";
  static const String managercompany = "$company/managerhome.php";
  static const String workspace = "$company/workspace.php";
  static const String progressbar = "$company/updateprogressbartasks.php";
  static const String showrequestjoin = "$company/showrequestjoin.php";
  static const String acceptrequestjoin = "$company/acceptrequestjoin.php";
  static const String rejectrequestjoin = "$company/rejectrequestjoin.php";
  static const String deleteemployeecompany = "$company/deleteemployee.php";
  static const String viewnotificationmanager =
      "$company/viewuserstatustask.php";
  static const String viewprofile = "$company/viewprofile.php";
  static const String updateprofile = "$company/updateprofile.php";
  static const String nudgeEmployee = "$company/nudge_employee.php";

  //----------------------- Task Company --------------------------------//
  static const String taskcompany = "$server/taskcompany";
  static const String taskcreatecompany = "$taskcompany/createtaskcompay.php";
  static const String taskdeletecompany = "$taskcompany/deletetaskcompany.php";
  static const String taskupdatecompany = "$taskcompany/updatetaskcompany.php";
  static const String taskviewdetails = "$taskcompany/viewtaskcompany.php";

  //----------------------- Task Details --------------------------------//
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
  static const String assignToSprint =
      "$taskcompanydetails/tasks/assign_to_sprint.php";

  //----------------------- Assign User to Task --------------------------------//
  static const String assinguser = "$server/taskassignuser";
  static const String assigntasktoemployee =
      "$assinguser/assignusertotaskcreate.php";
  static const String assigntaskupdateemployee =
      "$assinguser/updateassignusertotask.php";

  //----------------------- Employee --------------------------------//
  static const String employee = "$server/employee";
  static const String empjoinrequest = "$employee/requestjoincompany.php";
  static const String employeehome = "$employee/getemployeecompanydata.php";
  static const String employeeviewtask = "$employee/viewtaskemployee.php";
  static const String employeeInsertUpdateTask =
      "$employee/addandupdatetaskcheck.php";
  static const String workspaceemployee = "$employee/viewworkspaceemployee.php";

  //----------------------- Projects --------------------------------//
  static const String projects = "$server/projects";
  static const String projectcreate = "$projects/create.php";
  static const String projectgetall = "$projects/get_all.php";
  static const String getProjectWorkspace = "$projects/get_workspace.php";
  static const String getProjectBacklog = "$projects/get_backlog.php";
  static const String assignToProject = "$projects/assign_employees.php";
  static const String projectUpdate = "$projects/update.php";
  static const String projectDelete = "$projects/delete.php";
  static const String projectUpdateStatus = "$projects/update_status.php";

  //----------------------- Sprints --------------------------------//
  static const String sprints = "$server/sprints";
  static const String sprintcreate = "$sprints/create.php";
  static const String sprintUpdate = "$sprints/update.php";
  static const String sprintUpdateStatus = "$sprints/update_status.php";
  static const String sprintDelete = "$sprints/delete.php";
  static const String sprintUpdateTasks = "$sprints/update_tasks.php";

  // --- NEW: Finance Endpoints ---
  static const String finances = "$server/finances";
  static const String financeAddEntry = "$finances/add_entry.php";
  static const String financeGetSummary = "$finances/get_summary.php";
  static const String financeGetProjectDetails =
      "$finances/get_project_details.php";
  static const String financeDeleteEntry = "$finances/delete_entry.php";
  static const String financeUpdateEntry = "$finances/update_entry.php";
}
