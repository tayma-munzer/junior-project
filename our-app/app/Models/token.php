<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class token extends Model
{
    use HasFactory;

    protected $table = 'personal_access_tokens';
    public $timestamps = false;
    
    
}
