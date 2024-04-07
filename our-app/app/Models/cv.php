<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class cv extends Model
{
    use HasFactory;
    protected $fillable = [
        'career_obj',
        'phone',
        'address',
        'email',
        'u_id',
    ];
}
