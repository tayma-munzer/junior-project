const URL = "http://127.0.0.1:8000/api/";

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
const add_cv = URL + "add_cv"; // اضافة معلومات اساسية للسيرة الذاتية
const add_skills = URL + "add_skills"; // اضافة مهارة للسيرة الذاتية
const add_language = URL + "add_language"; //اضافة لغة للسيرة الذاتية
const add_projects = URL + "add_projects"; // اذافة مشروع للسيرة الذاتية
const add_exp = URL + "add_exp"; //اضافة خبرة للسيرة الذاتية
const add_training_courses =
    URL + "add_training_courses"; // اضافة دورات تدريبية للسيرة الذاتية
const add_education = URL + "add_education"; //اضافة تعلم للسيرة الذاتية
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
