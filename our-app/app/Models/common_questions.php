<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class common_questions extends Model
{
    use HasFactory;
    protected $table = 'common_questions';
    public $timestamps = false;
    protected $fillable = [
        'question',
        'answer',
    ];
}
