<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class user extends Model
{
    use HasFactory;
    protected $table = 'user';
    protected $fillable = [
        'f_name',
        'l_email',
        'age',
        'u_desc',
        'u_img',
        'email',
        'username',
        'password',
        'p_id',
        'gender',
    ];
}
