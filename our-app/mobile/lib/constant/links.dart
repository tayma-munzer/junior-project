//const URL = "http://192.168.1.13:8000/api/";
const URL = "http://10.0.2.2:8000/api/";
const login = URL + "login"; // تسجيل الدخول لمستخدم لديه حساب
const services_first_type =
    URL + "getfirst_type"; //get بجيب كل الانواع الاولية ,هاد نوعو
const services_second_type =
    URL + "getsec_type"; // بجيب الانواع الثانوية التابعة لنوع اولي محدد
const get_all_services_second_types =
    URL + "getsec_types"; //get بجيب كل الانواع الثانوية ,هاد نوعو
const add_service = URL + "addservice"; // اضافة خدمة
const add_alt_service = URL + "addalt_service"; // اضافة خدمة ملحقة لخدمة اساسية
const add_job = URL + "addjob"; // اضافة فرصة عمل
const get_secondry_type_services =
    URL + "get_type_services"; // بجيب كلشي خدمات تابعة لنوع ثانوي محدد
const add_service_discount = URL + "add_discount"; // اضافة تخفيض على سعر الخدمة
const edit_service_discount =
    URL + "edit_discount"; // تعديل التخفيض على سعر الخدمة
const delete_discount = URL + "delete_discount"; // حذف تخفيض على سعر الخدمة
const edit_profile = URL + "edit_profile"; //تعديل المعلومات الشخصية للمستخدم
const add_course = URL + "add_course"; //اضافة كورس
const add_media = URL + "add_media"; // اضافة فيديو لكورس محدد
const add_main_cv = URL + "add_cv"; // اضافة معلومات اساسية للسيرة الذاتية
const add_cv_skills = URL + "add_skills"; // اضافة مهارة للسيرة الذاتية
const add_cv_language = URL + "add_language"; //اضافة لغة للسيرة الذاتية
const add_cv_projects = URL + "add_projects"; // اذافة مشروع للسيرة الذاتية
const add_cv_exp = URL + "add_exp"; //اضافة خبرة للسيرة الذاتية
const add_cv_training_courses =
    URL + "add_training_courses"; // اضافة دورات تدريبية للسيرة الذاتية
const add_cv_education = URL + "add_education"; //اضافة تعلم للسيرة الذاتية
const edit_job = URL + "edit_job"; //تعديل تفاصيل فرصة عمل
const edit_media = URL + "edit_media"; // تعديل تفاصيل فيديو تابع لكورس
const edit_service = URL + "edit_service"; // تعديل تفاصيل خدمة
const edit_cv = URL + "edit_cv"; // تعديل تفاصيل السيرة الذاتية
const delete_job = URL + "delete_job"; // حذف فرصة عمل
const delete_service = URL + "delete_service"; // حذف خدمة
const delete_media = URL + "delete_media"; //حذف فيديو تابع لكورس
const get_all_jobs = URL + "get_all_jobs"; // get بجيب كل فرص العمل . نوعو
const get_job = URL + "get_job"; //بجيب فرصة عمل معينة
const get_media = URL + "get_media"; // بجيب فيديو معين
const get_all_media = URL + "get_all_media"; // بجيب كل الفيديويهات لكورس محدد
const get_service = URL + "get_service"; // بجيب خدمة معينة
const get_all_cv =
    URL + "get_all_cv"; //بجيب السيرة الذاتية كاملة مع كلشي تابع الها
const delete_all_cv =
    URL + "delete_all_cv"; //بيحذف السيرة الذاتية كاملة مع كلشي تابع الها
const get_cv_projects =
    URL + "get_cv_projects"; // بجيب المشاريع يلي بقلب السيرة الذاتية
const get_cv_languages =
    URL + "get_cv_languages"; //بجيب اللغات يلي بقلب السيرة الذاتية
const get_cv_skills =
    URL + "get_cv_skills"; // بجيب المهارات يلي بقلب السيرة الذاتية
const get_all_alt_services =
    URL + "get_all_alt_services"; // بجيب كل الخدمات الملحقة التابعة لخدمة ميعنة
const delete_project = URL + "delete_project"; //حذف مشروع من سيرة ذاتية
const _cv_language = URL + "delete_cv_language"; // حذف لغة من سيرة ذاتية
const delete_skill = URL + "delete_skill"; // حذف مهارة من سيرة ذاتية
const delete_alt_service =
    URL + "delete_alt_service"; // حذف خدمة ملحقة لخدمة معينة
const edit_experience =
    URL + "edit_experience"; // تعديل خبرة معينة بالسيرة الذاتية
