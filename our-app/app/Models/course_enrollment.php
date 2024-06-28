<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class course_enrollment extends Model
{
    use HasFactory;
    protected $table = 'course_enrollments';
    public $timestamps = false;
    protected $fillable = [
        'c_id',
        'u_id',
    ];
}
