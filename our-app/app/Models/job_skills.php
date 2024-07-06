<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class job_skills extends Model
{
    use HasFactory;
    protected $table = 'job_skills';
    protected $primaryKey = 'js_id';
    public $timestamps = false;
    protected $fillable = [
        'j_id',
        'skill',
    ];
}
