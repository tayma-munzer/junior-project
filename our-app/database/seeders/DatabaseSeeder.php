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
    }
}
