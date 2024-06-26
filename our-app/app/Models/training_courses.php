<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class training_courses extends Model
{
    use HasFactory;
    protected $table = 'training_courses';
    protected $primaryKey = 't_id';
    public $timestamps = false;
    protected $fillable = [
        'cv_id',
        'course_name',
        'training_center',
        'completion_date',

    ];

    public function ratings(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(rates_reviews::class, 'ratable');
    }
}
