<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class services_type extends Model
{
    use HasFactory;
    protected $fillable = [
        'type',
        't_icon',
    ];
}