const edit_projects = URL + "edit_projects"; //تعديل مشروع بالسيرة الذاتية
const edit_language = URL + "edit_language"; //تعديل لغة بالسيرة الذاتية
const edit_skills = URL + "edit_skills"; //تعديل مهارة بالسيرة الذاتية
const edit_alt_service =
    URL + "edit_alt_service"; // تعديل خدمة ملحقة بالسيرة الذاتية
const get_all_languages = URL + "getlanguages"; // get بجيب كل اللغات , هاد نوعو
const edit_course = URL + "edit_course";
const delete_course = URL + "delete_course";
const get_course = URL + "get_course";
const edit_training_courses = URL + "edit_training_courses";
const delete_training_courses = URL + "delete_training_courses";
const get_training_course = URL + "get_training_courses";
const edit_education = URL + "edit_education";
const delete_education = URL + "delete_education";
const get_education = URL + "get_education";
const delete_exp = URL + "delete_exp";
const get_exp = URL + "get_exp";
const get_user_jobs = URL + "get_user_jobs";
const get_course_types = URL + "get_course_types"; //بيرجع انواع الكورسات
const get_course_detils = URL +
    'get_course_detils'; // بيرجع تفاصيل الكورس من جدول الكورسات حسب رقم الكورس
const get_courses_for_type =
    URL + 'get_courses_for_type'; // بيرجع الكورسات لنوع معين
const get_course_for_user =
    URL + 'get_course_for_user'; // بيرجع كورسات حسب اليوزر

const get_skill = URL + "get_skill"; //بجيب المهارة عن طريق ال s_id
const get_project = URL + "get_project";
const get_cv_lang = URL + "get_cv_lang";
const get_profile = URL + "get_profile";
const get_home_page_services = URL + "get_home_page_services";
const get_home_page_jobs = URL + "get_home_page_jobs";
const get_home_page_courses = URL + "get_home_page_courses";
const test_add_media = URL + "test_add_media";
const test_get_media = URL + "test_get_media";
const add_course_rating = URL + "add_course_rating";
const add_job_rating = URL + "add_job_rating";
const add_service_rating = URL + "add_service_rating";
const add_training_courses_rating = URL + "add_training_courses_rating";
const add_service_enrollment = URL + "add_service_enrollment";
const get_user_services = URL + "get_user_services";
const add_not_found_service = URL + "add_not_found_service";
const register = URL + "register";
const get_common_questions = URL + "get_common_questions";
const edit_work = URL + "edit_work";
const delete_work = URL + "delete_work";

const switch_account = URL + "switch_account";
const logout = URL + "logout";
const delete_account = URL + "delete_account"; // حذف المستخدم الحساب بنفسه
const get_profiles = URL + "get_profiles"; //جلب بروفايلات المتسخدمين
const get_complaints = URL + "get_complaints";
const get_profits = URL + "get_profits"; // مراقبة ارباح الخدمات
const get_service_requests =
    URL + "get_service_requests"; //بيجيب الخدمات  يلي حالتها pindding
const add_job_complaint = URL + "add_job_complaint";
const add_service_complaint = URL + "add_service_complaint";
const add_course_complaint = URL + "add_course_complaint";

int? id;
var accept_course =
    URL + "accept_course /${id}"; //الموافقة على كورس من قبل الادمن
var reject_course = URL + "reject_course /${id}"; // رفض الكورس من قبل الادمن
var accept_service = URL + "accept_service /${id}";
var reject_service = URL + "reject_service /${id}";
var accept_job = URL + "accept_job/${id}";
var reject_job = URL + "reject_job/${id}";
var delete_user = URL + "delete_user/${id}"; // حذف الحساب من قبل الادمن
var get_courses_count = URL + "get_courses_count/${id}";
var get_services_count = URL + "get_services_count/${id}";
var get_jobs_count = URL + "get_jobs_count/${id}";
var get_service_user = URL + "get_service_user/${id}";
var get_course_user = URL + "get_course_user/${id}";
var get_job_user = URL + "get_job_user/${id}";

var delete_coursee = URL + "delete_coursee/${id}";
var delete_jobb = URL + "delete_jobb/${id}";
var delete_servicee = URL + "delete_servicee/${id}";

const delete_cv_language = URL + "delete_cv_language";
const add_course_enrollment = URL + "add_course_enrollment";
const is_user_course_enrolled = URL + "is_user_course_enrolled";
const get_preservations = URL + "get_preservations";
const get_job_types = URL + "get_job_types";

const get_my_courses = URL + "get_my_courses";
const get_my_jobs = URL + "get_my_jobs";
const get_my_services = URL + "get_my_services";
const get_my_services_enrollments = URL + "get_my_services_enrollments";
const get_my_courses_enrollments = URL + "get_my_courses_enrollments";
const job_filter = URL + "job_filter";
