<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class job_application extends Model
{
    use HasFactory;
    protected $table = 'job_application';
    public $timestamps = false;
    protected $fillable = [
        'j_id',
        'u_id',
    ];
}
