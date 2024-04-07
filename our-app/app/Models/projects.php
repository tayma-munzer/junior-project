<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class projects extends Model
{
    use HasFactory;
    protected $fillable = [
        'cv_id',
        'p_name',
        'p_desc',
        'start_date',
        'end_date',
        'responsibilities',
    ];
}
