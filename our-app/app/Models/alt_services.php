<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class alt_services extends Model
{
    use HasFactory;
    protected $fillable = [
        's_id',
        'a_name',
        'a_price',
        'added_duration',
    ];
}
