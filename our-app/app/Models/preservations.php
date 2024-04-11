<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class preservations extends Model
{
    use HasFactory;
    protected $table = 'preservations';
    public $timestamps = false;
    protected $fillable = [
        'p_name',
    ];
}
