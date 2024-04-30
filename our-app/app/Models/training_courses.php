<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class training_courses extends Model
{
    use HasFactory;
    protected $table = 'training_courses';
    public $timestamps = false;
    protected $fillable = [
        'cv_id',
        'course_name',
        'training_center',
        'completion_date',
    ];
}
