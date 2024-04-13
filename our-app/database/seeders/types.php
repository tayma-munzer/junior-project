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
        DB::table('services_types')->insert([
            'type'=>'قسم المعلوماتية',
            't_icon'=>'Icons.computer',
        ]);
        DB::table('services_types')->insert([
            'type'=>'قسم تصميم و بصريات',
            't_icon'=>'Icons.brush',
        ]);
        DB::table('services_types')->insert([
            'type'=>'قسم البيانات',
            't_icon'=>'Icons.data_usage',
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
