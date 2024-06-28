<?php

namespace Database\Seeders;

use App\Models\role;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;


class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        //data in role table 
        
        DB::table('roles')->insert([
            'role' => 'صاحب خدمة',
        ]);
        DB::table('roles')->insert([
            'role' => 'صاحب فرصة عمل',
        ]);
        DB::table('roles')->insert([
            'role' => 'مستفيد',
        ]);
        DB::table('roles')->insert([
            'role' => 'ادمن',
        ]);

        //data in preservations table 
        DB::table('preservations')->insert([
            'p_name' => 'دمشق',
        ]);
        DB::table('preservations')->insert([
            'p_name' => 'درعا',
        ]);
        DB::table('preservations')->insert([
            'p_name' => 'حمص',
        ]);
        DB::table('preservations')->insert([
            'p_name' => 'حلب',
        ]);

        //data in user table 
        DB::table('user')->insert([
            'f_name' => 'تيمه',
            'l_name' => 'عبدربه',
            'age' => '21',
            'u_desc' => 'طالبة جامعية',
            'u_img' => 'personal_image.jpg',
            'email' => 'tayma@gmail.com',
            'username' => 'تيمه',
            'password' => '123456',
            'p_id' => '1',
            'gender' => 'انثى',

        ]);
        DB::table('user')->insert([
            'f_name' => 'حلا',
            'l_name' => 'مرعي',
            'age' => '21',
            'u_desc' => 'طالبة جامعية ',
            'u_img' => 'personal_image.jpg',
            'email' => 'hala@gmail.com',
            'username' => 'حلا',
            'password' => '123456',
            'p_id' => '2',
            'gender' => 'انثى',

        ]);

        //data in user_role table 

        DB::table('user_roles')->insert([
            'u_id'=>'1',
            'r_id'=>'2'

        ]);
        DB::table('user_roles')->insert([
            'u_id'=>'2',
            'r_id'=>'1'

        ]);
        DB::table('user_roles')->insert([
            'u_id'=>'1',
            'r_id'=>'3'
        ]);
        DB::table('user_roles')->insert([
            'u_id'=>'1',
            'r_id'=>'1'
        ]);
         
        DB::table('services_types')->insert([
            'type'=>'قسم اللغويات',
            't_icon'=>'translate',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'1',
            'sec_type'=>'لغة عربية',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'1',
            'sec_type'=>'لغة انكليزية',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'1',
            'sec_type'=>'لغة فرنسية',
        ]);
        DB::table('services_types')->insert([
            'type'=>'قسم المعلوماتية',
            't_icon'=>'laptop',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'2',
            'sec_type'=>'وورد بريس',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'2',
            'sec_type'=>'معلوماتية فرعي 2 ',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'3',
            'sec_type'=>'معلوماتية فرعي 3',
        ]);
        DB::table('services_types')->insert([
            'type'=>'قسم تصميم و بصريات',
            't_icon'=>'draw',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'3',
            'sec_type'=>'تصميم مواقع',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'3',
            'sec_type'=>'تصميم لوغو',
        ]);
        DB::table('services_types')->insert([
            'type'=>'قسم البيانات',
            't_icon'=>'database',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'4',
            'sec_type'=>'تخزين بيانات اكسل',
        ]);
        DB::table('services_types')->insert([
            'type'=>'قسم هندسة العمارة',
            't_icon'=>'mdiRulerSquareCompass',
        ]);
        DB::table('services_types')->insert([
            'type'=>'قسم التسويق',
            't_icon'=>'shopping',
        ]);
        DB::table('services')->insert(
            [
                'u_id'=>1,
                's_name'=>'تصميم مواقع الكترونية',
                's_price'=>'500000',
                's_desc'=>' اسرع و افضل التصاميم شعارنا رضى العميل',
                's_duration'=>'شهر واحد',
                'st_id'=>'7',
                's_img'=>'personal_image.jpg',
            ]
        );
        DB::table('services')->insert(
            [
                'u_id'=>1,
                's_name'=>'تصميم مواقع وورد بريس',
                's_price'=>'520000',
                's_desc'=>' اسرع و افضل التصاميم الوورد بريس ',
                's_duration'=>'نصف شهر',
                'st_id'=>'8',
                's_img'=>'personal_image.jpg',
            ]
            );
        DB::table('services')->insert(
            [
                'u_id'=>2,
                's_name'=>'تصميم افضل مواقع ووردبريس ',
                's_price'=>'620000',
                's_desc'=>' اسرع و افضل التصاميم رضى العميل من اولوياتنا ',
                's_duration'=>'شهرين',
                'st_id'=>'8',
                's_img'=>'personal_image.jpg',
            ]
            );
        DB::table('services')->insert(
            [
                'u_id'=>1,
                's_name'=>'تصميم مواقع الكترونية ديناميكية',
                's_price'=>'650000',
                's_desc'=>' اسرع و افضل التصاميم شعارنا رضى العميل',
                's_duration'=>'شهر و نص',
                'st_id'=>'7',
                's_img'=>'personal_image.jpg',
            ]
            );
        DB::table('services')->insert(
            [
                'u_id'=>1,
                's_name'=>'تعليم لغة عربية',
                's_price'=>'75000',
                's_desc'=>'جلسة تعليم قواعد اللغة العربية لكافة المراحل التعليمية',
                's_duration'=>'ساعة و نص',
                'st_id'=>'1',
                's_img'=>'personal_image.jpg',
            ]
            );
        DB::table('services')->insert(
            [
                'u_id'=>2,
                's_name'=>'تعليم لغة عربية تعبير',
                's_price'=>'95000',
                's_desc'=>'جلسة تعليمة كتابة موضوع تعبير',
                's_duration'=>'ساعة و نص',
                'st_id'=>'1',
                's_img'=>'personal_image.jpg',
            ]
            );
        DB::table('services')->insert(
            [
                'u_id'=>1,
                's_name'=>'تعليم قواعد لغة انكيزية',
                's_price'=>'75000',
                's_desc'=>'جلسة تعليم قواعد اللغة الانكليزية لكافة المراحل التعليمية',
                's_duration'=>'ساعة',
                'st_id'=>'2',
                's_img'=>'personal_image.jpg',
            ]
            );
        DB::table('services')->insert(
            [
                'u_id'=>2,
                's_name'=>'تعليم قواعد لغة انكيزية',
                's_price'=>'75000',
                's_desc'=>'جلسة تعليم قواعد اللغة الانكليزية لصف التاسع و البكلوريا',
                's_duration'=>'ساعة',
                'st_id'=>'2',
                's_img'=>'personal_image.jpg',
            ]
            );
        DB::table('services')->insert(
            [
                'u_id'=>1,
                's_name'=>'تعليم قواعد لغة الفرنسية',
                's_price'=>'110000',
                's_desc'=>'جلسة تعليم قواعد اللغة الفرنسية لكافة المراحل التعليمية',
                's_duration'=>'ساعتين',
                'st_id'=>'3',
                's_img'=>'personal_image.jpg',
            ]
            );
        DB::table('services')->insert(
            [
                'u_id'=>2,
                's_name'=>'تعليم قواعد لغة الفرنسية',
                's_price'=>'60000',
                's_desc'=>'جلسة تعليم قواعد اللغة الفرنسية لكافة المراحل التعليمية',
                's_duration'=>'ساعة',
                'st_id'=>'3',
                's_img'=>'personal_image.jpg',
            ]
            );
        DB::table('alt_services')->insert([
            's_id'=>'1',
            'a_name'=>'اضافة دارك كود للموقع',
            'a_price'=>'50000',
            'added_duration'=>'يومين',
        ]);
        DB::table('alt_services')->insert([
            's_id'=>'1',
            'a_name'=>'اضافة داش بوورد',
            'a_price'=>'250000',
            'added_duration'=>'نص شهر',
        ]);
        DB::table('alt_services')->insert([
            's_id'=>'5',
            'a_name'=>'اجراء اختبار في نهاية الجلسة',
            'a_price'=>'10000',
            'added_duration'=>'نصف ساعة',
        ]);
        DB::table('alt_services')->insert([
            's_id'=>'7',
            'a_name'=>'ارسال ملخص للقواعد',
            'a_price'=>'25000',
            'added_duration'=>'ربع ساعة',
        ]);
        DB::table('languages')->insert([
            'language'=>'english',
        ]);
        DB::table('languages')->insert([
            'language'=>'لغة عربية',
        ]);
        DB::table('languages')->insert([
            'language'=>'french',
        ]);
        DB::table('courses')->insert([
            'c_name'=>'1 اسم كورس ',
            'c_desc'=> ' 1 وصف كورس',
            'c_price'=>'100000',
            'c_img'=>  'personal_image.jpg',
            'u_id'=>   '1',
            'c_duration'=>'10',
            'pre_requisite'=>'pr',
            'ct_id'=>'1',
            'num_of_free_videos'=>'1',
            
        ]);
        DB::table('courses')->insert([
            'c_name'=>' 2 اسم كورس ',
            'c_desc'=> 'وصف كورس 2',
            'c_price'=>'100000',
            'c_img'=>  'personal_image.jpg',
            'u_id'=>   '2',
            'c_duration'=>'20',
            'pre_requisite'=>'cs',
            'ct_id'=>'2',
            'num_of_free_videos'=>'0',
        ]);
        DB::table('courses')->insert([
            'c_name'=>'اسم كورس 3',
            'c_desc'=> 'وصف كورس 3',
            'c_price'=>'100000',
            'c_img'=>  'personal_image.jpg',
            'u_id'=>   '2',
            'c_duration'=>'30',
            'pre_requisite'=>'lc',
            'ct_id'=>'3',
            'num_of_free_videos'=>'0',
        ]);
        DB::table('courses')->insert([
            'c_name'=>'اسم كورس 4',
            'c_desc'=> 'وصف كورس 4',
            'c_price'=>'100000',
            'c_img'=>  'personal_image.jpg',
            'u_id'=>   '1',
            'c_duration'=>'40',
            'pre_requisite'=>'cl',
            'ct_id'=>'4',
            'num_of_free_videos'=>'0',
            ]);
            DB::table('courses')->insert([
                'c_name'=>'5 اسم كورس ',
                'c_desc'=> ' 5 وصف كورس',
                'c_price'=>'100000',
                'c_img'=>  'personal_image.jpg',
                'u_id'=>   '1',
                'c_duration'=>'10',
                'pre_requisite'=>'pr',
                'ct_id'=>'1',
                'num_of_free_videos'=>'0',
            ]);
            DB::table('courses')->insert([
            'c_name'=>'6 اسم كورس ',
            'c_desc'=> ' 6 وصف كورس',
            'c_price'=>'100000',
            'c_img'=>  'personal_image.jpg',
            'u_id'=>   '1',
            'c_duration'=>'10',
            'pre_requisite'=>'pr',
            'ct_id'=>'1',
            'num_of_free_videos'=>'0',
        ]);
        DB::table('courses')->insert([
            'c_name'=>'7 اسم كورس ',
            'c_desc'=> ' 7 وصف كورس',
            'c_price'=>'100000',
            'c_img'=>  'personal_image.jpg',
            'u_id'=>   '1',
            'c_duration'=>'10',
            'pre_requisite'=>'pr',
            'ct_id'=>'2',
            'num_of_free_videos'=>'0',
        ]);
        DB::table('courses')->insert([
            'c_name'=>'8 اسم كورس ',
            'c_desc'=> ' 8 وصف كورس',
            'c_price'=>'100000',
            'c_img'=>  'personal_image.jpg',
            'u_id'=>   '1',
            'c_duration'=>'10',
            'pre_requisite'=>'pr',
            'ct_id'=>'2',
            'num_of_free_videos'=>'0',
        ]);
        DB::table('courses')->insert([
            'c_name'=>'9 اسم كورس ',
            'c_desc'=> ' 9 وصف كورس',
            'c_price'=>'100000',
            'c_img'=>  'personal_image.jpg',
            'u_id'=>   '1',
            'c_duration'=>'10',
            'pre_requisite'=>'pr',
            'ct_id'=>'3',
            'num_of_free_videos'=>'0',
        ]);
        DB::table('jobs')->insert([
            'j_name'=>'اسم الوظيفة 1',
            'j_desc'=>'وصف الوظيفة 1',
            'j_sal'=>'2000000',
            'j_req'=>'متطليات الوظيفة 1',
            'u_id'=>'1'
        ]);
        DB::table('jobs')->insert([
            'j_name'=>'اسم الوظيفة 2',
            'j_desc'=>'وصف الوظيفة 2',
            'j_sal'=>'3000000',
            'j_req'=>'متطليات الوظيفة 2',
            'u_id'=>'1'
        ]);
        DB::table('jobs')->insert([
            'j_name'=>'اسم الوظيفة 3',
            'j_desc'=>'وصف الوظيفة 3',
            'j_sal'=>'1500000',
            'j_req'=>'متطليات الوظيفة 3',
            'u_id'=>'2'
        ]);
        DB::table('jobs')->insert([
            'j_name'=>'اسم الوظيفة 4',
            'j_desc'=>'وصف الوظيفة 4',
            'j_sal'=>'3500000',
            'j_req'=>'متطليات الوظيفة 4',
            'u_id'=>'1'
        ]);
        DB::table('jobs')->insert([
            'j_name'=>'اسم الوظيفة 5',
            'j_desc'=>'وصف الوظيفة 5',
            'j_sal'=>'4500000',
            'j_req'=>'متطليات الوظيفة 5',
            'u_id'=>'2'
        ]);
        DB::table('cv')->insert([
            'career_obj'=>'هددف وظيفي محدد',
            'phone'=>'0912345678',
            'address'=>'دمشق الميدان',
            'email'=>'tayma2@gmail.com',
            'u_id'=>'1',
        ]);
        DB::table('skills')->insert([
            'cv_id'=>'1',
            's_name'=>'مهارة 1',
            's_level'=>'متوسط',
            'years_of_exp'=>'1'
        ]);
        DB::table('skills')->insert([
            'cv_id'=>'1',
            's_name'=>'مهارة 2',
            's_level'=>'ممتاز',
            'years_of_exp'=>'3'
        ]);
        DB::table('training_courses')->insert([
            'cv_id'=>'1',
            'completion_date'=>'2024-4-1',
            'course_name'=>'كورس 1 ',
            'training_center'=>'مركز تدريب 1'
        ]);
        DB::table('training_courses')->insert([
            'cv_id'=>'1',
            'completion_date'=>'2024-5-1',
            'course_name'=>'كورس 2 ',
            'training_center'=>'مركز تدريب 11'
        ]);
        DB::table('experiences')->insert([
            'cv_id'=>'1',
            'position'=>'مسمى وظيفي 1',
            'company'=>'شركة 1',
            'start_date'=>'2024-1-1',
            'end_date'=>'2024-5-5',
            'responsibilities'=>'مسؤوليات كزا و كزا'
        ]);
        DB::table('experiences')->insert([
            'cv_id'=>'1',
            'position'=>'موقع وظيفي 2',
            'company'=>'شركة 1',
            'start_date'=>'2023-1-1',
            'end_date'=>'2024-1-1',
            'responsibilities'=>'مسؤولية وحدة كزا '
        ]);
        DB::table('projects')->insert([
            'cv_id'=>'1',
            'p_name'=>'اسم مشروع 1',
            'p_desc'=>'وصف مشورع 1',
            'start_date'=>'2023-1-1',
            'end_date'=>'2024-1-1',
            'responsibilities'=>'مسؤولية وحدة كزا '            
        ]);
        DB::table('projects')->insert([
            'cv_id'=>'1',
            'p_name'=>'اسم المشروع 2',
            'p_desc'=>'وصف المشروع 2',
            'start_date'=>'2023-1-1',
            'end_date'=>'2024-1-1',
            'responsibilities'=>'مسؤولية  مشورع 2 '            
        ]);
        DB::table('cv_langs')->insert([
            'cv_id'=>'1',
            'l_id'=>'2'
        ]);
        DB::table('cv_langs')->insert([
            'cv_id'=>'1',
            'l_id'=>'3'
        ]);
        DB::table('education')->insert([
            'cv_id'=>'1',
            'grad_year'=>'2021',
            'degree'=>'باكالورويس',
            'uni'=>'العربية الدولية',
            'field_of_study'=>'معلوماتية',
            'gba'=>'3.2'
        ]);
        DB::table('education')->insert([
            'cv_id'=>'2',
            'grad_year'=>'2023',
            'degree'=>'ماجستير',
            'uni'=>'دمشق',
            'field_of_study'=>'شي بالمعلوماتية',
            'gba'=>'3.2'
        ]);

        DB::table('courses_types')->insert([
            'ct_type'=>'laravel',
            'ct_icon'=>'laptop'
        ]);
        DB::table('courses_types')->insert([
            'ct_type'=>'database',
            'ct_icon'=>'database'
        ]);
        
        DB::table('media')->insert([
            'm_title'=>'add job',
            'm_name'=>'video1.mp4',
            'm_desc'=>'short description about the video',
            'c_id'=>'1'
        ]);
        DB::table('media')->insert([
            'm_title'=>'add service',
            'm_name'=>'video2.mp4',
            'm_desc'=>'short description about the video',
            'c_id'=>'1'
        ]);

        DB::table('media')->insert([
            'm_title'=>'add anything',
            'm_name'=>'video3.mp4',
            'm_desc'=>'short description about the video',
            'c_id'=>'1'
        ]);
        
        DB::table('media')->insert([
            'm_title'=>'add something',
            'm_name'=>'video4.mp4',
            'm_desc'=>'short description about the video',
            'c_id'=>'2'
        ]);

        DB::table('complaints')->insert([
            'description'=>'desc desc 1',
            'u_id'=>'1',
            'complainable_type'=>'App\Models\job',
            'complainable_id'=>'2',
            'created_at'=>'2024-06-28 07:17:14',
            'updated_at'=>'2024-06-28 07:17:14',

        ]);
        DB::table('complaints')->insert([
            'description'=>'desc desc 2',
            'u_id'=>'1',
            'complainable_type'=>'App\Models\job',
            'complainable_id'=>'2',
            'created_at'=>'2024-06-28 07:17:14',
            'updated_at'=>'2024-06-28 07:17:14',
        ]);
        DB::table('complaints')->insert([
            'description'=>'desc desc 3',
            'u_id'=>'2',
            'complainable_type'=>'App\Models\course',
            'complainable_id'=>'1',
            'created_at'=>'2024-06-28 07:17:14',
            'updated_at'=>'2024-06-28 07:17:14',
        ]);

        DB::table('complaints')->insert([
            'description'=>'desc desc 3',
            'u_id'=>'2',
            'complainable_type'=>'App\Models\services',
            'complainable_id'=>'1',
            'created_at'=>'2024-06-28 07:17:14',
            'updated_at'=>'2024-06-28 07:17:14',
        ]);
        

    }
}
