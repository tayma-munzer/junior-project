<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class types extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        
        DB::table('services_types')->insert([
            'type'=>'قسم اللغويات',
            't_icon'=>'Icons.language',
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
            't_icon'=>'Icons.computer',
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
            't_icon'=>'Icons.brush',
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
            't_icon'=>'Icons.data_usage',
        ]);
        DB::table('secondry_type')->insert([
            't_id'=>'4',
            'sec_type'=>'تخزين بيانات اكسل',
        ]);
        DB::table('services_types')->insert([
            'type'=>'قسم هندسة العمارة',
            't_icon'=>'Icons.apartment',
        ]);
        DB::table('services_types')->insert([
            'type'=>'قسم التسويق',
            't_icon'=>'Icons.business',
        ]);
    }
}
