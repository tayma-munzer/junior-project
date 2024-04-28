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
            'u_img' => 'assets/profile.jpg',
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
            'u_img' => 'assets/profile.jpg',
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
                's_img'=>'null.png',
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
                's_img'=>'null.png',
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
                's_img'=>'null.png',
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
                's_img'=>'null.png',
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
                's_img'=>'null.png',
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
                's_img'=>'null.png',
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
                's_img'=>'null.png',
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
                's_img'=>'null.png',
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
                's_img'=>'null.png',
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
                's_img'=>'null.png',
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


    }
}
