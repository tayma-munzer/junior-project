<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class user_role extends Model
{
    use HasFactory;
    protected $table = 'user_roles';
    public $timestamps = false;
    protected $fillable = [
        'u_id',
        'r_id',
    ];
}
