<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class sec_type extends Model
{
    use HasFactory;

    protected $table = 'secondry_type';
    public $timestamps = false;
    protected $fillable = [
        't_id',
        'sec_type',
    ];
}
