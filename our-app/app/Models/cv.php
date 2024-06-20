<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class cv extends Model
{
    use HasFactory;
    protected $table = 'cv';
    public $timestamps = false;
    protected $fillable = [
        'career_obj',
        'phone',
        'address',
        'email',
        'u_id',
    ];

    public function user(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'u_id');
    }

    public function cvLangs(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(cv_lang::class, 'cv_id');
    }

    public function education(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(education::class, 'cv_id');
    }

    public function experiences(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(experience::class, 'cv_id');
    }

    public function projects(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(projects::class, 'cv_id');
    }

    public function skills(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(skills::class, 'cv_id');
    }
}
