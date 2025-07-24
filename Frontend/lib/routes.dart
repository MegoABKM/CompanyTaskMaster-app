import 'package:companymanagment/bindings/loginbinding/login_binding.dart';
import 'package:companymanagment/bindings/signupbinding/signup_binding.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/view/screen/company/employee/homeemployee/employee_home_navigator.dart';
import 'package:companymanagment/view/screen/company/manager/homemanager/manager_home_navigator.dart';
import 'package:companymanagment/view/screen/language.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/middleware/mymiddleware.dart';
import 'package:companymanagment/view/screen/auth/forgetpassword/forget_password.dart';
import 'package:companymanagment/view/screen/auth/forgetpassword/reset_password.dart';
import 'package:companymanagment/view/screen/auth/forgetpassword/success_password_reset.dart';
import 'package:companymanagment/view/screen/auth/forgetpassword/verify_code_password.dart';
import 'package:companymanagment/view/screen/auth/login.dart';
import 'package:companymanagment/view/screen/auth/signup.dart';
import 'package:companymanagment/view/screen/auth/signupcheck/success_sign_up.dart';
import 'package:companymanagment/view/screen/auth/signupcheck/verify_code_sign_up.dart';
import 'package:companymanagment/view/screen/company/manager/company/create_company.dart';
import 'package:companymanagment/view/screen/company/manager/company/view_company_details_manager.dart';
import 'package:companymanagment/view/screen/company/manager/tasks/workspace.dart';
import 'package:companymanagment/view/screen/company/company_home.dart';
import 'package:companymanagment/view/screen/onboaring.dart';

List<GetPage<dynamic>>? routes = [
  // The initial route is now "/", which points to OnBoarding
  // The middleware will handle redirecting to /language if needed
  GetPage(
      name: "/", page: () => const OnBoarding(), middlewares: [Mymiddleware()]),

  // Define the new language route
  GetPage(name: AppRoute.language, page: () => const Langauge()),

  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  GetPage(
      name: AppRoute.login, page: () => const Login(), binding: LoginBinding()),
  GetPage(
      name: AppRoute.signUp,
      page: () => const Signup(),
      binding: SignupBinding()),
  GetPage(name: AppRoute.forgetPassword, page: () => const Forgetpassword()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(name: AppRoute.verifyCode, page: () => const VerifyCodePassword()),
  GetPage(
      name: AppRoute.successReset, page: () => const SuccessPasswordReset()),
  GetPage(name: AppRoute.successSignup, page: () => const SuccessSignup()),
  GetPage(
      name: AppRoute.verifyCodeSignup, page: () => const VerifyCodeSignup()),
  GetPage(name: AppRoute.companyhome, page: () => const CompanyHome()),
  GetPage(name: AppRoute.companycreate, page: () => const CreateCompany()),
  GetPage(name: AppRoute.infocompany, page: () => const ViewCompanyManager()),
  GetPage(name: AppRoute.workspace, page: () => const Workspace()),

  GetPage(name: AppRoute.managerhome, page: () => const ManagerHomeNavigator()),
  GetPage(
      name: AppRoute.employeehome, page: () => const EmployeeHomeNavigator()),
];
