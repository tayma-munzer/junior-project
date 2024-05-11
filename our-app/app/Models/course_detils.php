<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class course_details extends Model
{
    use HasFactory;
    protected $table = 'course_detils';
    public $timestamps = false;
    protected $fillable = [
        'c_id',
        'c_name',
        'c_desc',
        'c_price',
        'c_img',
        'c_duration',
        'pre_requisite',
    ];
}