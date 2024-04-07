<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class cv_lang extends Model
{
    use HasFactory;
    protected $fillable = [
        'cv_id',
        'l_id',
    ];
}
