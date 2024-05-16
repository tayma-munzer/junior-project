<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class education extends Model
{
    use HasFactory;
    protected $table = 'education';
    public $timestamps = false;
    protected $fillable = [
        'e_id',
        'cv_id',
        'degree',
        'uni',
        'grad_year',
        'field_of_study',
        'gba',
    ];
}
