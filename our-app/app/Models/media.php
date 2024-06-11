<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class media extends Model
{
    use HasFactory;
    protected $table = 'media';
    public $timestamps = false;
    protected $fillable = [
        'c_id',
        'm_id',
        'm_name',
        'm_title',
        'm_desc',
    ];
}
