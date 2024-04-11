<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class job extends Model
{
    use HasFactory;
    protected $table = 'jobs';
    public $timestamps = false;
    protected $fillable = [
        'u_id',
        'j_name',
        'j_desc',
        'j_sal',
        'j_req',
    ];
}
