<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class experience extends Model
{
    use HasFactory;
    protected $fillable = [
        'cv_id',
        'position',
        'company',
        'start_date',
        'end_date',
        'responsibilities',
    ];
}
