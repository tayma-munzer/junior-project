<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class rates_reviews extends Model
{
    use HasFactory;
    protected $table = 'rates_reviews';
    public $timestamps = false;
    protected $fillable = [
        'sc_id',
        'rate',
        'review',
    ];
}
