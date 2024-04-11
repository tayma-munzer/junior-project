<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class skills extends Model
{
    use HasFactory;
    protected $table = 'skills';
    public $timestamps = false;
    protected $fillable = [
        'cv_id',
        's_name',
        's_level',
        'years_of_exp',
    ];
}
