<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class training_courses extends Model
{
    use HasFactory;
    protected $fillable = [
        'cv_id',
        'course_name',
        'training_ center',
        'completion_date',
    ];
}