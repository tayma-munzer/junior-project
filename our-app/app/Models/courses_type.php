<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class courses_type extends Model
{
    use HasFactory;
    protected $table = 'courses_type';
    public $timestamps = false;
    protected $fillable = [
        'ct_id',
        'ct_type',
        'ct_icon' ,
    ];
}