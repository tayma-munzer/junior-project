<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Complaint extends Model
{
    use HasFactory;

    protected $fillable = [
        'description',
        'u_id',
        'complainable_id',
        'complainable_type'
    ];

    public function user(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'u_id', 'u_id');
    }

    public function complainable(): \Illuminate\Database\Eloquent\Relations\MorphTo
    {
        return $this->morphTo("complainable");
    }
}
