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