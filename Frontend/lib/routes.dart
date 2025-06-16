import 'package:get/get.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/middleware/mymiddleware.dart';
// import 'package:tasknotate/core/middleware/mymiddleware.dart';
import 'package:tasknotate/view/screen/auth/forgetpassword/forget_password.dart';
import 'package:tasknotate/view/screen/auth/forgetpassword/reset_password.dart';
import 'package:tasknotate/view/screen/auth/forgetpassword/success_password_reset.dart';
import 'package:tasknotate/view/screen/auth/forgetpassword/verify_code_password.dart';
import 'package:tasknotate/view/screen/auth/login.dart';
import 'package:tasknotate/view/screen/auth/signup.dart';
import 'package:tasknotate/view/screen/auth/signupcheck/success_sign_up.dart';
import 'package:tasknotate/view/screen/auth/signupcheck/verify_code_sign_up.dart';
import 'package:tasknotate/view/screen/company/manager/company/create_company.dart';
import 'package:tasknotate/view/screen/company/employee/homeemployee/employee_home.dart';
// import 'package:tasknotate/view/screen/company/manager/task/viewtaskcompany.dart';
import 'package:tasknotate/view/screen/company/manager/company/view_company_details_manager.dart';
import 'package:tasknotate/view/screen/company/manager/homemanager/manager_home.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/workspace.dart';
import 'package:tasknotate/view/screen/company/company_home.dart';
import 'package:tasknotate/view/screen/home_navigator.dart';
import 'package:tasknotate/view/screen/notes/create_note.dart';
// import 'package:tasknotate/view/screen/language.dart';
import 'package:tasknotate/view/screen/notes/view_note.dart';
import 'package:tasknotate/view/screen/onboaring.dart';
import 'package:tasknotate/view/screen/tasks/create_task.dart';
import 'package:tasknotate/view/screen/tasks/update_task.dart';
import 'package:tasknotate/view/screen/tasks/view_task.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/", page: () => const OnBoarding(), middlewares: [Mymiddleware()]),
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.home, page: () => const HomeNavigator()),
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  GetPage(name: AppRoute.signUp, page: () => const Signup()),
  GetPage(name: AppRoute.forgetPassword, page: () => const Forgetpassword()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(name: AppRoute.verifyCode, page: () => const VerifyCodePassword()),
  GetPage(
      name: AppRoute.successReset, page: () => const SuccessPasswordReset()),
  GetPage(name: AppRoute.successSignup, page: () => const SuccessSignup()),
  GetPage(
      name: AppRoute.verifyCodeSignup, page: () => const VerifyCodeSignup()),

  // GetPage(name: "/", page: () => const OnBoarding()),
  GetPage(name: AppRoute.createNote, page: () => const CreateNoteView()),
  GetPage(name: AppRoute.viewNote, page: () => const ViewNote()),
  GetPage(name: AppRoute.createTask, page: () => CreateTask()),
  GetPage(name: AppRoute.viewTask, page: () => const ViewTask()),
  GetPage(name: AppRoute.updatetask, page: () => const UpdateTask()),
  GetPage(name: AppRoute.companyhome, page: () => const CompanyHome()),
  GetPage(name: AppRoute.employeehome, page: () => const EmployeeHome()),
  GetPage(name: AppRoute.managerhome, page: () => const Managerpage()),
  GetPage(name: AppRoute.companycreate, page: () => const CreateCompany()),
  GetPage(name: AppRoute.infocompany, page: () => const ViewCompanyManager()),
  GetPage(name: AppRoute.workspace, page: () => const Workspace()),
];
